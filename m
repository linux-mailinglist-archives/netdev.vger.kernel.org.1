Return-Path: <netdev+bounces-71709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C556B854D0B
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 16:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D4EB22887
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 15:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D3F5D467;
	Wed, 14 Feb 2024 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5l8gLBt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDFF5CDD1
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925139; cv=none; b=Ggf1Rv/t3zDo3jBzmENXY8CExzbTITYNfPceAfXZI16dL09CtB9oatcTWElOpT0Y+//e3AfxNOPy1tKmtl3yosKB4dxZk9CPGmAohMIP1CnziqfzRU/FuKpTVR2uQHmn8dCiEEL2ZATOCZ2SfGM6yohFzfSC8IIBnrYYuMPWeXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925139; c=relaxed/simple;
	bh=n8VBkdmshM1Ua46Dy3FWca3nNQN9yVx/fWwAWslB+uE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aGPafQ8jA1HvMNT9ONVFtE61OnvhIVDVm9Dlf4C0BwVBLwDKsjzo5zvbJBQ27mmXw/XUXq1pBmgIlCpgGm71X8vltWWNlmT0MQD6GRiYtzOBubtXRFb6J8AtOadVkZCSJ7q/hL5OwTJQGfNA1B8MwvDp/DRcu8zetrQ96fw+1Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5l8gLBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434A3C433C7;
	Wed, 14 Feb 2024 15:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707925138;
	bh=n8VBkdmshM1Ua46Dy3FWca3nNQN9yVx/fWwAWslB+uE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=R5l8gLBtBsKv4gEhGxNmx8Tg9mhub9yZtmfAsdcna9Aj21hEZiIZnef6P9qCYCfEc
	 S7VsvtrONAjQRLQEYk3dwWhk2ADbiQ+5xkyfmuTT/hLQhoHq4Qt0LbfEbQFI6tvKVc
	 Ii2+6aDFqkBWFw3csJ8Al8vZg8d0bLmxqEJvggrkVBhMEzFvsDAFfz62waik6rVuGO
	 +j9ZZ6cHjk0wryx9yTAv9k2ePL69PTmIFY2jdBuHvwHxiqhcNe4xBVtCY9Nic50ueA
	 QYIUTCLyjISS5WmqDug9E/+txGEYU93sFsrFm1b5rZUu/We1pLZm+19Mu1egBCgq74
	 M2aFeySBelVtA==
Message-ID: <1833708b-6b3d-41b2-807b-864205578db7@kernel.org>
Date: Wed, 14 Feb 2024 08:38:57 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] net: ipv6/addrconf: ensure that
 regen_advance is at least 2 seconds
Content-Language: en-US
To: Alex Henrie <alexhenrie24@gmail.com>, netdev@vger.kernel.org,
 dan@danm.net, bagasdotme@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jikos@kernel.org
References: <20240209061035.3757-1-alexhenrie24@gmail.com>
 <20240214062711.608363-1-alexhenrie24@gmail.com>
 <20240214062711.608363-2-alexhenrie24@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240214062711.608363-2-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/24 11:26 PM, Alex Henrie wrote:
> RFC 8981 defines REGEN_ADVANCE as follows:
> 
> REGEN_ADVANCE = 2 + (TEMP_IDGEN_RETRIES * DupAddrDetectTransmits * RetransTimer / 1000)
> 
> Thus, allowing it to be less than 2 seconds is technically a protocol
> violation.
> 
> Link: https://datatracker.ietf.org/doc/html/rfc8981#name-defined-protocol-parameters
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  Documentation/networking/ip-sysctl.rst |  4 ++--
>  net/ipv6/addrconf.c                    | 15 +++++++++------
>  2 files changed, 11 insertions(+), 8 deletions(-)
> 

Alex: if no changes are made to a specific patch, then you should keep
any reviewed by tags on the next version.

Reviewed-by: David Ahern <dsahern@kernel.org>



