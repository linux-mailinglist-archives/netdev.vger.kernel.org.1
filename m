Return-Path: <netdev+bounces-284921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yG1ENTNg+2kuaQMAu9opvQ
	(envelope-from <netdev+bounces-284921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:37:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D194DD60C
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B7AF303F734
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E445426691;
	Wed,  6 May 2026 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZO9TXiOP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="poI9nu6q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127F33F075E
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081545; cv=none; b=ryj9MbnP+UxJFBxmntFXZoCAoJSTc0k0Olb33yjMaUoBd/tArPFTxqPL3MuXLJ8+iTPyfVkK3vtHySvUww1YSyOBT/1Tio6Xw08MGIWiqoxcRLcLVq5GSsNQn3hLEMC/L2NrCB0dTOBscE3i7M55o1XSiUhy1/Q7Yk/YsZxwN7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081545; c=relaxed/simple;
	bh=6B1JDvhMshkikE3fZUzsq/DnpD+6Z8qzfXdxsT5eDSE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gdF338Qi8+jpHQcEPNz+R/m8j0jD/jG+jrnp8vwShVw+kv8tcoXL49p+LV7dc7xTOjejlmauQmVRV5FWXx4xMpB6smO9R+Zt0Pcz+08aUC4OSSCNqjieya+IEL/9LjweS0a3atJOJp+Zr075WbrZ/J0KHJbJ538IXpLGFsJp15Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZO9TXiOP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=poI9nu6q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778081538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWPJjdL+Se4qf22augp+8U/7BbRvhUfZs7hvq4GmhQ8=;
	b=ZO9TXiOPDXhttOA0Ln1RQVrrdbF+J+Fv3Se36tSA2UZmr5IRyXr5JS6QUB+TweTiQYq37q
	7RSWkUFL7eGIs1dlWY+ktd1PqewbRKsMVTO+4TZV5559LVyPejeDltvdZjPNPhJZqkR5RK
	2ZCERacy6L+q/gQWHOF+SeTYQDRndPQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-GGsBt8ThP1SrLwWIOWQYmA-1; Wed, 06 May 2026 11:32:16 -0400
X-MC-Unique: GGsBt8ThP1SrLwWIOWQYmA-1
X-Mimecast-MFC-AGG-ID: GGsBt8ThP1SrLwWIOWQYmA_1778081534
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48a5952c635so71752365e9.2
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778081534; x=1778686334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BWPJjdL+Se4qf22augp+8U/7BbRvhUfZs7hvq4GmhQ8=;
        b=poI9nu6qHVNBnpI7t8Or5YOFC9c+vV1IzskQTsWQF9+6YMLFO+xZBU3HY0TZyvb1/8
         Qb/raVLmD3TrfI7YEmeQhBr1F2QWZGlE9SP9Q9P+VmGqRK42NFu6JBLLLuy09O+uxN3a
         8/IJDGuMSL+IXQvO50e00e4YI0hX3l32VRpBeCEA6kEWtn/x77fUG5JjYRCtfL/LFQTz
         INMTA7wCFvBIfji/r+XTEBaQpZG89TiL7kbl5p33dhUEpQO7b8wszbyNDDf08S8EOXWi
         Ip/dPIBY2aoEtl+nfke0dHjzX/1lP/G5qGwAtJfamsRetynpNjVpdurizLI+JwGMxni5
         9bYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778081534; x=1778686334;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BWPJjdL+Se4qf22augp+8U/7BbRvhUfZs7hvq4GmhQ8=;
        b=FsTC0aZTifdBFleKd+QTTDo3GjdPTpGUHYtNsv6OYFvH1ck3EYQPJzievMcnLpo/9G
         K0+9+FG9ac4Idvn3lkf2ahXNf6nSMHyTpA1WPotmkHGugyciEG5LM2EAGVQSDmvMXgtT
         dxPboaFDHpG6JQT7w+xdwH9wbvJAKDtGYR5sFgVI2nmEfYs2n8aR8+XaUtLRNeF/KIM/
         o74QGo1rV28P55UdsHnG/R7VVVnY/BdK6FxAoUknY7xMvaerX7M2LtjvLmgeEDWKJEiJ
         x2J+fyG1prRX3lzgSP8jf12OPEer6H3uWpAEg53WPzQqSSbiTe+7tuwtGX8rQ9ZLidtG
         OPew==
X-Gm-Message-State: AOJu0YxEGY5Zta2gDRCHqSMQWa1k1rrI4m3dSAdrQFZiCpcwh1cN6BD9
	5px2ctf7uUPyP6Q+ptGatvNwxrbRIGbxKtg7QmN5foGd7Po44HtNsn5rSCgcUrVFdMB4xpHALIS
	TC+qwHOmenPP3nmz98b/i//iAGBub+x4EIq5bqrWs08BrIkEswe6Cia7FMA==
X-Gm-Gg: AeBDieuet42MW3DdgOdrq55occvicOqMaxXH/NFrardxnsOLXLF30ST4mHTFqG8HblB
	v6zpwjmWds5XcrFUz7q4jpf78+aYUSxvrp6NrL6KClCX9hQB/QdgEcrisdFoeuEySZPj15TCwqj
	FYxPctU74clyXkF/a57V7+Is9e60FvYPr+FbaG+XnD79VxbZgSx3UI0lkdo5HBIgSRYIGq1TUCr
	ewDaOct/HrygJgBDLHdvohDr6Lpk223AY59J2/ePh2ypwo+T7ZjqGKSxL9CGwo3ESd0J5EbJWEe
	fIFXFKZbFBacH2Wxy4vJDJdTKt426z6Gr1tP+HlFR27gMqNYq6qybIbjfFUxVNh3l8XVlc2zo8L
	ECQEzI3VJpz24TCixnf5fOiBGpWXCfZrDG0fLBUSK+DBUHEuHu/zUB2ZKYljLMFl6YR8=
X-Received: by 2002:a05:600c:4996:b0:48a:5821:5ffc with SMTP id 5b1f17b1804b1-48e51e0bb6dmr41569935e9.2.1778081533808;
        Wed, 06 May 2026 08:32:13 -0700 (PDT)
X-Received: by 2002:a05:600c:4996:b0:48a:5821:5ffc with SMTP id 5b1f17b1804b1-48e51e0bb6dmr41569375e9.2.1778081533302;
        Wed, 06 May 2026 08:32:13 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53116a9fsm28671565e9.8.2026.05.06.08.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 08:32:12 -0700 (PDT)
Message-ID: <af591664-bb26-4b1b-93cf-cbcc68763d5e@redhat.com>
Date: Wed, 6 May 2026 17:32:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 04/12] net: shaper: try to avoid violating RCU
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 davem@davemloft.net
References: <20260506000628.1501691-1-kuba@kernel.org>
 <20260506000628.1501691-5-kuba@kernel.org>
 <59b26f1e-efd5-488e-8738-15e96b9c79e4@redhat.com>
Content-Language: en-US
In-Reply-To: <59b26f1e-efd5-488e-8738-15e96b9c79e4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 32D194DD60C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284921-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 5/6/26 5:22 PM, Paolo Abeni wrote:
> On 5/6/26 2:06 AM, Jakub Kicinski wrote:
>> net_shaper_commit() overrides nodes which may be concurrently read
>> under RCU. This is not a huge deal since the entries only contain
>> config, worst case user will see inconsistent config params. But
>> we should try to avoid this obvious RCU violation. Try to allocate
>> a new node. Since commit() can't fail fall back to overriding.
>>
>> Full fix is probably not worth the complexity, struct net_shaper
>> is around 80B, and the allocation is with GFP_KERNEL.
> 
> I'm not sure if even this variant is worthy?!? The scheduler tree dump
> could be still inconsistent, as the dump is not atomic. IMHO e.g.
> inconsistent weights in the same WRR group would be as bad as
> inconsistent values inside the single shaper.

I mean: I would simply avoid addressing this RCU violation.

/P


