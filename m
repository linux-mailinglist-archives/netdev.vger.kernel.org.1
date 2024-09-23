Return-Path: <netdev+bounces-129335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A882D97EE7D
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 17:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA70A1C2171B
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 15:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A68719E964;
	Mon, 23 Sep 2024 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9Z8qmCo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC3F2747D
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106514; cv=none; b=uvda6m5YUt3MuZHf+EDXXSgvu9gB8RyBCChv1TuPNPGu6AEim6PaPO6zy/5W6ZYLD1KbpKicieuia+1PCVKUJnBmH1RgiXfU5C8QzuXBnQ74LT3NhNaIiC2xdP5mOgwrPKmoWvjIRMG/2lKMgcShpzVH+REIAnqA8qkf9wJv6bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106514; c=relaxed/simple;
	bh=3LMiQYXHG2y4rQ2ij2Lqf3f9TLEGCTIiAjOk7FEbimk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TM8bE07nP50SENtz1dhayb7gGwaeOFxzkR+Ttq55XUxD7iwLlrFVEKEknBgrTwAlxOweHZJ9g0CkF0Ofl7cXhVen24v/xFG19Bvqe9zQvXSQa49g2zYHLtl7N9kIkRqPQuS1wZvq5jO8coio59x0G4tfNK+lhPloPEUUAKBXpsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9Z8qmCo; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e1d2cf4cbf1so3977466276.1
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 08:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727106512; x=1727711312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIX4iVlpQZFvHkAohyiKA5M1NKSDU8Zm5tZn/ijOLzs=;
        b=I9Z8qmCoFolt0nMavOwFckhsEMWudWsxZOzeDY1Zz2SeGzQEKA0fyayMHfH2IDrGtR
         tFbIa2W+oVvEZV69ShO3eBmMZXpX+g/M6qYa4Rs81q07iWrM0sQ/UDv+u/lkll+pGYVw
         p3jGw2k0H0SgSdyJ/5f3qgtXfrBs4WEHwWNSrZc7jvJObf9yPDcSAAGWI9qUei4ULXrJ
         7r4Z22q8/1dhoex5iASF8IS9OGmLF1jWl1HdIm7r6slxA6dPfude5GoQQVYiALwOZVNd
         NhsQI3aBbQIuneReJ9Yz2wrfNYnOfUXC26VnHpaHRWxnMF2bAEFnaTiH0wknGRJ4ytCo
         D5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727106512; x=1727711312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIX4iVlpQZFvHkAohyiKA5M1NKSDU8Zm5tZn/ijOLzs=;
        b=JcG/7wtg6q3uIW3U+HP1ELIxoQu4vb0ej9mV4o7Yc9Tvq6svaNWeRn6RMlQZKRqCAM
         YsIWmgrZrxYhDLg+MyYy+I/YF28JpiFl6JF5WILxQD7DRRoCBkUrzfoIi7AV6zzKmxe/
         4qFMi7d+tcs8dF94E2MnqcjbjlkRdUJ2l/t2g/CQNp9/BPPmpMPltOAv2AQy/0PDVZzT
         5BW8JpN0+21DCxCv3yLL/2WlptGDMTBxKKur8NFE7RcngpOwLI3gPcR23wGLQb5kV9NT
         LJfXC8xXvMqx7MJxofzSuoPMXlFAJNxnFd+CnSgY4mCI4drIyDjZX58HmotEz1oNc6Iu
         gLkQ==
X-Gm-Message-State: AOJu0Yz7UpJrTRIN+Onoisyae1CF0tL3d0R6YxtzVXD9BlkRAbMOk5fV
	wjWcN6cPIkZx/E3AiNa7Qn0WZRBdjKeryTUzlCg5NDjgEYBocEQI97A467PjmBXNpz1ckZJrWEg
	sUI2Bz+wKZCPu9P5ZPy6+ITfqRpWSqUg0tkoAyZSZ
X-Google-Smtp-Source: AGHT+IF6xtj25QTYUZmiJ7vdfvPZ2umsxzmGnETfqRImEFLCWacUgL9ZPJ8PgGZ8Mh+bv4mnU7uTDKuDq8bMAFv2/TQ=
X-Received: by 2002:a05:690c:64c6:b0:6db:d6b5:3bb with SMTP id
 00721157ae682-6dff2b2dff4mr93958337b3.43.1727106511679; Mon, 23 Sep 2024
 08:48:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912000446.1025844-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20240912000446.1025844-1-xiyou.wangcong@gmail.com>
From: ericnetdev dumazet <erdnetdev@gmail.com>
Date: Mon, 23 Sep 2024 17:48:20 +0200
Message-ID: <CAHTyZGzk-WUPm9v_kXoQfs6Vsk8ZG=gwTD+Q190012YFHV5X4w@mail.gmail.com>
Subject: Re: [Patch net] smc: use RCU version of lower netdev searching
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>, 
	syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 12 sept. 2024 =C3=A0 02:05, Cong Wang <xiyou.wangcong@gmail.com> a =
=C3=A9crit :
>
> From: Cong Wang <cong.wang@bytedance.com>
>
> Both netdev_walk_all_lower_dev() and netdev_lower_get_next() have a
> RCU version, which are netdev_walk_all_lower_dev_rcu() and
> netdev_next_lower_dev_rcu(). Switching to the RCU version would
> eliminate the need for RTL lock, thus could amend the deadlock
> complaints from syzbot. And it could also potentially speed up its
> callers like smc_connect().
>
> Reported-by: syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc75d1de73d3b8b76272f
> Cc: Wenjia Zhang <wenjia@linux.ibm.com>
> Cc: Jan Karcher <jaka@linux.ibm.com>
> Cc: "D. Wythe" <alibuda@linux.alibaba.com>
> Cc: Tony Lu <tonylu@linux.alibaba.com>
> Cc: Wen Gu <guwen@linux.alibaba.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---
>  net/smc/smc_core.c |  6 +++---
>  net/smc/smc_pnet.c | 14 +++++++-------
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index 3b95828d9976..574039b7d456 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -1850,9 +1850,9 @@ int smc_vlan_by_tcpsk(struct socket *clcsock, struc=
t smc_init_info *ini)
>         }
>
>         priv.data =3D (void *)&ini->vlan_id;
> -       rtnl_lock();
> -       netdev_walk_all_lower_dev(ndev, smc_vlan_by_tcpsk_walk, &priv);
> -       rtnl_unlock();
> +       rcu_read_lock();
> +       netdev_walk_all_lower_dev_rcu(ndev, smc_vlan_by_tcpsk_walk, &priv=
);

It seems smc_vlan_by_tcpsk_walk() depends on RTNL.

We should at least add a READ_ONCE() in is_vlan_dev() :

return READ_ONCE(dev->priv_flags) & IFF_802_1Q_VLAN;


> +       rcu_read_unlock();
>
>  out_rel:
>

