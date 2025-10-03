Return-Path: <netdev+bounces-227800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 348BFBB7827
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 18:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 214604EB45C
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 16:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B3619DF4A;
	Fri,  3 Oct 2025 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eI3tL9jY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878E84A23;
	Fri,  3 Oct 2025 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759508252; cv=none; b=gPnw6215B00sWaseDyt+xS+JR8kB3+RZ+RkIWF5sjLgTJx7sc6CtxuSf0DXp9YDnJEE2VkU8ylLp14HIPh/lEEgNcA5sZjC317qCp69j5uiR3EhzcZrOtshAuv5GspA29/zfFq35T5vxQXHDg/9kr+fK4Z+011G9U/Kbxekf74E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759508252; c=relaxed/simple;
	bh=carYbeZjOwIqkAnU67dPJv3O0JYLjYCtle9hufrjEYI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4e/Oc3r+pvF8S0ni67zIQIjY8QvRnOg7x0SfiHsYSIGmc/A14sWuS/kyuJrCK2pwC9maDCI4C0dHIsKDrCVmpOHcpgOdp1+CdqUGGg+fmMOeLf21OdaTuFLjOdAHBwg5hv81o9a7mzUWFL/fziHLxzkyG05nUVx6nsfDL7cDV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eI3tL9jY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB12C4CEF5;
	Fri,  3 Oct 2025 16:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759508251;
	bh=carYbeZjOwIqkAnU67dPJv3O0JYLjYCtle9hufrjEYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eI3tL9jYFXtD8ui4ouQGaGCjB7zkO3XPZectl+eYYKauSi0r9uLMQgc0kLLQeameH
	 5Ql5ias6VWrF1/l00bkbi2XdxVa0p3/PVRWVQ8puaF+4xZEDhZEeVtMbOq2EvUK2tA
	 uJ4pHt+o6vkIujMQmi7HQaKIfwgnnuyThkdTJpxHDrRgudOeF1SCRxPW8oHDBYJ+yE
	 y276Mfuzhbjodjy2+gZ8wSmlHNR9dGBWwLdUKbYqoV9e3t32wWDaKHt3stjOFf3E3O
	 6D8UfXJrGFKCVPpnWheDKdFAEhqUNPI4iFDxpNnz/XXfzoqp4mA4Pnu0mvVgxKEjI2
	 LXyS86BnqSf2A==
Date: Fri, 3 Oct 2025 09:17:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: khalasa@piap.pl, khc@pm.waw.pl, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] hdlc_ppp: fix potential null pointer in
 ppp_cp_event logging
Message-ID: <20251003091729.3158a8db@kernel.org>
In-Reply-To: <20251003092918.1428164-1-kriish.sharma2006@gmail.com>
References: <20251003092918.1428164-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Oct 2025 09:29:18 +0000 Kriish Sharma wrote:
> Fixes: 262858079afd ("Add linux-next specific files for 20250926")

This is not a fix, please post the next version in 2 weeks
(after the merge window has closed) and without the Fixes tag. 

The warning (not so?) obviously doesn't apply to the kernel. 
Kernel print methods will output "(null)" if you pass 0 as 
the value to %s.

I defer to Krzysztof on whether we should proceed with this
patch as a cleanup, but -Wformat-overflow= is disabled in 
the kernel builds for a good reason. This is not a fix.
-- 
pw-bot: cr

