Return-Path: <netdev+bounces-256701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM2jOO1Eg2nqkgMAu9opvQ
	(envelope-from <netdev+bounces-256701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 14:09:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7C3E632C
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 14:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 685AC3002B5E
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 13:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CEF3D6460;
	Wed,  4 Feb 2026 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYr3bXBo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AM9l8TBb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D203D5223
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770210537; cv=none; b=e3Qv0KC31B+cjAhuiPZSzcjYAMtLDdN7+rze8bEaa7dSUxvYgJ8cpgtDRU8xzawiOmifzY5/h9byLn1u3bq6NcKYY1ud000+q2/EaaMzAF8QDTE577tAEZPCLCtovdLBb9pV7FKa/+0ryiDH4e1ers2WeuWTpLDErU6efVlb/8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770210537; c=relaxed/simple;
	bh=3SO7cx5S7rFSJXcwelZ0NvCFyBA7ptmmVRTDDObOIVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lODmy/bs498YhKWU5JOdBWlPnUqPEVW6aMrCBR66TdH+BgGjz29WzAEqD6tAggbDeBIr6PCaM9hpeVix0aH+d06i0nayGPTxmln+xkiJTAKpSHLyv3UngE05qFDtXu+/3dfCzDCmE2eCBAaP6lLGek0TILtgRfn4mEF1PHJwvdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYr3bXBo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AM9l8TBb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770210535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2NGUqptSagiULrSmx3Ua+uy3IXQxpZJrFS8oeF2RpaY=;
	b=LYr3bXBoPWyb6YYpI1IIgGlLyCCXx2/rrhZfg15nhrSyaxhRdvyBz1grZpVh1UUzoWZdJI
	p4eUduhPq2Cy5LVyoJUNoXaW5JxxJLiLtPKBKO01NivPCf3P0+Hy3S0P+E9vMnArDYMW6V
	JJi3Ap/WxkbC9Hw+6GuBEK6WQE0i9aM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-iSkM5nlNP4y86BYpW46CKA-1; Wed, 04 Feb 2026 08:08:53 -0500
X-MC-Unique: iSkM5nlNP4y86BYpW46CKA-1
X-Mimecast-MFC-AGG-ID: iSkM5nlNP4y86BYpW46CKA_1770210533
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-435a6c0c794so4891454f8f.2
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 05:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770210530; x=1770815330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2NGUqptSagiULrSmx3Ua+uy3IXQxpZJrFS8oeF2RpaY=;
        b=AM9l8TBbUWQik0xVUOgkWWYt4sbBEpDRPWYOg3zLDOe33ChvF900z1VzWo/cr8qEAv
         0RCcotOm9A8o5CZlPdsGtHjybRM2IeT3IY2JMxg+86nz8UUljObpmczPnA0FD9prLZR3
         ZopdLpRuM8YfWSSdl/I26bOErkTtnHbPIeYJHVRm8itK3yeVqkg+51H6sxinNwVBhFpW
         SOan8s9NzOARg1Re4YzQSDiGxyfh3TWZE2yKvt3FZsGd5D9FyPqIv6/J0msk5oZ/MQPG
         binIMU6yXGVdIciwzvgI0cVS9yk/Pd8QcmiOnii1RYgTX+/2TJnnZ/P1a7SIAyoz9gpT
         Y+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770210530; x=1770815330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2NGUqptSagiULrSmx3Ua+uy3IXQxpZJrFS8oeF2RpaY=;
        b=S0SqblXCzfX3lJRk8AkqT58bo1Dk5sBLblxZMLGXM+EQHHtvAf1IaapCHBcTodjd1L
         T1CiQqobgriBelrxjOJNqcnzNsQ3w5p/J8WOICHvd+V/bxMaYmlMky1/LEwuxAAyAR2k
         SHYQIm9YKeN2n3YbmJag0egRHJaLl5wPY9axNQ+EfewSFIyyhIftQhcKeMEhHbDUJ708
         RlHJ9QGe2/uP7ZDyTkv20n9lNG07PQI+iZaLiLTMzJE4gQlJVY5+gtD1qc6E8Kzyn+cY
         VAOHZ8z51QEm2AvzxQcQQnq4NgSVCA1NAV1rDgJOGEmYqRjGOhsgXvHK0ggeZH3nCBNv
         hfLg==
X-Forwarded-Encrypted: i=1; AJvYcCUARMrNBokL7vjAOCyQIVy/pKwCoteW4ilBpLxmrQSPfkWGZTaAgiCzz0y1LRq4lz0VlylGWPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9iLyhIVZg5s7DyOWXoMa3gsFJoQI+Zf/IBQEiod4HpQgQLLqL
	4j2lRUZpXz5t3gUV5AIP+nSQCYIsJWotL622L0Zq/NVuG2DIlzNQRGL136e6w4zJO17/wyH4E9j
	vrJH2E1gP989ukaqXDlVmrKU7p9KworgmCTAZh26hOg5tM1E8S9b8XkskaA==
X-Gm-Gg: AZuq6aKZNZ1DqclBcdlNc2YtIauTw7yThLajZG+kuIuFvyy0E3HUZwJu0sQti93GESi
	MdWO/k5kQLR4E2gvJkuDzmUbrp1jVWJmH9KfNinBHvsEoE5Yal14AnlUq13DWA+5XZyJ7OohUht
	D2hH+g6cQaCSpCtVihAXGV+eQZKNhe+cCsI3X/bU0B83bR1wrIFHFgWOLAczBW0vKH4r4YLMz0Q
	M5NAA6RSOvhtPd58Y4i2khX58/sqSIztOB2+0L+RXtp6+7/seqUfBCwOcUlTLbyShu5sHA2J13L
	oEBPAW5xG1kEuzHwi+yxfaynNCF5fP1Bd1o9UqrE8PuLsKU78mdq4FTeenP1h/vr1TXJqomSagE
	Yv8ngUNoy
X-Received: by 2002:a05:6000:25c4:b0:433:2f55:7cab with SMTP id ffacd0b85a97d-436180550a8mr3837819f8f.37.1770210530487;
        Wed, 04 Feb 2026 05:08:50 -0800 (PST)
X-Received: by 2002:a05:6000:25c4:b0:433:2f55:7cab with SMTP id ffacd0b85a97d-436180550a8mr3837796f8f.37.1770210530022;
        Wed, 04 Feb 2026 05:08:50 -0800 (PST)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617cc9515sm5948265f8f.0.2026.02.04.05.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 05:08:49 -0800 (PST)
Message-ID: <1228b1f7-1765-4eea-90be-c9ddbc12cf82@redhat.com>
Date: Wed, 4 Feb 2026 14:08:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] dpll: add support for fractional frequency
 offset in ppt
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>, Jiri Pirko <jiri@resnulli.us>
References: <20260203101421.367965-1-ivecera@redhat.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260203101421.367965-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-256701-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 0D7C3E632C
X-Rspamd-Action: no action


On 2/3/26 11:14, Ivan Vecera wrote:
> Add support for the DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT attribute
> to the pin print attributes.
>
> The logic ensures that in standard (human-readable) output, the legacy
> fractional-frequency-offset is hidden if the new ppt (parts per trillion)
> value is present, preventing redundant information.
>
> However, the legacy attribute is still printed if:
> 1. The output format is JSON (to maintain full data availability).
> 2. The new PPT attribute is missing (backward compatibility with older
>     kernels).
>
> Human-readable output example:
> ==============================
> [root@host iproute2-next]# ./dpll/dpll pin show id 5
> pin id 5:
>    module-name: zl3073x
>    clock-id: 5855731461854439600
>    board-label: TCX0
>    package-label: REF4P
>    type: ext
>    frequency: 20000000 Hz
>    frequency-supported:
>      20000000 Hz
>    capabilities: 0x6 state-can-change priority-can-change
>    phase-adjust-min: -2147483648
>    phase-adjust-max: 2147483647
>    phase-adjust: 0
>    fractional-frequency-offset-ppt: 3003980
>    esync-frequency: 0 Hz
>    esync-pulse: 0
>    parent-device:
>      id 0 direction input prio 14 state disconnected phase-offset 0
>      id 1 direction input prio 14 state disconnected phase-offset 0
>
> JSON output example:
> ====================
> [root@host iproute2-next]# ./dpll/dpll -j -p pin show id 5
> {
>      "id": 5,
>      "module-name": "zl3073x",
>      "clock-id": 5855731461854439600,
>      "board-label": "TCX0",
>      "package-label": "REF4P",
>      "type": "ext",
>      "frequency": 20000000,
>      "frequency-supported": [ {
>              "frequency-min": 20000000,
>              "frequency-max": 20000000
>          } ],
>      "capabilities": [ "state-can-change","priority-can-change" ],
>      "phase-adjust-min": -2147483648,
>      "phase-adjust-max": 2147483647,
>      "phase-adjust": 0,
>      "fractional-frequency-offset": 3,
>      "fractional-frequency-offset-ppt": 3042863,
>      "esync-frequency": 0,
>      "esync-pulse": 0,
>      "parent-device": [ {
>              "parent-id": 0,
>              "direction": "input",
>              "prio": 14,
>              "state": "disconnected",
>              "phase-offset": 0
>          },{
>              "parent-id": 1,
>              "direction": "input",
>              "prio": 14,
>              "state": "disconnected",
>              "phase-offset": 0
>          } ]
> }
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   dpll/dpll.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/dpll/dpll.c b/dpll/dpll.c
> index 9dc3f8db373d..624567c2a826 100644
> --- a/dpll/dpll.c
> +++ b/dpll/dpll.c
> @@ -1261,8 +1261,11 @@ static void dpll_pin_print_attrs(struct nlattr **tb)
>   	DPLL_PR_UINT(tb, DPLL_A_PIN_PHASE_ADJUST_GRAN, "phase-adjust-gran");
>   	DPLL_PR_INT(tb, DPLL_A_PIN_PHASE_ADJUST, "phase-adjust");
>   
> -	DPLL_PR_SINT(tb, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
> -		     "fractional-frequency-offset");
> +	if (json || !tb[DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT])
> +		DPLL_PR_SINT(tb, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
> +			     "fractional-frequency-offset");
> +	DPLL_PR_SINT(tb, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT,
> +		     "fractional-frequency-offset-ppt");
>   
>   	DPLL_PR_U64_FMT(tb, DPLL_A_PIN_ESYNC_FREQUENCY, "esync-frequency",
>   			"  esync-frequency: %" PRIu64 " Hz\n");

Reviewed-by: Petr Oros <poros@redhat.com>


