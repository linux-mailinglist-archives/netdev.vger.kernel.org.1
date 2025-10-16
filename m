Return-Path: <netdev+bounces-230232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E5CBE5A4A
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 00:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 451474E5998
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 22:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860C62E3B11;
	Thu, 16 Oct 2025 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnXI9b1c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6106018FDDB
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760652625; cv=none; b=t8G7h3A+eBnnJE2v4xsjuu78pgx9nDnaZAKY+JW70DQRl4CUVbg8cH/JWe0BcHNYPlZU4vBV7H234mBRgTuX1CV1vtuOAxc8gDI2eiXhxhCItPgk+da0NVTSmiuyopTC2Jc2PxdKLlZn5Aq9QYlE6mQu1H7etXbjUkJDWpQBGZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760652625; c=relaxed/simple;
	bh=gdVBzpoveYtsiWD+dm+5DZdrMTQMI3mdvwLJIb3DHVw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tZoPaWgNiP/U7F918bAtgq5pbR7bTPXow97XHKgkK9YG8sIfmmovnuEb3z0XOQcYnwuxOHZtiywsPtPqB1X8fEudkWAXaC84LtxqVsjBDjgXPtbE6HQJ57xhjuCKvbCrAYTMwvQTnkDNCZh64frgT1vhZR2m1MBA1Yxfs0EGwZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnXI9b1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31B4C4CEF1;
	Thu, 16 Oct 2025 22:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760652624;
	bh=gdVBzpoveYtsiWD+dm+5DZdrMTQMI3mdvwLJIb3DHVw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lnXI9b1cu0ClTFYG7SUtCuPPGYFX2ZUUvvOgt2k0hFBtIM2vN/PybQ9/gcUvTrorR
	 GzFGSQgdYuR/A1iR91MxN1MYlUWNLfEVWRMW9DeD+kdriudPX72V7Pe+UxHWX1hv2Y
	 JFmrvUZv8xrMOxiln4p7cF1oVh5lnVpEib6NSIPZikpyknaeLjRgwSJ6teRFCyWD9+
	 opkUql7ayfCvyKPbt1lnZxsejNEw+TFQFgU60uCpOPZ8cPI/OfQmgNxi0nY+Shut4j
	 HAj5WwVolAFEYTKF4pn3DgQnY/Y1kIaobG2acCZcrg8HGiHxPfVDJKHS17giCUAbxu
	 sKUmFoXgItwDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3700E39D0C23;
	Thu, 16 Oct 2025 22:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] dcb: fix tc-maxrate unit conversions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176065260902.1923966.15696761521517630320.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 22:10:09 +0000
References: <20251011222829.25295-1-zengyijing19900106@gmail.com>
In-Reply-To: <20251011222829.25295-1-zengyijing19900106@gmail.com>
To: Yijing Zeng <zengyijing19900106@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, me@pmachata.org,
 kuba@kernel.org, yijingzeng@meta.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sat, 11 Oct 2025 15:25:24 -0700 you wrote:
> From: Yijing Zeng <yijingzeng@meta.com>
> 
> The ieee_maxrate UAPI is defined as kbps, but dcb_maxrate uses Bps.
> This fix patch converts Bps to kbps for parse by dividing 125,
> and convert kbps to Bps for print_rate() by multiplying 125.
> 
> Fixes: 117939d9bd89 ("dcb: Add a subtool for the DCB maxrate object")
> Signed-off-by: Yijing Zeng <yijingzeng@meta.com>
> 
> [...]

Here is the summary with links:
  - [v2] dcb: fix tc-maxrate unit conversions
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=af33b4800265

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



