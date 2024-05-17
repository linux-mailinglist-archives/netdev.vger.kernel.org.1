Return-Path: <netdev+bounces-96931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFE58C845D
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 11:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B46A1C226CC
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 09:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEFD2C856;
	Fri, 17 May 2024 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="kioMhkzR"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614782E40C
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715939918; cv=none; b=mcpc4WVY6Lj6C+oIFBRwhZBhc35Sfon6q2yodOy9yel3SZqYrbxyIoCd3FKCdVXt4OHnpWHbqSBZaA1sTRC0ltzGpgBfr/YtotDBy+JhsWW4hkcFV39tvmCHvc6F+7pZak4gIlqDG1r/6M5fx4Vmd2vQMTFGVujjspgCZ1d97tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715939918; c=relaxed/simple;
	bh=4uZAxIn9mS2aaPheXaZ/kXvtK16dVWiwtZyAonFag7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rl89Km/4T7cdtMWPSw1oi5PV/FolAoBVianz15YFHCz3tL8EoAlYTTk/mv++b7E23tuUH8si8pXU3PVaAKbU1x4+WP75ew5VGe75sySx+Goeh00LEWu/59V7yg0x3YZH4YFCjs2lphCdgjCwZAN/kTG16yyvWstX1SEU1j0K7qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=kioMhkzR; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1s7uMB-005OFe-G9; Fri, 17 May 2024 11:58:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=Fho4dAQ9iaTJi2FgDHXVYtQe8t5fUzl9P9JQAYynh6g=; b=kioMhkzRmf64MS1/6SVA3NRgqc
	Yi7NBDLKKYZTBClLnBXL8jHSLtEEYcB11iZ84J09mr3eT1oN2uHDcQCDv7YEyPoq62DG0OwFxGfPY
	vcEcwicSbGH2bYdwAJiKZCOBiDOwTwz9U8p6jhaQbDy68z/p1qMICamoPP4Tx38vJ1VQ+PojO5jIs
	JoK1Ta6p/70q4PL67Mn0Sv6wFmpqOPrLNerp8Q+LmLFWwUvdlFe+wt4//XnTUZwBuF8cEHCYeknnT
	hZtHqEuqUwiZUtMJ4mRRRqpfUI8KtmwTcV298xbvvJBwLw/K8rAint3+OtaRmDUhBGB4AgdY+RljB
	wfsKpcMQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1s7uMA-0004Jw-KY; Fri, 17 May 2024 11:58:30 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1s7uM1-004Bhq-UW; Fri, 17 May 2024 11:58:22 +0200
Message-ID: <985116d5-bb08-4bfb-8dd9-97403b8535d9@rbox.co>
Date: Fri, 17 May 2024 11:58:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] af_unix: Fix garbage collection of embryos
 carrying OOB with SCM_RIGHTS
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org
References: <c0fc4799-ee57-45dc-b13b-0be4711b5cf2@rbox.co>
 <20240517092250.33314-1-kuniyu@amazon.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20240517092250.33314-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/17/24 11:22, Kuniyuki Iwashima wrote:
> From: Michal Luczaj <mhal@rbox.co>
> Date: Fri, 17 May 2024 10:55:53 +0200
>> On 5/17/24 09:47, Kuniyuki Iwashima wrote:
>>> From: Michal Luczaj <mhal@rbox.co>
>>> Date: Fri, 17 May 2024 07:59:16 +0200
>>>> One question: git send-email automatically adds my Signed-off-by to your
>>>> patch (patch 2/2 in this series). Should I leave it that way?
>>>
>>> SOB is usually added by someone who changed the diff or merged it.
>>>
>>> I think it would be better not to add it if not intended.  At least
>>> on my laptop, it does not add SOB automatically.
>>
>> Sure, I understand. And the problem was that I had format.signOff = true in
>> .gitconfig. Fixed.
>>
>>> FWIW, my command is like
>>>
>>>   git send-email --annotate --cover-letter --thread --no-chain-reply-to \
>>>   --subject-prefix "PATCH v1 net-next" \
>>
>> maintainer-netdev.rst shows an example with a slightly different order:
>> "[PATCH net-next v3]". But I guess it doesn't matter?
> 
> It seems patchwork can parse either format. ("net,vX" and "vX,net")
> 
> https://patchwork.kernel.org/project/netdevbpf/list/

OK, v3 sent:
https://lore.kernel.org/netdev/20240517093138.1436323-1-mhal@rbox.co/

Thanks for help and review,
Michal


