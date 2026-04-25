Return-Path: <netdev+bounces-281085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA9/EmkL7GnbTwAAu9opvQ
	(envelope-from <netdev+bounces-281085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 02:31:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCF1464424
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 02:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F329300F109
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 00:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36C0194C95;
	Sat, 25 Apr 2026 00:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KevyhgEd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A372E7080D
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 00:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777077067; cv=none; b=e7zyv/JUWgHuZxBuKO9FLaVxZu6nbwhE7AcqpoH+UdVK9AKEBaLlOn2+txpD393iWyE73sBz/6xiy3AFgeWvpR9vuHE9cL7AXCcpiIstZ6q1VAvPEFxvr/ag4F9zzjJmIwHvMvNU9kEBBenCXaKD8TQdO7uSiV7R204gdv0Kk0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777077067; c=relaxed/simple;
	bh=9L62xwjArBntNKO9ecICnkDj175ZgUCNs8W1CCZhLSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jdr5gNoIgXcAZ4kUV7BpqGAJWYmMKYrqr2qnoYjT+xhugUjeWh9g/SXnHrO/fWLcX4B+mU7+bHfaiqrVYXvra5ZY+QCxyRvU3fBX3VvcU6rsdbtQtC9dKBILJihYLhMw9SkO06RXeNzDZiKVCk2iQK7bFtchSVKjviynPtlAlZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KevyhgEd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso67298505e9.0
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 17:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777077065; x=1777681865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0srnFrmgBaoPXdArgJP1j4sQT6zcktR4MHuImOUO7nA=;
        b=KevyhgEd7LgaGnJyhApXR+Uc1iQRVFnNXSNLueH1pXJXAgoF4ZTkgBtnyoDEVnCsfW
         EHQqNN2kRXWoeDCqKMhkrAlh8eLPp3F4uzt8Tn6+u2ZF5oiZ5dw5RWkMssnKghyVXKZn
         2uqa5tYzJCHHSedzVWyBI70HtlWgtITxBm/zZsp9umkBHHRk7QbvVliO7X25OSJDgJuQ
         0hdNhC9cDkdqNQAJRVu99kYLg6p9VIe5+sHQANn0WsN+xIMf5cwsU7CIdMqUx/muOKIq
         Xd0VJydnn2BSeJX4bsHc2SHqZ+Pt8VZfIAH/vI4E076aAPFhD9cIiK3Ta0zocS4Yzw77
         rWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777077065; x=1777681865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0srnFrmgBaoPXdArgJP1j4sQT6zcktR4MHuImOUO7nA=;
        b=s0VGkpoBxDP5Rud3OB58Pxxb3fJfSvqJdUBrbYnrBqvyli/Oo+e4VgVyRezP//TY/M
         tI0DK08iuT+Ud0bTXmEB7UisNVIXUJYVYfM3l26DK/o0WCqEf1lF/k483gyessajf1q2
         knN2jMyb3uCRQvu2zQI0gmS0pz5/gLj+FyYIago+QPmiPUH7s5MPsWFc8cclHsvTK0w5
         mlJyWW6KHXv4weRNYQCXh7t7TqTXz9viKXvW8MpiLbguFcivDikVACLzoxxjFY0AntBu
         jY2BT409AgVTjxhqODwaryMvJGC68S50tycFrnCgKVWTSzziAfu7i4IIY54iBj9NhG+W
         CrKw==
X-Forwarded-Encrypted: i=1; AFNElJ+QPW8lbY7O9YYKBflSXCN2IZDRG4b2zwixSOieMIyGlL6axjLNn+6YLX0+x3wl86CJU2+wfFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuayji6sYVDKEa+qcSGgHhyTV7cT8hf7JXlAeQygChMe0sZ+83
	9An9/Z2CBgZxfKvBySWXItnUI/JUf8dG/se6RL/deQL0PRMVDR7H/jUv
X-Gm-Gg: AeBDievnnCl4TD7ABc8DaNDF30gZnoTTKWZM7Dcxql9K0yfhK1k7oOmbiOP/vbeKYfL
	KPNZ4zfKeQ03g2qFuSBl07zFZDZZeh7djOYQ6v8zv2BcbbUjoXkzQAwz6gQ+Otv6A+8ikvZdwX/
	h4mUneJ3yAaan3rntCry6bNA8PkLpB8MkadEp6J8D8TqpG2jJU33fSCGGbGdv4ppVf5ia8Bm06V
	BTG4pOHOgAa9fN67n42SKlHN7ERCGkO4pLtjJf19OWP55bafUcppIi24PQwLjz0QF+AIM6icne7
	FHod28iEjqTWjHB+HFYeFZb67gUXxBbFaqdEWc3CYtS3Lz25JK626tCevjAl1dC8n4qDAbjJeE0
	bpmNTCGJqzDhEE9CT9C7wPg8XoLEz3Pn+EmXcr3zQDyf9Zo2NU396lo+Vu6mWu16OfHvI2B7qDA
	G1nJPBbJrdkQoNKbYefs9ijSqaSCj3oCAZOSwKMm3d1+xiBWttGPZggInY5T3bD+wA0f9mq6QhD
	EI/gutErag763kBJu4c+3ujvn7Eh39czx7e+RVCqA==
X-Received: by 2002:a05:600c:3150:b0:480:3ad0:93bf with SMTP id 5b1f17b1804b1-488fb7930famr489626335e9.24.1777077064912;
        Fri, 24 Apr 2026 17:31:04 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489201cde98sm378059485e9.7.2026.04.24.17.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 17:31:03 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: saeedm@nvidia.com,
	leon@kernel.org
Cc: kuba@kernel.org,
	tariqt@nvidia.com,
	cratiu@nvidia.com,
	cjubran@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH net v1] net/mlx5: Fix eswitch offloads cleanup on QoS init failure
Date: Sat, 25 Apr 2026 01:29:59 +0100
Message-ID: <20260425003046.6889-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9DCF1464424
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-281085-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

If mlx5_esw_qos_init() fails after esw_offloads_init() succeeds,
mlx5_eswitch_init() jumps to reps_err and skips esw_offloads_cleanup(),
leaking the offloads initialization state.

Add a dedicated unwind label for QoS init failure that cleans up
offloads before continuing the existing vport and outer eswitch cleanup.

Fixes: cac7356c653d ("net/mlx5: Rework esw qos domain init and cleanup")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 123c96716a54..db4bf17d2640 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -2059,7 +2059,7 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 	esw->mode = MLX5_ESWITCH_LEGACY;
 	err = mlx5_esw_qos_init(esw);
 	if (err)
-		goto reps_err;
+		goto qos_err;
 
 	mutex_init(&esw->offloads.encap_tbl_lock);
 	hash_init(esw->offloads.encap_tbl);
@@ -2088,6 +2088,8 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 		 MLX5_MAX_MC_PER_VPORT(dev));
 	return 0;
 
+qos_err:
+	esw_offloads_cleanup(esw);
 reps_err:
 	mlx5_esw_vports_cleanup(esw);
 	dev->priv.eswitch = NULL;
-- 
2.43.0


