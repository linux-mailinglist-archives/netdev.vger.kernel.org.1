Return-Path: <netdev+bounces-183076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A16A8AD0F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A16677A8834
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA5D1DFD9A;
	Wed, 16 Apr 2025 00:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpYpTJ/X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769651CEAC2
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 00:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744764841; cv=none; b=Gaeds/jnExd9FsDo8UPikH+1bhyZos2WdgQbGw775cUFJjQgWhQ6jrBsAp5plb9OKodrTAIGWleW/ItyLV7vC6yrjH+vxMRr5HRtKI6bjyWq0HTAqM+JMmjQzx+SfolbQQ6TFMgKdS6T0xVFEvrsGIGqufTX9F8QCVasWUAlJRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744764841; c=relaxed/simple;
	bh=zTO0PGprkgHrXrHtmLAb9UQPjHOxwm5tC+XNO/WFDMM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCEkGq93aLzS5yZstPh22+fsxKpbtL2gFjVv90q0o3pnGWia9BYB+FqqpRD3cmG2Dm0TpRyODy84JeHIkNyC6bJJGVtJfxocSBoE9sdG2nO/UbPXOdTaRf6tEzD7iaxPWIigghB31Hh/cnfSHFe74/10ShaqRMNupsvmhyu0aUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpYpTJ/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1BAC4CEE7;
	Wed, 16 Apr 2025 00:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744764841;
	bh=zTO0PGprkgHrXrHtmLAb9UQPjHOxwm5tC+XNO/WFDMM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gpYpTJ/XcB6rNrlzdN38czMx28ncPMQWzIk4XV0cH7UgdExtg3aRPzYT/S8Y2y0OH
	 xQm3dnFps5nHcA6JK15Vp1xw2yTsebsBUkxslUPoG3DsYdqMsf8gz3WKMZCEMMtTBj
	 NTtrdi9tYicLe4ALM03thVyzN2SW4iEVCq4nFasbLcEx3zgqhwYAQOB4FDItwuYLaR
	 CE//60QH70NzCGgXI7NHPZKumXZ8W23OyEQpd4IxnVzG3oyTXu/+btdI8ya4Qltu0+
	 0dMTvc8vMkKV/+76f9GybP0MX6TI2LAbbry5SQQ3mY0x1cYNOLHRiwyhr7fdXbl5XY
	 Om/IrgVbCbtUg==
Date: Tue, 15 Apr 2025 17:53:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
 <jdamato@fastly.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Igor
 Raits" <igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>,
 "Zdenek Pesek" <zdenek.pesek@gooddata.com>, "Eric Dumazet"
 <edumazet@google.com>, Martin Karsten <mkarsten@uwaterloo.ca>, "Ahmed Zaki"
 <ahmed.zaki@intel.com>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: Increased memory usage on NUMA nodes with ICE driver after
 upgrade to 6.13.y (regression in commit 492a044508ad)
Message-ID: <20250415175359.3c6117c9@kernel.org>
In-Reply-To: <4a061a51-8a6c-42b8-9957-66073b4bc65f@intel.com>
References: <CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfpr7dnZxzGMYoE44caRbgw@mail.gmail.com>
	<4a061a51-8a6c-42b8-9957-66073b4bc65f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 16:38:40 +0200 Przemek Kitszel wrote:
> > We traced the issue to commit 492a044508ad13a490a24c66f311339bf891cb5f
> > "ice: Add support for persistent NAPI config".  
> 
> thank you for the report and bisection,
> this commit is ice's opt-in into using persistent napi_config
> 
> I have checked the code, and there is nothing obvious to inflate memory
> consumption in the driver/core in the touched parts. I have not yet
> looked into how much memory is eaten by the hash array of now-kept
> configs.

+1 also unclear to me how that commit makes any difference.

Jaroslav, when you say "traced" what do you mean?
CONFIG_MEM_ALLOC_PROFILING ?

The napi_config struct is just 24B. The queue struct (we allocate
napi_config for each queue) is 320B...

