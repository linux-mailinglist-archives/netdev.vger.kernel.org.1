Return-Path: <netdev+bounces-272587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJbDILGPxmlLLwUAu9opvQ
	(envelope-from <netdev+bounces-272587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:09:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB241345CA6
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80C3B3082A55
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 14:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E8D289E06;
	Fri, 27 Mar 2026 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ZJdOXPz7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF3322173D
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620244; cv=none; b=joTa5+cv244J3Fs3+0cYNcAED37/HL1xKsVRnAndwxxi2mvcIGw1n7tIo92MhWOE/J0j3HDYd+HzvLkc10LR+8dw5YZe/c3q1SxxS6Gj4EPKxTyU0ccdfQFpvZaCJzBesq1XFzDWmJhUFXlpNo65GAL/70tG9FFEB0284cEixOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620244; c=relaxed/simple;
	bh=i5WMgrfhA+NvKpUbdB86oFVHQc0vR8QLu8+TWwJ0yPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rs6o/6ChQmwAPfT1bqibcHXPO+lppEiJ3YC4hk+XnOc34SnvGRAkTwhcIf3PtCAdZtSHNQaCnuzP+kfFMLpcqHFqDZcUcxxOnoD/i0nnmp+j3rnyFjM86xmlAsSNQXlzCPg+6jiqi7UkCyGUVhPAKrvvyKqbl3vaC0x8jOedbCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ZJdOXPz7; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56cc8a021e2so1536958e0c.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1774620242; x=1775225042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xFbsja3a4w8vKLd00y5Fn8gI0hunCuKaO0Qyb95+Ovg=;
        b=ZJdOXPz7xVD7wP3+Z3QbA3X+VewXZZi+4k6aL1VA8p8hB0aHmPota++uWHQVqdywXB
         2w6ThOhoBfylJZn1U1PR+v5fKrWg8G1J2fz4JZERPxyps7+ddJLAxQ/8EgK6qQPxCoXb
         dSQ19gCbhTYEBdq2wsz9gSYeKyq2cXpItWMOjBd6htGVSdI8LA5Gu1xjwb2nTOPnz9hm
         5jYMD5ILI2jg9zQhp8qgU0uEewFjTFO+Y7YurUxUK5+i4j9qFm/SdWJiW/8yO6FwC3xE
         82k8ojBdTBvk8DdJkya3vTr9HcjC6z0X5MhlqbJlJ7xdcUJywNdJUm+Wolvt3o29OKjc
         EsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774620242; x=1775225042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFbsja3a4w8vKLd00y5Fn8gI0hunCuKaO0Qyb95+Ovg=;
        b=SyhkzcyboyEbdaXSvPSDROpzFG5uCT+FpQIHemgpPKFB+NBT3cpg0IMrDCCqXG/eRN
         i5TNKq98gqlx/jLuuAPSsLYVRj4hXv5vW6blSX5Mmo0XYDTl89Gn4ywS5vavK0hrRAiC
         63kYDdflZh35tomgkV4dyK6r+fCLLdCCK1FEsmPDuk9PEj+W8q8Ym1LG7l2u00ae3z9W
         YRiJ6cz1jQvTPDFBoSUmkoDhOce/T0dQS3cTc21GInAOsKxzYU690c1oaBPVOR/QBsao
         qYzl+m1PCYrqCfb+VPOMTffq7TIWSL6mEWd5jVGBr7cwYkyZT2k1tLVHYqZGcnQx7lwJ
         GX2A==
X-Gm-Message-State: AOJu0YwCzi+nm8RHkEBi2LogUJBGAc5ctF83TIIIN7CH+P78143obOTG
	vbXzlmC2vd5XHjjCaUlYacS3fU3k77i0SBd2fabdYbPhLC0dAvDRBGpOS7LZngPDkw==
X-Gm-Gg: ATEYQzzwzSLAySflgnk61cMsMNUP3mt2F7WjYjkqVgJ44cpVkRcAMORsJeYN1Hn7Zqh
	qGGO4RFwgqN6j8qCYY4OmxFf2s7KypeH1feGvDlTeFBv8OwqbiO2WzBawgW/SBeChgG0kGcwryM
	l3/Fihy7Y3qdW7V4swbcvQKN0IAdTaljfQDz9PPb1m3FyY3q+4hdBbicjNrxYKrY1WzPS538kjP
	rhoS5Ih4HRaIVpqxrIhlolaAQEZA5E56BYc2xxyae+7+Rm688DEab7X6c9HyIqWf8he/O7zgRDJ
	mgp9Ojj5BYZ5QazmJ2ASFzxd89RAfq7op3ohfFBgBS8Rlonk9t44Jc5UGIryopJmGWj32+nUHvC
	R2RCJ19r7FsYWS3XtJ2uvWgfXcga4UkbN+suY21XteF7IfZXivjqq+VPkLOz2Ln+N+ZZ8PEzcf1
	rVtWpwLQTrXf8PtxqffDbuwPxkdn55x7KEzg==
X-Received: by 2002:a05:6122:8c0f:b0:56a:8f7c:49aa with SMTP id 71dfb90a1353d-56d4b9c212emr923933e0c.4.1774620242106;
        Fri, 27 Mar 2026 07:04:02 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c54:4d67::2000? ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d31d394fcsm8576761e0c.12.2026.03.27.07.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 07:04:01 -0700 (PDT)
Message-ID: <1672e371-e49c-4799-85bf-44074d444d45@mojatatu.com>
Date: Fri, 27 Mar 2026 11:03:56 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] selftests/tc-testing: add test for HFSC
 divide-by-zero in rtsc_min()
To: Xiang Mei <xmei5@asu.edu>, security@kernel.org
Cc: netdev@vger.kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, bestswngs@gmail.com
References: <20260326204310.1549327-1-xmei5@asu.edu>
 <20260326204310.1549327-2-xmei5@asu.edu>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20260326204310.1549327-2-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,mojatatu.com,resnulli.us,davemloft.net,google.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-272587-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email,mojatatu-com.20230601.gappssmtp.com:dkim,mojatatu.com:email,mojatatu.com:mid]
X-Rspamd-Queue-Id: DB241345CA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26/03/2026 17:43, Xiang Mei wrote:
> Add a regression test for the divide-by-zero in rtsc_min() triggered
> when m2sm() converts a large m1 value (e.g. 32gbit) to a u64 scaled
> slope reaching 2^32. rtsc_min() stores the difference of two such u64
> values (sm1 - sm2) in a u32 variable `dsm`, truncating 2^32 to zero
> and causing a divide-by-zero oops in the concave-curve intersection
> path. The test configures an HFSC class with m1=32gbit d=1ms m2=0bit,
> sends a packet to activate the class, waits for it to drain and go
> idle, then sends another packet to trigger reactivation through
> rtsc_min().
> 
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

