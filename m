Return-Path: <netdev+bounces-140789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8027F9B811C
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 18:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1031F23DE2
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 17:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3281BD515;
	Thu, 31 Oct 2024 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fq3JuKg8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DCC1386C9;
	Thu, 31 Oct 2024 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730395406; cv=none; b=FDbDzlTle8L/TrrMS8fvUFZ6TmI4TvrvZvLUP3dfnzb7V+L1XLR41xwkGrXUd4Ph4HIKtvaFdubHmEK6L/pmSxDVjZCmnkPUyTRsW5abb/lwa1DzBO/ROH2600dFn9NoHeUlTQMc1vyWKkoxE8seqsSggKUPU7AR6+SlycCwAfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730395406; c=relaxed/simple;
	bh=wXDe5lgDv74I8xwIkKsTzfDMb2TkCpRhzbt8TEStEyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHPrq09KpIRMxq3MSZ7xrT5stYBVp4ETaIQXewhYlKR0Qxyl2feb7LAZtdmHDY3IJv1hJxvSZd9q9UHIEFqwNia/kLWGtOGOFQ+4rBQg1jTqCA7q2mDJV9pSOmXmQ7dny2DX1Rh+IOhiKFC0DqbfKcc5yvwKgcN0DjJpEKH+pSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fq3JuKg8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d7351883aso78553f8f.0;
        Thu, 31 Oct 2024 10:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730395402; x=1731000202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VVTW9hw36AFB4MImdvCga8qTTKZp0wzSmGjii8X9VoA=;
        b=fq3JuKg8XN93vSUcAgkdX0wsh8GFNZvlnqiDPH8OZjWMHpkNnGk86yH0ryvKP+ia/A
         a5bdVTMivG2yH2F8y0J4smNSzQf1L695pvLr+Ub1OaMPBcuHtP3/hpls1bKDZlgmkN5K
         UZG3QkmDjbWAVZDDcqKl1QiYo4gYTVUjQtYLe9hhbBpUyQ19IubfhlAyi312HxBVuFe3
         +wfHIYrhzZQv9r5QtBBKxApq0Q5+1urIModYihMBKtwB9soL1ntub0pYpGMPjnfl49bj
         yXrrgNsRY0ZBMV93RHcHeDcdkDV/KtbqOPvFog91XqyL5qkHO3xdIHLmLXbET5NeSP7g
         fBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730395402; x=1731000202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVTW9hw36AFB4MImdvCga8qTTKZp0wzSmGjii8X9VoA=;
        b=HBHTW+BoPXFQr4RePE10nmf9FNsPPM82W6KArTuKQhVfV6n3zFJTJFyTpBybZKkYE9
         jfyWpMJxXcTYGZAJs4D5zeiiXTd9bLfz2bmx2uiZs1hAP/WYRM52FdN0UTGFi7yXv7uP
         0sM0WYWApQ3OB3yrIKI/DaMAOwJmCU7XXyjxW9Fv/1WPU4gj7ZpsrcLUQ8jDOQd0xaiO
         UwIWh/t+VJ4tp+LDmaKErPhFZTc9wP53RpmZyIbEcj9KL4AlK9FmZqmje8OoWCg8O8iY
         UleIaY+/WXMeBFktPktmAlxC0AqG6xw/SBHtUmJDdN1Va8hdmeJA8/s1UD/bU7CjcjnY
         9BYg==
X-Forwarded-Encrypted: i=1; AJvYcCWMVB6X1UKS099YVheRUuezMvMZdMqV9XeARz2xPiaGAE+PZNBGIG3sNRpTmjwI/OpDDr+UB5/QJf2+8t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOpK/7hSJhZFVGMfJUjElgqj8rctI2T0SnJcxMQyCMpfRZiG0E
	sKLxeNhv62lL4ORB2GRBmzKsl10QvC84FyD/p29EKl3AY7aHA6nu
X-Google-Smtp-Source: AGHT+IG8AifXoJzt/afMNe67tcFeiLrP5M6/urrkBJoQb1aUjJpqK75XQe++iygSMilFNcs3++wDxA==
X-Received: by 2002:a5d:6c6d:0:b0:37d:487e:4d9d with SMTP id ffacd0b85a97d-380612323c9mr8339382f8f.8.1730395402017;
        Thu, 31 Oct 2024 10:23:22 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116b181sm2703414f8f.107.2024.10.31.10.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 10:23:21 -0700 (PDT)
Date: Thu, 31 Oct 2024 19:23:18 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v7 3/8] net: stmmac: Refactor FPE functions to
 generic version
Message-ID: <20241031172318.w77ibjcz7pvia5wh@skbuf>
References: <cover.1730376866.git.0x1207@gmail.com>
 <cover.1730376866.git.0x1207@gmail.com>
 <1c05e448a12057b909cc6c7cc0c9645cf393d181.1730376866.git.0x1207@gmail.com>
 <1c05e448a12057b909cc6c7cc0c9645cf393d181.1730376866.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c05e448a12057b909cc6c7cc0c9645cf393d181.1730376866.git.0x1207@gmail.com>
 <1c05e448a12057b909cc6c7cc0c9645cf393d181.1730376866.git.0x1207@gmail.com>

On Thu, Oct 31, 2024 at 08:37:57PM +0800, Furong Xu wrote:
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
> index 25725fd5182f..15fcb9ef1a97 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
> @@ -12,34 +12,22 @@
>  #define STMMAC_FPE_MM_MAX_VERIFY_RETRIES	3
>  #define STMMAC_FPE_MM_MAX_VERIFY_TIME_MS	128
>  
> -/* FPE link-partner hand-shaking mPacket type */
> -enum stmmac_mpacket_type {
> -	MPACKET_VERIFY = 0,
> -	MPACKET_RESPONSE = 1,
> -};
> -
>  struct stmmac_priv;
>  struct stmmac_fpe_cfg;

With the removal of the dwmac5_*() and dwxgmac3_*() functions, the
forward definition of struct stmmac_fpe_cfg has no user in stmmac_fpe.h.

>  
>  void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up);
> -void stmmac_fpe_event_status(struct stmmac_priv *priv, int status);
>  void stmmac_fpe_init(struct stmmac_priv *priv);
>  void stmmac_fpe_apply(struct stmmac_priv *priv);
> +void stmmac_fpe_configure(struct stmmac_priv *priv, bool tx_enable,
> +			  bool pmac_enable);

I'm not sure why I missed this during v6, but stmmac_fpe_configure() is
only called from within stmmac_fpe.c, and thus should be static.

