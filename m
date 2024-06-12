Return-Path: <netdev+bounces-103015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BA6905F65
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 01:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52523B216BC
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 23:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B1812D20F;
	Wed, 12 Jun 2024 23:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7RTCU+l"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9BF41A84
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 23:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718235893; cv=none; b=lhU/wLGQGfv4Cs0KRnT41cysMTVTanOftW+PBtSpk/jr/TC2UwbkpTta4pjiqy/8fPyM577tlCJ36qUcA6pi7Sp2Bk2ORSVWLaILtt7ZtfpicSw92AiMn+2SvY3BpsgggdXPYrFR3KyAdH0DuqWbSscVbwit1+Fv+uMfBe3jxo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718235893; c=relaxed/simple;
	bh=LQb3o2/CP5JSK8KAyQba5WkdaHhdXZYvdSrm+JnIPLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7EORbgU8wFoEAIZdWutEwZ0d+9YBaQ4R5I6TnGYpVYErgqDSqAmy2WdVjxVJ6UwZCGK+G2fhWIiD6dVrxv/zqe7p2rB+rzCk9qDihmcY8EgxApk+uJ7BuCSV6fQ1JqBdu8DjJfv3VSV+G9biybKjWC6OLWuTR99TN2zLQWTBFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e7RTCU+l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718235891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1VosMQ3bFESuAWLh6SDqxXuOvd8Mst+9B84qG9NSYg=;
	b=e7RTCU+lGP3l388/1GgEY+J9ar0WROLfo2BnbA7m8JXGL3PyQK4GyTWv60XfSxKwbRnder
	iebJEw8c3Cck8/7gd59M07kolMTV0bdR8DZ/9R13bY63nw5P7hEByP99usMfpG+RgHiC10
	D83rgffA+aKKpQVCB5LBHPi/Ua1Oncc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-5C76sRpXOHyyAcm4cXViMg-1; Wed, 12 Jun 2024 19:44:49 -0400
X-MC-Unique: 5C76sRpXOHyyAcm4cXViMg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35f1cfa0be9so361460f8f.2
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 16:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718235888; x=1718840688;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1VosMQ3bFESuAWLh6SDqxXuOvd8Mst+9B84qG9NSYg=;
        b=N22y5o0gzY5f+4m0BddBCK3nHWeDSKQKM9lOOfSMR20g8yBYHaWLoK/dqoFnZ5aVQ6
         5DzuMrIfySU9rjXZtXhFXyN/yU/mFl4uKinY55loZIwFbGbj6uYlHi8wldDcXlJony0e
         Pgxf0M5DTW5PUtq7Uf7teghik8vhLfWEGEeKr9b8jBNtTkWNaylMz7EdKXKq+i+BY+LJ
         JSoBggD9wKS99rKt/iARz67ug9y57IacV8qIobDnct0ZBvqNHLvpIIRudXh9yvFvuVSK
         eSdpdQgHQf0BZml3FNfEIruAzbxsO/zxuxZ460O2OxcqbQBmf06xEbe/uR/KtLKuvdaP
         SHzw==
X-Forwarded-Encrypted: i=1; AJvYcCWyHXmcr3oirLcnbAzA77tqzCFNlm7gmBiagndi0TIef+qtZx6Wj19enEGoFdtVLKWp1Sl8yDymyUJO1wMVCZbEa0zIEO/c
X-Gm-Message-State: AOJu0YwNfvnTbxTNWx8ii9r6fuphkuKHiQSgj4RSss7snnVLxouJ2PLK
	c6x5xi+1cXiqj7L/uCuTbCi91lhTW+mmLxQqSw4F2Fnj720UB4CIJ5yPYH1yXN5T7BxleBiGMQ2
	2dmK8k8N0umuMMLbpH2Ufysyl6VDOdkYYqLw/WJObgXP+0+R1Pub65g==
X-Received: by 2002:a05:6000:2c4:b0:35f:1f3c:b632 with SMTP id ffacd0b85a97d-35fdf779b4dmr3084390f8f.12.1718235888517;
        Wed, 12 Jun 2024 16:44:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzTM0DuELFcd6K5W5zmF+NgyZEAXmKiPtBN7iRmrfadHH+oMGDf2fEtoNYfG4eSc3SnCV0pw==
X-Received: by 2002:a05:6000:2c4:b0:35f:1f3c:b632 with SMTP id ffacd0b85a97d-35fdf779b4dmr3084379f8f.12.1718235888065;
        Wed, 12 Jun 2024 16:44:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:94c5:b48b:41a4:81c0:f1c8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c8c2sm119131f8f.31.2024.06.12.16.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 16:44:47 -0700 (PDT)
Date: Wed, 12 Jun 2024 19:44:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 11/15] virtio_net: xsk: tx: support xmit xsk
 buffer
Message-ID: <20240612194425-mutt-send-email-mst@kernel.org>
References: <20240611114147.31320-1-xuanzhuo@linux.alibaba.com>
 <20240611114147.31320-12-xuanzhuo@linux.alibaba.com>
 <20240612162505.2fa3e645@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612162505.2fa3e645@kernel.org>

On Wed, Jun 12, 2024 at 04:25:05PM -0700, Jakub Kicinski wrote:
> On Tue, 11 Jun 2024 19:41:43 +0800 Xuan Zhuo wrote:
> > @@ -534,10 +534,13 @@ enum virtnet_xmit_type {
> >  	VIRTNET_XMIT_TYPE_SKB,
> >  	VIRTNET_XMIT_TYPE_XDP,
> >  	VIRTNET_XMIT_TYPE_DMA,
> > +	VIRTNET_XMIT_TYPE_XSK,
> 
> Again, would be great to avoid the transient warning (if it can be done
> cleanly):
> 
> drivers/net/virtio_net.c:5806:9: warning: enumeration value ‘VIRTNET_XMIT_TYPE_XSK’ not handled in switch [-Wswitch]
>  5806 |         switch (virtnet_xmit_ptr_strip(&buf)) {
>       |         ^~~~~~


yea just squashing is usually enough.

-- 
MST


