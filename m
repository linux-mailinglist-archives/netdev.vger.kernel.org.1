Return-Path: <netdev+bounces-282485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBDfKwFt8mkMrAEAu9opvQ
	(envelope-from <netdev+bounces-282485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 22:41:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA3849A38F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 22:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B63E0300B469
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 20:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0957639FCC5;
	Wed, 29 Apr 2026 20:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BfK55Za6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E173932DE
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 20:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777495293; cv=none; b=WwJmihSnFZUvuP+zwdoaxT8k6T/1Q/57Tr4LTbkYZctEfegY/BMH9fay1Lt5951p03yCIcCiYsU0jgXf0Jtkv/f1J/T2aaXjaWquZ3G82DNTBiyFndljBV9mSqrcMFC3K/IZK6ebSlJTNze8orshH/xiY2xUTjvU83KnditJjwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777495293; c=relaxed/simple;
	bh=kN+EfbkIP3h0uxp77sIOlxAwH9iR+jNzSBYddzfWMzo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uEjOPPSJO/PVrdjKm7wCsO+QBjC9glLkaWXChVVtEIxMOLTshWvIuwZ05ogVoGln5RTrsM4LJIXz3NgAQv34FdK2Q0+ZumL5aJhZe9UwHHAhYVgjtVt4Qyszug4r0ZMxZt9KTvNi/+5h7TaHcSo7wFYqbBYIiF9+9Z+c8gsumQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BfK55Za6; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2e60238adb1so914956eec.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 13:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777495292; x=1778100092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dombmj9ny0RyT7dLXRXjIRy7HfDUGhjx5FcWbglB77o=;
        b=BfK55Za6h80Vtd6j/DUeqv3jH0yxktcqbSHT4u8EIR31/3zXfrlywukmZZyZHq8CtQ
         UUjyybegVgQI/mEDAUKA6PPMCY0TeO8P76N49j+C6KeCPAQ9iHfItF8So7rgUBxZ4WYI
         WarqPhjCAss1dJa80y5yZtdgNRUNSuQKCVrTobQiMsYOoPCu9vwmo7kbcXB63cM8cNDw
         5SA5YczQgO6Bp2HCt/z+17+Y3yN5hKxO+/LHqDoMrumLWP8mKLD6eGaVOwvMQUMyEBi/
         fF1Lm97bydlM9BNE8J32kbV8b2ck0av8muuVewfhQQ/Fr0YDM8V3qGlL3fqDtZuyT3Yo
         T4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777495292; x=1778100092;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dombmj9ny0RyT7dLXRXjIRy7HfDUGhjx5FcWbglB77o=;
        b=WpvPCmH4iIuzuraDmjGR9YoTn95mi7a+gAv4ZRLz9Z6A9lGMNElG2bJCbAUh4h7oEJ
         5VKBDxRw8lOnBaMp8lj/FrisHoihKfw2Siv0+zP0sfIIsib/sOAOTkiQ/6S4BZ+Wumjl
         0XzGQeGEmxIuSAMBG9xTzlrLJFymY3BH0I98SiphoENeukmbc6nEaCvHjdY/kdqgoF/Y
         5mfP1UTOxLx535L61o8IJEM9e8m5sspSlM9rdRDmJDdhVJmd2zbg1M4LNt5mul0DMNif
         qiBu/2Wdd+YtkoEG/6+c5YJ090rFVeIEqPPA3fSkhPrNsKl0xN7f9dFlDgZxK1XXNlg4
         LnEg==
X-Gm-Message-State: AOJu0YxXHuH7ihzHB4DN6FtmB3bHXMl2hae1sRtqIrvoX4Gu0CkTa4td
	G7eMzBV66OWZYur+9L4ImViwiVnRheVykSpQI2W/gITAkm0c7y3SHb8PyF0hGyR3nSHg7CeHFSj
	ZFFiRKg==
X-Received: from dycmd10.prod.google.com ([2002:a05:693c:23ca:b0:2dd:7012:2d3b])
 (user=boolli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:dc93:b0:2cb:8d2f:e247
 with SMTP id 5a478bee46e88-2ed0a099154mr4072247eec.13.1777495291613; Wed, 29
 Apr 2026 13:41:31 -0700 (PDT)
Date: Wed, 29 Apr 2026 20:41:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260429204128.2865817-1-boolli@google.com>
Subject: [PATCH iwl-next v3] libie: log more info when virtchnl fails
From: Li Li <boolli@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Li Li <boolli@google.com>, emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 5BA3849A38F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282485-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Virtchnl failures can be hard to debug without logs. Logging the details
of virtchnl transactions can be useful for debugging virtchnl-related
issues.

Tested: Built & booted on a test machine and synthetically produced a
virtual failure to produce the following log:

idpf 0000:01:00.0: Non-zero virtchnl ret val (msg op: 1, ret val: 6,
data_len: 8); xn id: 0, cookie: 0
idpf 0000:01:00.0: Transaction failed (op 1, xn state:
3, id: 0, cookie: 0, size: 8)

Signed-off-by: Li Li <boolli@google.com>
---
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
index ebc05355e39d..ceca8a076d79 100644
--- a/drivers/net/ethernet/intel/libie/controlq.c
+++ b/drivers/net/ethernet/intel/libie/controlq.c
@@ -766,6 +766,14 @@ libie_ctlq_xn_process_recv(struct libie_ctlq_xn_recv_params *params,
 	    msg_cookie != xn->cookie)
 		return false;
 
+	if (ctlq_msg->chnl_retval) {
+		dev_err_ratelimited(
+			params->ctlq->dev,
+			"Non-zero virtchnl ret val (msg op: %u, ret val: %u, data_len: %u); xn id: %u, cookie: %u\n",
+			ctlq_msg->chnl_opcode, ctlq_msg->chnl_retval,
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
+			"Transaction failed (op %u, xn state: %d, id: %u, cookie: %u, size: %zu)\n",
+			params->chnl_opcode, xn->state, xn->index, xn->cookie,
+			xn->recv_mem.iov_len);
 		ret = -EBADMSG;
 		break;
 	}
-- 
2.54.0.545.g6539524ca2-goog


