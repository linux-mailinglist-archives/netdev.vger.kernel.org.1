Return-Path: <netdev+bounces-111548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 556D5931815
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 18:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005F21F223E1
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B9917BD3;
	Mon, 15 Jul 2024 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PT8U41mb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF941757E;
	Mon, 15 Jul 2024 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059641; cv=none; b=d6wMYE05fQkZ+6v5RbALm78AbMuWpCz7txHRvnaL4kLT3asL/HFRWtauva8noiWiTsSTRwFVTDs2LQaPT1KogGeIrEwEI0wc2sGl4x6AhYaNQTDi5UkXl7plVM3Olp0vZMMZlJpaWlKW5OZ5Bm0t6D7ucB5QaAEZ2vLB2FMzkMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059641; c=relaxed/simple;
	bh=LSAEUqJL/09RkQgjhZDFafNERM0VMMG79YGIIbpCemw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e22srwD6YW5WLJ35O78AJlWFS6Qxgcok9qYGivBDjynLLqd3syWfoys3gaQbHBr4dQb/U8+5xj3oHOEatYQM2hz7jPjPnQp+0c9P+LXsK+cizPHcPNFhkwiCqUybLQ0v0elT5tP41XZpIqVZxM0ZuPnY0OHh1+FbPkVapweKNTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PT8U41mb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B69C32782;
	Mon, 15 Jul 2024 16:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721059640;
	bh=LSAEUqJL/09RkQgjhZDFafNERM0VMMG79YGIIbpCemw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PT8U41mbn+PxGbbqMevegrJfsM7j54wKCWnRE/WBvWGaE4Ys6Rn6Ecfs9Su1vyOxf
	 cfpOLVzFwN7F8L3IBzweEalrPF6+ZYLRq2e0mhMciNPeBd3QcKWieq0PTifsfXCvNZ
	 Kak3uXfMSeN/H9LUbcvJN0ZFs/wRyCVg3NxSDkzo1qbTQYbeu11t3gGaLxAuMELX6M
	 ljn3kN3quAJ31WKUEBfHkPGuJ5QMG2vQ458MIljGFJQkkOjYm8/+tGtjgZsSCYIPT2
	 5/u6ctj2TGHrzgkGJ4wWR/k+bNX9AoNM3zkRrDAmWJLf9uW3/Ey/sCx0nT6brhcaNA
	 gD8hQ74RCbMmA==
Date: Mon, 15 Jul 2024 09:07:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Thorsten Blum <thorsten.blum@toblux.com>, marcin.s.wojtas@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mvpp2: Improve data types and use min()
Message-ID: <20240715090719.71bc145a@kernel.org>
In-Reply-To: <ZpVDVHXh4FTZnmUv@shell.armlinux.org.uk>
References: <20240711154741.174745-1-thorsten.blum@toblux.com>
	<ZpVDVHXh4FTZnmUv@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jul 2024 16:44:01 +0100 Russell King (Oracle) wrote:
> I don't think this is a good idea.

Reverted.

