Return-Path: <netdev+bounces-160314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1F1A193DA
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 15:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E63F3A91CF
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 14:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B50213E86;
	Wed, 22 Jan 2025 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUrNnsus"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0219213E7E
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556038; cv=none; b=n0pweqqtlRLVAShiJF/FEjAw+P12FKYbWT5nSxz/pSf2KUWhIzh1PMSwZR4fBh7qOTuhUWqdTwT5FFfwmRl6SWiDQDLNSNkN4vTCBU0F8pz68YdvnA/u8mFCXpfbbMwEwyaJY+LFs2xffY7LYVXQ2fE2n99rKWbHCDTtayF9LAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556038; c=relaxed/simple;
	bh=AOSRkDeK70uNkl6bciGnAttSd1pDIxBL696vg1h1KDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WavMG6LEMQoGbo2B043LaHreuuW+mixdHps4S7MEI9B78XDsD6n1ua8Nnww7SbtTXdt22iwPYRG+6JSzKJDFBFe6fvi0SCV5R65d2QVufa/tjS9TbmdZbvSqUHVDMcyJBiZsqY+a93mc44D2rJLy+RuDRA7GWMzs1YFWkZCO4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUrNnsus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4A1C4CED2;
	Wed, 22 Jan 2025 14:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737556035;
	bh=AOSRkDeK70uNkl6bciGnAttSd1pDIxBL696vg1h1KDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jUrNnsus7TKcgG04d9fgV52LT0Pn39GU3AV/88cTTFqyW6umsjrS2Si8tfmoUaAU/
	 57byeDXTISxPtxxzCxOhfu/UHQGr3B5UFvWGw3I2cgs6sfxA3/C69bLKSyyaiqdfgM
	 BzwiB3zSz9GveDjksJm1I3jtWFV3mpWGTRABX1G6MsN/e9slNOICd4GpF4+OAn8exM
	 /PU5Bt2CZQV9dpcInQajO/+H8TvXA0GEmdVLGxicc4t1iGvBYRU5/vtp0TIBLjTgtQ
	 t+hf96sQoA0D+pEqMyrw82Uaz6BmhJiTNHlcB4U/rR4kQqL+eA0xbxOIVG5LcDZ5pt
	 fqV64Buwdr4Eg==
Date: Wed, 22 Jan 2025 06:27:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 dan.carpenter@linaro.org, pavan.chebbi@broadcom.com, mchan@broadcom.com,
 kuniyu@amazon.com, romieu@fr.zoreil.com
Subject: Re: [PATCH net-next 1/7] eth: tg3: fix calling napi_enable() in
 atomic context
Message-ID: <20250122062713.09c9f8c9@kernel.org>
In-Reply-To: <CACKFLim4WrqAPY-WB2C8Q8n49nFavi9xtWV1Xu3d5=vX91fsSw@mail.gmail.com>
References: <20250121221519.392014-1-kuba@kernel.org>
	<20250121221519.392014-2-kuba@kernel.org>
	<CACKFLim4WrqAPY-WB2C8Q8n49nFavi9xtWV1Xu3d5=vX91fsSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jan 2025 23:41:53 -0800 Michael Chan wrote:
> One minor suggestion is to add the Sparse macros:
> 
> __releases(tp->dev->lock)
> __acquires(tp->dev->lock)
> 
> to tg3_restart_hw() since we already do the same thing there for tp->lock.

Does anyone actually use the sparse lock checking?
IIUC it's disabled by default, it's too noisy.
netdev_lock / netdev_unlock don't have the annotations.

