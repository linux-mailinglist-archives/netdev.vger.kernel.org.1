Return-Path: <netdev+bounces-243465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA1DCA1C78
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 23:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25C5F3005BBD
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 22:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D142DC357;
	Wed,  3 Dec 2025 22:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHc9kPzd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92122DAFD7
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 22:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764799893; cv=none; b=mGI6rUavFRWrsCwvBJRgS/cZhFUQpy2CjIMoKCT1dKmj7vIRrjKKUTG31+MJrObFbpdBYYlpbrMFvu3BfjJskk6LCQmykj2qIkH32b14nUN538RWg1hoRBbgo4Cny8s/eh8CkM7iccJO5MbjfyZm0/kZnEtPlnXobO4oHrUk4pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764799893; c=relaxed/simple;
	bh=XI+jxWA9VPp8iqvy+hxRuUYOaRu57YH+7Qc8NZ/K6Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZyfEZTQhyL0Mw5fqC9yB/dFs97xceQu196+5wDM97TXg9gcaA3N5hywPycjoJS8Zo6gGP8O70i7GG9qT12ATp2/ySt1TWl5ScA8cUdUL7qyrxOA3NMPrNDDT+48wH1ZJR8waXPASuM5ST6SmxB/le22RhDhtvx0vm7160ejGOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHc9kPzd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso1225245e9.2
        for <netdev@vger.kernel.org>; Wed, 03 Dec 2025 14:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764799890; x=1765404690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j30gxvcjzF3Z893VmbF7Qnn/jYc0/MzCVIS6JCRsvWM=;
        b=hHc9kPzdomNGlijbBkN7HQcTEASw8FM4S5t8REVMBFuhXNqn/mOVxYC6v3O5vS+Srl
         5x8HYPXu+y0JsstpQbUMwTDoYJpOtw7AR9LRVTmP0OfO53ADfSZa4ViYFPXVGywRMfhf
         FnsTccZoWt5vcwu9pWv7a9ylxbvXwVVSUmNp06hDKiqXJbCxS8FcHhJu1H25NuqFDQDr
         cRZ8j+1r8ETOC9y+LgjgLZJkc2ipFPVqk2pPNpAjoH4ITPdoibfe2OwRsrWRl25TnwvW
         SzrslTz9L0sqlv8K15iawdPmMdWSNb8djd+FWs3C2xUU6rtyg007sE3tTJeoHAn6Dq94
         pemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764799890; x=1765404690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j30gxvcjzF3Z893VmbF7Qnn/jYc0/MzCVIS6JCRsvWM=;
        b=ID3aMBuGKqEzX8rUWJzdDNZ8Nk7/yPcElLq1KeIdBNUK2UK2i0hNLnzsDKsPCZP9Bj
         2DBacJU2C/heWK8uWjRrrgLBX8XEKnKr9ZUWeD/o8vPirwaD+/eV4L1AvRoZpxquCoM3
         A2ewJCLYvR8EXUhdDgER71nROeJjKj/xPRGLtSZTz+t2XHB0/a3ia0OPqBOtsAk07UHb
         2cFrk9F8gqgtP37+N9JXuGipHYGGcOXAhUBSJ+qmmfBR6xGe4LE3WAohQpHVFmC4Q2RZ
         z6Isk1kXFEIXIC2AXXtgy6AlB8irUPXb5SCqn+BZTwVe6q7A06nfSi2lG+XKLvqaLBuv
         bTZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxoVthiRmBozLfsbn9r8axQ1T2YQhpTxqS99AerHSE2wysxh/JVH7vFZKTu3waLibojjmSCZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCTo9Bq54EAkHh7CROgeBIcPpY8GYckTFgHpUIlfXk9/fvinjl
	CxOLwTd9gv88WhsB+os0vHPAtaglglRIqSCU29aFI5hmEqYqRbO7JAOg
X-Gm-Gg: ASbGncu8pZajF7dYEkPIRbSsh8DJC590LOdm+2Gv9LGVfu+ClD+yEvW6PTc2IdhINgl
	uoolSy/I14IyHuU9+MZklKJTQIXa6VH9AFDf9SiJQfPklM/Qz7dYBvmNTxVCOYMwrG/rBVqfetG
	jDOce4zLdPjdfztEMgBPMxXDW0KFzLSA4Z+yh82XxeEA4bLQZCz7tWx28su/Wzk4oBh5qpWNhNG
	omk98SoQeSIJ5ROAg7aL36owhx3YxgcDQFZaYZZdimLIYCBaLmSG6v2k2WvPqaQl9DXddVE5kJd
	EFlp0YQu23Ka8RfqCRLlgDk9JTIHAPBfGDD89i43aYKrbW+WKOaY0I75BvFLmHJdyCW2nBzNPKI
	+2gBcD16pOR3V+Bgx7f3ZrIcU9WUYB/CaAyqc8acm8/kE0mi+mQ1A
X-Google-Smtp-Source: AGHT+IGqW5MR2lls1uRBOEGz41ieEUFkXl3YLtnRvwnllnwg+nmqwMOq7FZCXflhdwDOUiHAvUdJZg==
X-Received: by 2002:a05:600c:3b05:b0:477:7b16:5f88 with SMTP id 5b1f17b1804b1-4792aedeb45mr35768445e9.6.1764799890098;
        Wed, 03 Dec 2025 14:11:30 -0800 (PST)
Received: from google.com ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792a8c611esm67922185e9.9.2025.12.03.14.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 14:11:29 -0800 (PST)
Date: Wed, 3 Dec 2025 22:11:27 +0000
From: Fabio Baltieri <fabio.baltieri@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Michael Zimmermann <sigmaepsilon92@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] r8169: add support for RTL8127ATF
Message-ID: <aTC1jz5cTmsrQxwA@google.com>
References: <20251120195055.3127-1-fabio.baltieri@gmail.com>
 <f263daf0-70c2-46c2-af25-653ff3179cb0@gmail.com>
 <aSDLYiBftMR9ArUI@google.com>
 <b012587a-2c38-4597-9af9-3ba723ba6cba@gmail.com>
 <aSNVVoAOQHbleZFF@google.com>
 <0cacca03-6302-4e39-a807-06591bf787b1@gmail.com>
 <aSOgJ5VbluqPjV0l@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSOgJ5VbluqPjV0l@google.com>

On Mon, Nov 24, 2025 at 12:00:39AM +0000, Fabio Baltieri wrote:
> On Sun, Nov 23, 2025 at 11:54:41PM +0100, Heiner Kallweit wrote:
> > Thanks a lot for the valuable feedback!
> > I added the SDS PHY reset to the patch, and improved MAC EEE handling
> > in a second patch, incl. what you mentioned.
> > Patches should fully cover your use case now. Please give it a try.
> 
> Good stuff, applied both patches, link is stable and link detection
> works correctly.

Hey Heiner, were you planning on sending these out anytime soon? Just
wondering if there was a chance of them getting in this merge window,
though I guess you may want them to sit in net-next for a cycle.

Just curious, no pressure.

Cheers,
Fabio

