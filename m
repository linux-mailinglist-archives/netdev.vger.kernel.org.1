Return-Path: <netdev+bounces-108838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 166D2925ECD
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EDC229080E
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 11:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0BE17622C;
	Wed,  3 Jul 2024 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckmK7zYU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99064135414
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006754; cv=none; b=OQ/O32S6YPtKGHcX9FcNXO8cgoQkXARJQs3zTV0ivFP+SWhQ3RTvws/5YSGZ9Kr6GU0Yg3p5ksqBOTnjZrU/V3ScLRaOISzYsmeflZnx/m0jdh+XaVspjfDvGN1N3HQbWPhrP7T8cvRqtJ4AWDo+8sHDEb8wZT98d5ryS5ee6FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006754; c=relaxed/simple;
	bh=2a1q2GV1WkAiQmqD8jHv1FCBn6EPH1IBR3AxRL92OEs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GDEEPrSE2+ZhSuDu7lbS88mzSPfLQxg01sWA3TyBfQsVaW+PgC9yiRpyGTIHcjdPo5nleOdynxAa9KRlgdR0Svbm1R+IqOp77sdKptD9Ajpp3kvzM0KlWCUEZVHGgotQ94sb0b6OJyWpYHysbAoYDGX9LLT15Und1JGg7kzlOjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckmK7zYU; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec50a5e230so52682001fa.0
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 04:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720006751; x=1720611551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g86+A7tUmbSQ07GzPT5KF8zw5EmR1kjksGSMt38IM0A=;
        b=ckmK7zYUeZ5DswJU+r0m30dDj9pbOhk9R06Y7tjIwlKqipGz0SLqalVUOmgo8jLPFP
         f1G+fplRcWe24392297cwYXgcs4fBw2mLO7qBbpycvz/YjB42H81hqj/cLGtYg0Gk48+
         4dAckKuGlslUQqOU687vXqw+JE8onc3sse+7RU2QqZie7hkQcNjXSyGGHgRChhrDFaCC
         +KuWg+ywxhgxaeFR8Me6wcev/q+73NOTES9nlkGaAsjv+bBix2wxnt40ZkvErK5ewqBa
         kP0R4XIZzkZfQCr6qZm/Jvo8A+cfyUgibR1H5D5QHZbzvqjIFAo6h8xfO4N8nbpc0CBr
         GMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720006751; x=1720611551;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g86+A7tUmbSQ07GzPT5KF8zw5EmR1kjksGSMt38IM0A=;
        b=gfZ8398RWEwh3d0Q7NtNUQN3ZCHvF0JTv1xoOewF/zfKRm9MJPmDQio3d0TURZDohF
         f/PTE7dhL3/jLgHgBbRCm4XYFsT5qio06CCUi+mbIacsEJLChdRO7GadDLDdlP7cZshL
         yu062NS/1N1nCqzTQ1R6DXNEhVRgQ88uT8aZJDur/iTDTCO091nnXHsgN5lkdbChInYh
         bhltmOal8OwFVcoNeI4hxDDqHqn2E2jNcQCFDxO50tjxsIayBbnVn1AJgAittMebFqO6
         EFgs2Qz/dOQimz5OXeQAgTIziG2pI6AfyGWDSaM2sHlKuKVPIPgbuAIOwbOJctvklq7D
         FcFA==
X-Gm-Message-State: AOJu0YxeficohfosTC0s17LGWvez6OxZHjjLn0HLgqBXqdV/IzFBmsOV
	Y5FBmMoqw1WViqLodVE+6KaNScuvJPpiTbI8MyIdfRIyW+uYjS2J
X-Google-Smtp-Source: AGHT+IEwIzZX62hL7tcJ/YykvXX1Vyp4zuUfMNNyZ4cKygsiwvTJAeRGFT90pZatmvPAoIyr0aBJew==
X-Received: by 2002:a2e:bc82:0:b0:2ee:7c12:7b36 with SMTP id 38308e7fff4ca-2ee7c127e6bmr21217791fa.19.1720006750633;
        Wed, 03 Jul 2024 04:39:10 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b09890dsm236323285e9.36.2024.07.03.04.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 04:39:10 -0700 (PDT)
Subject: Re: [PATCH net-next 10/11] eth: bnxt: use the indir table from
 ethtool context
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 michael.chan@broadcom.com
References: <20240702234757.4188344-1-kuba@kernel.org>
 <20240702234757.4188344-12-kuba@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <04214959-8b0c-2e5c-5dc7-8426746b48b9@gmail.com>
Date: Wed, 3 Jul 2024 12:39:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240702234757.4188344-12-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 03/07/2024 00:47, Jakub Kicinski wrote:
> Instead of allocating a separate indir table in the vnic use
> the one already present in the RSS context allocated by the core.
> This doesn't save much LoC but we won't have to worry about syncing
> the local version back to the core, once core learns how to dump
> contexts.
> 
> Add ethtool_rxfh_priv_context() for converting from priv pointer
> to the context. The cast is a bit ugly (understatement) and some
> driver paths make carrying the context pointer in addition to
> driver priv pointer quite tedious.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
...
> @@ -6315,10 +6311,12 @@ static void bnxt_fill_hw_rss_tbl_p5(struct bnxt *bp,
>  				    struct bnxt_vnic_info *vnic)
>  {
>  	__le16 *ring_tbl = vnic->rss_table;
> +	struct ethtool_rxfh_context *ctx;
>  	struct bnxt_rx_ring_info *rxr;
>  	u16 tbl_size, i;
>  
>  	tbl_size = bnxt_get_rxfh_indir_size(bp->dev);
> +	ctx = ethtool_rxfh_priv_context(vnic->rss_ctx);

Not super familiar with this driver or why this need arises, but
 would it be simpler to just store ctx in vnic instead of priv?

