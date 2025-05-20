Return-Path: <netdev+bounces-191982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E81ABE164
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52FC9188685F
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B0B24EA85;
	Tue, 20 May 2025 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sw5TivHC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7415E35893
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760285; cv=none; b=MivZR0gD5u85m+iEoqllMlM0O6xDdJ61IgMnaUXF86ff3P3VkddtiFGBdqjBKwpJe0bRf50lYb5fpZVruyTtxpVrCDt55CEybgRSs40YHLO/9Y/s7Gt2p+8Zw1ZZcs9hbI4U1UHskCwomyJX8uOfMkA8uF+C95J6i9w45ErDm/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760285; c=relaxed/simple;
	bh=1yMCsLR9ydamW1xTO+Tv3ZIQLOtmHuOkYEY1u/0nFUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VF2n4GWmAo5J3/tf/lLFJA35tjNIOx+Ib1elH37Rya4DsQEso7+xzcJROlxKdlrakIdo7bg+RoMVf9rRK1TVTr8aBsHt5hdudGda1mcmF2vlJ+Seq0cPRUdd70JpRWF7xkPXBsRvl0XUXP7IiC8IU5dD6rBvAIG13EMU3fSj9BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sw5TivHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19378C4CEE9;
	Tue, 20 May 2025 16:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747760284;
	bh=1yMCsLR9ydamW1xTO+Tv3ZIQLOtmHuOkYEY1u/0nFUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sw5TivHCYZPXLUTh+FiTTEXv5JR7GUPUTOODtTkZPLwXp2rZRNchrJh42XqjREtR2
	 fu0btrg5eYzU+KdgzpYIqcR4MFmxvugEEDh2es2tVdRE0/3yCMFUUXEhgQs+mDX1uc
	 X12v7lIRvdarxWGc3jiiXnaarJoDA0bYgzlF4FdKCDqChY3ets6+m3+wcaj4nABqcD
	 aprqcZ16buNqAlaTMvCh26kaS94fWYIcechJd9JzWAZAzlJESVRpr68axOwXFQdfcn
	 LL6qXW2N7exQUQL24XRKaZ4SHTKZxi6Mv23sdbUY//X81Y19DMGRBkjEug3NTVtJiO
	 PSzsHfxH8snIA==
Date: Tue, 20 May 2025 17:58:01 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, richardcochran@gmail.com,
	linux@armlinux.org.uk, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 7/9] net: txgbe: Restrict the use of mismatched
 FW versions
Message-ID: <20250520165801.GM365796@horms.kernel.org>
References: <20250516093220.6044-1-jiawenwu@trustnetic.com>
 <ED7ACBFDFF6405A7+20250516093220.6044-8-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ED7ACBFDFF6405A7+20250516093220.6044-8-jiawenwu@trustnetic.com>

On Fri, May 16, 2025 at 05:32:18PM +0800, Jiawen Wu wrote:
> The new added mailbox commands require a new released firmware version.
> Otherwise, a lot of logs "Unknown FW command" would be printed. And the
> devices may not work properly. So add the test command in the probe
> function.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Simon Horman <horms@kernel.org>


