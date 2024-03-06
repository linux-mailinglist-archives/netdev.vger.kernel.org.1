Return-Path: <netdev+bounces-77768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A84AD872E0B
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 05:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60396280BDA
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 04:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5060E156C2;
	Wed,  6 Mar 2024 04:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kjqm1QAa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4B814292
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 04:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709699954; cv=none; b=MRQbtZBO3jbzL4nL1V1Jjs5AMLaV2YLkSSp78G2EMv62S8jVvbc0lvhOHl9kfFBrBRA4R89nfpAEvLz1FNUpYRXLIbk4aDJtmF2+zTlkmw8WO59r0+UpDgVK9qWwlhbItLEyVxuAnH7plKxwfQPD4KouE96N8SoNRTPwnk9dWmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709699954; c=relaxed/simple;
	bh=1VM2BhqFlCAYFP2rcYEkjNUc8BvTx9Rq6mowLJOwBHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAnCkoSDGNIrwWkUMFBbcAyUfFh6dDqsF/2S2Vvn8PRT1AUSZjAw199RtMtKrHFnE3rRetsUf73+JgE5s9bYyRPMwiRSCtgXk4jH1MeGkyrbW1f3+I2zeoxG5XUrfvDaat6AZQbeiQoEi0CBQbrGNEdbl1Ic7qJYnj5G75AAVsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kjqm1QAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F637C433F1;
	Wed,  6 Mar 2024 04:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709699953;
	bh=1VM2BhqFlCAYFP2rcYEkjNUc8BvTx9Rq6mowLJOwBHc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kjqm1QAazhCyJ3d3M8TWMJ3jvfnoRlwuJ4UrwpLyK8gzYu5ohoFDtbgk+OdD4wjne
	 Sez0aoV6P0l2dQa/rdrGda5brfNg3f3EpOAdcsLwjwtvkuC5WM5O+J3x9WXhZzC9Yi
	 TocS4RVPMpOU/Xu12s2UiTyghTm1864urJ5GJbs/RPAqKy42rIDX7F1HhDMdhpq4qn
	 yWkGTgSkdIwZB8hGVTiyRNdOapWIQ9ZsDgdoiFH/6VCzm1qd85P8pnwIjWAPnMMD6A
	 yleIKvW/cO6iXD0nStRAltVEyatY1DTu7MxuH1GBNvIIQ8sF/c4QlZKrVlwrlroNYe
	 +zoejEWNKN7DA==
Message-ID: <4cfe2f75-d492-4e22-b167-3eab5f3cdcdb@kernel.org>
Date: Tue, 5 Mar 2024 21:39:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/18] net: group together hot data
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 Soheil Hassas Yeganeh <soheil@google.com>,
 Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com
References: <20240305160413.2231423-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240305160413.2231423-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/24 9:03 AM, Eric Dumazet wrote:
> While our recent structure reorganizations were focused
> on increasing max throughput, there is still an
> area where improvements are much needed.
> 
> In many cases, a cpu handles one packet at a time,
> instead of a nice batch.
> 
> Hardware interrupt.
>  -> Software interrupt.
>    -> Network/Protocol stacks.
> 
> If the cpu was idle or busy in other layers,
> it has to pull many cache lines.
> 
> This series adds a new net_hotdata structure, where
> some critical (and read-mostly) data used in
> rx and tx path is packed in a small number of cache lines.
> 
> Synthetic benchmarks will not see much difference,
> but latency of single packet should improve.
> 
> net_hodata current size on 64bit is 416 bytes,
> but might grow in the future.
> 
> Also move RPS definitions to a new include file.
> 

Interesting patch set. For the set:

Reviewed-by: David Ahern <dsahern@kernel.org>


