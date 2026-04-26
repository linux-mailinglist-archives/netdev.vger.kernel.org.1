Return-Path: <netdev+bounces-281191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gItsGRFs7mmltgAAu9opvQ
	(envelope-from <netdev+bounces-281191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 21:48:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAE446AF9E
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 21:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5941C3004C53
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 19:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2D038B7BB;
	Sun, 26 Apr 2026 19:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksEB8nk1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC2237F8AE
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 19:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777232909; cv=none; b=eEaVxTmCgD62V4P8RPjiiLWB+gLwCVstSB8+HJvOehaDKluYZUKVSJSJkKyOYVbdU0WosNlBHSB8dvoh5oohlTXbGXfyQ/0ZO+xzrkEKaD2pO/gwhQkKuTbjc8O4P0yE9F2fg+U2N5FZ25QFmYE9NNt6gW1snyliWc2suVFdng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777232909; c=relaxed/simple;
	bh=UgNhc2XtPIsCVwwxP/76/PjPGzxLvlQlMmoEYslO3GQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7Ytaqlm0kFPq7EdDYM09W8YFfBwz1n8OlGQjlbfEs48e6vrBMz5bBxLdhAPKAwSOqgKU1cdEly2tZ/YkgxG/ZfOFZNB+/2F9ANqRU/s2TvvlbwgN/1dUPDFEM6nLRkyTi8rLjxjtPRT2stRUEPF36/sM7NhnPwv4otMGf3dHI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksEB8nk1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488d2079582so112000075e9.2
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 12:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777232906; x=1777837706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BWIZcQP7lzjA6vLYx3LGv7xy3BI2jnI4CCl625QupuE=;
        b=ksEB8nk1WVUQlao1cP5KnhIvkj/BHb09RvulMurc690BpLsu6f5x/R/K54mPFFF4p8
         Omkx9UkdxvGyOuh6b6/KhMaEHEYJxkQsUReQfaJ/sQCtLecV3QsuZJNNSCFc1zjrTm9D
         7ZLznHpRTTSiaLJhquVjCz9iB0fD/o0TEHsLDKVbguGupZ6onJP6F7ulzGKFywlDHVXA
         0QA209UIgujzMmUdA5IatWCJOG6YH5E9BG2pzcAj6KfkriCHaxKvZr0kgsuNFql7qCX9
         Pzd0lBIUu7Mv7h4HvOs8as5qxwbVkifnGTxr1dnbxhdTt8u6cYiBH/5MCcJCEVCMeTA8
         Evug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777232906; x=1777837706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BWIZcQP7lzjA6vLYx3LGv7xy3BI2jnI4CCl625QupuE=;
        b=YWxr7/I269KE7MSeGYSpw9yxt8DfR5sy+97/lVA9v95vCp0QLhWkAZagB5Nb0U10s0
         GsFzahUR6gbw/7QPlicA3L12dTCPSbcvX3rOth2wjHFpp/F3Y7QhiGDRJ4P6pMm3IeUT
         LflNzBzkSKcoU3F2saSjLNIjPkZc1Ln4zF5s+cMSJLYy+GqnPZLqLNfVlVc7ikCKXTTW
         N+30k+9uXVvVPhSvf6APPb5KGvtb80yU8+hFLJvfnUYoiMMhjjvur9hbPa3XGezCESe+
         RyTmxvKLKvOnYsVF4lXJkOLMnDHkVw4XhvIa4wa1GN9KQMIJSfrd88iYapTdaJTu7Lkn
         vyyQ==
X-Gm-Message-State: AOJu0YxcGw2EHPVjtV1jEAmYEl5efG33qUwSAacWA/yvZcdvp+TRrXXz
	40Vuwy8BjBaV/P4ng5ojlihGy2S6QIn4IaO6KcxnuOSg+jhDF0KlYnOG
X-Gm-Gg: AeBDieufP/HdMffYMUyKS68oBaRWt84vMzna/wSLeVPZLl2tvRo1JEqVSnYDkXxq0s8
	7xa25tDXxo8MuJqLyHrT/WWExoQv2U0LmA5L6RAhpCWHDXu9TurE3WLTi9jB9TZ/wwLUwus8Wh8
	cQQGmwytPwsz0uXwo1njQF6eDfhIIe2x1T9ZT6An1yPukXf20p4HkreR+hZ57a+8ZTwk3Yih7+F
	ooO6E3xXNY0PUJLggGv56Xw8e+xcveGEMHcYc4T/P5AlNQcCGhPPv2RURFxyDnQ12NuURiUxP43
	ku68NlmwT2Pkw8k3tPgPtEuvcKA7fW6CcQ/Chbg1DZuP6zYas4l7CvFdnBsB8SOfgZWqZlOuo8T
	Vm11J2sSff/ObsO0BpJZcDWejeTUFVjTbFOlL9ewRBeBmAgA2XkGymZBL/KKwrYORKDtOOrMqxh
	0AUPy09voXEJ2fq3wpU/hhtZykv6tQSo3JjiwsUKv9esQ5ZWj9cdEqOoKwUHBGVEVxAsayF01l1
	q7lewZ9Te9TG6jF8UlyTnxm/7YMQkok6+66Cos5QYOEQhjrLH3bXvHE3MUWyQa70jy6OcJHNm+0
X-Received: by 2002:a05:600c:1e28:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-488fb77fbf3mr578841625e9.20.1777232906049;
        Sun, 26 Apr 2026 12:48:26 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f05:5f00:78bd:435f:9d9e:b57a? (p200300ea8f055f0078bd435f9d9eb57a.dip0.t-ipconnect.de. [2003:ea:8f05:5f00:78bd:435f:9d9e:b57a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1cfbf2sm777227475e9.15.2026.04.26.12.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2026 12:48:25 -0700 (PDT)
Message-ID: <7ea50189-2114-4b98-8713-8876f071d7af@gmail.com>
Date: Sun, 26 Apr 2026 21:48:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC Patch net-next v1 3/9] r8169: add support for multi tx
 queues
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260420021957.1756-1-javen_xu@realsil.com.cn>
 <20260420021957.1756-4-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260420021957.1756-4-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9BAE446AF9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281191-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 20.04.2026 04:19, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch support for multi tx queues. But we still use one tx queue
> here. More support will be available in rss support patch.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 278 ++++++++++++++++------
>  1 file changed, 199 insertions(+), 79 deletions(-)
> 
Series is named "add RSS support". So, to reduce complexity of the series,
multi tx queue should be removed here and may come as a follow-up to
RSS support.

