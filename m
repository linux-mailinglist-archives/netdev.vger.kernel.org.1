Return-Path: <netdev+bounces-293365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PbQDedoG2oxCAkAu9opvQ
	(envelope-from <netdev+bounces-293365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 00:47:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 844F7613AF7
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 00:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B819301F30A
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 22:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A813329E46;
	Sat, 30 May 2026 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0ADw+Ij"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D20723EAA0
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780181217; cv=none; b=qQI8oR1bAuJbHxBAWj1UoCJVRI0ZKZLgmOO4l0to7G7jR6NAYu/NH5ESX3E42xs625kof6BdKk3RbV/uQzboT8KXosA0RQ0425MsjojWdCzmbjypbaer7XQB9ja+l2Akl6uNcyDhIpD+43ku2g62HFThSo0kh8q+YyJqN9pCxqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780181217; c=relaxed/simple;
	bh=ZQRBfuTpW858XAy4W91USneKqQbvS7ZTIRzYZvR9kCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TDx0JLCu3QFD2gVvb3utc2TUiFUd4pyarl5bm7xsyD23Ui2DDvsv1ubBYuGnXnQ/1OBhHSM7708ormVweYj7wdjyPZ0H9v96oScBCm0KYY+u01tGfi9WScy4BjoLPBtIWladWA8fyY/Cjw6t3R0YWvSyHtS2NnwRdHngMKvrVE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0ADw+Ij; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36d5b11201aso389715a91.2
        for <netdev@vger.kernel.org>; Sat, 30 May 2026 15:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780181216; x=1780786016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BdCe29b/RCqYoRCAq21CObi9o5BQunwDqEEx86iglz8=;
        b=K0ADw+IjZ9CtUJWeAXdrqITIMXtT8vOmCZLqEJyGC3StiW0BiZa18jPGGT8f/WWkPI
         EVXCG4KnWyJBf+sWYk+aRdA0mnH2pEjDPJiLLVDwX6INTUoacYrhwyqbcRmFJnw/Kb4x
         5cRNruyP6CCWFz1CwmE6w9IaSX4xuFNF/kMQ85AEGkGFmENCrIi519mqluadYgVaI0wg
         0Ylej1pOW2TY1ppjINrhuvQMVadM/fi+iBv0P63an6KiLR/w+9s1pqcbc3LaSMcVCgXt
         GT7/aet3KPdG/m3+xHkCB/O8m98KLSleUHbyBTO2/PTtLpmEzcWDv2kQGl82zK/e2xML
         r6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780181216; x=1780786016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdCe29b/RCqYoRCAq21CObi9o5BQunwDqEEx86iglz8=;
        b=CaTDtXmM1/r8B1ugVRoJ482wAvKIqCiv3DkLVwLzNTAwEUX1F/PT9p21tIL6Wgv8rD
         QtCRyngp9cUc1FhhnkiPFUkim0kVk9ABfm0X45Fp0P3RJyh1mGFjs1JpUF1dc8NnGKR0
         cstz7B1BD/PAwRqM51xOmDZlp/8hk6FMRHV7uokdwB+Isc1/zNWuuLbW3k4MqbCSPUHJ
         FyTVMI/hB4FZd0dt5hn21tVWJbamIep9EqdYC84mHWLIl1eie0nf7qSro7wqfY67030O
         MXkvkGTUtJMeq66M060w0TARGVc8356F/f5ICLrhbxo9lNnFjbW0lq5Q3XPJZ0ArmMY1
         2kZA==
X-Gm-Message-State: AOJu0Yz+PwW8YxlOyl/HWfHP2mCuOZx60UUMnFiPaEZyaYI6DpXEhDnr
	eW9Cl8NfJ3/T/1zY63nLewrX6OI4FuTkQk/YPrnnTY+UwdHnz7FB6Lkg6RSVBefg
X-Gm-Gg: Acq92OEmSpVNf4f9jzkxc7W+ySLZDFi/tfYHTdiDFUzcjdNxn1uTVMVR/BaUz2wsaiG
	msxgjMUJvVdMsqJXDWyzJ44guCaKcKpwgE86xlHzjKNE6w4sVw9WWLGBqrftGBv8I8SMWmuyTi0
	iryrzxUGLpx1ShjeIlU+z6U4eXsvgjuhX7rRcPFSr8yQCRoq6P7YE2S2dpNZt2vdhzLGI3i4dWa
	MKW/N0Ik07Qn1WEnVyzyU8mEvb7hEPg+CjLpQvPz3ikUZsG2jpKHJyZPgLDcave8uDq4ttkBc79
	LscY47ZwlPyfIv2V5ZZNU1+TdGs1X57CeraIbPMmOnx+ESxauJfK6QH3MIlKTMmbozNDAAMbzwn
	hrGAQ54O+5Vcx3bwZoDhjw+1f9bNp8y0Hdx1NIbbWrCgw8m1UJQHcYdiO/J62DnW+ofLIjnOtxI
	SppuKPcnQ/ztCONzwdirvLWwyqL7nr5M/vu6cvFQTI/R2xdMiI0IIbJvyZgpDxXIqftC9voIER9
	SRK6iZGNBog+hI=
X-Received: by 2002:a17:90a:fc4c:b0:36b:7f69:c152 with SMTP id 98e67ed59e1d1-36c501b813cmr4888574a91.18.1780181215735;
        Sat, 30 May 2026 15:46:55 -0700 (PDT)
Received: from Ubuntu.. ([49.37.171.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36c689cb2b7sm3332611a91.7.2026.05.30.15.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 15:46:55 -0700 (PDT)
From: Manish Baing <manishbaing2789@gmail.com>
To: jk@codeconstruct.com.au,
	matt@codeconstruct.com.au,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	manishbaing2789@gmail.com
Subject: [PATCH v2] mctp: serial: replace memset with zero-initialization
Date: Sat, 30 May 2026 22:46:46 +0000
Message-ID: <20260530224646.160777-1-manishbaing2789@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293365-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manishbaing2789@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 844F7613AF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use empty brace initialization (= {}) instead of explicit memset()
to zero-initialize stack memory to simplify the code.

No functional change.

Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
---
Changes in v2:
- Fixed a compilation error caused by a duplicate variable declaration caught 
  by the kernel test robot.

 drivers/net/mctp/mctp-serial.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/mctp/mctp-serial.c b/drivers/net/mctp/mctp-serial.c
index 26c9a33fd636..df721ca4e07b 100644
--- a/drivers/net/mctp/mctp-serial.c
+++ b/drivers/net/mctp/mctp-serial.c
@@ -536,13 +536,12 @@ struct test_chunk_tx {
 
 static void test_next_chunk_len(struct kunit *test)
 {
-	struct mctp_serial devx;
+	struct mctp_serial devx = { };
 	struct mctp_serial *dev = &devx;
 	int next;
 
 	const struct test_chunk_tx *params = test->param_value;
 
-	memset(dev, 0x0, sizeof(*dev));
 	memcpy(dev->txbuf, params->input, params->input_len);
 	dev->txlen = params->input_len;
 
-- 
2.43.0


