Return-Path: <netdev+bounces-185813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EB5A9BCAF
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9FA1BA45F6
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A14B25776;
	Fri, 25 Apr 2025 02:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCTKT5NF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B40179A3;
	Fri, 25 Apr 2025 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745547364; cv=none; b=CAPag/mVOU+A3cNoPoLaJcfBVOCmE7z24e3qICmF5XHxvfGnJD8yQJqHUrlf274aZz9wazat1sI5nXIE3Nhz87OQCKVjEajIL9XjffBBDYqILl4zwSlhGPz8phe0R0Qk1BnLztirAtVWOgJDseVrGs/0tuGOzBcRQi+n0pbyB9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745547364; c=relaxed/simple;
	bh=7dhh4pgXnpoNNmP1zUba/AqVU9c6ggKMDn5X/JSgHWg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O2MWNx836dvk4GQTpUo35C3CLApz5qjVVzfmA+N1MKj1eYtcZHsGTSqwcabRHulkg+CprDskCM3t3yppuwg7/1jRIbv+gFTmLn3lFZ5ew9+Kgr5A7czCaDieFUDqIpN2vjaYyDiyEtBDkCc7w//cBD3rLqvMM5B/FXQxTwjg4Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCTKT5NF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B978FC4CEE3;
	Fri, 25 Apr 2025 02:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745547363;
	bh=7dhh4pgXnpoNNmP1zUba/AqVU9c6ggKMDn5X/JSgHWg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eCTKT5NF+ko/D0Ymvh908TbpHTfRFVlED2cyhNGLU54cjd/AwWZ8yotm3Z/263eWs
	 pMeEO14BV+RXs8rVQp/98Vjp13CIZBmHBlOfriCyXfvD2SYKi6JaRPgFtLBQYnlM4n
	 hJhIb2CCqZ7YmFRRvzVU0pC1Phd2GDVzYCsYunve6o/ez8srbW26sGEy+TaqKfBxjB
	 2pVE+PfKOQmNxPOzzT8xBI+FQK6/fAFf44ruvvutnj4BUs0I+kSw32yEebaJ/us4Xz
	 PlulC9+cw9oEk/nAuD9f8yOo/4IzDd1HYX9WbF5vSDgoqI4jDqINpD5gydqScjlJLR
	 E7ZyAk8ZVjglA==
Date: Thu, 24 Apr 2025 19:16:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com,
 ssantosh@kernel.org, tony@atomide.com, richardcochran@gmail.com,
 glaroque@baylibre.com, schnelle@linux.ibm.com, m-karicheri2@ti.com,
 s.hauer@pengutronix.de, rdunlap@infradead.org, diogo.ivo@siemens.com,
 basharath@couthit.com, horms@kernel.org, jacob.e.keller@intel.com,
 m-malladi@ti.com, javier.carrasco.cruz@gmail.com, afd@ti.com,
 s-anna@ti.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, pratheesh@ti.com, prajith@ti.com,
 vigneshr@ti.com, praneeth@ti.com, srk@ti.com, rogerq@ti.com,
 krishna@couthit.com, pmohan@couthit.com, mohan@couthit.com
Subject: Re: [PATCH net-next v6 06/11] net: ti: prueth: Adds HW timestamping
 support for PTP using PRU-ICSS IEP module
Message-ID: <20250424191600.50d7974c@kernel.org>
In-Reply-To: <20250423072356.146726-7-parvathi@couthit.com>
References: <20250423060707.145166-1-parvathi@couthit.com>
	<20250423072356.146726-7-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 12:53:51 +0530 Parvathi Pudi wrote:
> +static inline void icssm_prueth_ptp_ts_enable(struct prueth_emac *emac)

Also do not use "inline" for functions which are not called from 
the fast path. Basically no "inline" unless you can measure real
perf impact.

