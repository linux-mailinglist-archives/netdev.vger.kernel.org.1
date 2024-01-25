Return-Path: <netdev+bounces-65964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8161883CAAC
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 19:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190E91F27D15
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 18:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D9D1350D3;
	Thu, 25 Jan 2024 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Flq+APtc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324C11350CE
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 18:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206645; cv=none; b=aFOCmuYY6YeXltsuhOi4oGBz3dc8Wi25pzz3t67JaC0k3ZB6nJstvNyzJAeaifH+hkk/IMuToH63Ohbsa44EkiIYYqgFivRN21ihse8zMhyCOnDEfA6daT1pTHguYFiqvhq7/aApCYCYk6dp5B5Dx0QxuIvfhmQ94Wi0nT4mDP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206645; c=relaxed/simple;
	bh=Wawne1ixIMQZu5OBhwLWFcX8DyEiYhBqbXmeuPs95e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HLTsp+Do4neH44CQ+DFpEf9IjHGpTun4LEqeox1YpGVGAQsCfvL7WuaJ0nXPycDynUunCF0prKbZWWKxUD+HjGOUrhLk5wyWZORdtfIcg7K5WkWoJbYsHLGucqfXSqT0UYn7BWx4zSbPwGdhbtMfZJtdFybVXplqq71b5BpRoKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Flq+APtc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7511CC433C7;
	Thu, 25 Jan 2024 18:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706206643;
	bh=Wawne1ixIMQZu5OBhwLWFcX8DyEiYhBqbXmeuPs95e4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Flq+APtcNzcK/6f6zoX+SXBOx+ibPxLcc+nPeaGDdjzIBLajldfR1a9xrVlrZT9b3
	 yoPcsmJ2DBecOs4Ky0ER5yMW66bewUIyNOSx1NIDhWiCx//NREok72YABDh0FuBJnu
	 4qIVMg7ywI7gP3iHkxEk+8G1IfRirCkVtldo9cqzSMnDzqYJbACrkZ4z89L6MCoq0O
	 l/obPrrnzP31bAqmGKYhG30zujH2HfHa1VJVkvzp6ZCeyPA6XpYv3f/TXj1yHDY5Er
	 A8IXwEXYLcx+IENOA9eZQ2x+h1zA/LitxmYZ9ipVjUOv63Uz3L6brUO9HM2uiu/bIv
	 qQ8p/QvQN5tdw==
Message-ID: <90d26f2c-c798-43f6-bbbb-9319a2fe445d@kernel.org>
Date: Thu, 25 Jan 2024 11:17:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2] m_mirred: Allow mirred to block
Content-Language: en-US
To: Victor Nogueira <victor@mojatatu.com>, stephen@networkplumber.org,
 netdev@vger.kernel.org
Cc: kernel@mojatatu.com
References: <20240123213811.81337-1-victor@mojatatu.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240123213811.81337-1-victor@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 2:38 PM, Victor Nogueira wrote:
> So far the mirred action has dealt with syntax that handles
> mirror/redirection for netdev. A matching packet is redirected or mirrored
> to a target netdev.
> 
> In this patch we enable mirred to mirror to a tc block as well.
> IOW, the new syntax looks as follows:
> ... mirred <ingress | egress> <mirror | redirect> [index INDEX] < <blockid BLOCKID> | <dev <devname>> >
> 
> Examples of mirroring or redirecting to a tc block:
> $ tc filter add block 22 protocol ip pref 25 \
>   flower dst_ip 192.168.0.0/16 action mirred egress mirror blockid 22
> 
> $ tc filter add block 22 protocol ip pref 25 \
>   flower dst_ip 10.10.10.10/32 action mirred egress redirect blockid 22
> 
> Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> ---
> v1 -> v2:
> 
> - Add required changes to mirred's man page
> - Drop usage of the deprecated matches function in new code
> 
>  man/man8/tc-mirred.8 | 24 +++++++++++++++--
>  tc/m_mirred.c        | 62 +++++++++++++++++++++++++++++++++++---------
>  2 files changed, 72 insertions(+), 14 deletions(-)
> 


> +			} else if ((redir || mirror)) {
> +				if (strcmp(*argv, "blockid") == 0) {
> +					if (strlen(d)) {
> +						fprintf(stderr,
> +							"Mustn't specify blockid and dev simultaneously\n");

I fixed the error messages to avoid use of contractions

applied to iproute2-next



