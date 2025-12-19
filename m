Return-Path: <netdev+bounces-245488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFC7CCF09A
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 09:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B42F30389B9
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 08:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61192E9ECA;
	Fri, 19 Dec 2025 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REF2B5pf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQMMZ4Qa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED462E88B6
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766134230; cv=none; b=nbUyLsdFx8QnJDV6kmZBJNTm1oEtgi739lLYsNqua2CanQVjIBDUcRUn+Sy7fS3Te8BYy9GuTa4PYzi0sK10bpxAcSnf94RnVlCEc1F0LAXGwmgTSJVSRYoXeOvr7mDatkinmXer2ZQg9aJ0Caz5kCD3x50FdrwoFLFxfqgUTLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766134230; c=relaxed/simple;
	bh=RLALCsoe1w3XD3naM+vu9TepI4hTgU4yd/3pARzoNms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pdP2uqlsh8dtcs2gwJQjkXu/JgSH38HxpShZLkEHnCpfDXSfSX5RHrK3jdoB4QBVSbkTTdP+IxCaOgTMlWW3Irfaqv+gbAs3FFlHIwRZHgGWCkfXmmDkcxC3a6MjjmLKLFJyrWtfx2YFREvw9Fsg3KcyCncZM0w6nzi58dY5jjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=REF2B5pf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQMMZ4Qa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766134227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2K24You3Kfo8F59LNIwUD/2pkFrB/SR5T0fDa72reg=;
	b=REF2B5pfwn+ZKNZlyLpS1CxZZslmufzvY1r4W4rzV6iyG0uSRUqoAU+7njDcKRVY9qlFWk
	1hbEn2hXRqJKtTx685BpOj4uOLjO827UsyigePtrmuWQCb8qZl1MNE5APfom/TixDCfy8q
	4MB2Tuor1VoYSNtxAID1ZvX+9gJLh88=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-Lss8fLdNN4mP0YmwoD4pSw-1; Fri, 19 Dec 2025 03:50:26 -0500
X-MC-Unique: Lss8fLdNN4mP0YmwoD4pSw-1
X-Mimecast-MFC-AGG-ID: Lss8fLdNN4mP0YmwoD4pSw_1766134225
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42fb724518bso890066f8f.0
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 00:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766134225; x=1766739025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J2K24You3Kfo8F59LNIwUD/2pkFrB/SR5T0fDa72reg=;
        b=aQMMZ4QaFOnIGPCBBXvggXo0UhbzlchUj7NRDwAhDhBs2rPhTRel5qf3UOzFyV1kCy
         m1eVkDbyg/a0ipWftDvXQfNisb3+pciZssUhpxmSxAI3LKKjn8QMxK8P5L7AR7K5lLt9
         vQfv1mj4VSvB+IxukNEFFmk5Qqa00DkW8by0326dpn834SSoHmJHYtOg1jdHHxjshIX6
         TGJjGgKe8phBPZZ11Kte6byoH7X2TOQFUMFJCvOP/86n0ADXna8sXoLM4Kh6dtPvVoQa
         JGLGALsPVMMvL0SmUI+5owohpOaW6r9gsliLzXR/4ehcG/uiWIb/POoyRESn5OEOqDP9
         GmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766134225; x=1766739025;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2K24You3Kfo8F59LNIwUD/2pkFrB/SR5T0fDa72reg=;
        b=ZbTex5E7xtIIzH3QmYCHg1J+6wbMn/DcVXW48jLvyg+3tEPuq+fAVXYsIjITUj/lAf
         lFTTEVkio/lfWoKOcWEuHUSNbTEEy6i9JMJATQyne8bo6OQylxWUNZ8FP+d6n8jGd2i2
         krFadZlqz0vtSfpoBxmdBh/ZARVdIF3irDpZiYI27U0JwvRY7+NS2NvbHv0dzVslXU6X
         Mmum+NP5+epwxI8Xhio/MYpCCsk0xJPiI1nwZMv2MAt9MvgDlDdSc9PrI+ZSAv9z8XX4
         28OhrjqhJXyGCUwQfet857xHmYzX4x2fA0uD+U26mrQM9RGZu55CcoPB+o01L1wNrufN
         zUvg==
X-Forwarded-Encrypted: i=1; AJvYcCUL97mrC4daYHH0yl0bT9LKnJil8ugaw/+W1ISD4oc1xel//MeQXBO+h/kxuOMsdgmTzBYbR1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHPvh+WhN+vs3VRCnk6qY5BFmxRYSPqF7iyirtnbIg7D1T/HAK
	A1Fqw6U+J0/iLstHYcNcGbD536J8Zsnfyz1tUA1dKo4yDwB6HAVe5huLIT6w1Oxxs+cr1CNbh4/
	cOoZoM+rvnS/PPqSACsDZCkELu3JA7PZW0YmpiteSiYvJynm5EJ04qenfzg==
X-Gm-Gg: AY/fxX6HoPUQvU0SLoyGvSnvsGdt2933EQxmvG2enEWk/IrYhvuz7v+GUcZ0NvQxxDX
	fOR29sZzkMnIPotLkamRXhhfl9uuVPCkmCQoj/asBv0a3GZqsFWo7IkW9/L0IHR0FpHGwGIQGw1
	p3YmJNNV/vx87YBej/P8KaJV615oCuB8U4lWJ74xfUZvA28ZfEGy6qkP+3G1BZJAaZql0HGeQsC
	rZ2CH7F2amzINGXzUl5YdRmsn+KOc4U2EOcZ6K+8OESc/vzXua78EO8N0pgsJqzfbjAIV+k9rMk
	p5GytNmttz/vavaYzdnSb4qQl4I3WT0ALr8ap9ZTV+bCxEskSonewK0P6GUrBXBxmOJxcFBiJoY
	i1JOn+kbkIglH
X-Received: by 2002:a05:6000:2907:b0:429:b751:7935 with SMTP id ffacd0b85a97d-4324e704a80mr2514623f8f.56.1766134224866;
        Fri, 19 Dec 2025 00:50:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHt/CfVvLNdIq+TM1T6BQhBqxVPih7iUEVrqrCXF3wQwAR+Q36BoRwUoHyrhDWqs9SKEnDvQA==
X-Received: by 2002:a05:6000:2907:b0:429:b751:7935 with SMTP id ffacd0b85a97d-4324e704a80mr2514594f8f.56.1766134224471;
        Fri, 19 Dec 2025 00:50:24 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea2267fsm3591620f8f.12.2025.12.19.00.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 00:50:23 -0800 (PST)
Message-ID: <6d244984-ff8d-4226-a5d0-49b0547eaff4@redhat.com>
Date: Fri, 19 Dec 2025 09:50:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/6] netfilter: updates for net
To: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netfilter-devel@vger.kernel.org, pablo@netfilter.org
References: <20251216190904.14507-1-fw@strlen.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251216190904.14507-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/25 8:08 PM, Florian Westphal wrote:
> The following patchset contains Netfilter fixes for *net*:
> 
> 1)  Jozsef Kadlecsik is retiring.  Fortunately Jozsef will still keep an
>     eye on ipset patches.
> 
> 2)  remove a bogus direction check from nat core, this caused spurious
>     flakes in the 'reverse clash' selftest, from myself.
> 
> 3) nf_tables doesn't need to do chain validation on register store,
>    from Pablo Neira Ayuso.
> 
> 4) nf_tables shouldn't revisit chains during ruleset (graph) validation
>    if possible.  Both 3 and 4 were slated for -next initially but there
>    are now two independent reports of people hitting soft lockup errors
>    during ruleset validation, so it makes no sense anymore to route
>    this via -next given this is -stable material. From myself.
> 
> 5) call cond_resched() in a more frequently visited place during nf_tables
>    chain validation, this wasn't possible earlier due to rcu read lock,
>    but nowadays its not held anymore during set walks.
> 
> 6) Don't fail conntrack packetdrill test with HZ=100 kernels.
> 
> Please, pull these changes from:
> The following changes since commit 885bebac9909994050bbbeed0829c727e42bd1b7:
> 
>   nfc: pn533: Fix error code in pn533_acr122_poweron_rdr() (2025-12-11 01:40:00 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-25-12-16
> 
> for you to fetch changes up to fec7b0795548b43e2c3c46e3143c34ef6070341c:
> 
>   selftests: netfilter: packetdrill: avoid failure on HZ=100 kernel (2025-12-15 15:04:04 +0100)

Pulled, thanks!

Paolo


