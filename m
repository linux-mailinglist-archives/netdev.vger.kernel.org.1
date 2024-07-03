Return-Path: <netdev+bounces-108975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CE19266A8
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208031C2211E
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425D018306D;
	Wed,  3 Jul 2024 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaBkYP/h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6A4170836;
	Wed,  3 Jul 2024 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026159; cv=none; b=gugdep+fjY53ycePto8ufm/19aI3FKD9ps7cL4yd5nVFv3DPtHLLfv+uOuYLRiC7HiVnyemH2mv9TSpD5Vk5n/pJsKylWtWtFJ4msoBlYbfAgLiDtermpCaFWji7p013s4ODrxAL+NQpCCx50oZtbiodnCJ72wZdZMTbzAkVKCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026159; c=relaxed/simple;
	bh=PczAW3qLn/ZbrfRaQqhYjDMYqJS/LfKdlXR5ihFzx2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6CgVq0IqmYTouaGBqqYWUDSda5W4DY2k2uS2qida11Xva03ti8qZ8xOSvDoCD1SVi2TkLkf5HoeS36v40HbTpQ5vctcGQdkZMjqSaouFy4H0ph0H7+i7idwSDGfERdHLnefEg9YJhqALTfUEuPrAu9/gHQ4tQC4xhE4s99lB1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaBkYP/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17006C2BD10;
	Wed,  3 Jul 2024 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720026158;
	bh=PczAW3qLn/ZbrfRaQqhYjDMYqJS/LfKdlXR5ihFzx2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XaBkYP/hvzAlf8gahQ4hAT/f6d+MKvm2v2Ed3N5BB3OSH5ycQUknSGxS1fNywn04I
	 CkpqhIxaAU2A1ob8gaAgLXK6ERJ3TWjga5ITGE3qrl9fhUl0CX7inYNjVzr8vqA92h
	 fYTeCUjONJHQDra2Z6vpsINHqSMc4yntsHKPi1InuDgJpU0zLGcOfYQf43hgVpCrLn
	 eWaYplyHAwIyApRdjMZhvaCb/Yd38nC+ohb/LhyIYtyLLf4BSw367qWFVR9jEiPMW2
	 3edxn3q7cGiDyQ/KW3kHBUQIYIHzzXb19WMXFngl8FFwYdEGW7rylSR4LhP/Ft5jsk
	 OXgzCd0/JbVJw==
Date: Wed, 3 Jul 2024 18:02:33 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	rkannoth@marvell.com, jdamato@fastly.com, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v22 06/13] rtase: Implement .ndo_start_xmit
 function
Message-ID: <20240703170233.GY598357@kernel.org>
References: <20240701115403.7087-1-justinlai0215@realtek.com>
 <20240701115403.7087-7-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701115403.7087-7-justinlai0215@realtek.com>

On Mon, Jul 01, 2024 at 07:53:56PM +0800, Justin Lai wrote:
> Implement .ndo_start_xmit function to fill the information of the packet
> to be transmitted into the tx descriptor, and then the hardware will
> transmit the packet using the information in the tx descriptor.
> In addition, we also implemented the tx_handler function to enable the
> tx descriptor to be reused.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Reviewed-by: Simon Horman <horms@kernel.org>


