Return-Path: <netdev+bounces-234324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D373C1F608
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1929F34DAF0
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B07346E7E;
	Thu, 30 Oct 2025 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="mi+RgVcZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB154C6D;
	Thu, 30 Oct 2025 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817603; cv=none; b=qWdHg4sZyMsmdPtzYdIgSf0kHomJH7dJMlvtAaGhXnh/X7AtLhwHqLMqqG2NpYBFQ2mA+k8fEY9pQVUfN2w64eryZ5CnZv5J5J9LhHvkuKSP8ukFRMtKA2i/mfyajwbGDguQ8+jbadKjyXy3DR/XSODlT/uobOZjb1fYf2a8U8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817603; c=relaxed/simple;
	bh=blAzx4uEJP53BDG/8DrX8nI2p4iLjnpZLefLr7MozMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHldSi4RNJxcy0o9mEuT1//Mc48wnuH1uFdRzGlE7b9mEnTkoEa/HLAmXnQ3DGWfhuyiFzhBRU3ZekdlX5M7Ej0DLeKTEHREAhSY7A5uRQ3aA7rQyovQf5s5F7D8eV0tsOmjwlNezyDefmmQyYWbKbDqHeJUCWkvtWW/juIsaAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=mi+RgVcZ; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1761817597;
	bh=blAzx4uEJP53BDG/8DrX8nI2p4iLjnpZLefLr7MozMU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mi+RgVcZPPquTxgQAIIu24Hrb+IbAuotd0mc2iERVk6Q2Lv0htkI3uaOkxMsFsnvN
	 Y050MQCaPqBjBVG0Y23LunRj23dRRkf16k9Ni8cky+2pskVO/4me9/neuIZcsRsnxi
	 kNyzv8fmlyogZEnE+tvvTcAgSrk140GXwbafYlORxy9Ahx7d45BXuNDoXHCFlPYOFH
	 TGvj9oCiuHYuzRwpMrzYbo7WgAToOTeSR4xguTB9A8F9r97OvnJOmGHS3Ik562cZzx
	 fV/1AA0zBX5IN6rwIWEdP+NWU2xRqob8rI7zLov8vMlzJERKKFLQR4Dl0KDZMpkVmg
	 Kkj4ilyCEOEJQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 0FE406000C;
	Thu, 30 Oct 2025 09:46:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 3ED7A201247;
	Thu, 30 Oct 2025 09:46:25 +0000 (UTC)
Message-ID: <52e4619e-d018-4395-a94a-499ff7fd918d@fiberby.net>
Date: Thu, 30 Oct 2025 09:46:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 01/11] wireguard: netlink: validate nested
 arrays in policy
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251029205123.286115-1-ast@fiberby.net>
 <20251029205123.286115-2-ast@fiberby.net>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20251029205123.286115-2-ast@fiberby.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/29/25 8:51 PM, Asbjørn Sloth Tønnesen wrote:
> diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
> index 67f962eb8b46d..9bc76e1bcba2d 100644
> --- a/drivers/net/wireguard/netlink.c
> +++ b/drivers/net/wireguard/netlink.c
> @@ -27,7 +27,7 @@ static const struct nla_policy device_policy[WGDEVICE_A_MAX + 1] = {
>   	[WGDEVICE_A_FLAGS]		= NLA_POLICY_MASK(NLA_U32, __WGDEVICE_F_ALL),
>   	[WGDEVICE_A_LISTEN_PORT]	= { .type = NLA_U16 },
>   	[WGDEVICE_A_FWMARK]		= { .type = NLA_U32 },
> -	[WGDEVICE_A_PEERS]		= { .type = NLA_NESTED }
> +	[WGDEVICE_A_PEERS]		= NLA_POLICY_NESTED_ARRAY(peer_policy),
>   };
>   
>   static const struct nla_policy peer_policy[WGPEER_A_MAX + 1] = {
> @@ -39,7 +39,7 @@ static const struct nla_policy peer_policy[WGPEER_A_MAX + 1] = {
>   	[WGPEER_A_LAST_HANDSHAKE_TIME]			= NLA_POLICY_EXACT_LEN(sizeof(struct __kernel_timespec)),
>   	[WGPEER_A_RX_BYTES]				= { .type = NLA_U64 },
>   	[WGPEER_A_TX_BYTES]				= { .type = NLA_U64 },
> -	[WGPEER_A_ALLOWEDIPS]				= { .type = NLA_NESTED },
> +	[WGPEER_A_ALLOWEDIPS]				= NLA_POLICY_NESTED_ARRAY(allowedip_policy),
>   	[WGPEER_A_PROTOCOL_VERSION]			= { .type = NLA_U32 }
>   };

Oops, I messed this patch up.

I will add forward declarations in v2, which will be removed again once the policy code is generated,
as that will be less messy than reordering the policies.

-- 
pw-bot: changes-requested

