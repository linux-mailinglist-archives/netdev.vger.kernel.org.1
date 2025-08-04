Return-Path: <netdev+bounces-211613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72302B1A6DA
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 17:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E26C4E197C
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 15:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFDA222586;
	Mon,  4 Aug 2025 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGyskVcT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E9D221D88
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754323075; cv=none; b=BdJeWVSMqTxsCDgLzU/qRyKkgLl7Ho9cTOHu6ns9qd+cAHXaJ1q+5cmq1b3MCiGiP5ygWKgyRUWP+x7SbfARezyqm649FWqBL8gcXGIjwvO8Pfj1qL+vPUX9ylpd49u99Z9/Q4R65xP7n4PmrDi3geGGzNRS6vlOgXR5iV2l9fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754323075; c=relaxed/simple;
	bh=pDVC7rFBszGbUr0AQQyyEXmDE6L9VQjbDNm8JyUEdWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKIvu1cscpHsVk/CirGz9wGAzCZNaIBkg/rsDnNY48ZdATdwq8eM7WjRV5OE60T2uGOC6a95OESP1auZfamhoz3uJZfMRzCpCaH4AS1KZ9oqDkfy1nzPbmP54h7ft1YCTIguWMgas/Gh86HjG9ej7dtnNdWEU78+m5OR+GPAYcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGyskVcT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754323072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T9mUgdLRs3w5PT298F337vFTebghvsVRguazdU4qoq0=;
	b=YGyskVcTwjsLHREB+QQt4AOZcGB+wlB2AW8wQdojvfL2Hucvdrhw8MC+lKGTwtb4J1UlD/
	urDWUMitm1HEotZRqqxehBFKTK15dacSA0CiMWvFCTBU+OQk91Vuquw1NbMkWCkbs45F+J
	nEKnPpmSkAWuOJr3zVEwIgrydIPpvsY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-oN0uZK0DPcG8_XyQwNMyng-1; Mon, 04 Aug 2025 11:57:51 -0400
X-MC-Unique: oN0uZK0DPcG8_XyQwNMyng-1
X-Mimecast-MFC-AGG-ID: oN0uZK0DPcG8_XyQwNMyng_1754323070
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-459d7da3647so8790755e9.0
        for <netdev@vger.kernel.org>; Mon, 04 Aug 2025 08:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754323070; x=1754927870;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9mUgdLRs3w5PT298F337vFTebghvsVRguazdU4qoq0=;
        b=YK0GBc6pR4n6fYTZ4AhUuP5Z1hBAkXb0kqF2NjkJJiaz7xh39mEFKNNIkNmTWVTDPJ
         2OuOyn1cEueffWG0YplXiEcEWl0v4/CW9ixKGN0UNi0pmZ37u8EOc4K+FDJ4utCckPys
         hpngEvKdErtCLVrs7RZi6wM8sSU7MbY1Oil5OAlEPIz5yABfxBvmcM1SwqISa13uvVVK
         6iA0Hj9HSEneMJHpYCzfbfuMJaaoTgfd3u8+xDXcIT6xRKDabfOdjN65ZNdxuJKkWbDn
         pz2qjZgJgeSoNEpIgVwkG/jT8xeVXqXZnw3YFBCfiETTrc7ontMezmkhpFwzkGtp+lA5
         SVPw==
X-Forwarded-Encrypted: i=1; AJvYcCWxLENWRcnOGcTlrUirD9WR+2tcInaVvXRdI69s7V2v2+n9kOQu/uPed3wxPTFm/BA0489bTcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKjr84zTjNiwC55nmxm5Ncsh4s1X7vdBTHF6WnJ/nWBWQvQSnL
	1E2u9sAoTfAWbvTpCwKUwTw507+P59fXcBAgvS2NVW6xjpWrSgyiA8j69OZxAbgCmLtijr3RFjO
	h/U6bPDZulOQxzhi53XHMqnq12D4KYf2IPeeWh6XvDvffU2T8jsWKObTsfA==
X-Gm-Gg: ASbGnct8AzJRa3y/x4XXiFCyLDR+1m2xGNrfp/PQ//LF6Ragab/LsXqpgXjwB6sSLBI
	WF7RR7MQLuJOQaM2wrcQMPPfPkRKDMhBTtIoKIviYy6MFv2Ua8EGyoqV/W3HQJylfAAA/EY8FMN
	0yRuLubOZF2NfzEuG8YAcZbY25Uu6wEPgUqYeWjNhpOR93/x6Pll3Q9jXkGSrBcSGGGwk7EvLzv
	Hls72IFKUe3moFr1gYz71kbOv1Oivjs3A72CwkljFWq4LtXiPo7P0WWNb5mh3UOfQfGaWDhBIHo
	dJXk92RzQojcwD10pbRTYdt7AapLi8Id
X-Received: by 2002:a05:600c:19d4:b0:458:c059:7d86 with SMTP id 5b1f17b1804b1-458c0597ec7mr60423635e9.10.1754323069731;
        Mon, 04 Aug 2025 08:57:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvZfiMjphP3x3l4zUqhsolAK9PHooH9Tsp0BlG/3TnfFNZ2tCNNeobV4uf7R2ru3mb+8//yA==
X-Received: by 2002:a05:600c:19d4:b0:458:c059:7d86 with SMTP id 5b1f17b1804b1-458c0597ec7mr60423395e9.10.1754323069333;
        Mon, 04 Aug 2025 08:57:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e054036bsm6166517f8f.31.2025.08.04.08.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:57:48 -0700 (PDT)
Date: Mon, 4 Aug 2025 11:57:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgarzare@redhat.com, will@kernel.org,
	JAEHOON KIM <jhkim@linux.ibm.com>, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] vhost: initialize vq->nheads properly
Message-ID: <20250804115728-mutt-send-email-mst@kernel.org>
References: <20250729073916.80647-1-jasowang@redhat.com>
 <CACGkMEuNx_7Q_Jq+xcE83fwbFa2uVZkrqr0Nx=1pxcZuFkO91w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuNx_7Q_Jq+xcE83fwbFa2uVZkrqr0Nx=1pxcZuFkO91w@mail.gmail.com>

On Mon, Aug 04, 2025 at 05:05:57PM +0800, Jason Wang wrote:
> Hi Michael:
> 
> On Tue, Jul 29, 2025 at 3:39 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > Commit 7918bb2d19c9 ("vhost: basic in order support") introduces
> > vq->nheads to store the number of batched used buffers per used elem
> > but it forgets to initialize the vq->nheads to NULL in
> > vhost_dev_init() this will cause kfree() that would try to free it
> > without be allocated if SET_OWNER is not called.
> >
> > Reported-by: JAEHOON KIM <jhkim@linux.ibm.com>
> > Reported-by: Breno Leitao <leitao@debian.org>
> > Fixes: 7918bb2d19c9 ("vhost: basic in order support")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> I didn't see this in your pull request.
> 
> Thanks

in next now. Will be in the next pull, thanks!

-- 
MST


