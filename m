Return-Path: <netdev+bounces-120043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D8195808F
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 10:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6A01F2179E
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 08:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEC5189BBD;
	Tue, 20 Aug 2024 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ktlffYa0"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F86018E345
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724141290; cv=none; b=WYK8u0sY4frKU2yTB6yBcRuHYOd9+vj4759ubXw90qAVtEfHnOCRA8CG/S/ASc8WiE11p3ovlx01kfXIYOfOcLl1m0I8ioMA6xf9HnIjaUh1lsS/DBUjxWR/c1Q1lSKHnAgH93h4QGDhYrLywqyzQkpcu1LLzxmbQISk63jqhaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724141290; c=relaxed/simple;
	bh=ZnGmwBpUK7bVopZggQr72fyVrqZrCEdTqddsIvhuJGQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dVKaqQ0zdxTuY1xqETnED7SPSWxctHh6RNMiyvSJ3sFzZtcw40WU+ar00mC3Mc/sLzPEyol63/sn8it4rG8M0hmt75sRs8toOBcJbryDy7tgtpvnpFrEDGA2NGGTkM1uf1uWot4sPGJeTBGds8kd5uBFPoLYhwsJDfaIavTERtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ktlffYa0; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=aJqeN88v/WB5s+5jfGV74NDCWCLb0ShpX0n+pphY6TI=; b=ktlffYa0Bhc4dX7DFvg8Mr0+Cj
	61E9SNpbLzPqkBFEMe8clLcZSdSOKtAYMiK+a7hum/2x1gPS/3bdeODC+/02x6EMd0zdnKZrMwKqS
	mrRP3BWnR5C0p0ZDzaMKUevA0d1CSj0SAp1tvFrltDwlwFGkoZJ4Dm3DD+gowfiNCWoGMvK9ag2LC
	HklUduMxgTatMc9IcXlYcFR/RYCMQzHF50WL3sNrDaKC3G1Atl/HpsR6/nV/NWkwmeMpKcj3QTiaf
	YIgHgG61VD6RuqhZPgAxiMGWrr1RYq9+KUU73Yz1CZPhnM0SC6lYO2G+/lKzfuaQ2DvjgCRGyGvbJ
	K4YJv/1g==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sgJPL-000LRo-84; Tue, 20 Aug 2024 09:35:59 +0200
Received: from [178.197.248.23] (helo=linux-1.home)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sgJPL-000Lab-1C;
	Tue, 20 Aug 2024 09:35:58 +0200
Subject: Re: [PATCH iproute2-next] ip/netkit: print peer policy
To: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, dsahern@kernel.org
References: <20240806105548.3297249-1-razor@blackwall.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7c3883ac-54b4-a745-5efa-cfd4d0fcacd7@iogearbox.net>
Date: Tue, 20 Aug 2024 09:35:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240806105548.3297249-1-razor@blackwall.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27372/Mon Aug 19 10:42:12 2024)

On 8/6/24 12:55 PM, Nikolay Aleksandrov wrote:
> Print also the peer policy, example:
> $ ip -d l sh dev netkit0
> ...
>   netkit mode l2 type primary policy blackhole peer policy forward
> ...
> 
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

