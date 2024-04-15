Return-Path: <netdev+bounces-87753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B30218A46B1
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 04:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611761F219B8
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 02:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA01D29E;
	Mon, 15 Apr 2024 02:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="KfhJzkf7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEB16FCA
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 02:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713146588; cv=none; b=uXy9tnX9JEFWfqX4aqxS94qhUCFyUinYBiROLjgq8+Sb+3zgUBLln9mXlDl1bamstUydi5N3V+gSjtCArGrvKK2aytjGk9vk508yGebGYnLcssyuBbaGDEQX289dzS8OLH34taqQGr03UoXdP9Yi1E2gChJ8PpTPoKkk4vDeeSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713146588; c=relaxed/simple;
	bh=LLUxWlLv0vqmiHJ1UIZeaRzH8/vNgpEkiTxlBMPS6dI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kCEZoIlvKhrcDza/fzw4Wnrwk7tcggO3A4PEv+I2waqqJk1sLsS6C6gH+alw05HELrLiCWiSJmPGieKyq5ANkVfB4R00c1ylVQtgqkdpKenGThIbhBNbc9BbDE9Xsrjjz6pNWh8A2UJnQ7c2ZnTEchv2fxMH2ZrGQ9feruLx36A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=KfhJzkf7; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-1e411e339b8so21242995ad.3
        for <netdev@vger.kernel.org>; Sun, 14 Apr 2024 19:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1713146586; x=1713751386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VsiaKifJOZA0qRUVE1+neEb+M+HY5irGf4D2Q2Uktwo=;
        b=KfhJzkf7E731gNDQgo8qvjwBCVC+V9vUgkem78VvHQVjPhFGQ6m04QyhAMvwwzKHoF
         Iebi0fUIXQKmSCuD9tPttTodF5EYWQAehf4HX2Qjr81x1hokV9l4Dyo3qGzm5KR92AAk
         +tmuFJUPdhD4cBxGgjgkHDS+U7gZW0upxBvwzJhqlQuTzu25bvzssI4mlLot+c8v4VmL
         pAQaJBvtDOUFEUNNr5IMw715Cy9ey9tS7OmU4W6jkJ6QN+53tviQs0+B2SOjcX3gjXq0
         ykwiwfiyEur8CmTdqpTWyaTS9Nvms3hK6j5t8tWjrHv4pi9xUchMBpdlKywUGAmXqxbC
         fI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713146586; x=1713751386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VsiaKifJOZA0qRUVE1+neEb+M+HY5irGf4D2Q2Uktwo=;
        b=gOLapgtwYJhihUF4ftBH9RNxVsqPQq9jTQcL5Bo6gGAfT/BW9P07hjpwmxQ5aO7QGk
         YBdGGhaiz3Bq9ynaXMPeLMn6J7r7hYaq9L+FVh0xPLdyA6qIpYTn5HLDhYTbIMFdo/Xi
         GmrsDeevI+WOGevUYwPN48tqsAswj1XqmZlFnerwDVnlbSKo2KmpgDObGAb6CMGsVZMr
         uDvDu0546Gd/iCQeWUqBYH2pQFg0e4+YnHx8c53WxdqCcFFV+CN9PDwunFGjr5D4rW24
         9B1n+UxxRJDvFVFUu3usY+Es9NGfsCQSA1OqtkjvLSLli76pyYUS26ZRIPAbjbPb2bOH
         ra/w==
X-Forwarded-Encrypted: i=1; AJvYcCUyW/LyRmc38vuQ5eet1xogRy5UaWL30ia0Gt8hVEa8WmfwfZXe78ESos5dkzQGtl778CIFtQbtVOd9tQ9dC5vzh1kbSDCL
X-Gm-Message-State: AOJu0YzqwvWO9+rztJac8712+uPbyKxrENCZEa0fQ2JN1+1NOP2visFy
	cKF12mDS0MRxNtDe544pWy7ySkrt8Mpwe8r0JQHL/yKKl6wJztwchq7tT4mKWTY=
X-Google-Smtp-Source: AGHT+IFh1gnp53lS1uAZMRwhtdRmABsUTOLGcITiE0+jq7U8vWTjdjGd9ie6v4eS5XIVfJrJ9KbAkQ==
X-Received: by 2002:a17:902:db01:b0:1e2:bdfa:9c15 with SMTP id m1-20020a170902db0100b001e2bdfa9c15mr10660073plx.41.1713146585341;
        Sun, 14 Apr 2024 19:03:05 -0700 (PDT)
Received: from localhost.localdomain ([103.172.41.206])
        by smtp.googlemail.com with ESMTPSA id y2-20020a17090264c200b001e205884ac6sm6897872pli.20.2024.04.14.19.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 19:03:04 -0700 (PDT)
From: Lei Chen <lei.chen@smartx.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: Lei Chen <lei.chen@smartx.com>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5] tun: limit printing rate when illegal packet received by tun dev
Date: Sun, 14 Apr 2024 22:02:46 -0400
Message-ID: <20240415020247.2207781-1-lei.chen@smartx.com>
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

Fixes: ef3db4a59542 ("tun: avoid BUG, dump packet on GSO errors")
Signed-off-by: Lei Chen <lei.chen@smartx.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
Changes from v4:
https://lore.kernel.org/all/20240414081806.2173098-1-lei.chen@smartx.com/
 1. Adjust code indentation

Changes from v3:
https://lore.kernel.org/all/20240412065841.2148691-1-lei.chen@smartx.com/
 1. Change patch target from net tun to tun.
 2. Move change log below the seperator "---".
 3. Remove escaped parentheses in the Fixes string.

Changes from v2:
https://lore.kernel.org/netdev/20240410042245.2044516-1-lei.chen@smartx.com/
 1. Add net-dev to patch subject-prefix.
 2. Add fix tag.

Changes from v1:
https://lore.kernel.org/all/20240409062407.1952728-1-lei.chen@smartx.com/
 1. Use net_ratelimit instead of raw __ratelimit.
 2. Use netdev_err instead of pr_err to print more info abort net dev.
 3. Adjust git commit message to make git am happy.
 drivers/net/tun.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

 drivers/net/tun.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 0b3f21cba552..92da8c03d960 100644
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
+					   sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
+					   tun16_to_cpu(tun, gso.hdr_len));
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


