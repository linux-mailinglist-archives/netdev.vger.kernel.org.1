Return-Path: <netdev+bounces-190897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86741AB9349
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 02:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E2F3BFA66
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 00:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9275BA34;
	Fri, 16 May 2025 00:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twWK9usL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDA04C91;
	Fri, 16 May 2025 00:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747356404; cv=none; b=qk5CQs0Spmk3Od6Px03V/SjTpzGYZdI0bCBXR+zpsaaeLcWSyTEAxYBUJgzBr2OpQgy/SG+NARd87fQ48lKYdB4kUDiaMDgog8/0fzHTKOs4ztHiUSSlFyS1GSU/yMmaQfBO8typ8Nb4HMJKJxFG516xRkv38wXfA2Mgt7mHJ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747356404; c=relaxed/simple;
	bh=Gf5sbn00+GXlLm5aFAtbaauvncNnf3qV0wzYZGj2Zpw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+xAtK3Lsx3LEnv7/8t6XjE8GDwpJOGjZHNsc42/M+qzoxAzpb1cyCnpJyMwtO8bBlAy0OK10N9v37A4jJZrF/uqAfGrPbaGo9Q/vwc5TRKGXRB9tJIXcR+kGF4Ur9jLGsvBRdLf4XwkpSjzwpiqPDTQ0IETLK2t+I3am+ydEZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twWK9usL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F4FC4CEEB;
	Fri, 16 May 2025 00:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747356404;
	bh=Gf5sbn00+GXlLm5aFAtbaauvncNnf3qV0wzYZGj2Zpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=twWK9usLAHXcbZfUVPnlujvB4d+mZXEtI7rmRf8lbq6wMqIP2m3ktHDqXkZ4MI+jW
	 be8cRhJUA9NHBSd6iTMwjUX/J14FPU+zmXDKmgeXPX+4qXVvYDIv/eOCToEn9YIiun
	 AM21Jsf5tRkdyba/mKFcRTZBnvuZLq38xlybpFVaXEDU7QgbCktRKHiCUNOUwOTgow
	 u3auktKxYdjObIKtAZbNHfgUp+azJTQKdNg6szCKvpXmHyddZ1I77gwuldHwAL9FjD
	 7q/Du92dKoT4mZ+N5NcT0EgG6xQP1EWs0n6KQkGJ0onIc5jnN2/KtgwTkzIXuwns4d
	 BYB+Vm37Qwxlg==
Date: Thu, 15 May 2025 17:46:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Davis
 <afd@ti.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kernel
 test robot <lkp@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Samuel Holland <samuel@sholland.org>, Arnd
 Bergmann <arnd@arndb.de>, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] mux: mmio: Fix missing CONFIG_REGMAP_MMIO
Message-ID: <20250515174642.583b3aac@kernel.org>
In-Reply-To: <878caa72-df94-4530-95b8-ae827b82f2e4@linaro.org>
References: <20250515140555.325601-2-krzysztof.kozlowski@linaro.org>
	<878caa72-df94-4530-95b8-ae827b82f2e4@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 16:14:40 +0200 Krzysztof Kozlowski wrote:
> If this looks correct approach, please kindly ack because:
> 1. The MUX Kconfig part is a fix for a patch in my tree going through
> Greg's.
> 2. Above exposes circular dependency, thus should be fixed in the same
> commit.

Acked-by: Jakub Kicinski <kuba@kernel.org>

CC: Hainer who has been trying to improve the MDIO symbols lately
https://lore.kernel.org/all/20250515140555.325601-2-krzysztof.kozlowski@linaro.org/

