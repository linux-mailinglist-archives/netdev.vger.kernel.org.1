Return-Path: <netdev+bounces-132318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82439991348
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 01:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6651F23A3B
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1DF152787;
	Fri,  4 Oct 2024 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbFNq94a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280EC148FE5
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085729; cv=none; b=Maqv1THFEgrnXxHFIwAYGDxlRYKwwnrQZrqb9Tfkco8gzFwKcsFS2PNa3dvBh/L0NQMq0guV9IOtwy1s00mufnPDF84nSW/4FPXTRckKFe4z8KJo2rU15e1S9fIMx2F+A0FrY+x8dzyhiMJWJdza7igI56ZHE+NauE4qiKFcxUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085729; c=relaxed/simple;
	bh=nwkY+ZGfMrqLg6ae6TDYiCQfpHto1/pdlZWrpuO5LqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QX6UTLUcSu1ky22hmUB5gy4jxZ3lXhjFWTJz9+8TW7INhghk+9cx3N0ZW8ogQKaYkCBPRWTKR5gGPTL4YyHr+yN5YNb3G81at+E3ox+ptWQsCbPUUGIfHwlwL5B8S/UN/wLBZKBF7ZRZ0iogwU/RJQaE/p3jjEMdKhkRSMYuKGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbFNq94a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4E9C4CEC6;
	Fri,  4 Oct 2024 23:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728085728;
	bh=nwkY+ZGfMrqLg6ae6TDYiCQfpHto1/pdlZWrpuO5LqA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cbFNq94az3qofuG9O7ST+3A10fo8TaU0RqRTbs55g2BGkbaCCS4Gvric/d2acM9yV
	 Nm0GpjghhWQvfS/9GBgaZ3D5yyAKBCaHjGDxNqHhPV15VHogiG4fk13cJ4T+8M/O9H
	 5Dc9ZQIV+y4Ns0MstrKsyH2XUWvqQieHouBN+UHPB4HTZ21PhBz3lStskjB9dBqyB5
	 ruR2VQKTo0VJc5r4Hi/UEIliE48nMbhleIoIsn7VSBRsJyQvpkJzrRYyzJ8d+9GG6m
	 T+uIhJFmYHvXdyCUj4HoeiLhALl56D6gY8xugDUc1CvBwdfxHceGjrjrxCHJD5q4OY
	 19s7St1VIhQlg==
Date: Fri, 4 Oct 2024 16:48:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, willemb@google.com, jeroendb@google.com,
 shailend@google.com, hramamurthy@google.com, ziweixiao@google.com,
 shannon.nelson@amd.com
Subject: Re: [PATCH net-next v2 2/2] gve: adopt page pool for DQ RDA mode
Message-ID: <20241004164847.0a79e2b4@kernel.org>
In-Reply-To: <20241003163042.194168-3-pkaligineedi@google.com>
References: <20241003163042.194168-1-pkaligineedi@google.com>
	<20241003163042.194168-3-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Oct 2024 09:30:42 -0700 Praveen Kaligineedi wrote:
> Also add a stat per ring to track page pool allocation failures.

Please implement qstats instead of dumping it in ethtool -S:
https://elixir.bootlin.com/linux/v6.12-rc1/source/include/net/netdev_queues.h#L11
https://docs.kernel.org/next/networking/netlink_spec/netdev.html#rx-alloc-fail-uint
-- 
pw-bot: cr

