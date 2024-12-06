Return-Path: <netdev+bounces-149664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7FA9E6B2F
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5591916784B
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 09:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89351F472F;
	Fri,  6 Dec 2024 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIqun7C7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905721DB361;
	Fri,  6 Dec 2024 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733479183; cv=none; b=sPmeHGm8SxchaWEvt4DwpfkH28t7FEyT2rr7W5FIXmewhEbjKn+ca4cOH7mexj4JSemR1gMr6/624u3rcw7+pWF7Uo4c2/vx6HhPKyGQ9/EatF5g00L1UC2Sbp2cw9fxOEBjiviB3W+biNcz2EqCKzqnO0ijiwFN1/lL1/dyAZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733479183; c=relaxed/simple;
	bh=CeuSQcHdd8suFTsYTp7/+6YiPo2ymkTlLUJD52XBM8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6pmrirCVDVsgS+280lt4fRIiVoAqIERBhfHV9FwcL0wwAJLouEVIvlTPjF5Cm1djUcviVXwnQaOWKrcLcDNjPWaKngxsy/LWeUB4flpUzTnkE3a/h4mmT8h2AbqthYA2GwQcsU3EvhhefiUjZFLQOC/GGW9GZ+I2JIXEKR4sU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIqun7C7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B0EC4CED1;
	Fri,  6 Dec 2024 09:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733479183;
	bh=CeuSQcHdd8suFTsYTp7/+6YiPo2ymkTlLUJD52XBM8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uIqun7C7IibTb0jfp7wSgQ7Kcvcr5r2h1PJRYE6g6zi+x+RoUpREOld8m/12574xU
	 cu/HWYNMBCKdc+1UtLKu1aoLsmRkDrBLiUO6hbeAdXBJ+LM7oASh125kjsAyxtwzqH
	 rjSAO50xTQOJQEcP77zMHifzq+VsHySeluasPvvSNGBRvHKEjvXL6a7MghgsAEb5ng
	 75AdbWfE+ykTb6I/2XPZwOOKC3LDSJrqmwclJ3XvDDyCOw4SBMEP0rPDr6FBJCJH08
	 MD0pXj8TcK5nQ3Rq7YtwxA2CICDykehBKzpT+Fs5haXT/NQ76b76/4MaGD8/P7mIX9
	 /1gPao3+bhvXQ==
Date: Fri, 6 Dec 2024 09:59:38 +0000
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, frank.li@nxp.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v6 RESEND net-next 4/5] net: enetc: add LSO support for
 i.MX95 ENETC PF
Message-ID: <20241206095938.GJ2581@kernel.org>
References: <20241204052932.112446-1-wei.fang@nxp.com>
 <20241204052932.112446-5-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204052932.112446-5-wei.fang@nxp.com>

On Wed, Dec 04, 2024 at 01:29:31PM +0800, Wei Fang wrote:
> ENETC rev 4.1 supports large send offload (LSO), segmenting large TCP
> and UDP transmit units into multiple Ethernet frames. To support LSO,
> software needs to fill some auxiliary information in Tx BD, such as LSO
> header length, frame length, LSO maximum segment size, etc.
> 
> At 1Gbps link rate, TCP segmentation was tested using iperf3, and the
> CPU performance before and after applying the patch was compared through
> the top command. It can be seen that LSO saves a significant amount of
> CPU cycles compared to software TSO.
> 
> Before applying the patch:
> %Cpu(s):  0.1 us,  4.1 sy,  0.0 ni, 85.7 id,  0.0 wa,  0.5 hi,  9.7 si
> 
> After applying the patch:
> %Cpu(s):  0.1 us,  2.3 sy,  0.0 ni, 94.5 id,  0.0 wa,  0.4 hi,  2.6 si
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> ---
> v2: no changes
> v3: use enetc_skb_is_ipv6() helper fucntion which is added in patch 2
> v4: fix a typo
> v5: no changes
> v6: remove error logs from the datapath
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c  | 259 +++++++++++++++++-
>  drivers/net/ethernet/freescale/enetc/enetc.h  |  15 +
>  .../net/ethernet/freescale/enetc/enetc4_hw.h  |  22 ++
>  .../net/ethernet/freescale/enetc/enetc_hw.h   |  15 +-
>  .../freescale/enetc/enetc_pf_common.c         |   3 +
>  5 files changed, 304 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index dafe7aeac26b..82a7932725f9 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -523,6 +523,226 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
>  	}
>  }
>  
> +static inline int enetc_lso_count_descs(const struct sk_buff *skb)
> +{
> +	/* 4 BDs: 1 BD for LSO header + 1 BD for extended BD + 1 BD
> +	 * for linear area data but not include LSO header, namely
> +	 * skb_headlen(skb) - lso_hdr_len. And 1 BD for gap.
> +	 */
> +	return skb_shinfo(skb)->nr_frags + 4;
> +}
> +
> +static int enetc_lso_get_hdr_len(const struct sk_buff *skb)
> +{
> +	int hdr_len, tlen;
> +
> +	tlen = skb_is_gso_tcp(skb) ? tcp_hdrlen(skb) : sizeof(struct udphdr);
> +	hdr_len = skb_transport_offset(skb) + tlen;

Hi Wei,

I am wondering if packets that are neither TCP nor UDP can be process
by the LSO code added by this patch, and if so, what the implications are.

> +
> +	return hdr_len;
> +}

...

