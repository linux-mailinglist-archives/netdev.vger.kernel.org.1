Return-Path: <netdev+bounces-99176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451368D3ECC
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 21:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7652A1C21405
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 19:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B001015D5B9;
	Wed, 29 May 2024 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwq5GKTl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DA115B158
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717009818; cv=none; b=WEIeL0+Clid3vdyOO2aMS6zfaCrw1x6oh8NXLhuHexpW7CTgEHz4UZI7Dh/mUHNRha7x9nvszRxii9QaJTe1yDLVWT3pm5LwIvnv0Okvt6phHSaYqvmjrzNdREYmXUEwHOITZP8zII0sriqn8SByFp1HAoBsjF31lvZ6mMVOV3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717009818; c=relaxed/simple;
	bh=mfCluD2e6J4JGyMIkesDY3Swhmhih96o+q6ojlmLBQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NV35GiJ7aJtapjZ9uIL5lCnCf1fNKEDFUQyeH8vmRDI18ixSexkfOTJUcVKU9SiMd9oKUVVYeasUpP5EtN5BE+dWofejUMcS05p8+zfV5GXqO4vbgnTAM1zANR9yGCkoVdzIdHLZVRdWuJZ1GXUuJGzlwXsyXgivf1B7XqIBNmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwq5GKTl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717009815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mfCluD2e6J4JGyMIkesDY3Swhmhih96o+q6ojlmLBQ8=;
	b=cwq5GKTlrOoSj6/IgD3b4BVfjnbdZMWD8dswELXzrrkBaAGEvIZbQzhp4U+vvO5PbwGEsW
	7lkBA/VNG7sTNJRheXOTDlG0zsHlzdDDG7ywo3h6E81KYNKXSNQaj8JcEeaKY9kogCUxh3
	vAPSRc9JXDDM30x4S4AXaJ0puIT+UIM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-UJqq5156OZ2uj1sVuvUPSw-1; Wed, 29 May 2024 15:10:14 -0400
X-MC-Unique: UJqq5156OZ2uj1sVuvUPSw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-354fc05816dso43099f8f.1
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 12:10:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717009813; x=1717614613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfCluD2e6J4JGyMIkesDY3Swhmhih96o+q6ojlmLBQ8=;
        b=qJ3y2sNz/fHZmnPIASIgrDznIJoroTyVc7gl9C/CaZXED9fgp/sXw2kVJc7lulTmf9
         qe9ojSEgBRgEjqg0kbZFHsdwyTgP3FoYH6xxbQF+iKBed6D0+lzMotyHC2ulb0HWHDYu
         1LSS7C/YlvSDkWgPIk6DUw73augNB2i7nYwu0WzDYLdef9ReA62keI5R2Iw4bZFjuhnl
         IVQIgBXXHdWeicBPWOT3gixuaqmSNlUt/Koyf4enC/R0taInG4FfjWXKuBQAK7scEAHg
         QiCnM8cgcEpjZKAhFbxEyQw/71oVw53PrWp5ESkypdccY+hp4vHL14zK4RGTQuk31KMI
         PCBw==
X-Gm-Message-State: AOJu0YzJDwLk+KBkyZbDCnfVsSNxcrLdPlwYBdipj2VOylnyoCjpAO0T
	F0h6vh7FyWV6vTy987R0fezgHwssKpdeRgrADQDzQdNvu3YOhHeDddvfW4xzSPlHNAv4g5tZR0j
	o3q9PvOhwnpWRGtKpPliFx5qiplL+WF7ysaP9q2XmsVAy8P7vy+SEHw==
X-Received: by 2002:a05:6000:1743:b0:354:f8c1:c5aa with SMTP id ffacd0b85a97d-35dc0087c97mr74082f8f.13.1717009813242;
        Wed, 29 May 2024 12:10:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgi0sCVPu0G57WKtVkXq0F42xp+PzdWdAjTcTVyFx21vXiJAmcbFfbXM/goq6S/lOk3OczVA==
X-Received: by 2002:a05:6000:1743:b0:354:f8c1:c5aa with SMTP id ffacd0b85a97d-35dc0087c97mr74069f8f.13.1717009812849;
        Wed, 29 May 2024 12:10:12 -0700 (PDT)
Received: from debian (2a01cb058d23d600b6becf410648fe77.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:b6be:cf41:648:fe77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557dcf0377sm15726419f8f.100.2024.05.29.12.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 12:10:12 -0700 (PDT)
Date: Wed, 29 May 2024 21:10:10 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, stephen hemminger <shemminger@vyatta.com>
Subject: Re: [PATCH net] vxlan: Pull inner IP header in vxlan_xmit_one().
Message-ID: <Zld9kpgQwjMY8Sl6@debian>
References: <ea071b44960b1bb16413d6b53b355cab6ccfd215.1717009251.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea071b44960b1bb16413d6b53b355cab6ccfd215.1717009251.git.gnault@redhat.com>

On Wed, May 29, 2024 at 09:01:12PM +0200, Guillaume Nault wrote:
> Ensure the inner IP header is part of the skb's linear data before
> setting old_iph. Otherwise, on a fragmented skb, old_iph could point
> outside of the packet data.

Forgot the Fixes tag. Sorry.

Fixes: d342894c5d2f ("vxlan: virtual extensible lan")


