Return-Path: <netdev+bounces-191530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0290BABBD66
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 14:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910303BBD10
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBE32750EB;
	Mon, 19 May 2025 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gd06Ib3P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDEB1C683
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747656824; cv=none; b=BLsUTk9PSiIMOpAgoR4HMQ1LmSBrVLg65JPKQxOx6677N4PDpB0U4TE6pN0nnc1ISTSXVCmXI60qDg6C5OFH9xVkNtA7b2h++xKQh6tz0N86EPS9iQLuTp4swMAH1yjIUgG0IwfBaNuotSjD/5/oo2062kTwlVW1/90za8/NIpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747656824; c=relaxed/simple;
	bh=3O3BvXFkL0/xSTFEqW+BpY5Pwj+Qd/rdtZVU6OQMxto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqSOww5EuPnQuJNi49vGpQB+L9xVZLR+a0b25APBecxU7SqTcufDsKc9FfNtAwc9qKzf2u2Er2QYbEx7csR21mRbOKW0BPJN2nFYxuadfALQYh2WIU7PHfr6KlYtlXIX7Tk5q0XImEXonDFTC9grz61NyXVBFr3D5tU3X/Le1Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gd06Ib3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F2AC4CEE4;
	Mon, 19 May 2025 12:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747656824;
	bh=3O3BvXFkL0/xSTFEqW+BpY5Pwj+Qd/rdtZVU6OQMxto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gd06Ib3PDWHH2moEvq6vkVS0qSxaNfRGzNBhl8t9Z0HQiPs9CZfvZi5GlEC4H0Dhd
	 R46XsDF14LlLrqsCIySaNdXjFUrpNDgga401BUMSBQKAot4pfe5SA8Wq0Gfb2e0t9/
	 gt+osA9yQi0u8oR+weLu3H8j4mHdxEmw6Wlo4yBn3Co8pN2nYgx8EjR/tGJ9B/7cAU
	 pxM4GYibQiXoNmgzLCy01DES9+r0HPi7IK0+reROBpnnkzS6CGvriezaP8lyNKV7uX
	 9UR0OyuYz9KMKB3HK5vZKCaITvZBjoSDuF/zCV6pdnvPJFJ3NL3eJ9Mj8TroXVMVRA
	 R6bMIbfe68TZw==
Date: Mon, 19 May 2025 13:13:41 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: airoha: npu: Move memory allocation
 in airoha_npu_send_msg() caller
Message-ID: <20250519121341.GG365796@horms.kernel.org>
References: <20250516-airoha-en7581-flowstats-v2-0-06d5fbf28984@kernel.org>
 <20250516-airoha-en7581-flowstats-v2-1-06d5fbf28984@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516-airoha-en7581-flowstats-v2-1-06d5fbf28984@kernel.org>

On Fri, May 16, 2025 at 09:59:59AM +0200, Lorenzo Bianconi wrote:
> Move ppe_mbox_data struct memory allocation from airoha_npu_send_msg
> routine to the caller one. This is a preliminary patch to enable wlan NPU
> offloading and flow counter stats support.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


