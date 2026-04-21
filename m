Return-Path: <netdev+bounces-280068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNY9CwVL52l/6QEAu9opvQ
	(envelope-from <netdev+bounces-280068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 12:01:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C95A543941D
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 12:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A771F306775B
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 09:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693203B2FDA;
	Tue, 21 Apr 2026 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7CNrryI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3147E337BB8
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765413; cv=none; b=mY2dFJkkTBmX0wRg59GllproDMg46Kk3EC5oU/cBc+ov90BR0vmmwoL7RFY6I8U5IA55QRl54RujJO9vTMTrtk8eYJ8T1DOuQ2PivJvdGMxNiClGnoG9wNXMQ9UcVUGcomiNvLOojl6itRTvRplZFUNxfAnr1BU6yR8KEIDdA98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765413; c=relaxed/simple;
	bh=3BUnvxyuGd1DgomwnEK0E0FhgwItQGQvkyS6mj6Ii+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WD3QaVWY2yoetK+KE/i5QBg6uj41qVC+F0IuaV9Cdp1kUsVxE+DcT9Zygx7YoE7mvOW1oExt2oKXzdIPMoyn4ObZHm6oVGie+K0vqK3vanO7RM/pspMA8/+G7Id+PbJGNYDYWAt7opuVPX2VHZsHofw8AvuWReXjYw4c0w5n/t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7CNrryI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2aaed195901so17458645ad.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 02:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776765410; x=1777370210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qKZpSpV9EOuGvsbHlyyvc1vofUH1wihyDABD3Zf9nCg=;
        b=E7CNrryI7Q+OVjxIizYvVneAk0cxrMrwqOLK5sfHaMqya0cznEMcnKOdUT1kRTzg/W
         eEBuYksqNyU1/0jfZSZdnRK+F/ouHb7VlpDtUCNPeo10a1wAob+/14RSwFTcTW4Zexv/
         rCpWuaLM9eixmEq6F5FXaA/6hh3N/gmfijDEZbabb2ZZbRPevSF9pW4Sud9gWR5d8Okg
         3nEx/qMLnDXjGtU8EX5yYUpLQvh/LeX85NodfN48f9tzZeiNsphV0/j2ye2BnmVWhRtL
         tkXd5/RjxbMH06//mAbvgkh3JRyzwmHnjJGilGguuzd0HoNEP2XPzhnwzuI87Wscx7DM
         WY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776765410; x=1777370210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKZpSpV9EOuGvsbHlyyvc1vofUH1wihyDABD3Zf9nCg=;
        b=Rfjj35VVih7dkL0BCwrhjg0uIIKZbnVioh+/CLD1JrMVNbq2Qy6WDgcorDkw+1mhBY
         VgCOl9KDXhT7M2r1dcNpn4GiKQTFNpN1xfJzMI5MerfvEaKMJRmAgNMWY1XHK0cV8hEV
         cisGfjkIkoCMYQyI+DQDvqUrSSm2InsHql8jWiBVHdzURu2spDhxptUdP22VFs8LcS7c
         +I+6F0ODudQSOHneVEtLVc/3fU7l+bN9smZTrjse2m+En09OKOeKnehCTxlnTY9Pcwla
         iFLBw8CKF0S7yVec6mTeOVKxoJnikqvThGEAuHZAbDorbFQLTLedXD16p4SCn7XwYhMU
         TI+Q==
X-Forwarded-Encrypted: i=1; AFNElJ9NK7+oV7qWHwWZmo/cFSnYEZuha3hVAS45U7SBd4li6lksA9ASvp75ZZRZ5iLCbLqQLrKTj2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrTyAt4AawtX4hKH1FH2RwK60P2JcHDpz+fPtXZoq4evIFtTDH
	zW9ROmxjE6s9Tybq3u6V5l5whd/oxEyZKyk3WRzXgeSM9Ax2g8AQRW42
X-Gm-Gg: AeBDievLFV6qacEdtdPqGttpiA4GaRo4FK8KMAE1yBE+bqja8FuapYJx8z1/DOclLJ3
	crHM78Mo2lxA6rPmVfc37McnlSGhG6HSLB4UI3NXmKzSN5xX2w0XZ03UddwLWst532I6TbexvOT
	tfHFNMTD/pCGWSrsZdXAzLMxk++Gkbu9NSKvNtt6Ga3N0Ox3bbojCMZdTkBzWQ9cJOwl5tTNpQa
	59vc8dynTm8eGzPC/RSNg9IsF2UwsIE7Q6Eyty6sJJkY+w8hlRQ9z/sxeqgT3OR2Ed+AfYTpWSm
	9wJx2B8mrAwSbjiGJF/y2fzmB8JwKca3o0Gf+VGQOZtT9My2LjJJ5zcv65jwYVDFKoMkKR8DEmW
	UDw3quVC0vzmsYOR3GC8BQbfn55VmkKAdQvibnfXVMOZ98WaqRVgcChYybPM26Z3xLZC5M8sO8O
	w4VYdI8nHG/U2C0xVXD5u9VMrX8acPNCFHZvo3Ne5/0w==
X-Received: by 2002:a17:902:9044:b0:2ae:d09c:5241 with SMTP id d9443c01a7336-2b5f9e7a9b6mr126550535ad.2.1776765410430;
        Tue, 21 Apr 2026 02:56:50 -0700 (PDT)
Received: from localhost ([223.185.43.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa32ad8sm134467025ad.31.2026.04.21.02.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 02:56:49 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
X-Google-Original-From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: matttbe@kernel.org,
	martineau@kernel.org
Cc: geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	janak@mpiric.us,
	kalpan.jani@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH] mptcp: add per-reason MIB counters for MPTCP_RST_EMPTCP resets
Date: Tue, 21 Apr 2026 15:26:46 +0530
Message-Id: <20260421095646.3741956-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280068-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.linux.dev,mpiric.us,mpiricsoftware.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.234.253.10:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardulsb08@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C95A543941D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

MPTCP_RST_EMPTCP (reset reason 1) is used as a catch-all for seven
distinct error conditions across subflow setup, authentication, and
data path validation.  The existing MPRstTx/MPRstRx counters only
track aggregate reset volume, making it difficult to diagnose which
code path is triggering subflow resets in production.

Add per-reason MIB counters for each MPTCP_RST_EMPTCP use site:

  MPRstMD5SIG         - MD5SIG on listener, incompatible with MPTCP
  MPRstNoToken        - JOIN token lookup failed, no matching conn
  MPRstNoMPJ          - SYN/ACK missing MP_JOIN option
  MPRstHMAC           - HMAC validation failed during subflow join
  MPRstFatalFallback  - fatal fallback during child socket creation
  MPRstBadMap         - invalid data mapping on established subflow
  MPRstNotEstablished - JOIN on not-fully-established msk

These counters are incremented alongside the existing reset_reason
assignment and are visible via nstat as MPTcpExtMPRst*.  The
aggregate MPRstTx/MPRstRx counters remain unchanged.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/511
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/mib.c      |  7 +++++++
 net/mptcp/mib.h      |  7 +++++++
 net/mptcp/protocol.c |  1 +
 net/mptcp/subflow.c  | 14 +++++++++++---
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index f23fda0c55a7..ec42583c59cf 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -71,6 +71,13 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPFastcloseRx", MPTCP_MIB_MPFASTCLOSERX),
 	SNMP_MIB_ITEM("MPRstTx", MPTCP_MIB_MPRSTTX),
 	SNMP_MIB_ITEM("MPRstRx", MPTCP_MIB_MPRSTRX),
+	SNMP_MIB_ITEM("MPRstMD5SIG", MPTCP_MIB_MPRSTMD5SIG),
+	SNMP_MIB_ITEM("MPRstNoToken", MPTCP_MIB_MPRSTNOTOKEN),
+	SNMP_MIB_ITEM("MPRstNoMPJ", MPTCP_MIB_MPRSTNOMPJ),
+	SNMP_MIB_ITEM("MPRstHMAC", MPTCP_MIB_MPRSTHMAC),
+	SNMP_MIB_ITEM("MPRstFatalFallback", MPTCP_MIB_MPRSTFATALFALLBACK),
+	SNMP_MIB_ITEM("MPRstBadMap", MPTCP_MIB_MPRSTBADMAP),
+	SNMP_MIB_ITEM("MPRstNotEstablished", MPTCP_MIB_MPRSTNOTESTABLISHED),
 	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
 	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
 	SNMP_MIB_ITEM("SndWndShared", MPTCP_MIB_SNDWNDSHARED),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 812218b5ed2b..0ac109b52d35 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -70,6 +70,13 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPFASTCLOSERX,	/* Received a MP_FASTCLOSE */
 	MPTCP_MIB_MPRSTTX,		/* Transmit a MP_RST */
 	MPTCP_MIB_MPRSTRX,		/* Received a MP_RST */
+	MPTCP_MIB_MPRSTMD5SIG,		/* MP_RST: MD5SIG enabled on listener */
+	MPTCP_MIB_MPRSTNOTOKEN,		/* MP_RST: JOIN token not found */
+	MPTCP_MIB_MPRSTNOMPJ,		/* MP_RST: missing MPJ in SYN/ACK */
+	MPTCP_MIB_MPRSTHMAC,		/* MP_RST: HMAC validation failed */
+	MPTCP_MIB_MPRSTFATALFALLBACK,	/* MP_RST: fatal fallback on child */
+	MPTCP_MIB_MPRSTBADMAP,		/* MP_RST: bad data mapping */
+	MPTCP_MIB_MPRSTNOTESTABLISHED,	/* MP_RST: JOIN on not-established msk */
 	MPTCP_MIB_SUBFLOWSTALE,		/* Subflows entered 'stale' status */
 	MPTCP_MIB_SUBFLOWRECOVER,	/* Subflows returned to active status after being stale */
 	MPTCP_MIB_SNDWNDSHARED,		/* Subflow snd wnd is overridden by msk's one */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 17b9a8c13ebf..b06cbcf983f4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3836,6 +3836,7 @@ bool mptcp_finish_join(struct sock *ssk)
 
 	/* mptcp socket already closing? */
 	if (!mptcp_is_fully_established(parent)) {
+		MPTCP_INC_STATS(sock_net(parent), MPTCP_MIB_MPRSTNOTESTABLISHED);
 		subflow->reset_reason = MPTCP_RST_EMPTCP;
 		return false;
 	}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e2cb9d23e4a0..71bffcda0138 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -160,6 +160,7 @@ static int subflow_check_req(struct request_sock *req,
 	 * TCP option space.
 	 */
 	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info)) {
+		MPTCP_INC_STATS(sock_net(sk_listener), MPTCP_MIB_MPRSTMD5SIG);
 		subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
 		return -EINVAL;
 	}
@@ -227,6 +228,7 @@ static int subflow_check_req(struct request_sock *req,
 
 		/* Can't fall back to TCP in this case. */
 		if (!subflow_req->msk) {
+			MPTCP_INC_STATS(sock_net(sk_listener), MPTCP_MIB_MPRSTNOTOKEN);
 			subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
 			return -EPERM;
 		}
@@ -568,6 +570,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		u8 hmac[SHA256_DIGEST_SIZE];
 
 		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_SYNACK)) {
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPRSTNOMPJ);
 			subflow->reset_reason = MPTCP_RST_EMPTCP;
 			goto do_reset;
 		}
@@ -582,6 +585,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 
 		if (!subflow_thmac_valid(subflow)) {
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINACKMAC);
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPRSTHMAC);
 			subflow->reset_reason = MPTCP_RST_EMPTCP;
 			goto do_reset;
 		}
@@ -870,6 +874,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		 */
 		if (!ctx || fallback) {
 			if (fallback_is_fatal) {
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPRSTFATALFALLBACK);
 				subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
 				goto dispose_child;
 			}
@@ -1421,9 +1426,12 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */
 			subflow->reset_transient = 0;
-			subflow->reset_reason = status == MAPPING_NODSS ?
-						MPTCP_RST_EMIDDLEBOX :
-						MPTCP_RST_EMPTCP;
+			if (status == MAPPING_NODSS) {
+				subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
+			} else {
+				MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPRSTBADMAP);
+				subflow->reset_reason = MPTCP_RST_EMPTCP;
+			}
 
 reset:
 			WRITE_ONCE(ssk->sk_err, EBADMSG);
-- 
2.34.1


