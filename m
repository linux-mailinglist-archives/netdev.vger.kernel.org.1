Return-Path: <netdev+bounces-143418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 108F69C25BC
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 20:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8F81F21372
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 19:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBFD1AA1E9;
	Fri,  8 Nov 2024 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9hy6m7s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA551AA1E2
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731095002; cv=none; b=OLrlYYvjpcIOQHt/5rxTXGRAZ5EmXCf8bNG5MifdJ+ov3QWWFqVqs6IiM6ZWB1s+Lf1ef4Cvq+yKGjm5opiykKmsQ/xcFmnY0lYDF/LVOFdLz/z1UvxN72FAebvE5n1J8hdkSShQc/ydATL2pn8ABzLyrTkmxgqx9owcE3B1sEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731095002; c=relaxed/simple;
	bh=/Dsb4LqdN5yD3QQJCaxXSJroXWxN52qJRekTY3T2ijw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8Yc8KfpFWwBemophfeZn+KD/kha364ihcSc7VY6VJENRFZuUNeaTx2/5BdEwagTzg+C3ADD26c8Y1ydTldwJPA8NUGFAxAJtsdM4IYn565WlxVft+z4lK2MXeL2Qj5o3CDwwSTaTn643+aNoLVq1gR5ZB1wmYAzk/DIcR7xTLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9hy6m7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03569C4CECD;
	Fri,  8 Nov 2024 19:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731095001;
	bh=/Dsb4LqdN5yD3QQJCaxXSJroXWxN52qJRekTY3T2ijw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h9hy6m7sOGuTDLiqjeJidAj3jWWiloN26QpPrdEh/jAne99aH5D/ZSa2jZAXz8lw6
	 XdGbx/HdQNCK/ZlpshajaxjHvroqSyQQKBb1O0M6WU387ZStaG7FE3hh1LMR4MXzpH
	 iZMAASmH3tEa/ZPdGAfziavSnLT6FMabZWoNepddbClpuOQLJlWrLS9GWWj4Xhtah/
	 OlByAfojW0RvJ71BSmi5o4gyBj9o/4czjXkUuhIdQ9G/HgFoSpXAYYgMVBKRFTYgjf
	 11EUpLKcpfnxgjV0Dyv3xjrRZ4Mn7wYUG84pkrPKoA6R/1DjxyaFGmFHbyH7RxCIWN
	 i7x7zOzmeChFg==
Date: Fri, 8 Nov 2024 19:43:17 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/3] r8169: improve __rtl8169_set_wol
Message-ID: <20241108194317.GF4507@kernel.org>
References: <be734d10-37f7-4830-b7c2-367c0a656c08@gmail.com>
 <697b197a-8eac-40c6-8847-27093cacec36@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <697b197a-8eac-40c6-8847-27093cacec36@gmail.com>

On Wed, Nov 06, 2024 at 05:55:45PM +0100, Heiner Kallweit wrote:
> Add helper r8169_mod_reg8_cond() what allows to significantly simplify
> __rtl8169_set_wol().
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

__rtl8169_set_wol() certainly is much nicer now.

Reviewed-by: Simon Horman <horms@kernel.org>

