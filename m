Return-Path: <netdev+bounces-37723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 572A57B6C05
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 16:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id D7FC9B2096B
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 14:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47253328DA;
	Tue,  3 Oct 2023 14:46:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373E822EE2
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 14:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B908AC433C7;
	Tue,  3 Oct 2023 14:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696344413;
	bh=sMaOToJsBBcLkteYEKQuJ+ywdzN8QqtByIi9TPOY4f0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LGhC+c8fVhJStyaD+nKV7UoGSM2ayvLW4PCJylmAmAyVnw+3J+QHGy/TANAo2pVvR
	 144utPJigYDRfCttwW4LdFo/KFId8wL3VBm1mV98L6SdywbbQpv1hUexl4+Hi6r7TF
	 ZxHWWtWsvckVB1YtBHHwT2UOGtxxKPyrdhBLtUSsh9NL4dXKCU00NGwIbXwcda6vwV
	 ikGvpfZFcIesmU37eDxuYkoSBm4RLIAtvb00j18sKzN8rpxgNQp5xAOlykliHaapOj
	 pBUQmJEz3VUoPRJl0Ei3+tqREl/lZnWaeGGlJpQrmDtJLjvIJfILu5AAj28K0E1g6j
	 v32spSOi4RJJQ==
Message-ID: <0a1ed293-c709-eb93-f534-88d11e450a5f@kernel.org>
Date: Tue, 3 Oct 2023 08:46:51 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH iproute2-next V3 1/2] devlink: Support setting port
 function ipsec_crypto cap
Content-Language: en-US
To: Tariq Toukan <tariqt@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jiri Pirko <jiri@nvidia.com>, Dima Chumak <dchumak@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org
References: <20231002104349.971927-1-tariqt@nvidia.com>
 <20231002104349.971927-2-tariqt@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231002104349.971927-2-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/23 4:43 AM, Tariq Toukan wrote:
> From: Dima Chumak <dchumak@nvidia.com>
> 
> Support port function commands to enable / disable IPsec crypto
> offloads, this is used to control the port IPsec device capabilities.
> 
> When IPsec crypto capability is disabled for a function of the port
> (default), function cannot offload IPsec operation. When enabled, IPsec
> operation can be offloaded by the function of the port.
> 
> Enabling IPsec crypto offloads lets the kernel to delegate XFRM state
> processing and encrypt/decrypt operation to the device hardware.
> 
> Example of a PCI VF port which supports IPsec crypto offloads:
> 
> $ devlink port show pci/0000:06:00.0/1
>     pci/0000:06:00.0/1: type eth netdev enp6s0pf0vf0 flavour pcivf pfnum 0 vfnum 0
> 	function:
> 	hw_addr 00:00:00:00:00:00 roce enable ipsec_crypto disable
> 
> $ devlink port function set pci/0000:06:00.0/1 ipsec_crypto enable
> 
> $ devlink port show pci/0000:06:00.0/1
>     pci/0000:06:00.0/1: type eth netdev enp6s0pf0vf0 flavour pcivf pfnum 0 vfnum 0
> 	function:
> 	hw_addr 00:00:00:00:00:00 roce enable ipsec_crypto enable
> 

Why not just 'ipsec' instead of 'ipsec_crypto'? What value does the
extra '_crypto' provide?



