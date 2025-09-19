Return-Path: <netdev+bounces-224668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A11A1B87C2F
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 04:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D2B17032B
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 02:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EB625A343;
	Fri, 19 Sep 2025 02:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRLSHdFz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30CD2586FE
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 02:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758250612; cv=none; b=E/1pRCt3a//QN/YX8O4tJ9fpOthowpSQBvEX/T2q2psSfBIFHl3da4TWVLay2ILWjR0FwkHME3YnFqTZ0hZdF3N+1DsET5eBcBEQQQ2Tru0LAOR5W3iBNR2gkuMAPyBylKas++5qb5h1x4M5n29+M4goFIzLobMbMviIsv5UCGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758250612; c=relaxed/simple;
	bh=tqRDtHS5k1GrIcehlnQMe8j+zbuJ1arRBYLZ5MG6SuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKIiyVTWqhwmVKEQBJITkzHpUEmN1xnJHkfuW82Za3uHSPEXKAZjmLRnnguI7+E+GkzO2a5zjHSXKoFnwx9Atwr2b1POk2bGYcwpQaXUGCLzJP1Ky7Hs/QH4Gs/IOPlKqNXomSPeHsqU+NEYIaDk9jQSlvkseTo1R4hZivcTqoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRLSHdFz; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-ea5c77525c4so1449091276.1
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 19:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758250610; x=1758855410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qO6eabty1/dSjynDPSJipZBjWDXwhm/a+GVJlPdWL1w=;
        b=hRLSHdFzbG5q1ih2G4YG3BDmOoFQwYezM1uMVxEyAnKOecZ0tK8KJOkbt8lKqrNg5U
         gfs+My3DG7Mab2DxjyH3FjOdaz+BJUWtVKJ9mkB8t05/8hOGT7MrTus07ssWkrPfru8d
         Coe8OOAqEw7ffCDPxFNXmZ5tQs294zHGvOvTFAL/QzsycFcRk4BbunvOEqk4YKnDjuYs
         utNj3Pti3GxvH5Ne2623mvBWvke/oPEwCKKxlEZts8cOsbuElssYVDU1bcZfHOnLISQQ
         HCURYM1H8bf+zaUwvHtkOfIivmU9UrDNNvlVLhhvtv48EFn+jvRMONX7kx1hgved8qaE
         +QvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758250610; x=1758855410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qO6eabty1/dSjynDPSJipZBjWDXwhm/a+GVJlPdWL1w=;
        b=HBRpt7KMWQqanuOo6iMGqq6IkC4pHg0EiuDBdUqOqluoekn1bfsoUVPHgVQE4y07Ac
         sPXeT6Xf5UCtugjQypsIuKbAPHmzzw26lclgFIw9KUiaaigcbVHMT25hCBgZ/DZk63LT
         HUa/6QQHqgX3JyAdqTWfHirkMr4ashfY4EoLI9kIe2AiWN3DoXDNMfxjUSwrXtsoY0mG
         9zXLmzRwip6rybgufEIVAi73I5XXdonBq8pg+kVU26p2RpCbspAJuYky+hPfOWUVZ621
         +8lHI+HFu9zi88HE65mbuo3eIH0ubhfKIh7RORdj1PQFmYanoB+PPKIQlCpRmrovub1D
         Vwww==
X-Forwarded-Encrypted: i=1; AJvYcCVkTJSjSz6snRlF6TWkok+CRyfzX3u2wwkaTceqBJ0m7z87yRRCb3oOOxDNWbIxobQ3P6emla0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvx5YO6yROtpgnjnCuQkMQRMlrqfo7mhGj7xKr6Ac8wLVvxKM+
	tno0j7A/H/TBVP23AjcpW/tGZYpzHzaZVk23JMk8RlGTBYqpbjKZMUw7
X-Gm-Gg: ASbGncsXcrMQLbti1q7zvl/OiRYSZMzri+/lMwiJTacUaXfZFqDpL4NtIZl8bU6h8Ij
	OVzP2hJookN5vl6kUx2iF7BMdwktc0akBc6V/P4PTFTpZ/UyDgeWn11QEf8+SQ1ku92R1snvaz2
	zf2HaZEoSNrRUNLGPbvJNFKiNvHryWgOINjk7H2TCIMujx3H/63C7mgThGzjFu0ij16lPQXhkTP
	ydTqRrqWvFnMNxt21WQF11p4d7CK0dkMxvxT0sj6yBuZmjDOvTLCTJSDb8k+zqa5irXm12KyOKd
	IHbdnghU4tEyLHyWnqDbY4+yWibvJvane6dqLGi92yQlmZjx+NOXBJqttIrJBbm/tvdfNqccJWq
	XpJGjPj8cJC5ndEkHTBtMfRjnftNWoZGBOJLv01rlQw==
X-Google-Smtp-Source: AGHT+IFehA3xN/tMh9X208NCg7HmozISU6XaPbnU6X3wnRVZoD3aDuxzFTvKaV5O8c+4T3k3RmCSYQ==
X-Received: by 2002:a53:d88f:0:b0:604:3849:9bd1 with SMTP id 956f58d0204a3-6347f5f33d0mr1122776d50.17.1758250609606;
        Thu, 18 Sep 2025 19:56:49 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7397186acc0sm11546867b3.45.2025.09.18.19.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 19:56:49 -0700 (PDT)
Date: Thu, 18 Sep 2025 19:56:46 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Yaroslav Kolomiiets <yrk@meta.com>, James Clark <jjc@jclark.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/3] broadcom: report the supported flags for
 ancillary features
Message-ID: <aMzGbhXk4ae6JeFL@hoboy.vegasvil.org>
References: <20250918-jk-fix-bcm-phy-supported-flags-v1-0-747b60407c9c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918-jk-fix-bcm-phy-supported-flags-v1-0-747b60407c9c@intel.com>

On Thu, Sep 18, 2025 at 05:33:15PM -0700, Jacob Keller wrote:
> James Clark reported off list that the broadcom PHY PTP driver was
> incorrectly handling PTP_EXTTS_REQUEST and PTP_PEROUT_REQUEST ioctls since
> the conversion to the .supported_*_flags fields. This series fixes the
> driver to correctly report its flags through the .supported_perout_flags
> and .supported_extts_flags fields. It also contains an update to comment
> the behavior of the PTP_STRICT_FLAGS being always enabled for
> PTP_EXTTS_REQUEST2.
> 
> I plan to follow up this series with some improvements to the PTP
> documentation better explaining each flag and the expectation of the driver
> APIs.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

For series:

Acked-by: Richard Cochran <richardcochran@gmail.com>

