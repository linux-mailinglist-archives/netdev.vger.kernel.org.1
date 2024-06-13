Return-Path: <netdev+bounces-103193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820A4906CFD
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21BFC28456D
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 11:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2995144D0F;
	Thu, 13 Jun 2024 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEYNDcyU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E9F143883;
	Thu, 13 Jun 2024 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279504; cv=none; b=MIxmIbUEm+hR+4s7egeAX1UkBqbLBMTGld8n1QrrMJl32dvJ4AdvTNg7XDtiFCwSyXpw3rP57YupO8852xwwojpkK+rzHhj9Dbmu0vFK3nS31Eiq5TEE8swmF4nsiSb+fKv4t/ec4fgT9C15xCFbRxo+vHg42MiILaKqO+CrNGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279504; c=relaxed/simple;
	bh=5yq8m+SBGM96rXAdcdQvH/rJPfubuzK0CuGVUXOIVAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jh9Jh/VGqn08hTE6672OLxDCwyWrW6NMWl4F9BFo6cE9O8ITmaNaQz5+2X9riTbNT0eFG+0gtEtNbzIsxj8HC8avcFebHRdR08BLovC21i+WkiwvoBWmO4c3aatSsXkJfd8d/FOkaFbonxQRGQvuVdFYwgKAKzJWqMIP7YzkcVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEYNDcyU; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-579fa270e53so1174802a12.3;
        Thu, 13 Jun 2024 04:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718279501; x=1718884301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KJefyQyjkOVfFqQZSnaUeK5Yr2ypYtTp77GMMmsGIZU=;
        b=dEYNDcyUbhsZ8S9LewhAlZ0r+drK3RWEg6pR20ccdIQF3auoUzCVjRs1Y8iWtwaI3P
         57pDkUTj/Hy2XaIhGi0lvqR8Lbnty7cTDOr4e2/yzCQgTc5lyP2ljyxlZZsNAKw2sTGq
         GwalnwqKt7g7vDI2oBoGxdw8bbXmemHXeXnpnlKRiF9QZ/tnMibVhyDDDy8QhUwMpAW5
         aOD8w5r4KlNVFrN5/taSEOFxhDqy9R+qdg/+7as+z+tqiTc5TGTSLBt00dx9ya1BVDp1
         3FHic3HWuES5P9dYQO1BNlPGwT6rFm3YgM7xfuvJIy7cZNPtzwzxpTrA4lMRgQ/em41d
         GZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279501; x=1718884301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJefyQyjkOVfFqQZSnaUeK5Yr2ypYtTp77GMMmsGIZU=;
        b=r7UL7MMjz1AIa5W66YcSY31JtsjhShEapBMf3Gm7QFIKil5WPu0revLLsifrTPvT/q
         QBXdRQ5GMrms87WRWP0kgvoDpMqBN3iyoHL18iJxWhK5skuR34T4oUMlX50lyblxsvgS
         Tjuo7z7RJWKh5YCnSyaXLWgEkGszJUFCvpXpmn5gTskSLYzRR1kgM37odwBrCyNl2/dv
         JQwQK0/sZgNgwtEjCksgrOYtev3z3uq607eI63tCZFtBmcNdhzJ45C7UhJsI2XfWQHEl
         4QsR0NvsuVY0dXelmfH2zS9ro52nnWC/tEldnYz2hByWz0nQ85ZxVFHP3KS+pip1cZJ0
         OD+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdRdj05Qcht3uAP+dPfaiKOcLdLxY8dPk66ht4HQYCD6tl6MpW2ZbcDApq85ql95WmBA8gUcMegaDymdCUF4ixiu1rlvIE/tfLWSQzwzZlLt+VJ1GIjjBroCD9JtQG3TutCpN+bXkjGaer1VAjLFbR417FIBeWLCbbkYL6dUVLUg==
X-Gm-Message-State: AOJu0YxpQZXSA+UdpV8anQeEajXQ5v6MLeXRqNlIqzWGThulQs7XACqX
	UMXDinc8CVLocw574GJZZkCxO3xwFjfgyiD/xj1puN7wE11OmauC
X-Google-Smtp-Source: AGHT+IGXMOflSMi6KOV3hqkc/LDkCH7Tx3vmolC5e6vFF/VUI6SVgZ6qSUivVUegzux7CBuHZAnxGQ==
X-Received: by 2002:a17:906:651:b0:a6f:e15:8163 with SMTP id a640c23a62f3a-a6f47d4ed2bmr336987866b.7.1718279500976;
        Thu, 13 Jun 2024 04:51:40 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db5bafsm64364566b.50.2024.06.13.04.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:51:40 -0700 (PDT)
Date: Thu, 13 Jun 2024 14:51:37 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 04/12] net: dsa: lantiq_gswip: Use
 dev_err_probe where appropriate
Message-ID: <20240613115137.ignzu35jxmmorxys@skbuf>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611135434.3180973-5-ms@dev.tdt.de>
 <20240611135434.3180973-5-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611135434.3180973-5-ms@dev.tdt.de>
 <20240611135434.3180973-5-ms@dev.tdt.de>

On Tue, Jun 11, 2024 at 03:54:26PM +0200, Martin Schiller wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> dev_err_probe() can be used to simplify the existing code. Also it means
> we get rid of the following warning which is seen whenever the PMAC
> (Ethernet controller which connects to GSWIP's CPU port) has not been
> probed yet:
>   gswip 1e108000.switch: dsa switch register failed: -517
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---

Needs your sign off.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

