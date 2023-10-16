Return-Path: <netdev+bounces-41598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E09AA7CB689
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 00:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956F02815B2
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 22:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6E338F9F;
	Mon, 16 Oct 2023 22:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDG8J87n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A9438F98
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 22:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50618C433C7;
	Mon, 16 Oct 2023 22:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697495024;
	bh=bRrY6z8Qu3DHxdJ9AWDgW2EEHgMVRnN3AxmhHve8YT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vDG8J87nBqFt4L6UK9UD0UURS6rn2Zw5xR5YguOBewzOHIpPmFmU7m2BWITb6nKtP
	 1bUMsnYgmBJ4ihkMfm+CKSQdB3svbnsafQLeqhOFOT8aktvznQeOxoMXxDgMEtluL7
	 /ItwqYCfITwZEq0Uie/0PtTtmP9FVsNExso+35t63ihM5YqgcXBMy5DV+4xCo7+VDv
	 TPMkgErh0SFf1NgbrzXJ+Ix4F2S+8Vj/+cEVZJ8gJvDyeHUSUfZ2MG8WTaTulWAS4S
	 EnMQJ/67pYltlKrmgWTsmdVmhsC1YnbjYbAx6+rDe3WByYmkhpCkwcVyU596eWuhgB
	 UfsfQyYAwwdZA==
Date: Mon, 16 Oct 2023 15:23:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Takeru Hayasaka <hayatake396@gmail.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Harald Welte <laforge@gnumonks.org>,
 Pablo Neira Ayuso <pablo@netfilter.org>, osmocom-net-gprs@lists.osmocom.org
Subject: Re: [PATCH net-next v2] ethtool: ice: Support for RSS settings to
 GTP from ethtool
Message-ID: <20231016152343.1fc7c7be@kernel.org>
In-Reply-To: <20231012060115.107183-1-hayatake396@gmail.com>
References: <20231012060115.107183-1-hayatake396@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Thanks for the v2!

Adding Willem, Pablo, and Harald to CC (please CC them on future
versions).

On Thu, 12 Oct 2023 06:01:15 +0000 Takeru Hayasaka wrote:
> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index f7fba0dc87e5..a2d4f2081cf3 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -2011,6 +2011,18 @@ static inline int ethtool_validate_duplex(__u8 duplex)
>  #define	IPV4_FLOW	0x10	/* hash only */
>  #define	IPV6_FLOW	0x11	/* hash only */
>  #define	ETHER_FLOW	0x12	/* spec only (ether_spec) */
> +#define GTPU_V4_FLOW 0x13	/* hash only */
> +#define GTPU_V6_FLOW 0x14	/* hash only */
> +#define GTPC_V4_FLOW 0x15	/* hash only */
> +#define GTPC_V6_FLOW 0x16	/* hash only */
> +#define GTPC_TEID_V4_FLOW 0x17	/* hash only */
> +#define GTPC_TEID_V6_FLOW 0x18	/* hash only */
> +#define GTPU_EH_V4_FLOW 0x19	/* hash only */
> +#define GTPU_EH_V6_FLOW 0x20	/* hash only */

nit: please note that these are hex numbers,
     next value after 0x19 is 0x1a, not 0x20.

> +#define GTPU_UL_V4_FLOW 0x21	/* hash only */
> +#define GTPU_UL_V6_FLOW 0x22	/* hash only */
> +#define GTPU_DL_V4_FLOW 0x23	/* hash only */
> +#define GTPU_DL_V6_FLOW 0x24	/* hash only */
>  /* Flag to enable additional fields in struct ethtool_rx_flow_spec */
>  #define	FLOW_EXT	0x80000000
>  #define	FLOW_MAC_EXT	0x40000000

What gives me pause here is the number of flow sub-types we define
for GTP hashing.

My understanding of GTP is limited to what I just read on Wikipedia.

IIUC the GTPC vs GTPU distinction comes down to the UDP port on
which the protocol runs? Are the frames also different?

I'm guessing UL/DL are uplink/downlink but what's EH?

How do GTPU_V4_FLOW, GTPU_EH_V4_FLOW, GTPU_UL_V4_FLOW, and
GTPU_DL_V4_FLOW differ?

Key question is - are there reasonable use cases that you can think of
for enabling GTP hashing for each one of those bits individually or can
we combine some of them?

> @@ -2025,6 +2037,7 @@ static inline int ethtool_validate_duplex(__u8 duplex)
>  #define	RXH_IP_DST	(1 << 5)
>  #define	RXH_L4_B_0_1	(1 << 6) /* src port in case of TCP/UDP/SCTP */
>  #define	RXH_L4_B_2_3	(1 << 7) /* dst port in case of TCP/UDP/SCTP */
> +#define	RXH_GTP_TEID	(1 << 8) /* teid in case of GTP */
>  #define	RXH_DISCARD	(1 << 31)

