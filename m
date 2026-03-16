Return-Path: <netdev+bounces-268089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD0YAn7Vt2kwWAEAu9opvQ
	(envelope-from <netdev+bounces-268089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:03:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA522979E7
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9270F3019FFA
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 09:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3BE38D006;
	Mon, 16 Mar 2026 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhkGTxms";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4Sev15X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80DB385534
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654986; cv=none; b=Ti0YB4r9CFUvvMntogAgcXsBOpyWcY2Gn4djxX0MqYo+mrg83ba/9IKoY2AvxSIDYsjdTO0uoHI2BUbFPhLDGDu8vNo92PTtKeAjX88GJatXhcKsjccKSzcSKCBFwLFWbwuGgu5NNM/CnmcHQO6FOINb5PwHKbElODPtdEb1Hl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654986; c=relaxed/simple;
	bh=QTOs2akWd78BcczwkDDLLxY3jOM4b2hdWX+lrEFzrTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLbesn+HAD1lW6rddiwAgzeZwgFzF3Ca3X/R7U6UsDrYpS4YLbnB4SeschME3k8o0onhCpuawXqLlesoDfs/BPloNh2cbS3JH2+n3xa+ztyPkWUzt9HhfYXODvqixrJZodeF6HsDPg+DO35Fg+Y79CPL6j3pRjlASZBknLOGQ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fhkGTxms; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P4Sev15X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773654984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QAVRmEgA2BSDX5bYHZyyKUZsGjR3EOuD2wkxuTEaH2I=;
	b=fhkGTxmsDhqbH9W5rSRxG6u8PeOFrWBGsYIaHnbkuOD29sVz5AP0/o41/rJlqqba0g4Nzw
	Ww2aRRWK5bEbm1uVr2s8AdHOnR8axCV0eas1biExApJVtJrXicaza+q+0ikOyTM+MuACDt
	DPXZL3s23L7VTHKrWl6a+r/t0pnjwd0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127--8MYJ0sXPkOnk1LfSc6l5Q-1; Mon, 16 Mar 2026 05:56:22 -0400
X-MC-Unique: -8MYJ0sXPkOnk1LfSc6l5Q-1
X-Mimecast-MFC-AGG-ID: -8MYJ0sXPkOnk1LfSc6l5Q_1773654981
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48535f4d5e1so42929305e9.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 02:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773654981; x=1774259781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QAVRmEgA2BSDX5bYHZyyKUZsGjR3EOuD2wkxuTEaH2I=;
        b=P4Sev15XDXbVJXGgYBunRvq+7Z/cAVOxb8dM0nb5NTpxbgo+mUynYYefhGn1wdtqmx
         r2LgsGMOmgU9h8DjYtUt2g3NdORsOvleN5ZXEEZpRWt/6qghxow4A5BtSbG89QROeuBI
         64YQkvwwDQ1SlWdGeKVax7IGDf6H98QJjIL/I+CVuJOFF5HyEyDzooNTGeLTEoBUlhNF
         /wfmHX1Anbm8yUwUQc/4il+HjtfVvek1MUm5IyJgpiqnOjmaGJJbrcsd12B721CEo0I2
         ObR//G9wo2EcwfFDNlRGPePe3SGuXdjfFyLT3dGaALFFT1OjzK747J/kJxE7RDGU752s
         V2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773654981; x=1774259781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAVRmEgA2BSDX5bYHZyyKUZsGjR3EOuD2wkxuTEaH2I=;
        b=C4ssYkle8Y/qz7aMWl2o+MlkcY4hp2lMtwciRYOoOKCNipogR01ZWKhY04iHsUR8ZS
         ZTXdYI1rOeWDBVgdOeruVIkvj8W6g9w7YANW7kU2eNXtJVU8jQp/6mlsIwQaSoN5z5qv
         HvIUs3bNr/u3IRgJn+LTJYZT1e8PDzYH3NgV21k7UjJtBypN/wzYMKkWusgBb9WWRPlj
         ipE/w5dtys6CBifhVsuSJuSQV1FTdAEl27383nD2l0bC1hsiRaQWfpdGqcNdbkCYOPyB
         unDp6zbL9PF/5QrkfaVm2BPXpHa4cl4fLmBr+W7suoo3vXEmMaTtkrBckODRE/N4cst6
         oHVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQk0kvaRh/T2PoZkHqjyn7m40J/xeQbNmV+mNPE7QVk9jqZXo9jStKtHvbapRxt/sZtlFp51o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7SZhZwlzGZC+vZJIBtNYGaito0Ei12RNPn/bppwe7oOy6xo+1
	VkSWHl6ItL98i0h5OmOlMRtmy6pqhuQzEmb3gtJSmw/3yRdwogVKpZJAPBAGSzJ2sUldZ0/Vft4
	KnS0xG7SqvDq/PTCIlTaK3X2SlmNiY9isfBgxfv4ZkX/qv+xcbRAyCXDB2A==
X-Gm-Gg: ATEYQzxAKmhESAjWpruSL5oMZBUSrR74qzMkNwfXUQwRJxqzcTaN4r5qcGXrmp/edPt
	/eGTwF4d2iJeD3DzfiCDrROmg2YaqYZw2Hkn5awwuJYzrEnhFU0RvMdUuDJQDsibDwZ5tXMhCV4
	b7hhxRjpu9IyHNjZrfPfGOuJmTXuNofr6JrvRa/hUqNSgnulvOoXDoGiTdP5fnFgWNfXGOkai22
	Om9RuDdwUUehhe+44vB2QeU7aEU58+YWjFKOBQDqun9qkO9pFGqDwdopNJcgylTxLi+53T062GC
	yOW4I20nKmEpLpxyi6hg+X5RxeN0SR//43DTLVh/AaYMx4pdFpBz2rDsCPvAhNtcFLf99t1BLqc
	x352hEK6+edS9FZZXh431cc1vm2dihBFcOiU/uY6N48YzzQ==
X-Received: by 2002:a05:600c:4586:b0:485:363b:fafe with SMTP id 5b1f17b1804b1-485566c6a15mr212112905e9.1.1773654981236;
        Mon, 16 Mar 2026 02:56:21 -0700 (PDT)
X-Received: by 2002:a05:600c:4586:b0:485:363b:fafe with SMTP id 5b1f17b1804b1-485566c6a15mr212112255e9.1.1773654980698;
        Mon, 16 Mar 2026 02:56:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f708sm889800085e9.11.2026.03.16.02.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:56:20 -0700 (PDT)
Date: Mon, 16 Mar 2026 05:56:16 -0400
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
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for
 buffer allocation
Message-ID: <20260316054232-mutt-send-email-mst@kernel.org>
References: <20260310183107.2822016-1-vishs@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310183107.2822016-1-vishs@meta.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268089-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AA522979E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 10, 2026 at 11:31:04AM -0700, Vishwanath Seshagiri wrote:
> @@ -5857,7 +5863,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
>  	/* In big_packets mode, xdp cannot work, so there is no need to
>  	 * initialize xsk of rq.
>  	 */
> -	if (vi->big_packets && !vi->mergeable_rx_bufs)
> +	if (!vi->rq[qid].page_pool)
>  		return -ENOENT;
>  
>  	if (qid >= vi->curr_queue_pairs)



It seems that a qid that exceeds curr_queue_pairs would previously get
-EINVAL and now gets -ENOENT. Maybe reorder the checks:

        if (qid >= vi->curr_queue_pairs)
                return -EINVAL;

        /* In big_packets mode, xdp cannot work, so there is no need to
         * initialize xsk of rq.
         */ 
       if (!vi->rq[qid].page_pool)
               return -ENOENT;


Alternatively I think we can completely drop this chunk: we already seem
to init page_pull at all times except for big packets mode, so the
current code is fine I think.


-- 
MST


