Return-Path: <netdev+bounces-137487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F06349A6AF9
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4612847A7
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 13:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE731F1301;
	Mon, 21 Oct 2024 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SM/1J1Xq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D071DC04C;
	Mon, 21 Oct 2024 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518607; cv=none; b=ir4GB8nV3MXWftL71c+SFqJWCuaGZm9Td5+w/lucic+mXP4jJcltEtotflY3ZAux8atnHktrQN8ZG9t/iPlW1BTts9U/bXBqHecVnq354nHZCaXNQ2C+KlA5bcb9H7jaJONSoOikQiR4yfUYM/A5oA40WxjxZOYiGLJLKrZTec8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518607; c=relaxed/simple;
	bh=KtprUJLXkjuzcGdoL/QA73UOT8briZQ69IS5tC6po2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHlwTysnRHOLdK5hRO3YlJr7qFi4bZjk2eED9F/vDol4Vlj74517ZbH4mSvkm3DfOcajHktzbU68Y4JuST7Tf2KAP0ywmc53W6LReWk158MrUC9FbAGYQvVsSt2gFgo5/9eQ/101ZFAGEogUFZpPgUMWlY9hgTCP97cnDyQkvvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SM/1J1Xq; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a68480e3eso38993066b.1;
        Mon, 21 Oct 2024 06:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729518604; x=1730123404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xvZACKQE5A63kgrvXCHxaARVoSrgC3Hgpn7T6LENiug=;
        b=SM/1J1XqvtyC7BlhgZGc81QbYYXwv5gl2buh4SwiEWUFMt85wvq1Tky70mAhH8aI7o
         AwQPV54a+chnZnbcUbsv3tCxiUtMXcFkt5foORtf14+ZdOVjRYDb+adeIVBxjfgOC7Wy
         7sB/FWfF4gpmWhj9lQQgwejWwFjiAy1QRGF3BQ7y3USNIraR+C5gEQbY/FUJNK1F+AHo
         UrrrPqV6V/k4m1BMMwZ6TShGlJbNVgTDZy+7ZlyrQddrXnGYdxomntzaP9srEY2mjGyg
         Hpgzme6u1O0P/8kJlXucqO94oXxTi1VGnNUOD4AZIbAMpn+pJf7L0LmCzg8r0ciqGRxq
         3WJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729518604; x=1730123404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvZACKQE5A63kgrvXCHxaARVoSrgC3Hgpn7T6LENiug=;
        b=WFjzgnfDqONMPtQV8dF5YFIBwG/xPOni1YRrvuTgV5+XMMoX8qYHN6dpzWtElFHiCp
         mHRkNipkgW0O6sHSQJI/Re8+cpIdEK4ExqtySNwVwiziqgyCxrwYFCgglUXbPYF6D6H3
         wgTcxp7zE1raroQUC1RcinS3uRVftYva4/KZJTYwC9q5rp4cF75dCpCDX1KjH0FR36Y6
         L292/OYv1WJ6ro3x4iLtjxVc807+dl3/ZcdbQz7BhiYxMimBYP47CybI6NdRF+mSXUja
         ClGqoNF5D+CcMNfejI6htwlk4Tr7rgOVN4T5NFjxwb0CW8SdQv9sa+BaQGxlCCu/e3/5
         v84A==
X-Forwarded-Encrypted: i=1; AJvYcCULYTk8ZnqUwZq1IbuRdUit9IXUKtp53GpixG045uIG2qvsg/czLsl/giPurgsaq5J9xkBUuu6eeTwj@vger.kernel.org, AJvYcCUQOTl/jBARKzNzrrinAwWCWNPhq3z7Vcg4sybRnJ2IbNViB4naWAFrrME+qZ2TNvopxbtBW2xmNp/zuL3P@vger.kernel.org, AJvYcCVaAezqflFHRFQ636PdPKB4rvYDVAVF1uJ4CkPliXg4Tsexj6ICg8IlPMAyfDbW3yX+xwAKRLDw@vger.kernel.org
X-Gm-Message-State: AOJu0YyKlNIGPJyUxYaiBp6FBbuk7Nx8OJouKTjMjVAcFSQQSyDH667q
	iuNfKUADEbpzyGok9ty9gx8ATFNb4PgYVR1r0VdJ94qtfwh//AFl
X-Google-Smtp-Source: AGHT+IFkvdi1xXb440X3ZM1lEN+rP4lRDSyWGbbS/gXXJfBpY4FWgfR+FUuyyXY5eiShRJa3bmU8Tg==
X-Received: by 2002:a17:906:7951:b0:a9a:6700:1ee5 with SMTP id a640c23a62f3a-a9a69a7b2efmr420841666b.5.1729518603659;
        Mon, 21 Oct 2024 06:50:03 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9137060fsm205673366b.103.2024.10.21.06.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:50:03 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:50:00 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH 0/4] net: dsa: Add Airoha AN8855 support
Message-ID: <20241021135000.ygele6x64xvfzntl@skbuf>
References: <20241021130209.15660-1-ansuelsmth@gmail.com>
 <20241021133605.yavvlsgp2yikeep4@skbuf>
 <67165992.df0a0220.170dc.b117@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67165992.df0a0220.170dc.b117@mx.google.com>

On Mon, Oct 21, 2024 at 03:39:26PM +0200, Christian Marangi wrote:
> On Mon, Oct 21, 2024 at 04:36:05PM +0300, Vladimir Oltean wrote:
> > On Mon, Oct 21, 2024 at 03:01:55PM +0200, Christian Marangi wrote:
> > > It's conceptually similar to mediatek switch but register and bits
> > > are different.
> > 
> > Is it impractical to use struct regmap_field to abstract those
> > differences away and reuse the mt7530 driver's control flow? What is the
> > relationship between the Airoha and Mediatek IP anyway? The mt7530
> > maintainers should also be consulted w.r.t. whether code sharing is in
> > the common interest (I copied them).
> 
> Some logic are similar for ATU or VLAN handling but then they added bits
> in the middle of the register and moved some in other place.
> 
> Happy of being contradicted but from what I checked adapting the mtk
> code would introduce lots of condition and wrapper and I feel it would
> be actually worse than keeping the 2 codebase alone.
> 
> Would love some help by mt7530 to catch some very common case.

As long as the control flow is reasonably similar, the REG_FIELD() macro
is able to deal with register fields which have moved from one place to
another between hardware variants.

