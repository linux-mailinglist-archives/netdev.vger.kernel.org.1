Return-Path: <netdev+bounces-290655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eICZE8TJD2r/PgYAu9opvQ
	(envelope-from <netdev+bounces-290655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 05:13:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A20FA5AE41A
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 05:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2D2E303276A
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 03:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644F23074A1;
	Fri, 22 May 2026 03:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVFvZ7aJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986A32F5321
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 03:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779419229; cv=none; b=Ys95bxpHFKWAM24BWMIsWe/izpk6waJYJ4HkMw+e3q/mKkh+d6xzaW6QZBACg+U7FrFXs4ID70zP10+Mmv1n8Qd2LuOnv+NqE/V7GNegl9vx2AfCrrNmcb4tAeh+gvx18rKmGg1JrP4G/YpElLRZ2mQR7SOEkah+8kz29911/fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779419229; c=relaxed/simple;
	bh=ZPRT7WYReHlyRoabDar/4Qp3izQr5FU0A+2mB4kb3Es=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQusBBUA1kt7mdF6KC54aiNHyEessnhg3HqqkKAcdmxl28MtplqnfD47TXw87sOQkoCEX1SnZ/JUSyxrksDwA23xlulLeMjX9WGBa0RcHBcGSP4GiH2yBD0sqanb7S5w2aADgdhBzMQ6FinWNTEKXQAm/C3V6FCLe3K3THUq5R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVFvZ7aJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso35430405e9.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 20:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779419226; x=1780024026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F9IqWwcf1e7tSXeOT69SWZeSr+qxhc7BFwsFBBA+nr8=;
        b=mVFvZ7aJj/qMRMVK5ZfiJZ5BTdac/hAQLOmxT23syljV5+vygnGQcYeApNrKmfOR30
         8bP6jszQZuN02890rsCkqtezHAs4MWaf0VfxKJk5e91EK6lRTU5f4feoZgHhrPdQV1Ip
         2DrL5BlNQGirXg1OrP2YGBdXGccztPxurmGPnVWJg/DxZhvT/AHzu77smMUeAXkyOIQX
         kP4jelX3QTtMJk5ShNdnX0hEJM55YE1JFphIk+BrSZ8rAnDjlFfBxkct+Wtkk6+IpJWa
         DrPioZW/Ecz0CQdvY5bjvYEkiRnxAfD2Bh4fYSNbMhCHKmrBV9Rqp1MFaDWQDqIr/DJK
         HXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779419226; x=1780024026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9IqWwcf1e7tSXeOT69SWZeSr+qxhc7BFwsFBBA+nr8=;
        b=ESY3qjOags2XiFDK3cbwl0IuPTf5L/FVeUbO3bpO9ZW6AnXnELdJZQViLdx1Wbfu+M
         7eMWuAgZkGWZJ/jApkwipS8AR4QtvE/duO8bogx6IaHKycT4SXoransflKq25Y85wnga
         7qxPfkawKMO+HUPMxIrtQNcyrn3rR2qGECxthHyv1sZAF6cQ5BpPXSOgLx9Pw8Hzhthl
         fbyvEzua7gD1rv8qoTCn0uRThu1AcnQB0oFR5aUk5iHeKKaqgmf/ADxVIh1H5inu5IlP
         8GNg+n80sgSKgwiRgVzVghq+gIUVV6zeo0vusQr+gbMsbrXNwpvh7N4i5TX7kOczI+Re
         49ZA==
X-Gm-Message-State: AOJu0YykXNRmLFw4/uNW8Ghzngc2an5jLrEJWIkHB7FCklRwUUr9F28Y
	9S+WJQKo6/LurQq6+ybN8dvGx7TuDbFV70fYF8DkE9kwfxFKtp76c/6iCZRSGGdeSy4=
X-Gm-Gg: Acq92OHbcV/7Lf58CkZt4omPC1hm44tFYUjqornxlRF/euzNClgCv09LQLatdGaQl6F
	joFrVekI3GRRmSaeQkZFVuYyjSle1jXiTcV9+KwHZti7Cf/gabsOzgtnHw/IWio9ycBFXS4/Uq6
	W4jBKDjPbDIRRRx9dej+mumjgRXCdBI+oXZaF4j+OiR0Hr2fHSA486GdUZ//iqgAW/2QbMFB1oT
	P3RSU12X83avwEePwq0SA2ttVwnxO1w06+0wskkBq+E3Vi1xI/ooxQLywCqCrPHap6cmfiiZmsk
	Nv4W0Yfq+hTk/4pOX+TWWp2G6W9muD7QCFaZcfzeLducmG7U8sxeXP3K7F2k94uHhdlnKh/cv57
	DLQaUEA1tl2Y83GI5MO9gWIe+qKnCdenB273/OPVx740qhb7vGZ5mdDmTBBm0oeS+F99cNEXZk9
	aeGH+b6WXrJ8eph/Li+DmF
X-Received: by 2002:a05:600c:3112:b0:490:40ee:d561 with SMTP id 5b1f17b1804b1-49042487e14mr16772015e9.7.1779419225701;
        Thu, 21 May 2026 20:07:05 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:33::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm536337f8f.25.2026.05.21.20.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 20:07:05 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexander.duyck@gmail.com,
	dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com
Subject: [iproute2-next] netshaper: Fix man page accuracy and formatting issues
Date: Thu, 21 May 2026 20:07:02 -0700
Message-ID: <20260522030702.2671992-1-mohsin.bashr@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,networkplumber.org,redhat.com,linux.microsoft.com];
	TAGGED_FROM(0.00)[bounces-290655-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Queue-Id: A20FA5AE41A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mohsin Bashir <hmohsin@meta.com>

This is a follow up to a previous patch that was merged before the
feedback was provided. See link below for previous patch series.
https://lore.kernel.org/netdev/20260518202353.390827-1-mohsin.bashr@gmail.com

Address the following concerns:

- Document that parent scope must be node or netdev; queue is
  rejected by parse_scope_id() but the man page did not state this.

- Document that parent scope node requires an id, while parent scope
  netdev may omit the id.

- Document that leaf scope must be queue; parse_leaves() enforces
  this but the man page only implied it by example.

- Replace "scheduling groups" with "intermediate scheduling nodes"
  for the node scope to avoid confusion with the group command name.

- Show group handle scope choices explicitly in the synopsis as
  { node | netdev } instead of an unrestricted HANDLE_SCOPE token.

- Replace unusual { } repeat-group notation for leaves with a
  separate LEAF_SPEC definition using standard [ SPEC ... ] syntax.

- Use .B/.RB for literal keywords (bw-min, bw-max, weight, id,
  parent, leaves) and .I for metavariables, matching iproute2
  man page conventions.

- Clarify example 4 so the 10 Gbit/s cap clearly applies to the
  node, not the netdev parent.

- Update .TH date.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 man/man8/netshaper.8 | 94 +++++++++++++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 36 deletions(-)

diff --git a/man/man8/netshaper.8 b/man/man8/netshaper.8
index 9d22999b..020fbaa6 100644
--- a/man/man8/netshaper.8
+++ b/man/man8/netshaper.8
@@ -1,4 +1,4 @@
-.TH NETSHAPER 8 "7 Oct 2025" "iproute2" "Linux"
+.TH NETSHAPER 8 "19 May 2026" "iproute2" "Linux"
 .SH NAME
 netshaper \- show / manipulate network device hardware shaping configuration
 .SH SYNOPSIS
@@ -20,48 +20,57 @@ netshaper \- show / manipulate network device hardware shaping configuration
 .ti -8
 .B "netshaper set"
 .B dev
-.IR DEV
+.I DEV
 .B handle scope
-.IR HANDLE_SCOPE
-.RI "[ " id
+.I HANDLE_SCOPE
+.RB "[ " id
 .IR HANDLE_ID " ]"
-.RI "[ " bw-min
+.RB "[ " bw-min
 .IR BW_MIN " ]"
-.RI "[ " bw-max
+.RB "[ " bw-max
 .IR BW_MAX " ]"
-.RI "[ " weight
+.RB "[ " weight
 .IR WEIGHT " ]"
 
 .ti -8
 .B "netshaper" " { " show " | " delete " }"
 .B dev
-.IR DEV
+.I DEV
 .B handle scope
-.IR HANDLE_SCOPE
-.RI "[ " id
+.I HANDLE_SCOPE
+.RB "[ " id
 .IR HANDLE_ID " ]"
 
 .ti -8
 .B "netshaper group"
 .B dev
-.IR DEV
+.I DEV
 .B handle scope
-.IR HANDLE_SCOPE
-.RI "[ " id
+.RB "{ " node " | " netdev " }"
+.RB "[ " id
 .IR HANDLE_ID " ]"
-.RI "[ " "parent scope"
-.IR PARENT_SCOPE
-.RI "[ " id
-.IR PARENT_ID " ] ]"
-.RI "[ " bw-min
+.RB "[ " "parent scope" " { " "netdev" " [ " id
+.IR PARENT_ID " ] | "
+.BR node " " id
+.IR PARENT_ID " } ]"
+.RB "[ " bw-min
 .IR BW_MIN " ]"
-.RI "[ " bw-max
+.RB "[ " bw-max
 .IR BW_MAX " ]"
-.RI "[ " weight
+.RB "[ " weight
 .IR WEIGHT " ]"
 .B leaves
-.BI "{ scope queue id " ID
-.RI "[ " weight " WEIGHT ] [ " priority " PRIO ] } [ ... ]"
+.IR LEAF_SPEC " [ " LEAF_SPEC " ... ]"
+.sp
+.in +4
+.IR LEAF_SPEC " := "
+.B "scope queue id"
+.I ID
+.RB "[ " weight
+.IR WEIGHT " ]"
+.RB "[ " priority
+.IR PRIO " ]"
+.in -4
 
 .SH DESCRIPTION
 .B netshaper
@@ -92,7 +101,7 @@ parameter is required and specifies the queue number.
 
 .TP
 .B node
-Shapers representing scheduling groups that can be placed at arbitrary
+Intermediate scheduling nodes that can be placed at arbitrary
 locations in the scheduling tree. The
 .I id
 parameter is required for
@@ -130,10 +139,10 @@ Removes the specified shaper configuration from the device.
 .B netshaper group
 - Create a scheduling hierarchy
 
-Creates a scheduling group by binding one or more leaf shapers to a parent
-node in a single operation. The command specifies the group node's handle,
-its parent, optional bandwidth and weight parameters, and the set of leaf
-shapers to attach.
+Creates a scheduling group by binding one or more queue leaf shapers to a
+netdev or node handle in a single operation. The command specifies the
+target handle, its parent, optional bandwidth and weight parameters, and
+the set of queue leaves to attach.
 
 .SH PARAMETERS
 
@@ -187,19 +196,31 @@ siblings under the same parent node. Value is an unsigned integer.
 
 .TP
 .B parent
-Defines the parent node for the
+Defines the parent for the
 .B group
-command. Uses the same
-.BI scope " / " id
-syntax as
-.BR handle .
+command. The parent scope must be
+.B node
+or
+.BR netdev ;
+.B queue
+is not valid as a parent scope.
+For parent scope
+.BR node ,
+.I id
+is required. For parent scope
+.BR netdev ,
+.I id
+is optional.
 When omitted, the parent is inherited from the leaves' current
 parent, which requires all leaves to share the same parent.
 
 .TP
 .B leaves
 Specifies one or more leaf shapers to attach to the group. Each leaf
-is given as
+must use scope
+.BR queue ;
+no other scope is accepted for leaves.
+Each leaf is given as
 .BI "scope queue id " ID\fR,
 with optional
 .B weight
@@ -271,8 +292,8 @@ Displays the current shaper configuration for the specified device and handle.
     scope queue id 1 weight 2
 .fi
 .RS
-Creates a node shaper under the netdev parent with a 10 Gbit/s cap,
-grouping queues 0 and 1 as leaves.
+Creates a node shaper under the netdev parent, grouping queues 0 and 1
+as leaves. The 10 Gbit/s cap applies to the node itself.
 .RE
 
 .TP
@@ -311,7 +332,8 @@ Bandwidth values support standard suffixes:
 .IP \(bu
 The
 .B group
-command creates a node and attaches leaves in a single atomic operation.
+command attaches queue leaves to a netdev or node handle in a single
+atomic operation.
 
 .SH SEE ALSO
 .BR ip (8),
-- 
2.53.0-Meta


