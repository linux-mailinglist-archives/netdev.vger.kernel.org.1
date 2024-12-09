Return-Path: <netdev+bounces-150414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B07F29EA2A1
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 00:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46EFF1883150
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 23:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEB51F63EC;
	Mon,  9 Dec 2024 23:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8x6yzg2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C7C19E804;
	Mon,  9 Dec 2024 23:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733786588; cv=none; b=XAWBnWJ+lAOqZlz3K2yQ6PyCMU5Nj4M8+Kh+ADoUDiQhvrmWIahCRBXjtPJGRnlq5EKPfSn1r31BQQJ/XdUWMcSgD8uL6M/b8J6/hLOMEwCFJpaYPEZYca3XobpOETVIzd1mwvTqzCkFY5q/P6l2fZJuNmdhdqg+fET/QFfTfBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733786588; c=relaxed/simple;
	bh=kpFYJJJ70DDJ8yFSVSmnAXuzqPSJ7Afwtyt9UesIfmo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBeHEu5wQCiA/RKbGz8GxoBPiXe/tkRe6i2+36HakrCdCm3vQabGwf1RuKcYTwfXPtKw0fv1oLqW37+beDkUArSvRqVDn3SKKTcIVfCo4i5fHuzecJ3AzFS7DU0YzZnrcPr1SGnQjdWeQDDuFD1CtnfeKep+efektcvjW/Ao3uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8x6yzg2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3862b364538so2029234f8f.1;
        Mon, 09 Dec 2024 15:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733786585; x=1734391385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4za+GSZXfXk9ejvCCCE1cqr2r2pNcy2eq/BH59GGowU=;
        b=A8x6yzg23gfXkMQJUgq+FWWCPvsqYpQwuDDMSZMeJEpGYswN/XsSq16V5r2ucdrPiD
         3z4IC1dehEAJoUp+Qq+NWXypeqFWd9SWuZIzwCewV0II2dnuqfnVZ3SS+PPHzMgNdGzS
         kxp3JFvdxL77fPKO73G0tnGTaZnFNKFVP1nu/aue8eo6qMqfHk86mqeNIADjJR4nPFgU
         G5fOlb3DX8KER6UMGsU3HTBqsLPwl03IO7Icek0x1e4X+Ey6eHV0sLy8xVVxov39Ix0B
         PZzJLgcacfYXSrF2ohRonsKf+2Gk7Y8UbE62/5333pb2edY/PajFHzu+fFQ9MpJOea0E
         +Tww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733786585; x=1734391385;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4za+GSZXfXk9ejvCCCE1cqr2r2pNcy2eq/BH59GGowU=;
        b=cAMEkB1PZXCknEsKuBTC9XXLCn5JktSIGAXtF4QS+pZowPz2SiH6dBp/RIy/Q7Keg1
         9GrfmNNhXaU5iiykHjSd4DN2nL/VS2DrDX0xi80Uub+Sq13xfTGvOocfDTysJXBst8I9
         aq/+0T/FiV/mdzvEMhqmI7aBcyvFJsIxZsNwmt2rknK49/qwxCfcJWUdAhftJnbsD4Wt
         XRPFU953jQ7N07nM5erTrQpab68ic+LysXVbRdE10bsgL1IO54UQ40THf5gCoWLUoW8k
         4WqO0ekUYxYKmaEGKYFsIYViLqmYZmSrpIJ6imU38dHrKBvCg1HhWFi3944cuX7rHVFS
         xW6w==
X-Forwarded-Encrypted: i=1; AJvYcCUN87/5EcZanTPk/gVuB6Paa3bP53oQoDbHdi9FCVcCd/kXEPYwdrIK/sUgu10du4qLtzyySGmLjB63DRM0@vger.kernel.org, AJvYcCUVH2dV+4nR8GatzmjzBwWdaLWc7TqtPdTKSBb48GXdrC6uXUzPULMTN3B1fCUbBuWzs5Dq7haCSQo7@vger.kernel.org, AJvYcCVp68P1oTxHI/WcSV42ooVCr2SdXwrz9gCYQt4k61towUETHANrsmA7skN5+jiH0DbP8TEuYvry@vger.kernel.org
X-Gm-Message-State: AOJu0YxUPr7+dr5jBqXF3X5o3HXD8/MF/tWXv+g7SqOrdj4iKrcxgktV
	4mdOLnktENq4DZaCmIzXg3SMZdSLFLvqXVnK+uGzpcxR5SEufOjU
X-Gm-Gg: ASbGnct9HXPMn0OyXokH8GIK7MMPeP+xsz2nTt9ee8t55nhxkXDclOIKfuRQKf5siHV
	5z/NssMIkFWOgAC8VmqYKHPA+iHOjxN1wvIFVPN5ohm+Z36dzw2u2Fqdk/xULVrciLXb8M/t6ny
	Rhm3X/RsfoWKFXWe8pbZIfoGKDXrUBRhZhUoisF3P/QH0Agow4rdhwTvy2sRnh7y/usL4qKV+uo
	4TMxanHM1imcp1ztrBrn/dSLCUDZboSO8Epn1uacwIJ9ouuIitPnD/SA7wzAHPCxJDXBwhq9d/C
	xdf6vioeCA==
X-Google-Smtp-Source: AGHT+IGcwzFHa6tjiFPLaKsV++wYg1Uf2gT5gfK3g5nqMFs22rDgHy9nqza1HTLsDkylobsAiFk1iw==
X-Received: by 2002:a5d:5846:0:b0:386:37f8:451c with SMTP id ffacd0b85a97d-3864699e721mr903990f8f.1.1733786584777;
        Mon, 09 Dec 2024 15:23:04 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f55733d2sm65178135e9.40.2024.12.09.15.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 15:23:03 -0800 (PST)
Message-ID: <67577bd7.7b0a0220.1ce6b5.fe93@mx.google.com>
X-Google-Original-Message-ID: <Z1d70wi6VzvCTIBj@Ansuel-XPS.>
Date: Tue, 10 Dec 2024 00:22:59 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v11 5/9] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-6-ansuelsmth@gmail.com>
 <20241209151813.106eda03@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209151813.106eda03@kernel.org>

On Mon, Dec 09, 2024 at 03:18:13PM -0800, Jakub Kicinski wrote:
> On Mon,  9 Dec 2024 14:44:22 +0100 Christian Marangi wrote:
> > +	regmap = devm_regmap_init(priv->dev, NULL, priv,
> > +				  &an8855_regmap_config);
> > +	if (IS_ERR(regmap))
>             ^^^^^^^^^^^^^^
> > +		dev_err_probe(priv->dev, PTR_ERR(priv->dev),
>                                          ^^^^^^^^^^^^^^^^^^
> > +			      "regmap initialization failed\n");
> 
> wrong ptr?

yes wth... I'm sorry for all these stupid mistake for this series...
Also hope we won't have to request multiple stable tag for this multi
subsystem patch. Any hint on that?

-- 
	Ansuel

