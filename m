Return-Path: <netdev+bounces-171331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E898A4C8C0
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0B8188ED84
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D442139BF;
	Mon,  3 Mar 2025 16:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KgprLqKY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134A624EF86
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020375; cv=none; b=KZJrCt13I0rfD3eCibcVKOn+lV7i072/VjlweHniIHpbR1zaTaDHkIuPbDWCN8YST3JVcRMbv5ChqmfwMMkdFpPSk9/u4FRvfAtEXF37Jf6LpOyvuicaWnP/4I7pD7hk/M+o1R2xBXSHFQrc7j7WYzmdNRGwfpaVvOBkAPrsEuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020375; c=relaxed/simple;
	bh=4a3Js/QSUPm1CO0AmuaBEQTQLE/ky9K8nLFdDZq450M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHHflSydyn/qcgVEZMRE9f9XqWyHpuyt95s9xK8OqEe/qZnnWMdRTuwGC65KF7acazZjnvblDZ6QklTIboeukT8rCRYTguv07RpVQVwuRTRLgS6VNoKg6yu5PuW7wANU2YxJuzD8PYaBLaQe6J5+hu3IXXpDS7hk14DUl9vp77A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KgprLqKY; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e889e77249so39085766d6.1
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 08:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741020373; x=1741625173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8X1eRghCbAiXOwCl3h9CNpVTl3lfWmjRfbNCLQzdf/o=;
        b=KgprLqKYlXhvgf4V5eV/307ol1uKTjYW+EtCurudN/EIOaSmzCSHo1oPiO4sN5KWdb
         nIsk5aUpqAEXIXuPIssXjYDYhvm02MKC7ptOq/XlFQoBAFQBfUq+CNphgpOQhccEoiGU
         bdCob//qV/gdBrjmaOAXMYfRvw9PD92ya2Z54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020373; x=1741625173;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8X1eRghCbAiXOwCl3h9CNpVTl3lfWmjRfbNCLQzdf/o=;
        b=sldUOpXiuc8+P2QvUckmmo22+px6tLnDlEDrHTmThiHhRQYPMCdNXDAGfhODSTi1zs
         ZiZ//A8uJkcRmh4GSfW8ctQqakNJr2nXwg2eXICw2iFRUUvwoDkRIUbOYHDkYg2+/45x
         u8exh2SbsImerfn8JBk59ECkRhq3Q5w+WAZqXyVkxGyOfe3PgmqJ6Z84rfvbhZju27Yr
         XfNw+7BVMsbAgViXJWhnCaCVTUXbsEp0x1nbe5VAXRpzxsG8G0QGpkU0Amale8IXz5NQ
         RgOIzzZL8tWjtbO02bdQAF9q1eoa5pLwWt0tDMHKwJcEKEQ0j1brLBRkABj9kUsrWU25
         BLhQ==
X-Gm-Message-State: AOJu0Yy1Kvqrpddgyo7B1QDx9T0tdNqTalyfnS3dWOMqXHJtK9vTjvqK
	CWStXWtXFNijs39US/HR9MI0Wj+d3MRHpquG29xmqdYY8eWyi9q2dqHg0Xsr4Oo=
X-Gm-Gg: ASbGncsW+CF/TEZWlwIdvEZUZ6ERifIpQZU/aRLd4dF7S3cAGD7bP/ESuWivHQZ7oTu
	oz7saDwrAHp7BzvI5UQa9ealkpA04y2vesJ2AyFu51pH88MixMWxTgJ7A3aMqMl/UbZcnXE+Oo2
	va3jRnTWF1gvsAMOwsHM0mFrBtUqSrCPizvaMSE84GenA4BWWEBb9zzeQ9QJTqPpNFbNFrslw46
	EUTxkkrQ05DT5ok2/BfrkYXVsPhaTyNsDXcfi6q/AICCTaZyP7CG24wOkFDQeYz/ogz/gxdMQ8b
	a+72pajkuNa1ogLWW2Uo6NG2lUlqhO+wbWTWQ2U3XND+DImJYmqVKsWGKpIcE9SEjF/KLRxoU8G
	cUaSvI78=
X-Google-Smtp-Source: AGHT+IHkzyITDdW3vLOmKpMop+SV7m+wXZtHTB86svSFry2DpAQLcSAU+s3Ys44u2tdDtQuD6QzsPg==
X-Received: by 2002:ad4:5de6:0:b0:6cb:c54c:b782 with SMTP id 6a1803df08f44-6e8a0d84e3dmr230430596d6.32.1741020372960;
        Mon, 03 Mar 2025 08:46:12 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897653667sm54834896d6.32.2025.03.03.08.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:46:12 -0800 (PST)
Date: Mon, 3 Mar 2025 11:46:10 -0500
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
Message-ID: <Z8Xc0muOV8jtHBkX@LQ3V64L9R2>
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228182759.74de5bec@kernel.org>

On Fri, Feb 28, 2025 at 06:27:59PM -0800, Jakub Kicinski wrote:
> On Thu, 27 Feb 2025 18:50:13 +0000 Joe Damato wrote:
> > @@ -2870,9 +2883,15 @@ static void refill_work(struct work_struct *work)
> >  	for (i = 0; i < vi->curr_queue_pairs; i++) {
> >  		struct receive_queue *rq = &vi->rq[i];
> >  
> > +		rtnl_lock();
> >  		virtnet_napi_disable(rq);
> > +		rtnl_unlock();
> > +
> >  		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
> > +
> > +		rtnl_lock();
> >  		virtnet_napi_enable(rq);
> > +		rtnl_unlock();
> 
> Looks to me like refill_work is cancelled _sync while holding rtnl_lock
> from the close path. I think this could deadlock?

Good catch, thank you!

It looks like this is also the case in the failure path on
virtnet_open.

Jason: do you have any suggestions?

It looks like in both open and close disable_delayed_refill is
called first, before the cancel_delayed_work_sync.

Would something like this solve the problem?

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 76dcd65ec0f2..457115300f05 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2880,6 +2880,13 @@ static void refill_work(struct work_struct *work)
        bool still_empty;
        int i;

+       spin_lock(&vi->refill_lock);
+       if (!vi->refill_enabled) {
+               spin_unlock(&vi->refill_lock);
+               return;
+       }
+       spin_unlock(&vi->refill_lock);
+
        for (i = 0; i < vi->curr_queue_pairs; i++) {
                struct receive_queue *rq = &vi->rq[i];


