Return-Path: <netdev+bounces-272252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF23HFuexWlqAAUAu9opvQ
	(envelope-from <netdev+bounces-272252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:00:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA1B33B9D1
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 055EA304E79B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB2E3A8741;
	Thu, 26 Mar 2026 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltCieQgE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4411E3A7F50
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774558782; cv=none; b=NkSzO/4CizmRBZgusW009lzbi5BPxnAchyxRftOPoktHuR6/YoypvKpJzLwIQCYbJHIEwekTro7iuyOaBh3B4tJAlzZMz67QekmS4EmJ9/FHm+Wcsv+Ac6+V9KptN2ovBVGcV9WqRMGMV9lft3OfaltfZXkVcAaPxkAis/IgSwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774558782; c=relaxed/simple;
	bh=pdWhTr13yB2TeUjNjTSrTEV1W426Ty4TykkxZVSVbJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=loSbCt10FKfir6unoxKSyfY0d1x8GMXJhoX5P626Zj/dxVqDDaUVxFlosrd8XoWb1jjxVweQREN2o1QE1OD6Eua1YC5kSUqSJkbYTUjDGWsn6nXRVLV0vUur7RKtKYBMgdlXNWuvmwN8jysDetwnTnniwg6CnVFeH9cq8vMTMu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltCieQgE; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a27daa652fso1788371e87.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 13:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774558779; x=1775163579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R36FhGs7Uipw1Isw8Vzai14giCROBLkpYdIr0Y3wTOA=;
        b=ltCieQgEYDSmrv8WRGjF8kRHdcyQMQjDiK98tZmlU75UpeqLlw76qg9I2a5/ThozhC
         2RyyYshj1diPaoD62z6n05Hd3pAT/cMKJEsJIO78d9X33KNNVrjeK6X4ozAIYXu9YXRu
         oXSRZ4ZEdUcSNfdcu98IkQJ4MbTDAjmYpgPL4a8DNIm9GoU80GJ6L3akuftnOHbDr2/j
         yUF4AJXbfiQ3Sg7Yegl3cAf6Gx+abL/WFrCyJFIa0a5R2hJK8/CVTWBvfSGZu+dTdB+D
         +sBFo5v28vvvend+LdjMOX4KC123h+KUN9uUuF6OTg5Kyou4v/fMVjgbx4i3asg6VaxG
         nAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774558779; x=1775163579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R36FhGs7Uipw1Isw8Vzai14giCROBLkpYdIr0Y3wTOA=;
        b=haKPIl0nnK3AA6chtoFRhbyXnA+Ch/WgGfFzqaLYkhWObdQ2htPWio03EvUoQnC+Jl
         wdRM5YKMFK1EAmzoVRdoscWdiXCiathcjd8u0c0ZAIAj4wbASeL/GQWa2VFAit6v+PPZ
         pW548zu8kewnojBoUuZAET9sM4yoUhJOsuiHIDt39Kri5AIlD0Yk0V8AYF57iXr1MVi6
         8FCvxevDpjFc8KwnDVHjckLPKyBSXqNIeMSB0XwWlJbInjYS0DJXqU6MDsLh1sNWpgEz
         TKjUghZPHquBEwMTSJxh1DtaCVXUV7t15YdgcQvg7mUGpOiw4DYeqle1kohIrg+liM40
         uTGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQYG1ijvAADzbo4F7Zi5m6Qlid9vBCKrkyJbJt1z1XXSS9TmWfPpO8baEAnMQ/g2OM7zwiphY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr/0/BW6blBh+y3lhefm7pWKyXuA80Eo3P4E8GSa8b4oF0aJpH
	pEgrJFRNvU7wBbGImhqrcIuNnYgUuDCLiNaGIUhRN16BCSAxb15QRIzF
X-Gm-Gg: ATEYQzwJGjfZjTGn7jz6QSMkRBtggnpLMvK8eF490rSO1+WeBHKXew0azZeeB2o5t6z
	DnEMUPnoW4kvWNXrnvX1nyn1J/6auBR2G+qLfTKOxJJJIPhargue0qZKVL6c6y0aR17d1x/Xyq2
	gsMuYVYZd30QXwM/anSz+4nlUxHPrTl1EIQpe0xw6O1c7HMbQd4hODFDJBDKtqrpCOoAJOA5DfJ
	WzJRCoVTHoVFGtoSs2raubMnLXdwws6MUBeDv/JCVX1wiNPezNdDuV1C9LCvdCc+++KJAoeRMc6
	GjDMG5Fhwe5/3uxuvuP9huCvRNqFXIDhwz5WU8liZZ+nRl8bTMJx8cxn2JTI6QG7cbRc+um1VuB
	GUcWUtyddh4Us3+xH6qoTm/sxFEisPpr1d8pqImTPQZUgMLrEghrWQqYUo5X2luDM/XOQYBv6dR
	gAnvGG0EMuyBdhVKdG0u4cQGRImEpHaaHOKnSD1xAvOZcIUDaNyQAe57OpNcNtaH/0oUISBU5df
	7N2
X-Received: by 2002:a05:6512:1381:b0:5a2:aa50:4c55 with SMTP id 2adb3069b0e04-5a2ab7e9143mr12706e87.8.1774558779239;
        Thu, 26 Mar 2026 13:59:39 -0700 (PDT)
Received: from localhost.localdomain (81-237-238-191-no600.tbcn.telia.com. [81.237.238.191])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2a068f5f1sm842596e87.55.2026.03.26.13.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 13:59:37 -0700 (PDT)
From: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
To: saeedm@nvidia.com
Cc: tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Subject: [PATCH net 3/3] net/mlx5: Add null check for flow namespace in mlx5_cmd_set_slave_root_fdb
Date: Thu, 26 Mar 2026 21:58:24 +0100
Message-ID: <20260326205824.11749-3-rayfraytech@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326205824.11749-1-rayfraytech@gmail.com>
References: <20260326205824.11749-1-rayfraytech@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-272252-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rayfraytech@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5BA1B33B9D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mlx5_get_flow_namespace() can return NULL if the namespace is not
available. Add a null check to prevent potential null pointer
dereference when accessing ns->node.

Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index c348ee62cd3a..c52d8ca6aa0b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -186,6 +186,8 @@ static int mlx5_cmd_set_slave_root_fdb(struct mlx5_core_dev *master,
 	} else {
 		ns = mlx5_get_flow_namespace(slave,
 					     MLX5_FLOW_NAMESPACE_FDB);
+		if (!ns)
+			return -EOPNOTSUPP;
 		root = find_root(&ns->node);
 		MLX5_SET(set_flow_table_root_in, in, table_id,
 			 root->root_ft->id);
-- 
2.43.0


