Return-Path: <netdev+bounces-108653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39824924D3F
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 03:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8A31C217DA
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 01:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C5D138E;
	Wed,  3 Jul 2024 01:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1OG4VGM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EA739B
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 01:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719971195; cv=none; b=OG2n6Peqhhq7qfp/IQbB+jImoPHDa2kC62r3RerVPENNkkS2q2D3q5bVvjUooC863FsjgEBNrzRfyxUrOBjKoCmKgXpjf6u90CC677lgYF2IfW5OCU6I77aJATLCwhOCxEVz3vWFw6IokY6AWUB2KRw20ccA57FODv/SgDuv+Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719971195; c=relaxed/simple;
	bh=H5wtR/4oG6maolnFTbCbulP/taLpoHRmD9tmG013tmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lmmr3lv9DvqkH+g0dpDvSxJ8DlnC+3erkHkiyyoz29u45jslzgknr9Fzp541AalFoVE2+O1d0G5j2F1dzvytQ+6lYZHTwl4Byxr6JhoV5jVsSv5dXY2Rld9SG4dw/swOPOm05igmGwTfn73UGidfXN2fkWlf5kD4ED7+Au4LYJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1OG4VGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02410C116B1;
	Wed,  3 Jul 2024 01:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719971195;
	bh=H5wtR/4oG6maolnFTbCbulP/taLpoHRmD9tmG013tmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h1OG4VGMWl9pUS/GVpcukIV69yKK7ENKwYuml9BicF3oSXpYoMoav5XPksJ3EowMg
	 buQt3P5rFG6dVyZA1GIJD5XAv/WQHeQK0gFd/bG06If3mfTagsRpMg7mcTExHH6U9s
	 5G+RRXbL+55IxXttZIsb6IcXCxysXhn4pcV1S1RoahQZNr/jnFjHHTq8tO49CJzjHZ
	 5paHEEYW4lGwd54UZuDQaGRbu4MYMI8+7A/V96MtG9XT4c73COnMohsXP3/EqbX52D
	 MVjm3NQL+AfhKQb1frHRSG/vorIPVU0tE55Ta86ruEj1qXOesc+sRm+D5dYxKw24s7
	 KjvWLkUg+X/lg==
Date: Tue, 2 Jul 2024 18:46:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tom Herbert <tom@herbertland.com>
Cc: davem@davemloft.net, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, cai.huoqing@linux.dev, netdev@vger.kernel.org,
 felipe@sipanda.io, justin.iurman@uliege.be
Subject: Re: [PATCH net-next v2 0/7] drivers: Fix drivers doing TX csum
 offload with EH
Message-ID: <20240702184633.1f05673c@kernel.org>
In-Reply-To: <20240701195507.256374-1-tom@herbertland.com>
References: <20240701195507.256374-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Jul 2024 12:55:00 -0700 Tom Herbert wrote:
> Testing: The code compiles, but is otherwise untested due to lack of
> NIC hardware. It would be appreciated if someone with access to the
> hardware could test.

Could you pop a script under tools/testing/selftests/drivers/net/
that'd exercise this?

This will hopefully guarantee good coverage soon, due to:
https://netdev.bots.linux.dev/devices.html

