Return-Path: <netdev+bounces-140526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B619B6CBF
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 20:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8AD71C21641
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 19:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42271CF7AC;
	Wed, 30 Oct 2024 19:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeULAuYc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5903F1CBEA3
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730314970; cv=none; b=GxeZuUrhkVJ1xyuS7D9PfbR1l82ETIPPcLmaxt0PVkjVeq+DDAsh5dXIDVtMwdDaMc1pgxdjkhRruqmVhtlkon8KBV+D3gPXR+zK7IakWeKbfPAYf29ne0ymROIn6a8SpQHen4y2pakX6NRC4tWxxm7pOM8XjHjGZKpkWDwc/U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730314970; c=relaxed/simple;
	bh=j9DIOp/Kclalp0cCLloIiSs6Fei7UTtoyJf9KLwlY6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IIQLl0uooX7p5ZQzBgMKrJC6EzsnrqWxk63mg1eK5XOFndBR/Fm25D6T5Bw4WkCP1oShR8xMcynCa3QadafPiduoL8dy/lT0Om+D3aCgD0Cl0VqAMX+4jXcMgSEl5qZGnuhuWMl/kCp8vHbpAhx6FJQg6TRrYgGe9dKsBAebJoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeULAuYc; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d51055097so128271f8f.3
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 12:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730314967; x=1730919767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oqA081FjqQzyjm+eV2eQNvf4XD3S5z/TG2aVYA2vgrk=;
        b=FeULAuYc4FhV3+JkxPpM6SXKADn/EVuDsREF1qVnPdVz48KT4/JtkFBWQHy8jpkVPA
         Ndk6kEAN+LQV2QFD6k6wbsak2fDw4YTcPBo73NJwnEnxeEZUUHqtikfzaq+9sKH+RcqI
         mfpRKjzEIA5VoMBD7T2o0FDl7bXPOT1S7OpBxGNPuGhNEopXlZtL+MzPnPkLlNuSm7Uq
         FyUWNN6KS8+WQYN9EwYsXTpz0czn3Vr9PJM3WBluuw1Eh1ZnZDEDAnM4u0J84VWMb3ci
         me3tqsqdDgvXkikhYlwXZNildxArNTCMrHFpiBWHx0FejqpOi2NouPA5uHNfcgeGc2Lm
         E1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730314967; x=1730919767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oqA081FjqQzyjm+eV2eQNvf4XD3S5z/TG2aVYA2vgrk=;
        b=wD2bxDu2jIvPVTSUhGlCT1wcQhRcJztsa2uRs9aKZbKrxy6gEpi/5KwdDev8+Vg3qj
         QCsZWpIENX9/3RehB9ijHqn0YWmof2g5Bu1WNeCHzKdZ6zt1gZRfsggS7XWtz/f3bjZj
         EIxtoIKpvQ8cYsQg0Qge6k6qRaPGru2MXpEOpliO5rNpgEcDs0sMvjIFXSg/YiBibQ23
         7b+IZ77SiDRX5MxwGArwF5fxpnhfB8kQ9wgnXlykwCN9rDke+c161WIQCSrodm1LZ18C
         Fr79Rw5xJXB/DK3TZDLwhEaOJitTOt10oBXgdDftin5tgo941aGWbyxP6rpbDSKwhINx
         vLHg==
X-Forwarded-Encrypted: i=1; AJvYcCUaFy2h+A1ujdYa9BQt6O9WphEA/xPORGeA3rUWmTFYsQQxNPPLXr7tLdJDezP0xUywinS0QDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbE/vjQKbGkeseannbS2wL1th+1PVbzWeN+gcx4sRnvK25IA+7
	xnyK+N4+bzORGdxnleh8X2OQlHbtUE1yiRwIpC6OLbzqHJ7rD+ZG
X-Google-Smtp-Source: AGHT+IHIbC6t3OiwNDSm5ldxgbSOIvDaeRECrMbY+aCV990DG9HfupeEC9sTqqlcRvecWajod4VhAg==
X-Received: by 2002:a5d:6102:0:b0:37d:4d3f:51e9 with SMTP id ffacd0b85a97d-380611dbf21mr12076544f8f.40.1730314966433;
        Wed, 30 Oct 2024 12:02:46 -0700 (PDT)
Received: from [10.0.0.4] ([37.171.104.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b7124csm16110834f8f.81.2024.10.30.12.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 12:02:46 -0700 (PDT)
Message-ID: <94840d1d-f051-4c07-8262-a17f0d5ce300@gmail.com>
Date: Wed, 30 Oct 2024 20:02:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/12] net: homa: create homa_timer.c
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org,
 edumazet@google.com
References: <20241028213541.1529-1-ouster@cs.stanford.edu>
 <20241028213541.1529-11-ouster@cs.stanford.edu>
Content-Language: en-US
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <20241028213541.1529-11-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/28/24 10:35 PM, John Ousterhout wrote:
> This file contains code that wakes up periodically to check for
> missing data, initiate retransmissions, and declare peer nodes
> "dead".
>
> Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
> ---
>   net/homa/homa_timer.c | 158 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 158 insertions(+)
>   create mode 100644 net/homa/homa_timer.c
>
> diff --git a/net/homa/homa_timer.c b/net/homa/homa_timer.c
> new file mode 100644
> index 000000000000..bce7c02bb1cd
> --- /dev/null
> +++ b/net/homa/homa_timer.c
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: BSD-2-Clause
> +
> +/* This file handles timing-related functions for Homa, such as retries
> + * and timeouts.
> + */
> +
> +#include "homa_impl.h"
> +#include "homa_peer.h"
> +#include "homa_rpc.h"
> +
> +/**
> + * homa_check_rpc() -  Invoked for each RPC during each timer pass; does
> + * most of the work of checking for time-related actions such as sending
> + * resends, aborting RPCs for which there is no response, and sending
> + * requests for acks. It is separate from homa_timer because homa_timer
> + * got too long and deeply indented.
> + * @rpc:     RPC to check; must be locked by the caller.
> + */
> +void homa_check_rpc(struct homa_rpc *rpc)
> +{
> +	struct homa *homa = rpc->hsk->homa;
> +	struct resend_header resend;
> +
> +	/* See if we need to request an ack for this RPC. */
> +	if (!homa_is_client(rpc->id) && rpc->state == RPC_OUTGOING &&
> +	    rpc->msgout.next_xmit_offset >= rpc->msgout.length) {
> +		if (rpc->done_timer_ticks == 0) {
> +			rpc->done_timer_ticks = homa->timer_ticks;
> +		} else {
> +			/* >= comparison that handles tick wrap-around. */
> +			if ((rpc->done_timer_ticks + homa->request_ack_ticks
> +					- 1 - homa->timer_ticks) & 1 << 31) {
> +				struct need_ack_header h;
> +
> +				homa_xmit_control(NEED_ACK, &h, sizeof(h), rpc);
> +			}
> +		}
> +	}
> +
> +	if (rpc->state == RPC_INCOMING) {
> +		if (rpc->msgin.num_bpages == 0) {
> +			/* Waiting for buffer space, so no problem. */
> +			rpc->silent_ticks = 0;
> +			return;
> +		}
> +	} else if (!homa_is_client(rpc->id)) {
> +		/* We're the server and we've received the input message;
> +		 * no need to worry about retries.
> +		 */
> +		rpc->silent_ticks = 0;
> +		return;
> +	}
> +
> +	if (rpc->state == RPC_OUTGOING) {
> +		if (rpc->msgout.next_xmit_offset < rpc->msgout.length) {
> +			/* There are bytes that we haven't transmitted,
> +			 * so no need to be concerned; the ball is in our court.
> +			 */
> +			rpc->silent_ticks = 0;
> +			return;
> +		}
> +	}
> +
> +	if (rpc->silent_ticks < homa->resend_ticks)
> +		return;
> +	if (rpc->silent_ticks >= homa->timeout_ticks) {
> +		homa_rpc_abort(rpc, -ETIMEDOUT);
> +		return;
> +	}
> +	if (((rpc->silent_ticks - homa->resend_ticks) % homa->resend_interval)
> +			!= 0)
> +		return;
> +
> +	/* Issue a resend for the bytes just after the last ones received
> +	 * (gaps in the middle were already handled by homa_gap_retry above).
> +	 */
> +	if (rpc->msgin.length < 0) {
> +		/* Haven't received any data for this message; request
> +		 * retransmission of just the first packet (the sender
> +		 * will send at least one full packet, regardless of
> +		 * the length below).
> +		 */
> +		resend.offset = htonl(0);
> +		resend.length = htonl(100);
> +	} else {
> +		homa_gap_retry(rpc);
> +		resend.offset = htonl(rpc->msgin.recv_end);
> +		resend.length = htonl(rpc->msgin.length - rpc->msgin.recv_end);
> +		if (resend.length == 0)
> +			return;
> +	}
> +	homa_xmit_control(RESEND, &resend, sizeof(resend), rpc);
> +}
> +
> +/**
> + * homa_timer() - This function is invoked at regular intervals ("ticks")
> + * to implement retries and aborts for Homa.
> + * @homa:    Overall data about the Homa protocol implementation.
> + */
> +void homa_timer(struct homa *homa)
> +{
> +	struct homa_socktab_scan scan;
> +	struct homa_sock *hsk;
> +	struct homa_rpc *rpc;
> +	int total_rpcs = 0;
> +	int rpc_count = 0;
> +
> +	homa->timer_ticks++;
> +
> +	/* Scan all existing RPCs in all sockets.  The rcu_read_lock
> +	 * below prevents sockets from being deleted during the scan.
> +	 */
> +	rcu_read_lock();
> +	for (hsk = homa_socktab_start_scan(homa->port_map, &scan);
> +			hsk; hsk = homa_socktab_next(&scan)) {
> +		while (hsk->dead_skbs >= homa->dead_buffs_limit)
> +			/* If we get here, it means that homa_wait_for_message
> +			 * isn't keeping up with RPC reaping, so we'll help
> +			 * out.  See reap.txt for more info.
> +			 */
> +			if (homa_rpc_reap(hsk, hsk->homa->reap_limit) == 0)
> +				break;
> +
> +		if (list_empty(&hsk->active_rpcs) || hsk->shutdown)
> +			continue;
> +
> +		if (!homa_protect_rpcs(hsk))
> +			continue;
> +		list_for_each_entry_rcu(rpc, &hsk->active_rpcs, active_links) {
> +			total_rpcs++;
> +			homa_rpc_lock(rpc, "homa_timer");
> +			if (rpc->state == RPC_IN_SERVICE) {
> +				rpc->silent_ticks = 0;
> +				homa_rpc_unlock(rpc);
> +				continue;
> +			}
> +			rpc->silent_ticks++;
> +			homa_check_rpc(rpc);
> +			homa_rpc_unlock(rpc);
> +			rpc_count++;
> +			if (rpc_count >= 10) {
> +				/* Give other kernel threads a chance to run
> +				 * on this core. Must release the RCU read lock
> +				 * while doing this.
> +				 */
> +				rcu_read_unlock();
> +				schedule();

This is unsafe. homa_socktab_next() will access possibly freed data.

> +				rcu_read_lock();
> +				rpc_count = 0;
> +			}
> +		}
> +		homa_unprotect_rpcs(hsk);
> +	}
> +	rcu_read_unlock();
> +
> +//	if (total_rpcs > 0)
> +//		tt_record1("homa_timer finished scanning %d RPCs", total_rpcs);
> +}




