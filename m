Return-Path: <netdev+bounces-143805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 133169C4428
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 18:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E6B1F26602
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 17:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFF71AAE19;
	Mon, 11 Nov 2024 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLtk0Ral"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1332D1AA7BF;
	Mon, 11 Nov 2024 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347372; cv=none; b=oPD/OFtvmtjR2Jgq0FBS6dM86uMza/P9IJlCxbW7cnqzd82yuCLzwnerH1ihl4SXtJfN/4sFStprwgdN2oirzXyQpKB690dBuhfswnpFqqESPiD1+Swefc1UXqGYIajp6mQ1cxx4CL216b9V35Odow+WyqnRoR0r040sgoG2bWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347372; c=relaxed/simple;
	bh=L3GZntAmPUUqW5omPxjEYocwCLXEPfEJFR8CPMxG9Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImIA9jktobgLhHuump9TLCsHH7oF6jDOV7UqfIwVQnkU/0Cnyt4N1LSk3FOAz/2J9aa9IhHPnW1P7qBpuW6HtKV2euUl5npBvz3adzVqFfsPThhECvwptE/ym2a0ELUk+lN1jBbzIzUZWZ6tTSik11PxYiQxDHIJaHwCxoVdHZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLtk0Ral; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC369C4CED4;
	Mon, 11 Nov 2024 17:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731347371;
	bh=L3GZntAmPUUqW5omPxjEYocwCLXEPfEJFR8CPMxG9Lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLtk0Ral7YovejtQjT1ZaOLi3t2OdfteZHFsXcyw/f7JHDFZcHRmf5Ht78b83h72u
	 kgi/asrgJz0qo97qJAnMRJysqLCUMzjrQE719esda9tgfyswfxhGNFICCU5wBprtNE
	 374jYnmcdO1oM03We24f92wlgDcuPuO0ZVqCushAQ1NrXQMjSnx3mHELqjwujEBg37
	 Qf1EwwzORVhXid04xCHY7X/Wcrdn9P17aV4xw1gAlHsMga2OiWWA8rlRzfZwpvUMkz
	 16OtB3TlwAtd3QW7/NwVqEBAmMEIox+hzDxP+xtNmoh1F8fDx9Cp5ia6DOPYl+8Y/L
	 oYQI/r7u37QpQ==
Date: Mon, 11 Nov 2024 17:49:27 +0000
From: Simon Horman <horms@kernel.org>
To: Nelson Escobar <neescoba@cisco.com>
Cc: John Daley <johndale@cisco.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 7/7] enic: Move kdump check into
 enic_adjust_resources()
Message-ID: <20241111174927.GK4507@kernel.org>
References: <20241108-remove_vic_resource_limits-v3-0-3ba8123bcffc@cisco.com>
 <20241108-remove_vic_resource_limits-v3-7-3ba8123bcffc@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108-remove_vic_resource_limits-v3-7-3ba8123bcffc@cisco.com>

On Fri, Nov 08, 2024 at 09:47:53PM +0000, Nelson Escobar wrote:
> Move the kdump check into enic_adjust_resources() so that everything
> that modifies resources is in the same function.
> 
> Co-developed-by: John Daley <johndale@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> Co-developed-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>

Reviewed-by: Simon Horman <horms@kernel.org>


