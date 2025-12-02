Return-Path: <netdev+bounces-243212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1A1C9BA8A
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 14:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8708D344C32
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 13:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEF731D38F;
	Tue,  2 Dec 2025 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6ciUJZuJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CD631ED74;
	Tue,  2 Dec 2025 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764683218; cv=none; b=RUkDc9qs94MKO3ssWe+mEoDTsfoA2m3Z+uXDdwRJkJxwaydd2BWmXC2JJYn4ooASlE+sdksWb8KVm8piUBcX+LhdhUy+5F08c0TQdazXQYzGeLtygxsF83NXTxuX5lCchBkb5+ga+K+I88EfV3qsvtbbZIhMIErA1S+qsOznOos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764683218; c=relaxed/simple;
	bh=NuaxtZIKcPYB10LhdXyMA5Fq8JiyGEFCjuaxHvVhDnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nq7Z+BbNg5tIyTyC65o+eJknwC8PuhhH8FnjGTR3ueKLOgBN6YLhbrWK33aY1fq6Guzjoei+sjGcupIwMpYUKYhTLUHEv6UpNoSAlNT+qzFfkIOkRMnlJXrMh2evdf4vbUI0DFOG7mwxcQLlI6KqnwImOwP5GVxssqe5itjAwKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6ciUJZuJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Y6stw3fJIE8algbC/idoel2TPhkvr95XpaEq8jwpZ78=; b=6ciUJZuJUhZZNac9i0SekgpkVk
	03Z2WDVb1iVPfcSqudw+JEjOY29uTTWEwUF2IW+CZnSAbEwPZjJE8Th5IHa6Qunh3oUiIM65UtV75
	pzD+LQqVKgYP+tacBKK3gLMTcYpQImLAfNyJAamUxo8qMrdDeZ6cYAFKNF4TTJfvZcKg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vQQiI-00FhbA-2B; Tue, 02 Dec 2025 14:46:42 +0100
Date: Tue, 2 Dec 2025 14:46:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/1] net: mdio: reset PHY before attempting
 to access ID register
Message-ID: <79c050e9-83e7-4cc5-979e-457f098024bf@lunn.ch>
References: <5701a9faafd1769b650b79c2d0c72cc10b5bdbc8.1764337894.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5701a9faafd1769b650b79c2d0c72cc10b5bdbc8.1764337894.git.buday.csaba@prolan.hu>

> @@ -13,9 +13,12 @@
>  #include <linux/phy.h>
>  #include <linux/pse-pd/pse.h>
>  
> +#include "../phy/mdio-private.h"

Relative imports are generally not allowed. It sometimes suggests
layering violations.

I'm not convinced the complexity and ugliness of partially registering
a device in order to be able to reset it, is worth the effort when we
have a simpler solution of just using the ID values in DT.

Give the merge window, i will mark this as change request for the
moment.

    Andrew

---
pw-bot: cr

