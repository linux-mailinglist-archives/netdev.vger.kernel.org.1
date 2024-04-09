Return-Path: <netdev+bounces-85977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF5689D252
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 08:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61724281E94
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 06:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C622F71B3D;
	Tue,  9 Apr 2024 06:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="mBd5Jynk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AC95467C
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 06:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643880; cv=none; b=gTOGsVLGS9UH9onWs2au0fZCUhJq8iySFTN/xgLL5pmDqEpmRev+n635DcB9wnmW/5IUCHEO68rV8Sng07H2OGRmgs8UOiUsPufCtlYtGJkMiHEF/aQH1lo5/ZQlPvfc4LW6O+KOkX0afiA60ac1Qpe9YY0yhbrs1AD5Xyz6uH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643880; c=relaxed/simple;
	bh=hVKnFrLXVZo8p+orNJL7U1TZAHHwpoF0x03Pjb20TCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZzU6fXvMRskM/XkKxMV6h6QafaV1QcSyKyrtxJHvoVBjJkAJuwsat38//QB7a3GhlFq728QfcYjFO7InohFH709ObUrrCzwGBYItGODZ2d6VVYEOU4VA/LB7B+W+Jrf2k35xbL7R9WeOrzOyV/pH8+3hwdbafdeC4/q68tYRo4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=mBd5Jynk; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so3511906a12.0
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 23:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1712643878; x=1713248678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g6D3U2MYkd4kdAs30T5VMng1DzF96mHXquQn1nVv4ZA=;
        b=mBd5Jynks25yreFEZQWRSRjY4Yem2lFqSfqIGYy0OCXwL893b8UT4dUwOPCIfeVDyV
         UWk5epMxi0vV2t+xVtC1BzqzcFg77xGdCC9+kqSld+KHqeZMzaO8JWMrvzVJHUECm/jV
         saTwn0xvhSemn3RlvwF+Bc31JQstmHm8HaXk0wUwU3MaIBWE4QgrmbuWvu71BfWsRisd
         FX/vUhWWB5aPtWiM/2AU77RdLsDr4pE2qW/skyBzyTnsIqiEsYWSeHONrSYbjn2l5rgU
         0UYkewDzMuYF4COYfEmLr2pDjkMMauRLeJEw/QFGwR3B7G0joa2BLHn/G8eg6Z7K0n8z
         bF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712643878; x=1713248678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6D3U2MYkd4kdAs30T5VMng1DzF96mHXquQn1nVv4ZA=;
        b=NKoaz3sKzqxQFNLqKekXI01YL5kLHG5AViB28XQKSzfg9sEFLcEl5LgimhRnHDvLMi
         6sv8eBDD0/q38J4859fRyhL5bzzvN3j6XOqLxFEotxBJi2KOgpXTuYBlyL4SR1HTZhZd
         mlNztA+Xwx0ZWmLdmGBE9bw3w0H+aAgnl/x5c4/9yNoOPjeuXvh8r51BK0NvU8yI4Qvo
         x3hrpVHCL371LNnkpziS1YrWq0+4P7ZquhXlGkDWMK+V9WenDQiUTQNG/tAVWLcRIcM/
         u8XwfXI0Y7U6r+p5ockzf49jP5hLZJTo3UOC1beL5/opH2LacobOwz//1gEVQm0LZGbR
         Us9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCymZdhohSZ4Eo+76HCFG5hXm65k3MHe+XIVu5vgYCtzyotDflVNs/2G6KslH0+KWfLrgLGcPfCyxEG2fqQAS6yxUTJK1x
X-Gm-Message-State: AOJu0Yx0HctLXef8T7HwE89ShSeNy3GM4f6RPVUlADhDFC25CFBYMv7z
	lppmArEagOD3iQoNNsTAh+i8mKzglMq7RLMOZIG7cz3jLBu38mGiTfpe1ilnkwk=
X-Google-Smtp-Source: AGHT+IHk8SNceULlelSKpjfik0Ixk4C2Iug/nD5xWOoL0/StFu5CRaSBKWkAto4Tbf41CVCY5kkl2w==
X-Received: by 2002:a17:90a:fa92:b0:2a5:3c66:25a8 with SMTP id cu18-20020a17090afa9200b002a53c6625a8mr2754090pjb.15.1712643877210;
        Mon, 08 Apr 2024 23:24:37 -0700 (PDT)
Received: from localhost.localdomain ([8.210.91.195])
        by smtp.googlemail.com with ESMTPSA id h21-20020a63c015000000b005b458aa0541sm7372906pgg.15.2024.04.08.23.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 23:24:36 -0700 (PDT)
From: Lei Chen <lei.chen@smartx.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lei Chen <lei.chen@smartx.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] net:tun: limit printing rate when illegal packet received by tun dev
Date: Tue,  9 Apr 2024 02:24:05 -0400
Message-ID: <20240409062407.1952728-1-lei.chen@smartx.com>
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

Rate limit mechanism can be used to limit the dumping rate.

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
--- <NMI exception stack> ---
 #5 [ffffa655314979e8] io_serial_in at ffffffff89792594
 #6 [ffffa655314979e8] wait_for_xmitr at ffffffff89793470
 #7 [ffffa65531497a08] serial8250_console_putchar at ffffffff897934f6
 #8 [ffffa65531497a20] uart_console_write at ffffffff8978b605
 #9 [ffffa65531497a48] serial8250_console_write at ffffffff89796558

Signed-off-by: Lei Chen <lei.chen@smartx.com>
---
 drivers/net/tun.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 0b3f21cba552..34c6b043764d 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2087,6 +2087,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 			    struct sk_buff *skb,
 			    struct iov_iter *iter)
 {
+	static DEFINE_RATELIMIT_STATE(ratelimit, 60 * HZ, 5);
 	struct tun_pi pi = { 0, skb->protocol };
 	ssize_t total;
 	int vlan_offset = 0;
@@ -2125,14 +2126,16 @@ static ssize_t tun_put_user(struct tun_struct *tun,
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
+			if (__ratelimit(&ratelimit)) {
+				pr_err("unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
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
-- 
2.44.0


