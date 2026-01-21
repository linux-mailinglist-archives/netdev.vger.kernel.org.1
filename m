Return-Path: <netdev+bounces-252044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBDuD7EzcWlQfQAAu9opvQ
	(envelope-from <netdev+bounces-252044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:14:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 562E95CF0C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 978437E8AA4
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B945C3D523B;
	Wed, 21 Jan 2026 19:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="VDx4IwOV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E47133D6E9
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769024677; cv=none; b=mx/goa1+DDsjPQHcpR75+qsrWCNjtwNa0Nc32W90PFcVfIWvR2q+g1pzp0LOlCphOYu/sUzmVzrlVxUfHOA+gBBFmIF61YitLI3t58IH5hxyj7S/XCRS3RZWR8HH0pdUCNriUklVlY5Ck63WTYdYIAzAj/wBEfXGadLpqWD95i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769024677; c=relaxed/simple;
	bh=l5SyFJCfo1fQSa9mU6zNAv0ThOth/LCY4pXaeqqK6Go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oIfYUfXPnY/300PT8gN9G3jQ0lRBml1qOOCBKvTaFgPbgmt1hJxtp34z8Tkg/8jIAkBReIGhPClRd8VbO0kJZD3xvrEQwhpBRQQkbaKwxtoO+R8buy1JBwt+4vv4wzNeJEaDYOom9Y8oiiPeNbN2gcesCZAAFg4RxAQJTo1tCO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=VDx4IwOV; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so513786eec.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 11:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769024673; x=1769629473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KEa/Pdcnys+mGuP+b9JWKh6Y2RdyW/MdUrzTT9ml1Mc=;
        b=VDx4IwOVByoLhrAnSWP/KTgkljRYom53Maconcs0m2JH5yAV8OXYCONgsaWZiFCE5A
         1TZOTDFja3sRw+UK8aJJcbvvC3779tVdB/m7wE31EbbOutMwNokHiPNiiihub40d7RON
         yKnPAMXswdZaNjba5hOiT4+CAc7JbquqBGL0BuuT8M8E2URvDBsJlYuGov3q72WNE7Z+
         PQu+nZsJ98Dln5jrsN0X5mFuDvKwu1q+uz0+X2j9hhNKb7CX+kXqxnvXA/vL0fBokcrz
         gr62hOH8kxyRz7sflIMVJDbwA4B+81e3c45UZg3+TQX3SjwsBjPLgVKDCHApPx48EgfO
         wjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769024673; x=1769629473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEa/Pdcnys+mGuP+b9JWKh6Y2RdyW/MdUrzTT9ml1Mc=;
        b=nuuaioAan+OsBItVyIm5DkppBEmKCM/00xw2aMHPuDcSbI+kXpoCH5w5svhTkgNzIh
         D4M2wA3lbx0YQg6ggx+PySbEhk4XP92hqGZ+Tf3boZvQ9UNmzENH33Zsf6Yl6GydzNMI
         eFATTlB5X9NVj/bRxTsAXWtSyqntrOF9kPePPuiqrnaJ5MRFCUdGNN+qZwUkRtRYORzL
         dcKFBosuA0UxTQ5YwRxyGAFtuAEnggwvhWQWqsVwhb9GwL1+GiLmDqHuetfQBoGJb+rP
         RDqSr849KqcMg/CbZbvAFbJII61UgrwgMHzbZ6mZFn55vtBwOMyUSljkY+JrCfo/jOEm
         KWNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhCK4srbZ1Mk0vUBA/FVBEqQp4QshdGMcCNFpAbpj5pmxBYNRcS4b8HQfiigGK+K+qr8RULfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4r6TkRwIG8Sh90+jtax/oxu32g+McFXewTbWeLYnrpUAIXGN3
	k8fHe2WT5VN44MxO1GuvEUX2IMJNNTd2zBKpoL22nkjLzDF/wBRH85lvl2dwOJaA9g==
X-Gm-Gg: AZuq6aIkcAOEsce1luHHlnjKgesMeN1XxtxQ+1GorMdC9c4KMWwbHSrkBnS1v1Ov0hV
	kSrVAY1eUeDDA4asIjJwyWhJrpWXTWzYE+4LzJ7R4ogWB/AVeNNr2PT2VKKiWxK4TeFBpPBGYi4
	R8zbP1G3LaKXdSu7EK/Pu/194Yxb64Uj3bILjRms2vl2wNTSQhI/in48ko8bgQz2Uc1yVmFw0LR
	vCamExF9nTO0vPMkcDlI5uxkm7nejdtATh3dZ0cWFYTrr/uVjN1e605wOQbb/ekVKXoeiyZU9bx
	LuaB/OoGLkUTPJGQYSjd8j08uB9NltQ1fMrJlq9AH04Ov/wB0dnqrJvsIwKm+TlUlrjZm9+AH5N
	Oo7NYZOlC8aFVW5sV1O4L6R3os71jt+sBdyuMY44Gf6g21tEBbimR0PAZRv2sx7IjNpjo5N9l9e
	RA165vFaGiN9/FinXHVBXo2Q==
X-Received: by 2002:a05:7301:408c:b0:2b7:143a:9a8f with SMTP id 5a478bee46e88-2b7143a9e6bmr1628457eec.7.1769024671502;
        Wed, 21 Jan 2026 11:44:31 -0800 (PST)
Received: from ?IPV6:2804:14d:5c54:4efb::1c9d? ([2804:14d:5c54:4efb::1c9d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b71d3d2da2sm2106569eec.6.2026.01.21.11.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 11:44:31 -0800 (PST)
Message-ID: <1f63d057-ce11-4fdf-b9d4-7022ec356377@mojatatu.com>
Date: Wed, 21 Jan 2026 16:44:25 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 4/7] net/sched: act_gate: read schedule via RCU
To: Paul Moses <p@1g4.org>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260121131954.2710459-1-p@1g4.org>
 <20260121131954.2710459-5-p@1g4.org>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20260121131954.2710459-5-p@1g4.org>
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
	TAGGED_FROM(0.00)[bounces-252044-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mojatatu-com.20230601.gappssmtp.com:dkim,mojatatu.com:mid]
X-Rspamd-Queue-Id: 562E95CF0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21/01/2026 10:20, Paul Moses wrote:
> Switch dump/accessor reads to RCU read-side sections. This matches other
> actions that read params under rcu_read_lock(), e.g. act_tunnel_key dump
> (commit e97ae742972f6c), act_ctinfo dump (commit 799c94178cf9c9), and
> act_skbedit dump (commit 1f376373bd225c).
> 
> Dump reads tcf_action via READ_ONCE, following the lockless action reads used
> in act_sample (commit 5c5670fae43027) and act_gact.
> 
> Timer logic stays under tcf_lock and uses rcu_dereference_protected(), keeping
> RCU readers cheap while preserving lock-serialized timer updates.
> 
> diff --git a/include/net/tc_act/tc_gate.h b/include/net/tc_act/tc_gate.h
> index 05968b3822392..9587d9e9fa38f 100644
> --- a/include/net/tc_act/tc_gate.h
> +++ b/include/net/tc_act/tc_gate.h
> @@ -57,9 +57,10 @@ static inline s32 tcf_gate_prio(const struct tc_action *a)
>   	s32 tcfg_prio;
>   	struct tcf_gate_params *p;
>   
> -	p = rcu_dereference_protected(to_gate(a)->param,
> -				      lockdep_rtnl_is_held());
> +	rcu_read_lock();
> +	p = rcu_dereference(to_gate(a)->param);
>   	tcfg_prio = p->tcfg_priority;
> +	rcu_read_unlock();

These helper functions are called with the tcf_lock acquired, so you
don't need rcu_read_lock here. You can just do:

p = rcu_dereference_protected(to_gate(a)->param,
			      lockdep_is_held(&gact->tcf_lock));

cheers,
Victor

