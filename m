Return-Path: <netdev+bounces-226587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F214FBA2610
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 06:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1DA5615A8
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 04:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C15233704;
	Fri, 26 Sep 2025 04:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coQT9YQ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6A8E56A
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 04:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758860461; cv=none; b=F4lSNQ7ALxLQdynnCbTzBvcJipZeyC0aLI6r4JG9yQEp0CBzv1h2lBuwlqOYcoEjU59L3q6prdJLgkb61Ma6ijPeleWiH8ZYjczREwGsdLtRTCsm596zNJXBiU/o0L0u+a/Sqsm9ESNiLNQeRxy7r/4kovws/istktRNZtatwjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758860461; c=relaxed/simple;
	bh=eR95EyaDEJj3N3ApGR3XQ1Y0G40+I20qy/wBgSvIZVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOX8JTM4qzYx5BByj6RFmVYm75P0IjFlRq0Avw3opJ59l7NFQuyCOSnLnayi6YNjbzNa/ZQmCMFF02l1YMzpC/t+yK+OuWW3vEI6/G9J6HBXohnPiwW08oP8MQP2VlDDUwbXEc4KTn8ftLzNcApID5GxQxfEdYZ70pQLGRp2hw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coQT9YQ3; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b5506b28c98so1183022a12.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 21:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758860459; x=1759465259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sXTN/i9kgbuo8arMMY6rYBFHJ+Czs9wquc3zmOOkLw8=;
        b=coQT9YQ3k+xJUbS9FiFI+MMMuIRUv8/Et/C9hobAqD1GE3r8mno1FYUp8QpSp/hSH8
         NjS4T35WTVDS6sw1L3R6Wy2/XCRg4XupWZk47f2fytX20iD5ugGwDd9BiaJeQwyWfSgC
         p5mj5EQIWJr/zKD5gJ2fPlQ+8JibJoUuHRJBgxSIdQRW9n5VLSc/mTvdSmGU040OKK2g
         rLqcdxXiKPNbMtONZvTrhHiiX8nb9WefYLKaVkAZUXxBlqJyeHJx5Fs/PN/Jrf+R/U+k
         mcCWfhHW9R0xN3uywNNx1+4JcvJduvi61Vn69Dl0RZl+wsYqyLLX/wtjWI90vvTVm00Y
         4y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758860459; x=1759465259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXTN/i9kgbuo8arMMY6rYBFHJ+Czs9wquc3zmOOkLw8=;
        b=Yh6ZwYfG3PPOciuz0ZVU4jeobrwlPhqoIykm21kODs1LUcIBvZY3/FNu1xerm44PQx
         fmSxqNyTitR5ROWsZdnV/nM09Y7HuBr567xwg6M8Jz0hRo0ciSBUHhszzsmV8/FaOhQl
         PJj1H4JSCkxqfU6yF+P433qOaixiRIVGU8cTqU4aV/mDxlk0WDNEDVuvd9GRbDuyz1QD
         zXMvkD2qLgS6PfWNH6KkzewL6NjgNgJYgEnBgXZeMfjnE8AC97W492Zswg8Qa0bpCD/I
         /wNRI+FAxkSchFnk3j9a+yJX8JMFGt1bMa58DDSFII6cW40gWQvffRdE/3TNjqbjm5S9
         2lyA==
X-Forwarded-Encrypted: i=1; AJvYcCU4Oni6m4DX6fDxQmGGQiUo8XqCFQQ5zUgrdf5wcB5RrBj4CqvW7Z/iNtWGuLkWvzhcOLj8kAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ykzHcM8BCluqCzO7asb7IVMFgKreRG2Gk9/DH6d4iqRRlr9c
	LF7usiv1lbVc7QFeSPE44H8kBPapyhK7jUlwMHNxJ/+hlrf6u2QUHrE=
X-Gm-Gg: ASbGncu+xkLwpAibFyNNIPR4L0pRE7hXKUmNBNgqDHhPczjhieU4Hx+Gb0unAy7Pdke
	kiFm7zEScBChyfVmT+wjsMymL9duiZec8GD0ax3XqG9JUKITaRF6XwzNVkho8u+FVIIcNsp/mFE
	VieZhi3Y1uJPF2gZlCxRO1jkyFoPf50xJ0BX0YV2au85sUQ/D67EW7BwLOIplhKfLdZaU6SVqvx
	RAD2gKMzmZAPplOcAYCeI6QnWuCs4tiLp+aNY8hOdoNurDDtXfqN+8QFn/ZOoJTiC6/+vdJq777
	ieLK8fpdShSGn2TWugy32OXhfRhSHwA2M/lJ/ggb0bJ9DN+8YezgZrZ9TrttPtbI8ShZ8DEEdAc
	xrmvGOU0iysaZbnwPz7VfSTijELBjETDiloSGRVUi0zbXByrege/7AvVZphXeauOYTWtj8tSOlB
	Wokr3mgU74fuSkaDD7KWwdqjgKkoOq8dOL9nKF0WxnLkWl/i4Jpp4JESfvCy4mLNxnIkHTiGhb8
	QH7
X-Google-Smtp-Source: AGHT+IGHgag9Cvz1ZRdx/09/Op9JnLEt1h9vJf23LW70kwNFj3KdcgxMtOnNN6rMFnuWqeU3odbSTw==
X-Received: by 2002:a17:902:cccf:b0:252:50ad:4e6f with SMTP id d9443c01a7336-27ed4adad59mr69191975ad.54.1758860458545;
        Thu, 25 Sep 2025 21:20:58 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-27ed6700ccdsm40125045ad.37.2025.09.25.21.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 21:20:58 -0700 (PDT)
Date: Thu, 25 Sep 2025 21:20:57 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v2 1/5] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <aNYUqdaIJV1cvFCb@mini-arch>
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
 <20250925-bpf-xdp-meta-rxcksum-v2-1-6b3fe987ce91@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250925-bpf-xdp-meta-rxcksum-v2-1-6b3fe987ce91@kernel.org>

On 09/25, Lorenzo Bianconi wrote:
> Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
> checksum will be use by devices capable of exposing receive checksum
> result via bpf_xdp_metadata_rx_checksum().
> Moreover, introduce xmo_rx_checksum netdev callback in order allow the
> eBPF program bounded to the device to retrieve the RX checksum result
> computed by the hw NIC.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/netlink/specs/netdev.yaml |  5 +++++
>  include/net/xdp.h                       | 14 ++++++++++++++
>  net/core/xdp.c                          | 29 +++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index e00d3fa1c152d7165e9485d6d383a2cc9cef7cfd..00699bf4a7fdb67c6b9ee3548098b0c933fd39a4 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -61,6 +61,11 @@ definitions:
>          doc: |
>            Device is capable of exposing receive packet VLAN tag via
>            bpf_xdp_metadata_rx_vlan_tag().
> +      -
> +        name: checksum
> +        doc: |
> +          Device is capable of exposing receive checksum result via
> +          bpf_xdp_metadata_rx_checksum().
>    -
>      type: flags
>      name: xsk-flags
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index aa742f413c358575396530879af4570dc3fc18de..9ab9ac10ae2074b70618a9d4f32544d8b9a30b63 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -586,6 +586,10 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
>  			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
>  			   bpf_xdp_metadata_rx_vlan_tag, \
>  			   xmo_rx_vlan_tag) \
> +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CHECKSUM, \
> +			   NETDEV_XDP_RX_METADATA_CHECKSUM, \
> +			   bpf_xdp_metadata_rx_checksum, \
> +			   xmo_rx_checksum)
>  
>  enum xdp_rx_metadata {
>  #define XDP_METADATA_KFUNC(name, _, __, ___) name,
> @@ -643,12 +647,22 @@ enum xdp_rss_hash_type {
>  	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
>  };
>  
> +enum xdp_checksum {
> +	XDP_CHECKSUM_NONE		= CHECKSUM_NONE,
> +	XDP_CHECKSUM_UNNECESSARY	= CHECKSUM_UNNECESSARY,
> +	XDP_CHECKSUM_COMPLETE		= CHECKSUM_COMPLETE,
> +	XDP_CHECKSUM_PARTIAL		= CHECKSUM_PARTIAL,
> +};

Btw, might be worth mentioning, awhile ago we had settled on a smaller set of
exposed types:

https://lore.kernel.org/netdev/20230811161509.19722-13-larysa.zaremba@intel.com/

Maybe go through the previous postings and check if the arguments are
still relevant? (or explain why we want more checksum now)

