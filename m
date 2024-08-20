Return-Path: <netdev+bounces-120073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D7B95835C
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 11:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7F3285A97
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 09:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382A818C927;
	Tue, 20 Aug 2024 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/5wyE8S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD4F18C348;
	Tue, 20 Aug 2024 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147800; cv=none; b=RMaIZ4Iy/Qbp5uBt5bwYUvCjI1pz/89UG1dknOjYyHfuqPDMK6BEIR7fkFbDyF6cpKpwXZqOA0jP/05G35aXg18RqVPEU1+cWauG4FRT3uNSrGGMecDFK2cgMyICyo5Wy3qc02rhAAtnEUJAWy6GIIQNMzbhkAF1YQgjl7QpHnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147800; c=relaxed/simple;
	bh=a7twMUtRFY0MSBU8qzSf94QDny5wAuarNSPlg2DyCpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VReY7GqscxRKzg26ZEqwnjl8ct9c69HgXC6JlOW3cRAq9HhcFxGYfiKe/Yh2JjNOucJaIzqV98ZJ0xJPGUzqv1cR5QsziBkrQ25g+zBnBKqDhQmvAytPmzp4hTR4EsJG55SUXtswaExlMNozvPQLTxNT3ttLKiIjtOSgkqd/NPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/5wyE8S; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7d26c2297eso607552266b.2;
        Tue, 20 Aug 2024 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724147797; x=1724752597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c/NIrAB2SV5MwsEF/06Wpke0eOaZ94Do2IfzazTumNE=;
        b=Y/5wyE8SWseLNBG5UH5qxLYz1BISM8NXckqlAwPCfab9P7xI2t2/CKLhp9T72KLV9j
         FU681dihI4Xm5soKRHI0Kye31NbQriheVKGHvC7gCR1/g2Aieg17JfYeOPnjlAmx4Fq2
         ykr454nA8+OEZlKhsAEvIZfvRZa1gXCxPvXHiklHMRG6pGxyuslwAsAwxN/k1uS3S1OB
         MKJ23ty/RFqNobbWVxFGwKJgX/V29/ez4TZ7GJNZajWVhNvW7K9WZLrdSL59ar0L1pIV
         V/73FREhQWp71f/MXDyHgyb2da+KydFm39aUTUGBc2WML4jldDydu68DbstBf5gOrvSu
         eviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724147797; x=1724752597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/NIrAB2SV5MwsEF/06Wpke0eOaZ94Do2IfzazTumNE=;
        b=O9/BRRmNQxEpjPgRRKm4TTGQj4GPwNpjWNXyFiUifyPDg626a4hWCHU+zXW1kJ4lb7
         OgbM0bV2RCfmkTbJyHhAqp9q6MsFJft94hwQC59mb118sA09qUs0nsS0sdfwGUJa4OPa
         4jyUDYep2w/Th52s/YfTJ2dAlbMOy4RcJn9P2kga9L81MRwxHpj3w+vfV+o2fuAZ11sg
         ww3tM5yvP2ileNaaa4rqzTVRCY98nrtLdTlaUKiL0cKBEGI5JQ3txHKyStpJtR3Qznyw
         +jHHfj69G3LSzuVJUDA35kAXvttLXuCrcFxGIEk2cDGwMULVF1570ab9a9YPdp4roZMg
         URsg==
X-Forwarded-Encrypted: i=1; AJvYcCUYwHsDuzft+rUfw+QRgzHGYj2/tLw5kbg/3xM31g/2BDCYZ/qJSc9uqlEk5tTsYGeVJ8rUkUDr@vger.kernel.org, AJvYcCXpmwgmBdzMQBfRJ/iM4SYdsrAFdyzbMgUUTe0TpsaSXpndN4Dm0t1GNM0kCZUFdKkRzwwHSVhsxIH6QfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YziLxgD2mP8avosmN1sh31kcb8FOVLSwkIz2cN7CSBXlojOuFPY
	uAoB4gucwGOogwcLOZWqQXGHiIDUcTI4DeE509lW3VZkfIVT252m
X-Google-Smtp-Source: AGHT+IFWHx+VAD/A4mKL8+WTe1PuCUsQw6T0RzjJayT9ijFF56U9ZXHwSJnRiRbqZ6qYNlq9L9Dj6w==
X-Received: by 2002:a17:906:c147:b0:a80:d683:4d23 with SMTP id a640c23a62f3a-a8392a46e45mr964146466b.62.1724147796275;
        Tue, 20 Aug 2024 02:56:36 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839472basm746539166b.170.2024.08.20.02.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 02:56:35 -0700 (PDT)
Date: Tue, 20 Aug 2024 12:56:32 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com
Subject: Re: [PATCH net-next v4 2/7] net: stmmac: drop stmmac_fpe_handshake
Message-ID: <20240820095632.3y6dwjpt5sy3raq7@skbuf>
References: <cover.1724145786.git.0x1207@gmail.com>
 <cover.1724145786.git.0x1207@gmail.com>
 <4358074eebdfedf4d129ccce40434af5f6e2b3f9.1724145786.git.0x1207@gmail.com>
 <4358074eebdfedf4d129ccce40434af5f6e2b3f9.1724145786.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4358074eebdfedf4d129ccce40434af5f6e2b3f9.1724145786.git.0x1207@gmail.com>
 <4358074eebdfedf4d129ccce40434af5f6e2b3f9.1724145786.git.0x1207@gmail.com>

On Tue, Aug 20, 2024 at 05:38:30PM +0800, Furong Xu wrote:
> ethtool --set-mm can trigger FPE verification processe by calling

nitpick: process

> stmmac_fpe_send_mpacket, stmmac_fpe_handshake should be gone.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

