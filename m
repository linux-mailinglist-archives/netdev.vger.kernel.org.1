Return-Path: <netdev+bounces-259022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGosOC9glGnODAIAu9opvQ
	(envelope-from <netdev+bounces-259022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 13:33:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1427314BFF7
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 13:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA1443006033
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 12:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56573385A2;
	Tue, 17 Feb 2026 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJyn9eFN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="odrm1pQn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A26245029
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 12:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771331626; cv=none; b=eXg1ltf007hGk3deNzUVMoxInFTQZbz//1WxNphHKspoqTTNRtdPhl4Xvv9LD78k14NDM7ZocpVtuObsA/dpyBCiYB0Wt03iX7fQnUeVeFe7QvW7pPQqmLiS97XS3/s4uO0CGr2nwcHWf1fIhykO8aotr+Gz1KMRzjxSraHMfW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771331626; c=relaxed/simple;
	bh=3F/PtxbvnZWTruaWOX8pt9TFrvnOL7MN4m3IXy/gB00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WYvMLvbBmVyCw8v8kqwxQePbxIWOgedcDpPkPXs8PuOveuOQRLJV0dlL5MAtpToZCqN18bK3mqrTnlOOwUvUeYpJ0j42VZTP18L7raGxsrxO/ph4fu4ux/J3ouLKNKyMBwm5A+KGYC9HdNxFR6lBrp3AWO30UqPwSABashX8Dnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AJyn9eFN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=odrm1pQn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771331624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WDRWvoSrz3e9BgTnryMnQECVYhAGIwjQq5XKzoi1yT4=;
	b=AJyn9eFN6TO91G6/5Mb3kUFrcxmm3tQZe4+OTD5mtcSgNrmf513Vd2cc5QP2pf1laJji7I
	vPs+7LUptJC1o1Hsy+V7P6j9IJi6+DkqUybfXJpzl1/KBCK6/MIBmEUqRv0/AZRP5hCD4g
	0HR2a0DrnIv87xPn3nv1e9OoANEwrm4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-4LHr-B6aMaihp9Oghg_whQ-1; Tue, 17 Feb 2026 07:33:43 -0500
X-MC-Unique: 4LHr-B6aMaihp9Oghg_whQ-1
X-Mimecast-MFC-AGG-ID: 4LHr-B6aMaihp9Oghg_whQ_1771331622
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-437159d3ff2so4148580f8f.1
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 04:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771331622; x=1771936422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WDRWvoSrz3e9BgTnryMnQECVYhAGIwjQq5XKzoi1yT4=;
        b=odrm1pQnhSHcpzDdJCscpUySTdaXZLPiFpmr4InC9sWcK6tSvnCQgUWctil3SM3dae
         ku5BFRTYWOVfzMIR+kVyvJZGIULlnpCmkJwh1u3zJYg4mDMRgYfo9/kXFNHJAJupPFCK
         E+5p9qxtMDoVlMGp7di356y1+KAoCaTxY0lHjDJbAeC2xHcUw3X2kCNfG6JoG2nsBEjK
         0spCDezuf0Yi5SVfXCv/+iJwbME1o7rKzJvtpliwM1rbPMQzHBxah9BKJB+pyo6dr1Zr
         2aybALlwd3LNSLrKZZtxLp8AOEhXEmOIsYCIli2oo8+I713aY/HNy3v45L8AZiJMCPov
         9YWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771331622; x=1771936422;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDRWvoSrz3e9BgTnryMnQECVYhAGIwjQq5XKzoi1yT4=;
        b=VhMUI7z0Ywi+VgOhI8jYj4YxIv24KGevqxrjl7q6EGuUEb9bbxa6bZBoXn+hgrhMgc
         SEW4IdSisZVm7VY8b+FamKR9T02R2Y1rltzNTOLH/jyZlpeKtf3pUrIksKn+jCd4SXCw
         dRuo98HMf94tdDybgafMCnGiKJL9LilSBrN3tBgvegWywPbamQdrS8/wZHgcRKTst7Mu
         4R64DrkBh8WQ25H6V21o1BuzcLv8coMv5d4Fp75ZFcHFp8dssDQRINECTj/EOf+n2sPb
         z+ivF9eu9Z49PfMEhfHQb6tjZj+zMqn7dexpdT9khI9NhcklJPYN4s6pX+aTWSk9aY0s
         Z3ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGGgVqhGdNisn523nnlykkdXpetT2RRDWPIsSGBnAsGUtEsKw0OnDQ91MTKGUzV1akCRTxLM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPITbpA5lUrivsl5LiU+a7nx4ypqYncudDgAJVgGQOpK4WhN9p
	81n6SY+96lK2rRc2esBx5heT++zgmJ/pkX+FMN/OFajns0MT3L4YwB11LjBr5k/P2DnNflBUXLr
	6ZExzMGkSmO96b/DLz8/TH/6SZjbeb62ERokv+uZYDZsjtpKD2Fl6RDDypg==
X-Gm-Gg: AZuq6aKLq9G+VDTD7XOIcoitv/2EhIxBaKdt9nFiJgyj4/l2hTW8O994Gg0PB274rm1
	5+ty2MYKoK2BYLMlAbkwjFmrAHdWW8mPCl1upfiBYZ5roMTPrgiqTtNhELs1VTAPFHcSTuwseKW
	z1AyNI07EZAmFw5qw8bTb65uQKwGXZGxwD+iPOFq4lr19KEwFhG9uhEvP9K4IYgl+BpBKO7r4oq
	DeoHi4UNglyxGgK8Cgv2QpOv/8az5lxVcc/L44IpVnyqwuyXdOpHSOP9Kr4RopBtXtipIHuHPTP
	uU+2UI4zEBCqMbS8cmWeNEaIYsiEQ0nPbBVNE8RgDi0O62WWWzGDveAyZ5jBqNQ36kWPp7K8ojF
	8HCXtaJrfCvP2G8EHZERkh8DjAw==
X-Received: by 2002:a05:600c:8117:b0:475:da1a:53f9 with SMTP id 5b1f17b1804b1-483710588e9mr183712905e9.14.1771331621809;
        Tue, 17 Feb 2026 04:33:41 -0800 (PST)
X-Received: by 2002:a05:600c:8117:b0:475:da1a:53f9 with SMTP id 5b1f17b1804b1-483710588e9mr183712465e9.14.1771331621423;
        Tue, 17 Feb 2026 04:33:41 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48378b5196esm127469705e9.8.2026.02.17.04.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 04:33:40 -0800 (PST)
Message-ID: <354ecaee-7b66-4c8f-8293-30e68f1a3a1c@redhat.com>
Date: Tue, 17 Feb 2026 13:33:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/3] selftests: forwarding: fix pedit tests failure
 with br_netfilter enabled
To: Ido Schimmel <idosch@nvidia.com>,
 Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Petr Machata <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260213131907.43351-1-aleksey.oladko@virtuozzo.com>
 <20260213131907.43351-4-aleksey.oladko@virtuozzo.com>
 <20260215094520.GC114305@shredder>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260215094520.GC114305@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259022-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1427314BFF7
X-Rspamd-Action: no action

On 2/15/26 10:45 AM, Ido Schimmel wrote:
> On Fri, Feb 13, 2026 at 01:19:07PM +0000, Aleksei Oladko wrote:
>> The tests use the tc pedit action to modify the IPv4 source address
>> ("pedit ex munge ip src set"), but the IP header checksum is not
>> recalculated after the modification. As a result, the modified packet
>> fails sanity checks in br_netfilter after bridging and is dropped,
>> which causes the test to fail.
>>
>> Fix this by ensuring net.bridge.bridge-nf-call-iptables is set to 0
>> during the test execution. This prevents the bridge from passing
>> L2 traffic to netfilter, bypasing the checksum validation that
> 
> s/bypasing/bypassing/

No need to resubmit, I'll fix it while applying.

/P


