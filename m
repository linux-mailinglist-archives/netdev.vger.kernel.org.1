Return-Path: <netdev+bounces-119938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6313957A78
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 02:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35219283DA8
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1104C66;
	Tue, 20 Aug 2024 00:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffzGbqZB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4736AA50;
	Tue, 20 Aug 2024 00:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724113570; cv=none; b=Mn7j01YaHphIRGyqZhnPJgzRRcIlEgouu24AYYPbwDu4Tk4c1QwHjJJ0KqpavJfmiXwNs20zbGbAnUZrLvf4TJIDi431VbpbKKZD88fo9nltBlIiiv4wqVFM3i38WVwscPnWtcSVUgacvTMckXy7m0zGbro4itPGWrMIu6EvYL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724113570; c=relaxed/simple;
	bh=sRXxrYGsvqAwlJZMOO4J9ngwjq8KmLev6usREKg7EQM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXClaxFiC5dowZIDvceyfvaRGz/KRSuso8kGxRlR/GGvc7c6VmedOV4Md6IbDCkep4725ACO9RCx0dmUZiO/rdBZvB0gd25LDJYAP6dsYmiwGRbNaUIbKGIhZeNvgJFqPTiJo4PpCXMyctak/0jayaXpjVuBRwm8hr9w/xP4oW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffzGbqZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C31C32782;
	Tue, 20 Aug 2024 00:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724113570;
	bh=sRXxrYGsvqAwlJZMOO4J9ngwjq8KmLev6usREKg7EQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ffzGbqZBjngJhcweA6YvS9YSLaj9CpiUbjbytOIb0KYYO1uQhRJRpWAHfg/Pu7Sdb
	 NlTGceGnbVSOoqoosPZgnS/VNm6ZapJ8FkL8C66gxIpj5oDLDhil58q6XgBuOCk3O9
	 xS7I+59LNBMURATvJ0Tbxh34Jorc5GymzxDnrWQRhLl3sPZ1aykGmLTY5car8ZvCi1
	 CQzpdcGM0xp6U6WupcKHTeJQ8Ozd3J/E2bamphzZA5JnyvK1pqZyTtE3Mg26N+Zwus
	 xQkn0sJxUKAiMnvRqzYUo1GaOkpDs+zdQOLbHNgQ/A3rVmggs37yMnMF0zMiowTKDs
	 R0s4PjFJtpzNA==
Date: Mon, 19 Aug 2024 17:26:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v1 1/3] ethtool: Extend cable testing interface
 with result source information
Message-ID: <20240819172608.2ca87928@kernel.org>
In-Reply-To: <20240819141241.2711601-2-o.rempel@pengutronix.de>
References: <20240819141241.2711601-1-o.rempel@pengutronix.de>
	<20240819141241.2711601-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 16:12:39 +0200 Oleksij Rempel wrote:
> --- a/include/uapi/linux/ethtool_netlink.h
> +++ b/include/uapi/linux/ethtool_netlink.h
> @@ -573,15 +573,25 @@ enum {
>  	ETHTOOL_A_CABLE_RESULT_UNSPEC,
>  	ETHTOOL_A_CABLE_RESULT_PAIR,		/* u8 ETHTOOL_A_CABLE_PAIR_ */
>  	ETHTOOL_A_CABLE_RESULT_CODE,		/* u8 ETHTOOL_A_CABLE_RESULT_CODE_ */
> +	ETHTOOL_A_CABLE_RESULT_SRC,		/* u32 */
>  
>  	__ETHTOOL_A_CABLE_RESULT_CNT,
>  	ETHTOOL_A_CABLE_RESULT_MAX = (__ETHTOOL_A_CABLE_RESULT_CNT - 1)
>  };
>  
> +/* Information source for specific results. */
> +enum {
> +	/* Results provided by the Time Domain Reflectometry (TDR) */
> +	ETHTOOL_A_CABLE_INF_SRC_TDR,
> +	/* Results provided by the Active Link Cable Diagnostic (ALCD) */
> +	ETHTOOL_A_CABLE_INF_SRC_ALCD,
> +};
> +
>  enum {
>  	ETHTOOL_A_CABLE_FAULT_LENGTH_UNSPEC,
>  	ETHTOOL_A_CABLE_FAULT_LENGTH_PAIR,	/* u8 ETHTOOL_A_CABLE_PAIR_ */
>  	ETHTOOL_A_CABLE_FAULT_LENGTH_CM,	/* u32 */
> +	ETHTOOL_A_CABLE_FAULT_LENGTH_SRC,	/* u32 */

Please keep Documentation/netlink/specs/ethtool.yaml up to date

