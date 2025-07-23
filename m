Return-Path: <netdev+bounces-209388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A22BB0F70C
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED105809AB
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63621F5827;
	Wed, 23 Jul 2025 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKo2O0zu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705401E8324;
	Wed, 23 Jul 2025 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284607; cv=none; b=bd56DHHK56PsHuOGgsTqsRl1Tpgysrwm+bKwRbKNpvko+D0pnmihcwjcLfTFph4itQUIWihiz13tZ7HNkCc1ulqCmH3whdQ7BBlcrF6bS6kr3VLmV6hj6ZbY4hmVDAdaTn9OF0gMT6BDpe8oFc95TOoc4ck+x/v6kINSTl+7Lqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284607; c=relaxed/simple;
	bh=YE3uNRDI5S8fm0jmGk54vSek+0Ek8jLfojYmWBaxReY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRyawCdv186Qz50F7sZUhXGFpxQ1/kpyihIHL1MhX6Y+SXhJBg3TuBY5wEa/G/1HHOWlyF6b17LdXNTz04DdzO/iAN4fiXmdYUI78FXj9aUnSMcYNyKf8rWXBt9lkrlvb1Bt4Vyayrzhhjuo4JPePoWI3sKpS1aAzJgWhjtbPrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKo2O0zu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-234b440afa7so63414895ad.0;
        Wed, 23 Jul 2025 08:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753284606; x=1753889406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VlMz2/tTPFsG8As+bZqbz0VVzkqHQrHWWZOCUP7dezQ=;
        b=bKo2O0zuoU8+If/fU0+A/hH208KZZ47FRoZl93h8D+sMwXpG21cLewCax0JnmFn2Kj
         fDwIGUaqaL2IS8wWGzg3M5OMMr231avAExVNrtsCSFQNN5q3c/TAjbR04MtzCO1mPLIx
         NkNKoqHc7sdidw20J7VORlX5YcwMKK9tpuLmK8LNUBhITiFQdotG51dMYDPYCO3Owie7
         p54byuVXA/pnd+l5E7hLso4c9nGVOejBSpVIJL9QQx33HnSs+f+PcVSHqotP3EjE3OQr
         4HTAVrEAV1tdgxg+DcG3/4RleXMAAju7f8pSwet3pEQD8F1PEobCzyWeYJpdZua4fiDv
         c5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753284606; x=1753889406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlMz2/tTPFsG8As+bZqbz0VVzkqHQrHWWZOCUP7dezQ=;
        b=G2ZtHSW5PEbjtXvJO/TjytDTxztrqYH9E/awsQ2YyWDTjgeGkWtv3tS3Hr16OL+lVy
         8WKpuQ0lsiijylAM8Vh39hTxTKG2A4TJwnYNfz85A60ASCCIzHkLUXx9DEfPLTvKdaEE
         pFjGXuquzZePmmcREM3yEGC7Tjbj9J1KBdGs6Pen8J6MQ8dZj+QfSJWDs7Q1wO8ySVx7
         Zl1P4TFvu1SNIcpoGR/JfmNDfLStjH3JZKLhz2mCPNefds+0dLhOCa/51XLfZKd2u0FP
         iyH4nbV/RgbnCuRcTk9FwUDiWk4Qb5BIh00FlNRZ2psbgdw2LmkwyK1mBgb68lWsd295
         JMQw==
X-Forwarded-Encrypted: i=1; AJvYcCW/PjHg6ttp6/oIR++8S32YpIY/XXniLdJhhIFd7uCoOQSrk4pHUgE4JjVuAYhV4qj+eJipK3a7KiMElg4=@vger.kernel.org, AJvYcCXOoE702bAYSlbU916ZDrWCf0Pir3btCRofBTHNuhhFDDWhWakIPquMluffcqM5i6YP0m89up03@vger.kernel.org
X-Gm-Message-State: AOJu0YzQEq5V5LNv52UzuwSwkROq3Ew5hP/Lsr8XiihC/LQR1AlncU1y
	/Zy+DGOmYkDup/fhWgl/amyEnYMPes9NNJ4VMpcGK/slI20ktp2xGRU=
X-Gm-Gg: ASbGncsL7IV3ZfCvpDqC/kKiZC1GPIFzrnebal7NKpuB2nkvcWChRrz4ClqvBI9zEQj
	xvruxjtPWBoDJ7WmUXvS5wk/Gr0rdYaY8HN/CKnQyk5D204vczO4NRExJADzUncIDrJ6ev9bNVM
	h+y8ssKP+JU4ea17X/OwlLcx4EsDgIDBg/KYRWI19YgxjKonWplakBFsIcFkRJaWNEkgyEV8Tol
	9FMfTYQkfVxJCI2UEjBLg5Mysv8Tt862qVWsWwQTKCJrGRCdGX8/9vhSY9/G8JyZGrXTY04iiej
	2989HIoTCrzJ0mnMIKlYkOki1DXZeOaeadSDfXOJF2i8ONlJFBs4ofy9CHiPgkJe4VTdPOGHEsf
	LwoqKXOnlIOBusZkLoh6FxEa+d+1xz9WY5SQMbs9oPtg6JD3KnOfA72OUWxtg78O3FkRE5w==
X-Google-Smtp-Source: AGHT+IGlmkjVkRy2fyxX0cvy9lBsGJ3/JHZFcxGI03r10FEwuKm9lMvYYaVvLOt04g9NXTqCXmjVrQ==
X-Received: by 2002:a17:902:dacd:b0:23d:ce98:6110 with SMTP id d9443c01a7336-23f9812c147mr56965895ad.10.1753284605516;
        Wed, 23 Jul 2025 08:30:05 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23e3b6ef26esm99032005ad.193.2025.07.23.08.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 08:30:05 -0700 (PDT)
Date: Wed, 23 Jul 2025 08:30:04 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: Warn when overriding referenced dst entry
Message-ID: <aID__G3iKZqsY-yE@mini-arch>
References: <20250722210256.143208-1-sdf@fomichev.me>
 <20250722210256.143208-2-sdf@fomichev.me>
 <20250722190014.32f00bbb@kernel.org>
 <aID8FaYlyuVjeOH_@mini-arch>
 <20250723082407.06686876@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250723082407.06686876@kernel.org>

On 07/23, Jakub Kicinski wrote:
> On Wed, 23 Jul 2025 08:13:25 -0700 Stanislav Fomichev wrote:
> > > > +{
> > > > +	DEBUG_NET_WARN_ON_ONCE(skb_dst(skb) &&
> > > > +			       !(skb->_skb_refdst & SKB_DST_NOREF));  
> > > 
> > > Why not 
> > > 
> > > 	DEBUG_NET_WARN_ON_ONCE(skb->_skb_refdst & SKB_DST_PTRMASK);
> > > 
> > > ?  
> > 
> > That's more precise, agreed!
> 
> Just to be clear -- looks like I ate the
> 
>   !(skb->_skb_refdst & SKB_DST_NOREF)
> 
> part part of the condition. I think we still want that.

Ah, so you only want to get rid of those WARN_ONs in skb_dst, makes
sense.

