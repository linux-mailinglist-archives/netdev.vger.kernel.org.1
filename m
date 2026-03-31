Return-Path: <netdev+bounces-273688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOVIGqzwy2m5MgYAu9opvQ
	(envelope-from <netdev+bounces-273688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:05:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D497836C545
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CE7C3030EB4
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B42829A9FE;
	Tue, 31 Mar 2026 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Yl56894w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861C73FF8A5
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774972893; cv=none; b=gNuFAPDg0efM6dobwuwuTBI3tIWliG4Y2Kz1NWcCKoVhGigiYqcipIqP4/5Wi/9n+bqAneCRswHbuHAwYZfQiQ5+l4h6Ptyq+8gD2qGt64yolyL9cAOzpMAiD7fB54eOAmmPI4Dx5ivZ79pP2KY7FZ2A0QTA/VVqpoWT1YV/gQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774972893; c=relaxed/simple;
	bh=UeZWnJT7iOsYzEMEYCQI2P+oNw4o6H7bxKmYK1DTknM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0bpyZW3ewrDwovWH/vArw3CgMM0zZlhgW6Ql1zZAsRnvlkUDeAmHCk9qcXWSQpmhdvbVRpNGo9a2+4IziTGXcFABqtfwu7wiA9j71qZoBfibXaahVpaSCcOHOwTYi6FXT1mi2ht6se1rYQhgWLU1bXF5O/UPTAbOlI1sFsDcx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Yl56894w; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cf814609cso157588f8f.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774972890; x=1775577690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vzSeNrlyjIpdA5QjVt5ncgOyFtChlyyVRQ3D9frbF90=;
        b=Yl56894w7vaIzS+AA30THNOEHOmLpliDAe7JgJaZ5R2fTHvMNP6Z9DdZYENBv9kWks
         rtL5jNhb6LKmoPK2kbpvX7KuZaXMb1MDSx0VIx6pi1D8tWBkHUHsq5Fi+Sbo2Ju1jX4m
         jTXv/IoLCccloojhF4s+w5Tm05/h7ifRmGb2JNn4xHCF//+aGhfTe14rmkokdZ4b/7UQ
         9i8RwooFKZKDueSAMnJv033Q5fPaUyblGSGMJT02T1a4xvZnFbahjc64FdTBO2Sh/pSn
         y4j44tVRiNiHmuFsoKTbtpPgF0RRtTJ6M9P3yO/rwdsjGSNNqHnJp5vpY4Nncd/+mpjF
         icIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774972890; x=1775577690;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzSeNrlyjIpdA5QjVt5ncgOyFtChlyyVRQ3D9frbF90=;
        b=XFU/ZMZ4+Ego4/Iks49NXjYrqdrbWeiCJP9DfzLAxEatUDMtyan8W5Lgw3lXsfSW/5
         /5N0CuxzPf/czYUPqNGGmqNmkcELRNSgVtE1KC8lUqhEpfbI3ClYIeKkaOW3RPzOFfAW
         khi4GA2XlXaSrcg2MdahhDCAwCXjoviSM2v6WKWjUmQOULJGSLGFM4mclFL0M829ltWZ
         Y+iibJmA0ij6VAyeFuMBMNRP4ibaPk0DPgIpW6ooXB/Ga5nF2PXdn7QOsf9owz2Io/KH
         LaqUT1IuGlJUYRl1cPaXhOYOmsYoif5FJijM3f4UqGh1seO0vBL0Fh6vTmzqEEcLPMQr
         g0Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWQrUQ/VfmUx3fWOv9PskG8SYgjV8ZsRekA5Kxd70eYkFO1qolHVKtQHzcjUIiiUl6xQ//e0eU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbkqQWy7TtEPuqIXXJwdxxIQk1f0RZTlY2giLa7Afhn3fAN+GL
	El9kOQ2CfvOZtw7duewbwrUNhozkHJ6OuheyCh5Uosm28K72fmxmt0R/dBv+3IeWmuE=
X-Gm-Gg: ATEYQzy9eewFNs/IMMB4TQ9GWJnJpR+wfGQ3egYEtMChOVXrxflKYT/QLpQquGI6mZR
	N76EFNADQG/QtogmKcJpz4vie69pqQjeQ+G2s0OVh4ejDF87jrX0a3kJNargrS4dio2iIl5eCpe
	JJV6RhGkAVQZTWFsEkeOX/j/Wj9Dt+cXraO8Qa+bptmjTElkOD29Tib2ZeMuk/E+7RowDVacyWc
	ARpLOiuk9N/CiWK7IHDS8dbHvAiG9eVN4st3PSgzz9+Ym1FNY8zQy+AiQ1pfvcz6SbJAy3xfxVC
	5k2o5RVJuDj46Yr4NmpU+Ps6nsil2ZGZ3xASutmISNHlMGpkjRt5Pj/B7PTzOsXoQzc0lXduW9I
	w0vJyyJ1eh0b4YFrhr97/drEp7juY8WfgYuJpUOtWlrSWfVFL7Lsl9+YZ6ipjFQ8YcdD8v8GzzO
	JLRrt7wQF4AWcyRFkgkicLmra1UVUoX7Mk4nJbueEdXyHuWsLBhlGdTvrhBsZGZhB5HvazIFxBw
	8roAhytLwZKQl8=
X-Received: by 2002:a05:600c:4ed3:b0:487:2439:b7c3 with SMTP id 5b1f17b1804b1-487282be016mr148577775e9.4.1774972889800;
        Tue, 31 Mar 2026 09:01:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e735532sm57095615e9.0.2026.03.31.09.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 09:01:29 -0700 (PDT)
Message-ID: <ed0d3cd2-0e2d-4bc5-855d-fba079a7db79@6wind.com>
Date: Tue, 31 Mar 2026 18:01:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 1/2] seg6: separate dst_cache for input and output
 paths in seg6 lwtunnel
To: Andrea Mayer <andrea.mayer@uniroma2.it>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 david.lebrun@uclouvain.be, stefano.salsano@uniroma2.it,
 paolo.lungaroni@uniroma2.it, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260331110755.25042-1-andrea.mayer@uniroma2.it>
 <20260331110755.25042-2-andrea.mayer@uniroma2.it>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260331110755.25042-2-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-273688-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniroma2.it:email]
X-Rspamd-Queue-Id: D497836C545
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le 31/03/2026 à 13:07, Andrea Mayer a écrit :
> The seg6 lwtunnel uses a single dst_cache per encap route, shared
> between seg6_input_core() and seg6_output_core(). These two paths
> can perform the post-encap SID lookup in different routing contexts
> (e.g., ip rules matching on the ingress interface, or VRF table
> separation). Whichever path runs first populates the cache, and the
> other reuses it blindly, bypassing its own lookup.
> 
> Fix this by splitting the cache into cache_input and cache_output,
> so each path maintains its own cached dst independently.
> 
> Fixes: 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and injection with lwtunnels")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Thanks,
Nicolas

