Return-Path: <netdev+bounces-127714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246579762D8
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 09:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE54282318
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 07:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1DF18DF90;
	Thu, 12 Sep 2024 07:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeQbHF3O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953F718DF62;
	Thu, 12 Sep 2024 07:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126713; cv=none; b=eqDQUVrcHorVP6dcV9G+0snFC1E5F0cCqm9Kgy7zvCV4hev7tnDTUlrvexnwUrih9uXlFK923oXjYJQ38LtuLL8PWLm2fIfSuV+7c5vMBYB3BLRkFozKrepnB9FGF1Zmmc7IqDVc2+96cXRXg+4dKVHnGHAHiNnvCVfFSYH/zDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126713; c=relaxed/simple;
	bh=irrjP1SPtrwhI1dMYbrHujrM85Kly89z4dFpcoZwE3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLb1K85PBu0axSv4R30I0BffXj6gzZJAXGRmrwudAi5VSG4p/QraD2W/TXIDoJ/bbs0cI7sNCTrZvrt0q4/4qq7c0nB6wc6qdxIRiwAr7Q4pn5uw4EtoUFTxuhptzGTO2JgB0nhpMzkpEqSVptRXv66o9skl5CBQnFV51TdZpjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeQbHF3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2BAC4CECC;
	Thu, 12 Sep 2024 07:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726126713;
	bh=irrjP1SPtrwhI1dMYbrHujrM85Kly89z4dFpcoZwE3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PeQbHF3OCytGUlUZaM5mhkjX35bNjWjoTlp7Ebp+oUdiZXUoGjtiaE8x5Z3yS1YaD
	 2EE2kykiTOETNiCuWCzudXp9xBNVzN65BAvN28PjCfSofRfRRtPw2wcqVhAsw76SH5
	 00mVOYFLRLasbeMovJwAEjn3ceYrLvK56gY1et+loChC9qx2qsIq3Ub4jE4Xjd24yT
	 PQXDbgXMbgXF1OADqbNX0HDLShwtZluhpGw7MNCZ+hK7KVq7R2h98CI2vjFZf6JSjW
	 Zxl8UrEmt9o6bg2YQWOV5Es/C66/iK6ReCCLcHaC0HXbpWD+I2H4P5mZeOen1eqbkk
	 Uc+ZmBm+XUwOw==
Date: Thu, 12 Sep 2024 08:38:28 +0100
From: Simon Horman <horms@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: John Stultz <jstultz@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Miroslav Lichvar <mlichvar@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Christopher S Hall <christopher.s.hall@intel.com>
Subject: Re: [PATCH 10/24] timekeeping: Define a struct type for tk_core to
 make it reusable
Message-ID: <20240912073828.GC572255@kernel.org>
References: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-0-f7cae09e25d6@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-10-f7cae09e25d6@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-10-f7cae09e25d6@linutronix.de>

On Wed, Sep 11, 2024 at 03:29:54PM +0200, Anna-Maria Behnsen wrote:
> The struct tk_core uses is not reusable. As long as there is only a single
> timekeeper, this is not a problem. But when the timekeeper infrastructure
> will be reused for per ptp clock timekeepers, an explicit struct type is
> required.
> 
> Define struct tk_data as explicit struct type for tk_core.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

...

Hi Anna-Maria,

I wonder if the order of this and the previous patch should
be reversed, or the two patches should be squashed together.

I am seeing a build failure with only patches 01-09/24 of this series
applied, which seem to be resolved by applying this patch.

.../timekeeping.c:1735:43: warning: declaration of 'struct tk_data' will not be visible outside of this function [-Wvisibility]
 1735 | static __init void tkd_basic_setup(struct tk_data *tkd)
...

