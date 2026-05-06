Return-Path: <netdev+bounces-284608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePPiFdyE+mkePgMAu9opvQ
	(envelope-from <netdev+bounces-284608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:01:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0F94D4DC8
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8AF1303ACEC
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 00:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153C31A23B1;
	Wed,  6 May 2026 00:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7fIhRb2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BD71D88D7
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 00:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778025676; cv=none; b=Sr8vQqOvYkdoJMm+g5rNIRS96biNVD8I2qGGmCtDF41kby+xchG9ZYAFFixb03/MF1vQoFm3IldlXpnZEaFtUmaLWVKocBv1Cs/ROINulaTScUUeSOF8PQSGYAOdKnOz5kBtT0WWSiSg+nkPL+FTHKMYGewS4d82lFzaKJZi2gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778025676; c=relaxed/simple;
	bh=h1rUCEAVDreMRs/UIAh1ZQFmsNhLJtJVyOPd7r3hpiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=avx8F1XUFYQUTatmQdPth5xfjfWCdL1fxnV85Ku18+mTfve90UhDTvIG9Y6NqiJ9efjhef6oqQaoqaRx1S61aMLCMzKpHkvP4G+xpxN7l53Vm71WwNQCboh0HFpK3gV78E4FkU7apl/90rpJo7oFN/tgeQORKwksmCRiehTGMSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7fIhRb2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so36821615e9.3
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 17:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778025673; x=1778630473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l/Qg/UUHTqQhSyZu5dRkKvfDgdl5SGyTqVq0vb/VGhc=;
        b=M7fIhRb2GjsSrpuB+u2wT+KtbeERTvYE3MEoMwJY6HS5055Z2JcJEdgnqOObjK2svR
         dP4ph4GQezE/JE6GEI5hdp5ZE4E7k4XKKiCQdixBZQf9j/EVlreeLeFGeUtxbDPDEWut
         aeVEQo9rjBPHDCZTfvyj5Jh2s/FI7rlUcqdq17sJf9gLTuf9zAfz9UXgGJeEs0lQdFbR
         shT7ZU4EFSSaz5fkfPUH+vgSaLzKUzKVGMk6qAmNXiS4538uo/U0wOq/JJ/AQrIGFwUX
         akG9+BODZF0EzJ6HOEEn0rJGdfJ+U8+EXqYILT93gRfoS9nf7Dl+wgk8FuYCHzl7gjBX
         dM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778025673; x=1778630473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/Qg/UUHTqQhSyZu5dRkKvfDgdl5SGyTqVq0vb/VGhc=;
        b=Gf9FMQB5UZr4iX0bYbd7w2LLXnuc2mfQfdWFXC/nKAlIr3kzn4+OsmRgIZ/t/XrvnE
         1Q4izfJom43J5oNOQcfBxMR3em0oJeaxwe9h/cmdba3oNzoXDh+UHe9Git7xKf/br48w
         i7OXm+qQmtDQP9ki3gI6nMDVXq75lXHv04p7m8LsqZO8u7CfrjiKDod16VjpadnIg3Lc
         1KbieEmkNnu7eiCC++qBTxhaX6/7sasnkKMs0YEl277E23XM+iqWsXk2hnyqa+POdC6Q
         DeTZLD74nw8lUhZTE2MQVpER1f9JZY2I36D5xJyfT0W/L1TdbaOxB3RMiMgKemWzGT+f
         8JFg==
X-Forwarded-Encrypted: i=1; AFNElJ+X1FUufG0hJQ8Mq64N53YvsrezskB/JlPoNmaufD7mr/6/HmxAfYwMwD/4Nfems8Q/exbxTYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YybBvDRCKAtXh86d0HO9C5Q+BSQHd9NQ/mhF1Jr5oEuuLwcTE58
	s0kEBq5U9G97650JRbH2484b6lq/nLZASukUPNLZgsd1WYNrRWOXGnmu
X-Gm-Gg: AeBDiesLiXVpixpVh6NsInRie5NUIqhMHFo3GDbMWOJhU+Q2zShCu6Jhn4QH/r0l9P3
	bjdl5tLDYD4aH+zygsS1qTO5E8Tux8nUV/E3ZetjwVz3CN2YiwZkQ0/g+xcf0C6A6ZHQDBwIs6K
	Q1fipc43xEf4IyRMjKLWw+ezgX+u8VM02PcPzITSDrXiOPB0nir2+ddlGOswWb7hdyLzurgle58
	fsykw+K6cyP9gj0wwwpBPlAB06hGefgwKuWUpFLhZyjeH85rRSEtpFFkQI31WoM3Pxu3zfJaOY9
	EzbHG/zgeWCBA7n5wkWZnVs5l2FokZEzutZwK5RqS0a57nS9Jr+UsC0OhiqHksm4TZsaWyfwWup
	ne7lzxig5ZBtsUUOflNiLsDmwDJPmsv1RbNlVoM59HnnGIVCXFPabhgUruW8mvVnYlKrGbWo61M
	NgRuG5AMMymdKj8U/c/W3+BgPNuW9YnlJ9+ItD1mBNAKSV4n9H7L6+kcKe1bzLXg1S9GvYd3xOj
	dnDe6tMFRci45d1nNHIuRDI35Gu5XLHkDkxz8lG9MH6A8Fmbeab
X-Received: by 2002:a05:600c:34c8:b0:486:fd5c:2b35 with SMTP id 5b1f17b1804b1-48e51f2f85emr23251925e9.13.1778025672933;
        Tue, 05 May 2026 17:01:12 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538acbfcsm1454165e9.8.2026.05.05.17.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 17:01:10 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Cc: Moshe Shemesh <moshe@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH net v1] net/mlx5: HWS: Reject unsupported remove-header action
Date: Wed,  6 May 2026 01:00:31 +0100
Message-ID: <20260506000054.51797-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CD0F94D4DC8
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
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284608-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

mlx5_cmd_hws_packet_reformat_alloc() handles
MLX5_REFORMAT_TYPE_REMOVE_HDR by looking up a matching HWS remove-header
action.

If mlx5_fs_get_action_remove_header_vlan() returns NULL, the code only
logs an error and continues. The function then returns success with a NULL
HWS action stored in the packet-reformat object.

Return an error when no matching remove-header action is available.

Fixes: aecd9d1020e3 ("net/mlx5: fs, add HWS packet reformat API function")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index aca77853abb8..5a172c572a68 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -1320,8 +1320,10 @@ mlx5_cmd_hws_packet_reformat_alloc(struct mlx5_flow_root_namespace *ns,
 		break;
 	case MLX5_REFORMAT_TYPE_REMOVE_HDR:
 		hws_action = mlx5_fs_get_action_remove_header_vlan(fs_ctx, params);
-		if (!hws_action)
+		if (!hws_action) {
 			mlx5_core_err(dev, "Only vlan remove header supported\n");
+			return -EOPNOTSUPP;
+		}
 		break;
 	default:
 		mlx5_core_err(ns->dev, "Packet-reformat not supported(%d)\n",
-- 
2.43.0


