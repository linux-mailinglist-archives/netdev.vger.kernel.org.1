Return-Path: <netdev+bounces-117938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA3194FF53
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 10:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04AE61F20F9F
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 08:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819B213541B;
	Tue, 13 Aug 2024 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aF4IFUFI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B783B192
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723536411; cv=none; b=Q1YbYREbg2Jx/ZCPrbXhbXHOvGem694mxZ0LTNWYYJoLDVjdQTC1HGYngpCqwmY/GbqeVH52hD/YXV7FGSRSZEoLEcQiZ86xFLsWsQWTiMmtUtzpyTiuBTle4MXnGQyFkqTHw9RAISJ3PbV2jHUzaRtMHHYUsLVF+DEGqpMvoRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723536411; c=relaxed/simple;
	bh=BvAqtCFIBrKq32GAj44YKOBecH7LTrOIZkXTL2CA6m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QW9QmlvTdeJ31vsLeK1Zx9ukRTLcddGM+IT/ESBh5DRpcolr7b+He5/G0X2G5rEXrgBRF/5fAuvjVCWMVgVsLwQdYgF779ygiWJAf1dowNv1jJlng6fH3LnFadjoID4VPgYptm59giONi98rHKbsLvbTRBDC2qgJcb88xpCqUeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aF4IFUFI; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7de4364ca8so549198366b.2
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 01:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723536408; x=1724141208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dEbEbBr03OYuwYP8f6MOR5iKrAH0xwcbF5rG1MTVpOw=;
        b=aF4IFUFImW8cQNTcWhJy7wtjXqkQsRpUSA5MfvMMQzQPlpRYixRXjHFa17Xo25YTQ1
         40lSmQI/CdvaGM1fUniKMywY+kxHAr4laq8R0UiZ9VVPXnPi22KTzwvryuCvX28IBPL6
         guNKBC+Od1I6XW99JICHL4ZY9c4DWWy7GrOqpL19hikBXM7Q1WTIUa3rIhP+AodsaExm
         bBVls51F+yff3o5XQqcya5cNuA9z6mGQqpmM7SCg3rOJLjhPs/6MYAabxlRf6n3wR6iu
         GZqlpsJrlkT8m6O4cWwGei0OGQn8VkZHTeDcItJ9CEv6GVTMJWEgch5ySc7PCJa1s+St
         ok6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723536408; x=1724141208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEbEbBr03OYuwYP8f6MOR5iKrAH0xwcbF5rG1MTVpOw=;
        b=OiJh5m35qRsYgYjskxAapsT5n2MLLgqdc6E/J4w+ImMK5r2mGDLXCakZ5TXiT3GGaD
         c6zStUxEKeQL8owCUmUszpXo2/ZdtP2aOmWj6NiaBpFN5De29JXfP2aaOsOo8JiJ5Ns0
         CZ082TkmpIH4LgqgMHgcXxDOjildfTNpOFkxEOJCrCeBQsCeSuk6/1lHl1/WyExBbAvw
         6+wlPntkWEZUDSzb+2VdHaPlEYBCaOADV7n4NB4E3QIGS8X4RBJJr5AaWjOzmE1wqaVi
         OW/7R10JfilEOGHdAlwZuRJabMXcRHdkLfvlamQH1f2mDwd9f6f0pcVPiC9g3y58lU3z
         vTcA==
X-Forwarded-Encrypted: i=1; AJvYcCWVZ036U75/UneewnOvzh/4ZgqD0E6MIKLozPrPGOlhoEa4DLdddlM4vDLFuDUp7IIr7BdZXD1Ls8HFgnn0iCXx9/D163sw
X-Gm-Message-State: AOJu0YzjWWdzxiahQ6XaicVaWgShap6G7hWTde1Jr4mkwqkodltueaqx
	KSUtuPgkT2xYVkpQwlBm1aVYyMitciKTSPJXhVb8x7Pgdl+jRRu4eiEH49D6SaY=
X-Google-Smtp-Source: AGHT+IGkQmluegEvOCR04zQGFNMMJOXbaMawbLU7Q1dimfbs9OBxlsra50k47SxAe4Dnl7gf/d2JpA==
X-Received: by 2002:a17:907:968b:b0:a80:f7d5:addd with SMTP id a640c23a62f3a-a80f7d5ae9emr76749866b.13.1723536407834;
        Tue, 13 Aug 2024 01:06:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f411b105sm47786166b.103.2024.08.13.01.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 01:06:47 -0700 (PDT)
Date: Tue, 13 Aug 2024 11:06:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jan Kiszka <jan.kiszka@siemens.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v2 3/7] net: ti: icssg-prueth: Stop hardcoding
 def_inc
Message-ID: <42da6d34-e4ab-487c-8079-877d96d83ad9@stanley.mountain>
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <20240813074233.2473876-4-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813074233.2473876-4-danishanwar@ti.com>

On Tue, Aug 13, 2024 at 01:12:29PM +0530, MD Danish Anwar wrote:
> The def_inc is stored in icss_iep structure. Currently default increment
> (ns per clock tick) is hardcoded to 4 (Clock frequency being 250 MHz).
> Change this to use the iep->def_inc variable as the iep structure is now
> accessible to the driver files.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---

Thanks for breaking this out into a separate patch and removing the unused
spinlock.  I don't necessarily feel qualified to review this patchset but I
didn't have any other issues with it.

regards,
dan carpenter



