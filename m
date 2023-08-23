Return-Path: <netdev+bounces-30122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB267860E8
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 21:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442961C20D49
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 19:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0CC1FB48;
	Wed, 23 Aug 2023 19:45:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13471FB37
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 19:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0D7C433C7;
	Wed, 23 Aug 2023 19:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692819918;
	bh=lsGEuPRKfKWs371RBzhxtFzAYt+HhjkscGi468j6VnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VkjEKl6DmsHHydIXLBano6M99uE9mkTtn+oc+yn5Lcp7AO9k+pPH78YmmkVeuo1J/
	 mGXJBXv71cNXqIYmdOE8tg5ntEGKQoAkpOTcq3TWs5ugU/hOr5OSCF2kezw0wfwRqC
	 nEFHOkbdo0r2NdIcWbPKVdNduDPvTRpzimPC8VXOIrfspQLaEfCIIdAbLYjNZe688x
	 06i7McwrNKXQE8pdDsS7+Xz0crJ4ZN3bJzEFmSlNh8xAYZbWoVJuCTa2VUyPw0W/+o
	 JrApSXXJcfoJmW+fbYxHR9KEPj/WB/YXK+Zjn319YJldgjG7eGEdOvjFYf4So3EesG
	 nG0oeMxm9gMRg==
Date: Wed, 23 Aug 2023 12:45:17 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com
Subject: Re: [RFC PATCH net-next 1/3] net: ethtool: add symmetric Toeplitz
 RSS hash function
Message-ID: <ZOZhzYExHgnSBej4@x130>
References: <20230823164831.3284341-1-ahmed.zaki@intel.com>
 <20230823164831.3284341-2-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230823164831.3284341-2-ahmed.zaki@intel.com>

On 23 Aug 10:48, Ahmed Zaki wrote:
>Symmetric RSS hash functions are beneficial in applications that monitor
>both Tx and Rx packets of the same flow (IDS, software firewalls, ..etc).
>Getting all traffic of the same flow on the same RX queue results in
>higher CPU cache efficiency.
>

Can you please shed more light on the use case and configuration? 
Where do you expect the same flow/connection rx/tx to be received by the
same rxq in a nic driver?

>Allow ethtool to support symmetric Toeplitz algorithm. A user can set the
>RSS function of the netdevice via:
>    # ethtool -X eth0 hfunc symmetric_toeplitz
>

What is the expectation of the symmetric toeplitz hash, how do you achieve
that? by sorting packet fields? which fields?

Can you please provide a link to documentation/spec?
We should make sure all vendors agree on implementation and expectation of
the symmetric hash function.

>Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
>---
> include/linux/ethtool.h | 4 +++-
> net/ethtool/common.c    | 1 +
> 2 files changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
>index 62b61527bcc4..9a8e1fb7170d 100644
>--- a/include/linux/ethtool.h
>+++ b/include/linux/ethtool.h
>@@ -60,10 +60,11 @@ enum {
> 	ETH_RSS_HASH_TOP_BIT, /* Configurable RSS hash function - Toeplitz */
> 	ETH_RSS_HASH_XOR_BIT, /* Configurable RSS hash function - Xor */
> 	ETH_RSS_HASH_CRC32_BIT, /* Configurable RSS hash function - Crc32 */
>+	ETH_RSS_HASH_SYM_TOP_BIT, /* Configurable RSS hash function - Symmetric Toeplitz */
>
> 	/*
> 	 * Add your fresh new hash function bits above and remember to update
>-	 * rss_hash_func_strings[] in ethtool.c
>+	 * rss_hash_func_strings[] in ethtool/common.c
> 	 */
> 	ETH_RSS_HASH_FUNCS_COUNT
> };
>@@ -108,6 +109,7 @@ enum ethtool_supported_ring_param {
> #define __ETH_RSS_HASH(name)	__ETH_RSS_HASH_BIT(ETH_RSS_HASH_##name##_BIT)
>
> #define ETH_RSS_HASH_TOP	__ETH_RSS_HASH(TOP)
>+#define ETH_RSS_HASH_SYM_TOP	__ETH_RSS_HASH(SYM_TOP)
> #define ETH_RSS_HASH_XOR	__ETH_RSS_HASH(XOR)
> #define ETH_RSS_HASH_CRC32	__ETH_RSS_HASH(CRC32)
>
>diff --git a/net/ethtool/common.c b/net/ethtool/common.c
>index f5598c5f50de..a0e0c6b2980e 100644
>--- a/net/ethtool/common.c
>+++ b/net/ethtool/common.c
>@@ -81,6 +81,7 @@ rss_hash_func_strings[ETH_RSS_HASH_FUNCS_COUNT][ETH_GSTRING_LEN] = {
> 	[ETH_RSS_HASH_TOP_BIT] =	"toeplitz",
> 	[ETH_RSS_HASH_XOR_BIT] =	"xor",
> 	[ETH_RSS_HASH_CRC32_BIT] =	"crc32",
>+	[ETH_RSS_HASH_SYM_TOP_BIT] =	"symmetric_toeplitz",
> };
>
> const char
>-- 
>2.39.2
>
>

