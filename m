Return-Path: <netdev+bounces-63866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F054282FC4F
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 23:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DA51C27C86
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 22:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F096750A8D;
	Tue, 16 Jan 2024 20:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ptfqeuv6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8533E250F2
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 20:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437970; cv=none; b=h/d902/McEkk0IAFA2TgoBKsop7n0CDkwKEWb+uK9ar3yO6LFvMnTRLSTZUpWtzjCKn7kHJARWKGjF26nqP/c+hIziv+tL6GewaSCUZt4kjMWgAXVHM0HuZFWLMdPrOwt3LVaDg/AzuN2bQszTchuxbIgZZXqmYuVtasEjlzcfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437970; c=relaxed/simple;
	bh=8R04pV7NenTmY//Xvc4y+OGOzxSJ8Fvcj0st4h/W1DQ=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=peJTzhKbP5xfixVfVW8tKRs4fh1Gl6bzHUI4wjQ2sq5jaTOCsGRIiFuBqFNR54s4816wG4G4I+ichyyAcPEOqOeI4ZaXO2ho9N56pglNGNkgmricwOSViG8v+QahQtF4Y/FRQVyOKr+jA+0rKsBX+ikj6VU6+mqxPMflUOC+8eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ptfqeuv6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705437968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bY992iAsJxysfraXAvAsx9+n1cX0TFNO2wFD5XkN5qw=;
	b=Ptfqeuv60pTOFBIy1QYtcpuzUzfS5SlDpd6QLiE65c04rzJ3rTTx3nPQ/FBqy57BiNUtHl
	F3aOotjMlIspRZbtmXzDsNVmNngr1FVS+dJwL3GQBRGhLz6rGU5VgDKFAghNbftXcM4Fpg
	JYOuujI4Xvg58f8Xx5DXDed5QJ/tC4U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-4wGsv1qYNNy2TiKHRpWEJw-1; Tue, 16 Jan 2024 15:46:06 -0500
X-MC-Unique: 4wGsv1qYNNy2TiKHRpWEJw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33768a5f55cso7417010f8f.1
        for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 12:46:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705437965; x=1706042765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bY992iAsJxysfraXAvAsx9+n1cX0TFNO2wFD5XkN5qw=;
        b=RtjuoybVbS2fPbO3ozlUJx7zrpBAXGsKNf58r3z9MRl7tKdzP+4x0hIhGpOGKoYFkM
         rJt1flslNmw/qoRXBqAYrGhXEEO0IvXaF2dUHmT2lwzjPjtzTlXAC43jWDf0E+wJRMU/
         OL8J0IiOctSrX2GIxdUUQZdzK47OdvP8JhHDAjl2FpblIfyPyYm26RWqY74VQyo15RY7
         gVRYBgOwmgM2zy+ZcRCX+d/hUYMKsz09YWLXyjPz9r1NCprUV6fsvqjPpDjgs24wE5WR
         yl5AryW06igrVUPjLTaXp3NiFGPcx/WtqhkJXbvmut9esIz2Q/uXF6+HvJHFX3l1dpkk
         gCGA==
X-Gm-Message-State: AOJu0Yw1/efeAz9Dk+9fL/ciEPhQ5rwXXPcpxMSBMr8kDaKvClgEd6jo
	qaFcv+ur9TwMpypuqLYqo45Xt2Iof/hfmlGxVIhauKkkj1O1qBuYOzihPunEjTb/wpKWD/f53wO
	+WFJqsdF5i2Pf1aRbgYGYvQpS
X-Received: by 2002:a05:6000:1e91:b0:336:7758:c6f0 with SMTP id dd17-20020a0560001e9100b003367758c6f0mr4037106wrb.70.1705437965514;
        Tue, 16 Jan 2024 12:46:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBEgVRcQZRbRtvwBMA0vTrZAaj3oTq/d687Or3SKsa4+VHQJTpU40PB+JsEyt6A8/iN0r5Ow==
X-Received: by 2002:a05:6000:1e91:b0:336:7758:c6f0 with SMTP id dd17-20020a0560001e9100b003367758c6f0mr4037099wrb.70.1705437965213;
        Tue, 16 Jan 2024 12:46:05 -0800 (PST)
Received: from redhat.com ([2.52.29.192])
        by smtp.gmail.com with ESMTPSA id g17-20020a056000119100b003365951cef9sm18433wrx.55.2024.01.16.12.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 12:46:04 -0800 (PST)
Date: Tue, 16 Jan 2024 15:46:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 00/17] virtio-net: support AF_XDP zero copy (3/3)
Message-ID: <20240116154405-mutt-send-email-mst@kernel.org>
References: <20240116094313.119939-1-xuanzhuo@linux.alibaba.com>
 <e19024b42c8f72e2b09c819ff1a4118f4b73da78.camel@redhat.com>
 <20240116070705.1cbfc042@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116070705.1cbfc042@kernel.org>

On Tue, Jan 16, 2024 at 07:07:05AM -0800, Jakub Kicinski wrote:
> On Tue, 16 Jan 2024 13:37:30 +0100 Paolo Abeni wrote:
> > For future submission it would be better if you split this series in
> > smaller chunks: the maximum size allowed is 15 patches.
> 
> Which does not mean you can split it up and post them all at the same
> time, FWIW.


Really it's just 17 I don't think it matters. Some patches could be
squashed easily but I think that would be artificial.


