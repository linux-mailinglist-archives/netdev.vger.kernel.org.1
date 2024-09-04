Return-Path: <netdev+bounces-125173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F4296C2B0
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11A5EB235AE
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F781DEFCD;
	Wed,  4 Sep 2024 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2aVv8FX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D6D1EC017;
	Wed,  4 Sep 2024 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464553; cv=none; b=OhIK2AhjMHchZw8bJJUmKbmVZGWs7FnVVNiA/+KXvLvS1/dstssQj83T1v9whAQrC3QU962USUhB7E2JnkntB5Kc91Aiccn3wI3ya4eQ3gExsvoWYQ3MqLkoU31EhIz6TyLX65Kkv4eM73r8pc6Bhgo8Zhnjs2emz6aoqSZtSo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464553; c=relaxed/simple;
	bh=1xPFZ8hYwbWHIZ7KEURxSxbiLnr+gE2MVkYSkkl1uEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7XqOQB+LNaQAZ16zKP4yfJ1NdUjbkU/advV1QYJe+8baJAg7vsoSLbwVlWIUXT0ydE7fRQ4N0DVd17Vo8BHOwdMXrDiRFUN2vqQvpAvKisTyZ7LkF+GvPg6DqIndhnv1L3bxSczLNIIiP47Yy37RdDL9LPdNpLMJ18tmEl3Vss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2aVv8FX; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a866966ffceso34149866b.2;
        Wed, 04 Sep 2024 08:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725464550; x=1726069350; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M6e2YvfuCivW4PaDMInxNwbpYH1/P7j1Q84PnG6YUUM=;
        b=K2aVv8FXdEneK2iydMbyVFtf2g/8d4gijF2l2s0eIgE0L26RY6zOSnktguuIp1Oarl
         LD4p+zYKOiwMhrVz0/Duvz8GC/J47C9t92YuGBOmMDSniAwsCLMm5CV0sIFeD0+TjPB+
         aa6YdJrDKLBrYlMMN5eNAPGwlGo/EDEcSEcQM6zW8tb5PfqfQg7NlQ7Rt/rw2ZWRYR2V
         XOoVBuYPkpujZgYRhRDDupfa+4FsdzWoIwGcjpFv6+kyfqLN1YtQMYtqMkhb1zZVa09M
         /SbNvJFh2PoULEwztaEDyN7gtAqOPgO82Ex4MTTRM0N9rX5UrErL/DgWkoNMkglIfu+x
         Fg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725464550; x=1726069350;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M6e2YvfuCivW4PaDMInxNwbpYH1/P7j1Q84PnG6YUUM=;
        b=hTRV62P3uDGxR4nuR5QjtoHL1r99BG3ckgGzZlFmct7fSpXbIzHkvjgAF3fE7O6m3S
         Ny/bM8I9ePfNL4fbikv8o1gGMKC8g1Hj9G/vOXKV1BXcRs0e87nvtfL8UbrlWiH/Y0Gn
         ZXFoedCcks13flutEplw5wJuA1REAQkvEVREn7ABmci5LP9WRlX90Vl+ziD950XVSAWe
         1G8RyKRnzwCKVYTMDtIdzzQbZSj4JxCwWsZN0E6geXoJkeueS4ub1eDIqWspqfsaP7VK
         6zkPanzm77SUU6pi+KCcJqjc+ChOEkkQD+b5ZgLBHw7C+mstoaSAwsPqhfr8oubHn26u
         QfUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfbWyONMYW+bHA9xnMpLDcLcScIqKOqhsD/LMyyuE8woIvbYt+DROJys/cELAl7TzzGQmVe58E@vger.kernel.org, AJvYcCWjaCChvuGzhn8w4idCVN83xmTYS9jUer/70CM+Pkq0NJCGa5vnMloaLrD6mWoHRRFoXQ1CA7opnUNeRnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIzY7LIBJppsUz2RnOZhI44futGR7A3bOrM1JcTVpMue/mhdr6
	XhKcIZsi1pB2cOq1VxSwo+PKRVU73GnFSleHJcTzc7pufzOkxtyU
X-Google-Smtp-Source: AGHT+IHMic4XBuw2foanj88RblIDJ3ytZUAtd4gGVvzDtDWkXLLbXdQlWIpM8/kI4V1eZSw3Ww7rJQ==
X-Received: by 2002:a17:907:7b94:b0:a7a:87b3:722f with SMTP id a640c23a62f3a-a89a34c8c79mr775057766b.3.1725464549704;
        Wed, 04 Sep 2024 08:42:29 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a62038d59sm7125066b.52.2024.09.04.08.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:42:29 -0700 (PDT)
Date: Wed, 4 Sep 2024 18:42:26 +0300
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
	rmk+kernel@armlinux.org.uk, linux@armlinux.org.uk, xfr@outlook.com
Subject: Re: [PATCH net-next v7 5/7] net: stmmac: support fp parameter of
 tc-mqprio
Message-ID: <20240904154226.ztksb6sv4mjccb5l@skbuf>
References: <cover.1725441317.git.0x1207@gmail.com>
 <cover.1725441317.git.0x1207@gmail.com>
 <28f580d1c1e3cfdb0803207a5e05d42c4f9dd529.1725441317.git.0x1207@gmail.com>
 <28f580d1c1e3cfdb0803207a5e05d42c4f9dd529.1725441317.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28f580d1c1e3cfdb0803207a5e05d42c4f9dd529.1725441317.git.0x1207@gmail.com>
 <28f580d1c1e3cfdb0803207a5e05d42c4f9dd529.1725441317.git.0x1207@gmail.com>

On Wed, Sep 04, 2024 at 05:21:20PM +0800, Furong Xu wrote:
> +static void stmmac_reset_tc_mqprio(struct net_device *ndev,
> +				   struct netlink_ext_ack *extack)
> +{
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +
> +	netdev_reset_tc(ndev);
> +	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);
> +	stmmac_fpe_map_preemption_class(priv, ndev, extack, 0);
> +}
> +
> +static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
> +				    struct tc_mqprio_qopt_offload *mqprio)
> +{
> +	struct netlink_ext_ack *extack = mqprio->extack;
> +	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
> +	u32 offset, count, num_stack_tx_queues = 0;
> +	struct net_device *ndev = priv->dev;
> +	u32 num_tc = qopt->num_tc;
> +	int err;
> +
> +	if (!num_tc) {
> +		stmmac_reset_tc_mqprio(ndev, extack);
> +		return 0;
> +	}
> +
> +	err = netdev_set_num_tc(ndev, num_tc);
> +	if (err)
> +		return err;
> +
> +	for (u32 tc = 0; tc < num_tc; tc++) {
> +		offset = qopt->offset[tc];
> +		count = qopt->count[tc];
> +		num_stack_tx_queues += count;
> +
> +		err = netdev_set_tc_queue(ndev, tc, count, offset);
> +		if (err)
> +			goto err_reset_tc;
> +	}
> +
> +	err = netif_set_real_num_tx_queues(ndev, num_stack_tx_queues);
> +	if (err)
> +		goto err_reset_tc;
> +
> +	err = stmmac_fpe_map_preemption_class(priv, ndev, extack,
> +					      mqprio->preemptible_tcs);
> +	if (err)
> +		goto err_reset_tc;

I appreciate the improvement with the separate tc_ops, but I'm still not
in love with this.

This stmmac_hw entry (copied with line numbers because it lacks a name
by which I can easily reference it):

159 »       }, {
160 »       »       .gmac = false,
161 »       »       .gmac4 = true,
162 »       »       .xgmac = false,
163 »       »       .min_id = 0,
164 »       »       .regs = {
165 »       »       »       .ptp_off = PTP_GMAC4_OFFSET,
166 »       »       »       .mmc_off = MMC_GMAC4_OFFSET,
167 »       »       »       .est_off = EST_GMAC4_OFFSET,
168 »       »       },
169 »       »       .desc = &dwmac4_desc_ops,
170 »       »       .dma = &dwmac4_dma_ops,
171 »       »       .mac = &dwmac4_ops,
172 »       »       .hwtimestamp = &stmmac_ptp,
173 »       »       .mode = NULL,
174 »       »       .tc = &dwmac510_tc_ops,
175 »       »       .mmc = &dwmac_mmc_ops,
176 »       »       .est = &dwmac510_est_ops,
177 »       »       .setup = dwmac4_setup,
178 »       »       .quirks = stmmac_dwmac4_quirks,
179 »       }, {

has .mac = &dwmac4_ops, so it does not implement .fpe_map_preemption_class().
But it also has .tc = &dwmac510_tc_ops, so tc_setup_dwmac510_mqprio() will
get called.

Thus, I suppose that the stmmac_fpe_map_preemption_class() ->
stmmac_do_void_callback() mechanism will return -EINVAL for dwmac4_ops,
and this will make mqprio offload fail, for the sole reason that FPE is
not supported, _EVEN IF_ FPE was never requested (mqprio->preemptible_tcs is 0),
and the offload could have otherwise been applied just fine.

Not to mention my previous complaint still applies, that the test for
the presence of stmmac_ops :: fpe_map_preemption_class() is unnaturally
late relative to the flow of the tc_setup_dwmac510_mqprio() function.

Thus, I really recommend you to replace the stmmac_do_void_callback()
anti-pattern with something like:

	// early
	if (mqprio->preemptible_tcs && !priv->hw->ops->fpe_map_preemption_class) {
		NL_SET_ERR_MSG_MOD(mqprio->extack,
				   "Cannot map preemptible TCs to TXQs");
		return -EOPNOTSUPP;
	}

	// late
	if (priv->hw->ops->fpe_map_preemption_class) {
		err = priv->hw->ops->fpe_map_preemption_class(priv->dev,
							      mqprio->preemptible_tcs,
							      extack);
		if (err)
			goto err_reset_tc;
	}

WARNING: code not tested. The idea is that the early check makes sure
that only dwmac410_ops and dwmac510_ops permit mqprio->preemptible_tcs
to go to a non-zero value (which can later be reset to zero if desired,
in the late code path). For dwmac4_ops, mqprio->preemptible_tcs = 0 is
the only supported value (for which nothing needs to be done), and the
late code path is bypassed, due to the "if" condition returning false.

Either organize like this, or if you really, really, really insist to
use the stmmac_do_callback() anti-pattern in new code, at least don't
share the setup_mqprio() code path between MACs that implement
fpe_map_preemption_class() and MACs that don't.

