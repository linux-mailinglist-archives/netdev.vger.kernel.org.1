Return-Path: <netdev+bounces-158189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 528AAA10DD7
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 18:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086D63A10CB
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 17:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2DD1C1F0C;
	Tue, 14 Jan 2025 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="O9qqOlO9"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A71232456
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736876018; cv=none; b=KKm7URTCiBFHZUQsgAdiNFNEhX8gyUSugnIE8XvhTLMmjnr2gYtAzFPKUfHIvxBAV6eLr5rjfslsmObQO/uCoqRo0ODacrMRKVjRzJEjiuprFmafcbk1sqOGC3EDF6RFSDaRfS2B9vFSrvsqbB36exIHPFSy1Jv0ESgyIx+ipIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736876018; c=relaxed/simple;
	bh=jM8gdSYXRKXhordHJODptLgNuTaaddMsQI/iwDzh/5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pag9mYV3JtXtiYVNS891wC5oEgojOEGLg2N7/A+4SuSZY+qwCnRZL2v5wV8UiAm1BL1XVQKpmpstUX1AJUJtO3O4lfw3lgheT5phEpbmorlkU4WlwbIs14uFwVfpqa+GQDxFw7umq020AB+8Cr4YvYX9xa69wb0g03jdWhAlhPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=O9qqOlO9; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1736876012;
	bh=jM8gdSYXRKXhordHJODptLgNuTaaddMsQI/iwDzh/5g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O9qqOlO9paxheGouF3PnxSWHL9U/FQNfQhCg1ZKHwNhnAVTG6VMwFJn/ISr7od3e/
	 V5a25P8ngmVD21AF8+gwQ232s+Mt/pKTGQJ62EEDQ9GlQMwazGap4OmSbuXOJ5GPID
	 sAZxcICBxJaYCsGjqQP6aKA6NGUUrNHbUUVdq2JhtpxvpCTBQ+/CqsgxZIMXeldsEo
	 5bo9KlXr06urtw19RSMd3bUZTacHqPUfaNE3JgoyF3uAi9awgI+L8GwyKidoMHGu68
	 hjAfcf/kl2KWOC96aXNeUkNLM2n5g6JgNjVS1rVUrFy810QYDQmHaanfbLEUJKQTTt
	 sr3+hooDnRIOg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id CF80D60078;
	Tue, 14 Jan 2025 17:33:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 44EDD200B39;
	Tue, 14 Jan 2025 17:33:27 +0000 (UTC)
Message-ID: <b7b144d9-7099-42b1-b057-f6101b4580eb@fiberby.net>
Date: Tue, 14 Jan 2025 17:33:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net] net: sched: refine software bypass handling in
 tc_run
To: Xin Long <lucien.xin@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Shuang Li <shuali@redhat.com>, network dev <netdev@vger.kernel.org>
References: <17d459487b61c5d0276a01a3bc1254c6432b5d12.1736793775.git.lucien.xin@gmail.com>
 <8cf44ce9-e117-46fe-8bef-21200db97d0f@fiberby.net>
 <CADvbK_dYKMvZ8iUS-CvzNYYue1qxTsWXDpvcETyBD+sWOJcaSA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <CADvbK_dYKMvZ8iUS-CvzNYYue1qxTsWXDpvcETyBD+sWOJcaSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/14/25 2:30 AM, Xin Long wrote:
> On Mon, Jan 13, 2025 at 4:41 PM Asbjørn Sloth Tønnesen <ast@fiberby.net> wrote:
>> I will run it through some tests tomorrow with my patch applied.
> That will be great. :-)

Hi Xin,

Given the already posted changes, when I rerun the benchmark tests from my
original patch last year, I don't see any significant differences in the
forwarding performance. (single 8-core CPU, no parallel rule updates)

The test code is linked in my original patch:
https://lore.kernel.org/netdev/20240325204740.1393349-4-ast@fiberby.net/

