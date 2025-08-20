Return-Path: <netdev+bounces-215320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D7BB2E174
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 17:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666511C2262D
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 15:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085172E8B9F;
	Wed, 20 Aug 2025 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEaJhjFy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602882E8B94
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755704648; cv=none; b=RUFrW1FggfuES8unL4DYNsInnu1YP1WHdlyuiUmgTmL7wDa54QAlY+fUnJzrMsg/y+mRLAA+61SlykOqsh3Uwopv1uYOq63sZyCFPd2mqbDQqUSQpdRphPAjZDkx0/fa64dgeBEPSd/5NaD7gMbISfDXirQ/ooisLDQzxcRdzWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755704648; c=relaxed/simple;
	bh=95yC15JbWppqU8jyo2fHbeAS3d+H0Gix7rRJptRWZtM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0a5GP9I7vgQZX88vV1w4UkIP4+hCimfjA3ngP3UDjj1kSUO7FdEY1lsirPaLDFd2UEyChZu7fwWiSmiV13qGqAtLN9b8gEZ8XRjfGHQUzn9Uv4N6DnSGRYw4RIqrjFUp7nsRwnDEJwEW1nmcmQQp7TkmsO79orGoPcMBLdHhFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DEaJhjFy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755704646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZTdOUMLElInOZa8jWVy+Dw5UJB8zui244DoqjKy0s0=;
	b=DEaJhjFytRLTt5SlAU2XsbnBX5zHHg3RWiA8lN5jqEyu+TWN21C/1TjiAvTYxRWz+HClqT
	jFbTISA1OtF4e5MEifQCOf7zmnQtFaazNidliPcnxidPIVL3n8SKrkjeh8AqKp9Vt3Sfwz
	3bpTyyyOzG8uWfwONnaSJJbf7AJAmDE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-RtDSB4LxPWqJXcDiD97_Rg-1; Wed, 20 Aug 2025 11:44:05 -0400
X-MC-Unique: RtDSB4LxPWqJXcDiD97_Rg-1
X-Mimecast-MFC-AGG-ID: RtDSB4LxPWqJXcDiD97_Rg_1755704644
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0c5377so30095345e9.3
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 08:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755704644; x=1756309444;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZTdOUMLElInOZa8jWVy+Dw5UJB8zui244DoqjKy0s0=;
        b=KHrHi3iLOtep9dqV3vPgNOYruzZ93tk/RoCiwoU81MqoXnp8MhbKT0qo7coIZR/usj
         1U5R/tpltSKGU2IcnjMZ2e7CtpK6u6w8/L0Kh/KqSHvPczcbQpbnxtopvJ5tUax4mJ/1
         EGw2l8jDKnOndEIyVzZTbiGKxFr/3kImE4CuyaKZk59ejNsQIbkvbjb3WwWQz9bqUuHa
         4zyrdcHUDDUGyw0raTQnHJATIApAFMIoHywF4HcEeR0T2FePTNwtd13ixEuF6gihdXcD
         B9WgsUOD3okceauOzflnkm8KoSTEIEbKSfbgolsXk16Z5aUBtN7eaBHibt1Exrcn1s2g
         bDkw==
X-Gm-Message-State: AOJu0YzQUB+GfDllL0Z50kBZSslNywuMsXDvqU1h5UuZLdoci7Y7zBIr
	Da0C/bey0N/9B5Y86GxSKwlR+eEZvM81tmjv3ZoVtH3D/a6FknG0Q712jcICwzHj/Av/9dS4hj2
	czSdmQQYK7ka0AkZbuiHISBDQOmodNLVrZMVZLXPL92gwb3X7vSle7fGosA==
X-Gm-Gg: ASbGnctpT5NXzJITe01D6f1Mgz3guA1sDfryVWe1dRKgnJcfyfjIggGlDyEIq+jGnEV
	9P0dkzcYqL45//RdXRqM3IWN6VVLfHnq4zhv4nB+TPGHhmMdqDub3K0ZqK2npHvcloZtACr50YL
	9LW/AG+e93a9pLeCfaiz4WvtN7KBQDp4ZTfFMATSwYRkvqFlvnS1SXY6wBaVZjI8poVJoD9rjku
	tF+OvemMfBazH98osMSBtkBQgnsBdsVHJutqWRqzXMF2Qqr+uVLNzzzqf0ZSTTtA2K4D6kEiKqA
	V0udKDeHxmylcGc9lD1CqYI5ssaYMOkzjb4SPZd4rJU+VN3Ak3WLIJjHExJ5+gHUn3hO
X-Received: by 2002:a05:600c:8b4b:b0:456:24aa:9586 with SMTP id 5b1f17b1804b1-45b479f7d79mr29730335e9.21.1755704643877;
        Wed, 20 Aug 2025 08:44:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQEQmzCV1NTmYWg14hpuYZBLWhYM2bdzJEG/AeqxOARbHWDkqg2ZXpbF4adP2mEM4l9ToKqA==
X-Received: by 2002:a05:600c:8b4b:b0:456:24aa:9586 with SMTP id 5b1f17b1804b1-45b479f7d79mr29730055e9.21.1755704643410;
        Wed, 20 Aug 2025 08:44:03 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47c90cc4sm41236355e9.16.2025.08.20.08.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 08:44:02 -0700 (PDT)
Date: Wed, 20 Aug 2025 17:44:01 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Florian Westphal <fw@strlen.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Cc: <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, <netfilter-devel@vger.kernel.org>,
 pablo@netfilter.org
Subject: Re: [PATCH net-next 5/6] netfilter: nft_set_pipapo: Store real
 pointer, adjust later.
Message-ID: <20250820174401.5addbfc1@elisabeth>
In-Reply-To: <20250820144738.24250-6-fw@strlen.de>
References: <20250820144738.24250-1-fw@strlen.de>
	<20250820144738.24250-6-fw@strlen.de>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 16:47:37 +0200
Florian Westphal <fw@strlen.de> wrote:

> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> The struct nft_pipapo_scratch is allocated, then aligned to the required
> alignment and difference (in bytes) is then saved in align_off. The
> aligned pointer is used later.
> While this works, it gets complicated with all the extra checks if
> all member before map are larger than the required alignment.
> 
> Instead of saving the aligned pointer, just save the returned pointer
> and align the map pointer in nft_pipapo_lookup() before using it. The
> alignment later on shouldn't be that expensive.

The cost of doing the alignment later was the very reason why I added
this whole dance in the first place though. Did you check packet
matching rates before and after this?

-- 
Stefano


