Return-Path: <netdev+bounces-96541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C84998C666F
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 14:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0062C1C21DE3
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 12:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23A081736;
	Wed, 15 May 2024 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="pJl68KPT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD887441E
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 12:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715777080; cv=none; b=ifc8r+tzkfdeQyZBJbsFPQ0jXEK1fgY/SmdD5XExg9kU5zpuzjYIGOoiF/oPOMJVzOLwF4mQaxUGTfQmhq2zKdV23ZQCCpT/ZfGAhZhR630P7HJAXAJgoGDrT4ckRq6D8S+ea6hSdrJ+zWbgffp1loPi51TThIyvCwB4qT+IdHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715777080; c=relaxed/simple;
	bh=I/MyxrB+nmv6ZB0pa1tt9ijUXgrLl97Zv4WDrFGKzJ0=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=XPWcvq+C+l4Wf5jSqGB+IhJga0YVPYtb//uLmxhmUUY3g+qXdJQqJ3ktbBJjm7JSgv0QIsrm5L4GIWiL+eR5HNQ48MxDGMhFwAJ2ghOTec3/NmRT3Dt4pAvNANHIaUFC3GZ7D0ndGzZZs8P3pnxYIKcDNOaez1n31z4jkVh543o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=pJl68KPT; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 927B13F32F
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 12:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715777069;
	bh=4HJeFaOK9tGHFStLY3GCkQ10gHhR7YTwoxWqpzbp1lM=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=pJl68KPTMiGhDrhNp/eFy/KDrywR4ACXd1c9ZtW7KvjMRRqHRSSfPVziOIZmYEtzq
	 mssOg/Itq447FldkHsS2N2EmbUUFqSkcpi2GsEoowMvthXkZEVG2QzYZXSCj8KzjJV
	 qGMzF8XWC2RABMI3Wiw+hjYSmLbpMWYCX6SsXikCLII867bUVATNly71PBD0zmeFpP
	 lx7w4iVvAjDYuH0pUOKhXgF4ms+w0fXaURpSP+D0J41oNLfMZ0lZ5o/g4ivQ2EYzbz
	 b+dKHbNHbJ1WL9fUlqG7NszIToD6A/tFftxgkI/kVjNM5n/wxkcAcPzsONHj+dmmwa
	 j6w/TZdxpM1iw==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-34d91608deaso3990462f8f.0
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 05:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715777069; x=1716381869;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HJeFaOK9tGHFStLY3GCkQ10gHhR7YTwoxWqpzbp1lM=;
        b=un1FNVSWXmKhkCd8jQ/3AfbSPwvd9wFTcrth1yse1QFOOGSfsxLpeH5hCA6V9mqyN4
         /eAsOIK7orc67cnRX9BL3L2cLlDXg+VopPVGIyjZT4hrOTqmKOs3BVj7xLQVo3bJJ3Qg
         Kqg9cY84Ac3ks+/opfMonFlQQjZ8Y71i97l13DzYwhlwg3r4FGmrewMnspRtM795yzNw
         j9VcVRMPIpYgfwek0vp1Sytd0IVIF3UP8kueRG+h1T1wLuPRDavD7fWxNQ0Dw42nhnG6
         c9l4O17vodW36QI6kjMlVkTySY7xChe4lp4Fj0zob13utTQVS87pyG/iOiHevLJhHK9/
         1F1w==
X-Forwarded-Encrypted: i=1; AJvYcCXKE//O9HIqYVjWTQiVVUCVm2Od3tXOHiBjcF2ym9qJMa7CVodyNZDc6Oi9P1e51132p1v2adYfagZMJONJEBJ7IE22Y5R+
X-Gm-Message-State: AOJu0YxfXazxagX0Vb72kFhuGDboKMnjfOrtU8eoee6mBHaCgUrIo6rJ
	Mt2K1UPni6DeNOlqVCT+H0EOMbMrl+xDsdL3NrCEaZ7wUeZ1qlpKPNcK6a3MDIDj8dANqCDXHCa
	dElwfWwSvrb8NT4SPXkW2qdveycXjksrgoT+ZRbPAjrmaabEBVNerF0pKNvLZAm+ueXRBeQ==
X-Received: by 2002:adf:ebce:0:b0:34c:f507:1f54 with SMTP id ffacd0b85a97d-3504a736e3emr9476951f8f.25.1715777069046;
        Wed, 15 May 2024 05:44:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2MRd0PN5uylOgXamXcxl6EKRhC9ppy0P4vMOsfUNbJ+7uKPlFyEQO5UKmG6hhZSEmePlWPQ==
X-Received: by 2002:adf:ebce:0:b0:34c:f507:1f54 with SMTP id ffacd0b85a97d-3504a736e3emr9476934f8f.25.1715777068559;
        Wed, 15 May 2024 05:44:28 -0700 (PDT)
Received: from vermin.localdomain ([149.11.192.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b896ad0sm16290767f8f.47.2024.05.15.05.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 05:44:28 -0700 (PDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id 4FC0F1C04B7; Wed, 15 May 2024 05:44:27 -0700 (PDT)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id 4DA3B1C04B1;
	Wed, 15 May 2024 14:44:27 +0200 (CEST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Tony Battersby <tonyb@cybernetics.com>
cc: "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Andy Gospodarek <andy@greyhouse.net>,
    Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] bonding: fix oops during rmmod
In-reply-to: <641f914f-3216-4eeb-87dd-91b78aa97773@cybernetics.com>
References: <641f914f-3216-4eeb-87dd-91b78aa97773@cybernetics.com>
Comments: In-reply-to Tony Battersby <tonyb@cybernetics.com>
   message dated "Tue, 14 May 2024 15:57:29 -0400."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <232326.1715777067.1@vermin>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 May 2024 14:44:27 +0200
Message-ID: <232327.1715777067@vermin>

Tony Battersby <tonyb@cybernetics.com> wrote:

>"rmmod bonding" causes an oops ever since commit cc317ea3d927 ("bonding:
>remove redundant NULL check in debugfs function").  Here are the relevant
>functions being called:
>
>bonding_exit()
>  bond_destroy_debugfs()
>    debugfs_remove_recursive(bonding_debug_root);
>    bonding_debug_root =3D NULL; <--------- SET TO NULL HERE
>  bond_netlink_fini()
>    rtnl_link_unregister()
>      __rtnl_link_unregister()
>        unregister_netdevice_many_notify()
>          bond_uninit()
>            bond_debug_unregister()
>              (commit removed check for bonding_debug_root =3D=3D NULL)
>              debugfs_remove()
>              simple_recursive_removal()
>                down_write() -> OOPS
>
>However, reverting the bad commit does not solve the problem completely
>because the original code contains a race that could cause the same
>oops, although it was much less likely to be triggered unintentionally:
>
>CPU1
>  rmmod bonding
>    bonding_exit()
>      bond_destroy_debugfs()
>        debugfs_remove_recursive(bonding_debug_root);
>
>CPU2
>  echo -bond0 > /sys/class/net/bonding_masters
>    bond_uninit()
>      bond_debug_unregister()
>        if (!bonding_debug_root)
>
>CPU1
>        bonding_debug_root =3D NULL;
>
>So do NOT revert the bad commit (since the removed checks were racy
>anyway), and instead change the order of actions taken during module
>removal.  The same oops can also happen if there is an error during
>module init, so apply the same fix there.
>
>Fixes: cc317ea3d927 ("bonding: remove redundant NULL check in debugfs fun=
ction")
>Cc: stable@vger.kernel.org
>Signed-off-by: Tony Battersby <tonyb@cybernetics.com>

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>

>---
> drivers/net/bonding/bond_main.c | 13 +++++++------
> 1 file changed, 7 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 2c5ed0a7cb18..bceda85f0dcf 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -6477,16 +6477,16 @@ static int __init bonding_init(void)
> 	if (res)
> 		goto out;
> =

>+	bond_create_debugfs();
>+
> 	res =3D register_pernet_subsys(&bond_net_ops);
> 	if (res)
>-		goto out;
>+		goto err_net_ops;
> =

> 	res =3D bond_netlink_init();
> 	if (res)
> 		goto err_link;
> =

>-	bond_create_debugfs();
>-
> 	for (i =3D 0; i < max_bonds; i++) {
> 		res =3D bond_create(&init_net, NULL);
> 		if (res)
>@@ -6501,10 +6501,11 @@ static int __init bonding_init(void)
> out:
> 	return res;
> err:
>-	bond_destroy_debugfs();
> 	bond_netlink_fini();
> err_link:
> 	unregister_pernet_subsys(&bond_net_ops);
>+err_net_ops:
>+	bond_destroy_debugfs();
> 	goto out;
> =

> }
>@@ -6513,11 +6514,11 @@ static void __exit bonding_exit(void)
> {
> 	unregister_netdevice_notifier(&bond_netdev_notifier);
> =

>-	bond_destroy_debugfs();
>-
> 	bond_netlink_fini();
> 	unregister_pernet_subsys(&bond_net_ops);
> =

>+	bond_destroy_debugfs();
>+
> #ifdef CONFIG_NET_POLL_CONTROLLER
> 	/* Make sure we don't have an imbalance on our netpoll blocking */
> 	WARN_ON(atomic_read(&netpoll_block_tx));
>
>base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
>-- =

>2.25.1
>
>

