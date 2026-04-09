Return-Path: <netdev+bounces-277090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJOJN7Tm12n8UQgAu9opvQ
	(envelope-from <netdev+bounces-277090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 19:49:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 318BB3CE4C9
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 19:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE685301492C
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 17:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1D93CF039;
	Thu,  9 Apr 2026 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cI24ftv4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BB43B2FC0
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775756958; cv=none; b=GgUwIzYcGJsKcL1zxmN4BDNV+eQEPxUMBzXEPvzRkjNF3V6SqVCA329+7zCCrjiMqOmMvYa43VEqx1WD7mRr9/rSoypBu0dJSs2tx3yr0md5yqVZ23HT3kHkITbmk5FvoT9CKumLdN84BWP9iKRCWzn6hpYjVk8by4neJucqcYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775756958; c=relaxed/simple;
	bh=n8UC782heJc9nLqE4XafIFExJTAr+v3PqbB27s/DMpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oR+O8rQOeRnna59hrlcM6VbA898MKX5QU/4S7jfK/SExgMYt2dlbDPXw0iTj7TbVKGpmNCAavtLOHYc0iPH7mfhpc/GP0Aaevv1OdAHAw3AeMqXyFiwd6+x0cU+HlBfa2v7P4aogw35DVRcclbQ6arAVKGZimT2HmBttb1MLrHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cI24ftv4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82cdb4ab547so652819b3a.2
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 10:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775756956; x=1776361756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8mKYuAy6+k1yh1FJulOR+cbMMSykRFaR9tVDA+/KjQ=;
        b=cI24ftv4+k7Usf7EId6bsB+aBgTUuQLkOljNiL4+0ZJ5AI/p5nHi5MxUvVbreAYF0K
         gdI1SUZ58Ud4ST+lPzzmNJpSDFDkMw0hb9QropqgQ8XIAh3GroSlGbX+ODdohIA09wgl
         rfl6MmLvRk9BtZ9gE86YjlJ8+BNgoaB79lc1iwuM5lim4z4+1lzm3h5m8djpw1rFjpp3
         OfBAWSie1LxnveSkbU8JW3jmZshmhaM1Q3CK9qamN7dT7I/zo2zBNMK5Q9cb/lLP/4Lt
         bgSVUmgPNcpxr3mtwsZPjLs9Z0/1AOXvZ+XJF5o0v/rHz+y17Wu5Qq4P9w4HFAgQiUJI
         1SEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775756956; x=1776361756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c8mKYuAy6+k1yh1FJulOR+cbMMSykRFaR9tVDA+/KjQ=;
        b=o5qPAvF3mLmQtoPSOanL5xj1luGirchC/27HiK7hexbHR7muuzHJisiVQLYO9i0UkX
         /o0DqjSxsS/D8j4Svb/hIzZ8CMjy/bRr1TixWlUH+lNHmsYaWogN8aMxRbuyEjN0I9Cb
         XH0QRzpVr4ApYX1X7s3bwSMBiyR3vifNiBd9US9QP0zMUOHiZOH6jf+bcz0WV6dTYNzo
         iw1FYdkmqhN3EPlq5pnRwh58Cl8l1vrbXEmAdvIbWX3d21ymZRaMRLbxQEAaN1GZ6aeI
         LYdMFyGMoyZXeAw+nLvBBoA5HRCYxC9rHGqN+S+/gBJIghzIXCcUEs0Z11OkLAQHIITS
         CAgA==
X-Gm-Message-State: AOJu0YxYn4csGnDRH8lOuI32bfm56ZUwWCUHUIx6Mn94Yyd9M7MaI8os
	hCWIZbFNHiYrtYSvEyv39ieC6mz6kfrS2hx5yBayp5O5UHlXJKXD0LQTmy/h1sp1p+U=
X-Gm-Gg: AeBDietmKlc6P4LR6p98zWo5MT9hq/OQEg+S9zg8Ur25E10WbyVnAwKVNNrMKWOagP4
	petNYu0TJ80aXxA9BNrkzcAx+Q8qfHrovjFRIUgB3QFh85qsvCmdzsGM7m9P0NNNq17okXParfz
	mmjlxCiGdji0VrMjw3dQP+L0fxy342ugAqaKrearg61AsqYk+tNFHwoXdMpPT2NqL/iTI78G2Ug
	7vAIhuDPjXrQz05f2ydWdJ1Ga7sE+AdHLxrcyfrWOQBNyUO7hiclvr20NCRvwfcaCZn9AqN5BR0
	ZdlCDmAGjKhEq64MareqkR0RanYgZktou3rqv/Y1uXE7w5KNLco5E+DfM7ar9w2zqROWFw0d4U+
	qh70frAC52Zy0Cb7mroD8zes53ixZ4snm5xSqavxFebLHTXeDc/n6KHpcTpCXoDV8H1ssAeRanx
	liK1x67RuzYi5hYvjaHff8oT0GmEVoGII8FzfA
X-Received: by 2002:a05:6a00:3987:b0:82c:249d:d84f with SMTP id d2e1a72fcca58-82f0c38a1demr116982b3a.37.1775756956149;
        Thu, 09 Apr 2026 10:49:16 -0700 (PDT)
Received: from fedora ([2409:4061:4e14:5210:6a17:c456:bcba:6c11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c50d24bsm32725b3a.57.2026.04.09.10.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 10:49:15 -0700 (PDT)
From: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shubham Chakraborty <chakrabortyshubham66@gmail.com>
Subject: [PATCH v2] Documentation: sysctl: document net core sysctls
Date: Thu,  9 Apr 2026 23:18:59 +0530
Message-ID: <20260409174859.11854-1-chakrabortyshubham66@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407083213.27045-1-chakrabortyshubham66@gmail.com>
References: <20260407083213.27045-1-chakrabortyshubham66@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-277090-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chakrabortyshubham66@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 318BB3CE4C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Document missing net.core and net.unix sysctl entries in
admin-guide/sysctl/net.rst, and correct wording for defaults
that are derived from PAGE_SIZE, HZ, or CONFIG_MAX_SKB_FRAGS.

Also clarify that the RFS and flow-limit controls are only present
when CONFIG_RPS or CONFIG_NET_FLOW_LIMIT is enabled, and describe
rps_sock_flow_entries the way the handler implements it: non-zero
values are rounded up to the nearest power of two.

Signed-off-by: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
---
 Documentation/admin-guide/sysctl/net.rst | 66 +++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 3b2ad61995d4..05d301b8752c 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -210,7 +210,9 @@ Default: 0 (off)
 mem_pcpu_rsv
 ------------
 
-Per-cpu reserved forward alloc cache size in page units. Default 1MB per CPU.
+Per-cpu reserved forward alloc cache size in page units.
+
+Default: 1MB per CPU, expressed in page units
 
 bypass_prot_mem
 ---------------
@@ -238,6 +240,37 @@ rps_default_mask
 The default RPS CPU mask used on newly created network devices. An empty
 mask means RPS disabled by default.
 
+rps_sock_flow_entries
+---------------------
+
+The total number of entries in the RPS flow table. This is used by
+RFS (Receive Flow Steering) to track which CPU is currently processing
+a flow in userspace. Non-zero values are rounded up to the nearest
+power of two.
+Available only when ``CONFIG_RPS`` is enabled.
+
+Default: 0
+
+flow_limit_cpu_bitmap
+---------------------
+
+Bitmap of CPUs for which RPS flow limiting is enabled. Flow limiting
+prioritizes small flows during CPU contention by dropping packets
+from large flows slightly ahead of those from small flows.
+Available only when ``CONFIG_NET_FLOW_LIMIT`` is enabled.
+
+Default: 0 (disabled)
+
+flow_limit_table_len
+--------------------
+
+The number of buckets in the flow limit hashtable. This value is
+only consulted when a new table is allocated. Modifying it does
+not update active tables. This value should be a power of two.
+Available only when ``CONFIG_NET_FLOW_LIMIT`` is enabled.
+
+Default: 4096
+
 tstamp_allow_data
 -----------------
 Allow processes to receive tx timestamps looped together with the original
@@ -290,6 +323,8 @@ probed in a round-robin manner. Also, a polling cycle may not exceed
 netdev_budget_usecs microseconds, even if netdev_budget has not been
 exhausted.
 
+Default: 300
+
 netdev_budget_usecs
 ---------------------
 
@@ -297,12 +332,16 @@ Maximum number of microseconds in one NAPI polling cycle. Polling
 will exit when either netdev_budget_usecs have elapsed during the
 poll cycle or the number of packets processed reaches netdev_budget.
 
+Default: ``2 * USEC_PER_SEC / HZ`` (2000 when ``HZ`` is 1000)
+
 netdev_max_backlog
 ------------------
 
 Maximum number of packets, queued on the INPUT side, when the interface
 receives packets faster than kernel can process them.
 
+Default: 1000
+
 qdisc_max_burst
 ------------------
 
@@ -368,6 +407,15 @@ by the cpu which allocated them.
 
 Default: 128
 
+max_skb_frags
+-------------
+
+The maximum number of fragments allowed per skb (socket buffer).
+This is mostly used for performance tuning of GSO (Generic
+Segmentation Offload).
+
+Default: ``CONFIG_MAX_SKB_FRAGS`` (17 if not overridden)
+
 optmem_max
 ----------
 
@@ -377,6 +425,16 @@ optmem_max as a limit for its internal structures.
 
 Default : 128 KB
 
+somaxconn
+---------
+
+Limit of the socket listen() backlog, known in userspace as SOMAXCONN.
+The maximum number of established sockets waiting to be accepted by
+accept(). If the backlog is greater than this value, it will be
+silently truncated to this value.
+
+Default: 4096
+
 fb_tunnels_only_for_init_net
 ----------------------------
 
@@ -449,6 +507,8 @@ GRO has decided not to coalesce, it is placed on a per-NAPI list. This
 list is then passed to the stack when the number of segments reaches the
 gro_normal_batch limit.
 
+Default: 8
+
 high_order_alloc_disable
 ------------------------
 
@@ -465,9 +525,11 @@ Default: 0
 ----------------------------------------------------------
 
 There is only one file in this directory.
-unix_dgram_qlen limits the max number of datagrams queued in Unix domain
+max_dgram_qlen limits the max number of datagrams queued in Unix domain
 socket's buffer. It will not take effect unless PF_UNIX flag is specified.
 
+Default: 10
+
 
 3. /proc/sys/net/ipv4 - IPV4 settings
 -------------------------------------
-- 
2.53.0


