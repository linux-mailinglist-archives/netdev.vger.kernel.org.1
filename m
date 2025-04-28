Return-Path: <netdev+bounces-186599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501C0A9FD80
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 01:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFF83A5D4B
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 23:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A802040B2;
	Mon, 28 Apr 2025 23:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdo9+Viq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4A211C
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 23:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881573; cv=none; b=OpkU9zo+7b7Jz5uPeG1hfRGt236QXOsIvqXE0Q1m1dLW/ufYuM9Em1cSgXRK7ZROzZRWxvWL2E8CpqnlPIF0MqZf5zCO7vyl+iOy88NL+268HUgwvp8luukmx8rICdHUtNHKCcGqUOEfgoapjV+lNydwfW749q8wJqGmJs4PWJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881573; c=relaxed/simple;
	bh=L6AlL6nWWz0F/zqfSZhbRkA1uLLCvwNYPkhhgBZXtZo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hNxha/0mbYxoUaqCfEa1FEwuxyd1avS31qBzJC5Aos1/8uHqgxYX+U+6L1EsvBBWp6v3LPgTDHj3GQnfzMQtTF5SD4gaAIf4RaWvWiXpeqzvz1Llx9Tvv1H6/PGxzx/I15jVXDauNmx8cIs2z+BO/zMdtwopcxhvFgOdTAO2hHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdo9+Viq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D512C4CEE4;
	Mon, 28 Apr 2025 23:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745881572;
	bh=L6AlL6nWWz0F/zqfSZhbRkA1uLLCvwNYPkhhgBZXtZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cdo9+ViqYdCb3wqg8h/f871xuhwP1q4u61eSmmmoco2DuLGycc3ccfvTUPQa4WbGm
	 plIn3EUZ4d77X0mH0fzbf+7dfklmQnmlRF6YKi2APgDFLwS+HVJY6DDhj0FeSIpbK5
	 AXLJkopWoRe4XglK6nn1bxifCOQC+weavlyBv0Weqm7svxdfGFB0Ejya2Zz1H+m/2X
	 IWljaH7qP4AxhCzHlrTQw1cR5xvudeIctlRTnLFpR8xlGZRr/aRSd9BcO4A8s0OW1v
	 DXo1EULHS6SzL9AH9UL5bM805wbWTBhjEnZ1obRzU/r+uZFWkf0PNckcm84on74m5d
	 eW0cay1sBtpAQ==
Date: Mon, 28 Apr 2025 16:06:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V3 01/15] tools: ynl-gen: allow noncontiguous
 enums
Message-ID: <20250428160611.226e3e61@kernel.org>
In-Reply-To: <20250425214808.507732-2-saeed@kernel.org>
References: <20250425214808.507732-1-saeed@kernel.org>
	<20250425214808.507732-2-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 14:47:54 -0700 Saeed Mahameed wrote:
> In case the enum has holes, instead of hard stop, avoid the policy value
> checking and it to the code.

We guarantee that YNL generates full type validation for enum types.
IOW that the policy will reject values outside of the enum.
We need to preserve this guarantee.
Best we can do for sparse enums is probably to generate a function
callback that does the checking.
We could add something like a bitmap validation for small sparse values
(treat the mask in the policy as mask of allowed values).
But hard to justify the complexity with just a single case of the
problem. (actually classic netlink has a similar problem for AF_*
values, but there "->mask as a bitmap" validation don't do, since 
the elements of the enum go up to 256).

