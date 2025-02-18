Return-Path: <netdev+bounces-167131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CB9A38FF2
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952411891ED6
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 00:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A996EC13D;
	Tue, 18 Feb 2025 00:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSuYdJaf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBA979E1;
	Tue, 18 Feb 2025 00:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739838779; cv=none; b=QDxxf2Xv97UB+2wvbPdTETcNjDQhAi9jv7PKJgGTPBLm0UF3/qN7oXYvQn6qmyk+0he9aXpsr8fDV7zdJKVxLdH8wacePqlxrVP7sb7oG/CY0VpuUzpCSjMTd0emKayaan4yBONyZMoOyM/uE4KHHeFeYY/ndUnRBVTSSfVpuRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739838779; c=relaxed/simple;
	bh=7TsYm0VQroDLIwBtLeWiZg26n3x1/vAnj9r5cLl1Yys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCaU/j2nYsC80sH9vwbYvbVoH4Atz3tzyE3q1qqIX/1XCoyfeNKXWqwYjYnTbI9FgFfI36xwpUADu17+F6ovDL/fprRIhJUxoUNC02kMG7ycwkL4Gf0MSZSDI7bwwzXiUa3/65GSTQJxOOo3Sm/H7lcoBS0vLW528uJPJZYUddc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSuYdJaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64615C4CED1;
	Tue, 18 Feb 2025 00:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739838778;
	bh=7TsYm0VQroDLIwBtLeWiZg26n3x1/vAnj9r5cLl1Yys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XSuYdJafDRomcc3U5LvDDbZC82tRbN5EyNEI8WBqMehznMicBH0Gsnp5exaFarYMc
	 qDZnf1Wu6uXAYL0WaC1R/BdMiQQsbeV9N8xbm7vdpECVRViy4wGWz3SmIXwcRaX5GW
	 vtROAoeUHlmGOsjqhVF9DR19Y4+xd7uUYtQhycuu63NjXbf9W8emIjsJNCHUHm9reI
	 7d4TqX5LvW3waM1o6WV1R2s2+2qg+23Kk93X4mEJZ8ZPcfOm7T5YKax01ad5f6zdV2
	 SaoWMNK4BOe3dm9zwjX/U2iSbCEwWMGxq18nAWM2HkGyxkcCKAznd6MYdY+6vTCrMf
	 SPqJ9GtY2gh/w==
Date: Mon, 17 Feb 2025 16:32:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern
 <dsahern@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>, kuniyu@amazon.co.jp,
 ushankar@purestorage.com, kuniyu@amazon.com
Subject: Re: [PATCH net v4 1/2] net: Add non-RCU dev_getbyhwaddr() helper
Message-ID: <20250217163256.491b7990@kernel.org>
In-Reply-To: <20250213-arm_fix_selftest-v4-1-26714529a6cf@debian.org>
References: <20250213-arm_fix_selftest-v4-0-26714529a6cf@debian.org>
	<20250213-arm_fix_selftest-v4-1-26714529a6cf@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 04:42:37 -0800 Breno Leitao wrote:
> +static bool dev_comp_addr(struct net_device *dev, unsigned short type,

sorry for the nit, but: dev_comp_addr() -> dev_addr_cmp() ?

cmp is the typical abbreviation for compare in C

> + * dev_getbyhwaddr - find a device by its hardware address

another tiny nit here: I think ideally there should be a () after the
function name
-- 
pw-bot: cr

