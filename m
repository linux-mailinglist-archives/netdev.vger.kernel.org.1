Return-Path: <netdev+bounces-303229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gElzJxrQQ2o+jAoAu9opvQ
	(envelope-from <netdev+bounces-303229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:18:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9606E552A
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:18:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=h20HlIjE;
	dkim=pass header.d=redhat.com header.s=google header.b=Bl03F6d7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303229-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303229-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94E2830E44BF
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAC93ED5DA;
	Tue, 30 Jun 2026 14:10:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955F4374A07
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:10:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828618; cv=none; b=ssxH7YFA5biEMaMgZtVJFOcWtPvj0/M6OCGlHX+l0yECyfw+hNBB3d4OBlPH6tNkCR2t1Rks9FDJHen0pRJEQjJT8cYV52Jsu/VvOwW3BOrJSBNe1KQYDiDJ7YJudZFlDWVZy+gUBJQmizr05B5xZtB1KLayU9isVQFiG0YTsQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828618; c=relaxed/simple;
	bh=/wypLRgPYUhUm8w1lzxMnTMb4D5cfhEnCejHG8k/hTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D3wkuYvEyIOTDaSl0mxBe56E8SJMOUoyia5FEgTXUMhEuTdBqO1+czcVTg2lKt61dXYDZ6Ko3v1trpLp9loc97C1H+IAtuWAr55Ux3njMDG7PmaKk/yJHpXxUADjpB+CXMFmnrNN5V6TlutgU+4ddAxsPNWa1ac5L+oZ2uWMAUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h20HlIjE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bl03F6d7; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782828616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BFDdj7mBxvpQB1df0Zv0Bo5GXWFLdAHUl/QXNj3kRfg=;
	b=h20HlIjEA7NbHjBvLt5zLS77HyuASx+0uZNN9MY8Y/XCJHUPLW+G7nHBl3L6Jr0h6+HeF3
	2eR+S1E+qCLGMPF3PjJeHeP+sNykM2a0rJeL9oWuyJ8X2s+gOMOv3VF/CAzc28rDMJleWg
	qBOASnAr/IprFsyllt9/3iQ+NoySknM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-xD4EZ8xoOkyjMzAQLEDG4A-1; Tue, 30 Jun 2026 10:10:14 -0400
X-MC-Unique: xD4EZ8xoOkyjMzAQLEDG4A-1
X-Mimecast-MFC-AGG-ID: xD4EZ8xoOkyjMzAQLEDG4A_1782828613
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49244130073so38238235e9.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 07:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782828613; x=1783433413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BFDdj7mBxvpQB1df0Zv0Bo5GXWFLdAHUl/QXNj3kRfg=;
        b=Bl03F6d75Sadz8/djnBa62uP7Zk3opI7XIZ5LYa8InPxAFyyAnO2zXPKXJHI9nFkmQ
         Kt3yVNELD2EVtg4S3Wn73Ducfr2ILcI+l2XIPqLf6OHN+GLQViLE7Cy6vnCm0w1JD9yS
         ux9XM9Ub2HTbD6X7LDCAd8mF093VYJrct9wJngklVBmYn9Lom90Y4rIDtlxzP1FZvvof
         +MSvv/avG5f/at6EJMYBHSp73j5fv3l18daWOv7oIvlFr4YYajm7OPXjwmgRG5ML2eyB
         IXna10V/+v+1K+T8dmdpLrydyOfXO+7yiQVaieEogFYZADc5yzQdF3nz6HA0e+3R/6Pf
         AUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782828613; x=1783433413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFDdj7mBxvpQB1df0Zv0Bo5GXWFLdAHUl/QXNj3kRfg=;
        b=CQxDT7VPmw4+IHOs+IIxupaCnC7NKYbZBg+KCFp+3yodGI/6ptCJ3uAQTNiCS8a2C1
         uQy0AAGK2pEan6TgAhSjlrq2cR+2jnEuj0kO88oUYxIXLQcuRiR5wABFqLuxckUXFIHS
         LJU+Ie+Be0itD9w8pDbdUgt6tYJEaO3Ls89pz39SbyJY6WcCqSQlHDQ8gXlnxpufovQG
         iCF0iaq0z1lPZCRvRJHJ1MMCG9Z5PSuLU0OL0cMoJSAsHJbrt7icPEucrBAlESmHowfk
         nMyEtfHurpbavEB49+7KXArlSSpx6Xmm8rI8ELOqr++JgHWIPGcsCvqRYBG8qJFxJ0o2
         /Iug==
X-Gm-Message-State: AOJu0Yw8KuoP6z/SJO934JpEMa+NA26uSFdtftymeYbW1f+dMyo0Dx0L
	FiEtFeMyZ3K/N9uYSeazFlbh1dEG774gGJFAt8qX0ltCN8X33GUvGhbBHegXnj3tGV+PtNYvDy+
	L9pvp+ss/76T0HXD96oXxysLKT7GFnxmWxnY/xZcp+wkmZis0cGgrgFfL8w==
X-Gm-Gg: AfdE7cm/EOlgQ5f8tms6V+PHoNUPim00q8ZQ4T34/fSdJM4PhjISlxYseKd+aKWeKoz
	u1j1AP44mChUkH9duXzn1LhL+ZoFsWij25NM0G2KHcPkHd2s5M5NfCCItWq1hgOv0I0cV59uk+l
	Ur5zt1bdtaM92DIIAa6ZctK1coNBNCneFcZMJZJYYRoxBeo7R+zvF1If4WhVxOc9K2MwdQXFboc
	HsuP9kUPhcGITLlVGyriKGlqQkBSLncxWBhWHqMA3dSwp2RQWVOOONL8UHPSmBQQz/fCy0nsKPZ
	yZVUdXiZzhSM2Y+OqoKXIHhCAxIj4C3UXW/MKDPPtNjbJ+UF/LnAYL9lqT6JlDtBNUlNIaaJTwi
	aokZvOwrL3UfCtuSUCri2rO67Jz66cupIP3s3j2OCe36lovK8VyR6q4Miuu5dj/vICjJMLCwuQb
	wXvurQVeegpA==
X-Received: by 2002:a05:600c:4747:b0:490:a1dc:e542 with SMTP id 5b1f17b1804b1-493b827db4dmr55140245e9.6.1782828612894;
        Tue, 30 Jun 2026 07:10:12 -0700 (PDT)
X-Received: by 2002:a05:600c:4747:b0:490:a1dc:e542 with SMTP id 5b1f17b1804b1-493b827db4dmr55139705e9.6.1782828612365;
        Tue, 30 Jun 2026 07:10:12 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8c79baasm74104705e9.7.2026.06.30.07.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 07:10:11 -0700 (PDT)
Message-ID: <3dab7c8e-aed3-41f2-97e0-558c7a82f925@redhat.com>
Date: Tue, 30 Jun 2026 16:10:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/1] net/sched: sch_teql: Introduce slaves_lock to
 avoid race condition and UAF
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, victor@mojatatu.com, jiri@resnulli.us,
 security@kernel.org, zdi-disclosures@trendmicro.com, stable@vger.kernel.org
References: <20260628111229.669751-1-jhs@mojatatu.com>
 <de40b1a5-663e-43ab-9fb7-5a49f029cc4b@redhat.com>
 <CAM0EoMn-6Ayjd3mxsiifDXwN1zdefx9eiRk_wWRpsuEh22LziA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAM0EoMn-6Ayjd3mxsiifDXwN1zdefx9eiRk_wWRpsuEh22LziA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303229-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:victor@mojatatu.com,m:jiri@resnulli.us,m:security@kernel.org,m:zdi-disclosures@trendmicro.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,trendmicro.com:email,mojatatu.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB9606E552A

On 6/30/26 1:49 PM, Jamal Hadi Salim wrote:
> On Tue, Jun 30, 2026 at 7:15 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 6/28/26 1:12 PM, Jamal Hadi Salim wrote:
>>> The teql master->slaves singly linked list is not protected against
>>> multiple writes. It can be mod'ed concurently from teql_master_xmit(),
>>> teql_dequeue(), teql_init() and teql_destroy() without holding any list
>>> lock or RCU protection.
>>>
>>> zdi-disclosures@trendmicro.com has demonstrated that the qdisc is freed
>>> after an RCU grace period, but teql_master_xmit() running on another
>>> CPU can still hold a stale pointer into the list, resulting in a
>>> slab-use-after-free:
>>>
>>> BUG: KASAN: slab-use-after-free in teql_master_xmit+0xf0f/0x16b0
>>> Read of size 8 at addr ffff888013fb0440 by task poc/332
>>> Freed 512-byte region [ffff888013fb0400, ffff888013fb0600) (kmalloc-512)
>>>
>>> The fix?
>>> Add a per-master slaves_lock spinlock that serializes all mutations of
>>> master->slaves and the NEXT_SLAVE() links in teql_destroy() and
>>> teql_qdisc_init(). teql_master_xmit() also takes the same slaves_lock
>>> around those updates.
>>> Annotate master->slaves and the per-slave ->next pointer with __rcu and
>>> use the appropriate RCU accessors everywhere they are touched:
>>> rcu_assign_pointer() on the writer side (under slaves_lock),
>>> rcu_dereference_protected() for the writer-side loads (also under
>>> slaves_lock), rcu_dereference_bh() for the loads in teql_master_xmit() and
>>> rtnl_dereference() for the loads in teql_master_open()/teql_master_mtu(),
>>> which run under RTNL.
>>> Pair this with rcu_read_lock_bh()/rcu_read_unlock_bh() around the list
>>> traversal in teql_master_xmit(), so that readers either observe a fully
>>> linked list or are deferred until the in-flight mutation completes. The two
>>> early-return paths in teql_master_xmit() are updated to release the RCU-bh
>>> read-side critical section before returning, since leaving it held would
>>> disable BH on that CPU for good.
>>>
>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>> Reported-by: zdi-disclosures@trendmicro.com
>>> Tested-by: Victor Nogueira <victor@mojatatu.com>
>>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>>
>> Looks good, thanks!
>>
>> Please note that sashiko/gemini found a pre-existing issues which may
>> require a follow-up/separate fix:
>>
>> https://sashiko.dev/#/patchset/20260628111229.669751-1-jhs%40mojatatu.com
>>
>> (the 2nd one in the above link, IDK how to generate a direct link to a
>> specific comment)
> 
> I just sent v4 which covered that but i will send a followup instead
> if you already applied.

The PW bot is went on vacation and no 'patch applied' notification is
reaching the ML; v3 is already applied.

> BTW: What is the ruling on when Sashiko finds a pre-existing issue?
> Should we address that as a separate follow-up patch? It is unclear
> what the policy is.

The general guidance is that pre-existing issues should be addressed
separately.

> This teql patch was one of the hardest to deal with in terms of
> reproduciability and the fact sashiko kept coming up with pre-existing
> issues - including the one Simon and I were discussing. Note: None of
> the pre-existing issues affected reproducibility at all although i am
> sure one of the AI-kiddies reading the sashiko reports will find a way
> to create a poc (this is why i entertain fixing them when they look
> simple enough)
Not an ideal situation both ways (which is increasingly the case).

Addressing incrementally pre-existing issues can lead to an huge/endless
number of iterations when touching some unfortunate area (4 is _not_ a
big number ;) delaying the actual fix indefinitely.

/P



