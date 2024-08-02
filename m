Return-Path: <netdev+bounces-115440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A552794661A
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 01:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F51E282DAA
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A8713A24D;
	Fri,  2 Aug 2024 23:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcGKKyLY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3A41ABEB5
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 23:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722640417; cv=none; b=NImdC9yVftXE5bluXHyGKxTUDPrIXfBy6AKpKp16RFXSFfmEAEGjwvVFW+CAqmp2nspZVoZ4AVkcL2qACNA+dXx1pUiuIUtafOb0zqgLAGECHZNJbJNVC9UJv1dZrV92lGSvpsOW4QvTV2eVXeyRRU+TI+6cNE6XmY/CCl1G6ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722640417; c=relaxed/simple;
	bh=X2poKPdL6wewbY6A9vzlgBb71uKWp6MviVKv4d5kqI0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qwykQlOkCqAYe12R657KBDGzLnzBTH883sC0Et1EjvRWQu6kvC2opuqfu2NyzMIsrzo5qGyY95gYECVYz6FrN5qy2zf6xSNyfuvcYVF/HZ/hzv3xQY9BLCjZmNKS1G0P/V2W81B6OUef5quRwuFs3WAp2vfhS1clceS9B3inFHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcGKKyLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88783C32782;
	Fri,  2 Aug 2024 23:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722640416;
	bh=X2poKPdL6wewbY6A9vzlgBb71uKWp6MviVKv4d5kqI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RcGKKyLYuC4STRmbypY2k6bW9AROb6sMXjwMzXPzbvNdjK/kTUIjm17SVvULlTv4T
	 AysAz9NJYSWxCsxoycmJLHQKURAwHMHFeIoyGzdjk1FfPVAcjHi5upF+uQliJUaRvL
	 vDIUHnrnroIA+r2mRXiV5iUqRUG10AI7mMUnjM2VEzU9EpY4Kudwu/DLCCSXf+IgBA
	 kJ+FRC4tkbMU/p0uXqV9EmJ/mGA7QPMyaLke5PahIjqeeQqQ5lsqrhqZqBQqgDvqa3
	 yf46WvLfZKsqy/6jbIme+owyEq4s1KJQYCNA4oP+QpluY1QBPoInNH9ZGA82BfzCHl
	 SzUJVT8D0CGGg==
Date: Fri, 2 Aug 2024 16:13:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, willemb@google.com, jeroendb@google.com,
 shailend@google.com, hramamurthy@google.com, jfraker@google.com, Ziwei Xiao
 <ziweixiao@google.com>
Subject: Re: [PATCH net-next 1/2] gve: Add RSS device option
Message-ID: <20240802161335.0e23e9ec@kernel.org>
In-Reply-To: <20240802012834.1051452-2-pkaligineedi@google.com>
References: <20240802012834.1051452-1-pkaligineedi@google.com>
	<20240802012834.1051452-2-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Aug 2024 18:28:33 -0700 Praveen Kaligineedi wrote:
> @@ -45,7 +45,8 @@ void gve_parse_device_option(struct gve_priv *priv,
>  			     struct gve_device_option_dqo_qpl **dev_op_dqo_qpl,
>  			     struct gve_device_option_buffer_sizes **dev_op_buffer_sizes,
>  			     struct gve_device_option_flow_steering **dev_op_flow_steering,
> -			     struct gve_device_option_modify_ring **dev_op_modify_ring)
> +			     struct gve_device_option_modify_ring **dev_op_modify_ring,
> +			     struct gve_device_option_rss_config **dev_op_rss_config)
>  {
>  	u32 req_feat_mask = be32_to_cpu(option->required_features_mask);
>  	u16 option_length = be16_to_cpu(option->option_length);


> @@ -867,6 +887,8 @@ static void gve_enable_supported_features(struct gve_priv *priv,
>  					  *dev_op_buffer_sizes,
>  					  const struct gve_device_option_flow_steering
>  					  *dev_op_flow_steering,
> +					  const struct gve_device_option_rss_config
> +					  *dev_op_rss_config,
>  					  const struct gve_device_option_modify_ring
>  					  *dev_op_modify_ring)

Any reason these two functions order the arguments differently?

