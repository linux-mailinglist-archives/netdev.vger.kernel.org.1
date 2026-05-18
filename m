Return-Path: <netdev+bounces-289172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJWYHY11C2oZIAUAu9opvQ
	(envelope-from <netdev+bounces-289172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 22:24:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8244573572
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 22:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A2443041B86
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E777C3932E7;
	Mon, 18 May 2026 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hn7emI1/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0543932FD
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135861; cv=none; b=C4+vG5HijtidszUcLfQdKVg8M5BglVgewfNlWLBI1F8YqLwm9n3gS6mHbLru43jFN3W0kA74Gq4ghV+kVLyEI3qBqwJ5htes/rh5I9hV2kd/5rBdraJ+UchDtiLU17DaasJ5B3mFpn/Ce1jEwlZP2JsQn5iyGkO55A+kB51HHAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135861; c=relaxed/simple;
	bh=9tjHjYGhr+vyU+oWilJqhXrg1+pWKJQyL3LBk6cTRMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGwq5GgUlDGkvXdZ/lsphwlnyCSigTRSfdK2H4W76IECtPPQ3tv0dTl/rLSScLqekELlH7rK1QYYLPKF6S7bCm0+T5YKLipxz0UCQDNX4d4vMWgCA5fKFs7KKKoKxvgcXRpuKkJLeiJX35j2+El3uPZDbgnLOtGY50jLSeIEW5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hn7emI1/; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bd2e8931915so665495266b.1
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 13:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779135856; x=1779740656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvMIw0X9Leq+wUYzOHDJIrGcQXvsh1LVpCYc5JZJo/c=;
        b=Hn7emI1/q0JL9HQg/qNHZ8pHi1dNn5HAWtW9rEPQOqWYh6QWxThltEzbIv9+ZNQ99P
         9jTvxEgq87feNHl7FFCTGc7zot6ssaSBSbJPEvkphJLVCYzKNJebuTkFE8GgOsplFZE3
         bIbdVOEYp4JHO53nADkp4sDVk2KTcnTl8rGRretHZO48kdnvH5K7Ejtag9zZdZSRBVrw
         9mlpWPrD9naNSnZHFaAOHbACtx4ig/If/mro43nOwSLB+D0wvv1IRO3+3Ow4KHUDS0sv
         t7R8QOy1TvpMLhlU9ReKqfeUf4+7AeC7znN/mBlAXCAy/l8E97wPYjrjq654A2G+SXEQ
         DrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779135856; x=1779740656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MvMIw0X9Leq+wUYzOHDJIrGcQXvsh1LVpCYc5JZJo/c=;
        b=sbzFwbL4it2ME6FTQ6SX1N7/C+ngBWeMTCJiYbAW6IgrKaItQmz0z08P361hGDbDvM
         1xY3OXLsT0SA/iDWEX9aNM7f6alTHb01JQJQyNsGeGBiAMuP2Dq8PC5XHn1aGN0Wp5GT
         Cp+O5IMhUJoIppCjdu4Te7kyoZzQyueJxiIn7VUXyPZv+CqssxPlZS1iV7bpm6FtEiyW
         HsOU028yCzJvIX+bXWL9dSOdBD40R7TopXlhGZDE3qgfW5Xgcy9hkrm5dvtxo6O/6Rx2
         pkP9vonDmgLxnYT+GwAoyFFuOVP5rz1liuV/FMs0HsnwPVEP9QYbFGKfTTfGOFX90Zv0
         /Dcg==
X-Gm-Message-State: AOJu0YztaPc5QpU1PJHlp7u6KAilwEUgQqy9IeXZI5ID8wY/GiO0L+RJ
	/ixWRS2aTAV0sOWQkJp2T7FMAfuWPJsBFyQHhpziQwz1WdcbyShTguFNGt1q8zikMPw=
X-Gm-Gg: Acq92OHqLNsqhauKg+QyzdEbAgZJc3LSVxFZg/TwsRvUUhhHTGU6pqUs+zym1lSr5gG
	RDO6LPN6Qi14/1IjS/PYMI4cjWFdlQ0H7jPtVXzna0tAF4+YIOX8bCA8Ml+ET1L18ZxT3v0RXxv
	F41PDWkZQPqF5MZjAqS3yBk9v2C1bIwxr9bj543pSuFNCfCuBVO8U7YFEZ0vx4Rbik0Lcnef5wc
	Rvha5Oncl7uk1bmfPbGMRx9YXym/MzCmRQRrUwskFYMhzIqJDwjpqB0pcUhC5lvIgP9bV+1rjuy
	vGUWpVu+5k65bxKRbCetr+MlJl/fv5C9qOz1w2JLDkfW7ZGmdNgN7iZjFtUuYxhz93Q1ZfrZ7Y2
	lYtcEsLEb75u/onCotX8BSNbtFHxrigCHm22l87hn8DRxSdzCBDai89hjzfRxLVNqZLvvFhSt0b
	B0Nrk+ehnIGo+bieEvFCdv
X-Received: by 2002:a17:907:97d6:b0:bd3:329e:81e0 with SMTP id a640c23a62f3a-bd4f333f97amr1053543866b.9.1779135856093;
        Mon, 18 May 2026 13:24:16 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:46::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4ded6dfsm624118066b.39.2026.05.18.13.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 13:24:15 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexander.duyck@gmail.com,
	dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com
Subject: [iproute2-next V4 6/6] netshaper: Update man page for new parameters and group command
Date: Mon, 18 May 2026 13:23:53 -0700
Message-ID: <20260518202353.390827-7-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260518202353.390827-1-mohsin.bashr@gmail.com>
References: <20260518202353.390827-1-mohsin.bashr@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289172-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,networkplumber.org,redhat.com,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Queue-Id: E8244573572
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mohsin Bashir <hmohsin@meta.com>

Document bw-min, weight, and the group command in the netshaper
man page. Node id is required for set/show/delete but optional
for the group command. Leaves support optional per-queue weight
and priority parameters for scheduling within the group.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 man/man8/netshaper.8 | 150 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 129 insertions(+), 21 deletions(-)

diff --git a/man/man8/netshaper.8 b/man/man8/netshaper.8
index f5fe36cc..9d22999b 100644
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
@@ -37,6 +41,28 @@ netshaper \- show / manipulate network device hardware shaping configuration
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
+.RI "[ " "parent scope"
+.IR PARENT_SCOPE
+.RI "[ " id
+.IR PARENT_ID " ] ]"
+.RI "[ " bw-min
+.IR BW_MIN " ]"
+.RI "[ " bw-max
+.IR BW_MAX " ]"
+.RI "[ " weight
+.IR WEIGHT " ]"
+.B leaves
+.BI "{ scope queue id " ID
+.RI "[ " weight " WEIGHT ] [ " priority " PRIO ] } [ ... ]"
+
 .SH DESCRIPTION
 .B netshaper
 allows configuration and management of hardware rate limiting (shaping) capabilities
@@ -69,7 +95,11 @@ parameter is required and specifies the queue number.
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
 
@@ -77,16 +107,18 @@ parameter is required.
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
@@ -94,6 +126,15 @@ limits and device information.
 
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
@@ -115,21 +156,58 @@ or
 
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
+When omitted, the parent is inherited from the leaves' current
+parent, which requires all leaves to share the same parent.
+
+.TP
+.B leaves
+Specifies one or more leaf shapers to attach to the group. Each leaf
+is given as
+.BI "scope queue id " ID\fR,
+with optional
+.B weight
+and
+.B priority
+parameters for per-queue scheduling within the group.
+Multiple leaves can be specified in sequence.
+
 .SH OPTIONS
 
 .TP
@@ -156,17 +234,27 @@ Display usage information and exit.
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
@@ -175,9 +263,22 @@ Displays the current shaper configuration for the specified device and handle.
 .RE
 
 .TP
-.B Example 3: Delete shaper configuration
+.B Example 4: Create a scheduling hierarchy with group
 .nf
-# netshaper delete dev eth0 handle scope netdev
+# netshaper group dev foo handle scope node \e
+    parent scope netdev bw-max 10gbit \e
+    leaves scope queue id 0 weight 3 \e
+    scope queue id 1 weight 2
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
@@ -197,15 +298,20 @@ and
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
@@ -214,3 +320,5 @@ functionality will be added as requirements are identified.
 
 .SH AUTHOR
 Erni Sri Satya Vennela <ernis@linux.microsoft.com>
+.br
+Mohsin Bashir <hmohsin@meta.com>
-- 
2.53.0-Meta


