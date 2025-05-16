Return-Path: <netdev+bounces-191224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869BBABA6A8
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 01:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5ACF9E557C
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870F3280A4F;
	Fri, 16 May 2025 23:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbXW0+fh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E605280A3A;
	Fri, 16 May 2025 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747438812; cv=none; b=ZB25XuSww4oe++BTTZVEOmXgfx86/ITK8qVLUA0Yepc5gi2+sZSDtsOc1g37HpwAyeq1DJlfjGtuWO3pLf4mLGpPc6d6W8ca/qXWTN8xr9xDHUSivlUdAZxZPmH+NWKUyHSoZsXfcpkrAZGvlVLw7NXg67DrV+fbCYIBhzIY18Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747438812; c=relaxed/simple;
	bh=2wztyBXxOGcEiedsFd8ApQEJP6P3565tlm2K7lr01eM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kuZQ+R2UAJ3SgYK6dsAuVXI6106/LPpCwagu410U5ab0+Tbi3s7Sl0TQHEWVxzTLjn+gJn04ZUwglaIodoO9P3JcLfmsQK280+wGMlhHD0xVp89PSI0tT3CktdG1E2M4CL2l4VsEiTdkkEFMdQ9tleRHS9415THVeSGJ9qnC6ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbXW0+fh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864A6C4CEE4;
	Fri, 16 May 2025 23:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747438811;
	bh=2wztyBXxOGcEiedsFd8ApQEJP6P3565tlm2K7lr01eM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HbXW0+fhRJxASDJElHg5BFeC/a5dgevV3uGLbBZiqa4hpdztDVHWoYvZrtIJyUL84
	 ILcw8PQLHJWnrpDd7spHthi1lKz3oJ34VXmiJBiyIEEfJYCDxmGcOduAOgJr4tbN8Q
	 OqSRza6r6IlFm9JXJipBbvDBXKcy3pAfkF+bxJ1+Zg8qafkIJo/mwDgmGOXh38YkC9
	 +wAL/OQgKAcxI/JDIoOfN+eA1QeQsEQzYPZsmrq+mkyuYTbwSqbXV5bQNE+UnZ+8LY
	 cjijfHKRJiNR/8Hg+TZ0l7SsIbEMlNLMlfk/Q9zInYPESqHplQOZ7XkhqJU3xN3jnK
	 EMBeChQT8vmWg==
Date: Fri, 16 May 2025 16:40:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 net] net: lan743x: Restore SGMII CTRL register on
 resume
Message-ID: <20250516164010.49dd5e8b@kernel.org>
In-Reply-To: <20250516035719.117960-1-thangaraj.s@microchip.com>
References: <20250516035719.117960-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2025 09:27:19 +0530 Thangaraj Samynathan wrote:
> SGMII_CTRL register, which specifies the active interface, was not 
> properly restored when resuming from suspend. This led to incorrect
> interface selection after resume particularly in scenarios involving
> the FPGA.
> 
> To fix this:
> - Move the SGMII_CTRL setup out of the probe function.
> - Initialize the register in the hardware initialization helper function,
> which is called during both device initialization and resume.
> 
> This ensures the interface configuration is consistently restored after
> suspend/resume cycles.

Is there a reason you're not CCing Raju Lakkaraju on this?
Having a review tag from the author of the change under Fixes 
is always great.

