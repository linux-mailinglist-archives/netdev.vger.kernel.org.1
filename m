Return-Path: <netdev+bounces-72196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E43856EA2
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 21:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A035282514
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 20:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3631913AA41;
	Thu, 15 Feb 2024 20:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lSgD07zm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6E618E01
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708029304; cv=none; b=Gek5ml09pyxAttFGBBFtzhRqbSP96fpTvNCfr/Sdn7vh0DZAM/xFZrB3b9K4yI7ZXQ1ZZh89KhntlLfuiANKtCFj6ZT7D97dDNr5xASixcEWZxV/1o+OmgGBuw5Yxkoo1axtdo4Iniw7uHqiDTQQv10eyzY//6B28U3olfC7JVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708029304; c=relaxed/simple;
	bh=h3PYUBQe3yCtRxrjIQDEU1Mw8km0CzUKEmbLDcQ7Cag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GqaahNU9JJGobrdyIQmZkR8ajpNHBpDqwTuG++0j+LONOlwbPMyJN6h+wOEGn9ndT9Oa8N/nDH5F56wXufDWxMLDIOiToSIHPs7oWGX9EWt4L+VbPGBNH/nFQGOsDqlkWejR90quneN1TfiqCnrGcAXS+6YVKxz09HG+sYkbeKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lSgD07zm; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-563dfa4ccdcso3572a12.1
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 12:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708029300; x=1708634100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7an4kvg31W2wSTkLx7ZBTIK5HZwT7PN0lj9ZiIjsxxM=;
        b=lSgD07zmswupjf4puHHqQA6Tb+NnLRJwq716PuyLm5uzhgKWkK6Nygbc+QBwMz7CsG
         k47hrrqRbNhnTTbuwewCJ0QH7KL0nk70/qOjnAqZyH+KanH7rb2gy0DIOBNl2mFsS56A
         Pi5HOi6i1GBbRNtwwgABResLi/muoPP6WwMv8q1SUovllA9v+YbINj4P5/Mg/NXX6J1o
         LtIGqpJKgNaWsDAfzCLRDn1xavn5VV+IimbRLXglGYP9afuBxDrj47ASNdSO+ZKuMVq+
         EQZdcGPj+2cTuo8zFL+lmJ0RxLZaIkONdVz7Wdl11FmR1IcBZPKqt7Mg7nsJV2n7+OFD
         nnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708029300; x=1708634100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7an4kvg31W2wSTkLx7ZBTIK5HZwT7PN0lj9ZiIjsxxM=;
        b=hvHTbOdi2SxuWFmPV10bJEBHqofsLUfsAgsqODYb4i1Y4b8BAuneDfFyLNisEB8kJI
         yMREwfzX9K4HxoIuAnwer+HQmHcKi8/Sa+mUdtzXs9JIK+zPY5fcDpy0avCeRe4pbKts
         7u6Jk3yFCe+2Abkq5fPuRafYGfmHuB6APHPZuIRLwQsQzRwJwXWdxTA8rrPePvRewfdD
         CVFlzEuFInyE+hTmP1yXMn5bAYuNs6Fr2JI0u5M2rabsCb4fs2VCziQgWiM8mX2cYG/f
         bUc/h7uAoapWk3G5Yl6qY6gT3n8y/5K3dnTLQJka+AOrMXSVBCcOBhVkZqIGnrlTns7M
         Hc0g==
X-Gm-Message-State: AOJu0Yy40RXqto97EDR//y2/de0AihKB7kdzuu7uDgWzYwxG8zo1I1om
	bwk9bnsazKfLkw0bZzs4ZeYxx5WGtsmFp1CW25h6X06RljK1d9+5mdQgoqLveNNZVQM0EJLixhz
	ksOvCZzYjDHXvFGVSD7iCqyl0wBOE8T49XFgd
X-Google-Smtp-Source: AGHT+IE1FNvWdJuD8MBnl+NvqqcGD5WY0JV3xoxcn/Lt3BGv7ra2iU5eZvjtja3V+ZweGzhA+O390CJ1hJa0g+zZHnU=
X-Received: by 2002:a50:d607:0:b0:563:adf3:f5f4 with SMTP id
 x7-20020a50d607000000b00563adf3f5f4mr43235edi.1.1708029300357; Thu, 15 Feb
 2024 12:35:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215202949.29879-1-kovalev@altlinux.org>
In-Reply-To: <20240215202949.29879-1-kovalev@altlinux.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 15 Feb 2024 21:34:49 +0100
Message-ID: <CANn89i+TNVtk8UT1+2QeeKHR-b6AQoopdxpcqcbNVOp9+JYSYw@mail.gmail.com>
Subject: Re: [PATCH] tcp_metrics: fix possible memory leak in tcp_metrics_init()
To: kovalev@altlinux.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, ebiederm@xmission.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 9:29=E2=80=AFPM <kovalev@altlinux.org> wrote:
>
> From: Vasiliy Kovalev <kovalev@altlinux.org>
>
> Fixes: 6493517eaea9 ("tcp_metrics: panic when tcp_metrics_init fails.")
> Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
> ---
>  net/ipv4/tcp_metrics.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
> index c2a925538542b5..517c7f801dc220 100644
> --- a/net/ipv4/tcp_metrics.c
> +++ b/net/ipv4/tcp_metrics.c
> @@ -1048,6 +1048,8 @@ void __init tcp_metrics_init(void)
>                 panic("Could not register tcp_net_metrics_ops\n");
>
>         ret =3D genl_register_family(&tcp_metrics_nl_family);
> -       if (ret < 0)
> +       if (ret < 0) {
>                 panic("Could not register tcp_metrics generic netlink\n")=
;
> +               unregister_pernet_subsys(&tcp_net_metrics_ops);
> +       }
>  }

Well, the whole point of panic() is to crash the host.

We do not expect to recover.

