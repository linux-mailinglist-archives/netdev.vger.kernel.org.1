Return-Path: <netdev+bounces-68033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FAC845AC9
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0B92858FD
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DBA5F477;
	Thu,  1 Feb 2024 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjrGrrKr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4FD5D486
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799763; cv=none; b=ifmuR+ej2HpWGxFc8aG0/IC+b8VTr0HEw2j3Ozjs4yCcL9zF0chUutD4IQ3llRs9OZri6kzzEOVy4LsGB460UPHjX/shIJFd1sLRF+BfOGAHAqHpXb/3u3uFkgdTZuqFcIaopExAYDr55cZby7lnAAjg0ArgXlZ1cAgAMf0d7wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799763; c=relaxed/simple;
	bh=/dIW4OBdklSDE8BXmgaEh4dz7g7RcCH7j+OYgLFXHiE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJrWRu3FhH4VlxMb/lmB7GMEvVDWRwiJdc/aWaWf7tqz0rGZdwtSuKgZJ3jDmoOnKMdVydX1oWXUf1BCACX4SFx8gE3gre/wWgjjJiT4wd16UlF1qTJzpBcCVexwuar12M29DFXCI1GYWWmpgvFLC7SwCnbibC3LUSNftkFztb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjrGrrKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DA2C43390;
	Thu,  1 Feb 2024 15:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706799763;
	bh=/dIW4OBdklSDE8BXmgaEh4dz7g7RcCH7j+OYgLFXHiE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hjrGrrKrzzbEgXpB3QqoKB/PItmATawLCNEqE3U0gLtVQaGRWPEOy4l6iYL3j+l6d
	 vRzZkMIQvtyVvK8PJrurquBeW4EfiNIBSKNF2yLeT9ALiVU6xFf6b84HVX05Ek7YBI
	 nxKCa8ys1mLWx6uDPQwmkdPUncPpvQfwqI79pYD4EEH0LmBkv0fhCiUE0nQqL2PUb+
	 aVoryIvr1Lv7eidzcQUtbjuLQSQ4/vQ7XSm27mnR3Q7UgCHHa/HlEzlI0bsNkYeHJa
	 NP6BarSU/v9BCyy7owyaJf6ipu0bw0W+xU3i0zJLTXedPO8ctruyaFYbxFgGRRPJ8M
	 HRUnnQ/VLvRhg==
Date: Thu, 1 Feb 2024 07:02:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com,
 saeedm@nvidia.com, leon@kernel.org, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, rrameshbabu@nvidia.com
Subject: Re: [patch net-next v2 1/3] dpll: extend uapi by lock status error
 attribute
Message-ID: <20240201070241.469b0824@kernel.org>
In-Reply-To: <20240201135311.GE530335@kernel.org>
References: <20240130120831.261085-1-jiri@resnulli.us>
	<20240130120831.261085-2-jiri@resnulli.us>
	<20240201135311.GE530335@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Feb 2024 14:53:11 +0100 Simon Horman wrote:
> > +	DPLL_LOCK_STATUS_ERROR_FRACTIONAL_FREQUENCY_OFFSET_TOO_HIGH,  
> 
> nit: I'm all for descriptive names,
>      but this one is rather long to say the least.

OMG :(

