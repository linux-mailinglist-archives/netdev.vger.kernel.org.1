Return-Path: <netdev+bounces-172523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0F6A5522C
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 18:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB4F188DD61
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 17:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B12D25B670;
	Thu,  6 Mar 2025 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="OBFBi61X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4664B25A651
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280408; cv=none; b=dhjhUC2qDZwXafQOJSL6pWA0D6raBnUF99rYnI3WZePwGElOjFcTlWmDUoM8pb/3hk9TbKhRwvvvNm5kP0pSFYDhOSt/wKvT87qANMWz5+knn2S9C6UXCiwf0UyfIPXWKQZCGE1AFb4p4BgqL06EtCWx6W5mwjFjhyLY31+y9Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280408; c=relaxed/simple;
	bh=6EHelBLacWleQv44yGckAy3mIbBU9S9fc+Yecr7hfhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEF/U4aS86u0Wxt6aTMO23eWTECy8hvo1pHMNKFUmFqh97kjOmf/qUg5V5bmN1Na9wyi+T/XTtRRLFgU1FqYf1DnSqVvU4aZEtExCgEcDOuRUtWAZC+TyQdqu5XNGt/Kp8MU9Tgz/VuLnJWVJ7hKtffZFpsW25BPPzFXRMobPNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=OBFBi61X; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so1462742a91.3
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 09:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741280406; x=1741885206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQqTHFjNB8mAC6MabLFJci/UUFVOIM/RIyf/FHXgNd8=;
        b=OBFBi61Xhv2xkNoU7z7xkdqvHEZIWTSQ5PJQ2Qsj4ms+zsdxD/ynUw/jToc5bk4IMN
         h9y4ZMSUPumTLvnf0cJI78LcN0t8NSPHE7avP5fTZ4icmIVLT1BcQaffZwrpCiL5L3Ma
         JENUqnbSk7BS5gvewlb0OMxyhcz1HkAp0cFAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741280406; x=1741885206;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQqTHFjNB8mAC6MabLFJci/UUFVOIM/RIyf/FHXgNd8=;
        b=Jjei3TlI3EtmpxcGHFw5t3oxsZZLuHUHjBOnR13iB/ogI8GPMG0mtqxyscKFx1G4fS
         8tWDP14QXy7WFgqTifHyAgzV9+G7Ld+lCZlkOxQF4f3JJ5du632ledaaR2j2YxTKuAAq
         JrKn18qhQ9td+4q72sAkc7fGZLrVhwXzzZ2chJL5fnaf5E5hoKqM1P+D7V8iMbOScMRF
         qAxLzYUCQ/Gu6enp6Lj3IhE9AylSDzzSEs3fniNmGWe4cNkGqkYfAM5pbFBt5b0prIv4
         az1ZiELINiZAToYY4XV9uI37gr1w7njMGLwD4aAEmaVcHYxr2yrppyWqpqArbDCIPKsm
         WJvw==
X-Gm-Message-State: AOJu0Yy9vEadPvilKAoYhjmPLieY5axATUKU0+aKNkzESEWLfcdTIjsn
	lzOaR32Ev1+JZtGpb+OlNMx4cweNAAamdbPoNGmvKjYesb6qlutZtkrCHg4gAME=
X-Gm-Gg: ASbGncv84g0vAR82WVo2jxUvpqyNsZIRzPoUnuavmsIJyOur26WOs807jRrle1bwR5e
	xLpaRdrwpfbmW96YXVfWZ3yXxXcBqswxcLWT5Bh1VGRMueZHytHL1Sp8fWDXf65cTFwW69FyofX
	ssCAa2AEO4P+6rVIBKPhcC1Y7OKt2B/oQEXUtZVZsjlt94fTElFWZcqYdiWmbZ0rqhVLb1c5wHZ
	/JsVjdN5YJdF7b+nklZi6JV8mRg9Ugj8lXawzQqxn2jUj7guqoNqUBON17az8m5KUFiwDnJCoEp
	a42J26IJsYACe1eYKnatoSLQomNmy7IHtuUl2Ye+tz9c0MHuv/o40WMMqZZwxtawQluS+HeidXJ
	rtWJ3/jLnaUs=
X-Google-Smtp-Source: AGHT+IGMGInMYoKZVtUaLSTFn7K3E/qcMiV7/r81nffI3pTWDuYLKqaB5kMCtQ4fVSMgy49C9wt38w==
X-Received: by 2002:a17:90b:5688:b0:2ee:5bc9:75c3 with SMTP id 98e67ed59e1d1-2ff49717481mr11337807a91.5.1741280406235;
        Thu, 06 Mar 2025 09:00:06 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff5f6a64ecsm1685585a91.0.2025.03.06.09.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 09:00:05 -0800 (PST)
Date: Thu, 6 Mar 2025 09:00:02 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, mst@redhat.com, leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
Message-ID: <Z8nUksjJyKEbP68-@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, mst@redhat.com,
	leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250227185017.206785-1-jdamato@fastly.com>
 <20250227185017.206785-4-jdamato@fastly.com>
 <20250228182759.74de5bec@kernel.org>
 <Z8Xc0muOV8jtHBkX@LQ3V64L9R2>
 <Z8XgGrToAD7Bak-I@LQ3V64L9R2>
 <Z8X15hxz8t-vXpPU@LQ3V64L9R2>
 <20250303160355.5f8d82d8@kernel.org>
 <Z8j9i-bW3P-GOpbw@LQ3V64L9R2>
 <20250305182118.3d885f0d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305182118.3d885f0d@kernel.org>

On Wed, Mar 05, 2025 at 06:21:18PM -0800, Jakub Kicinski wrote:
> On Wed, 5 Mar 2025 17:42:35 -0800 Joe Damato wrote:
> > Two spots that come to mind are:
> >  - in virtnet_probe where all the other netdev ops are plumbed
> >    through, or
> >  - above virtnet_disable_queue_pair which I assume a future queue
> >    API implementor would need to call for ndo_queue_stop
> 
> I'd put it next to some call which will have to be inspected.
> Normally we change napi_disable() to napi_disable_locked()
> for drivers using the instance lock, so maybe on the napi_disable()
> line in the refill? 

Sure, that seems reasonable to me.

Does this comment seem reasonable? I tried to distill what you said
in your previous message (thanks for the guidance, btw):

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d6c8fe670005..fe5f6313d422 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2883,6 +2883,18 @@ static void refill_work(struct work_struct *work)
        for (i = 0; i < vi->curr_queue_pairs; i++) {
                struct receive_queue *rq = &vi->rq[i];

+               /*
+                * When queue API support is added in the future and the call
+                * below becomes napi_disable_locked, this driver will need to
+                * be refactored.
+                *
+                * One possible solution would be to:
+                *   - cancel refill_work with cancel_delayed_work (note: non-sync)
+                *   - cancel refill_work with cancel_delayed_work_sync in
+                *     virtnet_remove after the netdev is unregistered
+                *   - wrap all of the work in a lock (perhaps vi->refill_lock?)
+                *   - check netif_running() and return early to avoid a race
+                */

