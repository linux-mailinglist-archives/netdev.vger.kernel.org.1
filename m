Return-Path: <netdev+bounces-122463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5FD96169F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 272C8284224
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 18:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF06A1D1757;
	Tue, 27 Aug 2024 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAWbSply"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A251D2F4D
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 18:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782598; cv=none; b=HqthsvpcRCRKZppIMhYPnaNa5oO/jnokghEuw3Fl7ZIAJjCfTCtzHusrgiTbrpDl6C8qqno+WrW8EaUrsnW+fGk9fuBksCbBAO5JrDarYo9HneBhRSdzZgwV0P3fYTdR1QN/sLlNOiVqSWIrHP+i9y12XGODycjOYci6hxut+6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782598; c=relaxed/simple;
	bh=X8QcjerdXUVJM0M6K25kjjudFG+vmIr5pWvEHt8N2WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYTr/HRQqsiusThVxsTpF3g9I68QwGH2l2C7ewobrFMmmIqlJBZIwqv8iQc50Wf1gicUzMtdYZKWjPMZ6EIElbG0+TDIMDOwFRDkIv1u+4CarSwvnR5QKHNLykMf+5FXAVg++r2WBtNTkKxYg7h+tB1c8sTkHSIFGFf/iLROZBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HAWbSply; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724782596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHSBO7ll3rbZOfjXr1T8jodqp3tHRdp2gSRkpPRf9Tg=;
	b=HAWbSplyNrpeIEgf2zP07+t0ix/WDNJlPtOuvgEa5ulDYPiMkT1eTdxCi6eJ8Skp+mpxKa
	ZevXnnUNa5Ejd+701HRM26ylOY466mffgmBTGiXrHQHpVUoYgPnfzb0JrrNih3dw8NY/dZ
	uEUBX7qi0zOw0LdiR8BBLAFN+0/Kqf0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-dIwCQhuYM4aMfyb2E7t3iw-1; Tue, 27 Aug 2024 14:16:34 -0400
X-MC-Unique: dIwCQhuYM4aMfyb2E7t3iw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a86690270dcso555058366b.2
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 11:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724782594; x=1725387394;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHSBO7ll3rbZOfjXr1T8jodqp3tHRdp2gSRkpPRf9Tg=;
        b=eAwinLRFFl9MCOx68qjIm0LuCoJvKWKPYlx2KC7/yfU5FYmDEH0LDqNYiPlzrKI3Dk
         lUZi0ewpmgdT4rnae4u/2NCF36U1IYCmuAIhUc5qrBRdo/CVzZRSLrvG2dQSQivuK551
         ygyYd+dHjpj/W6nm0dpmuHH3xFH+NZ9J4k3D9acQvQtEky0cBLLerDfg46VDAVTgkqtN
         y/nr7fDP3JEqEaPru3faDLLV4U/DrC6Ojatjz6KIm2NSbhmrr6ednrUmoTy5F3JRwXvw
         xViSDOtJc5AXaK7avlhgeTGANU4mpyLnzzY1TV4PDOyCOikUQUkEzMJcDyW3WRTye9Nm
         ZM/g==
X-Forwarded-Encrypted: i=1; AJvYcCUbFdg2xCcTKy2FY6PfNR0DZeajQldkxl/r3Rzi4eLgenpb0gnctgWHfrKuewJNfXaOz4fdkmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuEcJBE+XeUVRuZRVcG1IKDjMKPyh8ati7M93S5mxQv9ztihOO
	wKxDFZiPmxnXwCnQVUBNWCl/lCsniQFU5FpFYhefde/vr/qK0hqw2+FAqInptTvLx0+pwsu+qUy
	w77LZi7oHfjeE5719sxIhe4FcAJ2MtD4bjuZVEDV4vVfsKrhojnqDHQ==
X-Received: by 2002:a17:906:7315:b0:a86:99e9:ffa1 with SMTP id a640c23a62f3a-a86e3d3e9camr241758766b.64.1724782593699;
        Tue, 27 Aug 2024 11:16:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnDe3VluilgSG0vcrrqRKifn4o56qtamsjzIVVNpfdjfRpMszxTYEqVcY4D+Wi8k/eikH1ig==
X-Received: by 2002:a17:906:7315:b0:a86:99e9:ffa1 with SMTP id a640c23a62f3a-a86e3d3e9camr241756666b.64.1724782592949;
        Tue, 27 Aug 2024 11:16:32 -0700 (PDT)
Received: from redhat.com ([2.55.185.222])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e588b39asm138757166b.159.2024.08.27.11.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:16:32 -0700 (PDT)
Date: Tue, 27 Aug 2024 14:16:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Carlos Bilbao <cbilbao@digitalocean.com>
Cc: virtualization@lists.linux-foundation.org, jasowang@redhat.com,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] vDPA: Trying to make sense of config data
Message-ID: <20240827141529-mutt-send-email-mst@kernel.org>
References: <4f4572c8-1d8c-4ec6-96a1-fb74848475af@digitalocean.com>
 <e7ba91a7-2ba6-4532-a59a-03c2023309c6@digitalocean.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7ba91a7-2ba6-4532-a59a-03c2023309c6@digitalocean.com>

On Fri, Aug 23, 2024 at 09:51:24AM -0500, Carlos Bilbao wrote:
> Hello again, 
> 
> Answering my own question:
> 
> https://elixir.bootlin.com/linux/v6.10.2/source/include/uapi/linux/virtio_net.h#L92
> 
> Thanks, Carlos

Right. kernel.org would be the official source for that header.
Or if you want it in english, that would be the virtio spec.

-- 
MST


