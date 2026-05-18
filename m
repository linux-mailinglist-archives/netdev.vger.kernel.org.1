Return-Path: <netdev+bounces-288858-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPQqAGSkCmqy4gQAu9opvQ
	(envelope-from <netdev+bounces-288858-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:32:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49785566450
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CDE9301A521
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C463B19D2;
	Mon, 18 May 2026 05:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b="EWEnZj37"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C44B3AB26E
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 05:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779082316; cv=none; b=qKP3X1oDiHVzpeoQerFBCPsZTD/cqOIG23A1OqcoHezN6ICIMIn+EfhsRePoMNgl88bJJqehSlM+H9tnMAFlmferU5dEjqDCSSUg8y9+o47ouZvZ+wi5Q5OMIXfBPtMRIE/Q/xruaCOQ7sWTjad4JjncXDk6tJqVGxXEoKGJdH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779082316; c=relaxed/simple;
	bh=Ned4ol8vz7Bh1l/p1mUYhTl5oKEAmZypE4u6wrnLdZY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f1Ph7RePk75UMg+vNslAQ6XdVsa71SfFkbCesCdZzNNZIR6+4OzewTu2HXft2re373Grt3N1IcA5bAPjpBvgIMF9+yCqGBPo58+x3gP7yhP9zOPKE6i7gDDizP6y/Wr4Ox0HKrAKqxWfl3IiKXg7+U4eL1TZZy1pGKhGorFGjdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com; spf=pass smtp.mailfrom=juliahub.com; dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b=EWEnZj37; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juliahub.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9106ea78cd8so360334385a.3
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 22:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliahub.com; s=google; t=1779082294; x=1779687094; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YaCqS9VEHADAY4+Ko1Sdf5gqYjwOEBQdqfe6uNonwPQ=;
        b=EWEnZj37P+dGh9qdL5QCdeRIWmi1qg3dNKetN3BvT8sjOFA2RR8SqDw3eAvachszp5
         ek0+hMK2W2g8q/bgSrNoe/GfzetpKSOHvjbaxH7IRLkjmOq+KdPRuT4VAil0FfRsBIMb
         jC5xeLvur3FTN6ygL9l9HFr7THiXx2dZ14Uaqw6AVVenN9lRExKFVORHBErqH23kVgQP
         6ZoInaQrUZW7j8IPM03Hwg4hofJKG/dkdJJzudUf7IpMiHiGMlBru0zw44MtI8Nd8XUD
         +Wmao7+A8LRSqLvJJgf5vzMH5N9iiuEJ5lkUJxrnAuA5/oBfCHXCiwPWKB+/ijUFx3nL
         OQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779082294; x=1779687094;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YaCqS9VEHADAY4+Ko1Sdf5gqYjwOEBQdqfe6uNonwPQ=;
        b=lLgPuExKT+HUdMkfDsrwl8RP80EsHMeByXLwORi8/ZsWeHwkj60PYvJqzYE9mtUZDj
         lC3U5pqpAi2i+qOx0onstvsDzmxcgCT7c7VhpA2OJZ+Am5AiXpGUuBRWrDLdKDIO6JYo
         2/esvNgZiD/XhNbB84F7MFoC2YUpHcYihg0tWf9RbfnANkSjKj/KA0gDCB0S0OgDjpOu
         oRk7ISR3UnB+1tW5K6yhaWT6s8eDdANXUnVko4UF/9e2ICbpg9cZTXeC2FdjlBFL3+C/
         ubm9y4nfNZ2gGvRqXngyeD3C74ZGpTi+gEOF5sWZoB/qNQd6blWOJRyx7GC98IS2AQWK
         MyzQ==
X-Gm-Message-State: AOJu0YxOdJEX6ZZ3jKYoihQyx+ENEv8T1GivbkxpeCFZl4/9P3JpMZgs
	jVG8rcU43F8goPjlaUvwdnfgEkH8K/Jo0/DVj3kUknGsjnGfpOhtx4LmUXAoMf/ucP1GBiTd9Q1
	IAswv
X-Gm-Gg: Acq92OEAuMw/dOJ4Ipo+Wz9tdi1CRZY949QFDCyZezilgtT6YoFyBRNU0K9UKb/JAA9
	voNwcFpJMI6wSVCk+VpdA1CdNbrVX/JNUTIByLneSpQXnjvTdADNTRpTnQeHHLhQpvySqLHyhtC
	HYPdNt7aDzxLTXd2rrIUB5oHDRC/ShsAZs2PNzJQDOgI7bCAecaelQVa+f5IvSnr78r1JFoE7+z
	ppbc2EyOqMdvsLUoyAJB2rUe0Gq9YXH0+aMyYQ7HmT2TL2IkodzYjXH+NuxLtVGSGUWPxojuPyq
	hIKUfvhbqJsypcZ0HT3q5h1p0A9gHRD7uXuz/Z+YbSTPnqEb+rAd2wj90ObXaByr5BRni8WrUw3
	AjP3Q9G4b07S76ZSjlDXFTXfEVHAzJQlXbpmQRfFZQ/uBe/0ov+6Chq1J30Ojz3tvFlK/ZxEoBE
	QaP1zNzr37wwVV94avU36NEoUYs7ct+j0JHdhzskNN0wBs6nq5KAZc
X-Received: by 2002:a05:620a:4514:b0:913:7bc8:79b9 with SMTP id af79cd13be357-9137bc88256mr898007585a.22.1779082293918;
        Sun, 17 May 2026 22:31:33 -0700 (PDT)
Received: from juliahub.com ([66.31.114.203])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba36e1acsm1381641185a.3.2026.05.17.22.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 22:31:33 -0700 (PDT)
Date: Mon, 18 May 2026 01:31:31 -0400
From: Keno Fischer <keno@juliahub.com>
To: netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] mlxsw: spectrum_ethtool: expose per-PG rx_discards
Message-ID: <agqkMwgM1PdkyMUR@juliahub.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 49785566450
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[juliahub.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[juliahub.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[juliahub.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-288858-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[keno@juliahub.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,juliahub.com:email,juliahub.com:mid,juliahub.com:dkim]
X-Rspamd-Action: no action

PPCNT group 0x10 (per-priority counters) carries an rx_discards field at
offset 0x78. These counters aggregate up into if_in_discards, but don't
show up anywhere else. Since there are many things that aggregate into
`if_in_discards`, having these counters helps distinguish what caused
those discards (in my case they were caused by headroom buffer overruns
due to inappropriately configured buffer sizes).

Of note, from emperical testing, these counter are per-"priority group"
(PG) not per-"switch priority". It's a bit confusing, because the rest
of these counter are per-"switch priority" and the header file calls
these "Per Priority Group Counters". However, that should be read as
"(Per Priority) Group Counters", not "Per (Priority Group) Counters".

I attempted to distinguish this in the counter naming by calling these
`rx_discards_pg_N` rather than `rx_discards_prio_N` (which is the
naming scheme of the other counters in this PPCNT group).

I will also note that the mlx5 driver (which already has this counter)
uses the schme `rx_prioN_discards` (and same for the other counters
in this group). However, I was unable to determine whether the mlx5
counters behave the same as the mlxsw counters with respect to PG
mapping. An attempt to remap to a different PG there did not change
which counter incremented, but the mlx5 configuration code is quite
different, so it's possible the remapping needs to be done differently.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Keno Fischer <keno@juliahub.com>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h              | 8 ++++++++
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 3bb89045eaf5..01fcbd1c8d01 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -5651,6 +5651,14 @@ MLXSW_ITEM64(reg, ppcnt, tx_pause_duration,
 MLXSW_ITEM64(reg, ppcnt, tx_pause_transition,
 	     MLXSW_REG_PPCNT_COUNTERS_OFFSET + 0x70, 0, 64);
 
+/* reg_ppcnt_rx_discards
+ * Per-PG (ingress priority group) drop count.
+ * index slot is the PG, switch priority.
+ * Access: RO
+ */
+MLXSW_ITEM64(reg, ppcnt, rx_discards,
+	     MLXSW_REG_PPCNT_COUNTERS_OFFSET + 0x78, 0, 64);
+
 /* Ethernet Per Traffic Class Counters */
 
 /* reg_ppcnt_tc_transmit_queue
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
index 0a8fb9c842d3..7f78b1ef61cc 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
@@ -542,6 +542,10 @@ static struct mlxsw_sp_port_hw_stats mlxsw_sp_port_hw_prio_stats[] = {
 		.str = "tx_pause_duration_prio",
 		.getter = mlxsw_reg_ppcnt_tx_pause_duration_get,
 	},
+	{
+		.str = "rx_discards_pg",
+		.getter = mlxsw_reg_ppcnt_rx_discards_get,
+	},
 };
 
 #define MLXSW_SP_PORT_HW_PRIO_STATS_LEN ARRAY_SIZE(mlxsw_sp_port_hw_prio_stats)
-- 
2.54.0


