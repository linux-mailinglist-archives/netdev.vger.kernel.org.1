Return-Path: <netdev+bounces-170020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1D7A46E45
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 23:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4DE416A913
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F0F26E155;
	Wed, 26 Feb 2025 22:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GoKTtbmX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B884626F44A
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 22:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607977; cv=none; b=Th13zXi5XnAXgfBiXaPvoDL+XFrYaH1xCgDvbsiJhQtefzCSmHE4aF+TAren6Z7aG1TSkBoJV4JrDP7JkB9qCtyeG+axhhPfX6DAme1o+srJiELzlYR9jpjz1A6in/bjgUTEdur10VfS09XdxFPgM/wep6eDi2jcHI3xZa0JgNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607977; c=relaxed/simple;
	bh=VMw6PwnSyOQuNLsxwWXJ1HC3mKzTS0VTMM8MtmY/nEw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cYAfzHD08MroU3WzUgl3AX5OC5tqUfN5/iPS+WVsWl+8bXIeu00tKgEMV4ZZpQCw2YiX/HVlgBDqEFG3dBd8LUVZmZazNKSIz3ftga7MOVsJ2l6f1lruwUu440KNEQKh9C7Ytb2nV01b93tvqrzehxvI+g1DiD+iw02iVa9Tdeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GoKTtbmX; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-472051849acso5422191cf.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 14:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740607974; x=1741212774; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0sTlK3EXl7m/fD1kmG4lPMc/3lamvwsB/3FfrlC/BqA=;
        b=GoKTtbmX1ScFGaWbzynaJOMKfeEDqpPGax3FQz3UZpfIqy/VxIEO6JsKlYMQKALOmL
         q1HaKnplWIx+rfDo6QDCEZ3ab39mz3FOjwfbmwPgMcofvvFd+thdLli0DnYl73d8SmfL
         c0ha3tSKYIkyTAIp87nSUR2iuqV/rfnwafV1JVBlodr8YZsXXsM15LJeXWBH4GaNygtD
         IoLjtU2dcuzvj5aEuukQkv9clpVHdwjUoAVeTIjt6lwp1h3CLPcTuwcyGOEASbUxNRdN
         zQYwXLOQh4zO3KhK73xeb1Sage/Nj3ZoBmMVubi6TvUFmas4u/NV/Vo0jIyCATfWFxuU
         aGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740607974; x=1741212774;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0sTlK3EXl7m/fD1kmG4lPMc/3lamvwsB/3FfrlC/BqA=;
        b=tpd4ZWwifnzY/DCCczZJhBQD1XB8qlaJQUqvnFfgugyzQnNBKLzMPcCGQOwvwW7/O3
         1pQwV9xDYJ7xUQgdT2RBDsrTcuOZ/LG139Zh9jJ6pdpTX9ZO4ccTWLgZi2yawL91GBPZ
         4xEJTa2zaRDr5swlkfjW/8sIdqS8aXFyFaFGPby4QFbEgdnH+7yPacRkX2r9YQsE1Ysr
         Mj35f7MqXgEuesaK6JpN9oaIDXIUzvZNJojw+B45rGVUILC8Qv2QGi1GMgKFZcjbR5s9
         V/ju5x7bmT6Iac+b6tZNHmciWkNhb8Z+lgMof+RUx2gTWwoJwLMJNgbe9wT54mTVenEC
         M5rQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+d9buHmoRPXRKA5xdU8mc5I/F0+49xFgz9fs7v8pnq+615lL7rS4a6/+Q91+9+riojnt1O5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT4M7k5V9Zg/sjbxgrSS44j6JJMg20vQRq6viXEB+gfOjOsSXY
	pA31W/5VtUntLvs/2guF6DBlch4XlkoaojzYuEzV0MVUObjTFYr99nVc7CWhhwp0RnYOxO0W0mW
	T8ajS6T3jxQ==
X-Google-Smtp-Source: AGHT+IE4+mg7d+uuqFj71ofTJ4ILQ4cihPABVqUz/DledT3xf0P433Bn9Dd+MmDtdI40ch+NJKyaynvK89Rohg==
X-Received: from qtbbz16.prod.google.com ([2002:a05:622a:1e90:b0:471:f25c:e47d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5482:0:b0:472:673:6a5c with SMTP id d75a77b69052e-473813bb306mr61341551cf.32.1740607974569;
 Wed, 26 Feb 2025 14:12:54 -0800 (PST)
Date: Wed, 26 Feb 2025 22:12:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250226221253.1927782-1-edumazet@google.com>
Subject: [PATCH net] idpf: fix checksums set in idpf_rx_rsc()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Alan Brady <alan.brady@intel.com>, 
	Joshua Hay <joshua.a.hay@intel.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

idpf_rx_rsc() uses skb_transport_offset(skb) while the transport header
is not set yet.

This triggers the following warning for CONFIG_DEBUG_NET=y builds.

DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb))

[   69.261620] WARNING: CPU: 7 PID: 0 at ./include/linux/skbuff.h:3020 idpf_vport_splitq_napi_poll (include/linux/skbuff.h:3020) idpf
[   69.261629] Modules linked in: vfat fat dummy bridge intel_uncore_frequency_tpmi intel_uncore_frequency_common intel_vsec_tpmi idpf intel_vsec cdc_ncm cdc_eem cdc_ether usbnet mii xhci_pci xhci_hcd ehci_pci ehci_hcd libeth
[   69.261644] CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Tainted: G S      W          6.14.0-smp-DEV #1697
[   69.261648] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
[   69.261650] RIP: 0010:idpf_vport_splitq_napi_poll (include/linux/skbuff.h:3020) idpf
[   69.261677] ? __warn (kernel/panic.c:242 kernel/panic.c:748)
[   69.261682] ? idpf_vport_splitq_napi_poll (include/linux/skbuff.h:3020) idpf
[   69.261687] ? report_bug (lib/bug.c:?)
[   69.261690] ? handle_bug (arch/x86/kernel/traps.c:285)
[   69.261694] ? exc_invalid_op (arch/x86/kernel/traps.c:309)
[   69.261697] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621)
[   69.261700] ? __pfx_idpf_vport_splitq_napi_poll (drivers/net/ethernet/intel/idpf/idpf_txrx.c:4011) idpf
[   69.261704] ? idpf_vport_splitq_napi_poll (include/linux/skbuff.h:3020) idpf
[   69.261708] ? idpf_vport_splitq_napi_poll (drivers/net/ethernet/intel/idpf/idpf_txrx.c:3072) idpf
[   69.261712] __napi_poll (net/core/dev.c:7194)
[   69.261716] net_rx_action (net/core/dev.c:7265)
[   69.261718] ? __qdisc_run (net/sched/sch_generic.c:293)
[   69.261721] ? sched_clock (arch/x86/include/asm/preempt.h:84 arch/x86/kernel/tsc.c:288)
[   69.261726] handle_softirqs (kernel/softirq.c:561)

Fixes: 3a8845af66edb ("idpf: add RX splitq napi poll support")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Alan Brady <alan.brady@intel.com>
Cc: Joshua Hay <joshua.a.hay@intel.com>
Cc: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 9be6a6b59c4e1414f993de39698b00fffa7d2940..977741c4149805b13b3b77fdfb612c514e2530e6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3013,7 +3013,6 @@ static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 	skb_shinfo(skb)->gso_size = rsc_seg_len;
 
 	skb_reset_network_header(skb);
-	len = skb->len - skb_transport_offset(skb);
 
 	if (ipv4) {
 		struct iphdr *ipv4h = ip_hdr(skb);
@@ -3022,6 +3021,7 @@ static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 
 		/* Reset and set transport header offset in skb */
 		skb_set_transport_header(skb, sizeof(struct iphdr));
+		len = skb->len - skb_transport_offset(skb);
 
 		/* Compute the TCP pseudo header checksum*/
 		tcp_hdr(skb)->check =
@@ -3031,6 +3031,7 @@ static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 
 		skb_shinfo(skb)->gso_type = SKB_GSO_TCPV6;
 		skb_set_transport_header(skb, sizeof(struct ipv6hdr));
+		len = skb->len - skb_transport_offset(skb);
 		tcp_hdr(skb)->check =
 			~tcp_v6_check(len, &ipv6h->saddr, &ipv6h->daddr, 0);
 	}
-- 
2.48.1.658.g4767266eb4-goog


