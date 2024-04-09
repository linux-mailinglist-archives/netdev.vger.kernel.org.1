Return-Path: <netdev+bounces-86263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA47689E486
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 22:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D3D7B20EA5
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 20:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E355158843;
	Tue,  9 Apr 2024 20:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="lCdo/Oj0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151271586F5
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695047; cv=none; b=sr47ydiP0fc2ueBMqs4MtJ6cx0QOfKn0GJcevZEcqrjq7Tn0fsQEBNY88iwE2PFFFqoq5avbOPsTY2y8fl1DkLzhpwGbzHo6ve9ONfgTeFHOhnlOPttCh3JzqQydM+RAYDnvuwssLEgMQO6vDTjaPRV5Ws4JF2ggiyhjflPPk18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695047; c=relaxed/simple;
	bh=u+15pDAEB5MWpkKMtaMFy1jXkl9kXCc5ri80aqBTrRE=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=rp8CQgC1itA/uBVWa9QD5EWvsAn7RcQKh0wIGdO4x7IbsKXqDtf01XsW4IiWH59NVg89mThJYHUB0KdS9sPmgkKZSS0VPKvKtIuGfboGc/dlWRlF9ul8fbsElzMbXlLAqEp3uc6+5aHsLI5KluN8yl6nTDwHWrD6yp21Ox0kpFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=lCdo/Oj0; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 492344015F
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 20:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712695037;
	bh=P0XQvMLUzmnDQra44JK7FmoD/lzc63xwynY1liutI8s=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=lCdo/Oj0XLISk5jyY8ujD5eyBq/qUtA0sgzrIZeMZKXltna33CrWH2TWFRcP7PZ0f
	 CaC7gJkrOTWlHCOHI5yqV569JtcWaI4Yyit5XgW03CQ/Z2/5lVnZDXIpBQ3E7hD5hn
	 t7pSipURoVqjoQ6R13KOIkM/gWuC/LRV/ML9P/Xc5vyS5Rr+WQQswENWrdGtXCXui3
	 pDyhTQyF8+A14AcT4dHx36w79fL+0AJqRY8T+tsSaPItFQT6pSKcwBdYccKLD3mvOr
	 0/0EP6ZHRvoMXNpnxuB6FAtHey0Kq6lW3Er1F7/3IVRiSf4pQCbfir0cS/yS1Nbkvq
	 vndFcgmb25rww==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e2a45b303bso44546785ad.2
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 13:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712695036; x=1713299836;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0XQvMLUzmnDQra44JK7FmoD/lzc63xwynY1liutI8s=;
        b=q9RqVuwHFa4wqCmSxI4vANAHz3rofBA4JL3gW1tkcy8pq9NMbdD1fgZPIsNTHHtC+R
         32WqaTQSr3OObhUFNeh/bCVKtnGgs5vSRH5CZO7wsAuBsZYIS37aTq3Sc8TT0j+Dusqq
         5y58Yuq0C1KoL/b8dmkivGIFyQXo0d9pslwnsNgingQpZK39W0kS1u5HD9/23ttSsYS9
         72hiinqspKc/jiqLkW02n+G1k/33K8m9ZOTv8cB6J/+dDhG74MbOngHlDfiOtLsbTToX
         ivrLc+K5bu87i3l5n8oQZurEJ+ZfH1anVbUvpfjRVWnmvh0qcBfjtxtmEXv3Q/EixpE4
         3onQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRqwPnpJsvtqoXJ7FjVqVB+u1TbQRR/VpLeppSdS+w3gAbH0qzndmsSgL9kXThEnlcnk0gUfvPJh3OWEsHnAebLZRZZ7Ip
X-Gm-Message-State: AOJu0YzLKmt8Ae2QJwnem4N5pgb0LmpLITkqK3Q/0iCFSjvHy0l75aht
	juaanUgkXZdk33r+Vfp0WnZMwfq+hUT28H5OV+NPZsuiLUumhfZHKzQRcA8ZAEPDCQSKY4o041G
	om69ODV5hQUUFM0KiuW2H5ROdwqfPrCUPYsFtKp6KbCfWES5HuCO63R2wtRs7uaqrt/Y2nQ==
X-Received: by 2002:a17:902:7008:b0:1e4:3ad5:b6d6 with SMTP id y8-20020a170902700800b001e43ad5b6d6mr866882plk.37.1712695035513;
        Tue, 09 Apr 2024 13:37:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4rMJfsliIXa7yeMLKIgmE0KWh5I3b1errVH+NNR14V+zMZwiaueRuL9k3Sxn0/esx09gzNQ==
X-Received: by 2002:a17:902:7008:b0:1e4:3ad5:b6d6 with SMTP id y8-20020a170902700800b001e43ad5b6d6mr866864plk.37.1712695034984;
        Tue, 09 Apr 2024 13:37:14 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b001e42bb057b9sm4481138pli.105.2024.04.09.13.37.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:37:14 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 31CF1604B6; Tue,  9 Apr 2024 13:37:14 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 2AA459FA74;
	Tue,  9 Apr 2024 13:37:14 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Eric Dumazet <edumazet@google.com>
cc: "David S . Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org,
    eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 1/3] bonding: no longer use RTNL in bonding_show_bonds()
In-reply-to: <20240408190437.2214473-2-edumazet@google.com>
References: <20240408190437.2214473-1-edumazet@google.com> <20240408190437.2214473-2-edumazet@google.com>
Comments: In-reply-to Eric Dumazet <edumazet@google.com>
   message dated "Mon, 08 Apr 2024 19:04:35 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17331.1712695034.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Apr 2024 13:37:14 -0700
Message-ID: <17332.1712695034@famine>

Eric Dumazet <edumazet@google.com> wrote:

>netdev structures are already RCU protected.
>
>Change bond_init() and bond_uninit() to use RCU
>enabled list_add_tail_rcu() and list_del_rcu().
>
>Then bonding_show_bonds() can use rcu_read_lock()
>while iterating through bn->dev_list.
>
>Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>


>---
> drivers/net/bonding/bond_main.c  | 4 ++--
> drivers/net/bonding/bond_sysfs.c | 8 ++++----
> 2 files changed, 6 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index c9f0415f780ab0a9ecb26424795695eff951421a..08e9bdbf450afdc1039312492=
59c58a08665dc02 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -5933,7 +5933,7 @@ static void bond_uninit(struct net_device *bond_dev=
)
> =

> 	bond_set_slave_arr(bond, NULL, NULL);
> =

>-	list_del(&bond->bond_list);
>+	list_del_rcu(&bond->bond_list);
> =

> 	bond_debug_unregister(bond);
> }
>@@ -6347,7 +6347,7 @@ static int bond_init(struct net_device *bond_dev)
> 	spin_lock_init(&bond->stats_lock);
> 	netdev_lockdep_set_classes(bond_dev);
> =

>-	list_add_tail(&bond->bond_list, &bn->dev_list);
>+	list_add_tail_rcu(&bond->bond_list, &bn->dev_list);
> =

> 	bond_prepare_sysfs_group(bond);
> =

>diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_=
sysfs.c
>index 2805135a7205ba444ccaf412df33f621f55a729a..9132033f85fb0e33093e97c55=
f885a997c95cb4a 100644
>--- a/drivers/net/bonding/bond_sysfs.c
>+++ b/drivers/net/bonding/bond_sysfs.c
>@@ -37,12 +37,12 @@ static ssize_t bonding_show_bonds(const struct class =
*cls,
> {
> 	const struct bond_net *bn =3D
> 		container_of_const(attr, struct bond_net, class_attr_bonding_masters);
>-	int res =3D 0;
> 	struct bonding *bond;
>+	int res =3D 0;
> =

>-	rtnl_lock();
>+	rcu_read_lock();
> =

>-	list_for_each_entry(bond, &bn->dev_list, bond_list) {
>+	list_for_each_entry_rcu(bond, &bn->dev_list, bond_list) {
> 		if (res > (PAGE_SIZE - IFNAMSIZ)) {
> 			/* not enough space for another interface name */
> 			if ((PAGE_SIZE - res) > 10)
>@@ -55,7 +55,7 @@ static ssize_t bonding_show_bonds(const struct class *c=
ls,
> 	if (res)
> 		buf[res-1] =3D '\n'; /* eat the leftover space */
> =

>-	rtnl_unlock();
>+	rcu_read_unlock();
> 	return res;
> }
> =

>-- =

>2.44.0.478.gd926399ef9-goog
>
>

