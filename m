Return-Path: <netdev+bounces-91943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CAE8B47C4
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 22:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B32BB21143
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 20:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A96127E3B;
	Sat, 27 Apr 2024 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="M+6UMR28"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9A43D967
	for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714248173; cv=none; b=Rxq2LIJNDZW+hOq/DjP3d5ht3uKmWxFI49fB4EHIXIKcmqj2IZzq41RLLKOYsozz3sjXow5OrY0fd1nA7OLz4X8t4U8McV+2vlhrTiN+oXWiQqDV+EqplMxRK6/ov5Wbp0FtMWdT2oRlPq/BZ4Zya/Kh9BogR9mjZqQw3B/mB38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714248173; c=relaxed/simple;
	bh=yyyGsaik+LbsbhIVLuN9SvpCoSpW51e+2YpzL54wjF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnNSQbvtByq9pDhXsWPWPGcANkBCd2AWSnB0vpcPwOnRHOIG6rs53giVngU7wmVEn/WOOc7ErsD6DBQ/WUvhtZfkPE3y9v6Ah6EpZvxCEG3hJ5zgmlbDjgFgqfYlblHPBjCQS21nhF8kuk2ubyMeZhvmWSTm5BJlStj2JVKTvWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=pass smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=M+6UMR28; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferroamp.se
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2def3637f88so30789451fa.1
        for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 13:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1714248170; x=1714852970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vWjJmEhDGcIZmJ6RLklkROoLEmZ+FgT/92DYm8xYqQg=;
        b=M+6UMR2824UuN/PeOSElWVh6XviPYwfiZdR9A1lctcwcxN1MKY5sbczvUPvh36HjIM
         VX5/8BrbmPmQY1kCQ2buqqlH1FMAtE7LFm+lsqbnDAgZ8SEA65n2R6/zV0u/H4Btsc6i
         B55e8ZyT70LrIL5c+5w5h4tODnXT+IV3Q2DUCYSZEaUuQm41sq3sVDTZyUQBTCIc7eX+
         X7MRh9NeKyWgjbvbVYAgigtiWWiD6AN5NwjNsR01wD4d0RhPERDKT+2KIU1cNusUbVwc
         yGNweXeZLQaAXy9NG65yDPw8Kw0sksZeEwTnLQr/7QStzmg8SroszSqKsW1TpMogHPCV
         PgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714248170; x=1714852970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWjJmEhDGcIZmJ6RLklkROoLEmZ+FgT/92DYm8xYqQg=;
        b=IPW/+XG+DfRNNULI/oUcFK/I2OdJrLJ4/NtcFu2CG0LOzq96d9TXeFBZSyLuGYUiQq
         o5aK5atYDptKNuIt7vl86ND0ceUTQRYHwDvC6GAkJzXv8avAQ0XGcO7dGdzwBufS2Qqr
         JpFyB4scTO8nwBrdsy7+R2ZkHFUCBK64oxpR0fH48HHnkX9wtHy6VPUgKZTXXdZYpqI1
         yQaUbiSGfKDK4njoymWL4Fe+RK3gFRvDuakZoVzuYVWUgMyqH/cKhV8WKvGClq+W9aYy
         5zHoBBCf0ucIVZ3mhEMIu3Qw6AUDXL6B9F3kdUvyVsV+5k2vj6nVkbBMJpH+sKezuyA0
         BuyA==
X-Forwarded-Encrypted: i=1; AJvYcCWk011CESzx74msXz1CGut/1bRaaV4B45MucZoxKosemr9TmD4l2hv50mAbIrL+GY8NJHIrnco66Wo/AlUrpYOvppXwVxgW
X-Gm-Message-State: AOJu0Yy+3t8XtEnl44us0DisNYkQd+t/QugozhayU7bZKNkkpMno9b/6
	xlTflAE2qXB/Hqc0UQBLie+NOndPsES/rUgNmQTkBRBtbuOzapJ5WQ3gG3GTFnQ=
X-Google-Smtp-Source: AGHT+IEVRtDc8xfcx1O164eV0zJKAVeIRhcZ31qCeiL0GbQSLmRJM/bupoRXj/nnOTZrtE52xp9Ldg==
X-Received: by 2002:a2e:a99e:0:b0:2df:ed17:d826 with SMTP id x30-20020a2ea99e000000b002dfed17d826mr501996ljq.3.1714248168402;
        Sat, 27 Apr 2024 13:02:48 -0700 (PDT)
Received: from builder (c188-149-135-220.bredband.tele2.se. [188.149.135.220])
        by smtp.gmail.com with ESMTPSA id w5-20020a2e3005000000b002d8607e75f1sm3072952ljw.31.2024.04.27.13.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 13:02:48 -0700 (PDT)
Date: Sat, 27 Apr 2024 22:02:46 +0200
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrew@lunn.ch, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 09/12] net: ethernet: oa_tc6: implement
 receive path to receive rx ethernet frames
Message-ID: <Zi1Z5ggCqEArWNoh@builder>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-10-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418125648.372526-10-Parthiban.Veerasooran@microchip.com>

Could xfer.rx_buf for the data path point to the currently allocacted socket buff 
	struct spi_transfer xfer = { 0 };
	struct spi_message msg;

	if (header_type == OA_TC6_DATA_HEADER) {
		xfer.tx_buf = tc6->spi_data_tx_buf;
		xfer.rx_buf = tc6->spi_data_rx_buf;
	} else {
		xfer.tx_buf = tc6->spi_ctrl_tx_buf;
		xfer.rx_buf = tc6->spi_ctrl_rx_buf;
	}
	xfer.len = length;

To avoid an additional copy here?

> +static void oa_tc6_update_rx_skb(struct oa_tc6 *tc6, u8 *payload, u8 length)
> +{
> +	memcpy(skb_put(tc6->rx_skb, length), payload, length);
> +}
> 

R

