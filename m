Return-Path: <netdev+bounces-109886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D6A92A2EA
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51FA7B24841
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8F278C73;
	Mon,  8 Jul 2024 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="R02JLmEZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53EC7E0F1;
	Mon,  8 Jul 2024 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442303; cv=none; b=Ggv0PohLebA4rMFWRPEuFLWRf8licPZ7KXAJndSnHNhT4mMmS0pK3alP4p+P1I3NUat55n6kGYt9FaZq31vOMNhkluQKayY0HlhIGHsDjZYWoUU1udP0Jvw3N83a5PIRV6G2ka4iKgzERpRLrgt2bX8JEXx46QX356qE/HoiO78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442303; c=relaxed/simple;
	bh=6YTcBypVx+Kf/BJx+Vz0MGCNsTs1ZskfwUvSJLUfHV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5hHdHsWs136nmJC/+HY/4FTlanUqRtxMbPes1UEzeVLZuAnXYtli06AW8N3woCsGx2S/IDgZuLJSJBs/uoucVgOcgAOrAagCu1u18IEaQtXe8e+YjEMTCADoFlNszBQ1kz+wCU9I0bllEKlEp/N5QMlUItmsUUy70Li1VaXnas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=R02JLmEZ; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720442297;
	bh=6YTcBypVx+Kf/BJx+Vz0MGCNsTs1ZskfwUvSJLUfHV4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R02JLmEZGJ0YDiRP82phncL9p8m9P6IKTCcHFwfFKItoAMUZRQIuX+sd2h/jnnmKT
	 4VOfHuzBK0qEThEOM2uyUO/XaFf4TMSJ6cNUgct9+4RlSZxHs+yXoEZgIovhRyOhwK
	 eZ9+9MDpnDH+I6tjNueG01x4heNu+xOTE5wgWweeNNXnmnG1sTiE1n3xktl1cfa5iJ
	 R+EtuWhDWAepqOVMdTJ0qUIlzFFTJFTGDLg2CyWobilQ/uEyQ3bP7e2z2CuFMRgyGF
	 eXAe1zUMOK2B0n8TqF7K45tq44jMp34RmzxCoDX0D/bYPsnmokH63oxYw/ZTKbZbVl
	 H0GhvDatES7QA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 7491160078;
	Mon,  8 Jul 2024 12:38:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id D23182011BC;
	Mon, 08 Jul 2024 12:38:12 +0000 (UTC)
Message-ID: <36b8ba99-0a8d-4b06-89cc-c1cc1cceeb8b@fiberby.net>
Date: Mon, 8 Jul 2024 12:38:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 01/10] net/sched: flower: refactor tunnel flag
 definitions
To: Davide Caratti <dcaratti@redhat.com>
Cc: netdev@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Florian Westphal <fw@strlen.de>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-kernel@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>
References: <20240705133348.728901-1-ast@fiberby.net>
 <20240705133348.728901-2-ast@fiberby.net>
 <aadf8f7c-2f99-4282-b94e-9c46c55975dd@fiberby.net>
 <CAKa-r6u85yD=Ct4nq2xZLXLT+3vWsz+WoDZ__xS4tkpge=yf-Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <CAKa-r6u85yD=Ct4nq2xZLXLT+3vWsz+WoDZ__xS4tkpge=yf-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Davide,

On 7/8/24 12:07 PM, Davide Caratti wrote:
> On Mon, Jul 8, 2024 at 1:12 PM Asbjørn Sloth Tønnesen<ast@fiberby.net>  wrote:
> [...]
> 
>> Davide, I think David Ahern would be happy [1] if you could post a new iproute2 patch,
>> since the kernel patches should preferably hit net-next this week (due to uAPI breakage).
> I will send an updated patch (don't use "matches" + add missing man
> page + rename keywords [1])  in the next hours.

Great.

>> Nit: I would prefix all of these with "tun_".
> "tun_" or just "tun" ? please note that each flag can have a "no"
> prefix, so is it better
> 
> notuncsum
> notundf
> notunoam
> notuncrit
> 
> or
> 
> notun_csum
> notun_df
> notun_oam
> notun_crit
> 
> ?
> 
> (I'm for not using the underscore - but I'm open to ideas: please let me know)

I'm fine with no underscores, alternatively recognizing both "no" and "no_" prefixes.

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

