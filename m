Return-Path: <netdev+bounces-286290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJOQL/OKAGpKKAEAu9opvQ
	(envelope-from <netdev+bounces-286290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 15:41:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEC7504517
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 15:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D28383001A6F
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 13:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D968388E63;
	Sun, 10 May 2026 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ckIxGIhy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQuYtERa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1B021ABC9
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778420457; cv=none; b=Pi1hSfqaXSDXXlrn9aAhnNRI8zBjvFKt/nfR3beNkW6oHXfh3qsSC+ryWbOaTo2EiurnVpCrhl8+YD4PC1UK+p67lijPhgX2eqhRFwFnZp/bez8Voe8o65Z04wZWY5Te3DnTvdWzlIDKQ46/uOspLlAmkblbGKX/sxHwXPraMro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778420457; c=relaxed/simple;
	bh=pN3+xf+lvplk/XSDKnk1tzXRm+HoHaTy2CDzov5pZOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xn3J11K7BAn2hFNzCsEnsdbfv/61bktobaYDznWSrJmmI7BKDpir/tqBy3soNn6fw78uMVjua5uuTg5B5N8WpoRmkzywoMD5hfAYxz3T+OgOGItUvtITjvhvvsDAdmznNivEQZwenj1JJSAsg8Mq9ni1XGZ3J6IvF3SoWdrWgks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ckIxGIhy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQuYtERa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778420455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L7Q24s236I9i1NyfkoKYidKcVPTH3QXz7TWxO8KOigQ=;
	b=ckIxGIhyimV7gcBE7y2xX625HiGY0TqfEd6eOsVHEFTPHj5xM+rUr/+pXd2KNIrte3zcAI
	sEjG2cHs18T2JtpesjhBk3h8haoW9yem5v5xBtyKPHxYqtj5v/bN138QN1I/pn2uXPlLcE
	tRpqM43TijYGHfKWQAovS6cYCPMl5TE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-z3DUNegNOh-rOZbNCBpQRw-1; Sun, 10 May 2026 09:40:53 -0400
X-MC-Unique: z3DUNegNOh-rOZbNCBpQRw-1
X-Mimecast-MFC-AGG-ID: z3DUNegNOh-rOZbNCBpQRw_1778420453
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48a589c7879so34625495e9.1
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778420453; x=1779025253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7Q24s236I9i1NyfkoKYidKcVPTH3QXz7TWxO8KOigQ=;
        b=ZQuYtERahi/8LgIzhW69B7hR9QWkr8vGGY4k3KdbJR+l+po8TMVVAo8FKWwnWVYNxb
         PmZewJ4vOJY+4R3Ux82d8QmDp4MbWxKWg0r+2CRfuaBuSmam7+DeCihrcnRreeDrX/jn
         j/8BfdH/cq27ipbtmbusjlmuhV+7C9iOqmYs8ameIZmO5R8yZ7tqb3ZkwekL9ZmG5fJt
         z764h0iCLH6pxJ1rNMErxp+d2hk7WuIxuncEabiHnkujD7bTR2wF8iw0OJFSTTRdGtBY
         ml8UxMMzbs3MtdNY0zs3xIFKapFKEbZRSk0DRmRXlBR3BSOD+K7gWqrqXU3TLoH8OLRL
         qXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778420453; x=1779025253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7Q24s236I9i1NyfkoKYidKcVPTH3QXz7TWxO8KOigQ=;
        b=j2RVfnWV+hjEU28swBzWjIUEiIFVYbtidAeu2a782Z2XoAdG5H1qVCf3hC2U9tkSHS
         JAY2t7TrcYJ3qu0rKhpE4wWWL+ZhJ+wa8ZTzhQBZ4dalG/PoEr4kdmwoBbIcab8rYQqB
         nFfWcE4YOXnIYO+6qD9ElXxOPZQwme9/SQF++j69NF0HNTXJ0gtcSotqKUS/+LBo957x
         hXhH5l9LDHB8jLVX6KkuAr0TmmRy71sEw5RXk4faoWvW047jukVPFIFfdFGgCaOM7zED
         2w5mqX0EIS02IVr+63uilKV6uw7MPCIZg5sZg3eOG/Ti7118jGJfX60aDkGWcnzjb4Lb
         JZeQ==
X-Forwarded-Encrypted: i=1; AFNElJ++AtiOBw+FTZ9crKR0299I449WqMWjsd1HEvm1WLKEqEzuloTwjxOxfc4sxYe3/eKHoEbt2Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS3uvVMIyHek97GlofI/HToNQZaRE6KK5ghyEeHGDCFNdEVRmt
	X8EtXixC/pEzAOsAai116TCWivSD1pqXoJklJdCwPu2uAtu19ufqEx38SqJ3HuKOnTBcgvppoCu
	xYhx1tTUtijko/6VmdnLtp02K9ObgXrm+OpC3XEFuAJMy06yvjyR8ObxTmg==
X-Gm-Gg: Acq92OEPyceA0NG4KoorT+GWoUY/ZhqCpbvd7nO6SwAk5hiLX1iLlJ1Yy5ZLlsIJOUT
	cr/pSIqDBNrAsn5n6JJhwEzq2DcxdV69DYANdO61O1K+qdNr6SC7J0pKsJJskhn4CM9k12hnuXh
	aXdzQQ8WTw0amRJyWJXf33uTD9ZhaxKylErcnhI1NZ4v6qOgLhW8kKu1l/SEn18rUQK2tBwZEUu
	LAUbLHvnWq13rzOVcttCnvyIyNbGzWWdFdvAZqDAChaUIav02wLociTlD22XTeMv7XYOb0DeATZ
	5fGxbV4YrxQ7OxkuDvkTbYKLY5eb42J0rxpIFSSoohqLtdSk3HUKV7CcdlIRjGkcQ1GTRQ67Yyp
	FCYTW+hz7qX7VF69kxtB4N9ZXWVUTan0qNA5Wy8KV
X-Received: by 2002:a05:600c:638e:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-48e5e00c1b9mr231940895e9.14.1778420452515;
        Sun, 10 May 2026 06:40:52 -0700 (PDT)
X-Received: by 2002:a05:600c:638e:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-48e5e00c1b9mr231940315e9.14.1778420451950;
        Sun, 10 May 2026 06:40:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d8e4ce1sm43533835e9.9.2026.05.10.06.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 06:40:51 -0700 (PDT)
Date: Sun, 10 May 2026 09:40:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v11 1/4] tun/tap: add ptr_ring consume helper
 with netdev queue wakeup
Message-ID: <20260510094020-mutt-send-email-mst@kernel.org>
References: <20260508151048.183125-1-simon.schippers@tu-dortmund.de>
 <20260508151048.183125-2-simon.schippers@tu-dortmund.de>
 <dd0a3ef1-d623-4e09-a391-b56fa4bf95af@tu-dortmund.de>
 <20260509183518-mutt-send-email-mst@kernel.org>
 <a14b700a-94e8-44c0-bde0-d8307761c0f1@tu-dortmund.de>
 <9a4458fc-61f2-469b-8260-f144d3827b5d@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a4458fc-61f2-469b-8260-f144d3827b5d@tu-dortmund.de>
X-Rspamd-Queue-Id: 5AEC7504517
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286290-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 10:55:34AM +0200, Simon Schippers wrote:
> On 5/10/26 09:03, Simon Schippers wrote:
> > On 5/10/26 00:44, Michael S. Tsirkin wrote:
> >> On Sat, May 09, 2026 at 06:31:47PM +0200, Simon Schippers wrote:
> >>> On 5/8/26 17:10, Simon Schippers wrote:
> >>>> +static void tun_queue_purge(struct tun_struct *tun, struct tun_file *tfile)
> >>>>  {
> >>>>  	void *ptr;
> >>>>  
> >>>> -	while ((ptr = ptr_ring_consume(&tfile->tx_ring)) != NULL)
> >>>> +	while ((ptr = tun_ring_consume(tun, tfile)) != NULL)
> >>>>  		tun_ptr_free(ptr);
> >>>>  
> >>>>  	skb_queue_purge(&tfile->sk.sk_write_queue);
> >>>
> >>> Sashiko is right once again. tun_ring_consume() in tun_queue_purge()
> >>> operates on a tfile that is being torn down. Its queue_index is no
> >>> longer valid. After the swap in __tun_detach(), it points to the
> >>> netdev subqueue of a different tfile.
> >>> --> We should not wake there.
> >>
> >> Does it not exactly point at ntfile which is what we want to wake?
> >>
> > 
> > I see your point. But calling tun_ring_consume() as done here is
> > wrong, because it does not wake if the tx_ring of the tfile 
> > (that is currently torn down) is empty. We could change
> > tun_ring_consume() to call __tun_wake_queue()
> > with consumed=0 if !ptr but I think this would slow down the consumer
> > path.
> >
> 
> My statement is wrong:
> There is no way that the tx_ring is empty and the queue is stopped
> at the same time. So we do not need to touch tun_ring_consume() and
> this works just fine.
> 
> >>
> >>> I will swap tun_ring_consume() with ptr_ring_consume() again and
> >>> submit a v12 :)
> >>
> >> If so then maybe
> >> netif_tx_wake_queue(netdev_get_tx_queue(tun->dev, index));
> >>
> > 
> > But we should only do this if there is space in the ntfile.
> > My approach:
> > 
> > @@ -586,12 +588,18 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
> >  		BUG_ON(index >= tun->numqueues);
> >  
> >  		rcu_assign_pointer(tun->tfiles[index],
> >  				   tun->tfiles[tun->numqueues - 1]);
> >  		ntfile = rtnl_dereference(tun->tfiles[index]);
> > +		spin_lock(&ntfile->tx_ring.consumer_lock);
> >  		ntfile->queue_index = index;
> >  		ntfile->xdp_rxq.queue_index = index;
> > +		ntfile->cons_cnt = 0;
> > +		if (__ptr_ring_empty(&ntfile->tx_ring)) {
> > +			netif_wake_subqueue(tun->dev, index);
> > +		}
> > +		spin_unlock(&ntfile->tx_ring.consumer_lock);
> >  		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
> >  				   NULL);
> > 
> > ntfile->cons_cnt is unvalid, because the new queue might not be stopped.
> > That is the reason why I reset it to 0.
> 
> However, I still prefer this approach because the code is easier to
> understand.


So do you want me to finish review of this one and ack, or want to
post v12?


