Return-Path: <netdev+bounces-288909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NixGvHLCmqf8AQAu9opvQ
	(envelope-from <netdev+bounces-288909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:21:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A79568998
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF95A302F423
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 08:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3E13254A5;
	Mon, 18 May 2026 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Za9aZZv4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YK/XdFUo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C890C146A66
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092096; cv=none; b=cKKnT/X57oq6p+ua8xU5uRA3lRYfEnRVH8YIrzYAjgj4RGIxmNhfqibnKE66Y/8+UAE4baP75Zk4RnnZCQwHtizJkVeXZ7OKUIY2myUOKtG5kZvyUD/acKrnA1ZbJ4fXrQJAWFr41BjMXVqcN2GPlGQefluE1ADf283zQG0+juM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092096; c=relaxed/simple;
	bh=NXLXACMGq01KhcBqBzTMAiYLshJ1yRIyucKXH7MXz5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1OvONLJsPU8Uu4MPSr6tQS8dmqo1MewFl4VoKEdkIwBpzNw7sX/V6qUu24f6WagRtNlphOD/ADJSFujwi/r5F72nNVbEIwlFL0OUHrySCoW6UwAa07JkefZs0MWvqyb4a/2oBAqAhLm27xErYbxVP+xw8Idd6C7sxZgiJKIwns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Za9aZZv4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YK/XdFUo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779092093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I/51p+5dYf6Fd1RjMo+qQj6qq0RjACWeHMVXT7PEEl0=;
	b=Za9aZZv42PGXJtJ7H3A4cH3KYBayr3PvVBubZ+4RaW+mrwOWlIl6LNzxKOst6D7zHtVE95
	rudGMT+vu2kROpHNVjqgtLFGuSdfxZecSVisLxYT3XnBlKG05VQskO2X9sd+Mef5Y1KxRD
	/1zTt8qKY9UToCLAUriuQGSimX+7HVs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-U-k8VicCPrWlPdxi3UsNyQ-1; Mon, 18 May 2026 04:14:52 -0400
X-MC-Unique: U-k8VicCPrWlPdxi3UsNyQ-1
X-Mimecast-MFC-AGG-ID: U-k8VicCPrWlPdxi3UsNyQ_1779092091
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48fd233d1e2so18136905e9.1
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 01:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779092091; x=1779696891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/51p+5dYf6Fd1RjMo+qQj6qq0RjACWeHMVXT7PEEl0=;
        b=YK/XdFUoFBt1rLt+RexE19bRiAw/jTs2cK4K90iUme8AydMnNs9t6faOZylbee4kbJ
         zeCyrYHdtggLBAl/MImVJ29wu3AJ3x2LRNorJPjbT+oslRpD0CPhKxzrLjVdKDAqu0ON
         vWWDjrjbWoyIWrJVflocOEAxeiFg2SQRtgBfIPZ18uMIbQSZ4cqS4Ix9wwlhkRIFAyGm
         zb1G6vurFXlOxBzXuzmtRNg/4IKIBwz89gKyxnO5y1xdMN1jkUgnYx+kbN2G0Yj+saAB
         EHtEkvnb83Szb4AxJAPDOAICrkM7DzusJkoQxZwznbzctX3JkRKsWX4i0Q/t5D+YX3ir
         S/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779092091; x=1779696891;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/51p+5dYf6Fd1RjMo+qQj6qq0RjACWeHMVXT7PEEl0=;
        b=NQ8sljsJLZK1+NjR+Zl1AurS0lJefa7b1vssWttXu7A2bVtGJVaEn4Kj3BPAmgTlbW
         XeDAcAy9p0TRe27EEUczWDpGpJhVzzZQyJ/kAnmR/3tcqpi3jRLPhA2jOrmtZrUvDOKR
         7oWh0/WjKaiZJ4+3hkZwj0pJcmLugvlbqafiJc70fBpBVydeFb6TI8Ra7girD9m6h/UB
         uoqF7bFDic1G0KW1ihKBvFvx2ZJWsLCR4VpIDsaZbco5Y2TKGce7SggpMdkcJaxJVo87
         X3315Wdi9qR8YPrxQrvAeO8kgLJ1ZT25hAvVPB1eKBeZEl3AjeVzkHOdGDLOy1Bqi/Pg
         fAng==
X-Forwarded-Encrypted: i=1; AFNElJ+B/WDD05JLuGobVdbhQZwP3Nu0/JR1QmsK3sQjQ3+x4bn3ZY3QndxsoMEWl1GxuDodoyCcqEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2R3CEMn3YclkIUpyAbxD574POkzq9gZ1bKgMPc81JDLfyzoEt
	RUBEjn0oJzSbHAqCnCe6ZBug9n3ac3t2a4L7jphTySy/gUSnatjvuJrtYJicSEhAdHJENlVoE8l
	k5Fpr5hA7JySU76IYspBuwaf/GqRCQQ3YAS+tUUP8wUTHfSqGIMw072t5Lw==
X-Gm-Gg: Acq92OFQUru6EZXMaA0NmBbHLeXO3zNTLeo6bmvE2DCRVwQNYUVPsBPdWI7n1rwVwnl
	cvy60cCuT4KJZSQ7gN4WBKtjaNQzVAPrAsB1Nd5EeSNJq0jeXbiLG781IMSi65O2+uN2OmsrSBU
	B+7Ck4VjawLpx+VPppZVEhoosLNodW/uFMUAQL854Sxx5I+2ayifyv8s33uPSWgBAybftaMrB4s
	ELql4wdfkfWV5ZD40m5m3IdjNnVOecYhQQvMxbpkg+gLblOsb0PUKnm/nKgGV9EznimQn588jdL
	evyRuqh7Nsty5Ai+Vvw6J0fSuPK8EnInO/QN5yTbEbxQSdRzHsPrPJohT2eEUbjjG2r0SnhRkif
	xGXZ6XRxJfUMpcUESSFJmZVCuQfCkPBHOknAiuYOdRFwPBK+MlHNdrcA=
X-Received: by 2002:a05:600c:4e02:b0:483:2c98:4368 with SMTP id 5b1f17b1804b1-48fe6322416mr223540815e9.18.1779092090772;
        Mon, 18 May 2026 01:14:50 -0700 (PDT)
X-Received: by 2002:a05:600c:4e02:b0:483:2c98:4368 with SMTP id 5b1f17b1804b1-48fe6322416mr223540055e9.18.1779092090179;
        Mon, 18 May 2026 01:14:50 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab290e1sm117930105e9.2.2026.05.18.01.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 01:14:49 -0700 (PDT)
Message-ID: <3131c62f-b5c2-4f8e-b2a3-ebb844f800ff@redhat.com>
Date: Mon, 18 May 2026 10:14:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 0/9] net/sched: Fix packet loops in mirred and
 netem
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, jiri@resnulli.us, stephen@networkplumber.org,
 victor@mojatatu.com, savy@syst3mfailure.io, will@willsroot.io,
 xmei5@asu.edu, pctammela@mojatatu.com, kuniyu@google.com, toke@toke.dk,
 willemdebruijnkernel@gmail.com, hxzene@gmail.com
References: <20260514144747.527175-1-jhs@mojatatu.com>
 <CAM0EoMkthnGFtsmJgj5ibwuFjKg5s8dGOAkJSXUtH4FytG=qtg@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CAM0EoMkthnGFtsmJgj5ibwuFjKg5s8dGOAkJSXUtH4FytG=qtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E1A79568998
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,resnulli.us,networkplumber.org,mojatatu.com,syst3mfailure.io,willsroot.io,asu.edu,toke.dk,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288909-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mojatatu.com:email]
X-Rspamd-Action: no action

On 5/15/26 10:26 PM, Jamal Hadi Salim wrote:
> On Thu, May 14, 2026 at 10:48 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>>
>> This patchset adds a 2-bit per-skb tc_depth counter that travels with
>> the packet. The existing per-CPU mirred nest tracking loses state
>> when a packet is deferred through the backlog or moves between CPUs
>> via XPS/RPS. A per-skb field covers both cases.
>>
>> Patch 1 adds the tc_depth field in a padding hole in sk_buff.
>> Patches 2-3 revert the check_netem_in_tree() fix and its tests,
>> which broke legitimate multi-netem configurations.
>> Patch 4 uses tc_depth to stop netem duplicate recursion.
>> Patch 5 uses tc_depth to catch mirred ingress redirect loops.
>> Patch 6 fixes the infinite loop in the mirred egress blockcast case.
>> Patch 7 fixes an skb leak in early return error scenarios in tcf_mirred_act
>> for redirect (caught by Sashiko [1]).
>> Patches 8-9 add mirred and netem test cases.
>>
>> Changes in v5:
>> - Fix issues in patches 6 and 7 found by Sashiko
>> - Set limit (1000) in root qdisc in test 8c17 to avoid flakiness (Paolo)
>>
> 
> Sashiko has found some issues - we'll be sending a v6.

I'm likely too late here and I haven't looked into the details for this
series, but please be aware that sashiko(gemini) has a tendency to point
out pre-existing issues in surrounding code, sometimes hiding quite well
the fact that the issue is pre-existing. The general guidance for such
cases is to address the issue(s) separately with follow-ups.

/P


