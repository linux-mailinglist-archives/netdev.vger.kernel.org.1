Return-Path: <netdev+bounces-127596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 737AC975D8C
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 01:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66D11C2238E
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 23:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1F11BC06E;
	Wed, 11 Sep 2024 22:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOTBOtIz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628031BA294;
	Wed, 11 Sep 2024 22:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095554; cv=none; b=uS8dJ3bOrt8sroT2VzU0n9aIDl7QEEL/+SURa+qMnMBd/+iWawFeFJ/epCJ+WiKIsfcE8Cs7CUoOaV/12Kf9YGsdLFm+IfI4Jr7gEqyXYyDwF3TtmfrtdIvBJt+9LDI4yyKQGRTwciB9Z7iuh/HmhG1ZztvreXqT/3Q869VzqQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095554; c=relaxed/simple;
	bh=84PJn/d6I3AuEiKoOZrQVc/IzbNYCuP+fQcUfAk+Ahg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pyqpi6pmGlyPP8T5DrRPvmUBy84kYAWqlSsvEGA+YPgN3K4OVNdGUKFEAzfUHr4AnMMUGLLcTt++m7tWQXMa695CUOdmtUaEEa4HYqHkIOk39QxXl6DLZPYHwlrNYKuN5/DxgMkBeSBHyPzCDNd9fTjMtoYgTz0PVOLDNWu+IAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOTBOtIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9884AC4CEC0;
	Wed, 11 Sep 2024 22:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726095554;
	bh=84PJn/d6I3AuEiKoOZrQVc/IzbNYCuP+fQcUfAk+Ahg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HOTBOtIzsGhew4x/uGucD5xC6ERlwFvWVp+mvASVcenfiD5Pyl/l7q4Hq4V9+E0Ku
	 AHt3Mgtz9EWofe07m6v9WA/ZzNJ+bNRIYc0xiCiXM7QHFvjI/9bEFzJSpLdrZAIN7n
	 ihMUP2QIXCCICfdChUywQPBkx0r90xQ020s69qPpzvRYxj+ntcti7zAr1SRuMGQuE/
	 Aj4Ns0RYcgOsKCb3dIpf6E4phDjy86FXwRnnOrKs63Cb6VtF5b9O8sEPzg2DS76Oae
	 s/kTrrWsbnQXvw9JCtViR/+h7waVHGsagVN8C93rNun19i5r419CyG7u6HKs9hmvvB
	 bGupZualD9Ddg==
Date: Wed, 11 Sep 2024 15:59:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <andrew@lunn.ch>
Cc: Divya Koppera <divya.koppera@microchip.com>,
 <arun.ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
 <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: microchip_t1: Cable Diagnostics for
 lan887x
Message-ID: <20240911155912.1c36cf3c@kernel.org>
In-Reply-To: <20240909114339.3446-1-divya.koppera@microchip.com>
References: <20240909114339.3446-1-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Sep 2024 17:13:39 +0530 Divya Koppera wrote:
> Add support for cable diagnostics in lan887x PHY.
> Using this we can diagnose connected/open/short wires and
> also length where cable fault is occurred.

Hi Andrew, is this one in your review queue by any chance? :)

