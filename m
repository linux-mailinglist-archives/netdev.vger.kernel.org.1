Return-Path: <netdev+bounces-96710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA268C73BA
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 11:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559A71C22986
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 09:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72145143747;
	Thu, 16 May 2024 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hy33Kw16"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C0613E88C
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715851504; cv=none; b=aoigRD4kG5dW7Q3iFWPFMPK/VUE0w7SxieVXQ17wa24tbQzKXahtB0qSJGxbJgbCp74/nkeLKRGjBuLtWdz+3lMP5WBag7abJh/1yONykeA66d+ZRxITneef2extH13uQIYWlYrUDHLYsRCGxrfQXtrEtNAmvCB9XhXCvQmjxks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715851504; c=relaxed/simple;
	bh=gEOFfe6fLPIqAo1WPwEV/+B0Gd/krGruDl9V3z9ITGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mf+OnC54Y7lNExg/zikgNkb1qFVe2uPbt+l7E6kbE6JNwMBX0BRhHJvCFAS7xL8zjqeNFtoroqoZiAXsvKLI/WLOJJD2KLFIJYAeYICdkkOs2+51BeGjFqkGD0I9GsmyGZ/eH2z7rqGZBE4k+mDH9LQTffVlbO8BoDGaRYMLww0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hy33Kw16; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715851501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pLsXGy9svYf5i7R9suDR3MeGGzNJZNzgdI1byXiF+rk=;
	b=hy33Kw16V9zQf5bKDvVfwdAG4rG2g+ZSPK7R9EEG+L79WpcCtppB05h0V8NADlvh0PTI4l
	/qpHmDxBcMkJTB260w5XCbG3ZVAwy4ASCiEfCozitW5f1AeIsZTB4bFynN0a37IeBh+crJ
	AHnWPA+IccWVyZnq0HEGe2vvyAhqNWU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-Hw0RDw-SNv6UoI37sG6mfA-1; Thu, 16 May 2024 05:25:00 -0400
X-MC-Unique: Hw0RDw-SNv6UoI37sG6mfA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1ecb7e1e3fdso61388425ad.0
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 02:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715851499; x=1716456299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLsXGy9svYf5i7R9suDR3MeGGzNJZNzgdI1byXiF+rk=;
        b=A9/NKMbkoC4K5fKaYxq3zsOpp2E8sAV3XMd2rK9vGRLwp5jNYMJgFHtH5HOoq422dm
         QdpHdTYcvNepPReaXCJxN9vV2Vwbl3s5NO7KuFtEvoX9yD/baco4h+BtBLJH4XE3w/My
         EphngNVGffFL6sXcGbSiWpQBfU64m3LbOPMlgRURDR9ehPNGNYdqWfD0cF1XZpsDkGri
         eMFwY26sjRnq0QBpxloQcwhuoutqLQqUpO6vUJ9c3IecS0KudOWsUa/BG88V01M8BefH
         T8Eh4j8ZewBv9eDRS/WgXDCK3Q6n4tp4I6VrSIbggeKVJin9+zKEeHQj6L0js12gUVDt
         W/eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg3yPDJ3xQd3eYL38paK1MRwUaY+rgVZUcyuLx1Y4JAZGAPNN6cjcIXsGygra9n3eQxP/U3ejYbYVZcPdvG48xTlSecuUT
X-Gm-Message-State: AOJu0YzpkJLNiuIpamzoBXA45Ac6cmYNvr6wX+fuFOltqq5+XKdQ56kd
	Z9MRWHEeCpN33vnMfJ6I+YwWjkW3iEKJ5tW05WHYAXSjoqKYkEMgYcWajJcomZj9Ms6TQuTaafP
	t9O0vXHMtXgOb6soPQhq+55YNQp4TEtACShDaj8yyr7T41E3zkUQ5+Q==
X-Received: by 2002:a17:902:e5ca:b0:1ea:657f:318f with SMTP id d9443c01a7336-1eef970fe76mr310399225ad.0.1715851498997;
        Thu, 16 May 2024 02:24:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjtRRqiN2KZ/i8PorLnqYc/elVZ41EN74K0P7lJgKGNOObydeMIHF+IPQLRSpASMPieLNd1w==
X-Received: by 2002:a17:902:e5ca:b0:1ea:657f:318f with SMTP id d9443c01a7336-1eef970fe76mr310398975ad.0.1715851498574;
        Thu, 16 May 2024 02:24:58 -0700 (PDT)
Received: from zeus ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d3565sm132966955ad.30.2024.05.16.02.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 02:24:57 -0700 (PDT)
Date: Thu, 16 May 2024 18:24:54 +0900
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, syoshida@redhat.com
Subject: Re: [PATCH net] nfc: nci: Fix handling of zero-length payload
 packets in nci_rx_work()
Message-ID: <ZkXQ5h8fla1KhX6A@zeus>
References: <20240515151757.457353-1-ryasuoka@redhat.com>
 <20240516084348.GF179178@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516084348.GF179178@kernel.org>

Thank you for your review and comment, Simon.

On Thu, May 16, 2024 at 09:43:48AM +0100, Simon Horman wrote:
> Hi Yasuoka-san,
> 
> On Thu, May 16, 2024 at 12:17:07AM +0900, Ryosuke Yasuoka wrote:
> > When nci_rx_work() receives a zero-length payload packet, it should
> > discard the packet without exiting the loop. Instead, it should continue
> > processing subsequent packets.
> 
> nit: I think it would be clearer to say:
> 
> ... it should not discard the packet and exit the loop. Instead, ...

Great. I'll update commit msg like this.

> > 
> > Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
> > Closes: https://lore.kernel.org/lkml/20240428134525.GW516117@kernel.org/T/
> 
> nit: I'm not sure this Closes link is adding much,
>      there are more changes coming, right?

No. I just wanna show the URL link as a reference where this bug is
found. This URL discuss a little bit different topic as you know.

In the following discussion [1], Jakub pointed out that changing
continue statement to break is not related to the patch "Fix
uninit-value in nci_rw_work". So I posted this new small patch before
posting v5 patch for "Fix: uninit-value in nci_rw_work".

If Closes tag is not appropriate, I can remove this in this v2 patch.
What do you think?

[1] https://lore.kernel.org/all/20240510190613.72838bf0@kernel.org/

> > Reported-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> > Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> > ---
> >  net/nfc/nci/core.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> > index b133dc55304c..f2ae8b0d81b9 100644
> > --- a/net/nfc/nci/core.c
> > +++ b/net/nfc/nci/core.c
> > @@ -1518,8 +1518,7 @@ static void nci_rx_work(struct work_struct *work)
> >  
> >  		if (!nci_plen(skb->data)) {
> >  			kfree_skb(skb);
> > -			kcov_remote_stop();
> > -			break;
> > +			continue;
> >  		}
> >  
> >  		/* Process frame */
> > -- 
> > 2.44.0
> > 
> > 
> 

Thank you for your help.
Ryosuke


