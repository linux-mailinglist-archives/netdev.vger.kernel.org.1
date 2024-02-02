Return-Path: <netdev+bounces-68700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D9A8479BF
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 20:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5209F1F27ABD
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 19:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38FF15E5D3;
	Fri,  2 Feb 2024 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="E0pr/XX5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF70415E5A6
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706902467; cv=none; b=V/oFxgWmnuZlB3l5onBoBj4cEPh/iu1jk5sEFOUBwjdIEXDq4WAxBCHhvEBCXEK6GEmUQoWHCBDLgq8I3PKoo7bzrDa4wivveFj4oO48tgSkK0vaeZzC7ko5+9zzJqLW7l3DHY1tuUagTLKQST1LNCZ0+r9nX97CJKIy2O+HIX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706902467; c=relaxed/simple;
	bh=Y5Muu2ufHlGnsg78AvHeQNFVAIdyf/qtjm8lGiyerbM=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=eASuxyFlJtbdQkMepQ7u956vTqx2vLIyyIQmruH4JhPD9zpxWgkvoS4BV6b+Sy8NxGhjIFomeKwesb0dHsLTTWUXN/qJ8lU3dgXqQhfKw0zunp82F5L6I5RCQQpsFs5sHUS/eIo68AZHkNqhyvNubNYwb1XDVZqh+jITY40FUE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=E0pr/XX5; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 003B83FE36
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 19:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706902458;
	bh=Kfxpmk+N/HftTY9CilAH9dM4781JeGZ/79vr3l+xI2I=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=E0pr/XX5tP2JAdYvWU+GqZU8Ignn3v9+lM9ENOR4wm7JTqkiLjJh5H5RSRAutd75i
	 lv6toRLf74McjjJ5Zz077wumr1o9GCRrqjtJpVahhmPoxUeECQiS3j8QaU1ZTgz5EA
	 BYqxW6myfB9maAo45C2jyDqTwYEx9xDT2WpL9K65mlmwwUpqeDD5DAK1TIyxyy3mmO
	 orKREPALR/a/gU0ReatDBg17YzocPpaT7/q+b/aJ+e5kIzC5Su2gslGxGbxZwDOK4t
	 vqhOdX4CsxfmxAmbGLOPwt6fVEIyFma8SB9kRQv8YcE/YN9NK3jgvcXNiSXpVqbTmK
	 PvnAwNIGWHIXA==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-290f607c1dfso2178798a91.3
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 11:34:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706902456; x=1707507256;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kfxpmk+N/HftTY9CilAH9dM4781JeGZ/79vr3l+xI2I=;
        b=QfYAg6CcLm6ElJRQL6wMiapj1HOjZAmVV4Mgp221b+CM4MWqywGV/rpJDsoZXGEihf
         f//PeWxGDaE4OlTYpv9PzRm8XzV7gFDQ8EHH/rJpOz2V7PiuPHT0RReusWq+foqDp+G5
         ndlJxhrpUpAAQiqTDKMWGirjLnTMAlBbLOcebr5rQ68BHje4xENdyrapVk3JJ2S7sl1r
         nkv4NYnk0c/MyWkI6X1DvjTC2TbtvxLhYrNXgLhbKNcdlUMcNlvEWCXfdyG2JHeiYnxv
         ejV0VtHqL7CCfh0iqu+UC94mjRQZWJeTDerzG727m1Nc57fONjP0W+fnkZUe6GFqWgSY
         obUA==
X-Gm-Message-State: AOJu0Yz3Q3q7iEIc4aLW/NA9RYHrkV9EQpYVGbiWqLIcCWxlT0rG3rrE
	D7KkFvP1Zdb7xG5Yu8k9L9a/DGCgWbrJA6EfRFlBgFcBkJUbnHnaNFSmST9ZztKLspOY4R+U9Vw
	6SxG1mNW94MVjGgH9qxvP7R2QNMoPEBysVpU6JXeXsbMy+wxYZri6eR/5gRUSDEta4NGdFw==
X-Received: by 2002:a17:90a:8c0c:b0:292:65ad:d57d with SMTP id a12-20020a17090a8c0c00b0029265add57dmr3047300pjo.33.1706902456704;
        Fri, 02 Feb 2024 11:34:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7jVdLAlMRm23tIdTlBYFsC1A04lBI/dSlB44YV1RLxQW+onJbe3uFKJdu0Lw0wOVyRqcRvA==
X-Received: by 2002:a17:90a:8c0c:b0:292:65ad:d57d with SMTP id a12-20020a17090a8c0c00b0029265add57dmr3047280pjo.33.1706902456415;
        Fri, 02 Feb 2024 11:34:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU6OW8l03IRrHganVFeKVwCCYJv5KD/UVgOYSHMyhUq0KaqjLnfRcSngo5MUAj6ohoJHZWTvrPkpQygNyfe2mEZA/kpuRjqWhybIhu9pm62EyFcRCsu5JHaVz+REefvbMYrzxGTeUxUltCLWpWge+uqvb9lkt4mlStrAKIrAaEwOAXD+heWcPQN3pKvbIg0xMfbLGoPUEFrRFNoGplNOul7CRnVfEQADe3uRw==
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id s15-20020a17090ad48f00b0029636e02c83sm397605pju.35.2024.02.02.11.34.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Feb 2024 11:34:15 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 6CC415FF14; Fri,  2 Feb 2024 11:34:15 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 6191D9F682;
	Fri,  2 Feb 2024 11:34:15 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Eric Dumazet <edumazet@google.com>
cc: "David S . Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org,
    eric.dumazet@gmail.com, Andy Gospodarek <andy@greyhouse.net>
Subject: Re: [PATCH v2 net-next 05/16] bonding: use exit_batch_rtnl() method
In-reply-to: <20240202174001.3328528-6-edumazet@google.com>
References: <20240202174001.3328528-1-edumazet@google.com> <20240202174001.3328528-6-edumazet@google.com>
Comments: In-reply-to Eric Dumazet <edumazet@google.com>
   message dated "Fri, 02 Feb 2024 17:39:50 +0000."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30338.1706902455.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Feb 2024 11:34:15 -0800
Message-ID: <30339.1706902455@famine>

Eric Dumazet <edumazet@google.com> wrote:

>exit_batch_rtnl() is called while RTNL is held,
>and devices to be unregistered can be queued in the dev_kill_list.
>
>This saves one rtnl_lock()/rtnl_unlock() pair,
>and one unregister_netdevice_many() call.
>
>v2: Added bond_net_pre_exit() method to make sure bond_destroy_sysfs()
>    is called before we unregister the devices in bond_net_exit_batch_rtn=
l
>
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>Link: https://lore.kernel.org/netdev/170688415193.5216.104998302727326228=
16@kwain/
>Cc: Antoine Tenart <atenart@kernel.org>
>Cc: Jay Vosburgh <j.vosburgh@gmail.com>
>Cc: Andy Gospodarek <andy@greyhouse.net>

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>


>---
> drivers/net/bonding/bond_main.c | 37 +++++++++++++++++++++++----------
> 1 file changed, 26 insertions(+), 11 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 4e0600c7b050f21c82a8862e224bb055e95d5039..a5e3d000ebd85c09beba379a2=
e6a7f69a0fd4c88 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -6415,28 +6415,41 @@ static int __net_init bond_net_init(struct net *n=
et)
> 	return 0;
> }
> =

>-static void __net_exit bond_net_exit_batch(struct list_head *net_list)
>+/* According to commit 69b0216ac255 ("bonding: fix bonding_masters
>+ * race condition in bond unloading") we need to remove sysfs files
>+ * before we remove our devices (done later in bond_net_exit_batch_rtnl(=
))
>+ */
>+static void __net_exit bond_net_pre_exit(struct net *net)
>+{
>+	struct bond_net *bn =3D net_generic(net, bond_net_id);
>+
>+	bond_destroy_sysfs(bn);
>+}
>+
>+static void __net_exit bond_net_exit_batch_rtnl(struct list_head *net_li=
st,
>+						struct list_head *dev_kill_list)
> {
> 	struct bond_net *bn;
> 	struct net *net;
>-	LIST_HEAD(list);
>-
>-	list_for_each_entry(net, net_list, exit_list) {
>-		bn =3D net_generic(net, bond_net_id);
>-		bond_destroy_sysfs(bn);
>-	}
> =

> 	/* Kill off any bonds created after unregistering bond rtnl ops */
>-	rtnl_lock();
> 	list_for_each_entry(net, net_list, exit_list) {
> 		struct bonding *bond, *tmp_bond;
> =

> 		bn =3D net_generic(net, bond_net_id);
> 		list_for_each_entry_safe(bond, tmp_bond, &bn->dev_list, bond_list)
>-			unregister_netdevice_queue(bond->dev, &list);
>+			unregister_netdevice_queue(bond->dev, dev_kill_list);
> 	}
>-	unregister_netdevice_many(&list);
>-	rtnl_unlock();
>+}
>+
>+/* According to commit 23fa5c2caae0 ("bonding: destroy proc directory
>+ * only after all bonds are gone") bond_destroy_proc_dir() is called
>+ * after bond_net_exit_batch_rtnl() has completed.
>+ */
>+static void __net_exit bond_net_exit_batch(struct list_head *net_list)
>+{
>+	struct bond_net *bn;
>+	struct net *net;
> =

> 	list_for_each_entry(net, net_list, exit_list) {
> 		bn =3D net_generic(net, bond_net_id);
>@@ -6446,6 +6459,8 @@ static void __net_exit bond_net_exit_batch(struct l=
ist_head *net_list)
> =

> static struct pernet_operations bond_net_ops =3D {
> 	.init =3D bond_net_init,
>+	.pre_exit =3D bond_net_pre_exit,
>+	.exit_batch_rtnl =3D bond_net_exit_batch_rtnl,
> 	.exit_batch =3D bond_net_exit_batch,
> 	.id   =3D &bond_net_id,
> 	.size =3D sizeof(struct bond_net),
>-- =

>2.43.0.594.gd9cf4e227d-goog
>
>

