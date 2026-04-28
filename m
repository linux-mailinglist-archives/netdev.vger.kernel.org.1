Return-Path: <netdev+bounces-281835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JimBNm08GlwXgEAu9opvQ
	(envelope-from <netdev+bounces-281835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:23:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DE9485C91
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D22C31DD397
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAD541B346;
	Tue, 28 Apr 2026 12:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+5HNLPn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD4A41C311
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777378934; cv=none; b=QJY2XfCEDsD7bYqGsY8xHJ78uJBgfNinrmbtGYhckDegMVpnE3FhsD+AmK7rG3sbx0wYzuioVp5dYFHPPoW9Y+xttdm7qlRoeUfiP+n6EAJzVceiI2IgmIjkVefGNUJLHGhpyFON4MSso8/kiApDFYLSGmFkwp9z0nltRXs+hEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777378934; c=relaxed/simple;
	bh=eYPmyiMGSedPs8Nz6KaAqMfRG2j7jcSEfi7C64leoOo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UrYyZOKqLMimRKkvtteKZvUjOxx1+xkPVWSQfauPJZu1NWvL8jqhTeyzZ+YKYAwy6elpYNuHg+7DXtesc+fNvLu8ZgvLO8RmmteChDTIn3Llf785jS1x//X+3P+5xvUUf5uPS3l0rP9NT9pGyjQJ4hc2kPTXMnzEB4dOTp2irpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+5HNLPn; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3614826eca4so9934058a91.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 05:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777378927; x=1777983727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eYPmyiMGSedPs8Nz6KaAqMfRG2j7jcSEfi7C64leoOo=;
        b=X+5HNLPnvrHMrNvEklBf9QLL7d/h/vmSwyQchRWz8qWl/nJ/tAaaLOHeglkvjl/7b6
         ZYEpkn2ZAe+o0gw+Tz6mDS5L7RLlrxv6lGHRoPPCupkS0pJk1fCZPqq2pmgkBVb4AOf+
         akDfXc8+2Bm1FBmqbUgK1Wauvy6fNQpNi9PWOZaotEkeWzEsPKMb6EWxKKQn7l4jsosc
         jC6Guo16iuAGd2CaSkv4sILLid+k1rjs9dWMkfWua4DL+vJ0uI/R6/piItUQeuAnNU+e
         NffETEUEnwV1IOQkClJQZkBiuajbfOkw6YaEHOZfcVuknkdSP9ppaeE0V0fynYNsySEE
         V7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777378927; x=1777983727;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eYPmyiMGSedPs8Nz6KaAqMfRG2j7jcSEfi7C64leoOo=;
        b=HOWxdZNAI72mJCTyyBccnTLcDhhZg2Bip4iuLse31guVNyEjMLXV0OjTlmsPAo0flh
         VCyYlJ8+EX+f12mLTsepIcQKP2W7d1bUr8l2dotuu8/R0XKyG2Yqy+md6WrbmmYNwSOj
         w1Cx2PcXfjKIMufiot406NdVMGyaH8EAeul5rppQ1uADO6gub/BJwBZrsH47+nw3CBQx
         +QIjyzm20QxfEbrNNxQrFjOBaie3O3suWzJfbb9JEXYQztcSmdLxD4OlUqdIJAnevJLm
         G8lmrYkt1zdZjzdsElIX8FF7paF8t4Wz1Z1pr6t5142FkzmH27rE96fcXBR8N9frVGhI
         s+qQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Lb9bWA3dsYSgGuNpO1vOahmwgdCPOJhEU5IJ40yi95MWi8WbmuQ1kOVEj78v0wDOp4vMbasM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT5GyBvjayPDlTo1u5VT0DOvEAD32PvC0mYDS4ewaQlr5ZDrok
	dR1WU9Kz3z/zB96w2YIgUCQozb0Jd7IQGtPsH61a9hUre5EtsGxJYFV1
X-Gm-Gg: AeBDietsuci5RutMVZ4cI2DJgOlvyIMeS7VolSairVEPBaF1Y+nx0q9TJasLbRj3PvI
	z4z8w6q40SCS1gu1UmICSLlG37KjVvP5TucL/9gLbjKyb7IqeHds74bu0owYIhzL9ijFGJhBNXm
	SsXM3gFubB4X8Q0n3QuYj/W0B4nIAY65E+aKSCTvX1LqPGU81GszBfiroEhEKVBEj6Ypo05laA7
	Fzz8wRMZjSGsaGJcRwXg8+cs8LmOyOv27IK9B1TBe5UnWtojaXj5l8XNDyNgETq198ZHAb4swQg
	iOz1zedipDDixcMMdd2DmNAwZ6hRoAmHhL9sZUYmIhiWgZtsjqoh2nvP/prckncvc8opUzJMy0G
	Hx2/tQe1bNvU6SnLfQll0/3WZbaVny+1nUjObHWKeqJRxHLnNKmJ6UnDWkU66La8uDYXrIVkUYa
	6438qe9gd1is0gjHY7jbbTGRTa4u3vYl1SjY5I/daRsGIIDYaOsEdPM7HNtRw1WS+5sfwRAQ1mP
	tDsxii3/W8=
X-Received: by 2002:a17:90b:2f8f:b0:35c:30a8:330 with SMTP id 98e67ed59e1d1-36491c8837amr2989046a91.0.1777378927430;
        Tue, 28 Apr 2026 05:22:07 -0700 (PDT)
Received: from ?IPV6:2001:da8:201d:1103:3367:a44:8d5a:228a? ([2001:da8:201d:1103:3367:a44:8d5a:228a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490de9f9asm2987905a91.8.2026.04.28.05.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 05:22:07 -0700 (PDT)
Message-ID: <65911f89-e1ef-4da1-aa41-d261e5162f71@gmail.com>
Date: Tue, 28 Apr 2026 20:21:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Linpu Yu <linpu5433@gmail.com>
Subject: Re: [PATCH v2 bpf 1/1] xskmap: reject TX-only AF_XDP sockets
To: kerneljasonxing@gmail.com, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: sdf@fomichev.me, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bjorn@kernel.org, linux-kernel@vger.kernel.org, tanyuan98@outlook.com,
 yifanwucs@gmail.com
References: <2b156bc4277a9e891f3399935416701d1f9efd7c.1777276241.git.linpu5433@gmail.com>
Content-Language: en-US
In-Reply-To: <2b156bc4277a9e891f3399935416701d1f9efd7c.1777276241.git.linpu5433@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 45DE9485C91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,vger.kernel.org,outlook.com];
	TAGGED_FROM(0.00)[bounces-281835-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linpu5433@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Thanks for catching this. fbfc504a24f5 is not the correct Fixes target.

At that point, AF_XDP did not yet have TX ring support in the UAPI, and
xsk_bind() also required xs->rx to exist, so a TX-only socket was not
constructible there.

Tx queue support came later in f61459030ec7 ("xsk: add Tx queue setup and
mmap support"), but XSKMAP updates still rejected sockets without an Rx
ring via xsk_is_setup_for_bpf_map().

The regression was introduced when 968be23ceaca removed that check.
I have corrected the Fixes tag accordingly in v3.


