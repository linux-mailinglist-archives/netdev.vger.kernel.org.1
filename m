Return-Path: <netdev+bounces-297694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +7yqKghxKWrOWwMAu9opvQ
	(envelope-from <netdev+bounces-297694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:13:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 039DB66A232
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:13:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=OzQNX+hx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297694-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297694-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A1D43066AB1
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9994C408020;
	Wed, 10 Jun 2026 14:08:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DD8405C41
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 14:08:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781100499; cv=none; b=EbCC/DDCQ67dwLGovQ/SWTK7n5qzQRcSZmQy3kgtDaStv4LnPFjo+3Aax+/nMXuRiA1wiY9rCRFzn13jtFqsW/zrCPSgj/ZnyFTQYkcpuLrq+wAcVDN7hjAIBaAJasUFuHn3SEkn8/wPYbvXNI9G5v39I2dvUbm8MdbMyhFOdH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781100499; c=relaxed/simple;
	bh=njgV0yDIZfMro/6yoEh9+ldS7wom6/CdkR9sVeg2JcY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AiyLxvHynkzBmOCtYJBdM7O1/OkJUMJwQXhxp/nS9K/8TSajJo/156w58LYwr17S98kYqiPCfrE1r5oLRF7Q48ijmz3277BN4Cogdk+VQhYqzFbtbWyjs84ttp+UHPEK4tqdquXsAy+PmHa5EaneNHQf63+RVg9QuHzV72FP50c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=OzQNX+hx; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 19A5E20799;
	Wed, 10 Jun 2026 16:08:09 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3aVQEm7Kgacw; Wed, 10 Jun 2026 16:08:08 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7748B20758;
	Wed, 10 Jun 2026 16:08:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7748B20758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781100488;
	bh=6FEN4yjrhjFNURqdOEDcHDRDH38GkJashbIterUl/Dc=;
	h=From:To:CC:Subject:Date:From;
	b=OzQNX+hxeBkYfD8rUYMussdFnca2lu3bXDcVq5F57qEml/vz3h9Px35JRBX2aOIX+
	 dVLQOMJU+uzLJjaAwcLrBvlvNUiG4f1zOCocdVeIQ/JXGcjwWiFVjbrvWjWqIUE5Lo
	 BDXd4hmlbfjiZbyLUecY3tJT9alizwlqe5N8zy/sXEwiBjoElNwHts6e/v9bV4QaBP
	 A2B6eGlBjnR1S9AFn5rbPWuobJs8/PYV6TKXJG8MjMngXE6yx1XmphUEnL6AX4dqiK
	 NUaBwC7YwkcI2iZ8msMRIEZms57hLpHVBPqByUaWh6kOWLsTcFd/aXV2nFOrZkqH41
	 fwtSmZTQScFKQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 16:08:07 +0200
Received: (nullmailer pid 2563190 invoked by uid 1000);
	Wed, 10 Jun 2026 14:08:07 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/6] pull request (net): ipsec 2026-06-10
Date: Wed, 10 Jun 2026 16:07:39 +0200
Message-ID: <20260610140800.2562818-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297694-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:dkim,secunet.com:mid,secunet.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 039DB66A232

1) xfrm: iptfs: preserve shared-frag marker in iptfs_consume_frags()                                                                       
   Propagate SKBFL_SHARED_FRAG when paged fragments are moved between                                                                      
   skbs so ESP can decide whether in-place crypto is safe.                                                                                 
 
2) xfrm: iptfs: fix use-after-free on first_skb in __input_process_payload                                                                 
   Replace the unlocked read of xtfs->ra_newskb with a local flag so a                                                                     
   concurrent reassembly can no longer free first_skb between                                                                              
   spin_unlock and the post-loop check.                                                                                                    
 
3) xfrm: policy: fix use-after-free on inexact bin in xfrm_policy_bysel_ctx()                                                              
   Prune the inexact bin under xfrm_policy_lock so a concurrent                                                                            
   xfrm_hash_rebuild() can no longer free it before xfrm_policy_kill()                                                                     
   dereferences it.                                                                                                                        
 
4) xfrm: iptfs: fix ABBA deadlock in iptfs_destroy_state()                                                                                 
   Move hrtimer_cancel() for the output and drop timers ahead of their                                                                     
   spinlocks, breaking the softirq/lock cycle that could deadlock                                                                          
   against the timer callbacks on SMP.                                                                                                     
 
5) xfrm: espintcp: do not reuse an in-progress partial send                                                                                
   Fail a new send when espintcp_push_msgs() returns with emsg->len                                                                        
   still set, so a blocking caller can no longer overwrite ctx->partial                                                                    
   while a previous transfer still owns it.                                                                                                
 
6) esp: fix page frag reference leak on skb_to_sgvec failure                                                                               
   Add a flag to esp_ssg_unref() to unconditionally unref the source                                                                       
   scatterlist, releasing the old page references that are otherwise                                                                       
   leaked when the second skb_to_sgvec() in esp_output_tail() fails.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 78ef59e7a6459b16f8102e0ee1c718443323d1af:

  Merge branch 'wireguard-fixes-for-7-1-rc6' (2026-05-29 13:01:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2026-06-10

for you to fetch changes up to 26aad08a928901296aabfbc7a33ecb951656bb98:

  esp: fix page frag reference leak on skb_to_sgvec failure (2026-06-09 15:58:17 +0200)

----------------------------------------------------------------
ipsec-2026-06-10

----------------------------------------------------------------
Alessandro Schino (1):
      esp: fix page frag reference leak on skb_to_sgvec failure

Sanghyun Park (1):
      xfrm: policy: fix use-after-free on inexact bin in xfrm_policy_bysel_ctx()

Takao Sato (1):
      xfrm: iptfs: preserve shared-frag marker in iptfs_consume_frags()

Tristan Madani (1):
      xfrm: iptfs: fix ABBA deadlock in iptfs_destroy_state()

Wyatt Feng (1):
      xfrm: espintcp: do not reuse an in-progress partial send

Zhenghang Xiao (1):
      xfrm: iptfs: fix use-after-free on first_skb in __input_process_payload

 net/ipv4/esp4.c        | 17 +++++++++++------
 net/ipv6/esp6.c        | 17 +++++++++++------
 net/xfrm/espintcp.c    |  4 ++++
 net/xfrm/xfrm_iptfs.c  | 11 +++++++----
 net/xfrm/xfrm_policy.c | 13 ++-----------
 5 files changed, 35 insertions(+), 27 deletions(-)

