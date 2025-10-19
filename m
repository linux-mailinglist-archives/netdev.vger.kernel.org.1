Return-Path: <netdev+bounces-230713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3E1BEDFE2
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 09:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3801189E4D6
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 07:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D612B22836C;
	Sun, 19 Oct 2025 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBECEz4w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6198D7483
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760860565; cv=none; b=jxCGOjFWR5So8dDX9sUPBxNcw55TgR0AhH4DXaBhFWfys/bt3RwOhGKPe/3VGS9c5YglOI4vEurZx6Kzu5u91cH4w0ECT8STzRZm3Elb8n+uJL5gJfqi33kdxwDgbAFVPapwOJemHt6ndy9YemGIuecuI3a5nK7qD/qf5rs3OkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760860565; c=relaxed/simple;
	bh=mVLXF4lEwtvDzcwn7LlkjBNH+v+CCXpaS5jhlxOHKcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NKE8fYjyjMKtnd0V8gbV97CeEOA6BxQSg19J6cCuqaZoakAEGc3T3h8AKt5vEEhitxWzz3dVgJZjzrlIOdOSXwz61bqHx8VIAOQmIDASPS8j1sydLnRMdZ15kPpyfX4GyO+J8B1N8on/cztSZKkPzIk0P73uSNd3OmNDqfqgOmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBECEz4w; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-269af38418aso38732525ad.1
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 00:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760860563; x=1761465363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3F6oM9Agr2FPxSXT/W3lN8s7vDqk89rfSGq18riZTFo=;
        b=eBECEz4w9T+cIjgDerVnQBr0k5C4LzWj99rHH8Z+hKBm5ABca75K4ZKBOKrAHpVn1L
         pom4hQ1+JfK8i/HNaEz6KwtKjVUj50BO+ljUVd1EtZO5aO9e7Zo8au1wnZgDnEkSA7yx
         c+xLE/9z43IJaebBweYQJMyw7H0i5iPEnFfOGFsS9QM6Mk0aBum5gnsN2eXxOmoy8nNu
         3OE+/rOEBu1vBg/cMJIGObNJ4fYcsW1Vh86S3e6kSLAxPeVk9dd5xzpl3lLnon3fScgg
         S2RsfYJVQCaBgblTMluiHld5jeCQhh4u5gk+ZEhXla8Oa75b+L5/ASLWlpOXSlAckkcf
         ps8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760860563; x=1761465363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3F6oM9Agr2FPxSXT/W3lN8s7vDqk89rfSGq18riZTFo=;
        b=ngDO5Dy7LPgESyAl2XfsgcncBtwhKV6IUA253raSOKwEBRNjGq22xjWAq83d1Oz/0M
         l2lJ0Tc/i3KDwcmEA2xLGENGIsKBs8DJc9ZrQEx+qfd5H6+yA97CJtDQKpMC7bgDgYTm
         d3kOPYZ1r3p+5tQKjUxgggWW9ptOyyXHW1R76DQIDfaADFwlXUnbGlGeFVUkJ69O4rgg
         o6uymW5wa/GS39a9jWpEtMu+w7rqW9ODUgq92jZi27j7es14pKJhje9Lb7ppMJIFEeC4
         7m1rjgbZkQTdHUnTE1TMr3RGbqnO0Rznk4fStjX2ygpoL0n1MhsQilm4Pjv26qPj5bo3
         S8Wg==
X-Gm-Message-State: AOJu0YwbEZ6DxNanoEG5/3a9DqcHbpkDqbczAU/K9yVxnbnBpj0w0Bnz
	oipLJWqF4W/QvDi20uJm6eK8P6+2VFZMI8Ycp2vfPRxlsMJ5y6nCJmoV
X-Gm-Gg: ASbGncuzsRe0MRcyKt1YpcIwSDvsVP9ZvcgLtgvq8TMBcZqZrXkEVM5FW1vSWuNSWUi
	kpwcjOkh7ZPQ/qvTkC8VXMbuEccn0NWGogTHFBXKIz2t4CHGk2AyH/xHdPKNd5McncLjJ5hWCCz
	HBA43Ua6iQsK82no7vrTcc7Vd0RE3TNbeskfBWVd5nqLF5mfexeC9/QGByqnhgcKfUn5a1Fa54S
	5LbBVrb/ynf2TbE5G5NzmnVl7ht8gqLfZfLMX8p9hooDRUWqB5gYhAzfouZAdjACTlOkcAcLOB+
	XKYmWlFKQDf8HcskvISbNpzSwShi/7dFdDn4mPMdVWqhfjRx8ulRlrVnoci2SnKWXY2I3IEzIDb
	Z+cHHpWrSXv58iH0frdXJMhb7Y0FzJvVsD6iVgAKQUtEKs1lx+q9mrYA1MnPKxJRwELEzWcWi5n
	OQQ3E3oU3uJz8PHGUM9ZTlw/A=
X-Google-Smtp-Source: AGHT+IHp7GBC91IZMRt5+CX0l2Khc9Tjxa3JtCmaKfz/d0LS6e0hmTCYCeXlwhSz8nZBUUiCPbUPuw==
X-Received: by 2002:a17:902:ea04:b0:269:74bf:f19a with SMTP id d9443c01a7336-290c9c89fc5mr123658105ad.11.1760860563331;
        Sun, 19 Oct 2025 00:56:03 -0700 (PDT)
Received: from mythos-cloud ([125.138.202.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ffeec3sm46200955ad.52.2025.10.19.00.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 00:56:03 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2] net: dlink: use dev_kfree_skb_any instead of dev_kfree_skb
Date: Sun, 19 Oct 2025 16:55:40 +0900
Message-ID: <20251019075540.55697-1-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace `dev_kfree_skb()` with `dev_kfree_skb_any()` in `start_xmit()`
which can be called from netpoll (hard IRQ) and from other contexts.

Also, `np->link_status` can be changed at any time by interrupt handler.

  <idle>-0       [011] dNh4.  4541.754603: start_xmit <-netpoll_start_xmit
  <idle>-0       [011] dNh4.  4541.754622: <stack trace>
 => [FTRACE TRAMPOLINE]
 => start_xmit
 => netpoll_start_xmit
 => netpoll_send_skb
 => write_msg
 => console_flush_all
 => console_unlock
 => vprintk_emit
 => _printk
 => rio_interrupt
 => __handle_irq_event_percpu
 => handle_irq_event
 => handle_fasteoi_irq
 => __common_interrupt
 => common_interrupt
 => asm_common_interrupt
 => mwait_idle
 => default_idle_call
 => do_idle
 => cpu_startup_entry
 => start_secondary
 => common_startup_64

This issue can occur when the link state changes from off to on
(e.g., plugging or unplugging the LAN cable) while transmitting a
packet. If the skb has a destructor, a warning message may be
printed in this situation.

-> consume_skb (dev_kfree_skb())
  -> __kfree_skb()
    -> skb_release_all()
      -> skb_release_head_state(skb)
	 if (skb->destructor) {
	         DEBUG_NET_WARN_ON_ONCE(in_hardirq());
		 skb->destructor(skb);
	 }

Found by inspection.

Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Tested-on: D-Link DGE-550T Rev-A3
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/dlink/dl2k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 7077d705e471..6e4f17142519 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -733,7 +733,7 @@ start_xmit (struct sk_buff *skb, struct net_device *dev)
 	u64 tfc_vlan_tag = 0;
 
 	if (np->link_status == 0) {	/* Link Down */
-		dev_kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		return NETDEV_TX_OK;
 	}
 	entry = np->cur_tx % TX_RING_SIZE;
-- 
2.51.0


