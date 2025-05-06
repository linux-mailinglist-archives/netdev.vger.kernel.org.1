Return-Path: <netdev+bounces-188206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0CCAAB8A1
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA134622B1
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 06:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F357E2D1644;
	Tue,  6 May 2025 03:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/BG53Zd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40AB35566D;
	Tue,  6 May 2025 01:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746494052; cv=none; b=kiuHR3VpaujvG5MWc8ntr8KVGuqYgrNyc1bFctdmXkC3wbVa/E7n97/7KZvVQXvSo54qlA/taGeDVK31Kk5ju/6dKaSa+mtFTXbtDUHJ4Mxs2rC3qTld3XaOf7a7C8zgnSj/c9fTmYFRV3wDuCLpZmIFmNpA+TDQx1/6nGb4SVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746494052; c=relaxed/simple;
	bh=DkjqaiNHBXbV+0n9cmGdTkEwmBKD3xmvL6XjuBD/yFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAbsvEGF2Je0Ylb3yMzVm41H6pXAhgBa3O/HpXpK2//widj/WxHda6Q3hBnsClPxavx0wWa0Fqx09dPjy+hIdAvCbF8QWPm8pbXDumTgqjpIcL8fmwmErwOtIh5DWEEprilIplSEIfTav0Vr2NRXkjivVqUnPvKxXdIFzApykp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/BG53Zd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95270C4CEE4;
	Tue,  6 May 2025 01:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746494052;
	bh=DkjqaiNHBXbV+0n9cmGdTkEwmBKD3xmvL6XjuBD/yFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p/BG53ZdqJ6Wn5cParmccP7A0YFtuLl7Zz6shvfwtCSmRBLaBnQvECXAVIRYQvzwz
	 xxWcYe7T0IHGzTfcVsFuUTaJzrnHacCQ3x22eEj7iOblx0hqu5yAjsvvCZUTxD3vH4
	 raak2xREqdtbF7l9j2wucw0YE50WAvmUbszWJ0to4iRU08pwilXBd9+DMmMDXO0FGI
	 y1B7yIAfc/ONISDgkyp2S4zONlX7ZeeQGq6zf6oC8HihUvO/RKocjLfccnLu3cd4lA
	 ERyeQOwEidtPkXPnEsLgTw46BKx+Mq3GLymH+9grB4tOrlIiPWcUafC+cqjS1PV3yG
	 eKwWF0UVSAKAA==
Date: Mon, 5 May 2025 18:14:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko
 <jiri@resnulli.us>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Lee Jones
 <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>, Michal Schmidt
 <mschmidt@redhat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v6 0/8] Add Microchip ZL3073x support (part 1)
Message-ID: <20250505181410.24b54946@kernel.org>
In-Reply-To: <20250430101126.83708-1-ivecera@redhat.com>
References: <20250430101126.83708-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Apr 2025 12:11:18 +0200 Ivan Vecera wrote:
> Add support for Microchip Azurite DPLL/PTP/SyncE chip family that
> provides DPLL and PTP functionality. This series bring first part
> that adds the common MFD driver that provides an access to the bus
> that can be either I2C or SPI.
> 
> The next part of the series is bringing the DPLL driver that will
> covers DPLL functionality. Another series will bring PTP driver and
> flashing capability via devlink in the MFD driver will follow soon.
> 
> Testing was done by myself and by Prathosh Satish on Microchip EDS2
> development board with ZL30732 DPLL chip connected over I2C bus.

Looks fine now from the network-ish perspective.
Whenever we get a green light from Lee I can put it on a stable branch
which then both Lee and netdev can pull?
I'll hide it from networking patchwork for now so it doesn't get
accidentally applied..

