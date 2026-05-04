Return-Path: <netdev+bounces-283721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFcxHTtO+GmQsQIAu9opvQ
	(envelope-from <netdev+bounces-283721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:43:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 126534B9896
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FABC301BF74
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 07:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8543033E1;
	Mon,  4 May 2026 07:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="OgDUOEl/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1528B2F690F
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880478; cv=none; b=SZxwHWjBbYmUsnWYV4/VexI7+9Sw+Xmft+5YhfeQpTMo66L9DYWGuA5hWYDRapVfqv1n8jlrGV6y11t+5Y4q832PzwbWHANpIyBP8zix3MRP4EGbK3m7h33aMZ/bqBKhYPPqbKUxIPYGN8rXQQtx+DZJzc641ZMU1C4jeHA1yQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880478; c=relaxed/simple;
	bh=2rpPDoGUMbl/OmiwIJkP4efIs256LD8njZZi9FevGN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCM7De+CMMIYiEIG0qjBzmT9M1hcmTVtohlBBWb5AkDI5nc7vkK4dCIp7023ZFw4sYtHvs2UnG3zKj5cOgQYPSv6Yz4JBN9yxKkTOY80UMtmtbrUcFLZyP4sPjwk6OARSw6xqVzyv6agAyjvO+dm6m3bS7/fhRojHQhSgnQPTdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=OgDUOEl/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so35707845e9.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 00:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777880474; x=1778485274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZhDFU6GxZcW7vndx5L08YOJX1khbTM/b3o1EeqP1uk0=;
        b=OgDUOEl/SnI6akw+4wx97LxnZxmG7Jez9kRErHykE2jOv5HJubkHsd4Yahl2eSYVJd
         Qy2+ys6mBmufS0FIIxL0zF3vQWUeSCXfb6g7+3Ay03SCt9qVz/QD0bFt6HYuN6z/daBR
         JzghkMUi10fkaQGhIg9QvssIrzMw6rVMQPUbVskl4u8ue+5N3exYL1RQFQgmwtwv71Gc
         sIh9mWDCX23BSSp5BjAytO+IgeraYmZmpp6bsCFbGavTO/YIcJxPdM52g+f8MQ28E/Q1
         QPPmCg7ADVSNEyaoI42O3nz8NjkqiJDGcw8x46TB6KVEjam3mbRFGMxHxLxy+WKxofug
         ZYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777880474; x=1778485274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZhDFU6GxZcW7vndx5L08YOJX1khbTM/b3o1EeqP1uk0=;
        b=HbvT24hxLc0+csdIQNDKWoV3WFTwG9CtXPOy26i4dhdlSXUX2QZRokAE1x+pp80bLG
         L0SmEzOJ1U4JZySGzAGA6WJUco86vgJLz77uMPzzPJcOVKZ4zIAsoJGQM87iz/E37rhp
         dDRYt1AucwanFhdD7W75eSu6f7kJsn/HTC7/VfJo+nZ86C7Tzi61igghcnKw7CN8bo5w
         5FDc0QvwxS+0lWkAVl1Pytq+FAwf2zfG9pk1wug8zb2i2A+bMYI5Zmj9kV30EJl9+Bjg
         qu3ibPg4/6Rr0LN8QgIH0oZ46pLr31F7FuKX23i5PpqtE/QtrT7V5a2f4GjOawo0OzH2
         VTeQ==
X-Forwarded-Encrypted: i=1; AFNElJ//6JhiSpuMzFWnj/rvmqxiwgI52ccz9cdgF1ukQ94deQj5DWAiawwHDdEPvum25FEw53hgXoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+2ClVPuNIvdHc0E2bdVoHvWj9JosTmenaBlLozUjbFcJsiISe
	seZtHClUXVkVjokfA1sIy/17/fzuf1u3HZztSyDEl5aIQ5CMgplp7VYDt3Jb6ccsm3s=
X-Gm-Gg: AeBDievcbd/rd7QFB+iTTska6yurSR7M2VRMt2G+IEFrOSqRchmE3ZRkjzEqJwmhBko
	6iH+Mu7JZYd/ReOYem0keSDTUnoLjolBqG8MOysi/rjcavwZqZ0yEHRXG13sMRe+7O/l6iEW1Hs
	WEafx3q2nBV8wrXFhS2eerS5KOY4PpvdH1+KRZ306kMYnkI9aZwR7/ZTPmwXhVTY9I3NamNa864
	Pz1K4kYv6qJnKirdpfSzbph6dRz15bPxaOReGDXP/x7UiRKG4TBb5QOOnHxD9eOzY7AKrnrd0F7
	Fv1iSiDVIoicjm+Ak5kxaFb3BDWZ1SLGE6pDvHGc6MC4fO0EoUR46pdG+YnwpFwh/v+SXCkomPF
	G3gjNSdkRP0gO4kYbnR9mNmmd7UKohRBahwzGU3+WDZFvZmfFFoHqyMesMlTBRoyZ8OowfJQXnH
	4fCkpwb9MWj9s8Fdfnahu6LxIxwJfPWgTXmSPSmA2AL8EZnIJb3LnT61QUXWC9wi38
X-Received: by 2002:a05:600c:1f11:b0:48a:f18:ece4 with SMTP id 5b1f17b1804b1-48a9866e803mr139507745e9.24.1777880473443;
        Mon, 04 May 2026 00:41:13 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fee4da6sm74095385e9.18.2026.05.04.00.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:41:12 -0700 (PDT)
Message-ID: <6803e955-7512-44e4-a0d1-8ad4d62e31e9@blackwall.org>
Date: Mon, 4 May 2026 10:41:10 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] bridge: uapi: Add neigh_forward_grat netlink
 attributes
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com,
 andrew+netdev@lunn.ch, shuah@kernel.org, ast@fiberby.net,
 liuhangbin@gmail.com, daniel@iogearbox.net, aroulin@nvidia.com,
 fmaurer@redhat.com, sdf.kernel@gmail.com, sd@queasysnail.net,
 kees@kernel.org, nickgarlis@gmail.com, amorenoz@redhat.com,
 alasdair@mcwilliam.dev, johannes.wiesboeck@aisec.fraunhofer.de,
 petrm@nvidia.com, linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
 linux-kselftest@vger.kernel.org
References: <20260503073532.2138165-1-danieller@nvidia.com>
 <20260503073532.2138165-2-danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260503073532.2138165-2-danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 126534B9896
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch,fiberby.net,iogearbox.net,queasysnail.net,mcwilliam.dev,aisec.fraunhofer.de,vger.kernel.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283721-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	DKIM_TRACE(0.00)[blackwall.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On 03/05/2026 10:35, Danielle Ratson wrote:
> Add netlink attributes for controlling gratuitous ARP and unsolicited NA
> forwarding when neighbor suppression is enabled.
> 
> Add IFLA_BRPORT_NEIGH_FORWARD_GRAT for port-level control and
> BRIDGE_VLANDB_ENTRY_NEIGH_FORWARD_GRAT for per-VLAN control.
> 
> The new attributes provide independent control of gratuitous ARP and
> unsolicited NA packets. Operators can enable forwarding for those packets
> for fast mobility across VTEPs while keeping general neighbor suppression
> active.
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>   Documentation/netlink/specs/rt-link.yaml |  3 +++
>   include/uapi/linux/if_bridge.h           |  1 +
>   include/uapi/linux/if_link.h             | 17 +++++++++++++++++
>   net/core/rtnetlink.c                     |  2 +-
>   4 files changed, 22 insertions(+), 1 deletion(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


