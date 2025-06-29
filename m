Return-Path: <netdev+bounces-202257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA165AECF6C
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 20:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03D6171F37
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 18:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846702253AE;
	Sun, 29 Jun 2025 18:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XCslqu7v"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB464A3C;
	Sun, 29 Jun 2025 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751220650; cv=none; b=QaI2wD2NoMwWWtsMczy7NmBK35IkrZGmFGArkumz7hhLIyrhAIL3JE3bMtBLAgEjZfx4Qg8A4Cnc/HKuGgSLOrk94cLcDRHcstl+8buOLk0cvPC9A2oT1r0cH6C8MKoy5JiwczzXRT51Dg2hFW4R5EDqqU2tfRhXVX7Z/NLbzVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751220650; c=relaxed/simple;
	bh=rQ13VObp17dm8Lf0rGOz6vSrG3BrY0W2QeZG0NRfLTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4WEFl6+w0bIT4V8DEW579s4DTM3ia2zR1E1CE7eAX97smiPiCuCzg770U8teFnA7wjWchg12BJ9bMPEp/BnPdwBoaI3A0a0MvXpIY/geOKwyzaSN1Y6NcNJUb6mqe7e/J4Kb80R4jBs+FFX2W/Lglhmg09+CjD/e1nHoCcbTOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XCslqu7v; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0SXtSx80cAdCDtcPv9j072wXjbBXpZrMW0XySoNhCpM=; b=XCslqu7v0e4xvy6nG6epE1EPIJ
	2sMobVmbQNK5E5AeZNuOc5TPB/L6Q2pQdXLxEDIyJxii0LeUsjmEfeqS6NtgiwKkNDHBXrArzEHyQ
	u+cywzWRihMoNasndy/IlJrhmXDdrSWZly0QGf3SUSDDZFRDTBYKkg5/l5+F2X0sJ46s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uVwTt-00HIBB-EX; Sun, 29 Jun 2025 20:10:21 +0200
Date: Sun, 29 Jun 2025 20:10:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: linux-clk@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, daniel@makrotopia.org, ericwouds@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	joseph.lin@airoha.com, wenshin.chung@airoha.com,
	lucien.jheng@airoha.com, albert-al.lee@airoha.com
Subject: Re: [PATCH v1 net-next PATCH 1/1] net: phy: air_en8811h: Introduce
 resume/suspend and clk_restore_context to ensure correct CKO settings after
 network interface reinitialization.
Message-ID: <fe9a6e67-2790-489b-a5fa-a03ec041f48e@lunn.ch>
References: <20250629115911.51392-1-lucienzx159@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629115911.51392-1-lucienzx159@gmail.com>

> +static void en8811h_clk_restore_context(struct clk_hw *hw)
> +{
> +	if (!__clk_get_enable_count(hw->clk))

Using a __ functions seems wrong, they are supposed to be internal.

How about clk_ops save_context() and restore_context()?

    Andrew

---
pw-bot: cr

