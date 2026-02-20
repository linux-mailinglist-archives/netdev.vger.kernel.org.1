Return-Path: <netdev+bounces-259748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDaYB9uomGmvKgMAu9opvQ
	(envelope-from <netdev+bounces-259748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 19:32:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A57216A137
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 19:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30171300F5E1
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 18:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974CB30E0ED;
	Fri, 20 Feb 2026 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlCaPA2m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74558307AF4
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771612376; cv=none; b=GrYW9xdb4T+W3C3bv9oc1ws6qnxhY8V8X64OSgl3YYt3cH1/vOjHNN1Jk1VGUbuF58DOsR182dDUzCq4TCke/bXrHpY9zlb9hWANQt1xv1hUsf3Fj9531+btWLucOv3u9Ng7QiyYM3i1MghPw/xGn1RL5J8m1D86G06e3jLbDIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771612376; c=relaxed/simple;
	bh=K7BhCXj0E/nLPBm19m08UFqnTFUFHR+vKsTmMuF7OcY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QiGk/zUNcxkSsfetaEdaTruzQbU2k9L8OM6c8bMBEECPF40JbxecjooOknhxnxeRfJFc/VB0YY5r3Y+VV+5RVYdke0uaKx77YEX0kPLbEF1XOizpgZsLUp+VLm4aDP6NfpKqflZMSwmdGOlv3JhbEbozry4BNWvT5n2qefeoTvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlCaPA2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B631DC116C6;
	Fri, 20 Feb 2026 18:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771612376;
	bh=K7BhCXj0E/nLPBm19m08UFqnTFUFHR+vKsTmMuF7OcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hlCaPA2mmWlD84jYCAVHTvRiCdGumgYL65iUS33dTezHPnDIePgPlJTFmZC4JTqeP
	 rVEocfm7k46vbsmHDcAXD4X94yfqLUNio4ppNkjGb/dfwRJkD4biCuhjX6j7IghTbG
	 7qvpTDm3O73oUOfwP/21SIQ9Sp041NgR/v2nOF8m/iPozxai5cnGF4FDpvAtGejNAQ
	 gApTxk2o/yvVaqL7txFdJ9j44CUACE8vM6OcESY/YFs2aPd73i92KD6TmNMZT+cziy
	 cz0uhNpso4jjiUxSd6GZJE5GXc7IP8Vn0ECIRS9n5HNNPFdP5AihUQpSre0bN7KQhF
	 spQRpVPruJkYg==
Date: Fri, 20 Feb 2026 10:32:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me, hawk@kernel.org,
 alexander.h.duyck@intel.com
Subject: Re: [PATCH net] net: consume xmit errors of GSO frames
Message-ID: <20260220103254.69e087e6@kernel.org>
In-Reply-To: <CANn89iKQUHeonhTJE2pOQ95TMj9s8JttHWCZr9Yy3sii6XXV0A@mail.gmail.com>
References: <20260220170032.2964535-1-kuba@kernel.org>
	<CANn89iKQUHeonhTJE2pOQ95TMj9s8JttHWCZr9Yy3sii6XXV0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259748-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,spinics.net:url]
X-Rspamd-Queue-Id: 7A57216A137
X-Rspamd-Action: no action

On Fri, 20 Feb 2026 18:17:14 +0100 Eric Dumazet wrote:
> This rings a bell.
> 
> I sent back in October something in the same vein.
> 
> https://www.spinics.net/lists/netdev/msg1131452.html

Yes, I had a recollection of you explaining this problem in the past.
Otherwise I would have never thought of this path! :) 

If we want to cover the BUSY case maybe the patch below? Too messy?

diff --git a/net/core/dev.c b/net/core/dev.c
index 096b3ff13f6b..65b7c54e1bef 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4822,6 +4822,8 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 		 * to -1 or to their cpu id, but not to our id.
 		 */
 		if (READ_ONCE(txq->xmit_lock_owner) != cpu) {
+			bool is_list = false, completed = false;
+
 			if (dev_xmit_recursion())
 				goto recursion_alert;
 
@@ -4832,17 +4834,27 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 			HARD_TX_LOCK(dev, txq, cpu);
 
 			if (!netif_xmit_stopped(txq)) {
+				/* GSO segments a single SKB into
+				 * a list of frames. TCP expects error
+				 * to mean none of the data was sent.
+				 */
+				is_list = !!skb->next;
+
 				dev_xmit_recursion_inc();
 				skb = dev_hard_start_xmit(skb, dev, txq, &rc);
 				dev_xmit_recursion_dec();
-				if (dev_xmit_complete(rc)) {
-					HARD_TX_UNLOCK(dev, txq);
-					goto out;
-				}
+				completed = dev_xmit_complete(rc);
+				if (is_list)
+					rc = NETDEV_TX_OK;
 			}
 			HARD_TX_UNLOCK(dev, txq);
+			if (completed)
+				goto out;
+
 			net_crit_ratelimited("Virtual device %s asks to queue packet!\n",
 					     dev->name);
+			if (!is_list)
+				rc = -ENETDOWN;
 		} else {
 			/* Recursion is detected! It is possible,
 			 * unfortunately
@@ -4850,10 +4862,10 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 recursion_alert:
 			net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
 					     dev->name);
+			rc = -ENETDOWN;
 		}
 	}
 
-	rc = -ENETDOWN;
 	rcu_read_unlock_bh();
 
 	dev_core_stats_tx_dropped_inc(dev);

