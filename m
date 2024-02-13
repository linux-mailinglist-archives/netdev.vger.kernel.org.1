Return-Path: <netdev+bounces-71445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99E38534C2
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 16:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC5B1C220A0
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 15:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F925DF3E;
	Tue, 13 Feb 2024 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTn5xMuN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F78C5D91C
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838535; cv=none; b=aBDdkE0+1BoC6L+fQew1UGJcDZACkWkqobGwwc6vMXEwVVsytn86mpKuE3E/u/YqZH90HHN+JjLxOzrM5SZ193h0sFZkwGVLDF25J76iAHcPkY7SdEWrnR3LrG/jjj7kX2T31MFs0AHq4KTCac9Saqj9PvOU3Xlg8gwLIXvOsa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838535; c=relaxed/simple;
	bh=QJ5/LZM1ymStSo5tgWjJU6rKHJ71DNN8D85wCktdIKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SopdZFdInfPCVcF6SMlu7eQTLOf6t86+B1gjpQOlPCSaLyxzu4s9I7S/WeHWu9scGlMargj4O0RdSMMH2SMh/I6qCvDtS4F6UUqthJoboQan2PmkNhHZ8FrVxTJXNfSQSzREP02zxCsvKsE7xMdwjP09hrRYNNCYYCAkkaz9XeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTn5xMuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBD4C433F1;
	Tue, 13 Feb 2024 15:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707838534;
	bh=QJ5/LZM1ymStSo5tgWjJU6rKHJ71DNN8D85wCktdIKI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=NTn5xMuNA0n+Q6FBqnKorXHQsi9gRm/iFsOQFmpN2cTQ3BjaC/cCEYHWN7PxuWPQU
	 i9Y7K8s+uc+KgggAJA+jBk/ggBVorHiOnnpxUTutz7fxOTMW422bPudJzgXnYl0aE0
	 vqcnEnbn7H8eUpniH1i3yUAfhsohtzkk8OOKY5D/8vp7fqpi9OZN5nGZNqJrqFQwUW
	 M3juugTN4BuexziznYFyBXUi3bAv1vmXj/9+kPpCf/h8H7LbCJxu1tyW3mgZ1Eowu2
	 miqevNbWmYMBLoHFtmuZOsBx2FkFZQ3EU7b+iKZLLT+pRTsjGxpP1PLbuqLCGQ/nza
	 A6Mba1Yevx7UQ==
Message-ID: <50c4491a-d945-46c1-b98f-e3e52911c1d2@kernel.org>
Date: Tue, 13 Feb 2024 08:35:33 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: ipv6/addrconf: ensure that
 regen_advance is at least 2 seconds
Content-Language: en-US
To: Alex Henrie <alexhenrie24@gmail.com>, netdev@vger.kernel.org,
 dan@danm.net, bagasdotme@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jikos@kernel.org
References: <20240209061035.3757-1-alexhenrie24@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240209061035.3757-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/8/24 11:10 PM, Alex Henrie wrote:
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
>  net/ipv6/addrconf.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



