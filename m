Return-Path: <netdev+bounces-304596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1WOiCebdR2pCggAAu9opvQ
	(envelope-from <netdev+bounces-304596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:05:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCED70421D
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:05:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=cwqCy9mi;
	dkim=pass header.d=redhat.com header.s=google header.b=KtnBpCSm;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304596-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304596-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 835FA301D337
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 16:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60D82EBB8D;
	Fri,  3 Jul 2026 16:05:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3442EEE60
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 16:05:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783094736; cv=none; b=HXdrKHldVrtehFmXignyKeQOtHLn0sjlhOd2ibFLOrSBP5c88Nno93+MTtbGzAs24Fsku93+3kFceX0aXXD3QSEkHkcL6tZHfhqUeZQoi5+MZOn7RvfBFMUFz4PfT3GtLSkuAH+rMityZzZmQ6tmleEtMKutA7giFnZm4N5urrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783094736; c=relaxed/simple;
	bh=R8raQapqEko/nHjRDyj7SDbekaWrkygAAaKPhvpequc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mb7vGXwMg3h+7w2eNKt8pQwoa0gaYP4MzWIr+nYa5Ucf/AIowQ+SCp4Y+Q7ybSjSv9B8yw+anFtvL/c8nYyeFZ0ANPPyGIBcQkoctPOR4DMoViq4aKxTtVut46+WOh21zCAgcTeirj6j0xFhZb+IRsW8oEWr8wTr7O0SNku+QXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwqCy9mi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KtnBpCSm; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783094731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ExsD+fY9tpTLOuyb4+ACzKrp5pskUXTbgMDg8wamdvY=;
	b=cwqCy9miOPRPJYLx9SGnxUqfkr0aYJ79AeLc9Fgd/lwXHbAg7KXElI5FZmoy3zTeT6N3qD
	BJCyD8ZEr9ACXaV4YMp11ETovW7U6IuFPWRjYVltGMsox39xH0+39UPEIYiHk6jnjuvsTo
	Q5poBjmVDzn/NkCTkIheatz/gb4gCF8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-jX00mQE1Mhy18pxHz2vUsg-1; Fri, 03 Jul 2026 12:05:30 -0400
X-MC-Unique: jX00mQE1Mhy18pxHz2vUsg-1
X-Mimecast-MFC-AGG-ID: jX00mQE1Mhy18pxHz2vUsg_1783094729
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-473e18559b2so435693f8f.0
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 09:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783094729; x=1783699529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ExsD+fY9tpTLOuyb4+ACzKrp5pskUXTbgMDg8wamdvY=;
        b=KtnBpCSmklnpDGyMyURykx1l+ZI6tPdy2UWu9skO+usEEXISEOb4e6KCd3NoeTUMB1
         sENKvVBFp6qXjYuk4xXiwmLoEGz93z8LQYWg3YyEVrC3r6dudi81k23u25b46fdDttNK
         sL+8GfHj4TKUBsP5mI3CZ32wt7M16ks5qr/VgSiTD1kst7ki6MPrYl8snT4+UhbhiUWU
         QJaxnSjQJtayRk7y2ub54G4SMBr57WNMxZF7HBvQMLbZCzTMBeozDOsHnsovAR6x9DNf
         sQci4vgYS6MjoVCdfR83y1z/mcNKd5qS0Kyd8U9UbMp5Hun/y1yhPT8HINQfV2sPEbZi
         CDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783094729; x=1783699529;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ExsD+fY9tpTLOuyb4+ACzKrp5pskUXTbgMDg8wamdvY=;
        b=qIp/I8zZ6KpAgPyK1RoIpmXOgXDmV0kgGn0WXgme5oHOTO2mLffur+x55weRI2ITr1
         2bKRrcw9aqwE0PgwtrnVVS7XOqfsm9tJhoNwqykREgIBqM0bkmoRtESfC+8CBJmGlNQQ
         kJS222VGrISQFJsf99j9t+JB8vpjMemxwmW3qoqFj28aVL7l7laYaXNmf3r0MOLlW3+Q
         5tbsvBgAv766nhL8eyAnaqPfmN4a/55OaHhuZ59oBQgTA6m8QN2n4FpaS17pFsUCoZNE
         6hOUEQjqeOfrKaIQ6NWgyJZWFTFPqetbtXiUyRbStayqdffprug+gPacI8bwNv1u2oEM
         gFcQ==
X-Forwarded-Encrypted: i=1; AHgh+RqHi6Xx9E7RdQP+umBmG84LuPZbnIL41Vstxc6aW8FNnNLtZHGOuRBF4QO81li0/pF5rVFD9sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNMiVQAFYz6JW0NrKyUhBpX8VYOcQ7XMSDKjGw6jV+6d+t/15k
	1gMW2c+Y4I11sanvb6twLLLtLfLUJGoi7SDp0MYKtGlOwxkZo7OHtzT/QIl/QMgFNhWT22hUf83
	mJmGr/swmtvRDm7Wx4AmjNaolaEX7fExqS7MXp03EvfNz6Bpt3qF9liB6mA==
X-Gm-Gg: AfdE7cnFzyJYdA3jRvG8SL+6UEkMlzpVZu62ZByP1Rfp+pilJk7HDzXA8iyqUZs57U3
	zRjIi3WmGq1DCVrv+krlTUou80m0cDECzIQMJO12+/6rBIU1Nl3cN3euvBoKD9MnDI/r4yrAFn6
	uK6VZFEAaHTMn3TudP2dRt7tBJHMQfXc8yhUyV8Y47f7/GHQVgCdLzz4pSggdtq0OdOQLF/Qizn
	oVgfb9mrkI8VWK4cBs+CBQnLYS83hOC/i+4We6LrWOOjUKhEf/oASCov5jbKm6Dtf4U/KyCWwLz
	F/b8c4MU6tU3pZH4r7o1QYnvO21gEAOR+IyWwqrCF+pBznFWt0kBGvUaywm5DpGVTZbegICj1Fn
	bdidGNpW78WLu7RU2qBuky3NdgaHql5gH3c/liW85Efmw3TG6wYd3cAfAYSh+TQalZA==
X-Received: by 2002:a5d:50ca:0:b0:475:f0f0:9ed2 with SMTP id ffacd0b85a97d-477b601c4d1mr12059255f8f.61.1783094728600;
        Fri, 03 Jul 2026 09:05:28 -0700 (PDT)
X-Received: by 2002:a5d:50ca:0:b0:475:f0f0:9ed2 with SMTP id ffacd0b85a97d-477b601c4d1mr12059222f8f.61.1783094728239;
        Fri, 03 Jul 2026 09:05:28 -0700 (PDT)
Received: from debian (2a01cb05923c9a00ac64493857fc411e.ipv6.abo.wanadoo.fr. [2a01:cb05:923c:9a00:ac64:4938:57fc:411e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e6ccsm381813f8f.5.2026.07.03.09.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 09:05:27 -0700 (PDT)
Date: Fri, 3 Jul 2026 18:05:24 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Norbert Szetei <norbert@doyensec.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Breno Leitao <leitao@debian.org>, Taegu Ha <hataegu0826@gmail.com>,
	Kees Cook <kees@kernel.org>, linux-ppp@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] ppp: defer channel free to an RCU grace period to
 fix pppol2tp RX UAF
Message-ID: <akfdxKa9aaKGBFeJ@debian>
References: <D9C0245B-608B-4884-8A09-F55BA4A9F948@doyensec.com>
 <166370f4-0b8c-4af4-9fb7-6967828a99bc@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166370f4-0b8c-4af4-9fb7-6967828a99bc@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304596-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:qingfang.deng@linux.dev,m:norbert@doyensec.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:bigeasy@linutronix.de,m:leitao@debian.org,m:hataegu0826@gmail.com,m:kees@kernel.org,m:linux-ppp@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gnault@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[doyensec.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,debian.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnault@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,debian:mid,doyensec.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BCED70421D

On Thu, Jul 02, 2026 at 04:19:02PM +0800, Qingfang Deng wrote:
> Add: Guillaume
> 
> On 2026/7/2 at 2:12, Norbert Szetei wrote:
> > pppol2tp_recv() runs in the L2TP UDP-encap softirq RX path:
> > 
> >   l2tp_udp_encap_recv() -> l2tp_recv_common() -> pppol2tp_recv()
> >     -> ppp_input(&po->chan)

Hi Qingfang,

Thanks for Cc-ing me. I haven't had time to look at this problem yet,
and I'll be offline next week. So not sure if I'll get the possibility
to provide any feedback to this patch in time.

> > It runs under rcu_read_lock() holding only an l2tp_session reference and
> > takes NO reference on the internal PPP channel (struct channel,
> > chan->ppp) that ppp_input() dereferences.
> > 
> > The pppox socket is SOCK_RCU_FREE, so 'po' and the embedded ppp_channel
> > are RCU-safe.  But the internal struct channel is a separate allocation
> > that ppp_release_channel() frees with a plain kfree():
> > 
> >   close(data socket) -> pppol2tp_release() -> pppox_unbind_sock()
> >     -> ppp_unregister_channel() -> ppp_release_channel() -> kfree(pch)
> > 
> > For a channel that is bound (PPPIOCGCHAN) but not attached to a ppp unit
> > (no PPPIOCCONNECT, pch->ppp == NULL) and not bridged, teardown skips
> > both ppp_disconnect_channel()'s synchronize_net() and
> > ppp_unbridge_channels()'s synchronize_rcu(), so the kfree() has no grace
> > period.  rcu_read_lock() in pppol2tp_recv() does not protect against a
> > plain kfree(), so an in-flight ppp_input() on one CPU can dereference
> > the channel just freed by close() on another CPU.
> > 
> > The bug is reachable by an unprivileged user.
> > 
> > Defer the channel free to an RCU callback via call_rcu() so the grace
> > period fences any in-flight ppp_input(). The disconnect and unbridge
> > teardown paths already fence with synchronize_net()/synchronize_rcu();
> > call_rcu() does the same here without stalling the close() path.
> > 
> > Fixes: ee40fb2e1eb5 ("l2tp: protect sock pointer of struct pppol2tp_session with RCU")
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Norbert Szetei <norbert@doyensec.com>
> > ---
> > v2:
> > - Moved skb_queue_purge() to a dedicated RCU callback to prevent leaking
> >    skbs added by an in-flight ppp_input() during the grace period (Sebastian).
> > - Retained call_rcu() to avoid introducing synchronous multi-millisecond
> >    latency into the teardown path.
> > v1: https://lore.kernel.org/netdev/C954A7EA-AA98-4E3C-80B5-42C34B3183A3@doyensec.com/
> > 
> >   drivers/net/ppp/ppp_generic.c | 17 ++++++++++++++---
> >   1 file changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> > index 57c68efa5ff8..2d57de77780f 100644
> > --- a/drivers/net/ppp/ppp_generic.c
> > +++ b/drivers/net/ppp/ppp_generic.c
> > @@ -184,6 +184,7 @@ struct channel {
> >   	struct list_head clist;		/* link in list of channels per unit */
> >   	spinlock_t	upl;		/* protects `ppp' and 'bridge' */
> >   	struct channel __rcu *bridge;	/* "bridged" ppp channel */
> > +	struct rcu_head rcu;		/* for RCU-deferred free of the channel */
> >   #ifdef CONFIG_PPP_MULTILINK
> >   	u8		avail;		/* flag used in multilink stuff */
> >   	u8		had_frag;	/* >= 1 fragments have been sent */
> > @@ -3562,6 +3563,18 @@ ppp_disconnect_channel(struct channel *pch)
> >   	return err;
> >   }
> > +/* Purge after the grace period: a late ppp_input() may still queue an
> > + * skb on pch->file.rq before the last RCU reader drains.
> > + */
> > +static void ppp_release_channel_free(struct rcu_head *rcu)
> > +{
> > +	struct channel *pch = container_of(rcu, struct channel, rcu);
> > +
> > +	skb_queue_purge(&pch->file.xq);
> > +	skb_queue_purge(&pch->file.rq);
> > +	kfree(pch);
> > +}
> > +
> >   /*
> >    * Drop a reference to a ppp channel and free its memory if the refcount reaches
> >    * zero.
> > @@ -3581,9 +3594,7 @@ static void ppp_release_channel(struct channel *pch)
> >   		pr_err("ppp: destroying undead channel %p !\n", pch);
> >   		return;
> >   	}
> > -	skb_queue_purge(&pch->file.xq);
> > -	skb_queue_purge(&pch->file.rq);
> > -	kfree(pch);
> > +	call_rcu(&pch->rcu, ppp_release_channel_free);
> >   }
> >   static void __exit ppp_cleanup(void)
> 
> Reviewed-by: Qingfang Deng <qingfang.deng@linux.dev>
> 
> FYI, I attempted to merge the two channel structs and AI-review found a UAF
> [1], so this patch addresses the issue.
> 
> [1] https://lore.kernel.org/netdev/590d7931-02b0-45d6-8f43-ef909c9bde89@redhat.com/
> 
> Best regards,
> 
> Qingfang
> 
> 


