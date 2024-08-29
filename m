Return-Path: <netdev+bounces-123347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD5E96497D
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF381C21097
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53C01B1414;
	Thu, 29 Aug 2024 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uio2gy9T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C7C18A924;
	Thu, 29 Aug 2024 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944164; cv=none; b=nu4+XtLpVBP1noYy1gwFluq2aZQE/xVDbHwzj3LqXGLfP4beMOMJXj6pG2QgK+jqK2QrBUBReIlaxob3LuO/C3uHQ3Cio3bsQUpEi1hvqCcSk9GnWBvTGZHLDnV7EUzfW6UTUQyIUbmBarHcZfJ1v7sh9N0c0WuXP+wpYETEK+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944164; c=relaxed/simple;
	bh=OnGwgB7o0BmEoZTUNo9VL3hlcwZq57XInYpn69sTAQU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IT/6pwXsSNgHVYEdl+i2EYCvw9ZAEAUZewMHQU3du2lyurJnpMZidSZUM0l0mNuV/tWLXwF8e5femEQX4qYcCEP+QEpdFJnMoEUtM8ffBqJPivAgZZOR0FNJwBWoBoqizv5ywTdigcPh28rVjxebI7a9auQKhw+D+eR3P2pEQvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uio2gy9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5505C4CEC1;
	Thu, 29 Aug 2024 15:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724944164;
	bh=OnGwgB7o0BmEoZTUNo9VL3hlcwZq57XInYpn69sTAQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uio2gy9TE9Mq29b6TZMdTX41DWGMrBP5cFIm93Q4Fcg5WiKigoFvrsOoSW/eW9s1q
	 VLdQwNr6VEmuz4olvZZMqEJs+F5bR6Lw7v+PRAzhXn23vmDw/Qo2XuYCSgu82ZkhqI
	 JB+fVV+uq+bROXqI640GQ/wWZKYnoGVeeIoESIEOvqO47qIBDhngbCVXcwWgjmXwoz
	 pcE07axJe3tawyGOt1tdIL7W5ldUREaQkRWagHLm7LPj7KR0nOMdj5F6owBUC4TWoy
	 vidNSDXWli/UCVt1/RR4MI82YGqLxhJiiW7FajAuZpPypUWybCVbhEIoTliWgu/YlD
	 lC0E+VlhLgb1g==
Date: Thu, 29 Aug 2024 08:09:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Edward Cree
 <ecree.xilinx@gmail.com>, Shen Lichuan <shenlichuan@vivo.com>,
 habetsm.xilinx@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] sfc: Convert to use ERR_CAST()
Message-ID: <20240829080922.254736cd@kernel.org>
In-Reply-To: <4fe03d79-d66e-d33a-b5c6-4010f8bdff40@amd.com>
References: <20240828100044.53870-1-shenlichuan@vivo.com>
	<6e57f3c0-84bb-ce5d-bbca-b1a823729262@gmail.com>
	<63d45a76-6ead-4d62-bbca-5b1e3d542f1c@intel.com>
	<20240828160132.5553cb1a@kernel.org>
	<4fe03d79-d66e-d33a-b5c6-4010f8bdff40@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 07:47:34 +0100 Alejandro Lucero Palau wrote:
> On 8/29/24 00:01, Jakub Kicinski wrote:
> > On Wed, 28 Aug 2024 15:31:08 -0700 Jacob Keller wrote:  
> >> Somewhat unrelated but you could cleanup some of the confusion by using
> >> __free(kfree) annotation from <linux/cleanup.h> to avoid needing to
> >> manually free ctr in error paths, and just use return_ptr() return the
> >> value at the end.  
> > Please don't send people towards __free(). In general, but especially as
> > part of random cleanups.  
> 
> Could you explain why or point to a discussion about it?

It was discussed multiple times on the list and various community calls,
someone was supposed to document it but didn't. So I guess I should...

