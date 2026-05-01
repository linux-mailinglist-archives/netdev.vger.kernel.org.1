Return-Path: <netdev+bounces-283066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id s11rDfwA9Gkw9gEAu9opvQ
	(envelope-from <netdev+bounces-283066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:25:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 711414A99D1
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 048A1301B728
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 01:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229BB2BDC32;
	Fri,  1 May 2026 01:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fD6ToFG8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4421287263
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598713; cv=none; b=QLB7BvLqQPjDA975D6co6aEkzRXNO6kZheS/gGfRs6fpvOIiTOz3QENF7sYbauX2SV7NBN91CJ/vZM1YyQt7U5H9ezTPUeqwVf/WKjNnSlzmoU7lKhqRC+cRU9jf9E/lkz6dSL18ToHT9Jr8QZRztsacqItmfwEN+WCJivVyCGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598713; c=relaxed/simple;
	bh=sw9s8UjpZFd8zI7MGxTn46oINIzT/Z36l7Cymb5QNnM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lH71xzj2jOTceuu1FIjBULdIJ5F8V9QbCVEjdLkaZaRh3eDP304M3yGhCluNDniolj81byrMMaE4Q70teRTZbSBaNxquSeX0OEzuJPBV/538dwsK+tIu/H+6OhJILBmjOa6niOOFOVUvjXHDRpzoEkMpAEgW47ghIXCKtSc6Olc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fD6ToFG8; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so3256395eec.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 18:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777598711; x=1778203511; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oVNJyuWqlMR4ml4qJTrmF4Dl7mhOJUtG2QO1Cc6843I=;
        b=fD6ToFG8Pm8thJ2+P8ahPLCI6qotrYzWny8A1jQhlXUEQYP+hZ4g/tO617M2HKc5yD
         jaJA+mm807kCn/GVWe3apHcyn0Wlu3WqK0JR9R9Ro0ywuECeAkmQg4ThvAeyPY3yYz5P
         jKlSTkW2b0lcrYfrO2uO44H3IZBh4LApY5PrIbx9Rn8z/r5IXddcSjgQ6tlqUcFrJ0Aa
         1iLV/Oa6Npjz37mysgC0le+r3ZjCxH5bhj9WZ4OddZPzG5Ns3JRpiMvnH3IpmtU3Ov6g
         wCCEOX86bfS/l+U3OZCG9HV1RITAEmp2hiKcYG67QgUPXLFb2gKAS/8GEw8slj+/bCrC
         OLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777598711; x=1778203511;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oVNJyuWqlMR4ml4qJTrmF4Dl7mhOJUtG2QO1Cc6843I=;
        b=d2kKjnNjLSF721rzTeSVuW8MRXd3CjuajhwRKV9DjhPxv1K7X0NmiGQL6inbvjMW+F
         EGiOdHQFJMjT8fG+VldXCej/oQLT2vxV6GnPX4KKpDLKrVFjdaYzUsgzIISrAxNry+gT
         lcZSwDmjRJrW/Xx8cehSDahZ8NfWmXBj7NEUZqs3h+ZxgiRswbOuwgcxGm/OB4PWh0H0
         bspORlfID0OA/F6GySQD8yIlBD7utlRLJhPLbAOBxv9tVxD7rbPlRdPXschcnTGMCIx7
         VzPa91gJuNjR0felQoPe2EZqpAE2j+Srpk3WA30LhH0IcS4yTfRsQk9bFlpL8BulADVa
         LrrQ==
X-Gm-Message-State: AOJu0YxiPm6F0g2boAeVlnYcdqFla75ujTr+GuMh2M87Vs6Zu0vaMPEJ
	jjPeHJgNN0nGdrzk/X5ss4mOwxhTdhTclmy5mi6t4YS1rshx47ffmyFT2WgARxM9erve3I/wsYd
	JTnpuXQ==
X-Received: from dybvi26.prod.google.com ([2002:a05:7301:531a:b0:2d8:dd18:baee])
 (user=boolli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6743:b0:2d9:bc8d:f62a
 with SMTP id 5a478bee46e88-2ed3e486c61mr2586087eec.16.1777598710661; Thu, 30
 Apr 2026 18:25:10 -0700 (PDT)
Date: Fri,  1 May 2026 01:25:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501012507.461044-1-boolli@google.com>
Subject: [PATCH iwl-next v4] libie: log more info when virtchnl fails
From: Li Li <boolli@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Li Li <boolli@google.com>, emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 711414A99D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283066-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boolli@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Virtchnl failures can be hard to debug without logs. Logging the details
of virtchnl transactions can be useful for debugging virtchnl-related
issues.

Tested: Built & booted on a test machine and synthetically produced a
virtual failure to produce the following log:

idpf 0000:01:00.0: Non-zero virtchnl ret val 6 (msg op: 1, data_len: 8);
xn id: 0, cookie: 0
idpf 0000:01:00.0: Transaction failed (op 1, xn state:
3, id: 0, cookie: 0, size: 8)

Signed-off-by: Li Li <boolli@google.com>
---
v4:
 - Simplify logging to reduce redundant "ret val"s.
 - Use %u for xn->state.
v3:
 - Use dev_err_ratelimited in both logs.
 - Move log placement to after virtchnl field validation.
 - Remove redundant op/cookie fields since they were validated.
v2:
 - Use dev_warn_ratelimited instead of dev_notice_ratelimited based on
   reviewer feedback.
 drivers/net/ethernet/intel/libie/controlq.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
index ebc05355e39d..e1bc19d6cdbf 100644
--- a/drivers/net/ethernet/intel/libie/controlq.c
+++ b/drivers/net/ethernet/intel/libie/controlq.c
@@ -766,6 +766,14 @@ libie_ctlq_xn_process_recv(struct libie_ctlq_xn_recv_params *params,
 	    msg_cookie != xn->cookie)
 		return false;
 
+	if (ctlq_msg->chnl_retval) {
+		dev_err_ratelimited(
+			params->ctlq->dev,
+			"Non-zero virtchnl ret val %u (msg op: %u, data_len: %u); xn id: %u, cookie: %u\n",
+			ctlq_msg->chnl_retval, ctlq_msg->chnl_opcode,
+			ctlq_msg->data_len, xn->index, xn->cookie);
+	}
+
 	spin_lock(&xn->xn_lock);
 	if (xn->state != LIBIE_CTLQ_XN_ASYNC &&
 	    xn->state != LIBIE_CTLQ_XN_WAITING) {
@@ -1011,6 +1019,11 @@ int libie_ctlq_xn_send(struct libie_ctlq_xn_send_params *params)
 		params->recv_mem = xn->recv_mem;
 		break;
 	default:
+		dev_err_ratelimited(
+			params->ctlq->dev,
+			"Transaction failed (op %u, xn state: %u, id: %u, cookie: %u, size: %zu)\n",
+			params->chnl_opcode, xn->state, xn->index, xn->cookie,
+			xn->recv_mem.iov_len);
 		ret = -EBADMSG;
 		break;
 	}
-- 
2.54.0.545.g6539524ca2-goog


