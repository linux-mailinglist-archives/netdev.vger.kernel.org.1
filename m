Return-Path: <netdev+bounces-286091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKx2A2+b/mkMtwAAu9opvQ
	(envelope-from <netdev+bounces-286091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 04:26:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A784FDA0D
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 04:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A211301690C
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 02:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CE928642B;
	Sat,  9 May 2026 02:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOgOCFLQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048C626CE05
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 02:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778293461; cv=none; b=HrrbjPz5t9KZHdIsH2vc09p3fiIL+kE+AjaQVWERtNwIqORM3+C6ZaAHWzp1KbiK7/1ZRBaXfwJm2p6BSXjV/35qFQi064+7DEyW0OVVKjfAZNLlSw8CtiVGH8Ppygj55b9qpXffqXDSuMUvw9bjXjqIEAaK3dbpBJa4DtZCIbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778293461; c=relaxed/simple;
	bh=DwmWjoAyyW49gd6f2hUanQXi+7c5YLbSsuN25PolLEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaB/uFQMuBT+l/IzxidOTfEwK+sfaeNynIyPXhj6jKfBwkiJDh6p9eOsRA0N0Fa28NvMA/5TNjle3/CIc2TljY/Jp9zCy9o/5OfFVVU2nV8CgSbg3rT09F7JUwqzgORA+5mUl33Mnr32fd8ILmpaxhe8Y8PUCM0Q7qI877WOXn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOgOCFLQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d75312379so2347943f8f.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 19:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778293458; x=1778898258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJ/5YEDZxLNWqRgEEoidkDgyQRq1c7Os5nVIDy+QDgs=;
        b=JOgOCFLQ0/Q6AzwTxgh91D4BytEt8KblAsHaNA5wqofEi6KTuQOsZ1J3kPnU7MFvz0
         lq5sGcQtn/mazFtgcIJWN71Nid82jjiAi3Pkl5NTWdWnFMJxKQ1/AAwsF/fpu6euKY0t
         NxtNMkeLypMOC7VwqVECKzXIIsm25wDCvM1gf9rJR7j8mkWlJApLZlwqNZMyew+5FAaZ
         opwlRtezfuVysSmczA47fEao+cawcU4ueO3oAUTcWz+TCbdZxhD5dzvyMapNm90Cakz+
         F8o7R13vCQUep6urXLPawmBwo6I/UPCJctxQo3mhzz6tYUy2rWSHXWF3h1OZ+HnzqJXm
         RHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778293458; x=1778898258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vJ/5YEDZxLNWqRgEEoidkDgyQRq1c7Os5nVIDy+QDgs=;
        b=aJBNoDuu2V+tLZHjWNYEG4p6uvMDHmXT/CXxVNGvKldu1cFCPK7hx0Qwr0EVGVK4U1
         3HHsH0lPnAncligssFnO4OlsSb8dj2lOyQskxhjVl6rkFA8+7xQHN/kMehUAHqc2XDqR
         AhCBXMcrakTct/JTEj0wfXle2K2urAV2HoAP+7j4rueMSbxo1GUHfFpB+5xGixhiiRAU
         LRh33MjCzuu7DFA71jv0p+akVhO3JwdD0hJosmUNd2KkKV+64G7d+vId0ELXue5C5Gjt
         GXbYu1+QnDHwnEKbge7IEA80utt78yTL+CTqh4nFqmGeB2Gch4Q7aRPD8V9YZpJ4+QEa
         POyg==
X-Gm-Message-State: AOJu0Yzz0mq94i1qVwhgKZOYytw4KG8t58YOCK3D6Vjw1FfzhQrpZFyO
	6lRMVALLWhgQB6C1cgK1pjNNHHqusi9H15XtSJnFTNyiRnq5l2EBYU5o/46fAF23
X-Gm-Gg: AeBDievBlxutayu1RuOUq6YNATs5y752fJloXGnYWXGdoHtBkzsPvjAkDuQm3UIuV9q
	Dhebnt1PTc2vc1HlOrpulRU49gZtG2Qb176DE4qHpIuBsQ5yUpTzkCp4v2+iNLYc0WcPW5Fz6Zy
	zvtP5/Qpn5APkdmeC/w104BHdugziiCuRAbUFGyg960PxZC2Em7uagfgbmb/mGUikSzT6PNI4TH
	2G/8qLJgROCwtIqsrOEHu9N4c9M+sa1Lk0vtYSt1xLYlq8CTb+2VKDHdA/ay2kXh+L3PAZNDdDk
	XgkOfB1Pm5yyiasSrqg8Tbv08DVrItGNvCM4ru3odaxhKD6OrNEOIVY2ncQoqbeiVctaz76ZLlp
	5QYduFkQNUDZ77K/B7vvxin0AzMqnZRYYyy169k5IeHWF5ue/hEZL1O4Wj0lURgaXWbdWltW6lx
	QLuast6NTwLiACEkldzDib
X-Received: by 2002:a05:600c:444f:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-48e5dfd6a6amr140367255e9.6.1778293457863;
        Fri, 08 May 2026 19:24:17 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:2f::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6fffba52sm16155585e9.3.2026.05.08.19.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:24:17 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com
Subject: [PATCH iproute2-next v2 6/6] netshaper: Update man page for new parameters and group command
Date: Fri,  8 May 2026 19:23:53 -0700
Message-ID: <20260509022353.3470738-7-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260509022353.3470738-1-mohsin.bashr@gmail.com>
References: <20260509022353.3470738-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 75A784FDA0D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-286091-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,redhat.com,linux.microsoft.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Mohsin Bashir <hmohsin@meta.com>

Document bw-min, weight, and the group command in the netshaper
man page. Node id is required for set/show/delete but optional
for the group command. Leaves are documented as queue-only.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 man/man8/netshaper.8 | 140 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 119 insertions(+), 21 deletions(-)

diff --git a/man/man8/netshaper.8 b/man/man8/netshaper.8
index f5fe36cc..ed4f77fc 100644
--- a/man/man8/netshaper.8
+++ b/man/man8/netshaper.8
@@ -25,8 +25,12 @@ netshaper \- show / manipulate network device hardware shaping configuration
 .IR HANDLE_SCOPE
 .RI "[ " id
 .IR HANDLE_ID " ]"
-.B bw-max
-.IR BW_MAX
+.RI "[ " bw-min
+.IR BW_MIN " ]"
+.RI "[ " bw-max
+.IR BW_MAX " ]"
+.RI "[ " weight
+.IR WEIGHT " ]"
 
 .ti -8
 .B "netshaper" " { " show " | " delete " }"
@@ -37,6 +41,27 @@ netshaper \- show / manipulate network device hardware shaping configuration
 .RI "[ " id
 .IR HANDLE_ID " ]"
 
+.ti -8
+.B "netshaper group"
+.B dev
+.IR DEV
+.B handle scope
+.IR HANDLE_SCOPE
+.RI "[ " id
+.IR HANDLE_ID " ]"
+.B parent scope
+.IR PARENT_SCOPE
+.RI "[ " id
+.IR PARENT_ID " ]"
+.RI "[ " bw-min
+.IR BW_MIN " ]"
+.RI "[ " bw-max
+.IR BW_MAX " ]"
+.RI "[ " weight
+.IR WEIGHT " ]"
+.B leaves
+.BI "{ scope " SCOPE " id " ID " } [ ... ]"
+
 .SH DESCRIPTION
 .B netshaper
 allows configuration and management of hardware rate limiting (shaping) capabilities
@@ -69,7 +94,11 @@ parameter is required and specifies the queue number.
 Shapers representing scheduling groups that can be placed at arbitrary
 locations in the scheduling tree. The
 .I id
-parameter is required.
+parameter is required for
+.BR set ", " show ", and " delete
+commands. For the
+.B group
+command it is optional; if omitted, the kernel auto-assigns one.
 
 .SH COMMANDS
 
@@ -77,16 +106,18 @@ parameter is required.
 .B netshaper set
 - Create or update a shaper configuration
 
-Creates or updates a shaper with the specified parameters. The
+Creates or updates a shaper with the specified parameters. At least one of
+.BR bw-min ", " bw-max ", or " weight
+must be provided. The
 .I id
-parameter is optional for netdev scope but required for all other scopes.
+parameter is required for queue and node scopes and optional for netdev scope.
 
 .SS
 .B netshaper show
 - Display shaper information
 
 Shows the current configuration of the specified shaper, including bandwidth
-limits and device information.
+limits, weight, and parent information.
 
 .SS
 .B netshaper delete
@@ -94,6 +125,15 @@ limits and device information.
 
 Removes the specified shaper configuration from the device.
 
+.SS
+.B netshaper group
+- Create a scheduling hierarchy
+
+Creates a scheduling group by binding one or more leaf shapers to a parent
+node in a single operation. The command specifies the group node's handle,
+its parent, optional bandwidth and weight parameters, and the set of leaf
+shapers to attach.
+
 .SH PARAMETERS
 
 .TP
@@ -115,21 +155,51 @@ or
 
 .TP
 .BI id " HANDLE_ID"
-Numeric identifier for the shaper. Optional for
-.B netdev
-scope (defaults to 0), required for
+Numeric identifier for the shaper. Required for
 .B queue
 and
 .B node
-scopes.
+scopes. Optional for
+.B netdev
+scope (defaults to 0). For the
+.B group
+command, node
+.I id
+may be omitted to let the kernel auto-assign one.
 .RE
 
 .TP
-.BI bw-max " BW_MAX"
-Maximum bandwidth limit for the shaper. Accepts values with suffixes:
+.BI bw-min " BW_MIN"
+Minimum guaranteed bandwidth for the shaper. Accepts values with suffixes:
 .BR kbit ", " mbit ", " gbit
 for kilobits, megabits, and gigabits per second respectively.
 
+.TP
+.BI bw-max " BW_MAX"
+Maximum bandwidth limit for the shaper. Accepts the same suffixes as
+.BR bw-min .
+
+.TP
+.BI weight " WEIGHT"
+Scheduling weight for the shaper, used for weighted fair sharing among
+siblings under the same parent node. Value is an unsigned integer.
+
+.TP
+.B parent
+Defines the parent node for the
+.B group
+command. Uses the same
+.BI scope " / " id
+syntax as
+.BR handle .
+
+.TP
+.B leaves
+Specifies one or more leaf shapers to attach to the group. Each leaf
+is given as
+.BI "scope " SCOPE " id " ID\fR.
+Multiple leaves can be specified in sequence.
+
 .SH OPTIONS
 
 .TP
@@ -156,17 +226,27 @@ Display usage information and exit.
 .SH EXAMPLES
 
 .TP
-.B Example 1: Create a device-level shaper (ID optional)
+.B Example 1: Create a device-level shaper
 .nf
 # netshaper set dev foo handle scope netdev bw-max 10gbit
 .fi
 .RS
-Creates a netdev-scoped shaper with default id 0 and sets the maximum
-bandwidth to 10 gigabits per second.
+Creates a netdev-scoped shaper with maximum bandwidth of 10 Gbit/s.
 .RE
 
 .TP
-.B Example 2: Show shaper configuration
+.B Example 2: Set bandwidth and weight on a queue shaper
+.nf
+# netshaper set dev foo handle scope queue id 0 \e
+    bw-min 1gbit bw-max 5gbit weight 10
+.fi
+.RS
+Creates a queue-scoped shaper on queue 0 with minimum/maximum bandwidth
+limits and a scheduling weight.
+.RE
+
+.TP
+.B Example 3: Show shaper configuration
 .nf
 # netshaper show dev foo handle scope netdev
 .fi
@@ -175,9 +255,20 @@ Displays the current shaper configuration for the specified device and handle.
 .RE
 
 .TP
-.B Example 3: Delete shaper configuration
+.B Example 4: Create a scheduling hierarchy with group
 .nf
-# netshaper delete dev eth0 handle scope netdev
+# netshaper group dev foo handle scope node parent scope netdev \e
+    bw-max 10gbit leaves scope queue id 0 scope queue id 1
+.fi
+.RS
+Creates a node shaper under the netdev parent with a 10 Gbit/s cap,
+grouping queues 0 and 1 as leaves.
+.RE
+
+.TP
+.B Example 5: Delete shaper configuration
+.nf
+# netshaper delete dev foo handle scope netdev
 .fi
 .RS
 Removes the specified shaper configuration.
@@ -197,15 +288,20 @@ and
 .B node
 scopes, the
 .I id
-parameter is required.
+parameter is required. For the
+.B group
+command, node
+.I id
+may be omitted to let the kernel auto-assign one.
 .IP \(bu
 Bandwidth values support standard suffixes:
 .BR kbit " (kilobits per second), "
 .BR mbit " (megabits per second), "
 .BR gbit " (gigabits per second)."
 .IP \(bu
-This command currently supports basic shaper operations. Additional
-functionality will be added as requirements are identified.
+The
+.B group
+command creates a node and attaches leaves in a single atomic operation.
 
 .SH SEE ALSO
 .BR ip (8),
@@ -214,3 +310,5 @@ functionality will be added as requirements are identified.
 
 .SH AUTHOR
 Erni Sri Satya Vennela <ernis@linux.microsoft.com>
+.br
+Mohsin Bashir <hmohsin@meta.com>
-- 
2.53.0-Meta


