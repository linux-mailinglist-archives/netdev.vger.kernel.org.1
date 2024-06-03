Return-Path: <netdev+bounces-100345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9BC8D8A7C
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4951C20F29
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 19:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BC8139D04;
	Mon,  3 Jun 2024 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hn1QX7rV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B13B15E88
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444213; cv=none; b=lKPWokZFEx4XHntVC864VTGCsVYL+jcaVrx1qv1tAGjJlEsuH83qay9TR7lHSuMCRFhA+QQQcB3LEnQYealGuI6qng1gRbfbM7WZgrQDllqs9c3IDknGux6v1Bql0yg02wQ5Ffxtuq0Wr3UwpiotdDPeBHLzVAa4WqECyJ7ljAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444213; c=relaxed/simple;
	bh=kEuoKO6OKML9TTlUr4lC5CbwDypU59X9w05HJeT1g1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYN0N6Bs3xn6PO2/VHW7OR57RRjZkyXiBd8AlnCWSrF574EEMiCfgb21Qfvh6IwfQAbBMkljqdcL07PJQtTDMgzyB/yREy3nV6JsCPESMGTZpQdCr2RGbZmg2/dQvl0Dvh9pwJhWeVswv5XHk1XogOcHcXF+u2LSDTmptWxLidc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hn1QX7rV; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso3737a12.0
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 12:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717444210; x=1718049010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c76Eb3fAJ5ydRtc9pdFUlI7ef5c9NLHaa+YI5jGd55U=;
        b=Hn1QX7rVtEVI+RDEZ7/bkjeyUwwqVTqdb7izHeOKMagh3ateLj5JNpoFXo33QZCzvP
         O0yEZrvRooF3peCxDuFHUYtzwsrB3HE970Q3GDkTTo25I1XMr2ysKjZ06LVUTkdmJ5Ns
         On9Cng9e0oh5W8vYtXcj5o944IO7YnJ+dX6dvhfdtCKW+1iRC073ynwg/I1IPZdSDh6T
         npBdUux33TLJL/f2Ffv8nztoU9orlr3G8h+Vf5RoLlBW4ushPc8rGS6CMOqNZvdbCKCr
         X6gx8l8Ac9pP9No5zC6FVCWw5tXQl+H7QQlNwB148lnrMT1kI011aofbsjhcfeaA8kbU
         AJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717444210; x=1718049010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c76Eb3fAJ5ydRtc9pdFUlI7ef5c9NLHaa+YI5jGd55U=;
        b=a6Ux5zhD9MpwV9IiYzZSyUaPzV9Gy/THymtuxqBZDH7P5xMHW+2jFzYDEQeL6CTicw
         Z5AKb4hh6/rTzVJ+OhotXWa9HrH8+6a59FQTl7oKXSVyejgz0y2ReBz76VRcPGpVM50O
         ONPqf+6qU6L6bA2GmhiSU4Ghx56WosvIZqK77H+K2O2kMqw7YnKw5jxUU4BVVEyz5sVV
         ME7H/HW6jxE5RGlklFSSD50C86UgYlsPiCGlvkGhj5zvFix0BxTuuy6Lk6ngzLMa8zym
         RagA1Szv6DQ/wUs6yUiGVvDoQvnzlUuRzd/65hHtg7R9iYCLFXQXpqFtbesX1yIEJ47O
         S0gw==
X-Forwarded-Encrypted: i=1; AJvYcCUzFkDQjvSnXN0pZA048ypoNF/7KuXL95cnhItxrXmgk9ykIqcNaeTvxhDg6isiVMePsf7aOD85DFP0MQ1AGeXWgh2omLFc
X-Gm-Message-State: AOJu0Yz1YgX0eiJZHiqOc+jKq9sqfSS6344OM3r/tgxc1SJph7H6gqf5
	c00jqYmKPy766SU1TFbYWkBIO6CDVZvPXvtfysaCThaQUlgaxuc2cdJcsDzmn3nPAYqISOTWjih
	QvVjOVUqzchVp1+5bc0OBF7fxWFJ8J2STqcbl
X-Google-Smtp-Source: AGHT+IHMszTUPsXRG174wM/IZeN1yVbzXIbSUl8ZlitnsNBBbIlt6IQc0oo5SGjyM3OHXiUFUxyEoh1/K4vIpERkoWg=
X-Received: by 2002:a05:6402:5d93:b0:57a:2a8f:2d86 with SMTP id
 4fb4d7f45d1cf-57a7d6e828cmr22075a12.2.1717444210182; Mon, 03 Jun 2024
 12:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603184826.1087245-1-kuba@kernel.org>
In-Reply-To: <20240603184826.1087245-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 3 Jun 2024 21:49:56 +0200
Message-ID: <CANn89iKA1eKUdCYLyejKN_wMK6ODFwW4t3SLZR6Zz_CSTLtVEw@mail.gmail.com>
Subject: Re: [PATCH net v3] rtnetlink: make the "split" NLM_DONE handling generic
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, dsahern@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 8:48=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Jaroslav reports Dell's OMSA Systems Management Data Engine
> expects NLM_DONE in a separate recvmsg(), both for rtnl_dump_ifinfo()
> and inet_dump_ifaddr(). We already added a similar fix previously in
> commit 460b0d33cf10 ("inet: bring NLM_DONE out to a separate recv() again=
")
>
> Instead of modifying all the dump handlers, and making them look
> different than modern for_each_netdev_dump()-based dump handlers -
> put the workaround in rtnetlink code. This will also help us move
> the custom rtnl-locking from af_netlink in the future (in net-next).
>
> Note that this change is not touching rtnl_dump_all(). rtnl_dump_all()
> is different kettle of fish and a potential problem. We now mix families
> in a single recvmsg(), but NLM_DONE is not coalesced.
>
> Tested:
>
>   ./cli.py --dbg-small-recv 4096 --spec netlink/specs/rt_addr.yaml \
>            --dump getaddr --json '{"ifa-family": 2}'
>
>   ./cli.py --dbg-small-recv 4096 --spec netlink/specs/rt_route.yaml \
>            --dump getroute --json '{"rtm-family": 2}'
>
>   ./cli.py --dbg-small-recv 4096 --spec netlink/specs/rt_link.yaml \
>            --dump getlink
>
> Fixes: 3e41af90767d ("rtnetlink: use xarray iterator to implement rtnl_du=
mp_ifinfo()")
> Fixes: cdb2f80f1c10 ("inet: use xa_array iterator to implement inet_dump_=
ifaddr()")
> Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
> Link: https://lore.kernel.org/all/CAK8fFZ7MKoFSEzMBDAOjoUt+vTZRRQgLDNXEOf=
dCCXSoXXKE0g@mail.gmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Very nice, thanks a lot for taking care of this Jakub.

Reviewed-by: Eric Dumazet <edumazet@google.com>

