Return-Path: <netdev+bounces-288699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NUxcFiB7CWo4cAQAu9opvQ
	(envelope-from <netdev+bounces-288699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 10:24:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F6A55FF0C
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 10:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CAA673003833
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8487332638;
	Sun, 17 May 2026 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OD5QpCS7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840213290A6
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779006234; cv=none; b=nzla21AgX6dDIs4WAwyowdFZ0zcz4RVYUi5PKEaTZoZc5KsV88hJthEESAz5+zXtHhm7UKh4auV91ecLSwqTzd1g3x4LlTV9WQFqc0Bz2rgjqCIeX8F0iKU7/dog3X0VArcyJGk6NgLueMe1ywJs4bU9nnsF7nc6NC7KfFCrXLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779006234; c=relaxed/simple;
	bh=Hpyx0w5s96BcUvBNDfdPwJs5WQMQWftVXYhbXoUHUYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXtLqC9ox9ZChqQxD6A85Yd3GheyEijtUKdbxKQ5fe+g0jR+lrgXXljmNpJSbYPGlPy2T25yoiAmi2ASBFREMZtfgsaVHjERGI5PXaJXArvtH5G3TAL3S4403oY55KfSzdT/3qttI51FpQvKm3Q17i+7N2BhdC+wpEubeBPLZn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OD5QpCS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BC6C2BCB0;
	Sun, 17 May 2026 08:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779006234;
	bh=Hpyx0w5s96BcUvBNDfdPwJs5WQMQWftVXYhbXoUHUYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OD5QpCS7k52/HERNxW8kx+zZFX5KQke05Ugvh+t9lHt0naSVm1L73FjGVMkaobb/Q
	 7u2ReGQJ4UsWJEVLczPrGGkpxJjYfp6S2xG3n0J+b26VVA7+7x/vmlBMR6cHzmbnRm
	 s7TMoJUr0uj6OH1z/6hjsVv7MC3KfIVzfjdNMVaNOZB+cUfQB17+Oh6nVIYMuW8KNC
	 w+Io03+Op0k3zPikqNIQyKsQ6PJySetAi7U8zvliSDdOBVdmAW8c9SXCrFHvR2erCp
	 goa3bW31mxdqjbqGm0AjePgt+CC4X+qvZMTH73+rxYowr/GyaGRAlll0nxzQr1gLQS
	 3z8qzzhHHFN8Q==
From: Simon Horman <horms@kernel.org>
To: michal.swiatkowski@linux.intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	aleksandr.loktionov@intel.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 1/4] ice: pass the return value of skb_checksum_help()
Date: Sun, 17 May 2026 09:23:25 +0100
Message-ID: <20260517082323.185010-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512084729.1338557-2-michal.swiatkowski@linux.intel.com>
References: <20260512084729.1338557-2-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 40F6A55FF0C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288699-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/

Simon says:
There is also an AI-generated review of this patch available on sashiko.dev
However I believe that can be treated in the context of possible follow-up.

---
ice: pass the return value of skb_checksum_help()

This patch propagates the return value of skb_checksum_help() back to
the caller and consolidates the software checksum fallback path under a
single checksum_sw_fb label in ice_tx_csum().

> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 4ca1a0602307..c04c5856dad6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -1654,7 +1654,7 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
>  			ret = ipv6_skip_exthdr(skb, exthdr - skb->data,
>  					       &l4_proto, &frag_off);
>  			if (ret < 0)
> -				return -1;
> +				goto checksum_sw_fb;
>  		}
>  
>  		/* define outer transport */
> @@ -1673,11 +1673,7 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
>  			l4.hdr = skb_inner_network_header(skb);
>  			break;
>  		default:
> -			if (first->tx_flags & ICE_TX_FLAGS_TSO)
> -				return -1;
> -
> -			skb_checksum_help(skb);
> -			return 0;
> +			goto checksum_sw_fb;
>  		}
>  
>  		/* compute outer L3 header size */

[ ... ]

> @@ -1736,7 +1732,7 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
>  			ipv6_skip_exthdr(skb, exthdr - skb->data, &l4_proto,
>  					 &frag_off);
>  	} else {
> -		return -1;
> +		goto checksum_sw_fb;
>  	}

[Low]

In the encapsulated branch, when the inner IP version is neither 4 nor 6
the new behaviour is to jump to checksum_sw_fb instead of unconditionally
returning -1. Before this patch the non-TSO path also bailed via
return 0 after skb_checksum_help(), and the caller would not emit a
context descriptor for that packet. After this patch the encapsulation
block has already populated off->cd_tunnel_params and set
off->cd_qw1 |= ICE_TX_DESC_DTYPE_CTX:

	/* record tunnel offload values */
	off->cd_tunnel_params |= tunnel;

	off->cd_qw1 |= (u64)ICE_TX_DESC_DTYPE_CTX;

If skb_checksum_help() then returns 0, ice_tx_csum() returns 0 and
ice_xmit_frame_ring() will still build a Tx context descriptor with the
tunnel parameters even though no L3/L4 offload bits ever get programmed
into the data descriptor.

Is that descriptor pair intentional for these malformed encapsulated
packets, or should the encapsulated default case clear the tunnel state
(or just return -1) before falling through to the software fallback?

> @@ -1789,15 +1785,17 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
>  		break;
>  
>  	default:
> -		if (first->tx_flags & ICE_TX_FLAGS_TSO)
> -			return -1;
> -		skb_checksum_help(skb);
> -		return 0;
> +		goto checksum_sw_fb;
>  	}
>  
>  	off->td_cmd |= cmd;
>  	off->td_offset |= offset;
>  	return 1;
> +
> +checksum_sw_fb:
> +	if (first->tx_flags & ICE_TX_FLAGS_TSO)
> +		return -1;
> +	return skb_checksum_help(skb);
>  }

