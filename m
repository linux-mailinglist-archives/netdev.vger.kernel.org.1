Return-Path: <netdev+bounces-284606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DiDAWCC+mngPQMAu9opvQ
	(envelope-from <netdev+bounces-284606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 01:50:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5BD4D4CE8
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 01:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26483304BF0E
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 23:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFE333B6DF;
	Tue,  5 May 2026 23:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJFbQ1GA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1A52F3C0A
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778025041; cv=none; b=dwUCwMTDRTUA2l1NW64Cg8xg+xQwQVxSOzd5FpVUi6PNjWuYGqAGL1kdD7bn53mqUuAGwkO3G9kHOrvFg9C/VKsClffEHXTCCtDwBAu5IHW5OJuLG2rt9AONXC9PXqyL9+Wm2Vg0VoJDDu1KQWHSl51dAygInSSVT0IMP+MLvM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778025041; c=relaxed/simple;
	bh=b0+sikzvNYfNWiv4eEBKwYdzayPztWTMNL7LUGw6qpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TFgSRyNP7mPTecP/K9FkaYkhbcjRpdHdrv3YbTcXjjAaejF0sbIMqBdIvfenwwVi3XwgaLRzUGlcNUJnvlvEa/PyW9Knwhjd0kG3ilcStIEZrS1NWgk93WOyMJYnEZN/TvNghx1ST3oMNJ2GWbIPACNXBnIgyLaNSqYAQrGSVU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJFbQ1GA; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d77f60944so3789984f8f.3
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 16:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778025037; x=1778629837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jviD8hPEm7lughBQuX/QL6NEuZ/mYGqrq0e4z3+1mUw=;
        b=MJFbQ1GA9RwDz6psrHMElWReazbqsemnUFwYBbLkcj6jumOTII06pMc2yhU99IhKEL
         z0rGwgR4MIJwfj6C0a36+Bm5rcuiIFKm5bYi8EOEz+zHDnVIpVvuTlIZXrvPqK6mo0z9
         p7MunXN5y/BHoqxrqFG+TQuzIvHUouW9ilB2GNRvk8Y6+ArRJ3DnNoWCHx+5RUXlAgiV
         BTCBGrb8V7iwNjgzZGDoRU6994/JZVPNupI+K17gzU+CxFc8fYiKIa+EHYC4aSWF8JXL
         /7oigQ9ADLkliLRAG3QoilYthRRi+EKXVXBmYBV/vubVP7Mxdm82sKMWNJ07f/PMIR0S
         VD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778025037; x=1778629837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jviD8hPEm7lughBQuX/QL6NEuZ/mYGqrq0e4z3+1mUw=;
        b=LvYOGY0WZZV0TaO6n/srVJf89nOB8myHmV3Z4XFo9DV1oXwegiOBLolTKwpnr4K8wY
         HoMpfypJQqEg7tEYmB3XPk6ixiD5t4TBwz/IbKA4g2UNLYMmiBHEw9Kln0RLcX/EfzPa
         HcNQIL2zDUlB4F0P1N8CQVFV0iXycIW9BV9KeW9fVL81LJvv1OeEj+IP63luOlAOfJli
         aS8Fo438CMAOVFhLvEkJGI1is8OowSgkMZlFrtWYADr3UVOT+o+4zFb/qIKfMvtlBF0t
         9Cwp8SlLXQfe7VmUeyPdyX2qIy8YVbwaGMQ4SwoWg7zi02VU84srimDEMt5kTw4EmC1v
         8b8w==
X-Forwarded-Encrypted: i=1; AFNElJ/ZeBLdCKHD5BeKJHDZI4XllYR9kZrpi29AzUL+xxXyFEBOhHbBpz9GTaOiLf/Ncha/P77+YBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxa9AFHsBvvaGog7rcsMq2fOP9kmZzQo+w7KNEqhu8BzcRfe5i
	RTKNGkOwZtrNWL3WjmKrjJGRGhAA4QRQJXqQwqQvSy9mS411m6x3xb5/
X-Gm-Gg: AeBDietuIsOf99DuQaoEmJZ3XwfX8dDcwO8jW8b5jiXOT+KSY0ImVdiys0YLD6+XLqw
	v5sZFgvrKRPrjp7LULwz8mFTHC+I0to4a36TLis4IMfi1rqAz0+J0hjLE/EcUuXlg9YWbJYDsx6
	atRKjlRGtMo0z8n7reYD4FoEv4ki0Yl85EcvTMV4DKzFknkLbc/B3vg4MiS0A9QX468jCAuzrT/
	jdSzXesjDvaxiCIeqp3pApluSXpC6jwtwBvzJon5aVhT3APSsY5QGyZN1UzmZuJRnlE7zuPtXgZ
	oGiclKv44vP7pe04zvIKQqmGz+3JrGG/eS1esbEOi+Lnr3+WAO1Gl7fg8PBGY4RsVpu3lNtFRBU
	/0PCOy+kF8GBskvntjLMfPHnZMpUOdyd8n6Q5zGmKLYQ3oBobNohhHFkPz5TdI3fmSpJ92XTkw7
	arV9lKyXbzOY58CVrUW3Liey/f/G7Pej8o1cgibqind+uyRomvA11Ol6+moy0WzjvLJUxmv4d5z
	wRI7P9enetdD0s2bbT0J3HYLtv1DNUN652fC0qLlw7bzALi2AKc
X-Received: by 2002:a05:6000:2386:b0:43f:e938:1e67 with SMTP id ffacd0b85a97d-4515d99fff7mr1670239f8f.38.1778025037016;
        Tue, 05 May 2026 16:50:37 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055e2d3d0sm7658839f8f.34.2026.05.05.16.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 16:50:35 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	Chris Mi <cmi@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH net v1] net/mlx5e: CT: Fix NAT miss rule cleanup on init failure
Date: Wed,  6 May 2026 00:48:33 +0100
Message-ID: <20260505235029.51045-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6F5BD4D4CE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-284606-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]

mlx5_tc_ct_init() creates the CT-NAT miss rule before initializing the
conntrack hash tables, workqueue and flow-steering state.

If one of those later initialization steps fails, the error path destroys
the CT-NAT table but does not delete the miss rule and flow group created
in that table.

Add a dedicated unwind step to delete the CT-NAT miss rule before
destroying the CT-NAT table.

Fixes: 49d37d05f216 ("net/mlx5: CT: Separate CT and CT-NAT tuple entries")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index 6c87a1c7db09..15e406d29004 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -2349,7 +2349,7 @@ mlx5_tc_ct_init(struct mlx5e_priv *priv, struct mlx5_fs_chains *chains,
 					   &ct_priv->ct_nat_miss_group,
 					   &ct_priv->ct_nat_miss_rule);
 	if (err)
-		goto err_ct_zone_ht;
+		goto err_ct_nat_miss_rule;
 
 	ct_priv->post_act = post_act;
 	mutex_init(&ct_priv->control_lock);
@@ -2382,6 +2382,9 @@ mlx5_tc_ct_init(struct mlx5e_priv *priv, struct mlx5_fs_chains *chains,
 err_ct_tuples_ht:
 	rhashtable_destroy(&ct_priv->zone_ht);
 err_ct_zone_ht:
+	tc_ct_del_ct_table_miss_rule(ct_priv->ct_nat_miss_group,
+				     ct_priv->ct_nat_miss_rule);
+err_ct_nat_miss_rule:
 	mlx5_chains_destroy_global_table(chains, ct_priv->ct_nat);
 err_ct_nat_tbl:
 	mlx5_chains_destroy_global_table(chains, ct_priv->ct);
-- 
2.43.0


