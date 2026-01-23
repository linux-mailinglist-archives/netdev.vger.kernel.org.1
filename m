Return-Path: <netdev+bounces-252966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBGBAo3dc2nMzAAAu9opvQ
	(envelope-from <netdev+bounces-252966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 21:43:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 705107AB3F
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 21:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7994B303F7FF
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2F72ECEB9;
	Fri, 23 Jan 2026 20:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CFHtDGzJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDF73EBF31
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769200878; cv=none; b=WY7kDoBLHZKov5o0BxYeVCgvAfM/MsZxZIFMWbSmlskC0yvj6CpHb0qTzdPOv9MWJQe7NRia1LalAwkYCSQeFQ5RtxEoLNXPqNMI6vkZtit0lTdTLxCTl0ScY6AB5v/q6uw88qIZzYfjzYFxAH66kBYeMsR2tjm9iVdleLwdMbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769200878; c=relaxed/simple;
	bh=Ge1BYLj4o1RylNM6YHics8YMRzeFye431Sj/cQyD8D4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bfZCLrSsOh3msdxY0PnTNqtIcKJuS8SH7uXoA+R/sCUEEnLcp67u655L3ebd7gHzh1kBbdBiygJpLHy82hh2XLFf7uBpH6nri9WSSFiByMytLVkdFs78lHavZpSkmDwyAzQUz/rJrLrr3FH+AMsY+aYvFcFEBRSAViWp67DeJFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CFHtDGzJ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a79164b686so30866585ad.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 12:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769200875; x=1769805675; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AU44HUCEHUqwi5+mrhLfRciiivzSXDT+0k5KnWcApVg=;
        b=CFHtDGzJBMFOJkHinpEliGOO4LgnVZjP22//lMaQJFJ78vF9xhx7Oq6sIO0H3hnglY
         pOVixdEx+Gsi305edlKfY6t/86reqPGMhKLHH3YSnUre3wcgbLg+72ihOILBCx4eHZ8W
         cyyiRQnIh0QR2rgW5nVChboxPylWF42FIYyvi0Wu/LwU1+Mm5qde2/DBBK/xvApPRjmO
         fUNzy5aZesko+Fj5UNXcY/Up5Le7jRxfTa/5QZp0XsFEK/OtPEJvHbgBbrDwoOFaMj1o
         I6kcXc5wkINoN6eMbxPzfgnV/oQ0awSCiZfzE6mUxybyvLgev+xej3cn0XplH4YuOl6o
         jS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769200875; x=1769805675;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AU44HUCEHUqwi5+mrhLfRciiivzSXDT+0k5KnWcApVg=;
        b=iD3uZinrKfOAKzZhKUwWMFo+eCuNN5BCs4BsH8cH2jhwZCtuG0BD4sYbJqFIQUEQCO
         ZENwzTdMZnq/ag3LjHso8s93h4iwjdovjP7jjeGfYh+ExIaI844fP5911wgYAtq8cFgS
         CuskTmhhkeWKCLLYRwqEXAsGTat9piE7Jby8YXlKjoJEiDQwkBDosNKNMmsdgBjEQexc
         IdvHkXWCwi7TrfxKjX7IhZIgq0UT8P13o1xzzheMxenxRzSxh0lEL1Ki8NQlPBuY2H1L
         WBnmjUvQGhow3dUpVbX14I51avVdhzLH++uiyicmHuN+kGIYIPJXECuYhRHqHWFY664G
         CL8g==
X-Forwarded-Encrypted: i=1; AJvYcCWpCZ6dTrtndUkG95nJ81rj7dT3QHnr85hIQKdMvvk4fow6TGPXrsaPKjWa5nzqifMtkgyscpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBiAAL9a7y7F0VTMpcMs6diDBW8Fsgw8Yih63ilM1wR0pelL/9
	raTe12TRQi2uBTFlXbWyd0J0suDVboeBJmZjQ11QpMLSHch4cTMUQyWxNYDiaVkcZpUuLXStl4f
	/w/wjp0QNaA==
X-Received: from pjzh2.prod.google.com ([2002:a17:90a:ea82:b0:34c:34ab:8fd9])
 (user=brianvv job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:a501:b0:29e:bf76:2d91
 with SMTP id d9443c01a7336-2a7fe741875mr26673385ad.42.1769200875444; Fri, 23
 Jan 2026 12:41:15 -0800 (PST)
Date: Fri, 23 Jan 2026 20:40:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260123204058.651080-1-brianvv@google.com>
Subject: [iwl-net PATCH] idpf: change IRQ naming to match netdev and ethtool
 queue numbering
From: Brian Vazquez <brianvv@google.com>
To: Brian Vazquez <brianvv.kernel@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	intel-wired-lan@lists.osuosl.org
Cc: David Decotigny <decot@google.com>, Li Li <boolli@google.com>, 
	Anjali Singhai <anjali.singhai@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	emil.s.tantilov@intel.com, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252966-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,davemloft.net,google.com,kernel.org,redhat.com,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brianvv@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 705107AB3F
X-Rspamd-Action: no action

The code uses the vidx for the IRQ name but that doesn't match ethtool
reporting or netdev naming, this makes it hard to tune the device and
associate queues with IRQs. Sequentially requesting irqs starting from
'0' makes the output consistent.

Before:

ethtool -L eth1 tx 1 combined 3

grep . /proc/irq/*/*idpf*/../smp_affinity_list
/proc/irq/67/idpf-Mailbox-0/../smp_affinity_list:0-55,112-167
/proc/irq/68/idpf-eth1-TxRx-1/../smp_affinity_list:0
/proc/irq/70/idpf-eth1-TxRx-3/../smp_affinity_list:1
/proc/irq/71/idpf-eth1-TxRx-4/../smp_affinity_list:2
/proc/irq/72/idpf-eth1-Tx-5/../smp_affinity_list:3

ethtool -S eth1 | grep -v ': 0'
NIC statistics:
     tx_q-0_pkts: 1002
     tx_q-1_pkts: 2679
     tx_q-2_pkts: 1113
     tx_q-3_pkts: 1192 <----- tx_q-3 vs idpf-eth1-Tx-5
     rx_q-0_pkts: 1143
     rx_q-1_pkts: 3172
     rx_q-2_pkts: 1074

After:

ethtool -L eth1 tx 1 combined 3

grep . /proc/irq/*/*idpf*/../smp_affinity_list

/proc/irq/67/idpf-Mailbox-0/../smp_affinity_list:0-55,112-167
/proc/irq/68/idpf-eth1-TxRx-0/../smp_affinity_list:0
/proc/irq/70/idpf-eth1-TxRx-1/../smp_affinity_list:1
/proc/irq/71/idpf-eth1-TxRx-2/../smp_affinity_list:2
/proc/irq/72/idpf-eth1-Tx-3/../smp_affinity_list:3

ethtool -S eth1 | grep -v ': 0'
NIC statistics:
     tx_q-0_pkts: 118
     tx_q-1_pkts: 134
     tx_q-2_pkts: 228
     tx_q-3_pkts: 138 <--- tx_q-3 matches idpf-eth1-Tx-3
     rx_q-0_pkts: 111
     rx_q-1_pkts: 366
     rx_q-2_pkts: 120

Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index c2a1fe3c79ec..c1f8dfc570ce 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4093,7 +4093,7 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport,
 			continue;
 
 		name = kasprintf(GFP_KERNEL, "%s-%s-%s-%d", drv_name, if_name,
-				 vec_name, vidx);
+				 vec_name, vector);
 
 		err = request_irq(irq_num, idpf_vport_intr_clean_queues, 0,
 				  name, q_vector);
-- 
2.52.0.457.g6b5491de43-goog


