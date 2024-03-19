Return-Path: <netdev+bounces-80661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB87A880369
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 18:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749B8284B26
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 17:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288501E4B1;
	Tue, 19 Mar 2024 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4pLN1bP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED936374F2;
	Tue, 19 Mar 2024 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869203; cv=none; b=EmYHyQ17F/aBFmo3YMNVrG4mir+aO2XWtlPY3rB2PrVgVJFVlKPzDKnqME5/ipbmqBcziUrvVSwnVS/Aik08BFoGmbNLnLyvtH/UUGEpCAYYdw7tcubdHzXSS4U47/dUotCjWsBQtvU6ms6Hz5dvRzZQurfPHSPDoBKwUlFY2+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869203; c=relaxed/simple;
	bh=q0mQXYnw7vmq+3ChIG1+fp/A8xtsC227i6BGq5i2jgU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WSmoJWYWCIj7JYww8g1QO8MgEPPlwfNJsOBrchgwuUNoUTXgdvZcAO3bbmGXixvHAFiN5qsKSJHLKf5NYozNhqXCMJ20z0sDkIiNr42B/yTp3om2b5ei+lP68f8Bu80OExhEjxa05Eg7qRJKqanGQTUs/kKuY7ZCwgKaD9Tgb4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4pLN1bP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22574C433C7;
	Tue, 19 Mar 2024 17:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710869202;
	bh=q0mQXYnw7vmq+3ChIG1+fp/A8xtsC227i6BGq5i2jgU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d4pLN1bPbg4B7W+yT0162XeCnqfd5s42ut/P2h5xEZoHQpneCel60Os5FYHMM4K1h
	 fIitQlVqxC8BVWvAyrXiQ9jLmAT61kaj+UKSaEUd+6RA9fpE5zln/55v07PvXWpXHd
	 g4xoI64ljAP1amp55Uxv3hh4NS2eqdU/ynjRlTsul86osiPajs64cAF1sFymSyiJdO
	 BK5fFlpuCgp/2nXi8DQjaxcHr/I7LJVKVkqcKs/wAYeg5YkQheRS8cGvD2bSNt+A0v
	 YUH6PPwHwPskxLmT92qx13oLAJxccrx8KJfROrYDp10kohpjmkPOkL4u+ER392oT1y
	 3e9vRJZ5zwO0w==
Date: Tue, 19 Mar 2024 10:26:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <Raju.Lakkaraju@microchip.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
 <edumazet@google.com>, <linux-kernel@vger.kernel.org>,
 <Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net V1 3/3] net: lan743x: Address problems with wake
 option flags configuration sequences
Message-ID: <20240319102641.3f135b2f@kernel.org>
In-Reply-To: <LV8PR11MB87002847609196ABF0D0568F9F2C2@LV8PR11MB8700.namprd11.prod.outlook.com>
References: <20240319055110.764002-1-Raju.Lakkaraju@microchip.com>
	<20240319055110.764002-4-Raju.Lakkaraju@microchip.com>
	<LV8PR11MB87002847609196ABF0D0568F9F2C2@LV8PR11MB8700.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 06:00:15 +0000 Raju.Lakkaraju@microchip.com wrote:
> Sorry for inconvenience. Please ignore this mail only. 
> By mistake it was not out.

Unfortunately patchwork decided to include it in the series,
please repost.

