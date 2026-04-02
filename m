Return-Path: <netdev+bounces-274430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMhOKbEtzmnIlQYAu9opvQ
	(envelope-from <netdev+bounces-274430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:49:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 232CB386479
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C01AB301CC76
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 08:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4873C5539;
	Thu,  2 Apr 2026 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ozw5O2zV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMzQV1/5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B343624CF
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775119518; cv=none; b=YYsZNhI61T9wfBYu4qRvPuo2Qw7JykQwWtcoK0KWebzEMvzFMbmR3YYwAjvwoKjNdylsorPFby6nPxj0at6cKpdLYDIwVd7Z37kzBMvbpoFcHFmXMPZM8u47p1sed1llxpheSSLblFMb0TthqAfHrg7XuX5g8nGFfglEkexnIWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775119518; c=relaxed/simple;
	bh=dm+ndDEpOaDOtVRU1v0Ul3uMIWipHNX5gxJnl1HJfOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOGgryFQs+cfh3YS6ATcrCo6a8Lpv2bfuUbRme6gz+f3aO4vStMICdheP8qvV92Aox9aH2tlNf4SxMOMAevKOEM3WWPnlsWOM5omJVC3dnRVM/sV53WYAkse1Ko5W3g/HCLdiT3KFb1hXaALbf4OpSUbfUBNv/i4LoEww3KhUVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ozw5O2zV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hMzQV1/5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775119516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mj5VbSaOpMIAAfwFyDpLkGHz6PUorYL3fNmYF2ZE9cA=;
	b=Ozw5O2zV1Rs4ExqUM6axtBK+TiBH6PgkIbotvTyxdHDTdsDpt50rcFg2fZmK/Pa0DWKI/X
	hqcDShZoWQlGccGG1kVM5Yep12GGnFKpaeATd01r9TWh5kzgLnkMtwbBikBBOKozbzULM9
	B+7XI/7djgO6RH/hyaa4Jv3cRDY5sCQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-Bk6fWGNLP1qHbrAhi1aT4Q-1; Thu, 02 Apr 2026 04:45:13 -0400
X-MC-Unique: Bk6fWGNLP1qHbrAhi1aT4Q-1
X-Mimecast-MFC-AGG-ID: Bk6fWGNLP1qHbrAhi1aT4Q_1775119512
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d02fa5860so653965f8f.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 01:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775119512; x=1775724312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mj5VbSaOpMIAAfwFyDpLkGHz6PUorYL3fNmYF2ZE9cA=;
        b=hMzQV1/5Kgcgzv79ns5TBjBbIIh4OebjYKPmgaf/GTJ5+eW0R8OZnrpc1G9fq1+P36
         LuzjBbz/pXgx67slP9rpE4e7LLZrEqE/fVORgk9DYXaV15sB+dJ6Wu90/1eZM8F7GMtA
         B4XtHby5pZA2kL1kyxmSwf+1b6FhvSPsx9LYz6nFelpy2JPO31xS1VrLLA0v4yPENZZS
         4e12A/b3e8JbqVoznf0nJ3XXA6vWLvA529IOHVpm7CMTRG5QR3mFgnV25lzkpgh63GxN
         DKwT2ZSvJV4zZ98fDEdaj1T2a/wDZ6gb0xgeRl66rh1jVAAtvVSUXwG7bWtX9Zsbfqfy
         uf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775119512; x=1775724312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mj5VbSaOpMIAAfwFyDpLkGHz6PUorYL3fNmYF2ZE9cA=;
        b=DHcjuvtxhbfhdm4AxvYwmQ7a9sqSOtZ4R6FN7wodMNZdzDbFqk84uMaPjITdzi+EdD
         BDnR32jKe9Vecblhu8tjlAGy3CRBB6vH8RIshiPRSzOZW/c62p4CavXS8WCvwx2lQYLP
         8CKAL47Yhc7YLF3v6oIYO4hgD1Pvce7d+5wORKDbhc0EaK0d80Rgi0Aci11MYGywzh9j
         +MxJOgIwUqeGSmlMh+g592HhpN623kGQHZgtXaML/FX3bTo5DqNmDPRzBC+nUjkDYIJw
         smcG9CAbm2uG7Arfpo5enjf4mdY6R3CB7DbSM2CrSsa0hiEQLxVnVB1G5M9G6Xck707R
         GQRQ==
X-Gm-Message-State: AOJu0YzL2xrF5QSvR7JY9Dzzs8UESAkhouT4YRLxnKi6wBfCQSNXiUm2
	AK+lcMvgwbnw4tboAEH4hLd6+qFErDLWc9g1dVw4VcxNGEsVPxTtvEhHc4FEK5O/5jSfv3tJ6nP
	gbgHsg/c8FLRz9M93W/7SSLp/hupKNEgX1GzJy2TemcQTn7wn2VoDoqzDoQ==
X-Gm-Gg: ATEYQzx0kTwWrBug2BieBcfQ1k/KNONHFsZfRBLzjSXKGatdQpJ/APvB3vzQa3nO16u
	xL6Eq3Oz0ghJpuHjV/MBhScRK3cDtFtYlndNx7qWSg0+WtH2mMex5i8V3PVSYDW5XUO4E8q5S51
	WmEfJEvULOFGdnBveB+45P2a/U4b/xMNV5zyaJV+Zu4X7jQIDrXAocVZ+3pYeQO6pRIq0Z12LGP
	eo1lV5ekXk4zTG2Y/zIrPtk+0DfEV9pCLOO+D/PoJlv1KDzUqQ4/yL5lsk+30I1gegJhj0zk1di
	mc7ZVORzNNUwKFsV3HeYQlKQhQJ5uUeypsyjFVyCyiyu2uatZtwQBLi14zd+h3B74jx92UqQgW+
	/lfdqNYw6dQCU3XZSfrIqlVXFORvuSUmv/E32MLrNChPDBtfGpX3lrFmAOA==
X-Received: by 2002:a05:6000:2409:b0:43b:6a16:17e with SMTP id ffacd0b85a97d-43d1505b105mr12337379f8f.11.1775119512050;
        Thu, 02 Apr 2026 01:45:12 -0700 (PDT)
X-Received: by 2002:a05:6000:2409:b0:43b:6a16:17e with SMTP id ffacd0b85a97d-43d1505b105mr12337306f8f.11.1775119511517;
        Thu, 02 Apr 2026 01:45:11 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d58e5sm7487535f8f.23.2026.04.02.01.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 01:45:10 -0700 (PDT)
Message-ID: <5985db57-e992-4786-9f9a-cb863220a0ea@redhat.com>
Date: Thu, 2 Apr 2026 10:45:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 6/6] octeontx2-af: npc: Support for custom KPU
 profile from filesystem
To: Ratheesh Kannoth <rkannoth@marvell.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, donald.hunter@gmail.com, jiri@resnulli.us,
 chuck.lever@oracle.com, matttbe@kernel.org, cjubran@nvidia.com,
 shshitrit@nvidia.com, dtatulea@nvidia.com, tariqt@nvidia.com
References: <20260325072159.1126964-1-rkannoth@marvell.com>
 <20260325072159.1126964-7-rkannoth@marvell.com>
 <20260327133036.GE567789@horms.kernel.org>
 <actCysjPKrnzExJx@rkannoth-OptiPlex-7090>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <actCysjPKrnzExJx@rkannoth-OptiPlex-7090>
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
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,davemloft.net,google.com,kernel.org,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-274430-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 232CB386479
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 5:43 AM, Ratheesh Kannoth wrote:
> On 2026-03-27 at 19:00:36, Simon Horman (horms@kernel.org) wrote:
>> AI review flags that:
>>
>> npc_load_kpu_profile_from_fs() calls npc_apply_custom_kpu(),
>> which returns early if the following condition is met.
>>
>> 	if (fw->kpus > profile->kpus)
>>
>> Does npc_prepare_default_kpu() need to be called before
>> npc_load_kpu_profile_from_fs() to initialise profile->kpus,
>> which is 0 by default due to profile being allocated using devm_kzalloc()?
> simon,
> 
> Thank you very much for your time.
> 
> The v9 AI review has raised the following concern again:
> https://netdev-ai.bots.linux.dev/ai-review.html?id=f29b81fe-bb3f-4902-85de-8271effbb41c
> 
> "In the filesystem loading path, does profile->kpus need to be initialized
> before calling npc_load_kpu_profile_from_fs()?
> 
> Simon Horman raised this concern in v8 review on lore:
> https://lore.kernel.org/netdev/20260327133036.GE567789@horms.kernel.org/"
> 
> would like to clarify that npc_prepare_default_kpu(rvu, profile) is invoked
> very early in the flow, and therefore applies to all execution paths
> (default, filesystem loading, and firmware loading). Additionally,
> if the filesystem loading fails, npc_prepare_default_kpu() is invoked again to
> ensure that all values are reset to their defaults before attempting to load from firmware.
> 
> Could you please advise on the best way to address the AI review comment?
> Specifically, would you recommend:
> 
> 1. Adding a clarifying comment in the code, or
> 2. Invoking npc_prepare_default_kpu() again just before npc_load_kpu_profile_from_fs()
> 
> to make this behavior clearer?

In this case, replying in the relevant thread is enough - AFAICS the AI
is allucinating quite a bit with this comment.

Sometimes adding an explanatory comment nearby the relevant code would
be better/more clear, but I think not in this specific case.

Thanks,

Paolo


