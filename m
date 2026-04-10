Return-Path: <netdev+bounces-277608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAqZHfV+2WmjqAgAu9opvQ
	(envelope-from <netdev+bounces-277608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:51:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8E43DD529
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CCBF73016510
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE7C347BDB;
	Fri, 10 Apr 2026 22:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arW4m0QT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8328124EAB1
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 22:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775861488; cv=none; b=M24WQIGgs2BishCQD7vNPyj/DulnVsDJTWTcPK//ehG8NRh75tirxFzul8cZcMbFw/xtalLtUTS8Tt5XC5fjX5PkGxEWTdvRSEeh4UiBEZYQiMxL6pAeFbOkeb5nInwYC3Sn9NjTCOj6Nasx6SEAEAyr6/DferM6BasjUaxZ33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775861488; c=relaxed/simple;
	bh=g94ZvU6Eq6VpyU6gZKGEO5v6YDDlDdSD7Aa1Zvg13DE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nRRNsOzFRAuM3mNAKNfs2NDxN4E0ZImZhV/K7ka5tkialqsuwJr5H6owimrtzQOx6nj3QmpXnPS/Y7nLDxTJ6gpredXrEOyYIsW9OeccOUaKseBj/O2CDgeF7go0iqdJcehExX6INpaYtcSKzKnkXDHTzFqTj1pyp7g4TgG8DQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arW4m0QT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48896199cbaso27082025e9.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775861486; x=1776466286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hSRTjy6wm25VHK2uTpX6ZsxoXvGmhSlH5xYLbZJnuyM=;
        b=arW4m0QTOPPf05hrS5AjHRfG/+uUs/txJE8eYQKR2OF2YlIM6l9Y/aNMSat595hmtr
         3/yQjWMmnHCaKz3L0F5xYbOKX1vOJipPjCziobAvhLbwmzzC2ncPxmkJ95hifT3CYCjb
         KErI+PBJRPF+JMh4BvsrYRJSdUWO3TFVUmqqKk/Nk/4svGJVqpD74qL6gYXPs++S5e6M
         SROks9h7fGqHzguzqfv55iNheOHJWwWDc4KwQ/ITR2cx7qumWYAtkNGi4vTaJpHGtC48
         K50hxhQBzTss2V6BcScRZZo9YGhM8ps7AF+FWPpq5PIfC0rhhxCa+onhR04Ab+jJfAla
         +Www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775861486; x=1776466286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSRTjy6wm25VHK2uTpX6ZsxoXvGmhSlH5xYLbZJnuyM=;
        b=eaF37HoQM/GOF8lopdPvTjQvYv4Wqoa3JFi5zgLxkHWvKnINBBPp/Nmpstbe2fSX+o
         MnL8PzSuU7r0bFvSzXpHblneHfHxuPr6FQI4+xsvh322fq8rtPeVgY5Yg5Eqmwn/8OCv
         NauoTiypE6EgPfZxXH3cCr6b2+8Iw2HAXs6mFfXdI1OnnCbs+4tU1t1/4OlDaqAXQ2KC
         xnEIVs83SfIB/2gyeaI3BQ4j6zSnJNQfpFDmtBYYZoqky483YexQIs5sRjJl59jLIh21
         GEw0G+QulK5Az/U6uXyQrP5IW33WxFV05uI99aNyF/t6hBDyD16RxKkpRm9C1xg3reoQ
         wDeA==
X-Gm-Message-State: AOJu0YxRgo8iOugO/awwZwQF6J+vV/2fvzW89HGk9ACwmnitj1FAFTpy
	wSbDuHlbrulNgouhLAd22XFK3wi6bdLZ3erRfeVjhOTq5onD/fsE2cQdMOVH7dHO
X-Gm-Gg: AeBDiesKlHWy7hmlBF2OrYLm7YqOkuK+wCZa4VRuW3FmwlLgeIL//R5ixaojATvKfK6
	2c9aj1HrHyzMuzFckJMykTZecdze7LBC4Vc6s1MbKjhtDewpWVklOMiP78oQFBqgFugjfaEGSWo
	CT9OlFWPexFyXgcFuWStAZ6Lf6kzzIr1MSkLfjXkEtpkPg0FnXk7fif0QYGEPOcI1ornPRSQ+0D
	WFIBEqoiSc28fnwcv3T8xWfDZbI8laDl3sYtzd1iDIeM5kgQ79IyvxhphuhbcGZFV3NtRuwp+GF
	jTwrkcXLEPGOMybhP1Rn1KLuXjVqzVZXKrT60zdmG41+5KZbY1tMRvbckKlTxsGOkmJ1jW5wum4
	3bKjSIi7PvdwpHT28hfVwbwZuf0nveKNs0C6GYY0e+hse/EQYwtbissBNxegpPEdgMT2Xl+7zmH
	Lkp7zVe30uEPrZW3TmZYF0
X-Received: by 2002:a05:600c:8585:b0:488:9bf8:7f17 with SMTP id 5b1f17b1804b1-488d684bcb0mr48381585e9.14.1775861485409;
        Fri, 10 Apr 2026 15:51:25 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:1c::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5347ea5sm118712345e9.8.2026.04.10.15.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 15:51:24 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: ast@fiberby.net,
	chuck.lever@oracle.com,
	davem@davemloft.net,
	donald.hunter@gmail.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	matttbe@kernel.org,
	pabeni@redhat.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next] net: shaper: Reject zero weight in shaper config
Date: Fri, 10 Apr 2026 15:51:23 -0700
Message-ID: <20260410225123.2341672-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277608-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fiberby.net,oracle.com,davemloft.net,gmail.com,google.com,kernel.org,vger.kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email]
X-Rspamd-Queue-Id: 1E8E43DD529
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A zero weight is meaningless for DWRR scheduling and can cause
starvation of the affected node. Add a min-value constraint to
the weight attribute in the net_shaper netlink spec so that zero
is rejected at the netlink policy level.

Found while prototyping a new driver, existing drivers are not
affected.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 Documentation/netlink/specs/net_shaper.yaml | 2 ++
 net/shaper/shaper_nl_gen.c                  | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/net_shaper.yaml b/Documentation/netlink/specs/net_shaper.yaml
index 3f2ad772b64b..7216568fcfc5 100644
--- a/Documentation/netlink/specs/net_shaper.yaml
+++ b/Documentation/netlink/specs/net_shaper.yaml
@@ -106,6 +106,8 @@ attribute-sets:
       -
         name: weight
         type: u32
+        checks:
+          min: 1
         doc: |
           Relative weight for round robin scheduling of the
           given shaper.
diff --git a/net/shaper/shaper_nl_gen.c b/net/shaper/shaper_nl_gen.c
index 9b29be3ef19a..0cad1a355350 100644
--- a/net/shaper/shaper_nl_gen.c
+++ b/net/shaper/shaper_nl_gen.c
@@ -20,7 +20,7 @@ const struct nla_policy net_shaper_handle_nl_policy[NET_SHAPER_A_HANDLE_ID + 1]
 const struct nla_policy net_shaper_leaf_info_nl_policy[NET_SHAPER_A_WEIGHT + 1] = {
 	[NET_SHAPER_A_HANDLE] = NLA_POLICY_NESTED(net_shaper_handle_nl_policy),
 	[NET_SHAPER_A_PRIORITY] = { .type = NLA_U32, },
-	[NET_SHAPER_A_WEIGHT] = { .type = NLA_U32, },
+	[NET_SHAPER_A_WEIGHT] = NLA_POLICY_MIN(NLA_U32, 1),
 };
 
 /* NET_SHAPER_CMD_GET - do */
@@ -43,7 +43,7 @@ static const struct nla_policy net_shaper_set_nl_policy[NET_SHAPER_A_IFINDEX + 1
 	[NET_SHAPER_A_BW_MAX] = { .type = NLA_UINT, },
 	[NET_SHAPER_A_BURST] = { .type = NLA_UINT, },
 	[NET_SHAPER_A_PRIORITY] = { .type = NLA_U32, },
-	[NET_SHAPER_A_WEIGHT] = { .type = NLA_U32, },
+	[NET_SHAPER_A_WEIGHT] = NLA_POLICY_MIN(NLA_U32, 1),
 };
 
 /* NET_SHAPER_CMD_DELETE - do */
@@ -62,7 +62,7 @@ static const struct nla_policy net_shaper_group_nl_policy[NET_SHAPER_A_LEAVES +
 	[NET_SHAPER_A_BW_MAX] = { .type = NLA_UINT, },
 	[NET_SHAPER_A_BURST] = { .type = NLA_UINT, },
 	[NET_SHAPER_A_PRIORITY] = { .type = NLA_U32, },
-	[NET_SHAPER_A_WEIGHT] = { .type = NLA_U32, },
+	[NET_SHAPER_A_WEIGHT] = NLA_POLICY_MIN(NLA_U32, 1),
 	[NET_SHAPER_A_LEAVES] = NLA_POLICY_NESTED(net_shaper_leaf_info_nl_policy),
 };
 
-- 
2.52.0


