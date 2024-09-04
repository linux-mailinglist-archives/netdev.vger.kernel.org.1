Return-Path: <netdev+bounces-125155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6F596C18B
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 16:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B83C1F29F35
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55811DC733;
	Wed,  4 Sep 2024 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SACRSE7R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB1A1DC05F;
	Wed,  4 Sep 2024 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461924; cv=none; b=V32oowyOB9DbUggtMOyuRLoui4vDdfF/uv511oDrfKmHazpBhzUsNFWUEDcAxEqYwXX0+4ipFKPp/YMctpq7rR5314urQlq3DjjO5JXkJJwLkZGMtu+7vHBDf/k4rx99ILRu2GJOB0bXM3hwmq1zkM300GUBcK/y8TnG43/iYGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461924; c=relaxed/simple;
	bh=ul6VV4JjxH0XxP4Hhv6qq03d2y4Xr1eVllPyVW6Vt2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNM5gsXc1KQjBF0SxwoAbC0FXhtuqdq9F2J7SG11tjKFX8EJcPLWgbBqYf0+lS4VTCcqid+Fl4sdckVqZnCNATLsn3G4bYV5QAJaAdyz6jMr9aEGzKszJrb0N+DqzTzF+OETs9WaCHCB3GPn6WLbOaWCEYEBGb9z7LLVl0LiM1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SACRSE7R; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a86753ac89bso31661066b.0;
        Wed, 04 Sep 2024 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725461921; x=1726066721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nyHRUbS96LQJMnxC77/pMoO0AXemk+GGLf2OYY2VbUE=;
        b=SACRSE7ReCgTFpa1yOZue9YSUKkh8mH5Oukf6EPx4p8sGfjaFUjrg3Z21h40K6yQai
         0ubFRbPKz6IWR1Fe1DKOm9xzgD8Wcsic9hZ6Ltm0+UKj7318zigG1aiCl2Y9c2xyXfuL
         O9ug1AVVbFFMIS7B/t4QwvLqCBfyURKxc5BSKp2AKGF7tDUjIYq5e2jjLYF9zUNqVUBu
         i93qLAcMOAS34ElJfZ6PPYB6CqEsiwTxSmELKS81Zh2QuuJTCnL+0NypXgb02AnatToo
         jrJEVWWLBQKMKQZ8o8zs+bGhBz1aFSbnbpFIaDgd5ysDYs5E1Ax3q/YhXMuZzaQwY++x
         8PcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725461921; x=1726066721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyHRUbS96LQJMnxC77/pMoO0AXemk+GGLf2OYY2VbUE=;
        b=pQ2j7c2u/pW1Gc0U0dQtB6tLUztmfeD1RFvvBnKSgZD41ESsPxI57pYt8RvyO6EgsL
         2KS3rTPbiKym+JjeeqdnLm4+MXbszLYqWdNRWD96kUgceWP4ymlKPgql+9nueRbdUec4
         gR+9SToALHrmb6rpYVGlg86suqhLt+tuENTgUIJcNbyaJ7hO0OWIpg0iU760IhgkEILj
         kwoy1iHAmjfuAVq9DZ0oOFDv+h46ASfTQ5inEvPHxxmauXy2wzSHc3jWq04OlpfXBwbK
         rUMUyeAH76084+49m5alLv5AiuqwpCnTwlSkIENvONy6Y2O/+m/W6AwYkYcANNqdsz32
         z2ig==
X-Forwarded-Encrypted: i=1; AJvYcCXB2AK26ectVKjvBZxYIWtYsAywsURiYlJyLRPEiiBmHmiHhzzJ1eTpEywXyEXOmWDMuoOBd5bRn7JGxSc=@vger.kernel.org, AJvYcCXfD7QaCWqmIU8N9G72cdJZqzAsBXDegOjO9R0NmqXK0Y4oGR8QHkDKk4R/n6DotsYLv4OdBCFc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5AYiSOchIxv69ws4Tz/gJlhHVkjWBuOt9zvzaQbntFDsZKeDU
	ykNxkCStX8Q1WGoOVoCePdDK3DRNYrs8kZizIkut4Ue+w08Fhh6R
X-Google-Smtp-Source: AGHT+IF9fNPAMV3rkGRPbruFXWJ88SAxEy28gAk+8MFg+kx8FVMQrf0q3A1TSlP9jRdQelWzVhiB+g==
X-Received: by 2002:a17:907:3e92:b0:a80:a37f:c303 with SMTP id a640c23a62f3a-a89a357825bmr653597266b.4.1725461921263;
        Wed, 04 Sep 2024 07:58:41 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a6236d041sm1984566b.132.2024.09.04.07.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 07:58:40 -0700 (PDT)
Date: Wed, 4 Sep 2024 17:58:37 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rmk+kernel@armlinux.org.uk, linux@armlinux.org.uk, xfr@outlook.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v7 3/7] net: stmmac: refactor FPE verification
 process
Message-ID: <20240904145837.wh7tdrffsiqpot22@skbuf>
References: <cover.1725441317.git.0x1207@gmail.com>
 <cover.1725441317.git.0x1207@gmail.com>
 <1e452525e496b28c0b1ea43afbdc3533c92930c6.1725441317.git.0x1207@gmail.com>
 <1e452525e496b28c0b1ea43afbdc3533c92930c6.1725441317.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e452525e496b28c0b1ea43afbdc3533c92930c6.1725441317.git.0x1207@gmail.com>
 <1e452525e496b28c0b1ea43afbdc3533c92930c6.1725441317.git.0x1207@gmail.com>

On Wed, Sep 04, 2024 at 05:21:18PM +0800, Furong Xu wrote:
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3072ad33b105..e2f933353f40 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -969,17 +969,30 @@ static void stmmac_mac_config(struct phylink_config *config, unsigned int mode,
>  static void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
>  {
>  	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
> -	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
> -	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
> -	bool *hs_enable = &fpe_cfg->hs_enable;
> +	unsigned long flags;
>  
> -	if (is_up && *hs_enable) {
> -		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
> -					MPACKET_VERIFY);
> +	del_timer_sync(&fpe_cfg->verify_timer);

Interesting comments in include/linux/timer.h:
 * Do not use in new code. Use timer_delete_sync() instead.

Also, interesting comment in the timer_delete_sync() kernel-doc:
 Callers must prevent restarting of the timer, otherwise this function is meaningless.

I don't think you have any restart prevention mechanism. So between the
timer deletion and the spin_lock_irqsave(), another thread has enough
time to acquire fpe_cfg->lock first, and run stmmac_fpe_verify_timer_arm().

