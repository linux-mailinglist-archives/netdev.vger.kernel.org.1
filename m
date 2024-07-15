Return-Path: <netdev+bounces-111592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83199931A84
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 20:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2925C1F2137C
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 18:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DEB71742;
	Mon, 15 Jul 2024 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Yf8druRL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49287179BD;
	Mon, 15 Jul 2024 18:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721069347; cv=none; b=r19Cm8HVLgXfkXOXRGsB6HZKBa0ju1GdZ5b55t3WjUcq0AKWkSDrYbyWwyhPDJK4Wevhr1sdGMjUjPg8Wu+g39QrE3luhKgJvqaDoOs7U6B80+vU+Xt0yP3j+/lw6rI/+dYA4zZjYY/xiNuGgxgErUjhEvJ+qoK+JnhaD9TZIAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721069347; c=relaxed/simple;
	bh=AmJtrJOYkheRvLPk7KDBMoq9AXd0A+zPJpe9ewJsmqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b966CRBHei1pkB9spfVx5w4Pu1NyNpbPLPo7WbRi08K53EdQwoqROlcJmZmhjehUch5zDOu0wYGzpup+Xc0Bo57FplfNxr5zYSlfyBq80o6BlfzqxzaXlRe9XTo+hzSVuHCKVvvZE/FT6yzgwJKPZXWRy6vfGZtTeCzPjLQCZho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Yf8druRL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=U/gaZ/UKVQ7nvvz75les85SF/WsWU7ztDSAN1VO2/gU=; b=Yf8druRLtaSPmhDfRfMjJMvWhc
	pNyZl7IQLM7zIYHeRJXwn7ilbIK6wwoMAXrddKmga4S2JvVYABMnPHMfg9ysSU1NPm1mZVNWnAAZN
	TDt1nVlCiwBUxdhpKaUGt+09vonwk2D2pAPEIpjmZ7BtPt1Lg4IW4B8l727aigduMojg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sTQkt-002akv-Gf; Mon, 15 Jul 2024 20:48:59 +0200
Date: Mon, 15 Jul 2024 20:48:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, richard.hughes@amd.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 01/15] cxl: add type2 device basic support
Message-ID: <72858182-c0e6-4c05-a11b-fc137f8f1edb@lunn.ch>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-2-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715172835.24757-2-alejandro.lucero-palau@amd.com>

> +++ b/include/linux/cxl_accel_mem.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
> +
> +#include <linux/cdev.h>

That is generally a red flag that something not good is about to be
found. But it does not appear to be used in this patch....

       Andrew

