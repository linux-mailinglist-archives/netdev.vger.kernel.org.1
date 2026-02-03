Return-Path: <netdev+bounces-256191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Mm2Fgu0gWnNIwMAu9opvQ
	(envelope-from <netdev+bounces-256191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:38:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAC1D649B
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 609AD309FC56
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 08:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46684395255;
	Tue,  3 Feb 2026 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bD2s2/7p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNRker4m"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D7A2C026C
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 08:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770107552; cv=none; b=RWESYpCFD52G3UF2Fgl5kR4zZ8V8Y9Zhr2WeUmx+nq2ykOw5Fwoiid0+4YNp+n/7jbv4/pJB0WjihxJ8VexYBiLHKM/DRYOT5499BFk/9SjlXH4gS8/Xb3Ar9duEpJDp5YZJlb9YeWVDUXBbuAh0bzBk3AcVMaT38uXc0SHsZEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770107552; c=relaxed/simple;
	bh=XwLGcHZPOqxu1Tr+vmfMhPAG2OUB3TbvDXlQ2wzB/Kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lg6gshjzYk3kxPJ582jsilpSs8DP/TkyCqeFUt1B41e2bvtRSOzezm2z0VZ8MeKKUniQYcWIu94xXipjx7YxsQAsZ79LSVEV+lFAmaVme6nVoFYCnRYN3JR1iN2KunPYLhrZoW4xjW/kaKRlrg63KXYDqoerJGZXkRCa14CGpr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bD2s2/7p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MNRker4m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770107548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RP0V2EEbdTJyskSM6vT8Q05yw0ANUNR7tmop2Pnro4A=;
	b=bD2s2/7pNJeyeIH7P2PNQ8VOgFzPyzDsPePMyyekun6JBiAMBxo+0o36Nks4J2YhB/4o4e
	8EpQhBO0esQDvClWxWgbrPjWCWGLnnFySBZCoklcwyDYnpg4/p1ubfFppGP5HyHxvH3FfI
	3zO7wdAnL1ZUnEan9+x05UcoYZ1be1A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-51nTInb2PM6ae0r_-ZA4sg-1; Tue, 03 Feb 2026 03:32:27 -0500
X-MC-Unique: 51nTInb2PM6ae0r_-ZA4sg-1
X-Mimecast-MFC-AGG-ID: 51nTInb2PM6ae0r_-ZA4sg_1770107546
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-435add03f12so3460408f8f.3
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 00:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770107546; x=1770712346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RP0V2EEbdTJyskSM6vT8Q05yw0ANUNR7tmop2Pnro4A=;
        b=MNRker4mp+1J4D8ocJ4cA2x8P57VSePMu9w2e//cnl7jLn6pjsoBZvVMw04Mi7xNvC
         CgmoD51aw8jOr6MkssB445Wu8uRRNYkTb0oHcQQUyrzxoRG53/GtMxEhvUqhPuMt0fA8
         8a8Odw+NggXxC0IZq0ia51UQX1RRLDHJGtcX6yU3uPt284kXbQfjawTF/n6/xK27KJuE
         sJKI2cQxkP/0MTOhzlXdXqGxO750FkC1/ZyWrqq6DgAjQFODo8rEIhOclsVfgHlx3RKu
         X86YepZl/wuQUkQr+2ldXZOAsGkbgcXBQibBtwH1aKodSxFWRb4y8mQYzU0Y17e1aAAx
         j2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770107546; x=1770712346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RP0V2EEbdTJyskSM6vT8Q05yw0ANUNR7tmop2Pnro4A=;
        b=lgxQBpCrQFI+8ivaee1Km7quWodnCnCcL9ggrbQ+EDZgntSCCm5BjI8BOxGXUBk5Tc
         L302Up/eR/5eV4eO1EvbbIKfeX5WjQqTtXDIzEfI6ORSkrWxnh3TmZp2dNMcHfhwXf74
         Fr9OaFTYF2nKje+jMD686kUqRmN9v3ydZVUbCFJNroNBE/Qpf9zwrCmdQtTnUqzKHVzo
         UOu7McRhB/ijthBC1iFRLqVICMiJGN7hUot4lappFsrqYv1Sf36wA2gK27wnXeXFkdkm
         IpQf4cw0q4rob5xHjPBFOIkEdzhX4umVa0Pr/aymvfm7soaJHaueLe4ywX3iLTBE7KdP
         I7Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVGnuQcAn7eqgf9bLNs6OuuYoISmTczQnFH5olaRZJKBiu6Fhsk+gRVDbmQHe/XH/sSeGILxwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNCVBn80u7+7CV2E0WVZoP/qnw/2dWkfKlrNm0FQz2Q5cKQ9hW
	fcjIWK3YqHvZpazU6RrWLGMj8Mf18iI/zsKoEcFwZGBviK+1q3yAy9E6JGEooZMTg8vZbrgyNCm
	GpI3W0hCIiDQSQJUlz323n0JU2OkXZpw3UiTofQBqxH7TfHLn7fTxdiDsuxJ12/T1uw==
X-Gm-Gg: AZuq6aI7D9KyJow3ps2jScb9H+z2esEZ+YGXovAPdt1MyWXsC7ljCQ8UDfh6PQO+qzR
	vFtlNVIkoDpNs5oIn7ZuRchJeotvEUv8xEW5Hwc6j9XhINfOPmouZYxVBU2oLw4epxResjYJuGH
	NW0cMKKEFndfJ/vJE8qV3FU/WMvGa/NGRyXV3UyWAqxUZpqckOFlCNlAeCM/sv7xyY3bbV98L+k
	Gv7xLdRPDN4DHCrKMbzt3/29poLYLeygBST9PWuZAMsxmkA2bAvBPF/M2G02thdvei6XZQzqL0j
	JY3qmd9Mtrp0txIFVK1QW2kDwZZ4mgIMh1UtqOLIAkCExna1V2LN0QxjaDzrRfI/Jtx3igsI0He
	yVWsNXZ9QlEs=
X-Received: by 2002:a05:6000:1a87:b0:435:9882:2342 with SMTP id ffacd0b85a97d-435f3aa91b8mr21129606f8f.33.1770107545713;
        Tue, 03 Feb 2026 00:32:25 -0800 (PST)
X-Received: by 2002:a05:6000:1a87:b0:435:9882:2342 with SMTP id ffacd0b85a97d-435f3aa91b8mr21129576f8f.33.1770107545344;
        Tue, 03 Feb 2026 00:32:25 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1323770sm51756926f8f.32.2026.02.03.00.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 00:32:24 -0800 (PST)
Message-ID: <a8ea949a-ac36-4753-b8ab-f9a85004750a@redhat.com>
Date: Tue, 3 Feb 2026 09:32:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 00/11] net: tunnel: introduce noref xmit flows
 for tunnels
To: Marek Mietus <mmietus97@yahoo.com>, netdev@vger.kernel.org,
 sd@queasysnail.net, kuba@kernel.org
Cc: Jason@zx2c4.com
References: <20260127070452.6581-1-mmietus97.ref@yahoo.com>
 <20260127070452.6581-1-mmietus97@yahoo.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260127070452.6581-1-mmietus97@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256191-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[yahoo.com,vger.kernel.org,queasysnail.net,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CAAC1D649B
X-Rspamd-Action: no action

On 1/27/26 8:04 AM, Marek Mietus wrote:
> Currently, tunnel xmit flows always take a reference on the dst_entry
> for each xmitted packet. These atomic operations are redundant in some
> flows.
> 
> This patchset introduces the infrastructure required for converting
> the tunnel xmit flows to noref, and converts them where possible.
> 
> These changes improve tunnel performance, since less atomic operations
> are used.
> 
> There are already noref optimizations in both ipv4 and ip6.
> (See __ip_queue_xmit, inet6_csk_xmit)
> This patchset implements similar optimizations in ip and udp tunnels.
> 
> Benchmarks:
> I used a vxlan tunnel over a pair of veth peers and measured the average
> throughput over multiple samples.
> 
> I ran 100 samples on a clean build, and another 100 on a patched
> build. Each sample ran for 120 seconds. These were my results:
> 
> clean:      71.95 mb/sec, stddev = 1.71
> patched:    74.92 mb/sec, stddev = 1.35

Which H/W are you using? I've never seen so low figures in this decade,
possibly not even in the previous one. Expected tput on not too
obsoleted H/W is orders of magnitude higher, and we need more relevant
figures.

Thanks,

Paolo


