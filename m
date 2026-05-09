Return-Path: <netdev+bounces-286222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3MiUAfW4/2l59wAAu9opvQ
	(envelope-from <netdev+bounces-286222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 00:45:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB47C501AEF
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 00:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 53FD430028FD
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 22:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459093D5671;
	Sat,  9 May 2026 22:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icDk8l7h";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rdMwsFFC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95621372B3B
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778366701; cv=none; b=BREk9dfcwgtFwTtFJdhiATfQFH5y4vRdXkrSbyrOmGk2l+gqf8Pwqrduh5PRsu7r6afiH2Ee2SW5RrKCJWqRU0nAw28clZYRjmrmDRitWwva71qrl+IriuNrv1/VSopPs/CjCokGvmu/D+gAkrSPS5/5HpsvIeeC6906mQLDXHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778366701; c=relaxed/simple;
	bh=I1uaCfP7MUFzA0C5hMsAjutKxQqou3ouWa1Ws0Uyyh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lk9Hv3pZpLGU5x+Qwcuw9/x4xBh/eK1h+wSwsI8K1yNvd8Gh8rGQ1D1QHomTGFAD4dOSVwETzvvn0pI1osD3MQKdwlgUvQpp0JySgwfpvGZDTPXQCSoQrQId/CMDKwZUr76vsy04NMunOcj82vRgebrhGuq1e0UhTVfvKlVqxtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=icDk8l7h; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rdMwsFFC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778366698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RMLC0/7OpZlfwin12rT49rU9O67TrMCpNs0CyOiqETU=;
	b=icDk8l7h68RejWheeD+g0aFYJIrCKMwIiNdTqPW1b2mTWwwTiq8xLLmilDf0g3aqdf4W3m
	qF7M2S7WmboAxUh6FqW89t9HyqWDIg6o0GXS9W/f1rFWhMSCuFed5DAKMsMTNFZ+g4wCmG
	cYPeaflLnpAbfV+qKlo8ihmE9UbZ3jU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-YPcpPIQyNIqXknWYswISyg-1; Sat, 09 May 2026 18:44:57 -0400
X-MC-Unique: YPcpPIQyNIqXknWYswISyg-1
X-Mimecast-MFC-AGG-ID: YPcpPIQyNIqXknWYswISyg_1778366696
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48a589c7879so32149305e9.1
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 15:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778366696; x=1778971496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RMLC0/7OpZlfwin12rT49rU9O67TrMCpNs0CyOiqETU=;
        b=rdMwsFFCMLqxUIVI83E5KrN74A3fDianVDy9zf4Yo+Sd4zBICG4qH8ccoPW7sBI1Dk
         XvsRMRLWSThPFmT63h2BM3447EOyN4dBcpMMUIvFMDqU+MFl1Mc2eeBW/GkMLjspy6LB
         Gb261fRxrmqxeU82bYVaEfFvVFWHDKSzn3rYXG8MynTrTdLGmK1gEdb13Dc7y1Zyjo5W
         YCJpETqNE47OGlo130iML9CVnYqdHPzeF66ftiREoW99Qk1n+mTvgVSkyjikmjbp1qQQ
         CBOomKPSYNwZOo/mJIiE4pqowNjEZHcRA+Rvswi8hXjAI2n5xhFX64Cx+0pgPCE6aBrQ
         n3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778366696; x=1778971496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMLC0/7OpZlfwin12rT49rU9O67TrMCpNs0CyOiqETU=;
        b=VQtKDfioznabNmH1HKKIHNjVCIccfcQYEy2OUV87akkLmhB3rXMUB6ILmZO8hYB+gc
         /Eh0iy52vlDetQW+ftDgsxFPMFM686+o6EZobEqqjymUBExopwYj6h7zzmM46+kZNgiz
         9L09DTJ5IlQx58cSnuDqxGyv5UCRAAfE9Xl3gRLVckRUNj8LB//qsO43WxfaIgtf6PeV
         fe25pyoTxMLjmqsAYqtwa7saW2Caul9KXYHJ+tJtwWrZBPbjN5e0GPk9jqCHYsEZfxGI
         RkKCp6lWLlnXjj4rWsZi/BtidU0DCdaR70XZcfovyehTGdAjnKuWxMUGJnT5bjVp9at7
         l+qQ==
X-Forwarded-Encrypted: i=1; AFNElJ8HIxppWGyCSBhuysOGhOdQq3GTdk02Dglv7RURoSEG+CRQi7sdgigNP6y1aiM9hAL3SnrEkZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiTWUQX32CVz460rnf02newWZYczXVmr81rGVT2g1a+7FYSwuq
	hTx/GPv/UikD0385FIegZGhABhy0B3JH07faYWlaBkUdzOTNaDFIy+QI+6B8u5GZJpx1ZR7VGbh
	Vaf5AuHao5eSo8kIud8spApvtR3fTmMmAH1GlrY9HOK2SfyGuceVrxQjX0A==
X-Gm-Gg: Acq92OHmB+pVK3pizJYZueKXpsAZXLV64UMQALy9nw7LMcthyDzoUj2e4+BOzzjNI7j
	pOE9/MTAkTwMU7R2Ic1m5XbuWAmxyNhZ4FFWVQjc8Mjyd5iloACAGZCAIA/8Nzc8cycOr8VJnQ7
	Smk8BX6b+7O9raXj8SOU47Xd7rl/VwgqNLr3zKUS986nVDKSdgA+2OkSJYxmZgPk6054xo/koy4
	rGPS3s838sVIOdpEjSAqOGYOFdzR/mAMvX8d6g/mXP/ky8DEtlT54p7vZBb96/c9/2GmkfCLS8j
	I0Rdp8ElqXSmOcWPJIGqG0cXlYZoxZ0K6eAdFTbDoQtR5O66fe9ZXQmnOLUnd+w2Li7jNs6iUU4
	BsGn3Jhm3XQ8lJAEujM9W1tbj2m0AQvNiYzA9qZKe
X-Received: by 2002:a05:600c:3b8f:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-48e642deefamr148087305e9.7.1778366695918;
        Sat, 09 May 2026 15:44:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3b8f:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-48e642deefamr148086915e9.7.1778366695323;
        Sat, 09 May 2026 15:44:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6dafa6c2sm42673165e9.5.2026.05.09.15.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 15:44:54 -0700 (PDT)
Date: Sat, 9 May 2026 18:44:49 -0400
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
Message-ID: <20260509183518-mutt-send-email-mst@kernel.org>
References: <20260508151048.183125-1-simon.schippers@tu-dortmund.de>
 <20260508151048.183125-2-simon.schippers@tu-dortmund.de>
 <dd0a3ef1-d623-4e09-a391-b56fa4bf95af@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd0a3ef1-d623-4e09-a391-b56fa4bf95af@tu-dortmund.de>
X-Rspamd-Queue-Id: EB47C501AEF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286222-lists,netdev=lfdr.de];
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

On Sat, May 09, 2026 at 06:31:47PM +0200, Simon Schippers wrote:
> On 5/8/26 17:10, Simon Schippers wrote:
> > +static void tun_queue_purge(struct tun_struct *tun, struct tun_file *tfile)
> >  {
> >  	void *ptr;
> >  
> > -	while ((ptr = ptr_ring_consume(&tfile->tx_ring)) != NULL)
> > +	while ((ptr = tun_ring_consume(tun, tfile)) != NULL)
> >  		tun_ptr_free(ptr);
> >  
> >  	skb_queue_purge(&tfile->sk.sk_write_queue);
> 
> Sashiko is right once again. tun_ring_consume() in tun_queue_purge()
> operates on a tfile that is being torn down. Its queue_index is no
> longer valid. After the swap in __tun_detach(), it points to the
> netdev subqueue of a different tfile.
> --> We should not wake there.

Does it not exactly point at ntfile which is what we want to wake?


> I will swap tun_ring_consume() with ptr_ring_consume() again and
> submit a v12 :)

If so then maybe
netif_tx_wake_queue(netdev_get_tx_queue(tun->dev, index));



-- 
MST


