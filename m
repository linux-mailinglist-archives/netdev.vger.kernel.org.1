Return-Path: <netdev+bounces-280921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJZeKtLg6mkNFAAAu9opvQ
	(envelope-from <netdev+bounces-280921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:17:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC11459697
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78BC23003617
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1287D3233F4;
	Fri, 24 Apr 2026 03:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tJUvczuG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B772D3FFD
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 03:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777000564; cv=none; b=UIW6to8KrdJihpXRI44hu8hLI992pRkECq2QlwAwnQZHTrocFLst55THd6HHdfRInq4QkPl8UYL8u3CsJmouTsQV3WTIQNj8ddyfpJ2iz8bQkFgDzNY0un66xI4PWCHHnfXFHvhq0gQb2Lkp3c6LOVpa/m03rk4M1VB/zWfG41I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777000564; c=relaxed/simple;
	bh=ftvM3LSO8eWNG2mumtmKKGXzblRrW9Wy8Fjpz/s/Vt4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rQb80WJ+QO8GFMqK5Fjl38E17LaSR2ACVIeNnk78LjDWk/7RqjXlkx54Yi59X2NOI0cmRJQ5PCIJ4wNdw4SyKVMSlwVR7m5RjO6t5SyxxwwthlzOspXhSBQ3uDqV7oge+RlNbE0N00U6DyilJcOyuxXRNxgMUATEm9fH2uEN7ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tJUvczuG; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso9463656eec.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 20:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777000562; x=1777605362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SbAAeoe+lCfBByxTKPuDEe/gKzpl0DVHWMIRbJcx2qg=;
        b=tJUvczuGBFGosCuJcH2hPPe2K+iYGn1u2iFXVIc3pRnS6ls7lhf+tZftOOWiLt0thu
         NHHPHKwWzCWR5g94JtAXefAApAccwD7RPCFqfJcY5cTAhM42FPth8nA27FW83AymbZXo
         Bec/A04n2nQAqxTMZCPWrHpBScKGe7A2oOh2pZ3oGvLP3Sg4TQr1MHgUrKwizIRXD/Xn
         wTlxnbvHmPhzja7BXQTjVxrgUeeOavdHZUQOvyLtnQ1dPzUWIIRN7WRaGV3Bqopd/pj1
         VxN7PhTY1FJWc0KOVeSd8nY8m7p3jsA+e7+yVw+zOsh4vJRFaS0PSoFA0qb2PulIroC4
         F7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777000562; x=1777605362;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SbAAeoe+lCfBByxTKPuDEe/gKzpl0DVHWMIRbJcx2qg=;
        b=PCsqUiLmcC04SW+9lVBuph0dNp7xeS7ZEy0G7RtfrA6/DYRAtlv73wk6I0oR8VOpHE
         6GsZttpno9LR4Dfch8OXtHuOXe/i2SDUIuPLXw5oA0QUiI0MnFn3UmH7VLpErE9+9wTc
         /M/v2OSRc3Po4JX9bknDpndZMk16PYTt5MR6Y+dPPe91LMjfiZZNTBuebPJoIWeZkC96
         V30HZQk1cA0raLH2acbyJGU/rv+njYV3xM5l1ODURTbUZL6tPaADUZZdeUbKUhPi/AmS
         yiGpcG4Bd4wyj54VufU/qQSE9mgg9SwwO+PSWtUZbvOMS9F7xGqciiZr2wjCoDn2oL7q
         Nluw==
X-Gm-Message-State: AOJu0YykcW3m61qkbalufiFYbmKzsRUjyJd8doobqZoKyCNynTlwy/VF
	XBRky+KXdkcVyxQj2k/1q2Uxjp+G9Sr1upmQD9VhWM+N9JdmEb5GBoZM9Vv+1JY8L9akuf+GMO2
	rxCqEtA==
X-Received: from dycog19.prod.google.com ([2002:a05:7301:9a93:b0:2dd:53c4:1b43])
 (user=boolli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:fb94:b0:2c4:61be:1d33
 with SMTP id 5a478bee46e88-2e464eaa230mr15160221eec.6.1777000561536; Thu, 23
 Apr 2026 20:16:01 -0700 (PDT)
Date: Fri, 24 Apr 2026 03:15:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260424031545.3777023-1-boolli@google.com>
Subject: [PATCH iwl-next] libie: log more info when virtchnl fails
From: Li Li <boolli@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Li Li <boolli@google.com>, emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: DFC11459697
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
	TAGGED_FROM(0.00)[bounces-280921-lists,netdev=lfdr.de];
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

Tested: Built and booted on a test machine.

Signed-off-by: Li Li <boolli@google.com>
---
 drivers/net/ethernet/intel/libie/controlq.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
index ebc05355e39d..7eaa77413621 100644
--- a/drivers/net/ethernet/intel/libie/controlq.c
+++ b/drivers/net/ethernet/intel/libie/controlq.c
@@ -762,6 +762,16 @@ libie_ctlq_xn_process_recv(struct libie_ctlq_xn_recv_params *params,
 	status = ctlq_msg->chnl_retval ? -EFAULT : 0;
 
 	xn = &xnm->ring[xn_index];
+
+	if (ctlq_msg->chnl_retval) {
+		dev_err_ratelimited(
+			params->ctlq->dev,
+			"Non-zero virtchnl ret val (msg op: %u, ret val: %u, msg_cookie: %u, data_len: %u); xn op: %u, id: %u, cookie: %u\n",
+			ctlq_msg->chnl_opcode, ctlq_msg->chnl_retval,
+			msg_cookie, ctlq_msg->data_len, xn->virtchnl_opcode,
+			xn->index, xn->cookie);
+	}
+
 	if (ctlq_msg->chnl_opcode != xn->virtchnl_opcode ||
 	    msg_cookie != xn->cookie)
 		return false;
@@ -1011,6 +1021,11 @@ int libie_ctlq_xn_send(struct libie_ctlq_xn_send_params *params)
 		params->recv_mem = xn->recv_mem;
 		break;
 	default:
+		dev_notice_ratelimited(
+			params->ctlq->dev,
+			"Transaction failed (op %u, xn state: %d, id: %u, cookie: %u, size: %zu)\n",
+			params->chnl_opcode, xn->state, xn->index, xn->cookie,
+			xn->recv_mem.iov_len);
 		ret = -EBADMSG;
 		break;
 	}
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog


