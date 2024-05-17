Return-Path: <netdev+bounces-96987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7F78C8914
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 17:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077311F26E93
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 15:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F846A8AD;
	Fri, 17 May 2024 15:11:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1026996A
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715958710; cv=none; b=Et4fYg6XNfpOu+CKSO2uEF5mKzMgP3P5fZa39Wuu5x/oC9HqxReWry8nVCvAjloh3onDCyOOk9AOpq6nCNWaA9VmU2JQuSmlIhaGONEC1lOCAlfRzzP7f5SiVKizD9MKvkPeAuO4oGTM2bDwAxa1z8EWpoKnn5eQp1PKA1jr9UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715958710; c=relaxed/simple;
	bh=JoaVRlStp8RrWSxyOCouhUz7t6oVS8UocMnIZpXzY4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uHO7BE7fJfORh+NDpZfJpSGFaW7orraLkH7GnnrpmyJxpNwF000js+fWjdk/iusJRK9DeJx+Uf9n4IgcZUD0NIwAlIfoXCIno5O3W9PpP4IED84HQJf5sq5iXJ9TMUM+FpGoeb2lby7jvsL6qmu3yz8NzlCVE9Buh9ZJrKJuF9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garver.life; spf=fail smtp.mailfrom=garver.life; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garver.life
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=garver.life
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-FktqgA7BPACkrmQQshGugg-1; Fri,
 17 May 2024 11:11:38 -0400
X-MC-Unique: FktqgA7BPACkrmQQshGugg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84C8D38C6163;
	Fri, 17 May 2024 15:11:38 +0000 (UTC)
Received: from egarver-mac.redhat.com (unknown [10.22.9.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B0E58740F;
	Fri, 17 May 2024 15:11:37 +0000 (UTC)
From: Eric Garver <eric@garver.life>
To: netdev@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net-next] netfilter: nft_fib: allow from forward/input without iif selector
Date: Fri, 17 May 2024 11:11:37 -0400
Message-ID: <20240517151137.89270-1-eric@garver.life>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: garver.life
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true

This removes the restriction of needing iif selector in the
forward/input hooks for fib lookups when requested result is
oif/oifname.

Removing this restriction allows "loose" lookups from the forward hooks.

Signed-off-by: Eric Garver <eric@garver.life>
---
 net/ipv4/netfilter/nft_fib_ipv4.c | 3 +--
 net/ipv6/netfilter/nft_fib_ipv6.c | 3 +--
 net/netfilter/nft_fib.c           | 8 +++-----
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/netfilter/nft_fib_ipv4.c b/net/ipv4/netfilter/nft_fib=
_ipv4.c
index 9eee535c64dd..975a4a809058 100644
--- a/net/ipv4/netfilter/nft_fib_ipv4.c
+++ b/net/ipv4/netfilter/nft_fib_ipv4.c
@@ -116,8 +116,7 @@ void nft_fib4_eval(const struct nft_expr *expr, struct =
nft_regs *regs,
 =09=09fl4.daddr =3D iph->daddr;
 =09=09fl4.saddr =3D get_saddr(iph->saddr);
 =09} else {
-=09=09if (nft_hook(pkt) =3D=3D NF_INET_FORWARD &&
-=09=09    priv->flags & NFTA_FIB_F_IIF)
+=09=09if (nft_hook(pkt) =3D=3D NF_INET_FORWARD)
 =09=09=09fl4.flowi4_iif =3D nft_out(pkt)->ifindex;
=20
 =09=09fl4.daddr =3D iph->saddr;
diff --git a/net/ipv6/netfilter/nft_fib_ipv6.c b/net/ipv6/netfilter/nft_fib=
_ipv6.c
index 36dc14b34388..f95e39e235d3 100644
--- a/net/ipv6/netfilter/nft_fib_ipv6.c
+++ b/net/ipv6/netfilter/nft_fib_ipv6.c
@@ -30,8 +30,7 @@ static int nft_fib6_flowi_init(struct flowi6 *fl6, const =
struct nft_fib *priv,
 =09=09fl6->daddr =3D iph->daddr;
 =09=09fl6->saddr =3D iph->saddr;
 =09} else {
-=09=09if (nft_hook(pkt) =3D=3D NF_INET_FORWARD &&
-=09=09    priv->flags & NFTA_FIB_F_IIF)
+=09=09if (nft_hook(pkt) =3D=3D NF_INET_FORWARD)
 =09=09=09fl6->flowi6_iif =3D nft_out(pkt)->ifindex;
=20
 =09=09fl6->daddr =3D iph->saddr;
diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index 37cfe6dd712d..b58f62195ff3 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -35,11 +35,9 @@ int nft_fib_validate(const struct nft_ctx *ctx, const st=
ruct nft_expr *expr,
 =09switch (priv->result) {
 =09case NFT_FIB_RESULT_OIF:
 =09case NFT_FIB_RESULT_OIFNAME:
-=09=09hooks =3D (1 << NF_INET_PRE_ROUTING);
-=09=09if (priv->flags & NFTA_FIB_F_IIF) {
-=09=09=09hooks |=3D (1 << NF_INET_LOCAL_IN) |
-=09=09=09=09 (1 << NF_INET_FORWARD);
-=09=09}
+=09=09hooks =3D (1 << NF_INET_PRE_ROUTING) |
+=09=09=09(1 << NF_INET_LOCAL_IN) |
+=09=09=09(1 << NF_INET_FORWARD);
 =09=09break;
 =09case NFT_FIB_RESULT_ADDRTYPE:
 =09=09if (priv->flags & NFTA_FIB_F_IIF)
--=20
2.43.0


