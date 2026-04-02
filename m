Return-Path: <netdev+bounces-274554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HXjCvNzzmkpnwYAu9opvQ
	(envelope-from <netdev+bounces-274554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:49:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2DC38A03F
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEBDB30DE2E0
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 13:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD473218B3;
	Thu,  2 Apr 2026 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnMTjmCy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA90316197
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775137325; cv=none; b=YFfeo7EDszDtDowDJeLQG/O4RU5TM75p8UUvS2MSP3eZYppp8eWwQa0H/WySNqjnPoSDJVH7Ra1dZyRKtoeOz2drbVN7+20NxFjfkMCjgOct3byUVQXXcLtB5D6dwndVjAuSTV0S0GKsvZe7eP5ZPbRLOIycVPcOImgAyCdDhoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775137325; c=relaxed/simple;
	bh=FqY5BsUqPvwDV1gpQXIDbZXm86YWuoUBORtLz5tB/4g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZqGNief4qRr3H3N6lBBYOShuc6725c8uHROdUn8HzFweeGwKCpN0i9efU8Bn6XLH1FjC442r6u3nu5phNJ5LfoD5yZ5sFut7e9jS5t9b2xT0WnDVFpasHwjFzkVojUMyqZEhidi1Vrc7D2JaknZeZ54W5HHlR9CEpbysvTMHns4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnMTjmCy; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50baf2df711so8823461cf.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 06:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775137323; x=1775742123; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eJxi10wBfb56d+iK+hMSY+8dLj8qv6sMpJ8dudYWWIg=;
        b=FnMTjmCyYroWYVsO0odKjWyx+4wxvJ0O6gaghGWMNSoQBQpeVFJcpugMcBW0+M0vMI
         Z5zg8n8hGfD9ttMOmsWTfAn4Yh0OLmVk8po5tppRB91SauGedM8PuPVwrWcBtFtlb+AO
         9NdWME6RcR6cOjW6GKC/YgTrx56mrR/t9c6OaDfJAJVXwg78R36ksagK65aJUtlUaFMI
         PEhjPOZHyfAo4wGgYSmVxE17BVDFBxj+uBQ5RxyfASaxallstDTYURK0SR6yRp9Y5RNJ
         xzCp4MQTsfR8SrAMW3RQkHV4Cu6xcQ4TgDLcYnihUNSRpjjaBEP6uFYdzSPnYPkiuGUB
         vfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775137323; x=1775742123;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJxi10wBfb56d+iK+hMSY+8dLj8qv6sMpJ8dudYWWIg=;
        b=ATXDjp5N2b4CJrj4toKDcFHX8fk+EtVGU9doXACUN98t6CHfT6tzJzeRZd/rCCgx5F
         8yMiXNJyk6i42cmow0rNHeADuAdGLtEdvKqMqSbCynnjTKKUjtoFl2avnzX6015kEHGu
         zWiKMkUZjb3EhyoQu5JNP4TR3kl1ANhZ4wJgv8tT3N4AnRoRxChUiVIZeOWEDhH8T3eF
         eSTL7xhFERWxO6b081ak/KjNpTVnAC6Hfm5ZRJs+nORs6bDDzXTd+2oZOTVAZBkdJg5z
         kskXRp1lZvdnhHXQoRS4V91iOEgNlaimpa7oocCSyPtTO+U6FS2z9/LKBEc4jEbA2I6t
         xdGw==
X-Forwarded-Encrypted: i=1; AJvYcCX81uA+HJr1G+Ali8yNKJn1oCzqRydIDxHsjCeLVbhhvtYikAK51tI0xTUgK+DlBUqox/mrMNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB6aETBS+9mLpwvE0kMv/DnCQPFcXSsKvIirhBg+6m4PEpgrIt
	jQzZUlBi4fLe/GrCpDXkHwksc6YLhuSXJaPszPqb9sTSJqy16XPrckVP
X-Gm-Gg: ATEYQzyUjNnnDW7Id3qhES4/fdH2rtsQgKszgzTSntSP4TjuAwxTp1sMIix1J/wtSgW
	27We1TqysqclIKa4pzANX7Td/h22ALHjd+cNhqA1oVqKAJoCiLMoj0uuN2C3QLbllD0/3NkylF7
	uPBaZmKA1NNeHR8Clrk5BQ0V9ylQ1DnnvDlDaSZ6KZE2215/ra3Hc/jeW9Ok048uOMVCubuDMDn
	L2GMCIqz6DnMEhJInyFG0saGmTUz/gZfaNj7FHgwC6a3zADDi5pwEmZYmYqQ5UNjUt5Q76fsZvr
	mElhIoLSH/aUgNzkWG3qWqCZiSSMfhBf2qF5nNZvbBQ0ZFCj5KBqUdlMBPKIpYhdck+xqvb7LHE
	uiBKbefaxaIAeWq0hybYvFY9dd0TNBm1wKCSJfg32womDHAJUv02kHz5P07nMygZFqKHLUhjxa6
	Ve7kdB93vA4Rp7R4v+PpG/NtFCc1L28EqprsaofuO/u08=
X-Received: by 2002:a05:622a:6695:b0:509:32e9:7e9f with SMTP id d75a77b69052e-50d4bb31052mr34510351cf.36.1775137323090;
        Thu, 02 Apr 2026 06:42:03 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593bf4f0fsm22636786d6.16.2026.04.02.06.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 06:42:02 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH net-next v2 0/4] net: macb: Remove dedicated IRQ handler
 for WoL
Date: Thu, 02 Apr 2026 21:41:21 +0800
Message-Id: <20260402-macb-irq-v2-0-942d98ab1154@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAFyzmkC/0WNywrCMBBFf6XM2pE8arWu/A/pIonTdsCkmoRSK
 f13QxFcHs7l3BUSRaYE12qFSDMnnkIBdajAjSYMhPwoDEqoRmgl0RtnkeMb65MmEq3Vuq2hzF+
 Rel721B0CZQy0ZOiKGTnlKX72j1nu/pe7/HOzRIFnq6lRqrd1426DN/w8uslDt23bF0LM+x2qA
 AAA
X-Change-ID: 20260321-macb-irq-453ee09b3394
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kevin Hao <haokexin@gmail.com>, netdev@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,tipi-net.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274554-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC2DC38A03F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During debugging of a suspend/resume issue, I observed that the macb driver
employs a dedicated IRQ handler for Wake-on-LAN (WoL) support. To my knowledge,
no other Ethernet driver adopts this approach. This implementation unnecessarily
complicates the suspend/resume process without providing any clear benefit.
Instead, we can easily modify the existing IRQ handler to manage WoL events,
avoiding any overhead in the TX/RX hot path.

The net throughput shows no significant difference following these changes.
The following data(net throughput and execution time of macb_interrupt) were
collected from my AMD Zynqmp board using the commands:
  taskset -c 1,2,3 iperf3 -c 192.168.3.4 -t 60 -Z -P 3 -R
  cat /sys/kernel/debug/tracing/trace_stat/function0

Before:
-------
  [SUM]   0.00-60.00  sec  5.99 GBytes   858 Mbits/sec    0             sender
  [SUM]   0.00-60.00  sec  5.99 GBytes   857 Mbits/sec                  receiver

  Function                               Hit    Time            Avg             s^2
  --------                               ---    ----            ---             ---
  macb_interrupt                      217996    678425.2 us     3.112 us        1.446 us

After:
------
  [SUM]   0.00-60.00  sec  6.00 GBytes   858 Mbits/sec    0             sender
  [SUM]   0.00-60.00  sec  5.99 GBytes   857 Mbits/sec                  receiver

  Function                               Hit    Time            Avg             s^2
  --------                               ---    ----            ---             ---
  macb_interrupt                      218212    668107.3 us     3.061 us        1.413 us

---
Changes in v2:

- The patch 2 has been reimplemented as suggested by Jakub Kicinski.

- Adjust patches 3 and 4 to align with the reimplementation of patch 2.

- Update the commit log for patch 4 to include verification steps.

- Link to v1: https://lore.kernel.org/r/20260328-macb-irq-v1-0-7b3e622fb46c@gmail.com

---
Kevin Hao (4):
      net: macb: Replace open-coded implementation with napi_schedule()
      net: macb: Introduce macb_queue_isr_clear() helper function
      net: macb: Factor out the handling of non-hot IRQ events into a separate function
      net: macb: Remove dedicated IRQ handler for WoL

 drivers/net/ethernet/cadence/macb.h      |   7 +
 drivers/net/ethernet/cadence/macb_main.c | 250 ++++++++++++-------------------
 2 files changed, 99 insertions(+), 158 deletions(-)
---
base-commit: bd0f139e5fc11182777b81cefc3893ea508544ec
change-id: 20260321-macb-irq-453ee09b3394

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


