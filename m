Return-Path: <netdev+bounces-106365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C432915FC9
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 09:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A2C1F22C3A
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 07:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A05146A98;
	Tue, 25 Jun 2024 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKYtymj+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48F6144312;
	Tue, 25 Jun 2024 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299716; cv=none; b=Y1mQ6NviKTMxlhRuzRHuQqncIeGOHunJsG2eFFKvYeWZSawgWQ2bm7W5Ex6GQaY2dDOf87eGz9lv4KqLrRuHh6aWmSRiE6fSl+c1YOv1QiaZbUrVjqyF5R8x/uT3Zq4jGnhT4W2eC3lZFwii0EOQqwtW1+MLUWAQLvIg4R9M2gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299716; c=relaxed/simple;
	bh=ldH74kf1TVm9pXlxKP+Hotg4oim3Y9gMDH1tkw50CeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a32yf1DxLHmsCyEdupBgbQgumTdz2oH4ynpOZOnFR40IH3RaMN5j21pSmUf8LZ2GkSFg5pXqnxwNJ4q+BmQ87UnnlrqmcM52f8hALlc/NBl+l1HjG3/5l52pY0k5mBBqVYD7zIiS5JGTd2EXhaCK/bQCFqyYEPGTADZTRpR03g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKYtymj+; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3608e6d14b6so3464175f8f.0;
        Tue, 25 Jun 2024 00:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719299713; x=1719904513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JySqkATRPlYLkNhd+lYESHv1lkNC/LIuMH3yqfbsSJ0=;
        b=VKYtymj+5Dze+em8Wpa6EX2i447iNQiiCWWYyKEzt+ndVlrB/DuvbaWMFPX/VOP6j8
         sl2pki5lTjnfdAi8BNaM8rR9561NMfs/F79C8BhEETM/iyoE0pDvE9KF5fUkVO0G6RIh
         OjidP6R1sv5Y89J5YwXGAiY8kOWhAK5W0Cdh85Z1guP6BSK1kUi73943T59HALrx272X
         ZYDkQom+2XZAkPmmMVexycKQT4L6rXNtlyVDMSDuwd14sw8nQGjFgHQX+RK2QsOUgl84
         ZkMEES1HWXb4HLeoDxlxNZIpgErxPmyPoMY3JQjoH8vkmLIvAPRlD0sixouN4fPbUA/T
         DeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719299713; x=1719904513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JySqkATRPlYLkNhd+lYESHv1lkNC/LIuMH3yqfbsSJ0=;
        b=cMsTt2YsZ/wbiHDbt88YsFao26Rp0ZDoAoGtQEEUzkTEHfZ+4s8dXrzSdbKz0B/Oc9
         yRoqiRqDL+zd7R2+lE0Yct4RgrFxYGdII+6hrbq8zLTop+SdyDx/pkPdeCX24s9htRoW
         ElPbyAKhU+YfsKgLbw3UVLMEPQnDr5Ew6iZModnqmDBNsZBt+WaHfYz4NpdcXfnlcFgB
         Oxrb8laSpnEfQBHiNsy7Tc2vsAcoWhhfX+OvNUa4dydKdWE3/iDzCb8Qd+ES2L9fhnGR
         QDMli0Dj+R9eKznF5bYG7ubjiTv28HA1cw3xK38ag4JPZ23FR4Nga2dRhcbFfzhTaw5r
         BRsw==
X-Forwarded-Encrypted: i=1; AJvYcCVROI5RkRsJG3k+R0wvjXo1U66OkaC3GcuR/8QBZi2LvBCs/8m0lD+GUDYgeSAuEIIeOnEgw79Z0/sQroUaz8XCJTZLciuyq70+L413VHQPDAkR3eOmTE1EvmFTh+8W019uT93/oIMXzdhzqxeRamcIwYFAekTFnLkMoNemyrW+hg==
X-Gm-Message-State: AOJu0Yyqj5r5HX5nI02JiUCT6Xyx/6Kidkwx3nURJPmeWmbaK5cH/cRT
	rJH2IU6ppIGKjZsuMxRxRn0Ee3iuIsnispEuTRK9PesvjcukFyYW
X-Google-Smtp-Source: AGHT+IEEbVK4uKqf4sQIA/jL4J3G03Si2HpSOHfkFWkWR7fwfWJ3/XR56egnedWU+oaQoTsc42xjlQ==
X-Received: by 2002:adf:e649:0:b0:35f:119a:14c7 with SMTP id ffacd0b85a97d-366e965ff49mr4161102f8f.69.1719299712727;
        Tue, 25 Jun 2024 00:15:12 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663ada128dsm12110656f8f.117.2024.06.25.00.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:15:11 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:15:09 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v2] dt-bindings: net: dsa: mediatek,mt7530: Minor wording
 fixes
Message-ID: <20240625071509.pwo4qmnvlf4ooqez@skbuf>
References: <20240624211858.1990601-1-chris.packham@alliedtelesis.co.nz>
 <20240624211858.1990601-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624211858.1990601-1-chris.packham@alliedtelesis.co.nz>
 <20240624211858.1990601-1-chris.packham@alliedtelesis.co.nz>

On Tue, Jun 25, 2024 at 09:18:57AM +1200, Chris Packham wrote:
> Update the mt7530 binding with some minor updates that make the document
> easier to read.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

