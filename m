Return-Path: <netdev+bounces-86382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CE489E8C8
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 06:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49C4EB23E8A
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 04:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4A48F44;
	Wed, 10 Apr 2024 04:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="kVT8cq7b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EE610A03
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 04:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712722977; cv=none; b=sLo43T/YrcnKuTwvKm9IY38hJqO4eNm/n3kwzHJuYUZ5k4++OXThGWR1OQL8I5XfuceKjLqiFWRkxgFVUY/C1mo147Du3iAASjV5vKbAa00e08RuCfVUXW5pQLrDDHYnAoiG5KV/VZqkHAtnxX8QoXKSmF3p63dxPqjzb80Mklc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712722977; c=relaxed/simple;
	bh=9X8K69Z9AlUuQYNsXtc2K5ZmdBKKto46xQO0C62fowo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ow/P7QdjRUUazZ9A7PYFajnKry4Z6+n5lXb36GTDcfK11eRtDQG8gOmojMhqegVkrYba+v8rAzN5eh5M87BKFMuFU+Wk8SvxU3SjTNEMb11ArLxFL1SJ5B45Fe523xt0IxuA0rYB/mu9AQaHR2bYyn9n9mIIVViolIC45X9JeFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=kVT8cq7b; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-3c5f38fabcbso716861b6e.3
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 21:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1712722974; x=1713327774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nel0BDOQg9x0X/rMPJc3bspVJYDD63CLeCUabNFV1dk=;
        b=kVT8cq7bZMHPYj+CNS23cDd+bVTHdPfExOu37ikF+EXYDVtdu/rczdSIa8U97KjAEe
         wyYDkHGYKUMTCI02XNAhqKsczUybCd8EyedWVWd3FcqhDS68fOsB5/09q8RGeJRXf2u0
         7+Jtr3UgDKT3w7++8WR84XOo2KgL372KIHH/Yju8wlK+QkHQld/WWLZOoV/7MEvW3jqx
         DJz68QwmKK/X1/DBEFLlBuvRr/HUZRBZx7iCGT4Hp3Hvdq61QE6MdIoPrlYoV/NrgOnI
         egr3TBevlZ8hFoiOnCQZyRo9lms3iBA6pQ3cY/r05Zv8a1aKesYBx1EzVdmpN3l1rpuA
         x3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712722974; x=1713327774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nel0BDOQg9x0X/rMPJc3bspVJYDD63CLeCUabNFV1dk=;
        b=q/31Jnd9QXp2+djtG1qlhAlJAKSt7jUqqF7Y1mc8zO8F2idsnKo9R3Qtn1pO3zHGhT
         vI8Y09PMkT+tTSHoS4wCAEYpWtbWdULZwwDJJrxTlW2EqLV129aoXogZ9+O47Q0Riel9
         vbjlRnpQwUk7C5ix3MqigUuUOVx30olUo5qcT/IcW4UHCCzs7NLI7PKpQvarsjMOAcTz
         M8A3ukiOBzzjfXV2PV2uFiNYBQblFTPKxCWAjba3WIoBKBl0jd93ztAnvpGcNV+RMTmq
         3ga2wcoCa6arfDVwRNe6W2ORngBO+sLOZwiqkB6W+r+i94ENfsrn6iA0ObOgOBpZtWPg
         vscw==
X-Forwarded-Encrypted: i=1; AJvYcCXmvLrlkRA6llJnI9CF1FI76cDAf+zoRpqo+Fymu710bpFBOiG2uKPGSVqlEiYLFqJmuG/sFemGDepSOKEEyPPXcrzvGtvj
X-Gm-Message-State: AOJu0YwAMuwYOQFXcE57xfXUca6Mg7YWbaT4V0wKk1pkPVq3No4moGKJ
	krkunZIhoJEeR5IkC+/l+7rjY26E7/HDwWFM41+sNxdGO2rw6bC14ZHTvLFSf8g=
X-Google-Smtp-Source: AGHT+IEjLSHWQzsXdB08KDkWZi4Rm+0b46QwgSQ/meOmZHKvCWbCu4ldgeOC3Wi7WtNhudyHeXaKLQ==
X-Received: by 2002:a54:4809:0:b0:3c6:5da:1635 with SMTP id j9-20020a544809000000b003c605da1635mr1705770oij.3.1712722973485;
        Tue, 09 Apr 2024 21:22:53 -0700 (PDT)
Received: from localhost.localdomain ([103.172.41.206])
        by smtp.googlemail.com with ESMTPSA id ll24-20020a056a00729800b006ed97aa7975sm1722125pfb.111.2024.04.09.21.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 21:22:53 -0700 (PDT)
From: Lei Chen <lei.chen@smartx.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lei Chen <lei.chen@smartx.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] net:tun: limit printing rate when illegal packet received by tun dev
Date: Wed, 10 Apr 2024 00:22:44 -0400
Message-ID: <20240410042245.2044516-1-lei.chen@smartx.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_worker will call tun call backs to receive packets. If too many
illegal packets arrives, tun_do_read will keep dumping packet contents.
When console is enabled, it will costs much more cpu time to dump
packet and soft lockup will be detected.

net_ratelimit mechanism can be used to limit the dumping rate.

PID: 33036    TASK: ffff949da6f20000  CPU: 23   COMMAND: "vhost-32980"
 #0 [fffffe00003fce50] crash_nmi_callback at ffffffff89249253
 #1 [fffffe00003fce58] nmi_handle at ffffffff89225fa3
 #2 [fffffe00003fceb0] default_do_nmi at ffffffff8922642e
 #3 [fffffe00003fced0] do_nmi at ffffffff8922660d
 #4 [fffffe00003fcef0] end_repeat_nmi at ffffffff89c01663
    [exception RIP: io_serial_in+20]
    RIP: ffffffff89792594  RSP: ffffa655314979e8  RFLAGS: 00000002
    RAX: ffffffff89792500  RBX: ffffffff8af428a0  RCX: 0000000000000000
    RDX: 00000000000003fd  RSI: 0000000000000005  RDI: ffffffff8af428a0
    RBP: 0000000000002710   R8: 0000000000000004   R9: 000000000000000f
    R10: 0000000000000000  R11: ffffffff8acbf64f  R12: 0000000000000020
    R13: ffffffff8acbf698  R14: 0000000000000058  R15: 0000000000000000
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #5 [ffffa655314979e8] io_serial_in at ffffffff89792594
 #6 [ffffa655314979e8] wait_for_xmitr at ffffffff89793470
 #7 [ffffa65531497a08] serial8250_console_putchar at ffffffff897934f6
 #8 [ffffa65531497a20] uart_console_write at ffffffff8978b605
 #9 [ffffa65531497a48] serial8250_console_write at ffffffff89796558
 #10 [ffffa65531497ac8] console_unlock at ffffffff89316124
 #11 [ffffa65531497b10] vprintk_emit at ffffffff89317c07
 #12 [ffffa65531497b68] printk at ffffffff89318306
 #13 [ffffa65531497bc8] print_hex_dump at ffffffff89650765
 #14 [ffffa65531497ca8] tun_do_read at ffffffffc0b06c27 [tun]
 #15 [ffffa65531497d38] tun_recvmsg at ffffffffc0b06e34 [tun]
 #16 [ffffa65531497d68] handle_rx at ffffffffc0c5d682 [vhost_net]
 #17 [ffffa65531497ed0] vhost_worker at ffffffffc0c644dc [vhost]
 #18 [ffffa65531497f10] kthread at ffffffff892d2e72
 #19 [ffffa65531497f50] ret_from_fork at ffffffff89c0022f

Signed-off-by: Lei Chen <lei.chen@smartx.com>

---
Changes from v1:
https://lore.kernel.org/all/20240409062407.1952728-1-lei.chen@smartx.com/
 1. Use net_ratelimit instead of raw __ratelimit.
 2. Use netdev_err instead of pr_err to print more info abort net dev.
 3. Adjust git commit message to make git am happy.

 drivers/net/tun.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 0b3f21cba552..ca9b4bc89de7 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2125,14 +2125,16 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 					    tun_is_little_endian(tun), true,
 					    vlan_hlen)) {
 			struct skb_shared_info *sinfo = skb_shinfo(skb);
-			pr_err("unexpected GSO type: "
-			       "0x%x, gso_size %d, hdr_len %d\n",
-			       sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
-			       tun16_to_cpu(tun, gso.hdr_len));
-			print_hex_dump(KERN_ERR, "tun: ",
-				       DUMP_PREFIX_NONE,
-				       16, 1, skb->head,
-				       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
+
+			if (net_ratelimit()) {
+				netdev_err(tun->dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
+				       sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
+				       tun16_to_cpu(tun, gso.hdr_len));
+				print_hex_dump(KERN_ERR, "tun: ",
+					       DUMP_PREFIX_NONE,
+					       16, 1, skb->head,
+					       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
+			}
 			WARN_ON_ONCE(1);
 			return -EINVAL;
 		}

base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
prerequisite-patch-id: 8952e320c0272899e153c953db09446879ed0d87
prerequisite-patch-id: 2f1e3234a4ac0bf421df2061505612538f128672
-- 
2.44.0


