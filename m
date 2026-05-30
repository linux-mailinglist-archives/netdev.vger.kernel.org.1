Return-Path: <netdev+bounces-293356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HGwLH0nG2qS/ggAu9opvQ
	(envelope-from <netdev+bounces-293356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 20:07:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9A8611095
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 20:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBA47302AC30
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 17:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834873B6359;
	Sat, 30 May 2026 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KA9E5+zA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0CC2628D
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163790; cv=none; b=OvL4yKxqDephYiq8qp8AVHAeYhnTAs+unaztZYvheBKCtU8mrhwlsvbnFfbj7lKj/zg3+UP0Wu+DSq0ZrWBNRJcPrL1TcoTrU2SiQ5Ns7jvn7B0HO90W1u3DH9qsDgvgdw+MNXsM5JMAd5xLdwzxREfcjqWg+Lhf8pjI1XUL6K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163790; c=relaxed/simple;
	bh=n3ZSQBD/H2AW1xNyzx0em2UfFE2UePZMJLqt3Gkk5Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TQtGl9NyGpU434t0bkns9uws9+gK+mGcrn98M4YOkA0qVVyhOulRQtj9nfLCVALBPy5m/9zvFzMxjNjia27YusL7p65r1Ljx7UUrXG1XTc1evykDM0MnrBE0M3fej4jAA0RLG38mdaFSUcUT/R9eZqF5hE3mYr8OpJpV3R2POOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KA9E5+zA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bea7176c72so74175635ad.0
        for <netdev@vger.kernel.org>; Sat, 30 May 2026 10:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780163788; x=1780768588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iroh2YBoq0cKDytA5DDegc2gyEIJygN+FydCkVruV/Q=;
        b=KA9E5+zATcsaTHEgn20ETk0xQ5NEMw3pjQsWCu3Nj/niC5E0+Qdw6wKqjnyFnbhpwa
         +p80ugpCltyBSd8B5tXDXlAx0gwvgIO5/+gBTLz8X+hAnnmj9BSVXSjpBWMtLczAjY4n
         ubIHqdzpFbZW7c0i+01EuJyexxYn7/+5eXDIBjqq33BvRixFd+lht5jcC2+pofuczsPh
         cpFmrtzJ+lNRljDv7LkyahEti1mtEojhCJkd2Ep7Bx5fOMuMf9dLuTbVDaQKnI7LBtXR
         xAeV5LU4QmC1am2Uy4Gw1IXErkuxU+h7lkhNcslO2NweDwsLzYIPlT3IuL+OD8Q7kjkx
         IfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780163788; x=1780768588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iroh2YBoq0cKDytA5DDegc2gyEIJygN+FydCkVruV/Q=;
        b=F+4TIB9gI9FB15DVL0fWq4cWk+nfIXdTDXrU2+bVp96a/xwOffvZTpdUsgZIcWQ3xA
         FsIZfKjgjmyD5DGRPM481unX13f8yv3GW4tb77x2rleOcGb5RTpRVhf8AE8n8kNR1tv1
         o8heUJykpND6EaJrm2fgtKqEnsv3/k0/poZvMkdZhtVMb6Zh5i6N0a0es7gYOUWsuDMX
         cqLnTfp9vQWzOL/abidOyCa0Mu1//FDsltmzrghuuogpI3FHozxugLVJTTE8v2ecKGSv
         gwHVY66YM7XUOptJnNJx+PR+xonDeBfa+JkTNLTSTZMO6rDLV2gR67VyNu5kPJeMuOCW
         oG6Q==
X-Forwarded-Encrypted: i=1; AFNElJ9nVrjRcxmaN4VANu42cXMAlMlKw+BqQqv9l3BEwCe2wDZTJ3G3zi12R+Rn+OHlGyGx7XOaNDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4wlV8fVo3ja94o0aZI0mcfg59H7v2isgViQf5YXs7KP1o3H3P
	HbPX9tJOyF/YIcIteXBYy9iW0oK9A3w8JIvyIiO8PayvUnNCaKvx5J6i
X-Gm-Gg: Acq92OFOMoj/675NggiOY699EFrNKke4eHGJouS9b6LLuemEKPH6rhakX/gYjpp2ss9
	h12xeayum/EnG9TjlDM/xY5mfbxHSGCl+JrivdsN1v1Y3dMTynaz39gssSpXy9+74ktyMNhrb4s
	her2gbiF4e/R3svQDM8q797D15pM1DroBjEfzBh4tK4rBqAk5rnTJefk7oNTht94T+4YhVYLIT5
	Bw4B8oIyN2Lujshb6i7kAMSmpPVc2gLGjQP16xNPBE5qqM9i59jUxWAroxiq8XTc17Z4X3R5Mr4
	oOX8htKylIwfVrkNNBSfs6AnKlMhNNMGDU9EOh0f0y83qeCPdPl7TZq9n2KCXkFYiqVycHtbr+p
	J3JLd67MBvAf9I3ueIEny7Fg2t89FyeFbfk/0K/bidBzLxVFGERX93gRLHAU7/w8TmUOjwmEg6L
	jmiGedBXS1vZx5JZWb1pLXf7lJEYC5s3JM0cUIqU2KWQ+ntxXxY1sC5vm6HTknid6bFrkzvJQA6
	J19
X-Received: by 2002:a17:902:ea04:b0:2bf:1d01:7b00 with SMTP id d9443c01a7336-2bf3683beb5mr58332515ad.23.1780163787787;
        Sat, 30 May 2026 10:56:27 -0700 (PDT)
Received: from Ubuntu.. ([49.37.171.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c580c6sm56791215ad.82.2026.05.30.10.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 10:56:27 -0700 (PDT)
From: Manish Baing <manishbaing2789@gmail.com>
To: jk@codeconstruct.com.au,
	matt@codeconstruct.com.au
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	manishbaing2789@gmail.com
Subject: [PATCH] mctp: serial: replace memset with zero-initialization
Date: Sat, 30 May 2026 17:56:18 +0000
Message-ID: <20260530175618.135533-1-manishbaing2789@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293356-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3A9A8611095
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use empty brace initialization (= {}) instead of explicit memset()
to zero-initialize stack memory to simplify the code.

No functional change.

Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
---
 drivers/net/mctp/mctp-serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mctp/mctp-serial.c b/drivers/net/mctp/mctp-serial.c
index 26c9a33fd636..c97ebd1af356 100644
--- a/drivers/net/mctp/mctp-serial.c
+++ b/drivers/net/mctp/mctp-serial.c
@@ -537,12 +537,12 @@ struct test_chunk_tx {
 static void test_next_chunk_len(struct kunit *test)
 {
 	struct mctp_serial devx;
+	struct mctp_serial devx = { };
 	struct mctp_serial *dev = &devx;
 	int next;
 
 	const struct test_chunk_tx *params = test->param_value;
 
-	memset(dev, 0x0, sizeof(*dev));
 	memcpy(dev->txbuf, params->input, params->input_len);
 	dev->txlen = params->input_len;
 
-- 
2.43.0


