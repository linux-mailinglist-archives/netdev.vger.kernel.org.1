Return-Path: <netdev+bounces-133253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130B1995658
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E091C25501
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD457212D13;
	Tue,  8 Oct 2024 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="W0mZNS7q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0786B1E0E1D
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411655; cv=none; b=KlONK6pAzk/77F7YbKDDleopl6ad33S44o7To16bWh8DWQr4meFqXYjMTNBz8tESs0O2JxpwP6954Qkr1HS//ADA2x3N682IvTrt/Us6TsmSQUINiqgLSA0ytD6MX/X01yh5E1/6pjgSF+q5g85BUXOYAe9lkPYkjCYyo6hqo+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411655; c=relaxed/simple;
	bh=maT2ElR+ztAXb8N7d6RAwLafiZW6/aQk5wJi3IPWR0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=to3eVOS34mkocC8U7/E12uEecldsjte0leMuTLQ2INccA61whgET4vjQj6AQeH+Qjnhsf6ZSYILqYyHcd0oRmnjXdTbvkHe4YUJETnklvrhtolsJD4NppxzXovCXyJ+ontTwe5dpoBzbc/r7h3xGI3h2ba9zPQthnKD0GzC6VxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=W0mZNS7q; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71df67c67fcso2278346b3a.2
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 11:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728411651; x=1729016451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdixHRRhJR+67cK5BvTRI84FxCdkiNcyBDRYQb0ntbk=;
        b=W0mZNS7q7PNrGpkL4TlMsJmeQC+19gKX5M0W49Vpy5OArPeUvd9EJ+U//n5sWYSJ2B
         EZlaomI38+v8b1AQUHAI3yxwHQFexWc9ZvBjaxgFrtFD54Bt4D+h1Dzi5+PJJnhH9oAd
         /RrqwJ2qEDg9daaZzT72U/4sB1WQI92HTQTJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728411651; x=1729016451;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PdixHRRhJR+67cK5BvTRI84FxCdkiNcyBDRYQb0ntbk=;
        b=ZiCRGUcMTNoZkRABHQTeXTv1ZdR+ZNqajuWJripx07TU+ccXOuNgtRJta/V7JvRPe5
         XSMTpFMN1SVmmanvTA+jL0UTEAnwtQ2Y4UtZ342ScOy19a1ZpNRqUK60fPvowZLIHAvm
         /35ZRVYurHPfc+6zX3JaewLJH1jt5Vrkn3baYvmxgEvObxaU9tPBH2nCpEQEfN8U32z/
         jF9UVZaaYMVJeIReO/C/eNcmUep9Tjpffc6OFebuR5gtvfmHIhpP8jiV2zU8u8ZBZlda
         RclDrW4kphQf2+syN/NRjNI0nThNuZjHZ+Q3ZpzD7kJlH+FOY4pOklUJlzalcmJzfQdm
         GzMg==
X-Gm-Message-State: AOJu0YwhGA6gIf429aBbn0yx9FUzISh2COnV7afUUyJNqHiMelVA5Nml
	q/0qdkP9ZXVgtBtvCq7SYOFYjbnjwNc91lvh7QzIdoZyVlmtNlQfqver/SCyTUO/b3fDVop3Kb0
	XiFgT4Wz0aPc7Kb0cryv/RSTnBQMlE4zHMtqAc2EPDHpRbfyLSCJPqFaQ4aXOUvhjvYGr3AOdAn
	nPuEQdrPqAJ1uylQwptwQ0DT+xMQaUwI9KqmI=
X-Google-Smtp-Source: AGHT+IHcgv+kRTgXo20tsQSHIv8ZWddq4lfnoSxMVWL9FKQSzZc7w/QjVIgngvmNyac2gK8yiL0N6g==
X-Received: by 2002:a05:6a00:3a14:b0:710:6e83:cd5e with SMTP id d2e1a72fcca58-71de22e1e3fmr27948867b3a.0.1728411651549;
        Tue, 08 Oct 2024 11:20:51 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c4915asm7122825a12.86.2024.10.08.11.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 11:20:50 -0700 (PDT)
Date: Tue, 8 Oct 2024 11:20:47 -0700
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v4 6/9] netdev-genl: Support setting per-NAPI
 config values
Message-ID: <ZwV3_3K_ID1Va6rT@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20241001235302.57609-1-jdamato@fastly.com>
 <20241001235302.57609-7-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001235302.57609-7-jdamato@fastly.com>

On Tue, Oct 01, 2024 at 11:52:37PM +0000, Joe Damato wrote:
> Add support to set per-NAPI defer_hard_irqs and gro_flush_timeout.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  Documentation/netlink/specs/netdev.yaml | 11 ++++++
>  include/uapi/linux/netdev.h             |  1 +
>  net/core/netdev-genl-gen.c              | 14 ++++++++
>  net/core/netdev-genl-gen.h              |  1 +
>  net/core/netdev-genl.c                  | 45 +++++++++++++++++++++++++
>  tools/include/uapi/linux/netdev.h       |  1 +
>  6 files changed, 73 insertions(+)

[...]

> diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
> index b28424ae06d5..901c6f65b735 100644
> --- a/net/core/netdev-genl-gen.c
> +++ b/net/core/netdev-genl-gen.c
> @@ -87,6 +87,13 @@ static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_DMABUF_FD + 1]
>  	[NETDEV_A_DMABUF_QUEUES] = NLA_POLICY_NESTED(netdev_queue_id_nl_policy),
>  };
>  
> +/* NETDEV_CMD_NAPI_SET - set */
> +static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT + 1] = {
> +	[NETDEV_A_NAPI_ID] = { .type = NLA_U32, },
> +	[NETDEV_A_NAPI_DEFER_HARD_IRQS] = { .type = NLA_S32 },

Noticed this while re-reading the code; planning on changing this
from NLA_S32 to NLA_U32 for v5.

