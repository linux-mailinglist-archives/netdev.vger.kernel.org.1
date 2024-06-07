Return-Path: <netdev+bounces-101748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA958FFED9
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75AA1C20F16
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6457C15B541;
	Fri,  7 Jun 2024 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bahr3dP3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C492F156C5B
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751351; cv=none; b=UzG7gftw6v7hc/bmZMrbQe2BwmTcxVSK4GNq+rZXEXnZFTwZHSgdtt697TGUHsoRZOGcW4AZWvK0WKUUC6691nRNrvSKazX90U9/qeg5r2BXS1rkfsnSjp9e9OuRhaHmriX1TBLqwKcY84/2YlKHGspe+mw/dsVnAmG0uy6jExg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751351; c=relaxed/simple;
	bh=2g085Qv2sZ+lzpHJ6d/morSwEobDi+HUPO3OoA/Wcfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaupqIz7J84dScAsNGHphIKzHJ+6ka8uGq++mWicY7VjPB7YZWLxEljYPCF9TqhkMSoogrQ3RNwkWWP8RMIz2DLuXjiNAl6ZNna0TCj7JF3IWJkoFj5QNyab+q9OL37nEgSZB0Ns8syKGIcfhQw3/5Bjk1oow6nVAIOCk8zj2D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bahr3dP3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717751348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B+hA8Ge9BqN2Oo6x+bvaug2r1jAxQeeVpqVkv24yF+U=;
	b=Bahr3dP3h3gIUseL5mEMCHW+HpfFdT5gG5CHNUbnz4L5DvrGcQSepzViM/nNZ3jwI2YdAO
	6V5w3UvphkOWQE/e3Er6LNsUorH8R4BSwafMezTa83t9XB5isyCBooMkT71dIgWHMy94w6
	/f9bqfGqfDfabcjO+UM38RXlTIgimwI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-uqMrFOiAOIK20ko5DlH5lA-1; Fri, 07 Jun 2024 05:09:07 -0400
X-MC-Unique: uqMrFOiAOIK20ko5DlH5lA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a68e0faf1f6so113610666b.3
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 02:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717751346; x=1718356146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+hA8Ge9BqN2Oo6x+bvaug2r1jAxQeeVpqVkv24yF+U=;
        b=ZSk9foPB+BKmO8CIFoINSnvKVKBZgqFWasTIISidUU6XSp8UdUZP5GRbkBDWfSW/5p
         H8snILAuOOr/YZuStHKPOmxb/jZq2D3rxBgLZy590Ot+mNTd8SO+q5bprOCqAGCYSPXW
         A80LCLGDHitt8hKmENa6HURR1wYn/3bWH9wWAxezGIIaaWm87rvmjTIvdFTV+r7wpjqH
         Q7USEdOuJR3ZucYW+nkerQnzphc9gVGEbumSfqjFrUz8GMLUXKJ2tmwLANU3zD//bsCs
         CIoHXm8V6Js1N4FsbowGOMGxYnDa9vY0kY+aTRrIfDJ+oloUw69tj51i8iXNHWbD8Nxj
         2hCw==
X-Forwarded-Encrypted: i=1; AJvYcCWjTILqiIgqhlq7eqv5onM1bMOQCDRpMZcar/nJUC/yo9OPji4K2T9h3T1Owwo4rg0h5OdBuSIAqwCfbo93ZPNx0hYibuEY
X-Gm-Message-State: AOJu0Yx/p2y4K1vyCLfAKWC2aMAA9klQs5l+ORaVjTDWMhODoiRv932j
	/fepiMMIv6jRqypJ/UJsMP0SFhSbrfY702JOl4vbQBMchLaP62MN1NId9Pt1NvEYTQcr05Zmg4K
	qLZK3WuSJK//fL/7lEEGmLerrO0PHUJnupHJjaxfkeJQXMeLObogEQg==
X-Received: by 2002:a17:906:48cc:b0:a68:e7e0:1fd1 with SMTP id a640c23a62f3a-a6cd5616af7mr139567666b.7.1717751345967;
        Fri, 07 Jun 2024 02:09:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeH+nc8VxKm7H4zo7Jyw3/GG2IBw4hOvl0fOyKmEAvw8ocTKoS9aGEe5N4RDOTTILMmK/Vfg==
X-Received: by 2002:a17:906:48cc:b0:a68:e7e0:1fd1 with SMTP id a640c23a62f3a-a6cd5616af7mr139565566b.7.1717751345434;
        Fri, 07 Jun 2024 02:09:05 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:d5af:1ef7:424d:1c87:7d25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581f42sm213657566b.1.2024.06.07.02.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:09:04 -0700 (PDT)
Date: Fri, 7 Jun 2024 05:09:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Harald Mommer <Harald.Mommer@opensynergy.com>
Cc: virtio-dev@lists.linux.dev, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>
Subject: Re: [PATCH 1/1] virtio-can: Add link to CAN specification from ISO.
Message-ID: <20240607050716-mutt-send-email-mst@kernel.org>
References: <20240606141222.11237-1-Harald.Mommer@opensynergy.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606141222.11237-1-Harald.Mommer@opensynergy.com>

On Thu, Jun 06, 2024 at 04:12:22PM +0200, Harald Mommer wrote:
> Add link to the CAN specification in the ISO shop.
> 
>   ISO 11898-1:2015
>   Road vehicles
>   Controller area network (CAN)
>   Part 1: Data link layer and physical signalling
> 
> The specification is not freely obtainable there.

This message really should not have been posted to any
of the lists that you copied.


> ---
>  introduction.tex | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/introduction.tex b/introduction.tex
> index 8bcef03..72573d6 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -142,7 +142,8 @@ \section{Normative References}\label{sec:Normative References}
>      TRANSMISSION CONTROL PROTOCOL
>  	\newline\url{https://www.rfc-editor.org/rfc/rfc793}\\
>  	\phantomsection\label{intro:CAN}\textbf{[CAN]} &
> -    ISO 11898-1:2015 Road vehicles -- Controller area network (CAN) -- Part 1: Data link layer and physical signalling\\
> +    ISO 11898-1:2015 Road vehicles -- Controller area network (CAN) -- Part 1: Data link layer and physical signalling
> +	\newline\url{https://www.iso.org/standard/63648.html}\\
>  \end{longtable}
>  
>  \section{Non-Normative References}
> -- 
> 2.34.1
> 


