Return-Path: <netdev+bounces-96914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416AC8C82D0
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 10:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC061C20AE8
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 08:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4BE14003;
	Fri, 17 May 2024 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Ojt3+cuU"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF54200D2
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715936183; cv=none; b=KnusgQObgmQufoieHXomtcMt/WrU/2HnYHr8B+YiANFwuSSlNPDSFFWl/GkEHr1ue/iF67WFa3rVPmFrt6uny2KqBdDbhUUZNyFumclwZxWPqVPfeauoWLenA2FBuQkekAbT7TmPo519cK0+dLSPyPY1UcNvDzRYzan3tiodOBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715936183; c=relaxed/simple;
	bh=Y6pl6Iz6QgYWmw0ZvRBR0yfSEM/k921ZjnoatfgWBHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=En+uSkoyQCzH91Vq0rc9fbpclQrZ2fBcajPE9luIPAwscj9Y3JlAsscvzeaK9Xnxi2SnN8bYnR3MWFPDAg1AvZXll+4yKBKDH6oc7O7HNp15OObzrGS+r7GgIIN5Tnf0LoF5rfE1pVVXoxS2Liok6v/L6R1xb7VSsj0F+ZsfbnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Ojt3+cuU; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1s7tNt-0056XN-HQ; Fri, 17 May 2024 10:56:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=o2SkN1TPQY7kjyDqqc8YPCO/EM3pPPpIt1rv1viFd9A=; b=Ojt3+cuUfWftc6n+IeEVnM2LWu
	ktMrDoAyxko3Td4EDCrIeKkYi2+otvnDSs0DVvFazjcfJ7vmbaUrzq0axVaBIC98LdPIoEiu82/kz
	UVhS5y8s3a5JCWFQJyg61gjuf+ywY66AJAY8RvxW+6wkjXXBqBA3sX9awCtHQuHst6XRRT+ooXnm5
	vExzBc7t9nlxyv6UqtyyQwOyk3ghmkcsA3W31mXBIQS0PfKv5tAsXX2Jl/S4bSCBrur8KjKrCc3jm
	JFk5PL7mvpoZEodFK5ILQL21khr5CFk1Ak7wgnqJtLaN12P2RIt4NkYxhxI6ylWiMzqRy3/a/8uY4
	wUO/eQbQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1s7tNs-00064m-RP; Fri, 17 May 2024 10:56:12 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1s7tNb-0040fy-JZ; Fri, 17 May 2024 10:55:55 +0200
Message-ID: <c0fc4799-ee57-45dc-b13b-0be4711b5cf2@rbox.co>
Date: Fri, 17 May 2024 10:55:53 +0200
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
References: <734273bc-2415-43b7-9873-26416aab8900@rbox.co>
 <20240517074742.24709-1-kuniyu@amazon.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20240517074742.24709-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/17/24 09:47, Kuniyuki Iwashima wrote:
> From: Michal Luczaj <mhal@rbox.co>
> Date: Fri, 17 May 2024 07:59:16 +0200
>> One question: git send-email automatically adds my Signed-off-by to your
>> patch (patch 2/2 in this series). Should I leave it that way?
> 
> SOB is usually added by someone who changed the diff or merged it.
> 
> I think it would be better not to add it if not intended.  At least
> on my laptop, it does not add SOB automatically.

Sure, I understand. And the problem was that I had format.signOff = true in
.gitconfig. Fixed.

> FWIW, my command is like
> 
>   git send-email --annotate --cover-letter --thread --no-chain-reply-to \
>   --subject-prefix "PATCH v1 net-next" \

maintainer-netdev.rst shows an example with a slightly different order:
"[PATCH net-next v3]". But I guess it doesn't matter?

>   --to "" \
>   --cc "" \
>   --cc netdev@vger.kernel.org \
>   --batch-size 1 --relogin-delay 15 --dry-run HEAD~10
> 
> Thanks!


