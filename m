Return-Path: <netdev+bounces-225298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08739B92080
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE62169E7D
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 15:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16FA2EB86A;
	Mon, 22 Sep 2025 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceYVxTI2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B70E2EB849
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555815; cv=none; b=VFKbI1oTPLUNqXFChs5g9sNOQz+ENokk1aSLhouWhN6A0nm8rwxYtKZIxlub4IUKjtPFQQIShWbGn050/uiymsp7r3KbNdBLA/uGGaEl7spgl+1vITHnS0qldiBu4Jz5FtS7xMJKL30++J4Kag1EvKwmw60AN1DxOr4A7U367As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555815; c=relaxed/simple;
	bh=yCDUfdybv2cpDR/gPmCqxuctyEFKTb4U4CQgebqSDuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Of6SIH7bD+kHpwUZ5xMgjMRR3JBcsQxGcJkidw88JjtfzZiebNxTlA/ajIIxX5HgVjQkbqQXIAsGeMUURLulbWB95tcdvT+/BVZpG5+wCZMjtLLj0Ew6aZzcMl5H6iAtdjk86NMeHXGiSVUnb8G3wme2UIWaKXJhOFLWAJwE+WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceYVxTI2; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f1f29a551so1999535b3a.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758555813; x=1759160613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v3V9jfcj4c/C9kF8Vt1ZcO3ulHKzrInrkcLPZRC1Na4=;
        b=ceYVxTI2PNUI+uUN7FLEKniyiBLsQt515iUa68iit8Gi/9wchaff/s1LapemZIloSX
         9KPvEwCtQVfZp1w+G/p2x1LmjDzz063Cz2r4Hx0wusI/sOV7OAFU2k8+9W/7a7XPNjyi
         glV3mUivfruxnYLmlaEkwZ3AJsrjzaS7C5RSRvIsRvVlZbhiIa5EATfLYAbeDm9+Q85+
         1hiE+yl5v2uTa3TzaTIIpFDbbe0ryCbFo+tY/ZyBI+UD7YN7ebokVrVKl/GL86bEEVuV
         XBB1NZgRziDMG38WRbPbs8A8eKHH6vLag+NZA3yLOMudcPPb0i2pZmh72XFW//kll4oc
         OAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758555813; x=1759160613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3V9jfcj4c/C9kF8Vt1ZcO3ulHKzrInrkcLPZRC1Na4=;
        b=ixYeBgXSPdW0voWSKvCxmLa7BnXxi3df6blMlcfr21KF0IytJnKDsvikSNn97XMfmB
         xkgTGRqg4Vi6YXhni3f2l6iNQcuIl24knorcAoRQqY8suzv4AwVp+a+Rs0GX5jnAM6Pk
         kIshixwSWBwLj8KuQOZVg0FLC2eJTXXugLQUeRInEo2mb3iUYAQoe6MB/hyAMREPjLtk
         ZiJn81EkGKPFo41dKprImxCVSdVUX90hC9OmjZS9YtXWIvqkmpulYVlyDiUXucK2fsV7
         ZSCGubez/B5hqgdHtUquFFxqaPqtW8IO91QEgQyV5Kjdjmf0S2e7Gu6yTvRE7S1ls3km
         bC4A==
X-Forwarded-Encrypted: i=1; AJvYcCW8wM+8xyVYWGbz/oKc+yW/nhKKoHQZjeZgK1bTeWL1JN4kGeozCC7b4ZsK2QtCPEwzEY8DUUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB3zEl1RIQ532jc0re/HCP4xNFlqY6/1ayRzuTiguyOVEVdpAc
	zh+FPq30QBtLcBqsMdhn8oFOSbisXiXVqsin6mI0xb3iJ5iV6fcQRUg=
X-Gm-Gg: ASbGnctJN5GPHvbOW1k5TYxCLEdfBU80fISX1ODlUY1H6Y0MXgSAka18L5c98wXk5t4
	uYWG6oqgfTeyJBn4cdxQXT7PuPWRN3LuBxQM3fkOn1c6Tag2kdxnWOcKwFSlA4hNYgoQ1PxSEfp
	XIPzeB0hoOesVMu/c4ZMJNnsoGEdPRDUkv6AbXpxLL2EDgOFmquEdYza8j60STjVw/ZBs9D/kBV
	KBkQvXjDgDQymuEZbWckV5rPBJv2Aty8QeTTUABW4Dr2hw1tKu987fsTI4Gmm84kHV2lr3flNbO
	SF58+EGTIgr+040/azi3eENWN5un72W+A/qlCDzuY/HZjmLNNq2QRb4STqHPjZrfrEuqpB5TnLY
	ckOldRpxsNNJ4LJSMBwXn+BtPwrCe2Qy7WcOHIIrzoBU9uszFE82gqC2QlSmX9WgS/3IXm3Vn6q
	GdMtp/9f0lj5dAjNiFdYlCgD5UiX/CBabOeIaZQuQB8RKtGxXB7+Lv7R8osslEI0rgcnvoUxmHQ
	4uT
X-Google-Smtp-Source: AGHT+IETBbukUvkAuvQVb1Skx6MlL0Qne0xJdc/u3lmyMRgaNlL6QuTtewx92TllrETSMx2zMBvRAA==
X-Received: by 2002:a05:6a20:7d8a:b0:251:c33d:2783 with SMTP id adf61e73a8af0-2925bace118mr16480567637.23.1758555813010;
        Mon, 22 Sep 2025 08:43:33 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-330607eac4esm13558095a91.21.2025.09.22.08.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 08:43:32 -0700 (PDT)
Date: Mon, 22 Sep 2025 08:43:32 -0700
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
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next 2/6] net: xdp: Add xmo_rx_checksum callback
Message-ID: <aNFupGy1QxlhRSUE@mini-arch>
References: <20250920-xdp-meta-rxcksum-v1-0-35e76a8a84e7@kernel.org>
 <20250920-xdp-meta-rxcksum-v1-2-35e76a8a84e7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250920-xdp-meta-rxcksum-v1-2-35e76a8a84e7@kernel.org>

On 09/20, Lorenzo Bianconi wrote:
> Introduce xmo_rx_checksum netdev callback in order allow the eBPF
> program bounded to the device to retrieve the RX checksum result computed
> by the hw NIC.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  include/net/xdp.h |  6 ++++++
>  net/core/xdp.c    | 29 +++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 6fd294fa6841d59c3d7dc4475e09e731996566b0..481b39976ac8c8d4db2de39055c72ba8d0d511c3 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -581,6 +581,10 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
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
> @@ -644,6 +648,8 @@ struct xdp_metadata_ops {
>  			       enum xdp_rss_hash_type *rss_type);
>  	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, __be16 *vlan_proto,
>  				   u16 *vlan_tci);
> +	int	(*xmo_rx_checksum)(const struct xdp_md *ctx, u8 *ip_summed,
> +				   u32 *cksum_meta);
>  };
>  
>  #ifdef CONFIG_NET
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 9100e160113a9a1e2cb88e7602e85c5f36a9f3b9..3edab2d5e5c7c2013b1ef98c949a83655eb94349 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -961,6 +961,35 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
>  	return -EOPNOTSUPP;
>  }
>  
> +/**
> + * bpf_xdp_metadata_rx_checksum - Read XDP frame RX checksum.
> + * @ctx: XDP context pointer.
> + * @ip_summed: Return value pointer indicating checksum result.
> + * @cksum_meta: Return value pointer indicating checksum result metadata.
> + *
> + * In case of success, ``ip_summed`` is set to the RX checksum result. Possible
> + * values are:
> + * ``CHECKSUM_NONE``
> + * ``CHECKSUM_UNNECESSARY``
> + * ``CHECKSUM_COMPLETE``
> + * ``CHECKSUM_PARTIAL``

What do you think about adding new UAPI enum here? Similar to
xdp_rss_hash_type for the hash. The values can match the internal
CHECKSUM_XXX ones with (BUILD_BUG_ONs to enforce the relationship).
Will be a bit nicer api-wise to have an enum than an opaque u8.

