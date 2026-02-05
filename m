Return-Path: <netdev+bounces-256967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMDQGI4qhGla0QMAu9opvQ
	(envelope-from <netdev+bounces-256967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:28:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BBAEEB68
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6AF230131DD
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 05:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4770F31AF25;
	Thu,  5 Feb 2026 05:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3KkRD3m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9AC1F471F;
	Thu,  5 Feb 2026 05:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770269320; cv=none; b=UAgtf3t83Qyfcs7j3SpJc91HXUgMP17aEu0xLSmcqw/ICYAVm4NU1+YmTWSvEeLalu23cyIR1Ed6kRPMgBlJyiPhQvzvgEWSmjdxdu3S2rU5u6+6vyT+PwsjdIMUtb4N0DQhCfwSbudf9YrueyhvLhmEXIN9bBLEu8J2XyYN3vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770269320; c=relaxed/simple;
	bh=BBfLCDc2/uDCwmTSk1Ji6KmW/FlEp2r0PF0c3zsmOBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FF3dby1bFjSIe3Rmo03D1E4dFoQ53maxcHxTaLtwAkz7fu0chHOl33RSAA5CdR37xpaGX3WH5e3iNbmGTZCpsv+YKgNBKBpSeBClVsKqvxNid4F2JVdYtza2YjN8Yca9r/cuW70vIDTl06nmh+07+uYPduEAbiLox0+3yoC1Ulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3KkRD3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEA1C4CEF7;
	Thu,  5 Feb 2026 05:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770269319;
	bh=BBfLCDc2/uDCwmTSk1Ji6KmW/FlEp2r0PF0c3zsmOBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K3KkRD3mQgYJ18W/8bq3mA9yT+cLveQshHPaHZd/DN3UlCTZleACxtx6uOo3beHjz
	 8f092D0wOVbKWAoux3EeXpEjPY8KfOgasazv3ekJOfBkCYGi+x4AirUJd/IDEejDGs
	 LtJfnlarGj17U15Bwie62MofkMQUeRDkEHolXQ3HbiN5CFIvP3L17AWrQQfDgb7Q6V
	 i711FpbmU/dAZ38ynZr0K044E8kaCF08RKl4pCzeBG9Hm2fWCZOBvbniJO4qB9cupN
	 GbwdSsJJue9ANOavzpc41UZZkxfnv0j95xK1lBRag9WDpH+3NK8mNl6RsJDj0SGpV7
	 RYSUnyJQ6W4Sw==
From: Jakub Kicinski <kuba@kernel.org>
To: wei.fang@nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	ast@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	pabeni@redhat.com,
	xiaoning.wang@nxp.com,
	john.fastabend@gmail.com,
	daniel@iogearbox.net,
	sdf@fomichev.me,
	frank.li@nxp.com,
	linux-kernel@vger.kernel.org,
	hawk@kernel.org,
	horms@kernel.org,
	bpf@vger.kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	imx@lists.linux.dev,
	shenwei.wang@nxp.com
Subject: Re: [v6,net-next,06/15] net: fec: add fec_enet_rx_queue_xdp() for XDP path
Date: Wed,  4 Feb 2026 21:28:37 -0800
Message-ID: <20260205052837.2449389-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260203052329.1085444-7-wei.fang@nxp.com>
References: <20260203052329.1085444-7-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,redhat.com,nxp.com,gmail.com,iogearbox.net,fomichev.me,vger.kernel.org,google.com,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-256967-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2BBAEEB68
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: fec: add fec_enet_rx_queue_xdp() for XDP path

This commit separates XDP path packet processing from fec_enet_rx_queue()
into a new function fec_enet_rx_queue_xdp() to optimize XDP performance.
Performance testing on iMX93 shows improvements across all xdp-bench tests.

> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1666,71 +1666,6 @@ static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
>  	return 0;
>  }
>
> -static u32
> -fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
> -		 struct xdp_buff *xdp, struct fec_enet_priv_rx_q *rxq, int cpu)
> -{

[ ... ]

> -	default:
> -		bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
> -		fallthrough;
> -
> -	case XDP_ABORTED:
> -		fallthrough;    /* handle aborts by dropping packet */
> -
> -	case XDP_DROP:
> -		rxq->stats[RX_XDP_DROP]++;
> -xdp_err:
> -		ret = FEC_ENET_XDP_CONSUMED;
> -		page = virt_to_head_page(xdp->data);
> -		page_pool_put_page(rxq->page_pool, page, sync, true);
> -		if (act != XDP_DROP)
> -			trace_xdp_exception(fep->netdev, prog, act);
> -		break;
> -	}
> -
> -	return ret;
> -}
> -

[ ... ]

> @@ -1962,7 +1879,167 @@

[ ... ]

> +static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
> +				 int budget, struct bpf_prog *prog)
> +{

[ ... ]

> +		switch (act) {
> +		case XDP_PASS:
> +			rxq->stats[RX_XDP_PASS]++;
> +			/* The packet length includes FCS, but we don't want to
> +			 * include that when passing upstream as it messes up
> +			 * bridging applications.
> +			 */
> +			skb = fec_build_skb(fep, rxq, bdp, page, pkt_len);
> +			if (!skb)
> +				trace_xdp_exception(ndev, prog, XDP_PASS);
> +			else
> +				napi_gro_receive(&fep->napi, skb);
> +
> +			break;
> +		case XDP_REDIRECT:
> +			rxq->stats[RX_XDP_REDIRECT]++;
> +			err = xdp_do_redirect(ndev, &xdp, prog);
> +			if (unlikely(err)) {
> +				fec_xdp_drop(rxq, &xdp, sync);
> +				trace_xdp_exception(ndev, prog, XDP_REDIRECT);
> +			} else {
> +				xdp_res |= FEC_ENET_XDP_REDIR;
> +			}
> +			break;
> +		case XDP_TX:
> +			rxq->stats[RX_XDP_TX]++;
> +			err = fec_enet_xdp_tx_xmit(fep, cpu, &xdp, sync);
> +			if (unlikely(err)) {
> +				rxq->stats[RX_XDP_TX_ERRORS]++;
> +				fec_xdp_drop(rxq, &xdp, sync);
> +				trace_xdp_exception(ndev, prog, XDP_TX);
> +			}
> +			break;
> +		default:
> +			bpf_warn_invalid_xdp_action(ndev, prog, act);
> +			fallthrough;
> +		case XDP_ABORTED:
> +			/* handle aborts by dropping packet */
> +			fallthrough;
> +		case XDP_DROP:
> +			rxq->stats[RX_XDP_DROP]++;
> +			fec_xdp_drop(rxq, &xdp, sync);
> +			break;

Are XDP_ABORTED and invalid XDP actions being traced properly? In the
deleted fec_enet_run_xdp() function, the error path included this check:

    if (act != XDP_DROP)
        trace_xdp_exception(fep->netdev, prog, act);

This would trace both XDP_ABORTED and invalid actions (after calling
bpf_warn_invalid_xdp_action). The new code in fec_enet_rx_queue_xdp()
calls trace_xdp_exception() for XDP_PASS failures, XDP_REDIRECT failures,
and XDP_TX failures, but not for XDP_ABORTED or invalid actions.

This trace information is useful for debugging XDP program issues and
monitoring abnormal XDP behavior.

> +		}
> +
> +rx_processing_done:

[ ... ]

> +	return pkt_received;
> +}
-- 
pw-bot: cr

