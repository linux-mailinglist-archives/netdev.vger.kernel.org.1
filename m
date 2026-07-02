Return-Path: <netdev+bounces-304292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c7VKL47sRmpRfgsAu9opvQ
	(envelope-from <netdev+bounces-304292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 00:56:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 888E96FD500
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 00:56:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=PVUNYagz;
	dkim=pass header.d=redhat.com header.s=google header.b=gREtxDtw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304292-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304292-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 509743002D3A
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 22:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23D83C6A2B;
	Thu,  2 Jul 2026 22:56:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647123C4563
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 22:56:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783032968; cv=none; b=mgyES5XOl0gUzWR9UHSS4BfsF5XIfMUSTvQDZu9PwuChaYOTgsUQc3U1syLZnCPq6sM3W0gEdLqbWWHv+wDBuDwlsKceuwMXcFZFgku3STJ6cg/bvJTq+PwlcC9FCdHgR4kQGnD8f4F0W2eeFLUbSuSW5xlH62TsHA/5DOdwVAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783032968; c=relaxed/simple;
	bh=d7Kd/I+a/fLK24mvS0n1w7CPiFKwrdoZz+oQ9j/wruc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZ4oS3oo0+sP7smX13Xw3Ua3gZthosiKh6jpTSt/bpNqRMp+FXX3gcckHfkpB5QbA7JxexpOF7q2umG5/nDw+f6Ww54f+0a6B6k5wjmq9Ck7UGbb2PbOUaMyIc30JVaEuSFGIsBi+SdXRQGSbj9By1jpFyKW90DEXwl+D0e2FLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PVUNYagz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gREtxDtw; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783032966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GN59CVwWQmPqxJ3gp/iRcnL5JZbPmURc0dB6sj/cdlI=;
	b=PVUNYagzVsI7YSaCZNhrWLvw1svWNb4f4gU4Hxa9Wy5ofngkb1xiHMVpYREjsOBlO3ljXZ
	SoQLDgVqJRPbrIdzHd1TzjZ/l32WK2sOCWXBEn1PgwxTh1FvI52A606R4bZHIumBwEzGNz
	LzEf5xhXWmGoKWE1Tf86QpNdprOCrxA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-uLxYhBltM6iLNdfxBFvbLA-1; Thu, 02 Jul 2026 18:56:05 -0400
X-MC-Unique: uLxYhBltM6iLNdfxBFvbLA-1
X-Mimecast-MFC-AGG-ID: uLxYhBltM6iLNdfxBFvbLA_1783032964
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493c47a09b5so9237165e9.2
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 15:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783032964; x=1783637764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GN59CVwWQmPqxJ3gp/iRcnL5JZbPmURc0dB6sj/cdlI=;
        b=gREtxDtwCAYVeBrI4eMgHp5OagdqgG7jB09tERrB8TsU9REo1yenWJtRrgbnesE9jN
         Q8WaI1prqM2fkczUg9+umOOC2VReBwaDIDlZvDQGe3RNKQZDS1OMvaWHX0cNts/tyu5Y
         autcFkzukmmGp39egWbChnMiTm0feVf48fL+oI3t4n/WHE9EFsAF6lmzSWwHcgtsAiHA
         9kQlpml/t0gwBoMu6zoqb5Yxn+yNJ6muvVNnvWPGpcZ7lbBk0e8Wc9b3gbU3oVTeBEtX
         Pd2VJqqp4OsReoDFk8VP07Hy4fKF1XnljsdkNySoDZWnD7BW+R3C0/8I/Dm/a2tUKqda
         lXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783032964; x=1783637764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GN59CVwWQmPqxJ3gp/iRcnL5JZbPmURc0dB6sj/cdlI=;
        b=PLS5JJNaNx3DyvFPYh5xzr7omq/5ZV0T0Oa0j1Oik8c8sjspwGBVLCunAHCedzilO0
         vIZIIm++/ZaGtID8ppdsG0Zs7/FqpC/EA00dH2CLDMf/TIdRXQ8bUmeXOY+1cE7EgFzr
         c3Z3T7JwX6BNtWSyRtzkNLUkqLuUHNDmRilPuVAOtJNuXxuDCukDKOs+NDfHcZuagBwC
         Ofmg0KmqJxApYFXpuWYr9v5J1Z1DDWuhA/21Z24ucWmr1Sw5N8T26bPS7OACx8404efU
         1cpMYMcNzvou6i/WOUThf3hHnmY+IV5uENYCJ/PDuYFPXiv0inBpQiOmEUYw42cRKqhZ
         9PAg==
X-Forwarded-Encrypted: i=1; AFNElJ9JLcQ86LzySgEHFM3z1v9i0VgvtvR2hH8E3AJ1Wfpl7CFRUPoMJ6R00IWFKGXqXeXNCK6vp/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkgoW5xcciEOzTbvNzZYYU7r9WXAZckxGAHeTbFe6uDZiPI4XK
	0xJWcgkuxE4Ap+/u7kwwdIa4xwUb8C56cp8Gt8yorhU2j9IZtAYYQJF8MDcX2zfmo3E2OkjXV9B
	K8VmEBGvhB5L7Zcm+62OlP+4gGnxWMRJtHaLU3OglwMOV5JenFLEV3b7dgA==
X-Gm-Gg: AfdE7cmmA4ttkgWKDnwRjt/fRoVbytpe0gL6dD/MjOWDIay1Ahk2xG1mSo+81wE/z3f
	Zvq9Svfk7nSWnVgG498Ec/R6lUlqkZpOy6koz2le8AfazsjcSZq+Ts1adAchqZJYZEOvwqMP8Tu
	Vluuhh5sDTQsFBxnRHDoQxWzeWEKp55bGqPBURLPtsgWb/1l+8xUV0C0FURoa2cXhWqYRIjgQfM
	m/8+qMScnQ2OCOKn8ClP4JR6oskMIQyyo2nGvxinFi7+IttZzQSfoLodedtLfVhzOWZiZkQ9GmI
	LtxF2lMb4TJijMuRDJhcqxD33YHOyV1eOGEtX65oKFbBIxINGNC178tBOKKP/QyRwLQEk/NT2f3
	LvDJu411k0QyZ0GAZzIERXtboe3P44hWk
X-Received: by 2002:a05:600c:310f:b0:493:b6e2:1b10 with SMTP id 5b1f17b1804b1-493c2ba0bc7mr106860125e9.31.1783032963502;
        Thu, 02 Jul 2026 15:56:03 -0700 (PDT)
X-Received: by 2002:a05:600c:310f:b0:493:b6e2:1b10 with SMTP id 5b1f17b1804b1-493c2ba0bc7mr106859855e9.31.1783032962992;
        Thu, 02 Jul 2026 15:56:02 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477de3dd46asm13399841f8f.36.2026.07.02.15.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 15:56:02 -0700 (PDT)
Date: Thu, 2 Jul 2026 18:55:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Brett Sheffield <bacs@librecast.net>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
	regressions@lists.linux.dev, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] tun/tap & vhost-net: multi-threaded
 network performance
Message-ID: <20260702185420-mutt-send-email-mst@kernel.org>
References: <akVnoOYQOrt8k-Gu@karahi.librecast.net>
 <20260701165359-mutt-send-email-mst@kernel.org>
 <ef33f0a7-f0b7-4bc4-9263-10d2b480d717@tu-dortmund.de>
 <akZGg96-Xu9VeGrw@karahi.librecast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akZGg96-Xu9VeGrw@karahi.librecast.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304292-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bacs@librecast.net,m:simon.schippers@tu-dortmund.de,m:regressions@lists.linux.dev,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:tim.gebauer@tu-dortmund.de,m:willemdebruijn.kernel@gmail.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[tu-dortmund.de,lists.linux.dev,vger.kernel.org,kernel.org,gmail.com,redhat.com,lunn.ch,davemloft.net,google.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,librecast.net:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,brettsheffield.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 888E96FD500

On Thu, Jul 02, 2026 at 01:07:47PM +0200, Brett Sheffield wrote:
> On 2026-07-02 09:24, Simon Schippers wrote:
> > On 7/1/26 22:56, Michael S. Tsirkin wrote:
> > > On Wed, Jul 01, 2026 at 09:16:48PM +0200, Brett Sheffield wrote:
> > >> TL;DR - Commit 1d6e569b7d0c0b2736636749e4be0a27f3cefcb3 causes
> > >> significant performance regressions with TAP interfaces and multithreaded
> > >> network code. Please revert.
> > >>
> > >>
> > >> Librecast is an IPv6 multicast library. One of the tests (0055) fails under
> > >> Linux 7.2-rc1. The test performs data synchronization over IPv6 multicast using a TAP
> > >> interface. This test has run successfully on every stable, LTS and mainline RC
> > >> released in the past year. Every kernel with my Tested-by has run this test.
> > >>
> > >> There have been a bunch of changes to MLDv2 so I started bisecting there, but
> > >> the culprit is actually 1d6e569b7d0c0b2736636749e4be0a27f3cefcb3 "tun/tap &
> > >> vhost-net: avoid ptr_ring tail-drop when a qdisc is present"
> > >>
> > >> Reverting this commit fixes the test.
> > >>
> > >> To eliminate my code and any multicast weirdness, I ran tests with iperf3
> > >> comparing the same host running 7.2-rc1 both with and without 1d6e569b7d0
> > >> reverted.
> > 
> > Thank you very much for your bisect!
> > 
> > As the author, I am sorry for that regression!
> 
> No worries. That's why we test :-)
> 
> > > - does it help to increase the tun queue size?
> > 
> > I agree, this would be great to know.
> > 
> > However, even then we must act. I am considering IFF_BACKPRESSURE
> > as a feature flag, defaulting to off. It would just enable/disable
> > the stopping logic in tun_net_xmit() and the waking logic
> > in __tun_wake_queue(). If disabled, it would result in the same logic
> > as before.
> > 
> > I could provide such a patch as [net] material.
> 
> I'm going to make myself a strong cup of tea and dig into it a bit more here and
> will let you know if I find anything worth reporting.
> 
> If you need me to try re-testing with specific settings or test a patch I'm
> happy to do so.
> 
> Cheers,
> 
> 
> Brett
> -- 
> Brett Sheffield (he/him)
> Librecast - Decentralising the Internet with Multicast
> https://librecast.net/
> https://blog.brettsheffield.com/

Maybe it's the supposedly rare case? Does this change anything
for you?


diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index bfa49fa9e3a1..bacd89460078 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1018,7 +1018,6 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct netdev_queue *queue;
 	struct tun_file *tfile;
 	int len = skb->len;
-	int ret;
 
 	rcu_read_lock();
 	tfile = rcu_dereference(tun->tfiles[txq]);
@@ -1064,19 +1063,24 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto drop;
 	}
 
-	skb_tx_timestamp(skb);
-
-	/* Orphan the skb - required as we might hang on to it
-	 * for indefinite time.
-	 */
-	skb_orphan(skb);
-
-	nf_reset_ct(skb);
-
 	queue = netdev_get_tx_queue(dev, txq);
 
 	spin_lock(&tfile->tx_ring.producer_lock);
-	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
+	if (__ptr_ring_check_produce(&tfile->tx_ring)) {
+		spin_unlock(&tfile->tx_ring.producer_lock);
+		netif_tx_stop_queue(queue);
+		smp_mb__after_atomic();
+		if (!__ptr_ring_check_produce(&tfile->tx_ring))
+			netif_tx_wake_queue(queue);
+		rcu_read_unlock();
+		return NETDEV_TX_BUSY;
+	}
+
+	skb_tx_timestamp(skb);
+	skb_orphan(skb);
+	nf_reset_ct(skb);
+
+	__ptr_ring_produce(&tfile->tx_ring, skb);
 	if (!qdisc_txq_has_no_queue(queue) &&
 	    __ptr_ring_check_produce(&tfile->tx_ring) == -ENOSPC) {
 		netif_tx_stop_queue(queue);
@@ -1087,18 +1091,6 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 	spin_unlock(&tfile->tx_ring.producer_lock);
 
-	if (ret) {
-		/* This should be a rare case if a qdisc is present, but
-		 * can happen due to lltx.
-		 * Since skb_tx_timestamp(), skb_orphan(),
-		 * run_ebpf_filter() and pskb_trim() could have tinkered
-		 * with the SKB, returning NETDEV_TX_BUSY is unsafe and
-		 * we must drop instead.
-		 */
-		drop_reason = SKB_DROP_REASON_FULL_RING;
-		goto drop;
-	}
-
 	/* dev->lltx requires to do our own update of trans_start */
 	txq_trans_cond_update(queue);
 


