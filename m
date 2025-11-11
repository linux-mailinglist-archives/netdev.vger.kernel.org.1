Return-Path: <netdev+bounces-237593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D26C4D8CE
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 13:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A07918919A6
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D195357721;
	Tue, 11 Nov 2025 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Giy6O0F9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596CA2DC77F
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862204; cv=none; b=HdvQN67DjJLW7u0mRdwfNLBkKBiqFOCTds52NKSleCCamWExS2uZFrdgojVGXwr+QiM3u7rLrpDS6wycVfU4sW3NKnSH9N6WlykMP1E/aRe8RczQcYWu+vDVOfxAKCNrrWA8j4RbVn0LqCvmsbnCm0NI7mhw3oohluTe7SSpDfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862204; c=relaxed/simple;
	bh=7cpCvyszEn5HOezxZLBqqcsmZ2uT7ZtZtkiuIpkUXg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkMmSOFZzQAqxgl9By1U+iw6qY+SQv741sjdt18ZjeD7w01qk4gX9U1SgLdgAndeWXsaDSz7ygQq0hu3HfVSedEdOGypKSzQ9Zjmj8xZX1KZXxU2xuKsI5F4AF8bn8J4CgCp4xAXhrtrDUyWOj4uwm+NeqM/SIFyCRHypm3KqTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Giy6O0F9; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b305881a1so312006f8f.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 03:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762862191; x=1763466991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CJgHQCcCAAMF/dux7/grV0vztHoMiGEbVl3yeix1xGI=;
        b=Giy6O0F98hm+bOKubD841CwYNu7joAPoUqyh55X85IVsqkQvraqRcWzFr24lNHUgyO
         wvnfQXZOvtwURhzwQopBbB0D8NqI0DZlMiHVaerEuZBWABDvaEHf/z6o35jEwblBVUCQ
         +7PTDy8qOBbTFgFX/C4VCcfiU6QV58uyiIAPXNI4G//yT8FRYnGhMSHQSEjDAgGUOW7x
         5HtqCVENpciSPf3UETxkf9PfTniWDpsrQ5TPlPbQlOvtCwcbNRsI5v7oaCX+gjys97kO
         sHDUBl0v1+ulaAoTxkpajUAL++4aLvoiPs8crcpuNyVG+ccC0YEnfUEiQrJOi+n9ti23
         UfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762862191; x=1763466991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJgHQCcCAAMF/dux7/grV0vztHoMiGEbVl3yeix1xGI=;
        b=cBVCgw/v50aq5c3o4Uee+oNV+JET2u2uZuIKdZe9R08xcmAB+/9a7M6EeUHYzYkKLy
         f764qYdgVRQBibaNH268hMppBZYklY+dtBpkmszwWhRxB9LITIHuSR6sxm4xhTmHRm8L
         9o3Nh3oHsD7BjdMjLYsflDVMtpgpXeffaj2v/waZlAH+DS1OEt/OjvlG3fbhzSN4JvXj
         3OrqbSQqBZWVWLVUvTn6biYXleiShpvKnVkipD0HQp1CbrKgTlH/6Yv12Uya7mYKwA3k
         +qBWAUL1Po9uYZ9464/Ha1BWJDmPyk77Nyd1aF7aJZrlnmdF3Tx59uPGoYV14cyTA5rI
         S4gw==
X-Forwarded-Encrypted: i=1; AJvYcCXCIf7Vkj69yvVlxhdsnqhNibEoFm6+1fjShHgzNnug23NiDN383B8SrdvMa4/2Cn+jFC6Mmt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+WX5kWmkPfOkMRH4JUOuOZvBuFX1neu2n4h5kxLQRgyP9G0Tr
	gX45vQr33kED7RF2+zihJ1r2yJcfUZ02bmqpNNhQbfQ4pEDudlyNTDbM
X-Gm-Gg: ASbGncssC+rj/HLEOFYFg08UxI/XpOKDvh8027xKP8MPsQP9zxpU1KiloDVt2RMmw+l
	Dp1dKt3LLSxPNcEP3gQlh3jUNqsWM04ENZmzYz5+FoUhHt6Sx35B2iZQsSEEi5mQk++TzNFSfV3
	8dfzSUVrX98tuAPxwexJr3OSK4L95iWgkFw8v2HZkHaNyGW8pSEyBA35wRGBr0wRVC1F+NMJSIC
	NBpXSRjQ9tEUCDF4xBSE8QSDRzHK4NZWOCyytpn4RA7mQFLwFExy90Ryn83QS0w18QHX7tmTW4e
	5pXQaCz65BmjhQEi3b7O6QHSYO+mw5vqZ9AZTGo8l1QUBI8k/psNdeQHm8llgmCF7EtT67s7825
	U3YtYVtq3i7fqHgaeO0jDwA0dYgk84cKghKGMO+vi6pBtBpiaqRYzHF9FyKeolHOAcN8cMFUTkn
	fcTdU=
X-Google-Smtp-Source: AGHT+IEvZuLBPX6umhXQeZ0Rv/NcKeiOMHYrfxaoqE4DsQaZb5ViZ0h12lREx2bg/R/5zR++qTxTlQ==
X-Received: by 2002:a05:600c:4711:b0:475:d7b8:8505 with SMTP id 5b1f17b1804b1-4777329f181mr60253945e9.7.1762862190504;
        Tue, 11 Nov 2025 03:56:30 -0800 (PST)
Received: from skbuf ([2a02:2f04:d104:5e00:40fe:dea4:2692:5340])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdc33c8sm364910025e9.2.2025.11.11.03.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 03:56:29 -0800 (PST)
Date: Tue, 11 Nov 2025 13:56:27 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 3/3] net: dsa: deny 8021q uppers on vlan
 unaware bridged ports
Message-ID: <20251111115627.orks445s5o2adkbu@skbuf>
References: <20251110214443.342103-1-jonas.gorski@gmail.com>
 <20251110214443.342103-4-jonas.gorski@gmail.com>
 <20251110222501.bghtbydtokuofwlr@skbuf>
 <CAOiHx=k8q7Zyr5CEJ_emKYLRV9SOXPjrrXYkUKs6=MbF_Autxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx=k8q7Zyr5CEJ_emKYLRV9SOXPjrrXYkUKs6=MbF_Autxw@mail.gmail.com>

On Tue, Nov 11, 2025 at 11:06:48AM +0100, Jonas Gorski wrote:
> But I noticed while testing that apparently b53 in filtering=0 mode
> does not forward any tagged traffic (and I think I know why ...).
> 
> Is there a way to ask for a replay of the fdb (static) entries? To fix
> this for older switches, we need to disable 802.1q mode, but this also
> switches the ARL from IVL to SVL, which changes the hashing, and would
> break any existing entries. So we need to flush the ARL before
> toggling 802.1q mode, and then reprogram any static entries.

I'm not clear on what happens. "Broken" FDB entries in the incorrect
bridge vlan_filtering mode sounds like normal behaviour (FDB entries
with VID=0 while vlan_filtering=1, or FDB entries with VID!=0 while
vlan_filtering=0). They should just sit idle in the ARL until the VLAN
filtering mode makes them active.

