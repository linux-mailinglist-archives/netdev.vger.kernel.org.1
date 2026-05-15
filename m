Return-Path: <netdev+bounces-288131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIBUM+ZrBmqFjgIAu9opvQ
	(envelope-from <netdev+bounces-288131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:42:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6406F5481C7
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C63863046FDC
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7A934BA50;
	Fri, 15 May 2026 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OohOHiBa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FDF33E368
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778805605; cv=none; b=RRhhU6zKtO690pRR+s/tFIew15QerUfK7O7dgZYQOgAK2Kyb1T2/e7+Boq57whFxVdUR7QL2u5kjfp8PZnEpYOFfuaHBan+x/QN5qKepWxweVTQdPpWtzUMdYnytZZehaI+62g1DPSKB22BawbX+ITclrjGOOfblHbV/Wo53Y1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778805605; c=relaxed/simple;
	bh=MPsAoDgwSud8ujCJSnrS05eA3l7Zf0/YspFqjl5KxL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L18BKz3k2sa/bzF5u3B6vDqzegrlXR+hJNjcDmmpnh1hX43wbnPROIHXiwLaoP9FuDTSDP/tdJmonD9CwVU+ZWpPzS5oq9V3RsZCVq8gZGFArBfVAKK2ONWLTABJjOdDFPUwIQvfUvf647WQalEGZq1myph0V6Xa3/BeEVRq8Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OohOHiBa; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-47c7b282e21so3545258b6e.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 17:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1778805598; x=1779410398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UFhBAFvMzOFdU+dTo9inXOk2WrWYrKcxJWd53K7eJsI=;
        b=OohOHiBaLc8K5Tlts/0Tu6ucHfYd3CGIYkLRiVPto4l+BdZKEjA7lFRldtNRyDjrgR
         RR8+BxBQxOaW75oE32lJHCp8W/ji5ObHpOHflrxJpQm1e729J6CzwY8+uifqbbkNRfLI
         sk1SLVKkcwCbeAjIagqJZTUNPcWnF1U1B+HAwLBhEusqDCTCjwAo3rVQ+YstlyzD33Nr
         s6ZRmbyLVu8KBfv5LQS33sihWGCvzZ2Oe63SZUbktomvU/a03x1Uay9iy5G1KQGXZoWe
         e4blKx5MKsyDfz/mgni1kZP5ity1v28aA2CKOgYM4JJwN1Qe+FxKf6f5uK/BzKCIn4op
         VGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778805598; x=1779410398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFhBAFvMzOFdU+dTo9inXOk2WrWYrKcxJWd53K7eJsI=;
        b=ohx0a18W4VagUPmGCS5fWw+N3ynZT+qfKmFcLxvXmKWWJHr3qXutFpEP+arPtstaRm
         aDLmIcdeZUiJLwpeMGf8y+PacjuyHQzd2eUx3KgvX95Lc5rmy9Q26eVBvuWu9vzlCgJr
         Dk6K/Wtll87W7PwBtOsXq0AOzF0T9CbnQiCpJ4NwOv0KUA8rHCkx9sXQCJUZMzSXVnzN
         AlRGakz9TTY/R7rlFeX3WLdJGJIGsjZwen9ZvXBfuy7SdZECm/HbcCpm3ahxz3GLyW1q
         VKxFJpEUKuKVmZPbe8ZvYwSt+oDyDKqMwLbrTvPwwhhh7kmjebGYaRynV3CWXjujwMNs
         nNBA==
X-Forwarded-Encrypted: i=1; AFNElJ9RtgHJ505f61pgGKdSV4H+9GPALKmMrgm/S2R3QhV5QmUrYYFTzROGNsqlqEvo4R08clDy68w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoZoJprCKjhj3ocY3k6xDpVXng/cESFUm8rhGCQK5rMMr16R3+
	Yq41sV0J+4UVlOYttJ3QPTx92WJe9Ivf+zFhTeGY+N1ABhMimSRexmFdNfFpbX3rQ4k=
X-Gm-Gg: Acq92OEJqRc8ggFx93g8zSx1zkEg4evu9BrnK4kJclYNsVOGQi+SHU13lt7gkc8m/ns
	x5FdnpvYLnM2SmsRDlLQS0+8ODeH0gbyoEdwcubtlgP8URGmXlKASWJEGvD0+I6hp8Cox+zKmBM
	qrc6eXFLj0A/evBtyAjFVcD8E6VtyGm5b4/Bhy2naCR8e2jrPupz+1Y8d3pvXMLoy948pBbU8LR
	F3Gdc9PiPPop6uFEAK3NM7hBv0CU8Hps1mYdnKiLSMYyMV2imeB8OBJIUn+Dfct3J4+cC6ud3Ve
	BXhNwJnWDHOuBhjpx1EW8ICLmxHhSD/MQq4MgUC3joTvKXJEqZI+MGjC1Sg/msZMKjlu5kp1wRb
	L8bq/RK1ciVyFvuJU4Lw2M0frUzg4Mho3OH71WJwbRf+tSwT3UR/oLBAXzP1U7GLFjF9MjPoVt+
	+fsu0=
X-Received: by 2002:a05:6808:384b:b0:466:fcbb:1673 with SMTP id 5614622812f47-482e56c1060mr1243567b6e.17.1778805598394;
        Thu, 14 May 2026 17:39:58 -0700 (PDT)
Received: from 20HS2G4 ([2a09:bac6:bf21:96::f:3c1])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482ee331fa4sm55843b6e.2.2026.05.14.17.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 17:39:56 -0700 (PDT)
Date: Thu, 14 May 2026 19:39:54 -0500
From: Chris Arges <carges@cloudflare.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH net v2] net: Clear skb metadata in LWT BPF xmit
Message-ID: <agZrWsoTb0v4XieV@20HS2G4>
References: <20260514-bpf-lwt-drop-skb-metadata-v2-1-458664edc2b5@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514-bpf-lwt-drop-skb-metadata-v2-1-458664edc2b5@cloudflare.com>
X-Rspamd-Queue-Id: 6406F5481C7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288131-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cloudflare.com:email,cloudflare.com:dkim]
X-Rspamd-Action: no action

On 2026-05-14 12:47:09, Jakub Sitnicki wrote:
> skb metadata is meant for passing information between XDP and TC.
> LWT programs cannot access the __sk_buff->data_meta pseudo-pointer.
> 
> However, LWT_XMIT programs can call helpers that move packet data.
> One such helper is bpf_skb_change_head(), which uses skb_data_move() to
> move both packet data and metadata after skb_push(). skb_data_move()
> expects metadata to sit immediately before skb->data. This is the layout
> that commit 8989d328dfe7 ("net: Helper to move packet data and metadata
> after skb_push/pull") preserves for TC(X) programs when skb_push() or
> skb_pull() moves packet data.
> 
> The IP output path can run LWT xmit before neighbour output has built the
> outgoing L2 header. For forwarded, or otherwise RX-originated, packets
> skb->data points at the network header while skb_mac_header() can still
> point at the old L2 header. If such an skb still carries XDP metadata,
> skb_data_move() sees metadata ending at skb_mac_header(), not immediately
> before skb->data, and warns:
> 
>   WARNING: CPU: 21 PID: 454557 at include/linux/skbuff.h:4609 skb_data_move+0x47/0x90
>   CPU: 21 UID: 0 PID: 454557 Comm: napi/iconduit-g Tainted: G           O        6.18.21 #1
>   RIP: 0010:skb_data_move+0x47/0x90
>   Call Trace:
>    <IRQ>
>    bpf_skb_change_head+0xe6/0x1a0
>    bpf_prog_...+0x213/0x2e3
>    run_lwt_bpf.isra.0+0x1d3/0x360
>    bpf_xmit+0x46/0xe0
>    lwtunnel_xmit+0xa1/0xf0
>    ip_finish_output2+0x1e7/0x5e0
>    ip_output+0x63/0x100
>    __netif_receive_skb_one_core+0x85/0xa0
>    process_backlog+0x9c/0x150
>    __napi_poll+0x2b/0x190
>    net_rx_action+0x40b/0x7f0
>    handle_softirqs+0xd2/0x270
>    do_softirq+0x3f/0x60
>    </IRQ>
> 
> Drop skb metadata in the LWT BPF xmit path, just before invoking the
> program. Doing it late, rather than in ip[6]_finish_output2(), preserves
> metadata for tc egress on the outgoing device when no LWT BPF program is
> attached - the only scenario where carrying tc-layer metadata through the
> IP output path could be meaningful. Non-BPF LWT encap types do not run
> helpers that touch metadata, so the BPF xmit op is the only site that needs
> the clear.
> 
> Fixes: 8989d328dfe7 ("net: Helper to move packet data and metadata after skb_push/pull")
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
> Changes in v2:
> - Clear metadata in bpf_xmit to allow access from tc(x) egress (Daniel)
> - Add WARNING snippet to the description
> - Link to v1: https://lore.kernel.org/r/20260428-wip-skb-local-storage-from-scratch-v1-1-8f7ca9b378ce@cloudflare.com

I was able to reproduce the problem with a C program. After applying your patch
I could no longer repro.

Tested-by: Chris J Arges <carges@cloudflare.com>

