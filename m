Return-Path: <netdev+bounces-30459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA76F78778D
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 20:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C3D1C20EA4
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 18:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7161415484;
	Thu, 24 Aug 2023 18:14:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4072828917
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 18:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CFAC433C7;
	Thu, 24 Aug 2023 18:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692900897;
	bh=ah6hoejZglaZltDj2TqykbcpDpG2iSExWH1WpAeeTuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=neGnK73eGLiMIeSuvNyK5AhN+8Tt2hYfcJr9dsZA/Yc4cobiqf+MFwJ3sLZS65Eok
	 VikV6O8rdSfsZXrM1NmBoUYw57Kq2EaoKOGGoDjmjMtNZ98Nq9XLErcZwSq28h4Pwt
	 hUUXUkQh/StJYDGxaFaPsxOU3T/lvqVawYa7hyynQTKC+Jiv4xShOev3oG5GfObI3J
	 07dQxydIzIVeD7lLt1DmoWBI8SQjS/iZtJwu+jozhCuUlpOYdbsxm6kI9x0Mi1QeHk
	 88RDg6WJQPCPrxP9LIoE+2SDrpMETcgb4NyU9SB5KMLX5EusRpOKiDZvfETEL5mQnk
	 BU1LjhfvsnBFQ==
Date: Thu, 24 Aug 2023 11:14:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>
Subject: Re: [RFC PATCH net-next 1/3] net: ethtool: add symmetric Toeplitz
 RSS hash function
Message-ID: <20230824111455.686e98b4@kernel.org>
In-Reply-To: <20230823164831.3284341-2-ahmed.zaki@intel.com>
References: <20230823164831.3284341-1-ahmed.zaki@intel.com>
	<20230823164831.3284341-2-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

CC Willem

On Wed, 23 Aug 2023 10:48:29 -0600 Ahmed Zaki wrote:
> Symmetric RSS hash functions are beneficial in applications that monitor
> both Tx and Rx packets of the same flow (IDS, software firewalls, ..etc).
> Getting all traffic of the same flow on the same RX queue results in
> higher CPU cache efficiency.
> 
> Allow ethtool to support symmetric Toeplitz algorithm. A user can set the
> RSS function of the netdevice via:
>     # ethtool -X eth0 hfunc symmetric_toeplitz

Looks fairly reasonable, but there are two questions we need to answer:
 - what do we do if RXH config includes fields which are by definition
   not symmetric (l2 DA or in the future flow label)?
 - my initial thought was the same as Saeed's - that the fields are
   sorted, so how do we inform user about the exact implementation?

One way to fix both problems would be to, instead of changing the hash
function, change the RXH config. Add new "xor-ed" fields there.

Another would be to name the function "XORSYM_TOP" and make the core
check that it cannot be combined with uni-dir fields?

I like the first option more.

Either way, please make sure to add docs, and extend the toeplitz test
for this.

> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 62b61527bcc4..9a8e1fb7170d 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -60,10 +60,11 @@ enum {
>  	ETH_RSS_HASH_TOP_BIT, /* Configurable RSS hash function - Toeplitz */
>  	ETH_RSS_HASH_XOR_BIT, /* Configurable RSS hash function - Xor */
>  	ETH_RSS_HASH_CRC32_BIT, /* Configurable RSS hash function - Crc32 */
> +	ETH_RSS_HASH_SYM_TOP_BIT, /* Configurable RSS hash function - Symmetric Toeplitz */
>  
>  	/*
>  	 * Add your fresh new hash function bits above and remember to update
> -	 * rss_hash_func_strings[] in ethtool.c
> +	 * rss_hash_func_strings[] in ethtool/common.c
>  	 */
>  	ETH_RSS_HASH_FUNCS_COUNT
>  };
> @@ -108,6 +109,7 @@ enum ethtool_supported_ring_param {
>  #define __ETH_RSS_HASH(name)	__ETH_RSS_HASH_BIT(ETH_RSS_HASH_##name##_BIT)
>  
>  #define ETH_RSS_HASH_TOP	__ETH_RSS_HASH(TOP)
> +#define ETH_RSS_HASH_SYM_TOP	__ETH_RSS_HASH(SYM_TOP)
>  #define ETH_RSS_HASH_XOR	__ETH_RSS_HASH(XOR)
>  #define ETH_RSS_HASH_CRC32	__ETH_RSS_HASH(CRC32)
>  
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index f5598c5f50de..a0e0c6b2980e 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -81,6 +81,7 @@ rss_hash_func_strings[ETH_RSS_HASH_FUNCS_COUNT][ETH_GSTRING_LEN] = {
>  	[ETH_RSS_HASH_TOP_BIT] =	"toeplitz",
>  	[ETH_RSS_HASH_XOR_BIT] =	"xor",
>  	[ETH_RSS_HASH_CRC32_BIT] =	"crc32",
> +	[ETH_RSS_HASH_SYM_TOP_BIT] =	"symmetric_toeplitz",
>  };
>  
>  const char


