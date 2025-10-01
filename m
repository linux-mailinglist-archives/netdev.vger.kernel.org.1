Return-Path: <netdev+bounces-227492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 522B4BB10D3
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 17:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC868189B755
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 15:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED072E2DD8;
	Wed,  1 Oct 2025 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GH7uO8lF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FA71DD9AD
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759332218; cv=none; b=b8suwspuS380EK3LbG5Jn4+Rt5BmLqOjr0xt/yNXAeWUXXE1mRoChAtD5PYwGeKZFYKfpfqXK12wZbLqQHozQWWh9CFdaVUA6zLB7kC5vyY8oQrn7AxE09SIIgtVrQplejGL6Q3vqerRWhhBIREXjQLTmMeD++HhfjmCSPBqVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759332218; c=relaxed/simple;
	bh=iBktchbTFIkQVIZCHXu3rzcyooPQa8aMp3zZsKHXgNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8fQ80G3LwTWDeDOKb3KYXl/bPPjlOxTnftG57KYDD3cIuAp+ffkoSg03z2QQEkCzu2MvWf5S5UQTrYwBHeh10Q1Nvuar5Ft/6jX1jOwhNQcx1peTdy9RooExCn9hXLu4sGVbJ9l/fxOlz2AH2rTbpHVNXCFMLFtaRgnhcyjqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GH7uO8lF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759332215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L8KTVkxDaTugQkJkjdBtyRDidD31YHiR8yeBnSmByJ8=;
	b=GH7uO8lFlsJxIzeLsHnlbzvlaNsjM2d9U2+BHelLUzqKdl5HbKoyahFZpcS+dcmAmDNl2A
	/B0yEOuSUnyGfiukhaeQsxRiXESMpBnJhnX8QS9NXM7UuW/StibAx6BLx0zT/yb2+0mWj+
	JHTN9icponRAEA/Oo9Z2mvKU/dRBIZ4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-oHDQmDRVP1yKlYFQR5FrzA-1; Wed, 01 Oct 2025 11:23:33 -0400
X-MC-Unique: oHDQmDRVP1yKlYFQR5FrzA-1
X-Mimecast-MFC-AGG-ID: oHDQmDRVP1yKlYFQR5FrzA_1759332212
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-40cfb98eddbso526024f8f.0
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 08:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759332212; x=1759937012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8KTVkxDaTugQkJkjdBtyRDidD31YHiR8yeBnSmByJ8=;
        b=Xg5PPCAvUu+jkh/brhBGuy15foC6Qd7j0035Qu5IvYiP0WOyHAj1gOf0zL6bArlYmU
         p+l7C4k45qEFTECLyfFBUKODeFCS8IT2QPYbjqIVWKt3IMkd9KJx7ORJdKzvX7g2S2yC
         hza37l368Sov1zsSmQhmjE8QHSQAllvT8C+9UAtp5e7I9Ye5yP88uSLpqBY+nnskgf+g
         D9ACTIydedB/Wgjwio98odffmf2HGVDKFYCUVU7A8/GjegNQA4W0cDGp04DSjln3Fi6f
         J/7Nz6wDPlXyR+AltRE3MsJWE5xloavbrK68PxmBqnG4i/uinmKF7QB3F8KK8CGtpB70
         087w==
X-Forwarded-Encrypted: i=1; AJvYcCXFe/MmPYvO/uogI0tg974DQxj5WbW8o30My+vDM5vAbkWrFwxPCuuS6VecRnTsuhIsgmZajLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQhyj8+iL+cGOrXPY9sKJi30n9n0n+KtyQpYOItSONpgzj2JcI
	HnKmmSuHDofz4TDaCz1OFMdnc88LbaRzIg+sATwKS+RV0n7o91ChUoY6zdGpV/gv0l1qm/WXUpE
	8wrEWvgg/iCjUwlKj13vDZyIhWY7ijksi6Ye1OtLz9GdZJRBj8dCD1nnN6A==
X-Gm-Gg: ASbGncvDcei3jA4nnz2ogWy7VHCImaxnBD7uiJY4jKkTad+I3AZmCIWpcC5/ZVwgkVP
	6fQOSMjL3KYHzws1NHAYJGttFpcqelQDA62M9+ekPaZELsgbO8qxA180I7MiyAu/FfQDEGaunKf
	9XHX2AU19A+1e2lorFY8mdp8H4B9FW8f/y2mJeOkrw67Ow5OY2tammoq0kVVLIPkZ94kjBggDSZ
	1JIqE16SxVyPumhHrGo7GKifzkep3Lkb5ZI1DQOtZ/U4T8v3oPz22WHZmYtERJw9cNN0hWFFOT3
	RElhjYKsJX6fbWXCPsIpef/8/0OGNw0LjKxhSprJCk/2LyCYVAgX7f3C+LX0vaDSEiweqTja4xt
	Mp2FmxGyTTQ==
X-Received: by 2002:a05:6000:40c7:b0:407:d776:4434 with SMTP id ffacd0b85a97d-4241227789emr7217862f8f.30.1759332211734;
        Wed, 01 Oct 2025 08:23:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0F9XwtcVPf6wB/WoKqvKR5BovvccvzXbrj2loiPZ9rqJZd0tUbtbAeri7VVwEh087dav6lw==
X-Received: by 2002:a05:6000:40c7:b0:407:d776:4434 with SMTP id ffacd0b85a97d-4241227789emr7217838f8f.30.1759332211348;
        Wed, 01 Oct 2025 08:23:31 -0700 (PDT)
Received: from fedora (193-248-58-176.ftth.fr.orangecustomers.net. [193.248.58.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc7e2c6b3sm29483495f8f.54.2025.10.01.08.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 08:23:31 -0700 (PDT)
Date: Wed, 1 Oct 2025 17:23:29 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
	Harald Mommer <harald.mommer@opensynergy.com>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	development@redaril.me, francesco@valla.it
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Message-ID: <aN1HcWZ4Q1lV+FdP@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <2243144.yiUUSuA9gR@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2243144.yiUUSuA9gR@fedora.fritz.box>

On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> Hello Mikhail, Harald,
> 
> hoping there will be a v6 of this patch soon, a few comments:
> 

I am thinking to send a v6 that addresses all the comments soon. 


Matias


