Return-Path: <netdev+bounces-281093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGsOM6Qd7Gl7UgAAu9opvQ
	(envelope-from <netdev+bounces-281093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 03:49:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A93D4647C0
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 03:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B9F83013A9F
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 01:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2385022D7A1;
	Sat, 25 Apr 2026 01:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K4XL1BPe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646FA1E9B1A
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 01:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777081739; cv=none; b=fs7liZav1LTjz0G/ZTJX6Y6eiwRugk7gyXCmv0xQ26e8xVw89a2VhQ7flNDb4Gkryvg/XEkGm8Rq2LnqGUvUJxCec5KoPPwti3iojdJv3m6mZ7CIfSQEvJKDr2bZTRx3Jaf6kQqiZ6TQhyguAmfS45dyQ3iTIGJAI4Pgug+JHo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777081739; c=relaxed/simple;
	bh=7NBLBNCgaPeu8Rt4l2UvtDHFYQtjS37GZUbNuqPQoyg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iq+IBQjdSd9b6urYdt9q6jwOUQ4Byu05rlSIpkNXu3/iNRs2QIetoiribqUFgulauWYw7bPlMNHOSoG5sacF98O+ra39edcrGysHHOLn1hc5vrMUsZQAJk2f3fjkabcQWTx+5H+XXVCiVs6Lk/jpFwGPakJyh6sd/8KWpAXdr8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K4XL1BPe; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2e60238adb1so19626240eec.0
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 18:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777081735; x=1777686535; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=81CODhtfCeY5gOXc4AcZuOqtvysUpw25zIQcp3J/FQg=;
        b=K4XL1BPeItq311U22poeRHn+C2FQck7Te8YLayTJ8GIDWjK/C7Z9bG5Iob7zdjtvEP
         FLAvcZjJAtzXo0HLYhx7QK9MNLQK9Vp0ZAyCCq8tlCfm4bP5nWKrNRu9KCR3uo3xHk48
         My4hUTtlkvAw3yLAclW5J5ghm9zOPydXpOikn5UnMx7YylYtOH987Y0gXEPasZMiNigj
         GT5BUJ+CXmtOPC0OLGmJfWvxayCEQSkGqxD7VpFWL3210SxWMQwDxqPyqaYBseN8fvTT
         CYsSRlbe2IyAp0qlN0/auBp3o3bkCpsho2S0OGyt7fXDjpeOYqAZg7D14PaXmufHS6HP
         +5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777081735; x=1777686535;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=81CODhtfCeY5gOXc4AcZuOqtvysUpw25zIQcp3J/FQg=;
        b=BfchCs1FtX47okZcvLrjlEq35qm5G/sRf6557156QBCMEzNBbUQ2271mH7R0f3RsDV
         7Auh1B0ioWIf6Qe3OtMtVrW+7CA4IHSCFarlmagIqaX7qZPpbEGYuJnYyaUe/UrCwa6N
         81GsULeiBSYdvKNsj991vJtw3oP3UK0YyWLu4NKupOClD8Qza4B7jQpCYg30ZqwU6Zgn
         9OM2KHU6EkGqo7z/hcCVUaagpN/trrss+VatPpDGypHvxTScIouCKX8gQGfw5J6yJKra
         7yE2x0SFy8XD4GJFk9beMn7Itss5i61VAT6yleQD1D7biG9JQNt6NwW7+WQ1NsoktsKi
         97SQ==
X-Gm-Message-State: AOJu0YxZL+X8EaE99PoiCrm45IEzqpeVJ+LNaFnDDWq2Dtf9HekApIgf
	Ne07GpE0coInEspd24JTFHdDYDYUpUJcFt7U2bXl0jf/w06cwBwe+rGJ/+7e6g0x+p92anqrYXl
	a8ieQAQ==
X-Received: from dlea14-n1.prod.google.com ([2002:a05:701b:420e:10b0:12c:49a5:e4a4])
 (user=boolli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:60c:b0:12a:713b:8958
 with SMTP id a92af1059eb24-12c73f7596bmr17260924c88.10.1777081735213; Fri, 24
 Apr 2026 18:48:55 -0700 (PDT)
Date: Sat, 25 Apr 2026 01:48:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260425014842.1036981-1-boolli@google.com>
Subject: [PATCH iwl-next v2] libie: log more info when virtchnl fails
From: Li Li <boolli@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Li Li <boolli@google.com>, emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2A93D4647C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281093-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Virtchnl failures can be hard to debug without logs. Logging the details
of virtchnl transactions can be useful for debugging virtchnl-related
issues.

Tested: Built and booted on a test machine.

Signed-off-by: Li Li <boolli@google.com>
---
v2:
 - Use dev_warn_ratelimited instead of dev_notice_ratelimited based on
   reviewer feedback.

 drivers/net/ethernet/intel/libie/controlq.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
index ebc05355e39d..bf200fea1e12 100644
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
+		dev_warn_ratelimited(
+			params->ctlq->dev,
+			"Transaction failed (op %u, xn state: %d, id: %u, cookie: %u, size: %zu)\n",
+			params->chnl_opcode, xn->state, xn->index, xn->cookie,
+			xn->recv_mem.iov_len);
 		ret = -EBADMSG;
 		break;
 	}
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog


