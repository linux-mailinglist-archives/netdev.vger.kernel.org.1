Return-Path: <netdev+bounces-127322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5332D974FB5
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 12:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E86283920
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37BD153820;
	Wed, 11 Sep 2024 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4trbwpW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0AC2F30
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050663; cv=none; b=I3kHHwQn4/LChTc7JywZDUtAXjX56Y1DSL9LqgZMifOmRM1uVnhLK+CXf2Fux16LIsyNWPRzIv+1D6jAYS/QmQdviBEYInZxEyH3NrurmfA+c6yeuojzLPncePfLhQuOf0+Dhf4OXFFqxZ0U8Ngh4nxDYlGNDzy+f5RR1Ady/30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050663; c=relaxed/simple;
	bh=dyYYWaUkW7Qj38yfF+lT8+G1k5MTqJErF4gqgbsWBm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9pzGwpzoOQ1Ths4SBQhDx2Vj1ZmK/Wg+9CuJKNhASAX7i4cYHug6BwS3vI+5tw68nL/zpYb15Gpy87GlXzUSjULtG3ivtQbYGohaHuo+I9ZKQ95HC6SKvpO4Nha74Arza6FxEfyMF087O2EcLQzGuU6cJv5d3v5ndS7EMaH0+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D4trbwpW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726050661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=caUs0yOnF97biFjcb48s5HolFUOhjWq58ujl243U++E=;
	b=D4trbwpWxwzRmgyQPtSXjrAHzKxwE60G8FKztoWBjL9R7WER4PB9OG28Ys8nAisHgGWAGK
	vxP8X+Ba9mPHVT6he8Vcoi+HPMi1xzkATk0VyqZG+PjFKw7NlicuU76M6XXYX8D5rx6xg1
	z7VJ1IJxBes2aZBx0gjD+gv9OBDXYSY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-Pqg-7JzaOfWfyYVwgy5OlA-1; Wed, 11 Sep 2024 06:31:00 -0400
X-MC-Unique: Pqg-7JzaOfWfyYVwgy5OlA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374c294d841so4815239f8f.1
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 03:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726050658; x=1726655458;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=caUs0yOnF97biFjcb48s5HolFUOhjWq58ujl243U++E=;
        b=P0Qcyscf9KSmTEgK4/qG6od8e/V0T/rMKhB40FP/BB/R4guA/8fbXdI5ad5Zd+puMn
         Zdo0SVN4AtQyIuENhxBmvz/Ntq8FUY6G4DvdsQKzOUM7aErh5pxaxcy6ZR/b2wj5GMkl
         EnLs4N86I7yKhZWxWQ80RUjwlGO6mkeiPYUJ2ig4aP//dVDF60ftUeKKGGGUAoFE+q6L
         4bBeQtgGRd4naZcybIQRgOqDJ51CFaxEczxmSfOXBGqlK0BHRIz2zgzvBJ1sdBQawv6h
         xVhoGsTQA2AmmTDKCpFc2SsQ6fu3GK1sfOmSScjXnbjvHS26mQ17r/BtcmECIkFh37mS
         PCDA==
X-Forwarded-Encrypted: i=1; AJvYcCU25NmagQmh32Tu8iHJTRWrtqGkCvr/WE6SdG/QlCECppu5IiVTqGJkki0i9IChCzJ+8HELCF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDDio0cSRlkfX1T/COTHOrpAn2DRBwG1tE9ZhWBaDR7KzQKyOV
	+alMEjPKCumvj27jaqZgI5otEFpR/hyr7EWPQKEBcm1EnnzMYdaRNCyCOEAPgo+8AkUO6QSXreq
	+eZw5iM4rwlSjYkOwVQOVnbSxytnhFx8meYPpBIIOAQ108hmoSXacDeLI2RNtKg==
X-Received: by 2002:adf:ea0e:0:b0:374:c05f:2313 with SMTP id ffacd0b85a97d-3789243fa0bmr11907019f8f.45.1726050658426;
        Wed, 11 Sep 2024 03:30:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtMggxMO/7B9PE3GYbAP3s7BqOmc7zlfd6FQ4MDGJx7VJlGmCoycy6iOpEGQqoU+TO08lKlg==
X-Received: by 2002:adf:ea0e:0:b0:374:c05f:2313 with SMTP id ffacd0b85a97d-3789243fa0bmr11906984f8f.45.1726050657807;
        Wed, 11 Sep 2024 03:30:57 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:a3d1:80b4:b3a2:70bf:9d18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ced201sm593139666b.168.2024.09.11.03.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:30:57 -0700 (PDT)
Date: Wed, 11 Sep 2024 06:30:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 02/13] virtio_ring: split: harden dma unmap for
 indirect
Message-ID: <20240911063024-mutt-send-email-mst@kernel.org>
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
 <20240820073330.9161-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEuN6mFv2NjkA-NFBE2NCt0F1EW5Gk=X0dC4hz45Ns+jhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuN6mFv2NjkA-NFBE2NCt0F1EW5Gk=X0dC4hz45Ns+jhw@mail.gmail.com>

On Wed, Sep 11, 2024 at 11:46:30AM +0800, Jason Wang wrote:
> On Tue, Aug 20, 2024 at 3:33 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > 1. this commit hardens dma unmap for indirect
> 
> I think we need to explain why we need such hardening.


yes pls be more specific. Recording same state in two
places is just a source of bugs, not hardening.


