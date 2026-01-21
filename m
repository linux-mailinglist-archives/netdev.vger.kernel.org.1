Return-Path: <netdev+bounces-251795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHhcN0eHcGlaYQAAu9opvQ
	(envelope-from <netdev+bounces-251795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:59:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D9F53258
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB3F04E8718
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 07:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2986838B7DB;
	Wed, 21 Jan 2026 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3DMvwDV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7P1G63L"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1AE44BCB7
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768982301; cv=none; b=SjusJAqeIBPSB8aSJcmbuEQOSUV48rt/ToSPhiVH3Gow6zp1kb+eLBik5KP70QWjDmMDRGD0hKQw8SbOSKWCotllyY+mAicJMWzcb32bbAta2r60bUjKQQckw+06gP4whValsX6t+8eL+NfBheA3deE2pJpAXA0rdl5psoDh1FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768982301; c=relaxed/simple;
	bh=yvTAb2zyJxbyGLlRHGT89BitSAH1SZdALJsqlZ+b2z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udPRCK8S5r4sNRa9xB0vU03tmg/7/r4BV6WTt3ZVkUUrOSOG3Iio3YMCKS5buBCLAT6jscHmZcNzjggHhzP5o2wU8dyvIEB4EFAQPMVds1Rb+C/lM4RZSfDS7Wa83ZMcgfyBUQc4i7P1BKNPNJmIbNs0YhoruQMV4uw0QtT9py0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3DMvwDV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K7P1G63L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768982298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xxvpO7SuR0Srs/NDxoqT0f/eYAD5mZdjyHg/RVhlFCs=;
	b=c3DMvwDVAindHXglwcwdgszjrOV8/vecj9EMP1aLixRty6MhR32xsHHcr7hv+AELvtEG66
	ft1y85eWuJ6VlZ5acUieIugLqeoVf9mhVD6HmgAmTk3TQkbzf63TjTKwQVM6fsqEJx0GWK
	j4hz8tBYNyYwpqauJseKKrha4VipfdE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-QDr5AGcrN8eZPQxfitKaDg-1; Wed, 21 Jan 2026 02:58:16 -0500
X-MC-Unique: QDr5AGcrN8eZPQxfitKaDg-1
X-Mimecast-MFC-AGG-ID: QDr5AGcrN8eZPQxfitKaDg_1768982295
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47ee71f0244so54845845e9.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 23:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768982295; x=1769587095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xxvpO7SuR0Srs/NDxoqT0f/eYAD5mZdjyHg/RVhlFCs=;
        b=K7P1G63LGX6IvHLuqQdZZEm28D5707Ixxr2p9sk9M2pIdU//6UxhnbEe1kI1P9nbAf
         2VuOUz3cPpkGv/iI3b9YeWgDGZqKQtQA7w6jjJwky9iTnUa0nWNH1PiQTswza3Vv+b/F
         k94V8Js3H7mMO+zfxlF3Xfms5FbYvuNTsrnVU90nzEm/PY1oLDYtrb5M/IeVxkKg2h/q
         aucKT3CiEmF8IfgjYufgmRW7Q1uAnoq/F8z28Zv/aVJrzUcExpKtzvyF0ecUsif7qhgd
         I3pY/R5OYvtw0au+zAZ7Ti30v7cbtJyPagD2o9mKyNuhHT8xe/PUCQm/MGfLQMnd1i1f
         CBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768982295; x=1769587095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxvpO7SuR0Srs/NDxoqT0f/eYAD5mZdjyHg/RVhlFCs=;
        b=bnNdnGNUPe/2azCcy7WAE00uS+qG5Wa3h9JIRPFfj7mAdHgg1yZVXn0ETBPzbYlFgS
         GWDaIm0Bllr6e5Z7bzMUSGwzfne5wI8dGMdgkl67bOFYXXfmkN+u+Gn95sb2ttMzlRaa
         s9/ZGGYq5/dxcxyD+AQfpSglr49mMVbmWXYRXXGZs9m1kDVkRSw6pbeTdT2++p+Zndix
         ncMLBJAZW3mmHih8vphNKmIoBmlfPqtzvoT2QWb3SXGoyvDqgByzBwGYgqOQWSd7W1e6
         EsA2U/pXVJmHBhOImC1W/TwI7enTRbcZjZW3DnuDiIIVsZdi3qEfQ8ZEkyRzc3i6Dfey
         5vVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHlEGoSpgwjIAVWgIebfudoHxDPj3DXYWinb6tmP/1cFeTME3p8cT0uDNGhBbPJJvvVTzg15g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX6QncghAXTrAEO6zwmzG1I1WxGPU9FJoPDJqzfpIW1oqFCFLK
	5Ylr4/92tByk61UYAStx2tITp7w7bTlbxrEcdWASSpukUoE7REqOCzDLGegjhScBfHVDGqEJmG6
	2BPuVeOrJbfDJnbuvCS5eXAFu2gQfhb+341vz0KOLGvxOda8fHlm0WhIo9w==
X-Gm-Gg: AZuq6aKWlDB3gADnjgCEs3yDzRZhO7d9uCBR7WztjR8fSbms08sqgjQVHomDetXfe0h
	Wu1uKU1dyK28TtG5v1JTxC14jfOs4KNTud5JXvI0WA+u/TxqyV/rgyodBUPfxOuZBSLG7Q7x0HY
	rlTG6vrz+MWO8/Ahzsz0rI8CckDoMDgtSX1jApS0gvoAIuRRnMUiwm8ZWpkGzpTVId2aYWWDqF+
	0AMjrLTsrEPfXohxvx5r7+wBGZrMBe5zsZ3VV6983HiqVEjWnfzJGSPc6eaeVrWVb4Xj4yucp5n
	GZByESN5R7O/2L748/SRB1agSw+9H8QXPwXHHamst51jiLyvsaIjXG7E/q1uah3nUShR4INCBnf
	FSjcPOAJYf9FD
X-Received: by 2002:a05:600c:1387:b0:47a:935f:618e with SMTP id 5b1f17b1804b1-4801e30ba55mr255746925e9.15.1768982295372;
        Tue, 20 Jan 2026 23:58:15 -0800 (PST)
X-Received: by 2002:a05:600c:1387:b0:47a:935f:618e with SMTP id 5b1f17b1804b1-4801e30ba55mr255746565e9.15.1768982295020;
        Tue, 20 Jan 2026 23:58:15 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.175])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48042c56f4asm13906205e9.15.2026.01.20.23.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 23:58:14 -0800 (PST)
Message-ID: <eaac2f5e-842e-4a18-a7a0-8a7ba2794ef9@redhat.com>
Date: Wed, 21 Jan 2026 08:58:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 2/3] bonding: restructure ad_churn_machine
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Mahesh Bandewar <maheshb@google.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 Liang Li <liali@redhat.com>
References: <20260114064921.57686-1-liuhangbin@gmail.com>
 <20260114064921.57686-3-liuhangbin@gmail.com>
 <20260119122203.5113b16f@kernel.org>
 <71e30492-7644-4d4f-aaab-9a505f8faae3@redhat.com>
 <20260120151109.2d483bd8@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260120151109.2d483bd8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251795-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 56D9F53258
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/21/26 12:11 AM, Jakub Kicinski wrote:
> On Tue, 20 Jan 2026 09:29:14 +0100 Paolo Abeni wrote:
>> On 1/19/26 9:22 PM, Jakub Kicinski wrote:
>>> On Wed, 14 Jan 2026 06:49:20 +0000 Hangbin Liu wrote:  
>>>> The current ad_churn_machine implementation only transitions the
>>>> actor/partner churn state to churned or none after the churn timer expires.
>>>> However, IEEE 802.1AX-2014 specifies that a port should enter the none
>>>> state immediately once the actor’s port state enters synchronization.  
>>>
>>> Paolo, how do you feel about his patch with 2+ weeks until final?
>>> The first patch is definitely suitable for net. If this one is not
>>> it should not have a Fixes tag. I'd lean towards getting them all
>>> into -rc7 if we can.  
>>
>> My personal preference would be for 2/3 landing into net-next: the code
>> looks correct to me, but refactor has IMHO still to much potential for
>> regressions do land directly into net and the blamed commit is quite old.
>>
>> I suggested targeting net-next while retaining the Fixes tag as we
>> already had complex fixes landing into net-next in the past.
> 
> The appropriate way to delay propagation of the fix to add:
> 
> Cc: <stable@vger.kernel.org> # after 4 weeks
> 
> not to merge things into -next.

I went over the code as carefully as I could and I don't see any obvious
problem, so I don't have a so strong opinion vs net, but to hopefully
clarify: my thinking is that this is net-next material because it's an
invasive refactor with behavior change. My preference would be let the
code be tested in next/net-next for a while before landing into mainline.

/P


