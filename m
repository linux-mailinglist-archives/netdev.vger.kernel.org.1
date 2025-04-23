Return-Path: <netdev+bounces-184945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9714A97C37
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 03:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2399189EE29
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3231262FCD;
	Wed, 23 Apr 2025 01:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="USIm+nKM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3C12620D5
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 01:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745372540; cv=none; b=X7BbCuZGAh07p+lwa3yCcNAiId3F5GfnznEuQtIoxDbrDDkGcVzxle6bsCq8JBvcvDu/KYHfnz1bjdzIp4M4g7GBtCKtRu5TBlpjsTZzwZVVv4ikUNIOrXHFBa3Lni3W4nctXGDTZUdJ2NrNh/8QhjY50ot/JJuBs9mf7JQSkL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745372540; c=relaxed/simple;
	bh=IZYZmcZ5+FeVp8pN0V49Fk54qeqMM7Icf1Fiyxs5RpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkA7JnvPDrHpl4S+3hmb358+V8Mg4IfCoX2qp8BxJ91VOAEtSZ88QBpRXmokF7Z6V82gyAN6PcngTou/hWJH60YUAifAi7cWShaDlNL/bppcIwMPhi9yQP7VkZMVHQtQ5Ro3B9hEql716yKmi7FXxpjs6DQE166fyREMiz3Ifmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=USIm+nKM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224191d92e4so58445535ad.3
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 18:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745372537; x=1745977337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0eQlRTWi1ThOTM0osK5ZbTwgG+k9NeRDzksiJyuhXA=;
        b=USIm+nKMT3XDjzXGiP/CcMiuqfeZfG+8+zx5MCxP0TrgFxWmVdmtl1LojF8sLuZee7
         w2PP06dgIFGEfm+G9qOYROq5kJSIlUlmqBsJdCVHn6ctIe4+2IzC1KHMc0i8z8ysmulg
         6YRWYTeMT4MiJVuOibF7a3yK5ksIOBOn6iyEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745372537; x=1745977337;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p0eQlRTWi1ThOTM0osK5ZbTwgG+k9NeRDzksiJyuhXA=;
        b=KvT7r78sgs8xkzu8AqSUAxdZzXdq3KmNPhcXK2p8N2VdMguB1r88H6iDlSolblSCnv
         rql7uw4WU21puM52GbowmPNfRL1AHdfMU785Bw0Au0rz7BT3UOvpFZUisBt8lRY+MYIk
         e2r0qfS4zdQU6MjO/RiBTvfGDzMPjhfgxmxRuaJhpbrdyFZWMNF+RcUoWi9sttlDYku5
         /moMkPKDYicfC9QTuynF6h+3LHJOtHrF8vSotKTiG/ZE4bkn0QhcCo+7MNbj6loPe6zK
         /hnG7J2BKp7piMRWqTgJco9QKNvEYbT3ubomyuJHWt+SmQY/vv1t/vFiQrIEqLcOZrZD
         SNgQ==
X-Gm-Message-State: AOJu0YwwQFxi0zutxA5z2Bw2MTmpWHdcVlGDrrvjiXNMOWgy6WS1hgyw
	RY+zSriDTglo5fu8+lYx9Qctu7m0AYYIZgFKWwCT5ay2Gqt/3U36hBhn9M790W0=
X-Gm-Gg: ASbGncv4kkYd1yqTVmTbbNwwihPBk/xQfurJgH1yHbD7I4npmyrBm5Y0DLD60Kafqcx
	3gN6gMI8PWb11+HBoUE5jXyACxyEbzRXlCAS2XIG5ioCrc2xkjb510Q/Qv9ertc49RczZlsDoyM
	+TlEkWx+A1l/xkVO6rntR8ESYn2Fyyyoe3AvnUVUrV/YleLm57uvThwK9Lnw/HrLapDkFnsPSOE
	JP/cTKIu7jh6LcjI11qIU0y+tPRbPCIIlOqvUvvMZCbxmeBQT1DsLguDWLeLoPs+7mGtPDKl59n
	mygpgNIXiXAlASe1hXj0HB/JV567R50Uc3EV0M9pA3gJqBRC+PTsvPLKLyDvl1Tc8XFWb/X/lXm
	UA/ZXg3A=
X-Google-Smtp-Source: AGHT+IFynIH9OJbR+0cqJfFpfno20jGYpNgsvhoPhcd6N5lULrePTo0fNEqFbkMiFdeOMauJKWs5rA==
X-Received: by 2002:a17:902:f652:b0:223:628c:199 with SMTP id d9443c01a7336-22c53620c8bmr229665635ad.52.1745372537249;
        Tue, 22 Apr 2025 18:42:17 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fdea5csm92365125ad.247.2025.04.22.18.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 18:42:16 -0700 (PDT)
Date: Tue, 22 Apr 2025 18:42:13 -0700
From: Joe Damato <jdamato@fastly.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jeroendb@google.com,
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com,
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com,
	shailend@google.com, linux@treblig.org, thostet@google.com,
	jfraker@google.com, horms@kernel.org, linux-kernel@vger.kernel.org,
	Jeff Rogers <jefrogers@google.com>
Subject: Re: [PATCH net-next 1/6] gve: Add device option for nic clock
 synchronization
Message-ID: <aAhFdQgbTfP2ZuIC@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jeroendb@google.com,
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com,
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com,
	shailend@google.com, linux@treblig.org, thostet@google.com,
	jfraker@google.com, horms@kernel.org, linux-kernel@vger.kernel.org,
	Jeff Rogers <jefrogers@google.com>
References: <20250418221254.112433-1-hramamurthy@google.com>
 <20250418221254.112433-2-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418221254.112433-2-hramamurthy@google.com>

On Fri, Apr 18, 2025 at 10:12:49PM +0000, Harshitha Ramamurthy wrote:
> From: John Fraker <jfraker@google.com>
> 
> This patch adds the device option and negotiation with the device for
> clock synchronization with the nic. This option is necessary before the
> driver will advertise support for hardware timestamping or other related
> features.
> 
> Co-developed-by: Jeff Rogers <jefrogers@google.com>
> Signed-off-by: Jeff Rogers <jefrogers@google.com>
> Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: John Fraker <jfraker@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---

[...]

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index 3e8fc33cc11f..ae20d2f7e6e1 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -46,6 +46,7 @@ void gve_parse_device_option(struct gve_priv *priv,
>  			     struct gve_device_option_buffer_sizes **dev_op_buffer_sizes,
>  			     struct gve_device_option_flow_steering **dev_op_flow_steering,
>  			     struct gve_device_option_rss_config **dev_op_rss_config,
> +			     struct gve_device_option_nic_timestamp **dev_op_nic_timestamp,
>  			     struct gve_device_option_modify_ring **dev_op_modify_ring)
>  {
>  	u32 req_feat_mask = be32_to_cpu(option->required_features_mask);
> @@ -225,6 +226,23 @@ void gve_parse_device_option(struct gve_priv *priv,
>  				 "RSS config");
>  		*dev_op_rss_config = (void *)(option + 1);
>  		break;
> +	case GVE_DEV_OPT_ID_NIC_TIMESTAMP:
> +		if (option_length < sizeof(**dev_op_nic_timestamp) ||
> +		    req_feat_mask != GVE_DEV_OPT_REQ_FEAT_MASK_NIC_TIMESTAMP) {
> +			dev_warn(&priv->pdev->dev, GVE_DEVICE_OPTION_ERROR_FMT,
> +				 "Nic Timestamp",
> +				 (int)sizeof(**dev_op_nic_timestamp),
> +				 GVE_DEV_OPT_REQ_FEAT_MASK_NIC_TIMESTAMP,
> +				 option_length, req_feat_mask);
> +			break;
> +		}
> +
> +		if (option_length > sizeof(**dev_op_nic_timestamp))
> +			dev_warn(&priv->pdev->dev,
> +				 GVE_DEVICE_OPTION_TOO_BIG_FMT,
> +				 "Nic Timestamp");
> +		*dev_op_nic_timestamp = (void *)(option + 1);
> +		break;

Overall: The above pattern is repeated quite a bit. Maybe it's time
to refactor gve_parse_device_option to eliminate all the duplicated
logic via some helpers or macros or something?

Notwithstanding the above:

Reviewed-by: Joe Damato <jdamato@fastly.com>

