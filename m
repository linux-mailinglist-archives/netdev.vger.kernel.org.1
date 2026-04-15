Return-Path: <netdev+bounces-278869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO2tLFX432mFbAAAu9opvQ
	(envelope-from <netdev+bounces-278869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 22:43:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C903407B21
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 22:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2324C30372E6
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 20:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5C038AC90;
	Wed, 15 Apr 2026 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3E+iUXl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1709134DB4F
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776285779; cv=none; b=fr6AuyN0stoSNIPWKIfrg3Tb/RHcOvaykv9dgAX9t/FU0e//WA7jieciWHiJin9OOyVAT2ydiCt3yGB253zj9/gxx6R1X7+J3o/BDnge0p8m4RSD+evl3/3nmuuMwz5edv952RaD2KGiaA7OebeBWXqvLgFoVwXuQLGSNNUOJPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776285779; c=relaxed/simple;
	bh=FWsWonbhjiU/L7z3fj458W+yTq2KdFvhc0odNdHRpSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sgl9ITkgIhZ74YBTrYn42PmWyYzVoVWL0OCgu/4DjEPxs1RHB3qN5UBf++JvqJlvyxXYCb7yuWGc1buCUcqZWGQ2sMb2pddjk9vQnMQguMuZ5tZi4fIFjacLWDAmSW/jlseJb8K8oVc055kv3ErKd78ur6zy51LrYKgEhh51OXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3E+iUXl; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c79662668bbso29414a12.1
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 13:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776285777; x=1776890577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lTPTk3IgW0r8HZW71NoocFyOw9bLBs1SntckvwqwCKY=;
        b=F3E+iUXlUqY/LEeciM/KruRumrF1QQHirTN7vdmHfruoMdGqRa1YcdefZuf+fq9Ap2
         miZF9Qa+lUq3pefOFLbYIZezGhuW65HW++afrnTg/lZSpp3EruzHnQIvCOSc9W4qWcwF
         u56o8bNAGp9EcIGwgYluBKbvTqaKxTSQ/C1ls1pFjX7r8tVLcb1syvlhMzddRbUW9/Er
         ExDO4yOUPLG1+Z1UDpIrHIzr95UwaR5lfd8G2cZ1YNJ8ScUFvBRqtT5vTIG12W0qEpc3
         Y92myu16zqFakrRWrGF1UmZctVFBtZ4AjrFl1b8tv7xylEgjibf8HCT6qvbjDhVD8jBv
         HpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776285777; x=1776890577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTPTk3IgW0r8HZW71NoocFyOw9bLBs1SntckvwqwCKY=;
        b=I4tRM8D5qt1eAMMvuQnNy9VAp39NuL92FSNsUL4wN05Q/m1qgUdoslbs6LRRHEefI+
         kv6PfJ6PiKouyHCthAO7u1Vj02ldzeUhvROoFinCRgsx/IiXHPsXLIJcgIl+CXd6ddsq
         Jb8O+R5dsB6/eFOQmLCPjJ3kqC7VMlErv45GjClazyddhFm0QV6HD0oI7n0hMywkc8HP
         Gmzh1KRfi/YOupCXJTKNtIUEHMXSWjt4z8kU4IjmIhFbnnuSA9L0pyhJQeDHmZ7xPHM5
         1aL0+furnKd36Pfmm2XLXTmdWANJM0//6bA3lLiTCoRYm0f7f0ID0RqVxoK8Hh3OYQJS
         VQZA==
X-Gm-Message-State: AOJu0Yzkss5OQ1OUoIDcpp0qr+XJGMckRq1GjiaJ1fmartl6PeyZHNzo
	Zi2WWS83EqoHivVUp37+67UxJlrsHxA5l2DJak/xALxCwWES0+N7UN6a
X-Gm-Gg: AeBDievBKBJJLDVe9alNblleRGeR5Qje2NNSQWNlRF5gKBTLMZqnhU+SrlxsMdQBiaw
	BlOoIRrLB2XqXa0X+9y1FrxSGEr/FNbRFN8IYnvCsg6KiPDzbCPZd75e0TfowmuiThviYX40LCB
	dFVpGvhLczskYlQvT+BDZgQYF98xwxSnGjoYlnokUiZv5xeKanjpUEJS6iHfWawxzISts5WFkFK
	8Y8q4cmZeAPW6vJfU5yjy6pCD2GPYFCCnG7DtFuUDxwxdwMmzmzLcX4L9YIlts5DvtptRf4VHj7
	nXWscU7qxE0aBCI2Fs9bjL6klpSW2EBS9oWNLsg0r4aYdJRXQFXfm1BwFZm/kyQnLkq41b+WWsW
	+zo+yv2OO6WHpx5mE7tj6aGeSndmkXct+KOL0kyr43ld3wX0Ks+sjtFW/erk6djvdALBVXHu6OH
	kSGSEusOAiMkdfFl9OImdBDU6LOKDTbN2MhSuo5G7k73d4K3zti9OBWAkQQlfUT3r0qJFzXQ8cW
	s6aoC7aB/ut
X-Received: by 2002:a05:6a20:3953:b0:398:7eea:50a0 with SMTP id adf61e73a8af0-39fe3da99c8mr26458090637.18.1776285777318;
        Wed, 15 Apr 2026 13:42:57 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7957eec605sm2836307a12.8.2026.04.15.13.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:42:56 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v2] slip: reject VJ receive packets on instances with no rstate array
Date: Thu, 16 Apr 2026 04:41:31 +0800
Message-ID: <20260415204130.258866-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,asu.edu,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278869-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2C903407B21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

slhc_init() accepts rslots == 0 as a valid configuration, with the
documented meaning of 'no receive compression'. In that case the
allocation loop in slhc_init() is skipped, so comp->rstate stays
NULL and comp->rslot_limit stays 0 (from the kzalloc of struct
slcompress).

The receive helpers do not defend against that configuration.
slhc_uncompress() dereferences comp->rstate[x] when the VJ header
carries an explicit connection ID, and slhc_remember() later assigns
cs = &comp->rstate[...] after only comparing the packet's slot number
to comp->rslot_limit. Because rslot_limit is 0, slot 0 passes the
range check, and the code dereferences a NULL rstate.

The configuration is reachable in-tree through PPP. PPPIOCSMAXCID
stores its argument in a signed int, and (val >> 16) uses arithmetic
shift. Passing 0xffff0000 therefore sign-extends to -1, so val2 + 1
is 0 and ppp_generic.c ends up calling slhc_init(0, 1). Because
/dev/ppp open is gated by ns_capable(CAP_NET_ADMIN), the whole path
is reachable from an unprivileged user namespace. Once the malformed
VJ state is installed, any inbound VJ-compressed or VJ-uncompressed
frame that selects slot 0 crashes the kernel in softirq context:

 Oops: general protection fault, probably for non-canonical
       address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
 RIP: 0010:slhc_uncompress (drivers/net/slip/slhc.c:519)
 Call Trace:
  <TASK>
  ppp_receive_nonmp_frame (drivers/net/ppp/ppp_generic.c:2466)
  ppp_input (drivers/net/ppp/ppp_generic.c:2359)
  ppp_async_process (drivers/net/ppp/ppp_async.c:492)
  tasklet_action_common (kernel/softirq.c:926)
  handle_softirqs (kernel/softirq.c:623)
  run_ksoftirqd (kernel/softirq.c:1055)
  smpboot_thread_fn (kernel/smpboot.c:160)
  kthread (kernel/kthread.c:436)
  ret_from_fork (arch/x86/kernel/process.c:164)
  </TASK>

Reject the receive side on such instances instead of touching rstate.
slhc_uncompress() falls through to its existing 'bad' label, which
bumps sls_i_error and enters the toss state. slhc_remember() mirrors
that with an explicit sls_i_error increment followed by slhc_toss();
the sls_i_runt counter is not used here because a missing rstate is
an internal configuration state, not a runt packet.

The transmit path is unaffected: the only in-tree caller that picks
rslots from userspace (ppp_generic.c) still supplies tslots >= 1, and
slip.c always calls slhc_init(16, 16), so comp->tstate remains valid
and slhc_compress() continues to work.

Fixes: b5451d783ade ("slip: Move the SLIP drivers")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v2:
- slhc_remember(): use sls_i_error instead of sls_i_runt for the
  missing-rstate case; it is a configuration error, not a runt packet
  (Simon).
- slhc_uncompress(): goto bad instead of returning 0, so the instance
  also enters SLF_TOSS on the first rejected frame.

 drivers/net/slip/slhc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/slip/slhc.c b/drivers/net/slip/slhc.c
index e3c785da3eef3..e18a4213d10ce 100644
--- a/drivers/net/slip/slhc.c
+++ b/drivers/net/slip/slhc.c
@@ -506,6 +506,8 @@ slhc_uncompress(struct slcompress *comp, unsigned char *icp, int isize)
 		comp->sls_i_error++;
 		return 0;
 	}
+	if (!comp->rstate)
+		goto bad;
 	changes = *cp++;
 	if(changes & NEW_C){
 		/* Make sure the state index is in range, then grab the state.
@@ -649,6 +651,10 @@ slhc_remember(struct slcompress *comp, unsigned char *icp, int isize)
 	struct cstate *cs;
 	unsigned int ihl;
 
+	if (!comp->rstate) {
+		comp->sls_i_error++;
+		return slhc_toss(comp);
+	}
 	/* The packet is shorter than a legal IP header.
 	 * Also make sure isize is positive.
 	 */
-- 
2.43.0


