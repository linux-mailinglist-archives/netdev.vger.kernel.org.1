Return-Path: <netdev+bounces-74138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9812786031E
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 20:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B061C22512
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 19:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDE214B838;
	Thu, 22 Feb 2024 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4CrXYmC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAEB14B815
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708631122; cv=none; b=ekRs7WqWTtjtJ7EM4KUdGmrDWA5ynhvK4gxrcYnWh2Gw3YoigTzXvKa8gbX2KFoD0BLYZCPKnrcEPZAfZr1Kv2eITg/exnQgXFnLS9E+ZdDwVYr/L8krC3rAstMYX4NLCHHPC14h/xB4QhH+a+n/4ywKK8ppijvXzRp4TjA8Yss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708631122; c=relaxed/simple;
	bh=oLWpUQzEDg1YWW4cOetAqNAPnhZ9oahsEaWv5ozR+LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4ON1ac9wuDl2Rg/I6/JPhviJ2/IYOBoV/wTlCR1/n73/ujuzUalg+06W4dANj8xAtBkejLXCJAjb4DsuB+7oQ78NKQnhdBSscmA9Beh/q+jlrZdGWBg4wL//1Z5H/ysx9LYUeD63nSWFXIuMOY3bhrwKg3nqBHY+p57XxWxc0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V4CrXYmC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708631119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HtS3rO3/k4CHxBCems7dZZwyABPFlcoiWlBHvKoMPuE=;
	b=V4CrXYmCbdezUwQ6+xb1iM+ZAgTpx4jjOsn6qqoCuPjgtBHV5V7KwMAF4h2etdMimDp8vC
	Nk/69QGO+3sKv0JB+kXMpnSsYxEQULZAt/MIajyRn7pwdMhoAE7AaSaoQGvPla2lMgAM6k
	40PxGDTGTiVOxH8eelMqLlksr0mv42I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-0omo4EjUO0eEY7KZGIg62w-1; Thu, 22 Feb 2024 14:45:18 -0500
X-MC-Unique: 0omo4EjUO0eEY7KZGIg62w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-412557adc00so945495e9.2
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 11:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708631117; x=1709235917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtS3rO3/k4CHxBCems7dZZwyABPFlcoiWlBHvKoMPuE=;
        b=HUqja4uy92M1u8XNLDOLVIek8U2cYOgLPP2nFpN6GczY7ZPSEUzSMvaFFl+ADMSXXM
         kUXYn4fRGlHoVGoxgMADjc1uDdrPYEPvzLaHI87wSUMvcmL+6mrhzfGNNcPaoK6EUO2z
         qZM5oDZgqqRZL6ulwkyfa1ZAafzysHEl1yIA7ETFwJ8yYbCU/UvhKKGoHKB3J013wKl+
         s+nUtgkD7ZCY9ICtH02UZzH2ETDR8jm624bHwCdlimOUauaRgC9zZcd56mmmc+8iP4pN
         L0KMZ+9yi/17RVDyW9s/DKPW5PJfMB3iYOuKB8vm0kjAcES3HbKo9C0Dj4zj8mbKtRVX
         /AtQ==
X-Gm-Message-State: AOJu0YwwD4cx3mjgMkPD6AGxzQXgUwTkZMEZxRaZJ2vDe2OHmXOLEBze
	RvjGcUEESYNXl6wseEzRSWqkRQaFw/dWzmmXLLB3uNXxk0AJNML+iRYxWiFuwefeIZG60UA3e25
	7k2ZzW5qq+eSuB6Z0kVueePwmVbmrrTe8QtKkXtnV6xSuK87kPEDfoBYPakIqD5UA
X-Received: by 2002:a05:600c:502b:b0:412:9064:fd12 with SMTP id n43-20020a05600c502b00b004129064fd12mr133436wmr.26.1708631117015;
        Thu, 22 Feb 2024 11:45:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIRLu3qZVKJ5FnK2wvIF3qslAVzVoLbk3KPH5Qa9qhUzWeKOnysKrycrAsYRbxrz39i8PjAQ==
X-Received: by 2002:a05:600c:502b:b0:412:9064:fd12 with SMTP id n43-20020a05600c502b00b004129064fd12mr133422wmr.26.1708631116744;
        Thu, 22 Feb 2024 11:45:16 -0800 (PST)
Received: from redhat.com ([172.93.237.99])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c228b00b0041290cd9483sm137666wmf.28.2024.02.22.11.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 11:45:16 -0800 (PST)
Date: Thu, 22 Feb 2024 14:45:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 0/5] virtio-net: sq support premapped mode
Message-ID: <20240222144420-mutt-send-email-mst@kernel.org>
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>

On Tue, Jan 16, 2024 at 03:59:19PM +0800, Xuan Zhuo wrote:
> This is the second part of virtio-net support AF_XDP zero copy.

My understanding is, there's going to be another version of all
this work?

-- 
MST


