Return-Path: <netdev+bounces-185059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C14A986C0
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 12:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 505067AB4CA
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 10:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B517268C70;
	Wed, 23 Apr 2025 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXuB20eY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E03262FDC;
	Wed, 23 Apr 2025 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745402813; cv=none; b=Tm6wwGR0iSga68IsGh1dKdH93AvghSjHALdtiY0j6xIQgRm5BOnVF6qAHTVYNonKjEf88a/8xSZH4a871jg7ROAxXMk+zlRt4OfSPUJudfWCscwOKz89zymctqfxISwg/91t+SYrIKICFKgQg8jniJqMJQGPeHekiol6SMar1v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745402813; c=relaxed/simple;
	bh=p1aeHbezR6P+B0RDIv5XMNvfkOFMi7yR6BnbDSgQIIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpV5CSKPOA8i8IF0olkZrILDBvcVdzXtgFFCvaAqEmtNQ9iai6PVeLe0ymxKwJ97/CeaIs3xNcQ6LTsZBDDv/Qb1epD5V6JPcE7dfnCDDHBiGtZ0E8fkp2fHxRzf4iPFRZYgXJs9xnHTeqhvOQT5cKkWxeByc6kmsgg1mDYC1Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXuB20eY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf257158fso40384765e9.2;
        Wed, 23 Apr 2025 03:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745402810; x=1746007610; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yLF36sbTYK0KIWRbMmjLucJkeA+0T4TK0wNGl/x6x44=;
        b=WXuB20eYcF7y7bk/FutWfqCk6ikpxra8t5KT350eCGeS79nQivTMrTZdzZqldACbcr
         IWpahBelEfksxSKrmRx7MDUgxvS2yCNiv182NRlmwAXKSCzQq8kQLFJXG6vtdXB+hNwb
         0tFcoxrtXTSPsSgiyPGc28zatyFU37ZnPFuqgZ7jLx/RcDkuhpc8l9MkHP5eddfoiMqO
         J81zxyV4fdZOB8o5t4QALhexaJR4Htb+6XX7o/cqukym4Go7SiWrcxAKla51PJnU7NK0
         JzdGg8CpK6O6E5dPPiwR6crkxaHEVcOZ2COIe1I6x6V6VTmPl47H3fgzq57guqFGXX7/
         6NVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745402810; x=1746007610;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLF36sbTYK0KIWRbMmjLucJkeA+0T4TK0wNGl/x6x44=;
        b=fmrpvrItW8qDgUPU1mdsyRebGvVGuArghY8JyT16bOgqnr9TyaniTPRI7d6dFh6FtG
         Em3aN/bju05k/gBquhRvUoYcU18BduVhN/b2FU0WRYIC/MKIkmFe9Qo5thDKTAnzYoiw
         OZVl2Zx1ccTAZoQ1+u+aobL16JmAIrsoIApgG4OxWxvmBXQqZRrYNsl7oS2HhTf7QmpS
         gDXb2WDJhsLIcyUIvZZ1pJXAd/ewbu+CmeQ1VlbQAQDM/DMGEDlGjEH6QyLHRebQ8HZO
         czlTuI1v0pcOy1Xl9cWbdsTw7IPP1xhOQFSSIBzJYM8/IGvQiUBTqYJfM1wWxmC/k3Ry
         quLg==
X-Forwarded-Encrypted: i=1; AJvYcCW7j1bfyoBwpdpDDHoEVE5Ef/Y8loWDNYIJC87SuFW+pP/EkeorWQ5/rov8DsPtjfqwA8SMGQfx9dsDhoA=@vger.kernel.org, AJvYcCWCWLhv0CL3HMzWhSQ1dcxQWj7rz5+WEsWxXwUgqCCD4ewxwx8Vk3tmVll9HsZK2tTBK21EOwlr@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt1VizWY8UsY5KsMzU/shZBoFvuhkUS/QGFWhOJ+iU/dnZNfsg
	vuilGKSJ0JP0PMAJaNP4uml48mFxIrJuskHfHNRu8qXLhCzxxty1
X-Gm-Gg: ASbGnctmpSa/zY2KYOkKzQEmc2f19b6h59i9Nwi3m/Yb/ocZHuauPYBAeiKydSmwsSp
	PsbB9vYAISjDNgXwU5raT9s4Tski41SQ0S2RtHtQlE7QAm/tpkFDqEP5VA0bwf/2omr7WfTLz6s
	WV3+xYEK3qNX4jJBsNPwa4UEfr7YJ3bpdBCpsZTTRtc2X4vIsLXnIUTSdU8Kae6FUGRFY9xCXXg
	7r1wIdy3Wqfp84RQUePEOzyKQKlaa802yPsYXC/7wu9chyskZ6Izrfj7SrIhuMxkAHBx4d9QESW
	Uk6wYzm5L0HLjkVSslJ9cfOmgOkSwdREXkCuDVHTTg==
X-Google-Smtp-Source: AGHT+IHWK0WshXlOs5OraQgDN/FsgzhL7hkkmTvNLw7hrCUa5cxOfc9S10EHvHC0RFX+JdX2CVNVXQ==
X-Received: by 2002:a05:600c:3c91:b0:43c:f00b:d581 with SMTP id 5b1f17b1804b1-4406ac0fc21mr156671605e9.29.1745402809826;
        Wed, 23 Apr 2025 03:06:49 -0700 (PDT)
Received: from Red ([2a01:cb1d:898:ab00:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39efa43bef1sm17924994f8f.49.2025.04.23.03.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 03:06:49 -0700 (PDT)
Date: Wed, 23 Apr 2025 12:06:46 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Yixun Lan <dlan@gentoo.org>,
	Maxime Ripard <mripard@kernel.org>, netdev@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next] net: stmmac: sun8i: drop unneeded default
 syscon value
Message-ID: <aAi7tq-otdhJRpTy@Red>
References: <20250423095222.1517507-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250423095222.1517507-1-andre.przywara@arm.com>

Le Wed, Apr 23, 2025 at 10:52:22AM +0100, Andre Przywara a écrit :
> For some odd reason we are very picky about the value of the EMAC clock
> register from the syscon block, insisting on a certain reset value and
> only doing read-modify-write operations on that register, even though we
> pretty much know the register layout.
> This already led to a basically redundant variant entry for the H6, which
> only differs by that value. We will have the same situation with the new
> A523 SoC, which again is compatible to the A64, but has a different syscon
> reset value.
> 
> Drop any assumptions about that value, and set or clear the bits that we
> want to program, from scratch (starting with a value of 0). For the
> remove() implementation, we just turn on the POWERDOWN bit, and deselect
> the internal PHY, which mimics the existing code.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Hi,
> 
> if anyone can shed some light on why we had this value and its handling
> in the first place, I would be grateful. I don't really get its purpose,
> and especially the warning message about the reset value seems odd.
> I briefly tested this on A523, H3, H6, but would be glad to see more
> testing on this.
> 

Hello

The origin is me, when doing initial sun8i-emac I feared to miss something and so added some strict tests on its value.
Another goal was to detect half init from firmware/bootloader.

But I agree it is now useless.

I will send this patch on all my CI boards, so you will have extra test.

Acked-by: Corentin LABBE <clabbe.montjoie@gmail.com>

Thanks
Regards

