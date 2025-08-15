Return-Path: <netdev+bounces-214163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5543AB2862B
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 21:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F605162E05
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EF71F4165;
	Fri, 15 Aug 2025 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCXPE1YO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEDD1E25ED;
	Fri, 15 Aug 2025 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285063; cv=none; b=OP3F+Ho66BiA9nKgJTZBdaVWg1gfzVCgvqNSOAkOpkLwhKuv37wuMzIGq438iWXZZCQJoHFs1YVxci9+yg3Lb7/BKqdVN8vxTjLjpSSD732MJZd03klC0mc+X1znx/IvUy0fu5cHaQfigwlA2NQa78+bv4n11GKZoqsr1RGsuSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285063; c=relaxed/simple;
	bh=vi4JZCzQaIOo6AYcyN/WiciqpUOBs2ZXoGMYOF8B8YA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lrA7wm3PTVE8ZMq4jAt4xvKRNxeqmYVcc7BYINlY3PuyUtljh+KJlryJnSuQvaZzGVM3+TlAlm0A6xHbdvZYY05ajnlNkhOjqAUeXRq4CXPYtLopzRp3B+iCiG3uwLcvXGnSwU2uN0XRmaNVM707gI3JmhRZ9LePQvxOO2eyJrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCXPE1YO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CE5C4CEF5;
	Fri, 15 Aug 2025 19:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755285063;
	bh=vi4JZCzQaIOo6AYcyN/WiciqpUOBs2ZXoGMYOF8B8YA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NCXPE1YOAqp4f9UVA700lPdHDTwNEoqqLTbZuTIkP47Nf/eNd+imLlBHGXNOdpy7/
	 NqmuA5NZKYwJJcbKLxAgsLaNkgInPtbKklsGDeC89SkPEue1nasDH4evyJ0mTcHbid
	 AKP1kZoiY/RpynRGkMKX6n1Ycd8xn+tC9BQuRH2ghqbopM6XA1PYQrFCRu1/PJEtjL
	 h2qwS59+LGiWiulV5uKHZMptGjHvVHWXMo9VUW56udMMNyGYUncmxhfpI/LPnIbV8Q
	 zA5eXa17gdjfYfgPcxPfRTpA2LTjLoTkJuzjkogfApQNPvA5QGmVfO5xqA/IirCNtB
	 R9XdrtOOryo2w==
Date: Fri, 15 Aug 2025 12:11:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chris Babroski <cbabroski@nvidia.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <davthompson@nvidia.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v1] mlxbf_gige: report unknown speed and duplex
 when link is down
Message-ID: <20250815121102.0653f13f@kernel.org>
In-Reply-To: <20250813163346.302186-1-cbabroski@nvidia.com>
References: <20250813163346.302186-1-cbabroski@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 12:33:46 -0400 Chris Babroski wrote:
> The "Speed" and "Duplex" fields displayed by ethtool should report
> "Unknown" when the link is down. Currently, the driver always reports
> the initially configured link speed and duplex, regardless of the actual
> link state.
> 
> Implement a get_link_ksettings() callback to update the values reported
> to ethtool based on the link state. When the link is down, the driver
> now reports unknown speed and duplex as expected.

If that's the correct thing to do why is
phy_ethtool_get_link_ksettings() not doing it?

Please explain what makes mlxbf special, and make sure to CC PHY
maintainers on v2.
-- 
pw-bot: cr

