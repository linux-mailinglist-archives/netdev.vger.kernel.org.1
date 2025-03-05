Return-Path: <netdev+bounces-171943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C418A4F8AA
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 09:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76B4B7A33E2
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 08:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415331FAC56;
	Wed,  5 Mar 2025 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="oy4gfSHP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903941D86F6
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162962; cv=none; b=PDw1tmMu7zYlIAQdXPRFAXOjk3Cm/P2kF5HT/SS9ESRM+U2nc58ZvnE8Qo9iNPCSornlZmHBcggkYRxYn6DlLMiTRv9UgiBKN1NvnRBC1KE65dY34Uk/XE+ZCsm+6feHSVlBPcbhe6Bvsz86tmRD1dS71wOJBJjai6V/UGJ6MNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162962; c=relaxed/simple;
	bh=nefCuvZh9BBXP1HgTB2e4dXo3Ejs7pSEpE8D1o/5fHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EoblHY7haUOGdNRoLzUwXixQni9fmkvx5vp/QGZZVPDDvwUS4Ny9SIfjqR2D9eigED/UmC52zfM+LCIXCltnZk3xjWOsn8cmuF8TdMzwGcc55bN4It8oocFGUcDAnwXb1alxNpu2iB0R1I930bWVZ7vne6leIRRN8kFwrlV5ORc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=oy4gfSHP; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e53b3fa7daso5384816a12.2
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 00:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741162958; x=1741767758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1brnVJAGUyBrrxRVaMvTP6y55O5yEMp4c+P5cyU9eYc=;
        b=oy4gfSHPVrs6EKnJ6VdugQ/D6WJbu7Hvhkz/xOUGN0u8aq8yhPGUChia/pc0qJmEkE
         lmzGcuI4p7AnUFYt0/ugjJj3EIqjrRyNDPk0ecPp/iKW+w8ddqSv18fJGyDLuujNpOXE
         ICZuDdFncPvzWlUXFd/i1+TbRPF3pjx7zNi6mqkGLT7+3RZwwJGOR2DgLKi2lN2p0muU
         3s7XfKBdYXh/q0I2kdIa3Q0qf90okSt3yO7qpkKiXB749GKIuKXUOtJnXfWMvPoa4hQI
         7jnDk4CwU1HRimIFfxegfIdqvSPiVGoV+QGM27bpUIhklGcphgQgq2IbMwPLCTYNG3M3
         ig9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162958; x=1741767758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1brnVJAGUyBrrxRVaMvTP6y55O5yEMp4c+P5cyU9eYc=;
        b=jlfWxYHh3qoTok0ieHT738Hpa2k3dc8aLiTe+GWlTzba5Vza0BN1zIyWV34Ru9vcED
         M66jXKBpxXQiQYt2KX+HQ/4MMCBEcf8KiDnGGkgtN6O/tUU1qM21t9ht3dbbru0J28sN
         xAcgMY2OWtwEXAhhuXSc/3awaQJGquCKbom8RozH4Ap40gARxS21FwNcCT0Ent15Z4cR
         4WYehZu2S9qbXHvgfPfNLyuKmCZRnFh2hVJ7Pj4bJlkFgevuWwNftEN8wHMQAxPCm+G0
         Fqi6x7amuf4eV0Ik8wXTdAtOFocb9Hxj2B5nFdKybifbbxH6eC5VFFjs/s4sle3eFghB
         54LA==
X-Gm-Message-State: AOJu0Yz3EFGuQja61cBn6kCzMqEG2G93pqSwcljuVTmIkI6b+fLRXAVn
	EOH+SCVTorExgHa9eijPiW/5JB8uVJCvnXA9lq9v3RIHPkZVL0hhPAEl9ZVsD0g=
X-Gm-Gg: ASbGnctGBim0Zm/pSGUsdmMJ9TQwUNsvDZshQ/liHQoPqR7g/fSFSjvytolb71UstWq
	thYDCv0Pi71178hJXPMt++KYUNIZGg1mOVRaaIFxrg0Sw5XIwYsLwgCWpJeBuC363R1A1buX8a5
	Wv6MJkghDFeKKlXScr0mM7WYIPtz58n0Pa7yVSw+j/INkbClKkb/jnxmIHl1ajhc2tpo4f49gcW
	kKzZAjk5jqtdZmulPjgQhEGG7tg3bAPFmDwcoEBxwy+fdJrmfY5dGuierEMrd7bg0cnQpu3lR8c
	n3Jmzy6jMV5gk8xZJmfLUt58qZoaGUscGCePTw6Fhys0+4Rgf33Rmo4emxqB2poQBUWGci5aME7
	8
X-Google-Smtp-Source: AGHT+IHSB1wDKnA9pHV1GSviWm2eGdZkD28ziFa7v6M0Rd/G5QVSKS+XqVwTfVjxopyszVvymfpwQA==
X-Received: by 2002:a05:6402:40cf:b0:5de:dfd0:9d22 with SMTP id 4fb4d7f45d1cf-5e59f470c8dmr2220203a12.22.1741162957444;
        Wed, 05 Mar 2025 00:22:37 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b6dbbbsm9395036a12.22.2025.03.05.00.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 00:22:36 -0800 (PST)
Message-ID: <350a057e-39ae-4e8d-a4ec-12b2f78f51cb@blackwall.org>
Date: Wed, 5 Mar 2025 10:22:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 11/15] netfilter: nft_flow_offload: Add
 DEV_PATH_MTK_WDMA to nft_dev_path_info()
To: Eric Woudstra <ericwouds@gmail.com>,
 Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20250228201533.23836-1-ericwouds@gmail.com>
 <20250228201533.23836-12-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250228201533.23836-12-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 22:15, Eric Woudstra wrote:
> In case of using mediatek wireless, in nft_dev_fill_forward_path(), the
> forward path is filled, ending with mediatek wlan1.
> 
> Because DEV_PATH_MTK_WDMA is unknown inside nft_dev_path_info() it returns
> with info.indev = NULL. Then nft_dev_forward_path() returns without
> setting the direct transmit parameters.
> 
> This results in a neighbor transmit, and direct transmit not possible.
> But we want to use it for flow between bridged interfaces.
> 
> So this patch adds DEV_PATH_MTK_WDMA to nft_dev_path_info() and makes
> direct transmission possible.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/netfilter/nft_flow_offload.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
> index 323c531c7046..b9e6d9e6df66 100644
> --- a/net/netfilter/nft_flow_offload.c
> +++ b/net/netfilter/nft_flow_offload.c
> @@ -105,6 +105,7 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
>  		switch (path->type) {
>  		case DEV_PATH_ETHERNET:
>  		case DEV_PATH_DSA:
> +		case DEV_PATH_MTK_WDMA:
>  		case DEV_PATH_VLAN:
>  		case DEV_PATH_PPPOE:
>  			info->indev = path->dev;
> @@ -117,6 +118,10 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
>  				i = stack->num_paths;
>  				break;
>  			}
> +			if (path->type == DEV_PATH_MTK_WDMA) {
> +				i = stack->num_paths;
> +				break;
> +			}
>  
>  			/* DEV_PATH_VLAN and DEV_PATH_PPPOE */
>  			if (info->num_encaps >= NF_FLOW_TABLE_ENCAP_MAX) {

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


