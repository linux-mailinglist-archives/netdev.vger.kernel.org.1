Return-Path: <netdev+bounces-86265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECAF89E48E
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 22:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2DC6B20EB9
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 20:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBAF158849;
	Tue,  9 Apr 2024 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="WGPOEFQc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AAD12A14F
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 20:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695184; cv=none; b=R8abWkfqRSoiwOL+IAFOJqt44sqzXJyZT8HdB7H0fiCWTwGlqdCwoEvdGMpgxHCgBJGjimZz+M40rAphdgjVBdWdl7dy0DME6yncaLc8nCkgu/9jy2sFCTi11llYAy2xOhgfwPDvZLGvK1v5Y8yZj/ewHri2WPChWsQMikaIl8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695184; c=relaxed/simple;
	bh=kxt1xaIGiRfKn8bnmgxnEvhy1erQkY1WkntNJvIErrk=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=UvgnEXlMR+g3uc+6LkyChq2qFL5H0KWTEhzLEk5MO2WAooXgGnQgxv4RIoKmq5W5FFPBLOQiS55DXq0eqNGNTlEg7mOQwVV12wYZlDL12DaBDcQgKD1Z8/Clw4GJ2GVXl5hQqayJs1XyHdNYfxEH9wrPPDtgZQLdx+pd5z2ubW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=WGPOEFQc; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6E93F4015F
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 20:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712695176;
	bh=3LgqTXD4OHIXECybmpM50M/MOaCc4Fc1qQRvh2f+gFA=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=WGPOEFQcCWexpnki8tCZaLyovh4ShOm7t75Jsl+zZ/wI4F/oW68SVAjB4RUcmq7m2
	 njOjYMLJBc5AyJ3qulY4ur4pKgM1BkLwD3TVui7e8aJEI64lUxqSUW7mDI1yLaanqo
	 NqmEbkzdHrCyJArjBY/b1k/Nmbr5/ZryX6gaREW3+v6RZ3QmpAk4TLH8MuJSVWNOEN
	 SmMtVzhqBe/MBOI+1hZ+WbdLsCHPOfg2vpnWHD5c4t8EW0Xpif3SK+uxL4cbGliBUd
	 jK0edcSa28Ez/wsMdSWVeG+GY4KMq/O/p196VLTkpIXf2R8Yd+zMJ2oljbH+A9fDvv
	 O/LWO0z+Caf/A==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a53909676fso1736596a91.3
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 13:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712695175; x=1713299975;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3LgqTXD4OHIXECybmpM50M/MOaCc4Fc1qQRvh2f+gFA=;
        b=J9onfJLSw03DgOl9Bji2ofjxg4MkxOvY8aeiuc4MPUd2+D2XpzwScACsLXVLEfVlTx
         f7xrxA6IIu8Hy6lNVFJKVrXlNbEfZ+rj776KuNQ8L80PU5zLJiPglU3mJqo019RV4l4l
         3UcOkJWu7YVAY3aMsdxkCWfCLx++xpr5KOxunJa0YUthvpVQBKHolhOAr0cXe8T8aRj/
         fo166rlgE1VaDZoaFJ6U0qOBFPSj4s47bMhiHwpiKXB0xWhyYX9/JmNMOI90p5c2iQ1p
         dD7mUf5wJasu023WqEpmaLuKC0+eV80P8wXHShCQQAGNFDUc+DeCAtQ8UCsRy6WQ2X5A
         aAfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0Hw9e5qfN3uZw3gz8Ve03eG+gDZRWL3AXHlbZf9xyGW51RMnFjznVxUdx4nXkXOodTeQb3pj86Joj4THiPHKZSfDSc10a
X-Gm-Message-State: AOJu0Yzt3QekDJdE5J+0RorxCh3KewlPYVA8mUKbpewvFc1d2wL/GyRQ
	08L8aJCbxMYCC2rjzC+JforhtKUbRvjlf8wXTcQVy5hz2esLP3P35vG0IsTED7Sgo5Lty3Ph4oK
	hjRK4AkcTaQUPs9PMCtarGxyCmyDM75/aVZxasDzexutPPcTNSS38QQMm0k0X8xwfW198ig==
X-Received: by 2002:a17:90a:bf15:b0:29f:ef34:3004 with SMTP id c21-20020a17090abf1500b0029fef343004mr805982pjs.43.1712695174767;
        Tue, 09 Apr 2024 13:39:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoGAF0CYRF0Bztmk+nxl4gdACM9zZDWlUkJyF49N3CyvmX3cBdMc/jHGmQgBHUyY4hKJm0hg==
X-Received: by 2002:a17:90a:bf15:b0:29f:ef34:3004 with SMTP id c21-20020a17090abf1500b0029fef343004mr805962pjs.43.1712695174113;
        Tue, 09 Apr 2024 13:39:34 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id lw14-20020a17090b180e00b0029c7963a33fsm14034pjb.10.2024.04.09.13.39.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:39:33 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 5F938604B6; Tue,  9 Apr 2024 13:39:33 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 57C2D9FA74;
	Tue,  9 Apr 2024 13:39:33 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Eric Dumazet <edumazet@google.com>
cc: "David S . Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org,
    eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 3/3] bonding: no longer use RTNL in bonding_show_queue_id()
In-reply-to: <20240408190437.2214473-4-edumazet@google.com>
References: <20240408190437.2214473-1-edumazet@google.com> <20240408190437.2214473-4-edumazet@google.com>
Comments: In-reply-to Eric Dumazet <edumazet@google.com>
   message dated "Mon, 08 Apr 2024 19:04:37 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17497.1712695173.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Apr 2024 13:39:33 -0700
Message-ID: <17498.1712695173@famine>

Eric Dumazet <edumazet@google.com> wrote:

>Annotate lockless reads of slave->queue_id.
>
>Annotate writes of slave->queue_id.
>
>Switch bonding_show_queue_id() to rcu_read_lock()
>and bond_for_each_slave_rcu().

	This is combining two logical changes into one patch, isn't it?
The annotation change isn't part of what's stated in the Subject.

	-J

>Signed-off-by: Eric Dumazet <edumazet@google.com>
>---
> drivers/net/bonding/bond_main.c        |  2 +-
> drivers/net/bonding/bond_netlink.c     |  3 ++-
> drivers/net/bonding/bond_options.c     |  2 +-
> drivers/net/bonding/bond_procfs.c      |  2 +-
> drivers/net/bonding/bond_sysfs.c       | 10 +++++-----
> drivers/net/bonding/bond_sysfs_slave.c |  2 +-
> 6 files changed, 11 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 08e9bdbf450afdc103931249259c58a08665dc02..b3a7d60c3a5ca60be1d9eed18=
4ec1dad593a182b 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -5245,7 +5245,7 @@ static inline int bond_slave_override(struct bondin=
g *bond,
> =

> 	/* Find out if any slaves have the same mapping as this skb. */
> 	bond_for_each_slave_rcu(bond, slave, iter) {
>-		if (slave->queue_id =3D=3D skb_get_queue_mapping(skb)) {
>+		if (READ_ONCE(slave->queue_id) =3D=3D skb_get_queue_mapping(skb)) {
> 			if (bond_slave_is_up(slave) &&
> 			    slave->link =3D=3D BOND_LINK_UP) {
> 				bond_dev_queue_xmit(bond, skb, slave->dev);
>diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bon=
d_netlink.c
>index 29b4c3d1b9b6ff873fe067e80bedf7cb681d18f1..2a6a424806aa603ad8a00ca79=
7e9e22d38bd0435 100644
>--- a/drivers/net/bonding/bond_netlink.c
>+++ b/drivers/net/bonding/bond_netlink.c
>@@ -51,7 +51,8 @@ static int bond_fill_slave_info(struct sk_buff *skb,
> 		    slave_dev->addr_len, slave->perm_hwaddr))
> 		goto nla_put_failure;
> =

>-	if (nla_put_u16(skb, IFLA_BOND_SLAVE_QUEUE_ID, slave->queue_id))
>+	if (nla_put_u16(skb, IFLA_BOND_SLAVE_QUEUE_ID,
>+			READ_ONCE(slave->queue_id)))
> 		goto nla_put_failure;
> =

> 	if (nla_put_s32(skb, IFLA_BOND_SLAVE_PRIO, slave->prio))
>diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bon=
d_options.c
>index 4cdbc7e084f4b4cb3b150656aa765531806d8ad9..0cacd7027e352dbf3204d82b7=
ce1672469a186de 100644
>--- a/drivers/net/bonding/bond_options.c
>+++ b/drivers/net/bonding/bond_options.c
>@@ -1589,7 +1589,7 @@ static int bond_option_queue_id_set(struct bonding =
*bond,
> 		goto err_no_cmd;
> =

> 	/* Actually set the qids for the slave */
>-	update_slave->queue_id =3D qid;
>+	WRITE_ONCE(update_slave->queue_id, qid);
> =

> out:
> 	return ret;
>diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond=
_procfs.c
>index 43be458422b3f9448d96383b0fb140837562f446..7edf72ec816abd8b66917bdec=
d2c93d237629ffa 100644
>--- a/drivers/net/bonding/bond_procfs.c
>+++ b/drivers/net/bonding/bond_procfs.c
>@@ -209,7 +209,7 @@ static void bond_info_show_slave(struct seq_file *seq=
,
> =

> 	seq_printf(seq, "Permanent HW addr: %*phC\n",
> 		   slave->dev->addr_len, slave->perm_hwaddr);
>-	seq_printf(seq, "Slave queue ID: %d\n", slave->queue_id);
>+	seq_printf(seq, "Slave queue ID: %d\n", READ_ONCE(slave->queue_id));
> =

> 	if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD) {
> 		const struct port *port =3D &SLAVE_AD_INFO(slave)->port;
>diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_=
sysfs.c
>index 75ee7ca369034ef6fa58fc9399b566dd7044fedc..1e13bb17051567e2b5d9451ce=
ef47f2cf1a588ec 100644
>--- a/drivers/net/bonding/bond_sysfs.c
>+++ b/drivers/net/bonding/bond_sysfs.c
>@@ -625,10 +625,9 @@ static ssize_t bonding_show_queue_id(struct device *=
d,
> 	struct slave *slave;
> 	int res =3D 0;
> =

>-	if (!rtnl_trylock())
>-		return restart_syscall();
>+	rcu_read_lock();
> =

>-	bond_for_each_slave(bond, slave, iter) {
>+	bond_for_each_slave_rcu(bond, slave, iter) {
> 		if (res > (PAGE_SIZE - IFNAMSIZ - 6)) {
> 			/* not enough space for another interface_name:queue_id pair */
> 			if ((PAGE_SIZE - res) > 10)
>@@ -637,12 +636,13 @@ static ssize_t bonding_show_queue_id(struct device =
*d,
> 			break;
> 		}
> 		res +=3D sysfs_emit_at(buf, res, "%s:%d ",
>-				     slave->dev->name, slave->queue_id);
>+				     slave->dev->name,
>+				     READ_ONCE(slave->queue_id));
> 	}
> 	if (res)
> 		buf[res-1] =3D '\n'; /* eat the leftover space */
> =

>-	rtnl_unlock();
>+	rcu_read_unlock();
> =

> 	return res;
> }
>diff --git a/drivers/net/bonding/bond_sysfs_slave.c b/drivers/net/bonding=
/bond_sysfs_slave.c
>index 313866f2c0e49ac96299ffea307b1613955713ec..36d0e8440b5b94464b3226ce1=
a04f32361de5aa6 100644
>--- a/drivers/net/bonding/bond_sysfs_slave.c
>+++ b/drivers/net/bonding/bond_sysfs_slave.c
>@@ -53,7 +53,7 @@ static SLAVE_ATTR_RO(perm_hwaddr);
> =

> static ssize_t queue_id_show(struct slave *slave, char *buf)
> {
>-	return sysfs_emit(buf, "%d\n", slave->queue_id);
>+	return sysfs_emit(buf, "%d\n", READ_ONCE(slave->queue_id));
> }
> static SLAVE_ATTR_RO(queue_id);
> =

>-- =

>2.44.0.478.gd926399ef9-goog
>
>

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

