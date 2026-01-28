Return-Path: <netdev+bounces-254333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG5PImQ9emlB4wEAu9opvQ
	(envelope-from <netdev+bounces-254333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:46:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF08A616D
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AE93301F33A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 16:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CC73090C2;
	Wed, 28 Jan 2026 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="nHxaf6B1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586F230BBAE
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616508; cv=none; b=UDff0QEIPDzDiSTFmbt6HXUFaKGN2S/QUH/RnssVDKhy9BjYZCAvfipwJusbZx7zWS+q0Nz5GTQHfRR6WUIM2o/lSS/v7jo3y4wsSG+bvmg/lvMzF+mbIDfu+IoKvsrzqrDTrs+5i3UVdVHsYBr8+o/cadIcrVPrcuv/GMqlXV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616508; c=relaxed/simple;
	bh=Ck3/TVpGdm5XlyDxvF+26c/QDieIZ9lm12lyWxVd61Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eg9nYmwGfiqSOhd7ITpE4Nna5w4Npbr1Jqou2m9Fa62tKBmoM52hzBBfi1TqL0cwKSdjmYEEReBqwZyNOIoMHO50CQGC+gKngDzc2nfGD1tnAiV/Fju7FH3mK2cgovKgy2xqF+Si7zpmBA9Z/2PcS3SZ6HIizCjy+GtN82qk//c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=nHxaf6B1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso128095e9.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 08:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1769616506; x=1770221306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WiKaoWtjMRDBROQANeCkUjaTheWdM6fcaXZ1pKr3nZg=;
        b=nHxaf6B15jotdI2axA3YudjRkAFwxCm0qGEUjgzS+MUfGkWpCfdtwaj+nD4uyxcW6Y
         EwQmXaJ4qwofIGbqbkKqn4+azI4sQATqDEWNYOrasKVmh9o2DSUCLdAdiZzU88z1453z
         KyoccNrcsPWtNVuwJCmPgOpEp+xHh37UOLgtYGCb6m1hXlkAirlImsILuM5FHu7bncim
         OlkYmuLqUJ31JFbDAXx/XpDyioDqtTs2loThh7gkihAmwHqYWgdkUWZ4PMb5ZCZ+akt3
         ykvnpHOdw/7VeKHKA3rZkojG2shZKMP8XUvX4B25SeR9EZDcr211ErgM1CobJXQpJqof
         WQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769616506; x=1770221306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiKaoWtjMRDBROQANeCkUjaTheWdM6fcaXZ1pKr3nZg=;
        b=UUAcniTQrcigOHxV7wI+LJBoVvKQazqzXjFvKGe4HU902GMS6cZVxbNJCVzGBYZQI7
         q6D7Tq34lR6SqAIFEU5t2izVkryWecfk7TT6erBstwLh7KRv61nu+tCBM2MF5Cg0LQ8F
         lAZjt/fzZNHQoj7hDY54o5qQiwJJcXLCCCGHKAKzgrNa8MLLBbNfXJYdD01fMnd1Q2f2
         xyGbS0PSQld2DVFy8COeLp8MH2FlhAN9/CdRFa9JvL1BIAZeQitFS0WmwbHl7AsOn6+m
         kHtuM1Wa2ZK821zwFl70KCoNx1xAPi4e7LL/9qllHSnqOfpGw51u/6iF+9SYThRrvZod
         r4XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSpsghrS+VfNUGDfIixyPAOgrO+zkmx1IKkrlets5tcRvVFEVjmSb8qNPNBV89pIxpaALg6xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YygfxhvvdVTsJw08p4cVib/OTAurbaA2aRyUhEWr5KfkKSJcOt1
	ag1iZ0CmTGs/Gr/x/obB0Ws+nQ0/Xaklr1ACeLAzgAdUW2kUs28Ap/UW9KTMAH6r1lscLU8EG42
	Ni3Tf
X-Gm-Gg: AZuq6aLmfSf4pxJk/0kgHPDnE6R7cRRj7dxbpA9xRh1yAiUZdIpT7D2n9Qp3Bi9G+JK
	9gc/S14qcObbLHtHW2CCU/c31kuMjbJQ6YXqIKmO/hzCYOvJmfG5S6oA2HsXCduEqfd1gNObZgt
	0y/F5LnARZhj5KA5WSRQuj2tYyAKmSuUxmGf8ev0uJdnLJyt3s7SLx6zBcpVYcSKZG9l8MhFgwR
	XG9u1JHESiZR54mAjVChjNbtPHuud2DlqVZIdp10klyQmKEspXvqvnu+6fMWbF61WcPOwMo3win
	n7PQIyx5yUvZhPJkZ94JEMMzEr9Dvy1swn12BW/sbomNWzu54/9iuV+8q0vtIWUETr8947b2hAJ
	oRMlQJdyz+g2oAG882c80jZ60bSPXG6CaXVJqAJZG7b/JjVFrzNvYRy/zmJOMMmEdNTdMwEn3cV
	DQSHD6hWLgA8iCxfOjFrQ1eKzADycMZ8yoxBCYEUriPw==
X-Received: by 2002:a05:600c:458a:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-48069c6970fmr66761015e9.19.1769616505584;
        Wed, 28 Jan 2026 08:08:25 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c40e04sm138669265e9.13.2026.01.28.08.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 08:08:25 -0800 (PST)
Message-ID: <15f092c1-fb1d-4dc0-b04b-a389c53cd62d@blackwall.org>
Date: Wed, 28 Jan 2026 18:08:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bridge: fix static key check
To: Martin Kaiser <martin@kaiser.cx>, Ido Schimmel <idosch@nvidia.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260127101925.1754425-1-martin@kaiser.cx>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260127101925.1754425-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-254333-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kaiser.cx:email,blackwall.org:email,blackwall.org:dkim,blackwall.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DEF08A616D
X-Rspamd-Action: no action

On 27/01/2026 12:19, Martin Kaiser wrote:
> Fix the check if netfilter's static keys are available. netfilter defines
> and exports static keys if CONFIG_JUMP_LABEL is enabled. (HAVE_JUMP_LABEL
> is never defined.)
> 
> Fixes: 971502d77faa ("bridge: netfilter: unroll NF_HOOK helper in bridge input path")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   net/bridge/br_input.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index e355a15bf5ab..1405f1061a54 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -274,7 +274,7 @@ static int nf_hook_bridge_pre(struct sk_buff *skb, struct sk_buff **pskb)
>   	int ret;
>   
>   	net = dev_net(skb->dev);
> -#ifdef HAVE_JUMP_LABEL
> +#ifdef CONFIG_JUMP_LABEL
>   	if (!static_key_false(&nf_hooks_needed[NFPROTO_BRIDGE][NF_BR_PRE_ROUTING]))
>   		goto frame_finish;
>   #endif

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


