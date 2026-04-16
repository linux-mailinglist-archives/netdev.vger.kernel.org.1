Return-Path: <netdev+bounces-278986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGeOHqC14GlClAAAu9opvQ
	(envelope-from <netdev+bounces-278986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:10:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7D340CC11
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 159F9303339D
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DA339D6D6;
	Thu, 16 Apr 2026 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKRSjiLv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="c359IVp7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684B939DBCB
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776334196; cv=none; b=pN5EwOfLeurdeFY+LzgBZ7c6A8N6UrFSo/bFeLnq/zMnTmsjVlX0JCMrMjrHCCoIY9Rwfvx7v3yInp0z2DcybTy8OihYT8Q+pddaSvpD5HcWl1oA4IgB+HUjepd17o4Tl2cZsz3zhy7Xgeye0Kr/Omq2PC7czeC/N+VW7aEVHuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776334196; c=relaxed/simple;
	bh=z6kd+nKQicYvDY3CUkmgWTERBKk+ndyaPYBRpyWXIEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9X9+CL+m1vQy8NiHXAj4gi7pNdR6i/VftV0WMftRbDTwaWH6BRgVCwFbwJabjCqmz7q7QyrC59pLab7LLtw3mzLGaok2l5grd2Z7X9CAtKnX3IKY0DpkEVAyZZBY0YbRQJuIG+wxW/d6ox92YORg4/vmkWjEIa2R0r6DGOXyKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FKRSjiLv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=c359IVp7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776334194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1cV7q2j+uSEe+DAeD9qB2jVzt4SquMZBCuxmlDEB6Vg=;
	b=FKRSjiLvn2Ln+4VffUmQl0XDxeSIxlGOeo1nI+lTTswG3MAQ/5cfNxrPftOjPpq9fRqz/y
	lF3HwGfGaiqwbCLNbqMvF0ninGDRo5Dzg5XJA90En6Y1cSSsvo7d0zmM5OQtr9fEymx08U
	qjhsvWEy1x6ob1763lW0Wo67khvRTV4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-gZKdrRQLPaqe0NACwP87bA-1; Thu, 16 Apr 2026 06:09:51 -0400
X-MC-Unique: gZKdrRQLPaqe0NACwP87bA-1
X-Mimecast-MFC-AGG-ID: gZKdrRQLPaqe0NACwP87bA_1776334191
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488c2cc0cbaso45248285e9.3
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 03:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776334190; x=1776938990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1cV7q2j+uSEe+DAeD9qB2jVzt4SquMZBCuxmlDEB6Vg=;
        b=c359IVp7gA11Oc3qzyHXzpH0x5bGs0Ht9uRRvmb0cgeXb1kqbpOd+oPzanNhmTpO1d
         vdXBrCuAwrSg6Oca8GjQRpgx3rOE/T2F5ycH5E6jyTGKKQjgl72mJAKS1ntS9RDoAePy
         k2hRL+zjH//o/KKyZD6zCYbPpv655LtvEkB+oXa1AccvFk1UDeymiLjOM1ve81vaOdNF
         AKELMCSh/VGDzkI2a/qdg9onZpYOWlB/mVW7+1JHJwmw4usLt5x/YT9hgGbd4a2gKO2W
         OjWfMtdu4oDWX0bt/y3IS0eKalJ32o48pb4NBEj06GsyroI4cVtspk7SQWVH98tojLHu
         bPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776334190; x=1776938990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1cV7q2j+uSEe+DAeD9qB2jVzt4SquMZBCuxmlDEB6Vg=;
        b=ajoZfBxTZbMsQ25rJ4H14TiBKzOoK1yOm3hi04Oi3GCBv+PrLwz5bvzfWCf++J3sP0
         uFRJfbvL/RJHvA93iT7X089hhvPdyYWPzuhjr0E/FiAerJV96VMX0vuVhjmH8/gJMVml
         T/IcLOaF7F5D5Znwco7+f/5/c21TElrjW3cjacJ+/0wxDY6hzKTm4YRlNKZ/4YzqM6ZC
         O1bsTlSEBeFf6qEEMNnlPw++jjg9PbRQ+xSEj2fjQaviIXfcr4KE2Lz4nhsfkTEJqJNF
         x8mc4KT7CwWKPMToTrRFQO9QIq7dyO2i7EeIBV/E4RlBVqwEv22FI5MIY/wKTgVfHEGo
         Pmdg==
X-Forwarded-Encrypted: i=1; AFNElJ+oNEKMhHj8nirY+mToQQTHCV21YKB+Y5wqIFU9HlVqjV61s6rIJK1s5g35G32BdLiMjUB7o8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfYi3sl7K/r/j8natrGDIuyqqaA7NySh8enfFeUnymyRqcE1mO
	JvEneARX6gsd9pK1eRlzPKyiK8MuPZAd/0y5qAvVI0iZoPhHMOlVGX+hrIeSMNG+OxCzuHKRG4K
	VwaEHxYRF5xEdmN10GQ2ON6gw8z9PotWKt9IFE8cUhLAJ14W3uKSeszZTKg==
X-Gm-Gg: AeBDieuCOqT49swJD06hnFlhhHl4Sc5iDi7fwXTsEk9yx0ODn+BsJZmR5T5aoUQTdTq
	1g5dTALwTl3xqKcCtqk5o0/raQ7zyLxvttyOjq9RIIgD3NH7c9mrgJtYWNsDpKI9zSx8MO39GBM
	xjlJoQf2nMyXRaLNo4qqcjGIH1qNKM3mhFH9Yol2ZKldBFLsEt/LD5QPjnyIeJxbA+2trSoZUOA
	cvgq2dNNxomw9JhnTtEJEPYkNMBj+xkDFUNoiEQiLRGceYioGWJtyJ+DY7UDCrCAAwSNdolaMXg
	9dTo8i75pr7Q3cdxIEiItrBsU7TQP6YcL4K9sVy/XCljaNSRQhSLXm91Wbq2ZwWdU3AvaCTTdkH
	Io5gtLB0N2+ry0B67Ww+xpXJhol2eHhuz99G+ZWpeFaYCP5nThGwG95JEnWzNqDNVKuU=
X-Received: by 2002:a05:600c:3b24:b0:488:aa33:dcbd with SMTP id 5b1f17b1804b1-488d687a645mr349028125e9.26.1776334190392;
        Thu, 16 Apr 2026 03:09:50 -0700 (PDT)
X-Received: by 2002:a05:600c:3b24:b0:488:aa33:dcbd with SMTP id 5b1f17b1804b1-488d687a645mr349027665e9.26.1776334189852;
        Thu, 16 Apr 2026 03:09:49 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5813665sm43475935e9.2.2026.04.16.03.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 03:09:49 -0700 (PDT)
Message-ID: <d49d5804-96b8-4e84-b693-b51a7e1cca15@redhat.com>
Date: Thu, 16 Apr 2026 12:09:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: sja1105: fix division by zero in
 sja1105_tas_set_runtime_params()
To: Alexander.Chesnokov@kaspersky.com, olteanv@gmail.com
Cc: lvc-project@linuxtesting.org, Oleg.Kazakov@kaspersky.com,
 Pavel.Zhigulin@kaspersky.com, stable@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260413085140.33138-1-Alexander.Chesnokov@kaspersky.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260413085140.33138-1-Alexander.Chesnokov@kaspersky.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278986-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kaspersky.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxtesting.org,kaspersky.com,vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kaspersky.com:email,linuxtesting.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD7D340CC11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 10:51 AM, Alexander.Chesnokov@kaspersky.com wrote:
> From: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
> 
> If taprio offload is configured such that none of the ports' base_time
> is less than S64_MAX (the initial value of earliest_base_time), then
> its_cycle_time remains zero and is passed to future_base_time() as
> cycle_time, causing division by zero in div_s64().
> 
> Add a check for its_cycle_time being zero before calling
> future_base_time() and return -EINVAL.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 86db36a347b4 ("net: dsa: sja1105: Implement state machine for TAS with PTP clock source")
> Cc: stable@vger.kernel.org
> 

No empty lines in the tag area.

> Signed-off-by: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
> ---
>  drivers/net/dsa/sja1105/sja1105_tas.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/dsa/sja1105/sja1105_tas.c b/drivers/net/dsa/sja1105/sja1105_tas.c
> index e6153848a950..ce4b544a2b9c 100644
> --- a/drivers/net/dsa/sja1105/sja1105_tas.c
> +++ b/drivers/net/dsa/sja1105/sja1105_tas.c
> @@ -62,6 +62,9 @@ static int sja1105_tas_set_runtime_params(struct sja1105_private *priv)
>  	if (!tas_data->enabled)
>  		return 0;
>  
> +	if (!its_cycle_time)
> +		return -EINVAL;

Sashiko says:

Is this division by zero reachable without this check?
When all ports have base_time == S64_MAX, earliest_base_time and
latest_base_time are both S64_MAX. When future_base_time(S64_MAX, 0,
S64_MAX) is called, it returns early because base_time >= now (S64_MAX
>= S64_MAX), avoiding the division.
Could this new error path cause an actual division by zero later?
When returning -EINVAL here, tas_data->enabled is already set to true,
but tas_data->max_cycle_time is left uninitialized (0).
If sja1105_tas_state_machine() runs later, it will pass this
max_cycle_time as the cycle_time argument to future_base_time(). Since 0
>= now + 1s is false, it proceeds to call div_s64() with a zero divisor.

/P


