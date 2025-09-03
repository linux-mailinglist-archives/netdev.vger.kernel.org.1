Return-Path: <netdev+bounces-219590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A690B42222
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B242034E8
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD12309DB4;
	Wed,  3 Sep 2025 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/3uiMpX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10DD1F4C85;
	Wed,  3 Sep 2025 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906896; cv=none; b=jLV4iURsfC2mPTOfMJJ7YHIu/fOwETs4/zo+mOcckkbiOEOVuyuF+4wvoddzbX6yTCRiiNiVu5x6WrUpYZowBAYQk1aZM9lOqNUQUVmIriUQoUwfobGlcBh4uFWkvFjRKFcnhPjnexmwF+/1LHbUlHdXcLp2fAQTCzxP07r58D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906896; c=relaxed/simple;
	bh=LtSHdTfd+/QVVScrEVKfgAJRnBoREvz6o6zvp2ZWROY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPKUbq6ParmxzxelUABVJ4S/vsyFzj2ws8A6lZ615xek2gBggrvwKVbYgka+A7rKPouTEsVgzivOQgUqV69LLzj7hQL7PBVh3DH6Oio1FWjr+QUgGaDBsCeyYSSUcAXEpY+qGUoUun1EEbvXLS8p9mccw61b1IfueFs5rROcIt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/3uiMpX; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d71bcac45so54971057b3.0;
        Wed, 03 Sep 2025 06:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756906893; x=1757511693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LtSHdTfd+/QVVScrEVKfgAJRnBoREvz6o6zvp2ZWROY=;
        b=Q/3uiMpXhuI1oye00jXGo45ZQzuUiMXeHyWAw+ZOvlI4IoasR+1IJ/7g0HTbKC260h
         tAPp6gpBfp/clWyFsx6zAkD3B1051Cb1QzP0y/CQcjRacb03NoDDzZVF03HjdwUquDpA
         B/yA8SGlBMXsRZCunAC1Xzdx4QokP+LT2k48Fi1EDyb8CoaPkpH06aUdT57sYYF3FxbX
         /p5GqopnVjCnU8pjRBOSXTAAIeVLjeoHyysFb/QK28o7cJaArAuSlFQfxP7SRmV9mAsg
         r0H9bNFm/2Jc2W2EJq90RCzEdpsny1234ezE7JfCuOlkzpnnGM9qndwcpFyur/gXoMRu
         5PcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756906893; x=1757511693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtSHdTfd+/QVVScrEVKfgAJRnBoREvz6o6zvp2ZWROY=;
        b=RRGl3GNnyJtph6O7a2kty5n1ca5Oq8TN9iPcYvBfuh+1K3xfpNIbsTPKLRdIFPWwvX
         SmYp96YvLaQH/1K472A3M7S0xWrf3kiChLqnV71n2XZFW/qmRNSNzfo6LARIKGkQn0k2
         uszFy5ERsN60VXVo3LjTX7WkrtXqwbISqlw9GPlWMXM9hpkthzkeklVFbJW7UhZBFDoN
         XTGHzGtMdn+K9yfFip6HcwwifY1jXE94sefThGF1/OQ7gA008bXNwi400nCbsurbyTgw
         n46qvCe8IDVsMgsCfdeDmiEetSNd3JL4MV4MZMuitkePs/P+kpICRCnUaBEdn3b6ihtX
         8obg==
X-Forwarded-Encrypted: i=1; AJvYcCWaiHmaA8BpQAVznfNu4Leq5i1Fw8CdEMOy1U40RWur20LqruZBo2dly0K6K11LwuxAVRqDE+3Ut6DtpI8=@vger.kernel.org, AJvYcCXLMAhvZdofcSJnQtHPdfpi+XoGJOwl437T5v0n70HcyGDVb4gi9dkrCuw2BNhJxazrw5prn80v@vger.kernel.org
X-Gm-Message-State: AOJu0YwxTwNHLJFR6WmmlIBut927K70zfNYYcB3yqR0mQUfPRGZN/jAx
	URoLHnaQxCip4eCYyhPk/WeeHNX6HP7l6m9rfQTvW7oGATqz+65PI3nNuFvXOA==
X-Gm-Gg: ASbGnct8WTUs4vrVBGkS5WeY31AiH+BmOgVHabVdy6FIvUqModjteJDXhqLYK/J8JeT
	+4UN7Dc89bSnKNWbsHFONRUXAq7/CdxhfP4ZSntkCwBOjCGDwAe0xYbX95l0MSt8vwW7GT0LbVn
	W9WLiNUynujrH71ix7ov0fLln4VD47b4XMof/twTGAcj9MIGH5ZJknA2Mw2+vqWr5Twumv0S/4r
	pq21/8NcwE6HehoG8CTYtw+EVGVna37w0jQhwh30zbh4x/mXHWtZYyxsFrmlwnbb5TUWhEq6Zja
	b0Ab0bWTR60xsh/WpTYlwmeknaDdt5OO7v0xD+RMONQIgtrBDvagcz8N7xwxYP4RS1yZaTm4ChK
	rb6tqWa5EpKMZybyqCjYwuMj6mXqyZP7y8qmChhncdKdl8K0iRa/l
X-Google-Smtp-Source: AGHT+IGnjHsAyQljYLZz2UQHy207mYMU6/HFTBywuxhNBv3nxCgO5MpvlVh0qFbK1/Zdh77rKiaXnQ==
X-Received: by 2002:a05:690c:4911:b0:71f:e430:666b with SMTP id 00721157ae682-722764acba5mr157076777b3.32.1756906893562;
        Wed, 03 Sep 2025 06:41:33 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a8329a4dsm13556527b3.22.2025.09.03.06.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 06:41:33 -0700 (PDT)
Date: Wed, 3 Sep 2025 06:41:30 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, Frank.Li@nxp.com, yangbo.lu@nxp.com,
	christophe.leroy@csgroup.eu, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH net-next 0/3] ptp: add pulse signal loopback support for
 debugging
Message-ID: <aLhFiqHoUnsBAVR7@hoboy.vegasvil.org>
References: <20250903083749.1388583-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903083749.1388583-1-wei.fang@nxp.com>

On Wed, Sep 03, 2025 at 04:37:46PM +0800, Wei Fang wrote:
> Some PTP devices support looping back the periodic pulse signal for
> debugging,

What kinds of debugs can be resolved by this loopback feature?

It seems pointless to me...

Thanks,
Richard

