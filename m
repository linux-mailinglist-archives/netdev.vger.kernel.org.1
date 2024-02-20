Return-Path: <netdev+bounces-73118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7A485B03C
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 02:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E941F225F8
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 01:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B622107B3;
	Tue, 20 Feb 2024 01:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYFnSlji"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581DDDDB6
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 01:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708391253; cv=none; b=lZc+uTvMHJ11ZiAT7fHzon/mvkWtZcO4YtqpohL7S4X+Am9CnGqWqYCmohhhv2H0PSvWmOMp3REcYD0eaGBccI18i5eafbg6CF8WE9DoGPCE5aRJb4ZJb6VmZnUXBPbEXqcuTjKFJ1SXvFnrnn332wVrhuSf4us4vlB/D3hIt8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708391253; c=relaxed/simple;
	bh=W7mIHh5rHh4vdMHkIbDHj/R9F9JPJqAdn6+RySJC+54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MagTybFa+8EWsMgEI7buhYXfMXLCQg/NKZGO1R1WI7Z56VeAL8ZldyxPbnZ3OWUSPgg66mocZHcHyuR5drdrL/QplwNRvyiv56XXdI8m0aZyq1xabtF1MeV4lIkKfOw4W782DNObJsPPZYkFAzqazlSfD+K11u88VKC8W/Uz9kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VYFnSlji; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708391250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bN+xRkF6So+ejO9INBzpCuxH/ICgnLXLsxP9bDXIKL0=;
	b=VYFnSljiJ4OdQyTzwg/wyeRH8f8/9kmxN7f0KzEbVNM+HVkrWYkQ2+9foeW6NV/v/g3TD4
	WNJEOwWCqAbRtxkhCiwF8sgLdsD/RYd9ftVV/kI4tZy1I0QmXrigWrgKt0irJ0C4KIwY08
	X9C2WrECu8WjgPQY4zRu9iInhdoYEqU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-VuvXYt_OO_GH_aIaqFwQfQ-1; Mon, 19 Feb 2024 20:07:27 -0500
X-MC-Unique: VuvXYt_OO_GH_aIaqFwQfQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d22e40a544so14498171fa.0
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708391246; x=1708996046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bN+xRkF6So+ejO9INBzpCuxH/ICgnLXLsxP9bDXIKL0=;
        b=FBVoY06y0x2nBPZp8WJDVgy5dxEcMloh+X3AZxbefL8EJMjneHRlz3hqGczU7E8+p7
         xNYg41hPd2FPrJbzH+KRLEQBfR/3n2CtjeEhoQndRpP8degYPSP+VJeARgzOMZx65rQP
         /YBdJlqLG/Li6zLczyIk01RsdM9iJwxLXcFMIB/KS5IINrw/t8aphbLZMZEJ/J5DsWcm
         bbVZTVg4I9LbloPbMJybPvcISX2+nwa4KZyrZV8EDyfFwCfTxAwsTuLHD1R7XOiag2ak
         LyWF4hQzGHb9Kd7jMh2yiJLyQPeJr1MXG5+gYlJ9JceYkjpI25ck3gAtDu4/RrK9MBlv
         HzCA==
X-Forwarded-Encrypted: i=1; AJvYcCVdR7d/00pB6A7wjiO5dIgSKnmv5LWme7xCHSWlkIyloMEMORJqd/OcxZq2+n78x6gepdxB5MIM7fUv9G/uzv4FRTA5iotR
X-Gm-Message-State: AOJu0YzKFn5D1mdhDXwVee/x7VwKIGpiz01DOux30ci9LBHJN9A7U8KU
	kBwZC4Yv4M+U1WrKfGZV4ZwvCo+WJxT0+eKg33IZl0a5+cQ2KhqssRhbAH0qWCbTWC6nxhjFSfO
	Wr6S29UfXnh/MkWSS6252K/GjR6GlXxvkwjYZDN0GP/pSsmAudt7BXgCv94e7AyJ69nVBkUdRVP
	YXeslIpIdH+SnyJDdcPQMHm+8sEMGL
X-Received: by 2002:a2e:3e1a:0:b0:2d2:39a5:d190 with SMTP id l26-20020a2e3e1a000000b002d239a5d190mr3791526lja.1.1708391246133;
        Mon, 19 Feb 2024 17:07:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1kIyPveHUOVWMZmCgVFi1xnalj/6PCfA0yBeOAHEpQlJnohIRvG+RGA4f3rHPjY22pVoOoBYS1nqilt7dOXQ=
X-Received: by 2002:a2e:3e1a:0:b0:2d2:39a5:d190 with SMTP id
 l26-20020a2e3e1a000000b002d239a5d190mr3791512lja.1.1708391245809; Mon, 19 Feb
 2024 17:07:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213152414.3703-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20240213152414.3703-1-n.zhandarovich@fintech.ru>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 19 Feb 2024 20:07:14 -0500
Message-ID: <CAK-6q+j52utmO8K_h=3LqDYmXqsqFC6MKRPUM+q=1Q30c7nEMg@mail.gmail.com>
Subject: Re: [PATCH wpan] mac802154: fix uninit-value issue in ieee802154_header_create()
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot+60a66d44892b66b56545@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 13, 2024 at 10:24=E2=80=AFAM Nikita Zhandarovich
<n.zhandarovich@fintech.ru> wrote:
>
> Syzkaller with KMSAN reported [1] a problem with uninitialized value
> access in ieee802154_header_create().
>
> The issue arises from a weird combination of cb->secen =3D=3D 1 and
> cb->secen_override =3D=3D 0, while other required security parameters
> are not found enabled in mac802154_set_header_security().
>

In case of cb->secen is 1 and cb->secen_override is 0
mac802154_set_header_security() should depend on the
ieee802154_llsec_params params.

As [0] WPAN_SECURITY_DEFAULT signals this behaviour.

> Ideally such case is expected to be caught by starting check at the
> beginning of mac802154_set_header_security():
>
>         if (!params.enabled && cb->secen_override && cb->secen)
>                 return -EINVAL;
>
> However, since secen_override is zero, the function in question
> passes this check and returns with success early, without having
> set values to ieee802154_sechdr fields such as key_id_mode. This in
> turn leads to uninitialized access of such values in
> ieee802154_hdr_push_sechdr() and other places.
>
> Fix this problem by only checking for secen value and presence of
> security parameters (and ignoring secen_override). Exit early with
> error if necessary requirements are not met.
>
> [1]
> BUG: KMSAN: uninit-value in ieee802154_hdr_push_sechdr net/ieee802154/hea=
der_ops.c:54 [inline]
> BUG: KMSAN: uninit-value in ieee802154_hdr_push+0x971/0xb90 net/ieee80215=
4/header_ops.c:108
>  ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:54 [inline]
>  ieee802154_hdr_push+0x971/0xb90 net/ieee802154/header_ops.c:108
>  ieee802154_header_create+0x9c0/0xc00 net/mac802154/iface.c:396
>  wpan_dev_hard_header include/net/cfg802154.h:494 [inline]
>  dgram_sendmsg+0xd1d/0x1500 net/ieee802154/socket.c:677
>  ieee802154_sock_sendmsg+0x91/0xc0 net/ieee802154/socket.c:96
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
>  __sys_sendmsg net/socket.c:2667 [inline]
>  __do_sys_sendmsg net/socket.c:2676 [inline]
>  __se_sys_sendmsg net/socket.c:2674 [inline]
>  __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> Local variable hdr created at:
>  ieee802154_header_create+0x4e/0xc00 net/mac802154/iface.c:360
>  wpan_dev_hard_header include/net/cfg802154.h:494 [inline]
>  dgram_sendmsg+0xd1d/0x1500 net/ieee802154/socket.c:677
>
> Fixes: f30be4d53cad ("mac802154: integrate llsec with wpan devices")
> Reported-and-tested-by: syzbot+60a66d44892b66b56545@syzkaller.appspotmail=
.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D60a66d44892b66b56545
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
> P.S. Link to previous similar discussion:
> https://lore.kernel.org/all/tencent_1C04CA8D66ADC45608D89687B4020B2A8706@=
qq.com/
> P.P.S. This issue may affect stable versions, at least up to 6.1.
>
>  net/mac802154/iface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> index c0e2da5072be..ad799d349625 100644
> --- a/net/mac802154/iface.c
> +++ b/net/mac802154/iface.c
> @@ -328,7 +328,7 @@ static int mac802154_set_header_security(struct ieee8=
02154_sub_if_data *sdata,
>
>         mac802154_llsec_get_params(&sdata->sec, &params);
>
> -       if (!params.enabled && cb->secen_override && cb->secen)
> +       if (!params.enabled && cb->secen)
>                 return -EINVAL;
>         if (!params.enabled ||
>             (cb->secen_override && !cb->secen) ||
>

I think there is just a missing check if (!cb->secen_override) then
use whatever mac802154_llsec_get_params() says and ignore
secen_enabled.

Also I think that we don't init those socket parameters to any value
at [1] so it's completely random what values are at socket creation.

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/net/ieee802154/socket.c?h=3Dv6.8-rc5#n911
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/net/ieee802154/socket.c?h=3Dv6.8-rc5#n474


