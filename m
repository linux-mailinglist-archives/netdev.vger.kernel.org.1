Return-Path: <netdev+bounces-103833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CE2909C61
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 09:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14DACB21B2F
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 07:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7640B1822C9;
	Sun, 16 Jun 2024 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Q/A1m8nE"
X-Original-To: netdev@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-74.smtpout.orange.fr [80.12.242.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B3661FF1;
	Sun, 16 Jun 2024 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718524699; cv=none; b=iQlOzp3BCfGMlAs9pLXC138xBXO53UzwgFvXU4q3NWxddCm5j3b4TqQeIZe3jKPl9tXAL064G6p78m5WgD5GJ/itJ3coMx6geXTC5PW59Nw9qtW4QfPC+Wn9DsN/Hfa3eu/tVjRKLIy1HFl/WERsUFAYVuCAjoRiSXzjrV0yw/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718524699; c=relaxed/simple;
	bh=WRZv3PDO/c6mtg4LaKOXC6PUftDrcCyhmpjzZeaRBdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eyj1A7VZVALMVvellVHZFv7S2EzrrxMf4U8inGILdacj6AyQIIdskoil2OeVqDovsUqe9gYoUy7k/aGgBuCHWv0MWy4alwlXr06MMxiRt2Fp6iH30xWlfnRRJpxfsubKXmK3JrE5XsuPd/5CqqlgRv33N0mmegZQremS/i5qAnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Q/A1m8nE; arc=none smtp.client-ip=80.12.242.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id Ikm4sPtRXuRA3Ikm4selgw; Sun, 16 Jun 2024 09:58:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1718524689;
	bh=9PkIY/+JvPRQH3lG8FJNGa1VEAbWJvoCrfAn8QG8UOQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Q/A1m8nE15VUD/F2KcFqQih3WKQqzCifDKGM/2EAxMQuLgsA1LyLfRtrEmPYV+Vqd
	 STY3RwYuI1z7WiPj9tuxMFpl1eBPybkYBaaz8Zu01+YPVXzoGpB9izrLaVD5wplg2i
	 t8WoLktVjxlysIhGPNCEga6dOPNTE8k87gzCBdYwa/WCLrLca25kv8Gu5lggYiUf1O
	 /3zzT/U2k55aKMYfPki78VajtGkxfrH2HqfYG+T65uxF1naq/n6Kt+LgZTfc1UQmkG
	 egZmBWxCTSR193wV1xn33tEcGTLRucGFwUXesx9ySaEK9jR1sAYo487TUP4FusDu8V
	 pnurseGbfG92w==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 16 Jun 2024 09:58:09 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next] net: microchip: Constify struct vcap_operations
Date: Sun, 16 Jun 2024 09:57:56 +0200
Message-ID: <d8e76094d2e98ebb5bfc8205799b3a9db0b46220.1718524644.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"struct vcap_operations" are not modified in these drivers.

Constifying this structure moves some data to a read-only section, so
increase overall security.

In order to do it, "struct vcap_control" also needs to be adjusted to this
new const qualifier.

As an example, on a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  15176	   1094	     16	  16286	   3f9e	drivers/net/ethernet/microchip/lan966x/lan966x_vcap_impl.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  15268	    998	     16	  16282	   3f9a	drivers/net/ethernet/microchip/lan966x/lan966x_vcap_impl.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I hope this can be applied as a single patch.
I think it can be split between lan966x, sparx5 and vcap if really needed.
---
 drivers/net/ethernet/microchip/lan966x/lan966x_vcap_impl.c   | 2 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c     | 2 +-
 drivers/net/ethernet/microchip/vcap/vcap_api.h               | 2 +-
 drivers/net/ethernet/microchip/vcap/vcap_api_debugfs_kunit.c | 2 +-
 drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c         | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_vcap_impl.c b/drivers/net/ethernet/microchip/lan966x/lan966x_vcap_impl.c
index a4414f63c9b1..a1471e38d118 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_vcap_impl.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_vcap_impl.c
@@ -581,7 +581,7 @@ static void lan966x_vcap_move(struct net_device *dev,
 	lan966x_vcap_wait_update(lan966x, admin->tgt_inst);
 }
 
-static struct vcap_operations lan966x_vcap_ops = {
+static const struct vcap_operations lan966x_vcap_ops = {
 	.validate_keyset = lan966x_vcap_validate_keyset,
 	.add_default_fields = lan966x_vcap_add_default_fields,
 	.cache_erase = lan966x_vcap_cache_erase,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
index 187efa1fc904..967c8621c250 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
@@ -1507,7 +1507,7 @@ static void sparx5_vcap_move(struct net_device *ndev, struct vcap_admin *admin,
 	}
 }
 
-static struct vcap_operations sparx5_vcap_ops = {
+static const struct vcap_operations sparx5_vcap_ops = {
 	.validate_keyset = sparx5_vcap_validate_keyset,
 	.add_default_fields = sparx5_vcap_add_default_fields,
 	.cache_erase = sparx5_vcap_cache_erase,
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.h b/drivers/net/ethernet/microchip/vcap/vcap_api.h
index 9eccfa633c1a..6069ad95c27e 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api.h
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api.h
@@ -271,7 +271,7 @@ struct vcap_operations {
 
 /* VCAP API Client control interface */
 struct vcap_control {
-	struct vcap_operations *ops;  /* client supplied operations */
+	const struct vcap_operations *ops;  /* client supplied operations */
 	const struct vcap_info *vcaps; /* client supplied vcap models */
 	const struct vcap_statistics *stats; /* client supplied vcap stats */
 	struct list_head list; /* list of vcap instances */
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs_kunit.c b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs_kunit.c
index b23c11b0647c..9c9d38042125 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs_kunit.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs_kunit.c
@@ -221,7 +221,7 @@ static int vcap_test_port_info(struct net_device *ndev,
 	return 0;
 }
 
-static struct vcap_operations test_callbacks = {
+static const struct vcap_operations test_callbacks = {
 	.validate_keyset = test_val_keyset,
 	.add_default_fields = test_add_def_fields,
 	.cache_erase = test_cache_erase,
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
index fe4e166de8a0..51d9423b08a6 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
@@ -211,7 +211,7 @@ static int vcap_test_port_info(struct net_device *ndev,
 	return 0;
 }
 
-static struct vcap_operations test_callbacks = {
+static const struct vcap_operations test_callbacks = {
 	.validate_keyset = test_val_keyset,
 	.add_default_fields = test_add_def_fields,
 	.cache_erase = test_cache_erase,
-- 
2.45.2


