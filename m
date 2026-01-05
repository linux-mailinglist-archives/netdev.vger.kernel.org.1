Return-Path: <netdev+bounces-247126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD557CF4CAF
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D400831673E0
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDC833E352;
	Mon,  5 Jan 2026 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meb/gSBf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376A3199D8
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767630885; cv=none; b=owdhxwuEZ7Hr3Rp8ZrknJAZTvoKA34B16JXmI2FxkCi278sefy2VeWBwoiHK3NcmkxniAdoZAQJg+gRXZBodVhpjMCH2LjYN1nmGhnz+PMBOwL97FbAiWZhPmFYiOiMIXH0badqbMH7KFXU0i3Dkdwb43HAcBM8i4ikz6UT+3uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767630885; c=relaxed/simple;
	bh=3deJ5qLA3IJhBAb1j74dPS91w2GSpuoSfqjZtqKZIMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLuPBefvbnSiQLe0t9GwSe8AFP5iTwSKsRuyt1HykyhbZGSWNeSRR6aRYjkgB5NCIroxE0ATXFEGdAg79vfZVaP7G5cry7089vIoItoSiJFADnrsDKYkS1eC7NcJ8hGySLOBWCnnVu6n/KEg5lV86Shy1kef2TUD+HnHYC8rF+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meb/gSBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB84C19424;
	Mon,  5 Jan 2026 16:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767630884;
	bh=3deJ5qLA3IJhBAb1j74dPS91w2GSpuoSfqjZtqKZIMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=meb/gSBfx0ENAZ3vrXvgpfRJG68hjNCcXTVVDGsTBC9t4HI7hf6F1rxbr7ECSGJBd
	 rPOU5fORuoCdomuf6+kfvIFU0ck9pvJ3+OCP9Pm6mP+bXfxSf95jdPcb2txjgDB4MQ
	 qaY6vxHcUyTVr8ZzQChjAeP5Ih2JUEYbRoLhDdEn46QUPq/7jvdedAPHpEnLc6Dm6y
	 Xk7wM1ZpZ6Hy3xq4WCj9Sd8rKVHO5zONwmQlGSPrCj/MUpNXXmqcsfzlbTmpZivFJF
	 OhaBH9BzIidEO7pTAIGZtynUfxvM4M4xUHH/moouUAbJDtR3GFrxlslhNV13Ie9Iml
	 gDIjQGaJ6jrNw==
Date: Mon, 5 Jan 2026 16:34:41 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net] ice: fix 'adjust' timer programming for E830
 devices
Message-ID: <aVvoIZYBivorDJkC@horms.kernel.org>
References: <20251218094428.1762860-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251218094428.1762860-1-grzegorz.nitka@intel.com>

On Thu, Dec 18, 2025 at 10:44:28AM +0100, Grzegorz Nitka wrote:
> Fix incorrect 'adjust the timer' programming sequence for E830 devices
> series. Only shadow registers GLTSYN_SHADJ were programmed in the
> current implementation. According to the specification [1], write to
> command GLTSYN_CMD register is also required with CMD field set to
> "Adjust the Time" value, for the timer adjustment to take the effect.
> 
> The flow was broken for the adjustment less than S32_MAX/MIN range
> (around +/- 2 seconds). For bigger adjustment, non-atomic programming
> flow is used, involving set timer programming. Non-atomic flow is
> implemented correctly.
> 
> Testing hints:
> Run command:
> 	phc_ctl /dev/ptpX get adj 2 get
> Expected result:
> 	Returned timstamps differ at least by 2 seconds
> 
> [1] Intel® Ethernet Controller E830 Datasheet rev 1.3, chapter 9.7.5.4
> https://cdrdv2.intel.com/v1/dl/getContent/787353?explicitVersion=true
> 
> Fixes: f00307522786 ("ice: Implement PTP support for E830 devices")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


