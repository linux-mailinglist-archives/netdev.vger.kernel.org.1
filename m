Return-Path: <netdev+bounces-200525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF139AE5DB5
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 09:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889A51893C1E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 07:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60547253B71;
	Tue, 24 Jun 2025 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPEmQW1i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B3D24E014;
	Tue, 24 Jun 2025 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750750163; cv=none; b=Qv7+jQzqvEyEjlVhmbjq/N1b8srOeBrhlQ9RgI8lwE8fI/LINDxyjZFl51zxiIBKmFVMQLx5dbdNmT/NrxPh24zt6RziTp94Yh58snxQCGMq/N+A/XPud4Oz6gu4TI6Ff/v5o5w3+aX9HqY4WoDpFeZISJbD9+wL1ANfAG5n5X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750750163; c=relaxed/simple;
	bh=O27h05PvealtzA1SswhnPXVG+5x+RcHWMCkh/jC3fzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYTOtlWXvh1iiHZzgSieIqkjMd/EQVVgPoISNzJVB98rSJ56OFFMWnBCO96EwGH0j/RTtQ+zJT3iE+uEUhPCTA+TFbuDyf4BRs9gAnzsOfmncN1pbFoglNnOxFbpIPezrVXjG++7QR/a6KSnMewXqnaaVDtw79CdNZqaenXEuUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPEmQW1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D785C4CEEF;
	Tue, 24 Jun 2025 07:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750750163;
	bh=O27h05PvealtzA1SswhnPXVG+5x+RcHWMCkh/jC3fzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qPEmQW1inTq4Rpz5TUtePLSc6M6wPN0iX9FAI+ANN3bNbUoGhlMxDrBNp4HIv9N8O
	 IfZFoam4LndvThNLZjiuuozIkQldFXvt6eumbSasbO4ll51KjH0wpn7w+p2gDtX4le
	 SNr5kv6XvlY85pE7L3jZNdA1+qRcUn8eegbfyVTvFCFubK7H1VfA6H140rF76hBRAN
	 k5AMMfiXVOBLFR6KPhbmH55pm91lEbGhYT4zMSW/D6IO1TbA4sM566MkDttt0VMA+m
	 697fFdIMkAx7lPtBbZ/GqzgVUgykeoUilBk51aczraYcbmI58+/DmBDu8uGqPobKaX
	 TjlOImCORjQLQ==
Date: Tue, 24 Jun 2025 09:29:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Joy Zou <joy.zou@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, catalin.marinas@arm.com, will@kernel.org, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	ulf.hansson@linaro.org, richardcochran@gmail.com, kernel@pengutronix.de, 
	festevam@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-pm@vger.kernel.or, frank.li@nxp.com, ye.li@nxp.com, 
	ping.bai@nxp.com, aisheng.dong@nxp.com
Subject: Re: [PATCH v6 0/9] Add i.MX91 platform support
Message-ID: <t5lg2iw2ha3xpqnce64k4xgaim3f2shfe4ccgnqggtouzy2lc3@se4e6ldggjtx>
References: <20250623095732.2139853-1-joy.zou@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250623095732.2139853-1-joy.zou@nxp.com>

On Mon, Jun 23, 2025 at 05:57:23PM +0800, Joy Zou wrote:
> The design of i.MX91 platform is very similar to i.MX93.
> Extracts the common parts in order to reuse code.
> 
> The mainly difference between i.MX91 and i.MX93 is as follows:
> - i.MX91 removed some clocks and modified the names of some clocks.
> - i.MX91 only has one A core.
> - i.MX91 has different pinmux.
> - i.MX91 has updated to new temperature sensor same with i.MX95.
> 
> ---
> Changes for v6:
> - add changelog in per patch.
> - correct commit message spell for patch #1.
> - merge rename imx93.dtsi to imx91_93_common.dtsi and move i.MX93
>   specific part from imx91_93_common.dtsi to imx93.dtsi for patch #3.
> - modify the commit message for patch #3.
> - restore copyright time and add modification time for common dtsi for patch #3.
> - remove unused map0 label in imx91_93_common.dtsi for patch #3.
> - remove tmu related node for patch #4.
> - remove unused regulators and pinctrl settings for patch #5.
> - add new modification for aliases change patch #6.


Where are the links to the previous versions? Why are you not using b4?

Best regards,
Krzysztof


