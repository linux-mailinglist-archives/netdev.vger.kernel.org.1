Return-Path: <netdev+bounces-286316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LklMQaoAGp/LQEAu9opvQ
	(envelope-from <netdev+bounces-286316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:45:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C5B504E63
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1EDF83006D57
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 15:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89463A0B1C;
	Sun, 10 May 2026 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drFbcTBN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GuOB4b8p"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF02F388E7C
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778427884; cv=none; b=bxsMDBDCX4wjwg4yo8i1acnFUF9vDSRQwfcIJsrSZZexGXrHQH6y5KmhVfefkQCK7mznDZ4kN32aYFWRYU04xy5GghvYFaZj6M0IS9CfxCLlgg8S+gl3udWW31aEv++pG7X95qnrL5U4TF8ktStWCAqYX4WUF378i1NNIOSqTb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778427884; c=relaxed/simple;
	bh=oCHlo1fqZatJDIDvyJ1SrB7bwf2coY5WCAjVkHb+KpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkzMZQdD5fDLyDh6oql/iaZ7XxEFrhFjAv5Z+Th7vga6tODIUVNFKB88GBDoUlTGuCp68nwAAmSPTOlT27/4nFnTF+v2Z8LceGUz6g19HELaIxC8knEOVHMXOajIWqt7u++/+rHYXy+mSGznX30V3jkenHebEJYu9U3Nowl55UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=drFbcTBN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GuOB4b8p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778427882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7jk9H54lMHadSFms9Swh2u6zzH7MNV3xP2hPzoWhQ7I=;
	b=drFbcTBNUBhA8/eDHasEV2qAYSHcZRFeytR6QkwMoJ33NH88QalEd4uSUMtFdESNHzCqob
	d4crOXfdW7VdT20M+fhLnhkqPqAxoMT3WkJqGWQ2hwcB2dgHH//0fvwjh9Cd5/AOEVzFR1
	qgKfpofBl+xOyyZth/2UGnP/MESe+dY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-r9zt-uWOMq-Nldm0V3RxbQ-1; Sun, 10 May 2026 11:44:40 -0400
X-MC-Unique: r9zt-uWOMq-Nldm0V3RxbQ-1
X-Mimecast-MFC-AGG-ID: r9zt-uWOMq-Nldm0V3RxbQ_1778427879
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-38e83f048bbso17121091fa.2
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 08:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778427879; x=1779032679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7jk9H54lMHadSFms9Swh2u6zzH7MNV3xP2hPzoWhQ7I=;
        b=GuOB4b8p4LkJw+/mwuEKmvVdU0Y8qAhLOm5ictQv5WRJ13qxNDxJflu3zd034A4HFN
         uSzPSxjwFDWrLuHoaHsq+NgKNWCi6Ol0WlrpZwBPEmHAyHhiURjuKrQRPTYX8TRcryWG
         zJYzM3yTLkP1asSFichwSR0IWsJ3N0Eng+Rk93H/ttg90w3kcxXrG/kfMmk8NwMtGsd/
         huj87W1rbpT856F4aShWZgQw/bh6QCRsKLMseEQAvazGQ+m3IhwOyVov66wvh9G1OE+q
         E1Z4GwiuRXf+GexF2KPsBU5dBYFx804Tyr6CjJP21Qom2ghwNtE451laPluJQVkkdJGl
         p0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778427879; x=1779032679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jk9H54lMHadSFms9Swh2u6zzH7MNV3xP2hPzoWhQ7I=;
        b=ql4SD5is8X2PTJc/DOXtwUW0/cO1aSnmWfkT5VMDsaHQtr/EyN4y2CQAMiQJIQHBvE
         GCYj9T9NXqAHLmjIRGtJqNYtxV267CqJRr0jNMl7dj5imBzDopFdtGbuDaG9Gg7JEl23
         H/RIOwqwmcfwATKsHRQz0ERwIxSYVwJhTFT3Cy2564GlFvzt/WKagg/pP8Kp6uNFIwtX
         38JxTSPIeIspo+32Mb7cE6UFIONt1MIY7F1pI0a+38mKJPBGPI3nssCZ0NadxQw608F2
         hdOZ4IU4acvjdfSF5UzAgYXzJwRwlXAp8fG7lu+vTDvzkCMo8xEuKE9q2htbAIb91oky
         WEUA==
X-Forwarded-Encrypted: i=1; AFNElJ/9+0on5yyybQN0OvyWnvvGmH8H+7XiQgOJWApJKWR2vbKjhQP8lsIki0kV+zt/Bhtu/J5c85U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcBB+nM1NxE9EtXIjLlBj0K1lDp7Ymg/jVkZElGd81ugppWJFE
	GXHMam+8FReUO5tsNm0Wxl9lgW6crZexwOTJOWGxX9HoZ/ZrWUY84q9e2ZMYsCwycYNx/iZTOO9
	WS6Hx26HfW4CeNEiMFm6Ha0jHR9HdwpeW6aT3G9ummAYX2sXeEFlv68sHWA==
X-Gm-Gg: Acq92OGmG9c9L7rDtIEeUELPQyhajXOSRLsQ70wwFGX0Z2Lx4KpY+XgRGjjIHttIm78
	aPL5fOo6mRNXMrk/Z9VjolKo/evPy7G/yURYvJzQoF0slhZ4oQ/WdGsH50qXVY91jmowkGSX+NK
	F9KKFBjmMGigiyZLUnw90W94Ow+bolQYrTHqEZVxn2IbYUYyPkO6fH3IQXFQjDTlXzrxIKZNqH2
	QnEokPcVUKB+ZQVjEZ6sgGa6VJEm41xFc06di8d+LjsYL2z+KGYWu7GBGbUCgo0+/iQmf4WIms8
	82Z8lPK0SmqlRPe30CsRZdOvtTsxwVUcaYEKEQ0y/WIEB+599PsqzNkwnAN/BxGQrYfh6N7colR
	Fgirid3w2MXAi+BYd7D1oWEFF0VdEzoMxMNtwq7mv
X-Received: by 2002:a05:651c:54e:b0:38e:e6fd:65b2 with SMTP id 38308e7fff4ca-39408132229mr19263581fa.21.1778427879024;
        Sun, 10 May 2026 08:44:39 -0700 (PDT)
X-Received: by 2002:a05:651c:54e:b0:38e:e6fd:65b2 with SMTP id 38308e7fff4ca-39408132229mr19263431fa.21.1778427878424;
        Sun, 10 May 2026 08:44:38 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f60db4f1sm19882511fa.27.2026.05.10.08.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 08:44:37 -0700 (PDT)
Date: Sun, 10 May 2026 11:44:32 -0400
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
Message-ID: <20260510114401-mutt-send-email-mst@kernel.org>
References: <20260508151048.183125-1-simon.schippers@tu-dortmund.de>
 <20260508151048.183125-2-simon.schippers@tu-dortmund.de>
 <dd0a3ef1-d623-4e09-a391-b56fa4bf95af@tu-dortmund.de>
 <20260509183518-mutt-send-email-mst@kernel.org>
 <a14b700a-94e8-44c0-bde0-d8307761c0f1@tu-dortmund.de>
 <9a4458fc-61f2-469b-8260-f144d3827b5d@tu-dortmund.de>
 <20260510094020-mutt-send-email-mst@kernel.org>
 <e5d69f44-4483-49f3-b7fc-aca2cdb24792@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5d69f44-4483-49f3-b7fc-aca2cdb24792@tu-dortmund.de>
X-Rspamd-Queue-Id: C4C5B504E63
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
	TAGGED_FROM(0.00)[bounces-286316-lists,netdev=lfdr.de];
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

On Sun, May 10, 2026 at 04:01:39PM +0200, Simon Schippers wrote:
> On 5/10/26 15:40, Michael S. Tsirkin wrote:
> > On Sun, May 10, 2026 at 10:55:34AM +0200, Simon Schippers wrote:
> >> On 5/10/26 09:03, Simon Schippers wrote:
> >>> On 5/10/26 00:44, Michael S. Tsirkin wrote:
> >>>> On Sat, May 09, 2026 at 06:31:47PM +0200, Simon Schippers wrote:
> >>>>> On 5/8/26 17:10, Simon Schippers wrote:
> >>>>>> +static void tun_queue_purge(struct tun_struct *tun, struct tun_file *tfile)
> >>>>>>  {
> >>>>>>  	void *ptr;
> >>>>>>  
> >>>>>> -	while ((ptr = ptr_ring_consume(&tfile->tx_ring)) != NULL)
> >>>>>> +	while ((ptr = tun_ring_consume(tun, tfile)) != NULL)
> >>>>>>  		tun_ptr_free(ptr);
> >>>>>>  
> >>>>>>  	skb_queue_purge(&tfile->sk.sk_write_queue);
> >>>>>
> >>>>> Sashiko is right once again. tun_ring_consume() in tun_queue_purge()
> >>>>> operates on a tfile that is being torn down. Its queue_index is no
> >>>>> longer valid. After the swap in __tun_detach(), it points to the
> >>>>> netdev subqueue of a different tfile.
> >>>>> --> We should not wake there.
> >>>>
> >>>> Does it not exactly point at ntfile which is what we want to wake?
> >>>>
> >>>
> >>> I see your point. But calling tun_ring_consume() as done here is
> >>> wrong, because it does not wake if the tx_ring of the tfile 
> >>> (that is currently torn down) is empty. We could change
> >>> tun_ring_consume() to call __tun_wake_queue()
> >>> with consumed=0 if !ptr but I think this would slow down the consumer
> >>> path.
> >>>
> >>
> >> My statement is wrong:
> >> There is no way that the tx_ring is empty and the queue is stopped
> >> at the same time. So we do not need to touch tun_ring_consume() and
> >> this works just fine.
> >>
> >>>>
> >>>>> I will swap tun_ring_consume() with ptr_ring_consume() again and
> >>>>> submit a v12 :)
> >>>>
> >>>> If so then maybe
> >>>> netif_tx_wake_queue(netdev_get_tx_queue(tun->dev, index));
> >>>>
> >>>
> >>> But we should only do this if there is space in the ntfile.
> >>> My approach:
> >>>
> >>> @@ -586,12 +588,18 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
> >>>  		BUG_ON(index >= tun->numqueues);
> >>>  
> >>>  		rcu_assign_pointer(tun->tfiles[index],
> >>>  				   tun->tfiles[tun->numqueues - 1]);
> >>>  		ntfile = rtnl_dereference(tun->tfiles[index]);
> >>> +		spin_lock(&ntfile->tx_ring.consumer_lock);
> >>>  		ntfile->queue_index = index;
> >>>  		ntfile->xdp_rxq.queue_index = index;
> >>> +		ntfile->cons_cnt = 0;
> >>> +		if (__ptr_ring_empty(&ntfile->tx_ring)) {
> >>> +			netif_wake_subqueue(tun->dev, index);
> >>> +		}
> >>> +		spin_unlock(&ntfile->tx_ring.consumer_lock);
> >>>  		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
> >>>  				   NULL);
> >>>
> >>> ntfile->cons_cnt is unvalid, because the new queue might not be stopped.
> >>> That is the reason why I reset it to 0.
> >>
> >> However, I still prefer this approach because the code is easier to
> >> understand.
> > 
> > 
> > So do you want me to finish review of this one and ack, or want to
> > post v12?
> > 
> 
> I will post a v12 with the proposed changes for patch 1.
> No other changes.
> 
> Thanks!

actually can you clarify? why only when ntfile ring is empty?


