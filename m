Return-Path: <netdev+bounces-160551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995C6A1A22D
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 11:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33F116D2F2
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 10:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860FB20D516;
	Thu, 23 Jan 2025 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVWJ/1Z9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6192C1C5F14
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737629305; cv=none; b=rgwwoROT8iyvoN6r39cw2QMGa826XBNlZQGLgeevJ0hTs8LmTca70I03Hy5jPysDUiKJDxpIuoF4gd0/dGRxipuAC5Nbpg3b5zPAcjd3autQttM4Y/STOh++hgh4fjoMO4G0uZSNHe0c5/669cHvXcJE73ClHAGoLufCGOQsu7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737629305; c=relaxed/simple;
	bh=AWAIN9O6xNoFyl3C5OyI7LR36ZRIB6u0JE1o3Wr/u/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeBfcISGydyI0isjSGmYfb2EQ01MOShi8Am0icgR8Sg4AIUCxXdM6u58oGNWQfmZgd8aDB9A1dqxfJn7/l/ZIFeqbE5EA0arCgiSPAQ5sFV7i3To+NY3Lfeh+9B3zzUjJCs+i+4WDTHZae4hyIp5gq/UqDJoXDDB/udZnMm18gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVWJ/1Z9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C34EC4CED3;
	Thu, 23 Jan 2025 10:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737629304;
	bh=AWAIN9O6xNoFyl3C5OyI7LR36ZRIB6u0JE1o3Wr/u/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVWJ/1Z9yMXny2XMIXH+KWjs3qo/cLTWcojdjEKso1r9fcdhKqwT7Eurs3//WVJVh
	 aCeRq/81g7rs/wsHXRgBf78MEeWoVcsMkynCsu3PH1+mkk636+Zk+kEn7TXeCmVfuo
	 8wxWVH8uo8YcoRXX/IS+4NOEU1By0soAUFjApstuyPgFiF7kv559Uzw8t6c5u0DXKg
	 m/dTnmnyCknVwtqSq6BvEH8HXnnMKqyivQTZLxIFVnyg+AhqzVS2KBF2gQKsaj9MG8
	 WJFpdrgZbIc4rAcOUHPc94FhCKOUrWuWpMSMEcZAZT0WcDkPzj4jWRRcsxdU0XSuh9
	 cBfidXLuN6Y8g==
Date: Thu, 23 Jan 2025 10:48:20 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, dan.carpenter@linaro.org,
	pavan.chebbi@broadcom.com, mchan@broadcom.com, kuniyu@amazon.com,
	romieu@fr.zoreil.com
Subject: Re: [PATCH net-next 1/7] eth: tg3: fix calling napi_enable() in
 atomic context
Message-ID: <20250123104820.GM395043@kernel.org>
References: <20250121221519.392014-1-kuba@kernel.org>
 <20250121221519.392014-2-kuba@kernel.org>
 <CACKFLim4WrqAPY-WB2C8Q8n49nFavi9xtWV1Xu3d5=vX91fsSw@mail.gmail.com>
 <20250122062713.09c9f8c9@kernel.org>
 <20250122154833.0e40aa86@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122154833.0e40aa86@kernel.org>

On Wed, Jan 22, 2025 at 03:48:33PM -0800, Jakub Kicinski wrote:
> On Wed, 22 Jan 2025 06:27:13 -0800 Jakub Kicinski wrote:
> > netdev_lock / netdev_unlock don't have the annotations.
> 
> Looks like sparse -Wcontext is happy either way, so I'll add it.

FWIIW, I do notice when these annotations get flagged by Sparse.
Well, at lest some of the time. Though I do confess that I'm not
always able to figure out a satisfactory resolution.

