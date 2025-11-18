Return-Path: <netdev+bounces-239617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E12DC6A444
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4F12C35F191
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA40535CB79;
	Tue, 18 Nov 2025 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AKYDQIwL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B116F355050;
	Tue, 18 Nov 2025 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763479047; cv=none; b=vF75L4gS/7dnM05N1XlLWYZNWImWrCYkKb0GCty4o/SDElYMms1oVV01ywWOxfO0Pg7bbltgHMqmb7Fn5A5Y4MPxgjRmj/Q1n/oR/X5MSKqP5FiIElPzpeabp8Pidr/ePiticVoJ5TYs6rruF5/bELaGh+WfxNRJiR0Fq3EJugE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763479047; c=relaxed/simple;
	bh=Qd/Dw1XSW4/UtD1vVIppFQ7k696F5SfWLuWpwgU5Be4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8ShzordU+x55qurYzY+grpQ4m0VuqlE0Y0JyqMinaKdOnfTpRhoHgeBaL/BnjPuifTWbDG0qFIdkxvfo5SJcA5ovxxGOIrAv5a4akUAlVVKyfTGE++mOfl8OWRWqhYi3HAlQIv9kff7Q5AFiaivyASRq6J/Nwv59YKlQK7+Rpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=AKYDQIwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0071EC116D0;
	Tue, 18 Nov 2025 15:17:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AKYDQIwL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1763479044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhDcgp2F0+Ob9aaLUyNKyb9g3TlinvuDBZqNJsuWEOw=;
	b=AKYDQIwLbcw6eAuvJbHAIG8dKoTmVe0Fo7cmSQ16i/m74o5FjD2n91R+3Tx9qhuIr0C6K2
	dBJvkrdV56B0dflK4jIcBU3NcY8FS3zkJZBUJfKkZokfQ+OwiHCOwNi4mRCJEMcvIsHQZY
	cR1Txv2x1WVR0KpDfEGhpSaj+VYtZwo=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4c36a217 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Nov 2025 15:17:24 +0000 (UTC)
Date: Tue, 18 Nov 2025 16:17:21 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jordan Rife <jordan@jrife.io>
Subject: Re: [PATCH net-next v3 07/11] uapi: wireguard: generate header with
 ynl-gen
Message-ID: <aRyOAYuWZE440WQ4@zx2c4.com>
References: <20251105183223.89913-1-ast@fiberby.net>
 <20251105183223.89913-8-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105183223.89913-8-ast@fiberby.net>

On Wed, Nov 05, 2025 at 06:32:16PM +0000, Asbjørn Sloth Tønnesen wrote:
> Use ynl-gen to generate the UAPI header for wireguard.
> diff --git a/include/uapi/linux/wireguard.h b/include/uapi/linux/wireguard.h
> index a2815f4f2910..dc3924d0c552 100644
> --- a/include/uapi/linux/wireguard.h
> +++ b/include/uapi/linux/wireguard.h
> @@ -1,32 +1,28 @@
> -/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT */
> -/*
> - * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> - */
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> +/* Do not edit directly, auto-generated from: */
> +/*	Documentation/netlink/specs/wireguard.yaml */
> +/* YNL-GEN uapi header */

Same desire here -- can this get auto generated at compile time (or in
headers_install time).

Jason

