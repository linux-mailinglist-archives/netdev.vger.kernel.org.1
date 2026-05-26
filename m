Return-Path: <netdev+bounces-291652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wATmLHB4FWrHVAcAu9opvQ
	(envelope-from <netdev+bounces-291652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:39:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA415D448A
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA74F3030F63
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762923D79F1;
	Tue, 26 May 2026 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsITDR8M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AED23DD85A
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791975; cv=none; b=QOAdi6JP6RVb1/kNT9jtC4Eemj5geDgVccPWzsm7vqkdBbX47Mt7w4zO/JjaGDSUvGQgc39ftI7mHkAIivxLMRiiGhFi4xXzZszX28dJVXE0S/7JwcvVrY/WJqiXM2EQwjKGcAcnhzdBM4IQKUZejmK8H3ukglo2XNZX73fDhEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791975; c=relaxed/simple;
	bh=B97ELvkX6N842HYjoNK7QJvLVI4ordhfDMdINxvheHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EuUPNDyzZKu2MhXQZu+G6oKTHJTd7Et20f9wWkCyspo1xxHPG7pN+0O7KIffr1UW/ebx3fiuMSTtfocTdy6NczAdjPdca3EinfLAtwhLJfc9KsJ9B+Gbq8QjUPFSxntP/82TMqlFRsKp8dtejHGL4Bo7SQtfDGfWEROJkQLFGoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsITDR8M; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2baef9f5ecdso84879775ad.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 03:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779791973; x=1780396773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UYm1BHMshCVKa2i1I2czc9BlKZah58XVCrdoxcCS9Rw=;
        b=NsITDR8MzqkOj4V86AgSbRDGRM5wHEPz9F9XOmMTfKZ1SB/YNIHeomB4aScRpQfFGq
         95oPe7yTK75gDRnaxLF5VX+X1Oj2AmYQBkL+GmyYLo86MQkKmOHXoGSwtcNikmtHl4Cp
         jUBZ4/nG2bs7VN6nJ8LWIxrvqaAhAF23B5HCujWBpqHMqL4Blf/MylCpeb7iW8aO/Crh
         a6onvhHDWrrbtdDcUY+IC+hYE5RZWC18Y5XV/z+VsF2QvMa5peX87bx4YLlnvpVNK5GS
         EEtUNgz3Cfn9GLlzA391WbAJmnwh2i3lV71+V9+upEXm9L9k0Pf31E5G0k/l5eKn5IQs
         vhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779791973; x=1780396773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYm1BHMshCVKa2i1I2czc9BlKZah58XVCrdoxcCS9Rw=;
        b=VZc8XJXpmSmXdAbss+iK8ODeA94rm5zQv89VVcMbv29YsdLcUmA4G2krDdpo7W3JiN
         wp3StrZlQBQbU1lhKYSc8VDD4yquqptsLM+PYnaP45GPhauP78oy8tSx6QM7fADnHDve
         gkkpS+MRdVurLCShjWeIO/pS4G8IyMCaiOC5/ir1+JB6qzR9iy1CRRQy62jigw/tfxsB
         tcDYaVng8/be0BgyRXGlJ7L0sr7pyt4z6Ph+Px7wvodGi0j72Dj4nxbGj6rS6D6Yfzw9
         GWp7uq/89+ffb7niEttnvpplMsu69UJ0PAnt+zws6AHRwC78EC5b8Qbto5VBXvgV69zq
         TdYQ==
X-Gm-Message-State: AOJu0YwblYGLJHEd3cAaoD6JFiL9hQQolRyvoYzk3wYA++54FNTAaQh2
	fKl27QrsU/4XzChZruC4vGew2pQ6A9SAl2pHnhRLPKwA+NibaeoOOf5A
X-Gm-Gg: Acq92OHUeMlr4k+Bn00s0C0M2Q1kjmwLvaLw+89GTWV/w7m9NVYNKWx20pmhVm89uEK
	fjTd9OAw4zGLZNHGUsnhirg9IWgK9ZO/ZuzAmpCkm8yYUmPuKdwmj5E7CzJqjGRJz2lnJa6Ex/D
	k+GPLntgnHFudoeffp4CrudlDjBDFJj4whn6PRwdtjZVm1D3Ti+28DifYbRpQaXv6ceEK1Ab5Of
	sUGADWNn50lfHAROTNi+8whwVy9KnrYvyKCRJbdf/rnQ7+yRL1toWSJ8syNmCAAiJLzmD/Rslnn
	qwvWcE4XE4pTg1PXWPaCdDRIV4ms8PcAsG0gLFth4EmtWh/mOkU4SV/hlzKotkTjigdXCFzb5AP
	4gaunhR0aBazCtdBlL/SYm/P69kphYSDEnnQWfB7EYAycH12GfuCi75/whoi6jPNABh1OPnFgHg
	FH8igjTLsIGuyMnNdO0oQyly5C06T6QYkejmesUe34BTZSBU1CjAIQ1Hp9xxla
X-Received: by 2002:a17:902:ebd2:b0:2bc:b141:8551 with SMTP id d9443c01a7336-2beb06f81f3mr203476025ad.19.1779791973489;
        Tue, 26 May 2026 03:39:33 -0700 (PDT)
Received: from KIPREYXIAO-MC2.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm65324415ad.2.2026.05.26.03.39.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 03:39:32 -0700 (PDT)
From: Zhenghang Xiao <kipreyyy@gmail.com>
To: 3chas3@gmail.com
Cc: netdev@vger.kernel.org,
	Zhenghang Xiao <kipreyyy@gmail.com>
Subject: [PATCH net] atm: fix use-after-free in vcc_sendmsg during device deregistration
Date: Tue, 26 May 2026 18:39:26 +0800
Message-ID: <20260526103926.1640-1-kipreyyy@gmail.com>
X-Mailer: git-send-email 2.50.1
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-291652-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kipreyyy@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2CA415D448A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

vcc_sendmsg() checks VCC state flags (ATM_VF_RELEASED, ATM_VF_CLOSE,
ATM_VF_READY) before calling copy_from_iter_full(), but does not re-check
after copy returns. copy_from_iter_full() can block on user-space page
faults, and if the ATM device is deregistered during that window via
atm_dev_deregister() -> atm_dev_release_vccs() -> vcc_release_async(),
the driver frees its per-device private state. When sendmsg resumes, it
calls vcc->dev->ops->send() which dereferences the freed memory.

Re-check VCC flags after copy_from_iter_full() completes, matching the
existing re-check pattern in the TX-ready wait loop.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
---
 net/atm/common.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/atm/common.c b/net/atm/common.c
index fe77f51f6ce1..cfcbefaaafb2 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -641,6 +641,13 @@ int vcc_sendmsg(struct socket *sock, struct msghdr *m, size_t size)
 	if (eff != size)
 		memset(skb->data + size, 0, eff-size);
 
+	if (test_bit(ATM_VF_RELEASED, &vcc->flags) ||
+	    test_bit(ATM_VF_CLOSE, &vcc->flags) ||
+	    !test_bit(ATM_VF_READY, &vcc->flags)) {
+		error = -EPIPE;
+		goto free_skb;
+	}
+
 	if (vcc->dev->ops->pre_send) {
 		error = vcc->dev->ops->pre_send(vcc, skb);
 		if (error)
-- 
2.50.1 (Apple Git-155)


