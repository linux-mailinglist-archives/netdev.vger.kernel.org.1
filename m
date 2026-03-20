Return-Path: <netdev+bounces-269994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH5PHYyDvWk4+gIAu9opvQ
	(envelope-from <netdev+bounces-269994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:27:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 073822DE9A9
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E79230576B6
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 17:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CE03D3485;
	Fri, 20 Mar 2026 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2iLMFbN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRl/xyyk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673CD3D333E
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 17:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027255; cv=none; b=ljTeOSZzOONrBdR13vyeEBGs9YTrYKtqSezSo9vUUf3IcYFnJRmH6ol4aGx+N+LqXdPlAAzSP0Ob+MVxwUF0kRPO5WwFY5/5MTG1Ecg+UWFlhqKliiMg9fCdv8qNrksNzOeFQ+ihUf8wSQBD95v30yukedYelEfYagZLD+YZwLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027255; c=relaxed/simple;
	bh=lH/cBIE1Yik3sd1WSnTq623sNscCjK0ppKmaNiwJoOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uf0laEm0yAMeCzZXQuejKkQ+eBzqcq3eB0sn9rPFrYe1+JQRwT6cANEum0xbeu5WBjmJ7GUXGuyXrpCWb+A8DrisnNDkiLn3qzC5WPtFe+eaDM3tbGveOIGGJZPDd09b1ElOsK8h/RXHNi0BLKPjkeVfyvjAnBNJ5mk/9zot+6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y2iLMFbN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TRl/xyyk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774027252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lH/cBIE1Yik3sd1WSnTq623sNscCjK0ppKmaNiwJoOc=;
	b=Y2iLMFbNo68s5PR4jqIbJXq8vQ6JTYUZeu2vpJNa0XJb4qyOWzwKwAgPbQgyirLoZ87i+k
	EJ6Q2FW6dIf4YTFHD6amaGXTQsL9W//z6VzwryHmVU8TdlQTzM/Mcrsnbp5hzqg8+hOUlv
	Vhy41lGql7QnEuvcfRH+nBtbldGwUKs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-iGMA9ALUPFKqsUmtprbOZA-1; Fri, 20 Mar 2026 13:20:50 -0400
X-MC-Unique: iGMA9ALUPFKqsUmtprbOZA-1
X-Mimecast-MFC-AGG-ID: iGMA9ALUPFKqsUmtprbOZA_1774027249
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-486ff4498b2so6204965e9.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 10:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774027249; x=1774632049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lH/cBIE1Yik3sd1WSnTq623sNscCjK0ppKmaNiwJoOc=;
        b=TRl/xyyk5QjOFMJGo0Lc2FRNJQ9pSewge1se9dwReeC6nCb6pTJA7A7y0K+nBvyYCx
         SZkTbZ5gNXA55VwcLHruuRek5GBkXIlTJAgrXpZeg9I+2lORzhsb3P2ISaI2TCl1fJ0V
         Ezyf3cNE8PUtiSOxkVUIXPTbat92EIvQaIbr4tTd4tSBFbsvHUcA2Os02d7YXTZR/y2E
         RkvXGK3DRw/S/8Ead8jvwWojB8Fw8C/wUfZNFJZHL7pxwjqMUlWSVTlC4ZvMHW6xt6lV
         +d+03jYf8krY/UCjhgVt33vSy90EomroyNB4NThZ7GCuP5MYLXrMGSKvEuFxlSOXmNjK
         rlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774027249; x=1774632049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lH/cBIE1Yik3sd1WSnTq623sNscCjK0ppKmaNiwJoOc=;
        b=Y/X9d6mwzLIr19bbvgahbilrH8dJDY6SFhx+82P5vVgg6vLIrzkI4spgrgJfpmXLws
         dlpz1gL7JtLHukfZqMhQTz40hqmjTPLn+64RbIflQfrQ+cEmszMxILtWK1+mkJzT1Sc0
         KOaPmD39CkS+/0pNaQ5hXy6Pe9pUZ3duRROTOdkScy0OkD42P2k+HkKnsoSFx1tDIKQD
         3pepsmusmuLRFWCtyT80gqDMfaujMvP45+wJFllpblZDCYe6dAMcIRms42ah+2oopbBk
         IVrIeV6jH/Q6CEBWeY0VGklV3HrrdFS2XR0TulMd0rNuY72nG0aer/pH5MZAZKen8ENq
         aScg==
X-Forwarded-Encrypted: i=1; AJvYcCUoUbiBcFGSlfM2y5x3mgShuZ2rwEuvcCSVc5Yk6oYQH3JlAwFXInR1ppqT5lUYKuGW5AY3Ebg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ+sHWKGX1DZrmYyB1vxKz02WtAVA4XuwB28/BBHDF+dHNLm+n
	sovhhD6ICVXzX3PK7bXpNiXt+Z68VT4ytX7cFIchDPWyzgHnqF/KRsMjloU+1iNrcrjxKJtiCk3
	78bKHkHu8MQwB8b8oPHAUEBeiMKO5KQ1RrjQCCFd28RS3JkjkqhigTZsp5A==
X-Gm-Gg: ATEYQzyPXj7QcK0K02otmr2nZZKOHnEeob1m3qME7EDr7RwzDh3KSN1w5ZQaz7Tw+c5
	ZCxPHE8JZw1im17EqXEqLbtZsL+soiPkdsrrrypmuTY5nIClnHdCA7G8lP+iIU4+HxTl1OpGu/d
	wpnU3BQagR/vWV8PFpFGz1FIJWT3PCmosQz4M+HUi4hSOSe4GqGHJIPweq5RyV0FmMa5Xx1pAhy
	jKrJKyKVUKVSRrlfxqiq1mvJJZjx6BJnDi/VFQMy9hwcw5yQmoV1f9u3BO8yBpIKH3Qu0xmXdOj
	uY+F0mkdLBJSRUAaUSXHpQ8f7+IaZ9eli787p6Kv413JeDCyEf08A0M8k60UyMKdfD+WZGpnBcj
	mYOypgHmco6Ml1DZkX/o43OZPLavpxv4jARq3ZwqvJ9xNPPwVw3EjMSpM
X-Received: by 2002:a05:600c:8710:b0:477:b734:8c53 with SMTP id 5b1f17b1804b1-486fee00f5amr56583625e9.12.1774027249300;
        Fri, 20 Mar 2026 10:20:49 -0700 (PDT)
X-Received: by 2002:a05:600c:8710:b0:477:b734:8c53 with SMTP id 5b1f17b1804b1-486fee00f5amr56583355e9.12.1774027248873;
        Fri, 20 Mar 2026 10:20:48 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe7dc4a2sm86246295e9.5.2026.03.20.10.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 10:20:48 -0700 (PDT)
Message-ID: <9cb6cc7c-5859-4be7-a3af-bd02232f0536@redhat.com>
Date: Fri, 20 Mar 2026 18:20:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v17,05/14] net: homa: create homa_peer.h and
 homa_peer.c
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: horms@kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com
References: <20260316223228.2611-6-ouster@cs.stanford.edu>
 <20260318072119.268920-1-pabeni@redhat.com>
 <CAGXJAmyDuz11NSwGnOopqBiOHeBPh2EFaegDJ6p=2O6-tHvNyA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAGXJAmyDuz11NSwGnOopqBiOHeBPh2EFaegDJ6p=2O6-tHvNyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-269994-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 073822DE9A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 6:13 PM, John Ousterhout wrote:
> I'm pretty impressed at the ability of AI tools to find subtle bugs.

Note that you can use the AI prompt locally, see:

https://github.com/masoncl/review-prompts

/P


