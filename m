Return-Path: <netdev+bounces-283723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UER8HAZP+GmQsQIAu9opvQ
	(envelope-from <netdev+bounces-283723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:47:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA69F4B9969
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F41213051C93
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 07:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D3E3093CB;
	Mon,  4 May 2026 07:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="n3dL+a0A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4952EB5CD
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 07:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880523; cv=none; b=X6Fqw6FeEbt9lltttWIFLQO2oHOXjHnEN9x9uI4ByV19zLmdJKWS+rJeGdKD2SNWOQRtC5oXY9TfFpAAGM9AolvHI0uhSwciWFJVIHXTS67jgc3DIgzTLzZ4c8D4EX/kazj9FViVKiW3VTgCieKP9Q/qCxd8PYbOAHpQilv+uRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880523; c=relaxed/simple;
	bh=wppOGaRjuNDplImhUtX3yedW8XVD+Rjnv4702GUsXr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRCvpcwGyCcwK0IUvNXO/FQphxhN9h9ow2LYD3INV3IOZu7Z2H1MMObtvd/HAPfVVEawwzKrDzpqEVP6oO8Hmc/Mn/H6pQGz4mkRpooEjcZT4AfdBZY4lzbeCZMhcA2KlPPNGGSTIJthYf0rYwk27dHKhhVo4b7NRPOIZY58F38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=n3dL+a0A; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48909558b3aso39928735e9.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 00:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777880519; x=1778485319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C3RAkK6cIEAorEjiat0wspxnHljFQkJZ30oFU41kBVI=;
        b=n3dL+a0AITT7wMJ+2WG2k2aw+20TwJLDw30kWbJF7NXj7OpKpMV4otW1caMBiIs5zv
         C+TWVXvoZwedO34GZrE6m0bskRY7XbUKTsgWbDkNxa/Qn8kAteEmenwHBbNAl42CZb8b
         kefAaI8RnJHocsQQTPrMY70OsTM8F4ClUFYp/HYl2SD0c8QUbYSIvfPe0P+413s93caH
         vFnLnJG/sgH4EroecFQ6VI3ZmNp+UcXSoFX1W5GH37vYqiTQTfBka7Ep1WSVVC4uFgtE
         6DUd4s12zZe3WBsnnD4zvZmBdh2r0wSongMF+FqopFaaohKl34ZHrRpjwPjIOOZMWvUn
         FiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777880519; x=1778485319;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3RAkK6cIEAorEjiat0wspxnHljFQkJZ30oFU41kBVI=;
        b=aspI8FybwroUs2o44ovu4XtGctIPnpGwUJW4HEotIuWFckrZAz4PsstNq1QMlrQEdi
         8qJSzF/0TMag/bfKfrb94nQu8dpBfppcF500JoKu4tp9jRJJDAeiNAmAOPwmnN6bAVLC
         WtxZI1RK/GYQ5NsEck7oM28JrGvzmgRtt8WXuq0GqfGjE+Ou+KeidhSz5HfPk3K2I/I+
         Dj5Ozwox8xUwhg5ZUQ+o98z+idPJWFJxJiVgir47LsDV6ghc/7gYrhhxZbhncePpN3iS
         mu9sdmYlRS69EyhIfQic2JedSTYE8XnMLJ1ZW+rO/k8cA/0wSaStJb1XL9v4peV3HAxx
         e+gg==
X-Forwarded-Encrypted: i=1; AFNElJ9LiJJE5xhvZaKwXBqj7K6c5TKVYK5j8nVoBXIGrh4L6Sj21xaULIH69gqchAsL4J0gpcFSTnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkaA2lqy6qwjMn4qkWNhMNql6xXC1UqD5YZ7HXjLfRtlBwC/mN
	gq31z+j1YH/GygA19fvJFEf2gT7oKbzVg9TJKdJpBCm48UjJxhZ6FZ/Cso4zf34KK8Y=
X-Gm-Gg: AeBDieu+Ug0jxiI4WrAlxYJ18xNF3wj6qejnMOLLdUGtJ0cXcr81x+bVioLSPAifTlz
	HooKcXDVD3bfOhIkdy4n1+zrh2MF2zBVAmr8YqUCwWntf6L92f41GtoQCm86wPwV+XdLw4j+mmf
	zkr57JO0xpFqirMTqgGVWGajhNPNiqbQZsliQpMDam8h4VulFdBAB3FIGSJTCHKu0Q6b25ToKWi
	0uy2tjjAWCP0O/iQUYytVZ8DvBNjpoKf1r/xG1YJ6ztC530m560hnOzbbgEKGjZQAQSIa+jlJbn
	NVLZL/hL9w5gGSqp5VMt4AqoGsNgRPd8aEu+eLiNG8QmjSGq5pftTAQ1OXhIM/MZlc3HuGH/wJ/
	HGYk57Py42J11IsJc49EDDqHtcT3Yt0/tGuzCfDyIaVpFWHsSanNRHhvzzPvPsVofmc12LkUhWz
	jVTyLXhKJ0etNM+Ra0Fg56ssdEZDlgHUv5sBu2pgZ6eaRgsdvLTzxRaAdWB9XbC3v5
X-Received: by 2002:a05:600c:1386:b0:488:9439:881a with SMTP id 5b1f17b1804b1-48a9852f471mr135743855e9.2.1777880519512;
        Mon, 04 May 2026 00:41:59 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fef8f39sm73312865e9.32.2026.05.04.00.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:41:58 -0700 (PDT)
Message-ID: <4e172860-1f37-4de9-8520-dcf3d53d5ad7@blackwall.org>
Date: Mon, 4 May 2026 10:41:57 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/6] bridge: Add selective forwarding of
 gratuitous neighbor announcements
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
 <20260503073532.2138165-4-danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260503073532.2138165-4-danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CA69F4B9969
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
	TAGGED_FROM(0.00)[bounces-283723-lists,netdev=lfdr.de];
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
> The existing neighbor suppression unconditionally suppresses gratuitous
> ARPs and unsolicited Neighbor Advertisements, which prevents fast
> mobility of hosts between VTEPs.
> 
> Add the neigh_forward_grat option to allow selective control of gratuitous
> neighbor announcements. When neigh_suppress is enabled but
> neigh_forward_grat is disabled (default), gratuitous announcements are
> suppressed. When neigh_forward_grat is enabled, gratuitous announcements
> are forwarded while regular neighbor discovery remains suppressed.
> 
> The implementation provides per-output-port control by:
> 1. Adding a 'grat_arp' flag to BR_INPUT_SKB_CB to mark gratuitous ARPs and
>     unsolicited NAs.
> 2. Setting both grat_arp and proxyarp_replied flags in
>     br_do_proxy_suppress_arp() and br_do_suppress_nd() when gratuitous
>     packets are detected.
> 3. Checking neigh_forward_grat per output port during flooding:
>     - For gratuitous ARPs/NAs: suppress unless the output port has
>       neigh_forward_grat enabled.
>     - For regular ARPs/NDs: maintain existing behavior.
> 
> This allows gratuitous announcements from any input port to be selectively
> forwarded based on each output port's individual neigh_forward_grat
> setting, enabling gratuitous neighbor announcements to be flooded to the
> VXLAN fabric.
> 
> Regular neighbor discovery (ARP requests, NS queries, solicited replies)
> remains controlled by neigh_suppress and is unaffected.
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>   net/bridge/br_arp_nd_proxy.c | 22 ++++++++++++++++++++++
>   net/bridge/br_forward.c      | 15 +++++++++++----
>   net/bridge/br_private.h      |  2 ++
>   3 files changed, 35 insertions(+), 4 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


