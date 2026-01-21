Return-Path: <netdev+bounces-252045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMkGJhkzcWlQfQAAu9opvQ
	(envelope-from <netdev+bounces-252045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:12:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1D05CE6C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF0579E49D5
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F92B3C1976;
	Wed, 21 Jan 2026 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="m/gLvpKm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A7530F94B
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 19:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769024702; cv=none; b=PfsygG6amPwv5BzpPE+ublvc/DXJFaqMQvo3FtGSYCuJq6KvY289jN/vF6AYgZ7S0T74GeJGhI6QU/fBFsu6dsVrOdBYR0OHaWK4iE3EhBvDyH7Kl/ZsK9Ok/Koi5ZmOUI5Spb4h7cMtNRj6yhGErnkO4XTsZFvj1N+OTfN4ZtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769024702; c=relaxed/simple;
	bh=ykOJXdnRPdORkrcuM4LDP6Fwb8+CG51exR/43qlXuAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHEEQnuDbpFYsff0CnEIZ66Mp7HbmU0mOZ/5+uB+UPogixqEjqXixXCskmBTHKNxPwVUZwsNTsKwr392lxwIe1A2zUX4KURMX5EsZVTK646Vsz5TSAP++g55QN+WvUAKw3WAgN+4KVBS5lxAtoj5P3Tg2zkJlsJXhcB1SvO2AqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=m/gLvpKm; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-121a0bcd376so586995c88.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 11:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769024698; x=1769629498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ecdrB4zSMEy5aBv8OAslEgazFoiJdmaPpZodoGqi+h0=;
        b=m/gLvpKmxspQ32YdnwcEX3KVnmdoNdVcKjtGLCVlDThBtYQeXf2g2V8FCjkPFrDEEO
         b198E8/2c/OLB9rKKApQoKfzavgUvp34diP7qKde56/X6wYr4KtE52H3SIZr3HE/1Vc/
         3J4+qe2OMoEx7W4IHxqyKcGspaRMItEoD3WEbaXDG8711dmKPILy8S50XcTfhkJpXkyE
         3yXlrxQXIF3KvYap/jbNy1EYv1y7Ev52fK+5mGiQX1SylTaGJmQOCSP4fymRafPiUjkx
         loR88taQbXx9jq2jX0mbJWW1Gw0ByfMgYzPsgfKLIsLPQjxaBGTokOx60uvX0lzAaeYz
         VGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769024698; x=1769629498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ecdrB4zSMEy5aBv8OAslEgazFoiJdmaPpZodoGqi+h0=;
        b=hDWvDZhHn43OxrOS4PvtMV9iKoZhb5z8eOAUoWsAHsXYgkUGfb64nX+HSRFhnW85O5
         7Ts9NfJzbIVIGtiE2rzo3eolWVvAjXxpuIi3OkdoOqfoiB7FrurpaAUP0bLBfYQP4Pp8
         /TvGsAW8yhcm/VDhYwUY2YYZ5AxijlHsyetFKgN64qu3NpsOg2zw1tTCov0AJwp6GrUX
         on85TF99lXYGMhGU3+6FRmVyN7+dh28iUgj6K3onwmBpMTSK001uHLAUCpwJN57jkjsP
         lS0FXgrw3TZDBqsKD2+cKg+0dcOYGWLNxK1yqzbo4pvrFP+rFTFxhFPQu4d8Xjn+MStB
         fMtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQnA1JqZukJeV2Xh8xeW0d6Ol/rcDahzSobZjQFtUC8G4JuhFz+1XS6jFCoN4r3BIgASnKSsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQJJCG193bMUP0NvbL4H/JhD67sUym9N2oRuUEtw7mKlbEw5yT
	Jup95m6LVw+hy5gPbfmoNGjoqu9KTZJ2PCXS+UqtV+Od1He4MXLGSX+4Djp0wKA55w==
X-Gm-Gg: AZuq6aKLas0b9tD9ri535yRbAJxymEbf9ZwRn9takTNkmdeAA17YC6IdRxH7KyzIySd
	Lxe7YMKtVCUr8oFKnDFhhpexNzUROtJx5o6rp8dayMQ6yQ9LesnwFiqsv+LX3vOWeM2tN2N2Ukw
	oBVate3w9G3xTwu5dG5BBJ1erK03Jq6WO/xXjJ4Pia7Xr7yrjp5eIbhOGQbepo4tP3sd4eROPFA
	mgzlwr3ZyzGFdaBCFLvybAOF3MEyi474RdEh4MxvCLZ96eXT1plzt2sC4jobzfuvVPqMukXnWNZ
	iRUhTI2XdVmcLM+umyuORDXxZnqwbkJqFxUWoFLa6jAOVgKGX4oLSvmGKhvHDyCjYNwnK7QzXr6
	vFaygscUmw1Ak/QAZkLxQFLhiqXhE08pJrqBzul0ysM3Ss0mjC548XTu3DKmFJxbRg8a21OTLNm
	AQum+DT0zdK49Zitkg+FeqDQ==
X-Received: by 2002:a05:7022:914:b0:119:e56b:c75a with SMTP id a92af1059eb24-1246aad1e60mr4237514c88.31.1769024697979;
        Wed, 21 Jan 2026 11:44:57 -0800 (PST)
Received: from ?IPV6:2804:14d:5c54:4efb::1c9d? ([2804:14d:5c54:4efb::1c9d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244aefac48sm23814082c88.11.2026.01.21.11.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 11:44:57 -0800 (PST)
Message-ID: <c8a8ae22-c5c4-4112-8084-0faa256a1d84@mojatatu.com>
Date: Wed, 21 Jan 2026 16:44:51 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 6/7] net/sched: act_gate: reject empty schedule
 list
To: Paul Moses <p@1g4.org>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260121131954.2710459-1-p@1g4.org>
 <20260121131954.2710459-7-p@1g4.org>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20260121131954.2710459-7-p@1g4.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252045-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:mid,1g4.org:email,mojatatu-com.20230601.gappssmtp.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: BE1D05CE6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21/01/2026 10:20, Paul Moses wrote:
> Reject empty schedules (num_entries == 0) so next_entry is always valid and
> RCU readers/timer logic never walk an empty list. taprio enforces the same
> constraint on schedules (sch_taprio.c, commit 09dbdf28f9f9fa).
> 
> Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
> Signed-off-by: Paul Moses <p@1g4.org>
> Cc: stable@vger.kernel.org
> ---
>   net/sched/act_gate.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index 48ff378bb051a..e4134b9a4a314 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c
> @@ -509,6 +509,12 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
>   		cycletime_ext = nla_get_u64(tb[TCA_GATE_CYCLE_TIME_EXT]);
>   	p->tcfg_cycletime_ext = cycletime_ext;
>   
> +	if (p->num_entries == 0) {
> +		NL_SET_ERR_MSG(extack, "The entry list is empty");
> +		err = -EINVAL;
> +		goto release_mem;
> +	}

It would be simpler to check this in parse_gate_list.
That way you could return -EINVAL there directly
in case 0 entries were passed.

cheers,
Victor

