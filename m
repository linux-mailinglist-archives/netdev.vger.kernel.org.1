Return-Path: <netdev+bounces-174159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B9CA5DA6F
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 11:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313A01897837
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA83235C16;
	Wed, 12 Mar 2025 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JhaNzZuA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8522F19882B
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741775481; cv=none; b=iiRQ3JXM3ayY5pW1FLk9Au8U1dKgddavbTRwrjO2/mJ7SSGeS/jN7Kd4qgeSI/aJ7kPWq2LcgzUaf58gTOr2W2OlcOpCXhfyJ7VqlFkqx6ISuV+JHkmrW/dydMjqTcxJgEDcXvfPGZnuwkl/3YEsHNx2p4dimWvQb/FFlcXnYjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741775481; c=relaxed/simple;
	bh=P99lE3mJwXPj+GEbmP0xwX+rf4eTqzBXZGRaykWQ8v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKJ6SlUaO6TiqF8wH9LyAAW9JSl/S++6G0q+5/eXyMoWr88NL39aYLp6PfhsWTSnUIj1WIhpdYObanU1luz9myBP1D7mNfxU4CoKUwXC7yFzlIMZ/ucPDt3YRC/evF85vsLaFEUB59K+gyGLN5JA+4ldVVbm7nC+eCv5Q2fxXJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JhaNzZuA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741775478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cx0qYAqk+Ndkh+zCqVoXeKfQLXTHj6djYkow7w5DHN4=;
	b=JhaNzZuA/KZTKA0gxXCl5msYwoHcs6YTaTvimCdD8BB0VAHTOR+UOzLmHlmUuKTfuexhSe
	elmn5X1qQfK5brk00mD7s1eWSkNcVZHeuFeaVe7BqpPeKW8weRt3Wt3JnuoTrLxEsrLN5s
	QbG8Ncn6eUWGbzWWjAB+5FKaekdy7eg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-yaS_IO4RMI2S8NC_FOD0dw-1; Wed, 12 Mar 2025 06:31:17 -0400
X-MC-Unique: yaS_IO4RMI2S8NC_FOD0dw-1
X-Mimecast-MFC-AGG-ID: yaS_IO4RMI2S8NC_FOD0dw_1741775476
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ceed237efso28391755e9.0
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 03:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741775476; x=1742380276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cx0qYAqk+Ndkh+zCqVoXeKfQLXTHj6djYkow7w5DHN4=;
        b=YFNLEGO6ti/0JgPmWJ2gGrNapR4TcUzf9O0a6md87xj0zh3HeA/UgbIHZwqdjTxWvD
         BByHmQSNyMPQe2uNZez7uZV5qDKxLK2PDIthUyeTwiwuujwCnXUFApIZJqoejR6KxBkU
         K11HdPSMmNjrUGxW1gbMOoG9uIVAGkc57rVm/Q4XKwW9XHm1x0itiQW/IhCPVFIQ4Wm0
         n7Qmu4zD6zdaAuN/pe79hMKKQch0/p1FzzJ3+MglzyTQ//+n1RpalvgaTTaeceMMcpsM
         ee4MyrcpfeDJrhzTwseG4pSxZdoC9MEFxbI+MOggPHr7Tqa0k79+h2NzzKRAzW/Ojkns
         srZw==
X-Forwarded-Encrypted: i=1; AJvYcCVOTUzBIcLjdJGv/UaUw1W12yA2GywyaqVTwqiPJEjUtTFQG0ASgKliCA1XxHjru6qGUVOLCts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/oUwV1zy/ES9u6/M8Xna3I8cr/ZVH8s7EDxbTwlXKkeyEFiRi
	QBE90DL/E0huPZmIkO+yneCfEatkW1LGrCk51J0iznZpDvZoAjgpniK65yqIK2eMK1PJtJIv5GH
	fUnOKDwMwXlTYqEAP33ZfGZtato45/GyafD9+tXjUk7aULNrmeAZ44A==
X-Gm-Gg: ASbGncuPzWhQh2AOAe5VsGPIVXR3wKTgXHsPB6CKlf6VK6wTI6hQ6ewdp2yfnz8/Eup
	veqwB7WXxukt53ckyghqVLCA1gskQJT/OnP0iOOkR2xMt2oFAO5oLX3CZoYzgn0Ba2m7h9mZBD4
	r7zkURlcUe0V6GksJTMyIMEA3eqXVI6IlqNjLm58lkxqR9142ZP4Rz3U298dtAKsdySGkFe0u9Q
	kVEZlzBid05vgth3PWnJHhnhG4xlMR33ghHZYtSbVs2u0F3DHF4KlaNcGwX1nN/AKhE0P/wWXLh
	bMiebPwgEQ==
X-Received: by 2002:a05:600c:1c81:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-43d01be6389mr90683845e9.14.1741775475781;
        Wed, 12 Mar 2025 03:31:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMo39VgoZH85nAphCFnLGhSo95m+X8Gu22NIYuOsLFerRQWzuG2jF+y+KHgzz3MHJwbiYZow==
X-Received: by 2002:a05:600c:1c81:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-43d01be6389mr90683655e9.14.1741775475423;
        Wed, 12 Mar 2025 03:31:15 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a72eb5fsm17374525e9.8.2025.03.12.03.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:31:14 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:31:12 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Harald Mommer <harald.mommer@opensynergy.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Message-ID: <Z9FicA7bHAYZWJAb@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <a366f529-c901-4cd1-a1a6-c3958562cace@wanadoo.fr>
 <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>

Hello,

On Thu, Feb 01, 2024 at 07:57:45PM +0100, Harald Mommer wrote:
> Hello,
> 
> I thought there would be some more comments coming and I could address
> everything in one chunk. Not the case, besides your comments silence.
> 
> On 08.01.24 20:34, Christophe JAILLET wrote:
> > 
> > Hi,
> > a few nits below, should there be a v6.
> > 
> 
> I'm sure there will be but not so soon. Probably after acceptance of the
> virtio CAN specification or after change requests to the specification are
> received and the driver has to be adapted to an updated draft.
> 
> 
What is the status of this series?

Thanks, Matias.


