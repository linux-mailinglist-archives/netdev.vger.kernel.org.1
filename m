Return-Path: <netdev+bounces-239004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E483C6208A
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 02:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1509B3AC21D
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 01:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E4A1F8691;
	Mon, 17 Nov 2025 01:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpAKZ+Y8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F0117A2E6;
	Mon, 17 Nov 2025 01:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763344649; cv=none; b=cYui3OjW7u3PZORbdPj0EOCNoLamOH34R765m0MNHG0Btv1wb2kAPYJe/0+Px3Yf9gOZO7JEQEEMcCIV+n82pCdfTpj1dqHq/V2XnkG/boF6R/MkS+FZo9n6pdXnV5+G+2yyejgz0hwwC43Tk8wENuCSEPhAvrGrQWuY+h2bx9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763344649; c=relaxed/simple;
	bh=Y8otecf9EJZ2AK3tZ87aARj9U0MFABmegSBtGQFds2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BN90QcLiOE6BNDJcUiO1bswxoNIeFgUSEdQT1/IyQBj4kQMz5CWpzR3rbBit9upyQo2O4lIJnjEdBCZURqmKotasgQ84ScU6TFvhe9gzUSf5lHJh9I60hhEZZ/vsDQdv3I2vpwaf1EV1DyMhc/9zMYlW70mBnKRgZ83W9bBlb4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpAKZ+Y8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7016C16AAE;
	Mon, 17 Nov 2025 01:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763344649;
	bh=Y8otecf9EJZ2AK3tZ87aARj9U0MFABmegSBtGQFds2Q=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=OpAKZ+Y8U5qnImxqOPHrzarBy0PbvBIo8q7aGxNII9rwyKQi0BnPFFqQaHg2C+Kf4
	 P87y0g0MUHCkt7vZoBRzqy/P+45d3XzOV9dUiMFxYnkjgDx1KhvN0+H/Ox185jN62+
	 iwyMxyTRyNLFxdoHdfNsA/Dz1bnG9gM16ju/c6pGV9VXANKLYiVMA4rIzd+6rlCYH2
	 rNYWvPK9JLmUFaw6YVkqQ6Qbc2MTvBG+vGK+9QolO48FFNh5NhELyQi0rW2SeRdEjv
	 4/vO/ujwRDdo791iJuFQMPd+ASKS2lK8NodNZ3biwRd1baVhzC0hYIMpwwlSBVUSKa
	 RQscZrq/wwf6w==
Message-ID: <7a4ebf5d-1815-44b6-bf77-bc7b32f39984@kernel.org>
Date: Sun, 16 Nov 2025 18:57:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ipv6: allow device-only routes via the multipath API
To: azey <me@azey.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>
References: <a6vmtv3ylu224fnj5awi6xrgnjoib5r2jm3kny672hemsk5ifi@ychcxqnmy5us>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <a6vmtv3ylu224fnj5awi6xrgnjoib5r2jm3kny672hemsk5ifi@ychcxqnmy5us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/25 11:31 AM, azey wrote:
> At some point after b5d2d75e079a ("net/ipv6: Do not allow device only
> routes via the multipath API"), the IPv6 stack was updated such that
> device-only multipath routes can be installed and work correctly, but
> still weren't allowed in the code.
> 
> This change removes the has_gateway check from rtm_to_fib6_multipath_config()
> and the fib_nh_gw_family check from rt6_qualify_for_ecmp(), allowing
> device-only multipath routes to be installed again.
> 

My recollection is that device only legs of an ECMP route is only valid
with the separate nexthop code. Added Nicholas (author of the original
IPv4 multipath code) to keep me honest.


