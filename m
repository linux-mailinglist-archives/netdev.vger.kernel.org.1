Return-Path: <netdev+bounces-289362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMUfIN4xDGrdZAUAu9opvQ
	(envelope-from <netdev+bounces-289362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:48:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD7357B9A4
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17D283060618
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A521A9FA0;
	Tue, 19 May 2026 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TiS0PWbW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oljx8jmt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EE53D47DD
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183894; cv=none; b=qK5i768EmenTuFYcFiMX5tmn0860UbETglWppWcV8tEqg4ax8uMgQazGOxbyPu9e8Pmozhw/Bv1+t5JmGGsNlbt7v6jdFD7QzdhoOjfQ9IyCQ6IYKLQqYTxTqs1Yt2/sum301/TyulNc/bm5lYtF7X+o0Fi9QEecRdRjikarRpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183894; c=relaxed/simple;
	bh=lOacJv7V5LVsinGCr6TMKN7P2fAlYwOiFkSQUvdCPU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sDG5e6E5KD2CrOYvGu8bRYofO9klX9Q4jCI5i7pLp5YpYcnyMVqYlX0mx5m80sesabomkGFNK0N1ZtLkaKmiAEKLUrIV03Im9G3G4oSJ3y5AleH+LffddlRGXrWNELBr6TZKCOjkvILLaZjKDhOacUZcXiiNechxB67OehqZQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TiS0PWbW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oljx8jmt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779183891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mS/dUe0xMjxuiR1Fr534B3h7HtHQAImNE62an91opEw=;
	b=TiS0PWbWHl3PJTedsS/47j7FoCQ/pNOd2EASD/OQ+75p7VGiMKDAMLhe9irVc9sokOMMv6
	n2k0/deoqfMQSdMn8+5jaijLx4g94MlHhUjGJJrJIoQn40tm35GFLZWN4r485Ls32WbaHp
	di/s/0XGJDDN+kv46qHYoTU1h5Q1EV4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-KhLEpzqKOGawBkMaWTauUg-1; Tue, 19 May 2026 05:44:50 -0400
X-MC-Unique: KhLEpzqKOGawBkMaWTauUg-1
X-Mimecast-MFC-AGG-ID: KhLEpzqKOGawBkMaWTauUg_1779183889
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45e81291d62so1643673f8f.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 02:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779183889; x=1779788689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mS/dUe0xMjxuiR1Fr534B3h7HtHQAImNE62an91opEw=;
        b=oljx8jmtdcBWExBuN327v8e7W0RlH4qgxweTkhBMc3d+rbnPeilK6k04I4xSyg2P12
         s+He3+FD+1PHw1+yC5Gb3yU5B5HJYO/7tb4A5gK6CaOrtfuV+w1ULgOA1oJsA9+6p5jC
         foaBMwL2OhbD+vSH9zgfrFJslxpeHSSsy5WFW/3ZhoKxQ9zOjfr1u6YYyvUrxI0/Eoh4
         XPDHCWp5OwoImc5DeStLfNJwMPW+x6yh4tuHIGNVaWAeYn4SebjdWr2jqZOd95QwNQMp
         quhGRjculRjewlLREVUyVxJIV5q5CWX4GPZZGH85TE4P4MsfAChnIu1c4jj2zGvE+OJD
         2eBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779183889; x=1779788689;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mS/dUe0xMjxuiR1Fr534B3h7HtHQAImNE62an91opEw=;
        b=aqQEK6SiZB7xM3P9H/HcIVvL6bFCsBtGDyTI0FA4THiDuNruwuV2KRHwr7Gse5vn9C
         MESWKrfisHelyB/fYs7pT4xsI0BLI8hlbtXrUcX33932Le8xbDnoT/LWWbgYf7jI/Ku1
         5JR78HKEBrJv2q/Vfxyte0ihvfLS4DlbuNSkHYa/s+ml6Jb1I5Ct4vXFRRVlDIk5uRJ/
         LxMlaH+bOTjc7Abp49P3RtbTylJgd6iUl03r585LZnqlqaLJbGGawspcCXctogEZ6Ymp
         q/XJGehRvfJms5SP+O2g29gQ7XxVMjBF9ni48HBjfGAINI8K+X0PF5yTiIMr2UYVPgQ8
         Uf9A==
X-Forwarded-Encrypted: i=1; AFNElJ9HmIpqVDAc/TK8Q0cuqsmiABMz1ocsOAG0+PXpgUdkuwa3e8U93s3/fZu1MB8Pq+Z0MpCLLtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBzhfkTUsiPYERvrTy7aA1zAiXjfKuN30lp/Lq0LN702CZIUEq
	EvrYMCYT1+AWrYcAISdQEIB7mXlT8gjJUYa+g9cVmBg6i0oE5PNXdB82b2hEtQlkW1P31ltW4rP
	aMqhg3ZagO3RF+AFPhGKKkLDdDunGEZEZc+1/d5xdcrr367luKAf0Bxq8ng==
X-Gm-Gg: Acq92OHuRV1+1ZaFiW0mw0TdT/2yi3reoIolleNZ0/6Fk1kloN0NjMsHaBW4mUoX3Pi
	pae0UZ5fHGt163ZA5HRvIAYHx09mNMNr5NzUa3GSIMeDNkxOckaXG2ey7KMFNTzm6ogTGUc4sWJ
	tS0Y3VKNTNASCfLvtzUNZbPtvzJG4WKqr2GgC3EsL9yt7Pv68Eb4TUoQHj5GQmEK3+U1tSLaAKy
	On1RW6p6bY+hywK1r7K0IxqT6HOK0OnAjK+0e54pEN3CFVJJtmHRyjlRZfx25orMQA/aTH3rNMP
	IuUU4KF/73J6DYOAXRowyMn4I30OFiKiEz2FD5jtgkUTJzdvJyC9t+6sViMqd/PQ8FbPKBIfWLA
	z+ncLHq/050k2+1QHC1Fg61u/hGzmT2SXc5XT4VGrSmnCBFA/X3Ckk+A=
X-Received: by 2002:a05:6000:2c07:b0:45e:75c5:1a6a with SMTP id ffacd0b85a97d-45e75c51b5emr16041037f8f.33.1779183888908;
        Tue, 19 May 2026 02:44:48 -0700 (PDT)
X-Received: by 2002:a05:6000:2c07:b0:45e:75c5:1a6a with SMTP id ffacd0b85a97d-45e75c51b5emr16040980f8f.33.1779183888421;
        Tue, 19 May 2026 02:44:48 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3ac86sm43826376f8f.14.2026.05.19.02.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 02:44:47 -0700 (PDT)
Message-ID: <5e306e50-bced-4d4d-9eb4-766224680145@redhat.com>
Date: Tue, 19 May 2026 11:44:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] octeontx2-pf: Retain ethtool stats across
 interface down/up.
To: Anshumali Gaur <agaur@marvell.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 gakula@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 sgoutham@marvell.com, bbhushan2@marvell.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260514091634.1611537-1-agaur@marvell.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260514091634.1611537-1-agaur@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289362-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3CD7357B9A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/14/26 11:16 AM, Anshumali Gaur wrote:
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 971fcab1c248..0ffcc613a4b2 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -139,19 +139,21 @@ void otx2_get_stats64(struct net_device *netdev,
>  		      struct rtnl_link_stats64 *stats)
>  {
>  	struct otx2_nic *pfvf = netdev_priv(netdev);
> -	struct otx2_dev_stats *dev_stats;
> +	struct otx2_dev_stats *dev_stats, *old_stats;

Please respect the reverse christmas tree order above.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index ee623476e5ff..21fd1dd4d755 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -2154,6 +2154,8 @@ EXPORT_SYMBOL(otx2_open);
>  int otx2_stop(struct net_device *netdev)
>  {
>  	struct otx2_nic *pf = netdev_priv(netdev);
> +	struct otx2_dev_stats *old_stats = &pf->hw.old_stats;
> +	struct otx2_dev_stats *dev = &pf->hw.dev_stats;
>  	struct otx2_cq_poll *cq_poll = NULL;
>  	struct otx2_qset *qset = &pf->qset;
>  	int qidx, vec, wrk;

Same here. You need to split variable declaration and initialization.

> @@ -2162,6 +2164,27 @@ int otx2_stop(struct net_device *netdev)
>  	if (pf->flags & OTX2_FLAG_INTF_DOWN)
>  		return 0;
>  
> +	/* First stop packet Rx/Tx */
> +	otx2_rxtx_enable(pf, false);
> +
> +	/* Read final HW counters and accumulate */
> +	otx2_get_dev_stats(pf);
> +
> +	/* Accumulate old stats */
> +	old_stats->rx_bytes     += dev->rx_bytes;
> +	old_stats->rx_drops     += dev->rx_drops;
> +	old_stats->rx_bcast_frames      += dev->rx_bcast_frames;
> +	old_stats->rx_mcast_frames      += dev->rx_mcast_frames;
> +	old_stats->rx_ucast_frames      += dev->rx_ucast_frames;
> +	old_stats->rx_frames            += dev->rx_frames;
> +
> +	old_stats->tx_bytes             += dev->tx_bytes;
> +	old_stats->tx_drops             += dev->tx_drops;
> +	old_stats->tx_bcast_frames      += dev->tx_bcast_frames;
> +	old_stats->tx_mcast_frames      += dev->tx_mcast_frames;
> +	old_stats->tx_ucast_frames      += dev->tx_ucast_frames;
> +	old_stats->tx_frames            += dev->tx_frames;

Sashiko notes this is still racy, as napi can still run and update the
counters. You should move the stat collection just before freeing H/W
resources.

/P


