Return-Path: <netdev+bounces-252048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A70J707cWnKfQAAu9opvQ
	(envelope-from <netdev+bounces-252048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:49:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1470E5D953
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0BCB4E6360
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106DC362141;
	Wed, 21 Jan 2026 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="OpGS25re"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB15350D5E
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 19:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769024857; cv=none; b=CREdsuZwLd5tBgZZECHh3Ybm3j4eKu8uIIyO+p6GD1fbPeDlF0MLkDh5PXxrQiKfq+MYhBwyWjYAd7B+aVWU11wO9vE5baIzcmkCJICqxPjrGYwhMh73PqsGv0Yot47Ncpny17AfRDI104DChN5xEWoGGF1EHxiagOKaY3RpVe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769024857; c=relaxed/simple;
	bh=orzjDnZyozRaJvwCpqJ+jtvJM5mx9ik0LsEMc44wRrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lQnPPSFB/O8M71dRnTMrjNGseagfWOruoIhlhKxBURVCfTPBodQ9ojha8uyl81TI7b5GYf1TNW7kjf4cZeUtvjfaQTx/CW3PynCFS5jCRIxBiNxiTDsT6wu5UCiTueFFrFsANOo2xHrNTM1U89K/a2OjXIu5/DrnVbaP6ZaF+0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=OpGS25re; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12339e2e2c1so157757c88.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 11:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769024854; x=1769629654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ghQ1KD4bD3UuMNHS90xQzdAHsii/uYgvSXFMZHQgAwQ=;
        b=OpGS25reeIVL229DD6aBx+eu31A+v4FeZpRy5frVWoJ/rFNOn3/X3nu54fJop8yKml
         lVqh+E2jaw/N+ZQd6fdb1i4mBxbc1BbTbeIqFdnIBIKQivhfXXzwJsm2SgY+izX4ofeE
         wzXCuzXlQAqLe0zGjsX3hxcGOAr1oB064ToxNiB6yWPamk8X1lgej7YoL3wb5guhYrZG
         7OWT0K7o9F+jxdyapZvQhYxF15JIsBMd/fS5RSAfYwYvBF29g0PHC0IP7GI61pShd3tt
         ECTsoasbouoFOqs/dd4lC10Cnm5rsYnjhiXiMncLYx+WMxRlSipi5n6VnwxmPqWpNJTu
         r9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769024854; x=1769629654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghQ1KD4bD3UuMNHS90xQzdAHsii/uYgvSXFMZHQgAwQ=;
        b=xLWgPfmLU4w2NRHTTYd1Ailc2L7a8aOo5Fti49tta4KtvZ+a/+EL9UBkuqt0Xxxg91
         3+p97PuQV6disNFk6DTzoXBeVLmODubd9dHqVx0LCDa6r/2NBAHOVUbx9rbnOpSEJBhL
         QogT0AwrwMMaYGEYZErLJ7tGbtxV/XzmJTgyqFkxNToPtKhi0cus9L1UjvreAve9Tyqs
         vKwwu0FcE2DvNyED1UwJCX5Rdjy+mENGpw8YVHELdPcZXM1jfFO6bzR6jaOeRXNdfYFg
         Z2a9ovDgiWLS9o5QK6cGAaQUBim1j1QcUA7vP0N+JV0F5p7V/xEky7pgwC0Y8FR6j5qV
         iPnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXENyhobMIjzpB0krUSE0G9E+mRBvmyHReqYcff/c+IvF5NIw5R/tGs/WRizEWyllq3TaZ1SNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjr2YnhapdOQCpls6xQx4gjNQYO8LRJX0B2OV0TgewIyAR1f7J
	HUGxXP5RZ05Tig2Uai51DgUJ0WQPdHi7fUSObzCOiBXPJ8uz2lrjL8Qg9bXS+OIfOg==
X-Gm-Gg: AZuq6aJj5Hf55lp2UIeVjOcqZxGb+Ji/nklhvCR6JILmvwp5XBMs8IrY4Xp63QSd0l/
	afoxH8sIa8W/4HrXUabBK/t/68VVwn3ZMRjpQmAEppiHxoYgeUiOIRXMPDo1ONCsYKaX333j8TL
	HABGtdMGFJODUvgei2oGsNWRwVm/BDTCSNOzhSi4Z3N1r+3z3IWO9A/EO8jF8fX6kazSheU7b9D
	73avfAisOutQf6KMf1g1U4OnxoQIChGqRRuAght2vtwkMoztmwP3klsOvE7SiPRtMd4O0NXP2vQ
	IcTCmaAjF+zDq/3Q2mZUDZbs5VC/USkSGrwYYVgGCh5E32OtEURYtvYgPbUSSsgQ4VJtiWrirMO
	eU0KKkvGFNLd0/+WDRlYDKjVw7rtFl3Xo06A6FhlXkoG5sbeFoFCAh1k84Cp0/Zvvvbm+FvrfjT
	BWhQcjR8WDrftFhOspujX5qw==
X-Received: by 2002:a05:7022:2390:b0:119:e569:f84d with SMTP id a92af1059eb24-12476a6d462mr351429c88.4.1769024853578;
        Wed, 21 Jan 2026 11:47:33 -0800 (PST)
Received: from ?IPV6:2804:14d:5c54:4efb::1c9d? ([2804:14d:5c54:4efb::1c9d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm22276230eec.9.2026.01.21.11.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 11:47:33 -0800 (PST)
Message-ID: <50912945-9da4-40c8-adad-34baa2b1e81b@mojatatu.com>
Date: Wed, 21 Jan 2026 16:47:27 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 7/7] net/sched: act_gate: guard NULL params in
 accessors
To: Paul Moses <p@1g4.org>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260121131954.2710459-1-p@1g4.org>
 <20260121131954.2710459-8-p@1g4.org>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20260121131954.2710459-8-p@1g4.org>
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
	TAGGED_FROM(0.00)[bounces-252048-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 1470E5D953
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21/01/2026 10:21, Paul Moses wrote:
> Guard NULL params in accessors/dump/timer paths to avoid crashes during
> teardown or failed initialization. Other actions already guard params before
> RCU cleanup (act_pedit, commit 52cf89f78c01bf; act_vlan, commits 4c5b9d9642c859
> and 1edf8abe04090c), so act_gate should tolerate NULL in reader paths too.
> [...]
> diff --git a/include/net/tc_act/tc_gate.h b/include/net/tc_act/tc_gate.h
> index 9587d9e9fa38f..8c3309b0dd779 100644
> --- a/include/net/tc_act/tc_gate.h
> +++ b/include/net/tc_act/tc_gate.h
> @@ -54,12 +54,13 @@ struct tcf_gate {
>   
>   static inline s32 tcf_gate_prio(const struct tc_action *a)
>   {
> -	s32 tcfg_prio;
> +	s32 tcfg_prio = 0;
>   	struct tcf_gate_params *p;
>   
>   	rcu_read_lock();
>   	p = rcu_dereference(to_gate(a)->param);
> -	tcfg_prio = p->tcfg_priority;
> +	if (p)
> +		tcfg_prio = p->tcfg_priority;

I don't believe you need to check for NULL in these helper functions. From
what I understood, the only place setting this to NULL is the cleanup
callback. You also won't be able to run this in parallel with the init
callback.

> [...]
>   	list_for_each_entry(entry, &p->entries, list)
> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index e4134b9a4a314..65b53cbf37e67 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c
> @@ -82,7 +82,11 @@ static enum hrtimer_restart gate_timer_func(struct hrtimer *timer)
>   
>   	p = rcu_dereference_protected(gact->param,
>   				      lockdep_is_held(&gact->tcf_lock));
> +	if (!p)
> +		goto out_unlock;

Also don't think you need to check this here.
Unless I'm missing something, cleanup will only set param to NULL after
the timer callback has finished executing.

> [...]
> @@ -643,6 +652,8 @@ static int tcf_gate_dump(struct sk_buff *skb, struct tc_action *a,
>   
>   	rcu_read_lock();
>   	p = rcu_dereference(gact->param);
> +	if (!p)
> +		goto nla_put_failure_rcu;

I don't think you need the check here either.
Take a look at act_vlan.

cheers,
Victor

