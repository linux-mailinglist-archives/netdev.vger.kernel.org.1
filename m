Return-Path: <netdev+bounces-267109-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oChuKMvRsmnrPwAAu9opvQ
	(envelope-from <netdev+bounces-267109-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:46:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 74832273980
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE1FC300B1B3
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582343750DD;
	Thu, 12 Mar 2026 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P256h7yN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0351373C00
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326792; cv=none; b=SRSdhmBqTNf7qEo++f7r7Tt3pznRWN24shWY9xK3aTDnsK7b6DcJibZ2IOsK5Iss5ysBzE1HEPRGPvZ3xT5BJ2LEpDvQEWPxWouXdtgH3bzi7fWc+XmcSRDmlNR+jfmV0k30uL4dPP6Lf1VrelhwINXHGluSDd0SjuNXJt81QxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326792; c=relaxed/simple;
	bh=stY+trT96HJiU1r+bucUsh2tex/vjyCiTevinfj0ybo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XPvqKOSQp1juN83+urQT7XyTISnt3RKKdhVyhQvxfzqFX8Jh8x42VnknFjj8Eizq4i98UMuqug1o+MqoSF+4x6QNZ4088w455y8/yOkFM3AJ66qDmokeKflSsaTpznld1nHqU7d/bJzjMaTI7e3ivMfSEJpnNL3eYpJCoMJc+aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P256h7yN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C9CC4CEF7;
	Thu, 12 Mar 2026 14:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773326792;
	bh=stY+trT96HJiU1r+bucUsh2tex/vjyCiTevinfj0ybo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P256h7yN3/E57yJgxhKfGO6cc0IlBJOyMqRAiqZjSprQ3CpSitNU5YWuyB60naXir
	 66cWZr/x6xPs/LE8wHg2B2gRvM2CIIgUNd3756Fyowe5byrmoUJvlJAXkaIsrE7BE9
	 y1Oe2/QUtaFCeDlXEq0L4XhkX1oQbzUEpQKlQffcFtQfY1nb1WM9THNxgjNUlw7Fw2
	 HH3fVzJSTrwW4lkOn1HueqN9y7vL49Dh+Jm5Eml+YskzJ16ziGArAQZq56M/YR+c7k
	 RdN6E2JWrUx562IRQITcha2Ku6Q5M0iHzp8j3RYayLhUo1pJCvOyA6G+QhCDuQKz5x
	 2y0BrJk9nAmqw==
Date: Thu, 12 Mar 2026 07:46:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Guillaume Nault
 <gnault@redhat.com>
Subject: Re: [PATCH net] ip_tunnel: adapt iptunnel_xmit_stats() to
 NETDEV_PCPU_STAT_DSTATS
Message-ID: <20260312074630.52e7a311@kernel.org>
In-Reply-To: <20260311123110.1471930-1-edumazet@google.com>
References: <20260311123110.1471930-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-267109-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74832273980
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 12:31:10 +0000 Eric Dumazet wrote:
> @syncp offset in pcpu_sw_netstats and pcpu_dstats is different.
> 
> 32bit kernels would either have corruptions or freezes if the syncp
> sequence was overwritten.

And moving syncp would be too much of a hack? 

>  	if (pkt_len > 0) {
> -		struct pcpu_sw_netstats *tstats = get_cpu_ptr(dev->tstats);
> -
> -		u64_stats_update_begin(&tstats->syncp);
> -		u64_stats_add(&tstats->tx_bytes, pkt_len);
> -		u64_stats_inc(&tstats->tx_packets);
> -		u64_stats_update_end(&tstats->syncp);
> -		put_cpu_ptr(tstats);
> +		if (dev->pcpu_stat_type == NETDEV_PCPU_STAT_DSTATS) {
> +			struct pcpu_dstats *dstats = get_cpu_ptr(dev->dstats);
> +
> +			u64_stats_update_begin(&dstats->syncp);
> +			u64_stats_add(&dstats->tx_bytes, pkt_len);
> +			u64_stats_inc(&dstats->tx_packets);
> +			u64_stats_update_end(&dstats->syncp);
> +			put_cpu_ptr(dstats);
> +			return;
> +		}
> +		if (dev->pcpu_stat_type == NETDEV_PCPU_STAT_TSTATS) {
> +			struct pcpu_sw_netstats *tstats = get_cpu_ptr(dev->tstats);
> +
> +			u64_stats_update_begin(&tstats->syncp);
> +			u64_stats_add(&tstats->tx_bytes, pkt_len);
> +			u64_stats_inc(&tstats->tx_packets);
> +			u64_stats_update_end(&tstats->syncp);
> +			put_cpu_ptr(tstats);
> +			return;
> +		}
> +		pr_err_once("iptunnel_xmit_stats pcpu_stat_type=%d\n",
> +			    dev->pcpu_stat_type);
> +		WARN_ON_ONCE(1);
>  		return;
>  	}

This code can run with migration enabled? Cause dev_dstats_tx_add() etc
exist

