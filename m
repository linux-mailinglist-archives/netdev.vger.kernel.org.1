Return-Path: <netdev+bounces-229662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 319E6BDF8B9
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC9A189B7F8
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6F629A9C8;
	Wed, 15 Oct 2025 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrUZlyql"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712FA251793;
	Wed, 15 Oct 2025 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544388; cv=none; b=F1YSdlstA1RFHhBUWwTSS4/IKZq49nNgGFIQ4HVOebo95H9AVXaGTjcExcUaMDkKamgTpqJ8AH9Z6mizxKQbteMu3ddrGf4ZYKmgRPtbN7TSKgeFEzw4fjbmayqkhur4k5MzeSKx0a4zA/uvlYPJKM8PqQgAtkyX9J0VWy9Or24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544388; c=relaxed/simple;
	bh=36wvgkxUgybT9jKiuwNVYIkH5W5KCOcXkZLMXlDzl+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Znenau+R/JZR5J/DGYp9Bw6eeWO+1y9dBq1QAPKcRrIwk6CawiegYUUGZxbLZ9itzDEQyUiNxtrmUzW/c49QMsYakZjTmZySQbAcHxkA/hvR0rvNL1S7AjcDB4QqUGRfIIW9/4ZT+OaQ99XvAIcLAt1FuIPMoXNkqby1HgKi0w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrUZlyql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF48C4CEF8;
	Wed, 15 Oct 2025 16:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760544388;
	bh=36wvgkxUgybT9jKiuwNVYIkH5W5KCOcXkZLMXlDzl+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qrUZlyqlHM+ceh+6TbjjLe8o7OLqVAsL1FLCSLbF79Kuk14YlGoiQfpSa3zJMk7z9
	 mdduyflt2UDbyEqRo0MrsLBp9L2hAT2VBL/h8AlyxpwZQS+zVyKnD5AbSVsmWaPYoT
	 poF7qz0b5wqzlBscxlHiDdlOvmjRmQeTjqseyfCPYP4DbeOkdY5reImgLzrhIamJPE
	 kFBu/xvyaReOKMbm+mTZLILCmYjiXQKD/sFBGQtTi/+ubbVstuBFOJFx/u2rLN453B
	 WNyRA9U+eS4zaAxjB044Ra8hztNvlUAMToj6VOERb0pahcp5X6HfMIcmciojKsRJak
	 0AQLPs0E3BwNA==
Date: Wed, 15 Oct 2025 17:06:23 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 02/12] net: airoha: ppe: Dynamically allocate
 foe_check_time array in airoha_ppe struct
Message-ID: <aO_Gf4sYHi6BoKCr@horms.kernel.org>
References: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
 <20251015-an7583-eth-support-v1-2-064855f05923@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-an7583-eth-support-v1-2-064855f05923@kernel.org>

On Wed, Oct 15, 2025 at 09:15:02AM +0200, Lorenzo Bianconi wrote:
> This is a preliminary patch to properly enable PPE support for AN7583
> SoC.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


