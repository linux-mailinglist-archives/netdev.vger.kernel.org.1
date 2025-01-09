Return-Path: <netdev+bounces-156721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1581A07990
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028841610E3
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 14:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00051282EE;
	Thu,  9 Jan 2025 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bImRtxAk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFD98BEC
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736433938; cv=none; b=Jcbcr6zGdBBm/sY4kArnLSyER8R/i88+VdZfF1EJWAoANfc0KbXJ0ME78aTK8nMzyETpTaK7oFJ2gAV9FIXhL59Geu/14DMDwXH8cEsJet17lX9RquzhclD3E9auLe09uVTE4r/ZjEF+vpOb5drz2bvnsKLA9KIjB+puOL6I1HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736433938; c=relaxed/simple;
	bh=BBF9BZ4wKhUMdB/M1w5SfIFa6Ulf4iiYU6Af8XL+VFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJq2YtKmv5Uc/IEBvrcgH/Yh9ZZoW0w5mC2T7Rq09B2mODZ0rd4dpflAVXj/YYMpq4LE1BfC8S0bcfTLJwJ8zKgk2fFuYWKfqdAqNIqfB5NGKc2CvRAe4k6NwF85I4uIabGwolqREwoNgyyr97B1brfcrNjNzmoYwaXA3jSWh2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bImRtxAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128D6C4CED2;
	Thu,  9 Jan 2025 14:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736433938;
	bh=BBF9BZ4wKhUMdB/M1w5SfIFa6Ulf4iiYU6Af8XL+VFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bImRtxAkxrSLEVwXm0rcC7DC6c2n59R3sOe2TFCBx4b6+KmMLlLAj07ImGhCZatbM
	 XQUZOXePPXP9xGYVhSljoAYqV932csWh7PiEvyBIr9hT1zuCla86DUXKTQyk82n5iN
	 DTEChWSBSlp3/bHvQIYelk6fngCmns8mi3QNUZXKMtUaDCn6W7pCQhm4lKTvj5y7r8
	 FH+EZLMxPJn/gcms+Buzcs/27sAv+H5T9vx+CTN1kjOHfoqtafXhyLU12zBwlV/bcl
	 8V7KHd9T/8Nl6nODDHHfr9+7GFadqfZ45diL332s/ptDUAGDfS/zx4PURViYwyt12n
	 WwNFvLwLBiuyg==
Date: Thu, 9 Jan 2025 06:45:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 davem@davemloft.net, edumazet@google.com, security@kernel.org,
 nnamrec@gmail.com
Subject: Re: [PATCH net 1/1 v2] net: sched: Disallow replacing of child
 qdisc from one parent to another
Message-ID: <20250109064537.5ad1c6a6@kernel.org>
In-Reply-To: <20250109143319.26433-1-jhs@mojatatu.com>
References: <20250109143319.26433-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Jan 2025 09:33:19 -0500 Jamal Hadi Salim wrote:
> Lion Ackermann was able to create a UAF which can be abused for privilege
> escalation with the following script

What's the Fixes tag?

