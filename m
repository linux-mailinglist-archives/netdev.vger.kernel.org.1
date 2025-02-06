Return-Path: <netdev+bounces-163584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16773A2AD35
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 17:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE833A9971
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 16:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B25F1624CF;
	Thu,  6 Feb 2025 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cx2gjWaN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E21F419B
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738857683; cv=none; b=Lb7/hLLIzP7wrdl9h137MHgVdCeldYQ9xZoAoWvQuMR1ee2HBs4TYxBXztzoWxuredm3bG9xv0d5QN+dLmmHvn1dTh7CMTR6aUdol+4wqcxqGVcgcWntbG8Kwvtl7MInjj0MHpv6OtU+3+9EOi3NL/NOMtORVioW7nEQLBi+MiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738857683; c=relaxed/simple;
	bh=cjrvqKwflKGDwidBjxOl4fQeR+OSK3UfDfYbifKFa8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmjkaeNHMgSM9tvgnyGbTBBXAares8Y/B1ktfgp/GUBRHmtRO0+qoQlq9BRfvFZw/SLRq4qggssHgdgOup0ACE0Yf4moCtUog5LMAFEezLbH/zFuMeS8dnqP/OgpmsRP6lzCYOlQbKitcf7C530NnPA83/q6EXXUdze0b6Yo+5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cx2gjWaN; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46785b66168so161cf.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 08:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738857681; x=1739462481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjrvqKwflKGDwidBjxOl4fQeR+OSK3UfDfYbifKFa8M=;
        b=cx2gjWaNrtShGDM8ubQzym32fXxhQC/dSeX3Xgcbvp8w9sWnR7mP6fkaT3BoPGEPmp
         /Cxr2F31U78RoM3oYsdFOKYvksfVv5AIicoiRgdKagzVGbf8r1a/0GqorTV4Q2r/ytrt
         u6IL/GHsXUeZ55B2dEPTpb48hmbCfWwy3keIlucoT8UH/jB2gVNVF3BrmEaLq5gvY6kP
         PNO3pBqYp8F2RO2ZKgRx+eWu5niLAnz5seKjGvkcfMw1/THx1gJzdbmNZT7bpQsIgoaF
         NmLvnkrNajPdIGbZtBQD47YhF7kBCcMXMP3YBvbLAx4jeXHqCxnF9LadfBz925SkleIo
         03Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738857681; x=1739462481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjrvqKwflKGDwidBjxOl4fQeR+OSK3UfDfYbifKFa8M=;
        b=rwZ8DHIWbFD/q8T2gpLhfmsw5ia6i8msEqKRRZ4+G2j20AhPC1TYuP1Z777h9bSZGE
         j0xAqw2nZH16lOVVS+Hp5N8TTAwAJ8UY+oLZFHIAK+wIBzAGIIHdJ+0vkHwm6Q0LUqbq
         O0DB5UVMgJFIYviRDEL1ma4zZ8hJQPmcpzc0KK3t31n61el0MIOzCzqZUCBGoSJDOmkM
         ilkd5ZRRdnbLsRLI1WQIiCoXAwnMj/ejdktOnyELchEG6UkzQDJyQiRMfLZK+O/+DNJX
         L/v0wCUFglqHWBNsaqXoQBxqx5L6ZamBD1Usb5l4eoBQrjnJq3Ohc+/yeRP39lfTN/UX
         gPvg==
X-Forwarded-Encrypted: i=1; AJvYcCXp0ODOG9HJyRu0bQ4P/10+X1Odm2ZE4VWSAs8D9ESJsvAH4aomhm+PDusocYlmAnvEwtWJCAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNqg2PjAqSZwlez7F9SPF3JgaF+KtDxlTF7Si06PYjOn5u+NEq
	+4ICFX/uz1ULd2idboWjwqYdVfBmGDQ5Q7Q4T5xPQhV19dxykFbR8YjWFVACkoSebpQanZoZQOe
	3dDWg4BPraVOJCsieUPi6NnFsO9zT5UhqQwvL
X-Gm-Gg: ASbGncuJH+GFXY8A09ZEASPDToofaDy7eJ/rpD2TOZhRMnejtyVkJOVIjFuBAWwVN6p
	buwQg8e+51G/jJwleH6fScShdXKc0CzDgnzWeGAN1nAdtQ09T15jFXKU7CAFEpT+0b8A=
X-Google-Smtp-Source: AGHT+IHjB+F8/fZHMMhgSaAE47vlW3DeQZTVy9zE6ENZIrdv7ci+SVjgVYdT6IJkDJ7qIU2CbsI9uq24EaoX1d8IAqE=
X-Received: by 2002:a05:622a:6119:b0:46e:bdd:64a3 with SMTP id
 d75a77b69052e-47165943ec9mr108971cf.0.1738857677787; Thu, 06 Feb 2025
 08:01:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204091918.2652604-1-yuyanghuang@google.com> <efd3dee8-5a2d-4928-ba1d-ddccb2f29fbe@redhat.com>
In-Reply-To: <efd3dee8-5a2d-4928-ba1d-ddccb2f29fbe@redhat.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Fri, 7 Feb 2025 01:00:40 +0900
X-Gm-Features: AWEUYZlBPEi6CskLDdUiEXDiby9O2raxQzVoLylqLV5g0ljIatLjaaRQmQ_o_mk
Message-ID: <CADXeF1H32H=SsMUM7DgA=v9utzhnWfpPhKu5wouriOkTCtVUnw@mail.gmail.com>
Subject: Re: [PATCH net-next, v7 1/2] netlink: support dumping IPv4 multicast addresses
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Hangbin Liu <liuhangbin@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	linux-kselftest@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>I did not undertand you intended to place the new header under the
>'include' directory. I still have a preference for a really private
>header that would under 'net/ipv4/' (IMHO the possible future divergence
>of inet_fill_args and inet6_fill_args is not very relevant) but it's not
>a deal breaker.

Thanks for the advice, I will move the header file under 'net/ipv4' in
the next version of this patch.

Thanks,

Yuyang

On Thu, Feb 6, 2025 at 11:29=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 2/4/25 10:19 AM, Yuyang Huang wrote:
> > diff --git a/include/linux/igmp_internal.h b/include/linux/igmp_interna=
l.h
> > new file mode 100644
> > index 000000000000..0a1bcc8ec8e1
> > --- /dev/null
> > +++ b/include/linux/igmp_internal.h
>
> I did not undertand you intended to place the new header under the
> 'include' directory. I still have a preference for a really private
> header that would under 'net/ipv4/' (IMHO the possible future divergence
> of inet_fill_args and inet6_fill_args is not very relevant) but it's not
> a deal breaker.
>
> /P
>

