Return-Path: <netdev+bounces-89351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 760548AA1B8
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 20:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B29A1C20CAA
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 18:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019BA177980;
	Thu, 18 Apr 2024 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7dIGe8Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E47174EF9
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713463350; cv=none; b=PT/K5VNG3BUOIahVv4HvWy3i8jWUl6w/QGE6/p4uDgnRrGixQAsdtuxKrEv/udYHLL8acCbtPjkoEM/EnXL0vN6X6CuYgNQW/tu1p9Ao256F1/STQGPUnrcQ5AKEekAI3cDpx2wS/sKZrqcNtmH5Gaw8BVjZiuTl+Du2HRbSEzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713463350; c=relaxed/simple;
	bh=Xx6rE0HhrZ0WOWx31tkLC+AByPOffRdRCF6jkZvizwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQsk+H3BDHRrxhYrHzrOmGw1BTB16ixJizjx+Wy5DXEKx3g7rHKOCquhoDaaMprYmRf+gPl9A2DevI7KMiHd1SA0OuQC9Kunm4nPPF2z/stPU2KP8fOZYhJAeXsDjz2m4K3hLhv4vbTJ3pilJDud39cjN/fhQ3oMWKqn7/kDnCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7dIGe8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80D3C113CC;
	Thu, 18 Apr 2024 18:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713463350;
	bh=Xx6rE0HhrZ0WOWx31tkLC+AByPOffRdRCF6jkZvizwI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z7dIGe8Zb+6H6NULMkV5WJudJsdZwcfXBUr4FL8p8oMmq8o2K1orp4NkEH/SM9K9m
	 B7O/uqfoTttsw3CxAfVP3io51bI2cUDPMQKMKHLneyXC/0w/GNV6kS454eFyF5ry7Q
	 komYGdjdcSOfFCSGMq+DOXj/607rnrvfSzTQBtLoUv9iSNPW+Jeccn2Cf995dfVnaJ
	 XiGIRP3KheWkv7ZIdnEaE1bEi528sr9oIcIGmUQXdZo3UOMgJhGBbOmet4BnRRANyJ
	 GBOSDZC/kuwFmETlELJG2CeIo2gFlnMWbQdR42dpNwY0AEqKHaT3c5bujjmvq627bn
	 Ope8MKvGbq1Hg==
Message-ID: <44e406a9-e3e7-44c7-9f79-c76280336ca3@kernel.org>
Date: Thu, 18 Apr 2024 11:02:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] tcp: conditionally call ip_icmp_error() from
 tcp_v4_err()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, eric.dumazet@gmail.com,
 =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 Willem de Bruijn <willemb@google.com>, Shachar Kagan <skagan@nvidia.com>
References: <20240417165756.2531620-1-edumazet@google.com>
 <20240417165756.2531620-2-edumazet@google.com>
 <e332d0b8fa7b116003dfd8b47f021901e66b36b9.camel@redhat.com>
 <CANn89i+-cjHze1yiFZKr-cCGG7Fh4gb9NZnS1u4u_77bG2Mf6Q@mail.gmail.com>
 <CANn89iLSZFOYfZUSK57LLe8yw4wNt8vHt=aD79a1MbZBhfeRbw@mail.gmail.com>
 <7d1aa7d5a134ad4f4bca215ec6a075190cea03f2.camel@redhat.com>
 <CANn89iJg7AcxMLbvwnghN85L6ASuoKsSSSHdgaQzBU48G1TRiw@mail.gmail.com>
 <274d458e-36c8-4742-9923-6944d3ef44b5@kernel.org>
 <CANn89iJOLPH72pkqLWm-E4dPKL4yWxTfyJhord0r_cPcRm9WiQ@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANn89iJOLPH72pkqLWm-E4dPKL4yWxTfyJhord0r_cPcRm9WiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/24 11:47 AM, Eric Dumazet wrote:
> I think the userspace program relied on a bug added in linux in 2020

which test - when was it added? nettest.c and the fcnal script were
merged in 2019.


