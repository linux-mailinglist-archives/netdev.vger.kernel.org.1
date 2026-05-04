Return-Path: <netdev+bounces-284056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCEnI7UY+Wlc5gIAu9opvQ
	(envelope-from <netdev+bounces-284056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 00:07:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 097CB4C44A1
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 00:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F230430128D4
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 22:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF1A37BE75;
	Mon,  4 May 2026 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR+z0bc0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CCA37B415
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 22:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777932466; cv=none; b=Ci+ElxJiV/ZGFAakbJQcdcBSkNTuFbKZC+3pmTTpTtSXx7SVi30NYQmRMeWIbzdhGxR0ssP7YfdMpcPLWfs4+9Dh1z8ukU0HO67MeBHPBrI/7cNoFBaXybGByzE/1isuNVRAjXc/Vs5/Y5iTPfLH5TCbx4Ya4s5sKw8uf/d8+Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777932466; c=relaxed/simple;
	bh=QMnG8lNMPjiWCPP9V8fm1Uvfmgn4efv6jtSMg58pV+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Frhs3r1AyayqPhRnR4Wg+GHfxQMUafH+IaJGjFSPkIrQH2OXF5CoqdsaclOyyCft6jRpeVLaifJOkYkciOWa7jrsYzFuIsvKGXIqfb+s5O7Uqn1uOY0UsX8I1/Mq18bC6zSDAKXwnumoO88tetZpSOE1uug6SCdnWWIU2GbRZBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mR+z0bc0; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-448528f4e69so2670618f8f.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 15:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777932462; x=1778537262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T2EAcQpFApLkE9tQqBTkW5v5GHoiaZ1e/P1wsvwgU1U=;
        b=mR+z0bc0KGVZu/d2HU46TVlE8dsyJn+vwLG3e2eeotorCHZZmJw+QDpY/Dd5DuQO5g
         D/vM8+I7yQLq3Rzx6K9xuIVimsVOyvWfujHtJaK215b0HBgv2R1Y3yDNsvTazs6w72Qz
         kxlKgsuKEHj0fl98wmTMwghNH90vkVRqkihaLoCfeKHiJ6g06OkD5HkyCDpqOjTbhZlg
         tYzRVLlUjy986KzHi5HVM67e42Fin5uBXO7mU1bwJ1HjfY8irmum9lUdWk/IO6+0LhW3
         sckAHxQv0Ven5hWIs1ErV/jQSFDlRfZpwIOsg5b08CmWux9JZzISdtTgzZoh3JXkARhH
         HfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777932462; x=1778537262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2EAcQpFApLkE9tQqBTkW5v5GHoiaZ1e/P1wsvwgU1U=;
        b=Ex/dFT9F2lAlt8CRlILAXNu9BReTUFGtaWHKdlfcEs8DvcNdk42eaHKTzKYunvC/aN
         s8KjpWj8huKkNoGhiYaEdkRgglg9kYfKmt41l9+4wK/eRTtdMLeYw3SuKINnpRU59B4W
         NqOcsN0PD3FZ74qqifgJasndLEW0bj0Ic9CqdbbHsHQfgn7kvWB/1yA18R45aSsNrt/K
         Rn33Bbq2BLQOCG/yRE/co3DZ1lBYL060njJ2jA+SJk5IvU93bRiV8W8NaUqilhFygc/P
         0zB5JYLmYqFoP3tJ6FWUZmvVtW8aQyaGC2Cp0+1ILoHrqMnlWjbyS8X2g9iOC2q3hTXi
         Z1QA==
X-Forwarded-Encrypted: i=1; AFNElJ9oTST9Rv7TimBTg7LuybJ38ZKil4BOhz9G8+vZQwxE+bjZxEiJxq+hy4Z0P0H+fWRFlDCOUOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YydPE4wrCDzedlYsz11r73wyDyT4K2u6KuLtboPTCcewg0sHpEj
	ErnT57t4hQteOuNjFf/I7llkLJphDnS1Gzsob3Fa/otRF5pSyZZUYEbv
X-Gm-Gg: AeBDiesG51vyrWsAU+rO9CjJNlVhfT/oFoc2KOaMMZICMJ349ULcuwoRF1AMv6zK25h
	UCsmiZEBud2OW1uQ9SW1EjgmS881+ORyq0evUIW7SOih/dErFoMF1IFg7nrZzWEx8YzGcczi+ap
	K9wV7QouuM3PzkRepqs3vIH4fmK5BHU99LprnhJ+WEiewShYs75/0DvbM9trnteg6CGTUZGxcKC
	+QrN0bkpTnG0uOza75XIVhtt2VZOrgVUFRlaRSJ2jCoQdOpn9b2+dSDezeT5wwaQSpbg22oKaQf
	BuyezB09YptD5vtVK+z7EV+1tuEdGuPwn+jyAxpbXyHCSu6cmTi6KlhyE4UxFaTYSjHP0fwYSoc
	vt1epfqtO/srzduu7Ym7N9jK6FfxKEpV2pffzXPeY8bGTGW2RAoA35YyYTemWUKarr++u7Es98C
	xR8/JdY7eSoW5FSYOkDvbJb5XwbET3Ycp1xX5B6FgMJhdqwhAipXAp4zSSI2lZt/L8PhNGUjGT7
	+eIStAE/Hy7lw5pamKUBaL9QqBR6MZi2HAcLYHxfw==
X-Received: by 2002:a05:6000:18a5:b0:44b:ad5a:cd33 with SMTP id ffacd0b85a97d-44bb66d6302mr18061645f8f.40.1777932462036;
        Mon, 04 May 2026 15:07:42 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4502c011043sm329503f8f.32.2026.05.04.15.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 15:07:41 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Cc: Moshe Shemesh <moshe@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH net v1] net/mlx5: Fix HWS action unwind NULL dereference
Date: Mon,  4 May 2026 23:06:46 +0100
Message-ID: <20260504220725.46686-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 097CB4C44A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284056-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

mlx5_fs_fte_get_hws_actions() stores some destination actions in
fs_actions[] before checking whether action creation succeeded.

If creating a table-number or range destination action fails, or if
fetching a sampler destination action fails, dest_action is NULL but
num_fs_actions has already been incremented. The shared error path then
calls mlx5_fs_destroy_fs_action(), which dereferences fs_action->action
to get the HWS action type, causing a NULL pointer dereference while
unwinding the original failure.

Track whether the current destination action needs fs_actions[] cleanup,
but append it only after dest_action has been validated.

Fixes: 2ec6786ad0a6b ("net/mlx5: fs, add HWS fte API functions")
Fixes: 32e658c84b6d ("net/mlx5: fs, add support for dest flow sampler HWS action")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 .../mellanox/mlx5/core/steering/hws/fs_hws.c     | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index aca77853abb8..fb12513dd83d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -950,6 +950,7 @@ static int mlx5_fs_fte_get_hws_actions(struct mlx5_flow_root_namespace *ns,
 			struct mlx5_flow_destination *attr = &dst->dest_attr;
 			bool type_uplink =
 				attr->type == MLX5_FLOW_DESTINATION_TYPE_UPLINK;
+			bool record_fs_action = false;
 
 			if (num_fs_actions == MLX5_FLOW_CONTEXT_ACTION_MAX ||
 			    num_dest_actions == MLX5_FLOW_CONTEXT_ACTION_MAX) {
@@ -973,11 +974,11 @@ static int mlx5_fs_fte_get_hws_actions(struct mlx5_flow_root_namespace *ns,
 					break;
 				dest_action = mlx5_fs_create_dest_action_table_num(fs_ctx,
 										   dst);
-				fs_actions[num_fs_actions++].action = dest_action;
+				record_fs_action = true;
 				break;
 			case MLX5_FLOW_DESTINATION_TYPE_RANGE:
 				dest_action = mlx5_fs_create_dest_action_range(ctx, dst);
-				fs_actions[num_fs_actions++].action = dest_action;
+				record_fs_action = true;
 				break;
 			case MLX5_FLOW_DESTINATION_TYPE_UPLINK:
 			case MLX5_FLOW_DESTINATION_TYPE_VPORT:
@@ -988,9 +989,7 @@ static int mlx5_fs_fte_get_hws_actions(struct mlx5_flow_root_namespace *ns,
 				dest_action =
 					mlx5_fs_get_dest_action_sampler(fs_ctx,
 									dst);
-				fs_actions[num_fs_actions].action = dest_action;
-				fs_actions[num_fs_actions++].sampler_id =
-							dst->dest_attr.sampler_id;
+				record_fs_action = true;
 				break;
 			default:
 				err = -EOPNOTSUPP;
@@ -1000,6 +999,13 @@ static int mlx5_fs_fte_get_hws_actions(struct mlx5_flow_root_namespace *ns,
 				err = -ENOMEM;
 				goto free_actions;
 			}
+			if (record_fs_action) {
+				fs_actions[num_fs_actions].action = dest_action;
+				if (attr->type == MLX5_FLOW_DESTINATION_TYPE_FLOW_SAMPLER)
+					fs_actions[num_fs_actions].sampler_id =
+								dst->dest_attr.sampler_id;
+				num_fs_actions++;
+			}
 			dest_actions[num_dest_actions++].dest = dest_action;
 		}
 	}
-- 
2.43.0


