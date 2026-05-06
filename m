Return-Path: <netdev+bounces-284932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MyHJk9k+2kuaQMAu9opvQ
	(envelope-from <netdev+bounces-284932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:54:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3CE4DDACB
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CB70301BEED
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F0F3F0AB7;
	Wed,  6 May 2026 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NscI5gwT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NubWE80K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0CB46AF0F
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778082577; cv=none; b=WFDkuoN3AhXD7RkTD0oPbhi2wz0cmvm/XHOzOs0ZbKuoinlNe6ZUNRPfLTb0pIxvxsg2TzgtTPXuiLpW19SYyx/1PNJtX+Q1Et/9a5rHXsqi9nQ494pVONsXRG7oxUVVHEiXrGYe2TmZlVccGycJ06nQs+L4S8SAm9/igyYLpRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778082577; c=relaxed/simple;
	bh=OFk6u9sPQNb/lVBSlnQi4dTa2C8rYPWBoQllv2zqLfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kmp5NpkewMi4/FLqk9QpJlwUoBDKMQUIDt9/MWL4JoqpBuYtVhux1AmlPlr1rZ/lg//9UOtOBVPOG8SE5a7lej9LjGgqWIAsvXT89ZEd7xsdug3uOfObT6GaQzM5mQZwhyyYNdtfk21wNiRVVrKJrPJYb4xJE+sXakkzKHsO6eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NscI5gwT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NubWE80K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778082573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQK7jK9fWfmI6EGpDkjX16iWpfsGamzwE3Vp7aLO0Yw=;
	b=NscI5gwTLPAh45sycHgBiydMFCZEdN6PdXHP0EbgIY1HfkJVpDe/9gA2uVwbTwtc9RTzkU
	VIaS8rer4pGTwZUlAFlPbE2WoLxsUAEUltf8VhfBuVVNrvpHp6eWpOGz51YJ2twqb7HuAn
	LawYDZtYeTdjR6zEDj5uXOURaxQgfyI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-I23jjczTNUyk0X05daPj4A-1; Wed, 06 May 2026 11:49:24 -0400
X-MC-Unique: I23jjczTNUyk0X05daPj4A-1
X-Mimecast-MFC-AGG-ID: I23jjczTNUyk0X05daPj4A_1778082563
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44b186b715aso3202790f8f.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 08:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778082563; x=1778687363; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AQK7jK9fWfmI6EGpDkjX16iWpfsGamzwE3Vp7aLO0Yw=;
        b=NubWE80KJ0iw2U4LMjZ+DGnRx7jzzADXYmR8af6aeWZJwyWH3tVs98ZSENOG+QLN2X
         spM1cw1o9xS7QqbhuMKsiW54txf0WT+J2gNd5JIE19aRGZY0ZIN+1TMS9Xxi2JzuD4TI
         8X9msN+J1boiYHWBYag4XilkPX6KRt4Cp9K96TiEBcjjkfnHoY0do19FiwdjgZCcJJBA
         fU2PFcLMo4K0hEpVEXeVRoANNfNlGpv/MwJ58iMr0JeYDsjSGEIDnP07VpJ4OfFeJKeG
         vvDSWZ9Wcrb/GqIGRV6ykHcTuJojzd+lporm4rFhO1IWDhJS6QPn4vuDmfz9IZYxiS14
         z72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778082563; x=1778687363;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQK7jK9fWfmI6EGpDkjX16iWpfsGamzwE3Vp7aLO0Yw=;
        b=hw+b1gPIgXF9TWJsKy5R4vLGdl6JXVpbpWeH6T5wfFOqfwOcJPbnR6plV5c2u2syTi
         rhh2EQg9S61KR7ARozp43yx30unX85R3pp3VjZXMMaHk/4vu8ulrTK2XwWBKmrw+Tslh
         QZ/+PbRjjxDti70/refgYqyAsA5uElpxKtuAxta9Ppj15KPYzcoHvxZcRu9DC4SitPY5
         D8xgP4B8sJhMNbbWYvT8Amdq3Ui7yU5VCd74db+JhRqw9KFhXmh3XKmYTY/hnc0gG5UZ
         Orizc3cC5FeauOhlYP8Fog8g1ZqV102BiNVLYAYnBYsvxuMYrRVUahC4A2HVHglg2n/X
         kxpg==
X-Forwarded-Encrypted: i=1; AFNElJ/7r3v8sfj3qRgmcab/aSFAaUgnMJwLAGc2jXHi05yedVUcLNod0KPyu1UYdA9s8V1FteEmguY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWYs0YyOn6X7N0zLtJhhxYmKu6wtfJUl6P6nleMFTgvtUGpCdR
	1a2gSlYQQnqrtmYkXivo1w9sOseffFRpylo0U9roeiGKIa3r6ki3dyglsS+LA3Ipk5atrSFtf//
	ng6gsO0cL5MWqMPmf9awhO9zOCW+KnYJrYTKc4K7BbtDRc57anUe3KSuOIA==
X-Gm-Gg: AeBDietksSwZNEuVpnOBe2gUu6zhyzF06HAGg+WrlR4/rwdiw9QixAJKsA8zzz0++JZ
	yf/+kCM4o2J6wzo0F5Ioe5dk+AG//Krtgleti6hbHi29AIwJHe9y0VboK3OVEeF99FatKy/KZHC
	EQrhqto6ZORN2jZPkYiehWPeCPqvy2VnLOr75eSLfc7/8l8nZUggpUscinDVrO+nbCBbLp34GO2
	mzxC1dR3ZSDBa1oSvXgGdCF4S2az3iVmJHpV6OoqIKlMqUfSoh4ebVMDDCPaCEvlsw2YAG6A9yo
	KxW0H9adfiQOtcnMJCrnRTJw9Zu+Pw0LEPU7+Pu2aOfqMNIygzxV/o66CZ2xzDSFdbgJzYEs6mb
	MGRE0/FgMx7yLUiTy5uz7A2fq8D85hpTG+06pDmqePBjQYtTlc60=
X-Received: by 2002:a05:600c:b8a:b0:48a:5333:811e with SMTP id 5b1f17b1804b1-48e51f2f91cmr68975615e9.15.1778082563107;
        Wed, 06 May 2026 08:49:23 -0700 (PDT)
X-Received: by 2002:a05:600c:b8a:b0:48a:5333:811e with SMTP id 5b1f17b1804b1-48e51f2f91cmr68975055e9.15.1778082562568;
        Wed, 06 May 2026 08:49:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e52f5d299sm31638085e9.0.2026.05.06.08.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:49:22 -0700 (PDT)
Date: Wed, 6 May 2026 11:49:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <20260506114213-mutt-send-email-mst@kernel.org>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <20260506111507-mutt-send-email-mst@kernel.org>
 <CANn89iKWhJp2N-60FC4JpX2Dw0sK8-vk2WrHkDOnkgC_c8nbHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKWhJp2N-60FC4JpX2Dw0sK8-vk2WrHkDOnkgC_c8nbHA@mail.gmail.com>
X-Rspamd-Queue-Id: 5E3CE4DDACB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284932-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,kernel.org,vger.kernel.org,gmail.com,sberdevices.ru,linux.alibaba.com,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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

On Wed, May 06, 2026 at 08:38:39AM -0700, Eric Dumazet wrote:
> On Wed, May 6, 2026 at 8:15 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
> > > There is always a discrepancy between skb->len and skb->truesize.
> > > You will not be able to announce a 1MB window, and accept one milliion
> > > skb of 1-byte each.
> >
> > We can if we copy.
> 
> You mean, ignore VIRTIO_VSOCK_SEQ_EOM?

No I mean saving it in a compact form.
If packet boundaries are the only concern, the overhead
needn't exceed 50% even for 1 byte messages. asn.1 ber, for
an over-engineered example?


