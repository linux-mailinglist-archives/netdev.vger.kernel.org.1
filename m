Return-Path: <netdev+bounces-95839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DE78C39F4
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 03:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3922A1F21075
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 01:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C56F626CB;
	Mon, 13 May 2024 01:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9cp7PL7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BE41CD3C
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 01:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715565282; cv=none; b=XzuNo6qBduwlNdH+ybPl4ZqAJ4SLvKkVwFZCHWYTdBFmyX0jcUbxrZR4bljXlTQGFtTxRq7DciKNgSK5FhrOPAZezpf3u//ae0jgPRO/1oH2K2BqKoIOjLJ08AH3iD9msDdxA9A0DkbO0rf5LnJbyfIr+tfe0cTqKYpyRXKqmyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715565282; c=relaxed/simple;
	bh=4y5/QkQAMQO2sJqLtA+Z80AAYH0SYkOz3x6FYNbFh20=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iU58suiYAentB8N4/zKAZwJCAMHgLCZCVmzmM/G2rA9fSWPCO4zaEmsLsKVzIZ1V+dLm5BP5l/tkN4HoLaEYTeVx4MQgw2uH1WvBCItvQ+a1ab447lfkGb4bl0PdSSVrkrbGLqcOEvo6B2YRtsr7RRdYHCgX5q9QAaUFy0G/DAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9cp7PL7; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-792bdf626beso353288585a.1
        for <netdev@vger.kernel.org>; Sun, 12 May 2024 18:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715565279; x=1716170079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cj+fVw/FgmEs7N5Wcx4hgbsZPiziqx2DHpBzwIrmuA=;
        b=F9cp7PL7pYstn/s1eijrQMtQB8+d/OW2SeHV0nWqTs8bl4sTtoCu62Fk3VXBcZxQsy
         BAP297ZjxMy9WmpRC5XsI3+Kaq9JJY/J4AAF2pWrLoQ3t07AuhfYeq9cS9JfWjkxprhh
         0JOcaRnOGm219SWYvakakuGyya2gHTFIaWr5wpMtHG1W082vFRS2C6h1sYsoDh4dz5wF
         L4yLvmgJdZs3CTXX2lb+C0p4Q1W2edzDsWZDjuFy7ajw487ZmK+g6EYBfUOYOznibB5C
         gEZX6IeHS1fqWH/iqdKNbGEWbHymOVezhrGT/gPFr+QUkD4CwBrbiM/hdhIYysNphBR6
         6k1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715565279; x=1716170079;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2cj+fVw/FgmEs7N5Wcx4hgbsZPiziqx2DHpBzwIrmuA=;
        b=rQDMFk4+HhOp6tFtyRJg9j6HHF2NXNXZcE4jsdi28K8Jb4DFaEDsrkj+Avq/rNy+XV
         j4C4+qlqup3kopn3YpiVFH6i4/cIDIbAPmJcI+3VSKDbq5U69E4Oj1Jm/MufzxgKvhfT
         jKXDXe0b5fK9ikzBKLGHCgT5kMx4wmOOKChUBQulU1PKCcNOPsxysVrzIYTCHIWzESpR
         Epqwf5zzIzTFKUuvlGcVDiYhZDrQtDs+UDK43ICsfQdbahKW0x+DeXE9p/dn/qVGkrPC
         om/fbKN7VfrMcL+O0W9pWF3jXZfZb+zkxAvkDKloihz3WhR9cjKWe/WfpDbElFki8Ijx
         7uRw==
X-Forwarded-Encrypted: i=1; AJvYcCWEZIOo5RuueBTw5cGRxffXMieZp38FmoPf+SmE8i0k25B+lGWqffbzd4jIqimCvSRQcWCldrCK9+8oOESXHBIDJ5G+emrM
X-Gm-Message-State: AOJu0YxXK2GpWtctzG/aByeig8pJD/e6lbwa54ASTgib6/cG1/ccWh37
	IUXbri1vYifB0A5x72eC0ClgGFhns6WkEJegLAi4m/2yNJnb8NXj
X-Google-Smtp-Source: AGHT+IE44bA2VJYhRYu3LAQ6duJD+12NCnke05wwfk98QNKSHek81czdcAwJYZ569lOe9YULdRVzqw==
X-Received: by 2002:a05:620a:57a:b0:790:f57c:5c46 with SMTP id af79cd13be357-792c6dbf857mr1377271285a.29.1715565279411;
        Sun, 12 May 2024 18:54:39 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2fc7e4sm411615385a.97.2024.05.12.18.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 18:54:39 -0700 (PDT)
Date: Sun, 12 May 2024 21:54:38 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org
Cc: pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 borisp@nvidia.com, 
 gal@nvidia.com, 
 cratiu@nvidia.com, 
 rrameshbabu@nvidia.com, 
 steffen.klassert@secunet.com, 
 tariqt@nvidia.com, 
 Raed Salem <raeds@nvidia.com>, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <664172ded406f_1d6c6729412@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240510030435.120935-15-kuba@kernel.org>
References: <20240510030435.120935-1-kuba@kernel.org>
 <20240510030435.120935-15-kuba@kernel.org>
Subject: Re: [RFC net-next 14/15] net/mlx5e: Add Rx data path offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> From: Raed Salem <raeds@nvidia.com>
> 
> On receive flow inspect received packets for PSP offload indication using
> the cqe, for PSP offloaded packets set SKB PSP metadata i.e spi, header
> length and key generation number to stack for further processing.
> 
> Signed-off-by: Raed Salem <raeds@nvidia.com>
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h  |  2 +-
>  .../mellanox/mlx5/core/en_accel/nisp_rxtx.c   | 79 +++++++++++++++++++
>  .../mellanox/mlx5/core/en_accel/nisp_rxtx.h   | 28 +++++++
>  .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 10 +++
>  4 files changed, 118 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
> index 82064614846f..9f025c80a6ef 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
> @@ -40,7 +40,7 @@
>  #include "en/txrx.h"
>  
>  /* Bit31: IPsec marker, Bit30: reserved, Bit29-24: IPsec syndrome, Bit23-0: IPsec obj id */
> -#define MLX5_IPSEC_METADATA_MARKER(metadata)  (((metadata) >> 31) & 0x1)
> +#define MLX5_IPSEC_METADATA_MARKER(metadata)  ((((metadata) >> 30) & 0x3) == 0x2)
>  #define MLX5_IPSEC_METADATA_SYNDROM(metadata) (((metadata) >> 24) & GENMASK(5, 0))
>  #define MLX5_IPSEC_METADATA_HANDLE(metadata)  ((metadata) & GENMASK(23, 0))
>  
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.c
> index c719b2916677..17f42b8d9fd8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.c
> @@ -15,6 +15,12 @@
>  #include "en_accel/nisp.h"
>  #include "lib/psp_defs.h"
>  
> +enum {
> +	MLX5E_NISP_OFFLOAD_RX_SYNDROME_DECRYPTED,
> +	MLX5E_NISP_OFFLOAD_RX_SYNDROME_AUTH_FAILED,
> +	MLX5E_NISP_OFFLOAD_RX_SYNDROME_BAD_TRAILER,
> +};
> +
>  static void mlx5e_nisp_set_swp(struct sk_buff *skb,
>  			       struct mlx5e_accel_tx_nisp_state *nisp_st,
>  			       struct mlx5_wqe_eth_seg *eseg)
> @@ -114,6 +120,79 @@ static bool mlx5e_nisp_set_state(struct mlx5e_priv *priv,
>  	return ret;
>  }
>  
> +void mlx5e_nisp_csum_complete(struct net_device *netdev, struct sk_buff *skb)
> +{
> +	pskb_trim(skb, skb->len - PSP_TRL_SIZE);
> +}
> +
> +/* Receive handler for PSP packets.
> + *
> + * Presently it accepts only already-authenticated packets and does not
> + * support optional fields, such as virtualization cookies.
> + */
> +static int psp_rcv(struct sk_buff *skb)
> +{
> +	const struct psphdr *psph;
> +	int depth = 0, end_depth;
> +	struct psp_skb_ext *pse;
> +	struct ipv6hdr *ipv6h;
> +	struct ethhdr *eth;
> +	__be16 proto;
> +	u32 spi;
> +
> +	eth = (struct ethhdr *)(skb->data);
> +	proto = __vlan_get_protocol(skb, eth->h_proto, &depth);
> +	if (proto != htons(ETH_P_IPV6))
> +		return -EINVAL;
> +
> +	ipv6h = (struct ipv6hdr *)(skb->data + depth);
> +	depth += sizeof(*ipv6h);
> +	end_depth = depth + sizeof(struct udphdr) + sizeof(struct psphdr);
> +
> +	if (unlikely(end_depth > skb_headlen(skb)))
> +		return -EINVAL;
> +
> +	pse = skb_ext_add(skb, SKB_EXT_PSP);
> +	if (!pse)
> +		return -EINVAL;
> +
> +	psph = (const struct psphdr *)(skb->data + depth + sizeof(struct udphdr));
> +	pse->spi = psph->spi;
> +	spi = ntohl(psph->spi);
> +	pse->generation = 0;
> +	pse->version = FIELD_GET(PSPHDR_VERFL_VERSION, psph->verfl);
> +
> +	ipv6h->nexthdr = psph->nexthdr;
> +	ipv6h->payload_len =
> +		htons(ntohs(ipv6h->payload_len) - PSP_ENCAP_HLEN - PSP_TRL_SIZE);
> +
> +	memmove(skb->data + PSP_ENCAP_HLEN, skb->data, depth);
> +	skb_pull(skb, PSP_ENCAP_HLEN);
> +
> +	return 0;
> +}
> +
> +void mlx5e_nisp_offload_handle_rx_skb(struct net_device *netdev, struct sk_buff *skb,
> +				      struct mlx5_cqe64 *cqe)
> +{
> +	u32 nisp_meta_data = be32_to_cpu(cqe->ft_metadata);
> +
> +	/* TBD: report errors as SW counters to ethtool, any further handling ? */
> +	switch (MLX5_NISP_METADATA_SYNDROM(nisp_meta_data)) {
> +	case MLX5E_NISP_OFFLOAD_RX_SYNDROME_DECRYPTED:
> +		if (psp_rcv(skb))
> +			netdev_warn_once(netdev, "PSP handling failed");
> +		skb->decrypted = 1;

Do not set skb->decrypted if psp_rcv failed? But drop the packet and
account the drop, likely.

> +		break;
> +	case MLX5E_NISP_OFFLOAD_RX_SYNDROME_AUTH_FAILED:
> +		break;
> +	case MLX5E_NISP_OFFLOAD_RX_SYNDROME_BAD_TRAILER:
> +		break;
> +	default:
> +		break;
> +	}
> +}


