Return-Path: <netdev+bounces-238563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCE8C5AFF8
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 03:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4888E34BFF3
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 02:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B705122A4FE;
	Fri, 14 Nov 2025 02:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKGatMz8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931361F5842
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 02:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763086917; cv=none; b=LtPv82MrPLVtruKbx6cYSyeghC/vCvcwHaDxNdDj7iFA1lfsUjmDdtymdvoJYGQc5EElNUwQr6Kp+Hbw7Gy9pd7iCloaZbbYt2reUZrsWYHoV5KU/ZYtd8h0J1Iwp0Zr23E1uEEKQ5fODvQgSaJes732t4Ttt/vbyZUvefNJ6uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763086917; c=relaxed/simple;
	bh=Na5EgauIczybJfHY94CEiIchGKaNn7AFHLj2EN5ClGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7LlMhr8zmvHSwdTTrM1EAXKYxz8DyJrWrPX32S4pQ2aYfeTf8tUBihV5D/vx8XPXdevcWifNWLIFcoWKDEceGcrNNIt1R5UY1/Zn9WjOsM5yM7TB7mpTHdkfF/e2cg7Bx7mzoqjPFkoRirqfvIYj6AP0RRNVfvSql9WJe2KC8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKGatMz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D778DC4CEF1;
	Fri, 14 Nov 2025 02:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763086917;
	bh=Na5EgauIczybJfHY94CEiIchGKaNn7AFHLj2EN5ClGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JKGatMz8L+FuTmUoppWVXtNitcUn5qETVGngVjyD6rAFLI4pP2ngrClgh/gCIe/GP
	 p/LUv+w0zPIKzH2ZgLL6uRP77tWytLbBT4pn5G46Y5cZrHx+8kwLC0AjfpZq6D2e4x
	 0EfgP4f0ggIMpOoBbh/QUjAECAdc7IEEliJRVHpsjFj86CRhe6pFYP122Ux4iJ/FFS
	 HQtlabgmGdg5llBpZyNgPSpg2KacE3Nl7x7b9YMvB7f9aRaBATDc3/+uP7vndLg0Vu
	 sBOxoZayeTAtwByQKrSOmOauFgAZZZXLsJ3UxMtqffGKnjUSNi6tAbmOb3bmbtNwCR
	 NI9fFrp5V+v9Q==
Date: Thu, 13 Nov 2025 18:21:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ralf Lici
 <ralf@mandelbit.com>
Subject: Re: [PATCH net-next 3/8] ovpn: notify userspace on client float
 event
Message-ID: <20251113182155.26d69123@kernel.org>
In-Reply-To: <20251111214744.12479-4-antonio@openvpn.net>
References: <20251111214744.12479-1-antonio@openvpn.net>
	<20251111214744.12479-4-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 22:47:36 +0100 Antonio Quartulli wrote:
> +	if (ss->ss_family == AF_INET) {
> +		sa = (struct sockaddr_in *)ss;
> +		if (nla_put_in_addr(msg, OVPN_A_PEER_REMOTE_IPV4,
> +				    sa->sin_addr.s_addr) ||
> +		    nla_put_net16(msg, OVPN_A_PEER_REMOTE_PORT, sa->sin_port))
> +			goto err_cancel_msg;
> +	} else if (ss->ss_family == AF_INET6) {
> +		sa6 = (struct sockaddr_in6 *)ss;
> +		if (nla_put_in6_addr(msg, OVPN_A_PEER_REMOTE_IPV6,
> +				     &sa6->sin6_addr) ||
> +		    nla_put_u32(msg, OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID,
> +				sa6->sin6_scope_id) ||
> +		    nla_put_net16(msg, OVPN_A_PEER_REMOTE_PORT, sa6->sin6_port))
> +			goto err_cancel_msg;
> +	} else {

presumably on this branch ret should be set to something?

> +		goto err_cancel_msg;
> +	}

