Return-Path: <netdev+bounces-262204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOCDBiZLo2nW/AQAu9opvQ
	(envelope-from <netdev+bounces-262204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:08:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA041C7EE7
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 384E930F9506
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 19:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E31317148;
	Sat, 28 Feb 2026 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqVmo4BE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/heX2A1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB31317143
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772305771; cv=none; b=cliV/NqcwT3COAD7s8w8GNfM0LHwWjZwR0VeBm/aw91lGSPT2LDnnsb9L7uibXysx+ShBhMUq0R+eq56gkGUb53beCKkLm8HwQp1ludww36a97f06Mv3iFlV6pifM/9853rF30IssDqszor2577Y8VeBAcLBEB8fSqCq34z0uUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772305771; c=relaxed/simple;
	bh=cgrra4B/i/V8Hiz0UZkBK1PpLGhkkR9xkKlji3DaXus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCo61N2/7r2u9Eft9i4nwomEwreJlVpenQI+X4ihcGlcilfUmU4kZ8dyU5YX2iO7JMXAqbdix0aNcO+keeu8/02P5oTl+wuhW97dTfAwSrkngDvMDXfVGdLVglUDW58LDXaf1BNf6+7sDAp8GkZanEbq/evKe4Os0WCFO5PCBC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iqVmo4BE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C/heX2A1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772305769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1mthzCRUAS99QEZz/4n5tzjUOyKpLiDJe/rzSMKQArA=;
	b=iqVmo4BELeGVfWBe3jLuhM43SaSH2q3HflyT0TaMUIFoWCkHKklM3hq2wJhnj2CyHBjTw1
	uBlYUpXnxm+1V7/8phSgsIkHzBK5p8wzb8CIMqnlxuP0JUIqEmZyqz4pd4PPPZA5HuqF5F
	8HCq02pwUZpUBsxpDjD+N5b/ti6CIug=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-utsRgNl0NhiKbJb0oZVLXQ-1; Sat, 28 Feb 2026 14:09:28 -0500
X-MC-Unique: utsRgNl0NhiKbJb0oZVLXQ-1
X-Mimecast-MFC-AGG-ID: utsRgNl0NhiKbJb0oZVLXQ_1772305767
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4836e35292cso27115985e9.1
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 11:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772305767; x=1772910567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1mthzCRUAS99QEZz/4n5tzjUOyKpLiDJe/rzSMKQArA=;
        b=C/heX2A1y/YzwacCyKvcSZQlX4lGQ2QUgOQy9puKgjXVLaOyxl+1e5KybcW4r25mXB
         av8uX5OtEtb8AugFpL3goNxIN+9lKMWEDKRfqNG8pAsrOOxVDLzVctfJTMBSt/I4HYVi
         863Mit4XGaXEg+7fNplroTjaAJ6r59hlgOXMiBdBLpe4nzoCCH/xgpKZC+TRy4RCnrbN
         xlhqoQpF+0ZurqPDo9fwHESgYvHI/7QSmXMIahrVplVELuWRwIfo70yKMnJe22e9lCbt
         VjvpeQitgo8/w1besgxd2+av0yWqZqasCq0JTXZ7fzDxeR5HZKYUAnPjsDU+VIVFFE2L
         EyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772305767; x=1772910567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mthzCRUAS99QEZz/4n5tzjUOyKpLiDJe/rzSMKQArA=;
        b=n+hV4eGeXqc3EdKGD6mCJup1fNMK312bBQcbjRZzqSM39O/InAP/rHlxPXQMiXgIb0
         u4THeqYoPwhgdW2hrBu+wEqBgJnYZRF2p1dQ9L3AlkRouQLHIFw6v6PSUazUwI5sj42r
         1j6ZqESl6UAG6QoLOiqj17MasEGfnRRvihSf4Ku9GloQ7fPyL6gIE/S2LKRIuZMOLw9N
         AcSNpI7NYREnRsO0+UwrjJrjzcOVTHdGJiia2OBydsaASGhtqxZDU0YtAWbyeXR33Uoo
         2KBjkZOPlnThy4qC+wFsVG9nga6FnG2RoiChJy/s5UZvfD2APtyTcD3gpCw+JeMIm/da
         dCgw==
X-Forwarded-Encrypted: i=1; AJvYcCVm+VWLsHJyl4W86CIU8URJAC58rmyMgT+wKfQvb+3wytBZgkiooIw88QupOkUHuP2CmDcOAbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdwNBNUnpBw+CJg7JirgpoiXAWYzU4fKn3MLKigrIjYCJ4HSRT
	WM+ElIWcjFOiwtfcTL+X4TP1o7ZPRGq4Jx9+3N+rjL4nKogMPIbEZCVwsgZsQcHYLMh3LfDFVRA
	PoQ3mRBrPMAXj4qPFyl4ASXyuFmRTI7mzteP9BqNzSWXuugHR+zdUGrZ7iw==
X-Gm-Gg: ATEYQzw6cNK5wGQ/3woxgl///+2nq9WQANB3qxc5TLmaS+dZC+aPdIvCYIRyUdkKHZm
	V7w2hJkvTLX4wvmEYpycrJ+Q2XX+dRUL+MS1uLzVXNuy8em42CcCR4UiE/Gm4Yj6o6YoZxje8j/
	cIqWRbOhMUG8Qje6kF69R4JmZAESSyROyYTBCdCBWnVsy0YSFOk6BXSIQEOjDh9Um/BDAQrNJqL
	fGb2lSsvZsUN0/AOtqhEBkSjo7EreP90MxndlDU6BNgYTea6pjWPO3KIM5gUF1snWha4mtQDdkg
	cxUm9OjOoZQIoSifuIe8E190nBvrM9Eb8YT5ukaeAOKFKAtoOSsiwE72E2m/+d7kjlhBGh2qZCT
	Owp6/gnCTCrSnBbDF9A==
X-Received: by 2002:a05:600c:3e86:b0:483:47ae:7c00 with SMTP id 5b1f17b1804b1-483c9c02502mr102212585e9.20.1772305766773;
        Sat, 28 Feb 2026 11:09:26 -0800 (PST)
X-Received: by 2002:a05:600c:3e86:b0:483:47ae:7c00 with SMTP id 5b1f17b1804b1-483c9c02502mr102212275e9.20.1772305766268;
        Sat, 28 Feb 2026 11:09:26 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e3:8f00:866c:5eeb:fc46:7674])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb776dfsm166673485e9.1.2026.02.28.11.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 11:09:25 -0800 (PST)
Date: Sat, 28 Feb 2026 14:09:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v8] virtio_net: add page_pool support for buffer
 allocation
Message-ID: <20260228135423-mutt-send-email-mst@kernel.org>
References: <20260228134122.631580-1-vishs@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228134122.631580-1-vishs@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262204-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AEA041C7EE7
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 05:41:22AM -0800, Vishwanath Seshagiri wrote:
> @@ -2446,7 +2349,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>  
>  	offset = buf - page_address(page);
>  	if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
> -		put_page(page);
> +		page_pool_put_page(rq->page_pool, page, -1, true);
>  		skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
>  				     len, truesize);
>  	} else {

This part seems wrong to me: can this not be called from
xsk_append_merge_buffer?  Because that one seems to still allocate with
napi_alloc_frag.




-- 
MST


