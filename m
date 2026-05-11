Return-Path: <netdev+bounces-286798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK/aBr8iAmocoAEAu9opvQ
	(envelope-from <netdev+bounces-286798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:41:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C96C5148E8
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 082693039CB5
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560254ADDAC;
	Mon, 11 May 2026 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPNv6VhT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7759A4ADDA2
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778524782; cv=none; b=FfnZHUqm3x+AG4dlKu2fEOkCjFFv7KN77ldrs7WCOgd3/q0bbd9QKGu4Eq6lWdUMyjRc8S5C+lEYn5GRXUcYR81wP+FzH95PBEdPdhbFI8F/YjJr6rLFKW0ohdR6I2FGDHjqD3z0WTVb/O3A//OQ03hZHp7mVdoHEGezrdLU0og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778524782; c=relaxed/simple;
	bh=yw/+itPOgPK4zHXh7d3cAsufxHTINSAIpKYrUJMqVXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cklAoDQUOfurcILlblt9ygnrxxFcxiZqlsqtljhu/S8R97aBTKuwInbas+VxBnOp9qvfe1jHG5q3kJ/df9dDFJ8uR/jMWhmIn+s1ysVDsOhTjrIfXbWdxtrbZjRBJIFeeBeuAEuhYK0IgJ/uzEDTzHoJzj/pEdC5WBRjlANS/cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPNv6VhT; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-448528f4e69so2784937f8f.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 11:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778524772; x=1779129572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKLgzX4GZvN/7HGKakAqCzqafM2f8oqG9OQE/kJouxk=;
        b=fPNv6VhTiyio94ezwxHprpO8Rl7RwC9u4Huy1SU2eS3JT+ImVZ5QeIm0YeZhfHDhGh
         9mDoh0r0r4K3XYJTUInGv1qBD3hXDfgqQcmx6NNOF/7DRhzGZ8q4o/bm3Q2I5jy5U4Hf
         v0m/nNa7M4egDT2jdgSzbI+5+MYmBQ1jWrVzb5nL5tUxi4gtM3ISgfmydZU7F8VKHkYL
         a7aKHsw+iCFD+KD9BMWe+Ogetsr9iCU6Cy9tvXsMGQqF6fq80yIkNiJScRsj5KnKgqYM
         Y4E03O4fJ8XxZhOdpAUCTG7L+fln0oHnQbMFtjoDVkWbf5tN45HaqDHAf0vWPDuPa9dC
         vX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778524772; x=1779129572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RKLgzX4GZvN/7HGKakAqCzqafM2f8oqG9OQE/kJouxk=;
        b=DisoN1HOXexnG+Xc75E416Mn0zzOpNkT2C8cdQ8tr7BPxFxw+OD43ETxqcixlj8RK5
         mvU/Ue6jxso6YuneY6i1KjbTUYuwyxu5d1b3g4oLIC9+p4RfmIZAQy1wRbFAyG2C+tvw
         Obok/GWHb3qIwTOTTO1FYYtr+h+cTfPPaJQUBJVpkhoK3vPrYpqfapO0Ev7TCrnW+P4k
         i0HjqqlXhu/0Ir9eyKXdLgl+8ZGSVGDy8NbEM/Mkm3vkXgCfEZBN+drBBhrMSfOOv351
         FtFc/Z3ZkEgpQXcYVuO2VVB/whIP2vUkTCeY7rWNJueD0hRl+t7uxLSzQPeArBHC/WSd
         rsbg==
X-Gm-Message-State: AOJu0YzBms6svjAVb84H/iFbVWVfEQvmHNbRPr7DqmKLvIbuM2j/3a2b
	xI/5OJwN0JP9EaTD+80Q4TMOEttcsZVIWdg51lPlKPJwXxRdXtOvrdGNp2obGA3w
X-Gm-Gg: Acq92OHxeUo5t5EdTXxhi5Wxbh1hnExrWaVgeBkwM0b1ZBs0PLjB0EvU3biRieEiVSP
	wDj/f1VOFOlml9TV0Zb2PANJIfFszHZ5xTQR97qDSdqp5yT8RSam60U278kGofE5fMbJ9netOxM
	/PmKzKaa46Fb/6kr9peFEBkdKsgciyvuNOjDBcsie/3nFWTYPFJrhiVNN3XqEq+rsQwrZD3a4mj
	jWQVmH3G32IkRs9fcAXlte8WL0kzsyz/N3ikkm8vRS/urdTZyA/vZb6WEj3mpzfrksdp12qGHGA
	qBC/CFgaXeq2Ft5DxVij7sidAwx6cDrVgYrnSv6VB+kxZIU4ZuBtvjqePWjddBn3cxZZTQOiTKp
	sE35XE4LHJesAp855j/knHhvVbv/h0QFOuVNkrHOp4AKSx5B/GRpIUSckYvSmd9ShpcB+lF3arO
	4wW7tnIL/9DRzj+MacKs2A
X-Received: by 2002:a05:6000:40ca:b0:449:d189:e79f with SMTP id ffacd0b85a97d-4546310a2fdmr24555080f8f.32.1778524772157;
        Mon, 11 May 2026 11:39:32 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:1c::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a6a64sm28524095f8f.6.2026.05.11.11.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:39:31 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com,
	alexanderduyck@gmail.com,
	Claude Assistant <noreply@anthropic.com>
Subject: [PATCH iproute2-next v3 6/6] netshaper: Update man page for new parameters and group command
Date: Mon, 11 May 2026 11:39:15 -0700
Message-ID: <20260511183915.797792-7-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260511183915.797792-1-mohsin.bashr@gmail.com>
References: <20260511183915.797792-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7C96C5148E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-286798-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,redhat.com,linux.microsoft.com,gmail.com,anthropic.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anthropic.com:email,meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Mohsin Bashir <hmohsin@meta.com>

Document bw-min, weight, and the group command in the netshaper
man page. Node id is required for set/show/delete but optional
for the group command. Leaves are documented as queue-only.

Reviewed-by: Claude Assistant <noreply@anthropic.com>
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


