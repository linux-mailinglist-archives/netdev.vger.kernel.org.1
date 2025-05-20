Return-Path: <netdev+bounces-191906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5024AABDDE2
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF6F503637
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F026524CEEA;
	Tue, 20 May 2025 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeo+kKSE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD8724C692
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752135; cv=none; b=GQ+EKw0PyWWArTqVbr3Vj2224DXdaPfHSyObJl3+0/6YU6n4tZolWdqD0VxtJprFJjJjYkfPgvbEW7pDrw/4xAZ+mgj1QIruzP+onPydSvJrmsFSYFvoIjamgEsHg+xPTOAx3sG0bdFpeWhJ6pE+qsiijmvv8Fw6utu1SNH1UgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752135; c=relaxed/simple;
	bh=RGSpyXETIuV3zSCeThB5l/TUO4EIfcpqIbHjzSx1Bwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6GyMki5JFS+rbaFNv5GvgjzUn0QQbUD2czZMhC7f/E3Z8bfHQfxJz6Vd+69bexsHCTdiHnsi77LjdxwIbUW4XXDVchsMOU/v2Mhmqkuo3PjNY5LmhXEo9ErL3blxqyCrbmrdrlM2cPy2SXuXe+nvlervEJy5pJidOlc1XMfSfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeo+kKSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6C2C4CEE9;
	Tue, 20 May 2025 14:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747752135;
	bh=RGSpyXETIuV3zSCeThB5l/TUO4EIfcpqIbHjzSx1Bwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jeo+kKSEM2SV+r2Bhr2FE4by174uubZyE0mV4ngbNybbfrp1m+NBt9uNUYJBEX1at
	 P8S/X+aGeH9OOREX+cz3nhlFiGg0cMeM8hat7EXeP1ToYVX0qYHCbINWrRLMVRjJyZ
	 MmVXBbXNBCtopCDSF3TaWdBSqYTws7sdN41I4WXJOAWAtW0pWxggXNmegrOVCGUvDX
	 a5pQmheTERHZ4+8n/SlIWkaU8OUqu2OLMvx/OgBqcixnrJJu9QxSq0luTNQssqfrNO
	 TeEheUsRH9ozdH9+k5nFHFzcvHHpIhcz59d7UHPdmevrLIEQ4Wh7HtV1r4L7rs+wmC
	 el9rX38a68jQA==
Date: Tue, 20 May 2025 15:42:11 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net 3/3] bnxt_en: Update MRU and RSS table of RSS
 contexts on queue reset
Message-ID: <20250520144211.GX365796@horms.kernel.org>
References: <20250519204130.3097027-1-michael.chan@broadcom.com>
 <20250519204130.3097027-4-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519204130.3097027-4-michael.chan@broadcom.com>

On Mon, May 19, 2025 at 01:41:30PM -0700, Michael Chan wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> The commit under the Fixes tag below which updates the VNICs' RSS
> and MRU during .ndo_queue_start(), needs to be extended to cover any
> non-default RSS contexts which have their own VNICs.  Without this
> step, packets that are destined to a non-default RSS context may be
> dropped after .ndo_queue_start().
> 
> Fixes: 5ac066b7b062 ("bnxt_en: Fix queue start to update vnic RSS table")
> Reported-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


