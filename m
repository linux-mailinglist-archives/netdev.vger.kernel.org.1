Return-Path: <netdev+bounces-253602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJuqAPvid2k9mQEAu9opvQ
	(envelope-from <netdev+bounces-253602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 22:56:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5934B8DB9E
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 22:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64260301A734
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 21:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540472F99BD;
	Mon, 26 Jan 2026 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j9mBZ7UF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF29D24A07C
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769464566; cv=none; b=uUEjA/lqfWH3tbiqn7xtbZ/d1s7R+IyCb9+p12+zVwIrCHHdhR4JjwQZwvucxVCElSrslZL52Pz44nAMJ58rC7pArH5dd3IayQnCRKDc4PLd5/z/IOcFPX9UnMTVhqchpcSU5sHX1hkPFgSAltFf7LKX+Al78xBmSXB42JLHbXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769464566; c=relaxed/simple;
	bh=fJ3znz89OgJOjd50tWt/s9ggvgZ7jvDqWLqyjMa6VU8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ulws6vc6ls1IOhhbuCojiGlF1zn7RVxaqC/hc6tgQ5XXf5N4F4BJLXqyjjASWRr+qq6YvFMuCEy1S19m0/M5QKzI50UONapjz671jENKfptOPKDSgU/GP2VeFRt0+QNuv/JIzbwbB69F0N2EKAhxJDkpt/Iej8zHMJAc8p8BQwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j9mBZ7UF; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a351686c17so42801555ad.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 13:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769464564; x=1770069364; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ehmTA1o3oHWV2JS6XnM6t9zEYMHCZAFgQr8k6VR/OCY=;
        b=j9mBZ7UFJ5wW6HuLZFDIYEHAqLMwhwrL3rYS11av2t7H7UY9Ju+myLgLSUaH7J90Tz
         PeD1uonGxOnZY/0880OQAXsGC68WAwX6lcJ4JNRIH1NQYV31Nkjy9kpo+9ukVLNaIdxE
         C2BLS3S4bebv1mkUx4nfXkGhHvt62AGDcCw3rU0h8/wUoiZ1ceydowOnKjbCdVoDnhhA
         cJJzry+cmIovQEBDU+t1wDNJAbjct9DooQAbtBjsUm6xqAb6mDr+/88XDNNdFjKEmAqf
         shUFS621iBhGrOYVs7XbiM35eFMiM1TMJtvo9xLz2iEHepu/aqS4ASoAhUERRMzHAuog
         FTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769464564; x=1770069364;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ehmTA1o3oHWV2JS6XnM6t9zEYMHCZAFgQr8k6VR/OCY=;
        b=ZTMclXDqNpoL2YmXVPEROopCwBEtOaLJQFR1s5vhDKlGxw2SVLh+uFxS4ejfHd2Urh
         c29xxovtUQsTncoGFcWCgzpZSaiUZbDJBa3Icg2etz1INGX7G4Lao1iwhZl5n+o8Njr6
         b/tFXCPn+A8xDKogErNoV7wgRjVJ4lhDBiVZybhaXltdV4qrFKz940DXqDh9j1xpRIlZ
         BkoK7bgR9gh30VkvbC0xSKOBOg2XCRDsLv4/wV4+p8HBdx0Eeo4KVUXZn9JIzceobM1c
         Qwd4pfO2UJYN4oH1CXMR3oBlQNLre7e8FQxgc0XcNvC6H4LFr9WMbp/MAoC45zaPuWBJ
         6NiA==
X-Forwarded-Encrypted: i=1; AJvYcCU6u5BmB/bl7a6j6KBf2mdB7eWTjHt/A0TrKGwMo2LfWo9GTHuTHvKXKLc4AcHX71UR0PZ591M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXezngmtc1AvjuSnR0Fu+adKtQdSq51nDmotqLT2+dpegsItgZ
	V4aaGAWG3E9PiccTptFSPcsf67lY1dhy4Rq3CiWfEqelAmuiCM8FooG9zwZn1pwY3e+CdSZaTpD
	CW2EUv0qrdw==
X-Received: from plbbb9.prod.google.com ([2002:a17:902:bc89:b0:2a7:d253:e3bf])
 (user=brianvv job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f4c:b0:2a1:3ee7:cc75
 with SMTP id d9443c01a7336-2a84525785bmr53056755ad.19.1769464564175; Mon, 26
 Jan 2026 13:56:04 -0800 (PST)
Date: Mon, 26 Jan 2026 21:55:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126215600.3387171-1-brianvv@google.com>
Subject: [iwl-net PATCH v3] idpf: change IRQ naming to match netdev and
 ethtool queue numbering
From: Brian Vazquez <brianvv@google.com>
To: Brian Vazquez <brianvv.kernel@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	intel-wired-lan@lists.osuosl.org
Cc: David Decotigny <decot@google.com>, Li Li <boolli@google.com>, 
	Anjali Singhai <anjali.singhai@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	emil.s.tantilov@intel.com, Brian Vazquez <brianvv@google.com>, 
	Brett Creeley <brett.creeley@amd.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,davemloft.net,google.com,kernel.org,redhat.com,lists.osuosl.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253602-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brianvv@google.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5934B8DB9E
X-Rspamd-Action: no action

The code uses the vidx for the IRQ name but that doesn't match ethtool
reporting nor netdev naming, this makes it hard to tune the device and
associate queues with IRQs. Sequentially requesting irqs starting from
'0' makes the output consistent.

This commit changes the interrupt numbering but preserves the name
format, maintaining ABI compatibility. Existing tools relying on the old
numbering are already non-functional, as they lack a useful correlation
to the interrupts.

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

Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
Signed-off-by: Brian Vazquez <brianvv@google.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
V3: Add more context to the commit message
V2: Add mising Fixes tag

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


