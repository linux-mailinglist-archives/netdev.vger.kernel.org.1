Return-Path: <netdev+bounces-285320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAgGKGWM/GkjRQAAu9opvQ
	(envelope-from <netdev+bounces-285320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:58:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3790D4E89BA
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1EF8130041C7
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 12:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6133CAE76;
	Thu,  7 May 2026 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MC5yDTjV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374792DF136;
	Thu,  7 May 2026 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158690; cv=none; b=SVF/g2VzDg7/i8l3r1p4tU9xHt+NA211FNStVLQEcnJaxlZfzI8oK+b1gBOKzytmjnXOkUaa+JHlXQsbZntEKuXYfVW6dmNpdFeS4vYm+yEvRGJyqgB8igoC8I/D9M45PE6Nk+V07zUwhCo4XWrZ60JJGlhRxKKasmxanENu8b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158690; c=relaxed/simple;
	bh=WDjhH006pjr7DO1odgRVIbkbsVw1XbJABURX23J9bC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksOsKFyHv0mB+ggVJ6QalOQ8iIX07bJWHu2Daqqma0h1g6Xgo4wq3+r0VZrhZ7rlmaZk6CsXF/W3btu5DNOuXsQ+8O4uwSEBd9ZkQFUkqz7KPAJoMQEsUdwoa6BhjpWcUJ9nRm4J1NVjHInQSscaxSMPlwgQ78/5LIvQ6vnR4KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MC5yDTjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6BDC2BCB2;
	Thu,  7 May 2026 12:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778158689;
	bh=WDjhH006pjr7DO1odgRVIbkbsVw1XbJABURX23J9bC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MC5yDTjVffa9Vy/D/mKcZft6etWRgTFNpxHsSa0fT7lqvB3QMgusLbDCsNCtSg0EB
	 gSb87FVTAcrr+15ntAazrE5yIZhnLooOS6iakT9MpNTPWg2hOnaLsrHKltGCh9hRaa
	 DCWNCqjrUgPK6WCGspntCMOxg+52vSM5n/ZkQ29NgTeOPBGy+ztBrCWZSxR4PWyyaX
	 6ML3pW0OnLGr7//mffaVCCzcdDGx7r4L1FYpZjb8/AaQPYWjnuXlj0cHozXbt2tGNh
	 VHMvXJSO50Y9W4H7UjKo1bmNuOZxVgaX08zSw34NhZmdq+2rVa2FlCWEfQxW393Ggz
	 2MQlN2Ap+VCyQ==
From: Simon Horman <horms@kernel.org>
To: larysa.zaremba@intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	joshua.a.hay@intel.com,
	willemb@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aleksandr.loktionov@intel.com,
	anthony.l.nguyen@intel.com
Subject: Re: [PATCH iwl-net v2] idpf: fix RSS LUT memcpy size
Date: Thu,  7 May 2026 13:54:32 +0100
Message-ID: <20260507125431.947371-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504144345.293219-1-larysa.zaremba@intel.com>
References: <20260504144345.293219-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3790D4E89BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-285320-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
idpf: fix RSS LUT memcpy size

This commit increases the memcpy size when retrieving the RSS lookup table
to account for the full buffer size rather than just the number of entries.
It also adjusts the required Rx buffer size check to include the structure
size.

Link: https://sashiko.dev/#/patchset/20260323174052.5355-1-larysa.zaremba%40intel.com?part=8

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index be66f9b2e101c..0fc7c68447f83 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -2915,8 +2915,9 @@ int idpf_send_get_set_rss_lut_msg(struct idpf_adapter *adapter,
>  	if (reply_sz < sizeof(struct virtchnl2_rss_lut))
>  		return -EIO;
>  
> -	lut_buf_size = le16_to_cpu(recv_rl->lut_entries) * sizeof(u32);
> -	if (reply_sz < lut_buf_size)
> +	lut_buf_size = flex_array_size(recv_rl, lut,
> +				       le16_to_cpu(recv_rl->lut_entries));
> +	if (reply_sz < lut_buf_size + sizeof(struct virtchnl2_rss_lut))
>  		return -EIO;

Could this cause an out-of-bounds read if the message size exceeds the
allocated buffer?

Looking at the allocation of recv_rl earlier in this function, it has a
fixed size:

    recv_rl = kzalloc(IDPF_CTLQ_MAX_BUF_LEN, GFP_KERNEL);

If the hardware-controlled recv_rl->lut_entries yields a calculated structure
size larger than IDPF_CTLQ_MAX_BUF_LEN, reply_sz may also exceed
IDPF_CTLQ_MAX_BUF_LEN.

While this check ensures reply_sz is large enough for lut_buf_size, does it
ensure we don't read past the end of the IDPF_CTLQ_MAX_BUF_LEN allocation
during the memcpy?

[ ... ]
> @@ -2933,7 +2934,7 @@ int idpf_send_get_set_rss_lut_msg(struct idpf_adapter *adapter,
>  	}
>  
>  do_memcpy:
> -	memcpy(rss_data->rss_lut, recv_rl->lut, rss_data->rss_lut_size);
> +	memcpy(rss_data->rss_lut, recv_rl->lut, lut_buf_size);

Does this copy skip necessary byte-order conversions?

The hardware response recv_rl->lut contains __le32 (little-endian) values,
but the destination rss_data->rss_lut is an array of host-order u32
integers.

The set path correctly applies cpu_to_le32() to elements before sending
them:

    rl->lut[i] = rxhash_ena ? cpu_to_le32(rss_data->rss_lut[i]) : 0;

On big-endian architectures, copying little-endian bytes directly with
memcpy() will result in byte-swapped queue indices. Does the driver need to
iterate over the entries and convert each using le32_to_cpu() instead?

