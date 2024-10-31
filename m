Return-Path: <netdev+bounces-140581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD589B715D
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 01:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B181A282384
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 00:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9485C17C98;
	Thu, 31 Oct 2024 00:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9hYr2c3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6923D156CF;
	Thu, 31 Oct 2024 00:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730335942; cv=none; b=ajLCDhbTTUkkG+PsQbf5erk/9EB4NuuHPxQuxjjEx5XDrR5YuSViH9vwGI5A8nyw/i/eH4q3V+RC4gAGB7/rW68Wff5BWEH3z+hPf2QTSwB6Qhvy4GzCtHqSReq5tUy7OEAshdOcptdPmJqJVr8VnOdkRW/N1aiH0N4/rOABhQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730335942; c=relaxed/simple;
	bh=VeMaAiinzyRSdFXGNVz/3Ux0g/W38EOi7+6/GJtkHp4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=coU2nU/R9Sl4RMuvdUWsMQHqTXL7/OkWetZOf/nghjHzerWYEJDux1Kjr9xoXexp8pd4+/a0uh6+10+pbEiKbOHzGBbM/VKUIyTjKPF20a6kUjhYYRALXqEiqjGhmZCcOHqGklbeogxcl0tiEOF91/RUqWmDf6PdWG7xBWdMtyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9hYr2c3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CF7C4CED3;
	Thu, 31 Oct 2024 00:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730335942;
	bh=VeMaAiinzyRSdFXGNVz/3Ux0g/W38EOi7+6/GJtkHp4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E9hYr2c3x+hLkFetIaZDAJ7+xUtEejHK4H6dbdmoJC8hhQHNlPuf+KK6MOAHuqrf9
	 pBQQQcsWdCJoHCUhio1UubTREWxZk1RkUKxQLLXsag9tSjQEn54kFjbhtfO6ZLhMqb
	 A3nzk2L/CRpLhlDSCJaa9+YVH5zehQ2Vd7M31DeQNjs5JbGdHTsgWJuCXHvZShsLBg
	 PCIbx+iM+Mrk0dVH0UoYnt1hdzV/ObN192FyOHk3eQ6eGVEzVRVyr9GIfvV0mq/SUq
	 omZadBf5M0cnJzV/MVQNedIp6EwY9tqcBHQR+CfPF8c6UIFmIN0I+Wh23fz0sOTye9
	 idJHnKAvO4ZLw==
Date: Wed, 30 Oct 2024 17:52:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <jiri@resnulli.us>,
 <edumazet@google.com>, <sgoutham@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>
Subject: Re: [net-next PATCH v4 0/4] Refactoring RVU NIC driver
Message-ID: <20241030175220.0f2d5046@kernel.org>
In-Reply-To: <20241023161843.15543-1-gakula@marvell.com>
References: <20241023161843.15543-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 21:48:39 +0530 Geetha sowjanya wrote:
> As suggested by "Jiri Pirko", submitting as separate patchset.
> 
> v3-v4:
>    (Suggested by "Jakub Kicinski").

These are our real names, you don't have to put them in quotes :)

While I'm typing - small nit for the future, please wrap the cover
letter at 72 chars, just like the commit messages.

