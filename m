Return-Path: <netdev+bounces-292677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBKNNo00GGpwfggAu9opvQ
	(envelope-from <netdev+bounces-292677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:26:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DDD5F2116
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DF0030E61F8
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1B03EA964;
	Thu, 28 May 2026 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="MP9YBZXZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A353EA94C
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 12:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779970914; cv=none; b=owxZko9UvAnnMI5AARLC4Vnh5VCQFJE4Cgx5WswhB7ywkoQnCeM/PmneTMz9VBFIMe9BIdtuRdpAvx38rLSn/XGFGk/TZ3IQuuDORM/aBVRdfqCdxiYvV4sj4K7Oige5IIATe/NXTTtabi3laoV1jksRuG95FwdtkLw8DgK71KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779970914; c=relaxed/simple;
	bh=r/xRTvDmxUrMGi2cUdcEZxCnG+w/nGbYyEkayIcnEpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZypsuhT9DoTk7u5Fo0xI0W7KjMOHPx7Y9n6ZHwFtse/HHvtJXg9w2CPUb0hjHtSZh79a+gCp8gFblzndoD4g88oMrTyKLClLX3oyNdDU2BdwcqYZQUh3pWEz9iOKhbQZPKOAQ/AmQe7jV7xDhmRKCWMDYwbIx0tEoWNTAfmZc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=MP9YBZXZ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-911501a99feso1497603785a.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 05:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779970912; x=1780575712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qWTfesN9KCRH9+LNadr/5Hlv3PT9cTJjJ4q8AqB8bQ=;
        b=MP9YBZXZT5PP0YwwJFzqE+3HXU5uC5cuq73u4r8sYqhiD09rD6JiCWL7N45sEZCSFt
         b+UByOsc/dwkBXdUl2EkiZ0AafwazKek+GEHGU6tTCbuntQ7VfzLWjbbTql8AvUgYGgc
         vN/1V6/PEa7m0D2bSJOMwwPHLSymXrPTj2RMDIHN8Mu8RPY6ZODPvo/nUlSQLRtZTE6A
         SaQyiAkq/56oWNL4YYuNPm5f5iNGE+Dy3g+3fvMM/iiQUEu1gMFAiYdiSeEoXCXfOZLF
         TMHKw2ELvm2QXiYitTUDTE6+UNI3A5dMKeZth57zGFoaMERG9k4pthqlctNgEaVxtHMq
         JC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779970912; x=1780575712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3qWTfesN9KCRH9+LNadr/5Hlv3PT9cTJjJ4q8AqB8bQ=;
        b=USybsUTRNRLHVQciQo7HfxEP4iEfTZTvcz2QewdG+WKmZqpvi7TvGpwZ2Y326aask3
         VwvbPWN7jwFQtbb7juJ7Q7l8GLy1xG9Sy7oO7MYmcvbxKei3tkuJq0Mg5rqC5mqHGCZv
         h7CX7SimFBfK9NUKr0JZEDm+bxG/hm5oYY8GbMbCvsH+kHa6n+p8PfewDHZ7c0z+cNO3
         MfdB/BQpEJ03gEmX601amX/YKCgu0M2SYIJCaNbitVvzdIf46KsBoREm71dUDKmAB0CJ
         0hLVTbx0Djch+HN1YH1UvHfmS5Oa4kdQhvboqQjqZA3A36Jj8DDrOjxQktVao2KEnvgy
         pcwg==
X-Forwarded-Encrypted: i=1; AFNElJ+uNNvCa7rhNuBcGau7ep+KpMVWekxVMGW3EFYT459lrsH4UYUokGui+3t1ZscPWE+1ULNeK4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytod1l2EE0TRQs/ZRcOtgWNdDKCjhxtmAauOuEIRr7MSBqBibL
	AuU9jsuTa4MaFoWE2TyCLwBCqI0CfwENIEvOhYX3APOHFcK4HmSmXA9SRzbf+GyHFvIXyw/wtic
	yehHq1uqz
X-Gm-Gg: Acq92OGjRQwsaXZXLue0T779G+7zV1koytaGBziw0EFIAaLD9ZGLmAgg4aZ9lvv+rhb
	0m/dMuq4t5bDYDRoCeOyb+3w55eez88DX5KelLlA+fRk3Y+cA8tVKDZB7DjG8Tddn/TcMxqZOKG
	Q9qusCQ7MkX/y5ykAYEe9KTmbFv/ZWlKbysDdofumqBMr1iYNQkSVv1IFdw0TBX33yezk3Rl7xV
	ldQ24DP2UF6MvjPcksYdGGeYNLRFkfod32bSPIo4uX7WVH7Oo9ouLOZPtvs7Ss5Q/CSDvcTrAUW
	gMuoYtSOEi4ci8qA6JHnDps+c3YWAz8BSBr6TsO0OS6krrNiA6poD7Hm1/EqztH560rXCD/BJKV
	QOw1fVWyF8tOH2ZM7wKoW1m9TlYOSNlvBaDpcmUv9gqWBkU6CJ+QkHobj7BT7H4yllj0HJEQ9w7
	0La2ioc/7jnWv6De7h3lnUcwyrJ/xe7OT0wvXsJFVs5m76aqFyGE51WiCLzOdF/lTFvdSYijZaQ
	s0U
X-Received: by 2002:a05:620a:2914:b0:914:c226:ecaa with SMTP id af79cd13be357-914c226f77cmr3314271785a.11.1779970912218;
        Thu, 28 May 2026 05:21:52 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c54:4d67:f17:d82a:d5b8:20a? ([2804:14d:5c54:4d67:f17:d82a:d5b8:20a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f87017a0sm792448585a.15.2026.05.28.05.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 05:21:51 -0700 (PDT)
Message-ID: <0d06e367-6114-46a5-9678-2f94827e3574@mojatatu.com>
Date: Thu, 28 May 2026 09:21:47 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/sched: act_api: use mutex in tcf_idr_check_alloc
To: Kyle Zeng <kylebot@openai.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Vlad Buslov <vladbu@nvidia.com>, Pedro Tammela <pctammela@mojatatu.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260526220847.28365-1-kylebot@openai.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20260526220847.28365-1-kylebot@openai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-292677-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,openai.com:email,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 26DDD5F2116
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26/05/2026 19:08, Kyle Zeng wrote:
> Currently, the NEWTFILTER path uses RCU to guard action idr accesses while
> the DELTFILTER path uses mutex to guard action accesses. This
> inconsistency leads to a race condition scenario, which can lead to
> erroneous operations on refcount, eventually leading to use-after-free
> situation.
> In this patch, we revert the introduction of RCU back to mutex in the
> NEWFILTER path, which is consistent with the DELFILTER path, avoiding
> the race condition.
> 
> Fixes: 4b55e86736d5 ("net/sched: act_api: rely on rcu in tcf_idr_check_alloc")
> Signed-off-by: Kyle Zeng <kylebot@openai.com>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

