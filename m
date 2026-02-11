Return-Path: <netdev+bounces-258265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIU/CjVtjGlmngAAu9opvQ
	(envelope-from <netdev+bounces-258265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 12:51:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B14123F7B
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 12:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F36AA300939D
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 11:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B5D318BB6;
	Wed, 11 Feb 2026 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtxLVMsQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VydUHVGK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064F7315793
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770810667; cv=none; b=GMpVGAXMiNFN1k9NX1KGg4+5GD+2wO9CDjve511/QNB7YuxatXh4zHNYPL5BcS0Y2+Jx3fPv4JsrDS8pZw2E8qMhOotxhZsGFAWHPD5Da8SL97EB96T3wAGgYFAueRPW/nWsLA/OAy4KJxmwiHfPVzKxHn8X82qVm96zgT6IDN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770810667; c=relaxed/simple;
	bh=Y1GRaTb+Cluqy6zy9whCvgKV50Qh0FqspXSE8R7HZ7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jiztDJdxQ1OI/ftGiL1JefccMuCJLBPIZb8yIu8Scrz7xVSXqEI+wm5Is0Xs1wYBNPaaO+M0+h4NoqtYi37sCezP7M7qEOxR5zdpqO1W9LGOWjAjPI5NC0FUAueokm4tzL2rlBxD/40nkEzMAqCnt1pGAsfct0IsUQAgOuVIYAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DtxLVMsQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VydUHVGK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770810665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RhSjZw86q7JLL8KRuEhtDk2hOfqYGgb3WkEvn7xqpfk=;
	b=DtxLVMsQA/dsrLMV0v1Wz+UeuaJmLn5cMVLlwTSvYj+JJ0cK3Mm5n+rSMZoRLb64AJ/uwi
	t0FOuU0Djl84eirSDRCQwvwWAGvxmngddE6ahENlN/gD9w/Y5hrBHAUACQ0usYfx4RuZti
	godGmD1brMgp+knL6AL6hS5pwmDc7f0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-88nV3Y7IPN-KAFRD7ICC5A-1; Wed, 11 Feb 2026 06:51:01 -0500
X-MC-Unique: 88nV3Y7IPN-KAFRD7ICC5A-1
X-Mimecast-MFC-AGG-ID: 88nV3Y7IPN-KAFRD7ICC5A_1770810661
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47ee3dd7fc8so46713645e9.3
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 03:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770810660; x=1771415460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RhSjZw86q7JLL8KRuEhtDk2hOfqYGgb3WkEvn7xqpfk=;
        b=VydUHVGKvbWGpKLFalSVT/DRb+mZFIC++bXDGH2GigWl99JcSPoTTim/2dCyHEvBp1
         EucBenZI4XDhBoEBzUH9U4efFxoVgJ46zIUtWqwpWxZ7e8psOmRgkSBfkl8ebbBVVBXn
         4FGTy2goVa/QtFKDsRVkDyCKArcwXDbdYU+/XZJvEDZgR4uTvxhYjy0JY5PXpvqR0JlR
         qHJjmziIbpH3qRHVQGSaDrFDljKVhX9t88wPd5D0mEpCRWrTiBXpTvUbtqjdcDTlx2Gp
         bOoc6RLED5ekIpFaLOhnTWqa/nv4Ov7PYROWOja92UfS1Yo+xqL8CvFlCHu86uNZplE4
         Ptww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770810660; x=1771415460;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RhSjZw86q7JLL8KRuEhtDk2hOfqYGgb3WkEvn7xqpfk=;
        b=P0RgqwtRZyiQJCD7qhP9q/PmKVlBX7wIN8nexX/+aVFUSeBSw8qv7g7lyHJXBEHS35
         +fw7o/YKcNxlIGAVmnOzRKYxAeyPt2kxuQj3qQI3o8VzhpHGcG9BUytPFGxFsgCPZvrf
         U2PKkfLUSQez1WcJU+I9vAK3CUnvTogLKyePtjLe4/aR/lBeUs+kUV0mPoluDtuvBDHt
         t58uuhz+Xkyoub97YxFIyDZWFWcM3nhe1cKdEYM57dNq9B6Ow5g88glByuIE5nv4jWq4
         XMI5269qPW26qR7egANOk5siJjaGrr634BiNwwFAGj6eyMTmnsSipfr/pckCHYyP+SMh
         ahRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp23MtbpQlMphpnJnfVsz7hdcHxPD7Zo0xHr9ild20agql7NIQq9049ihy3jfxrt1lwENVV6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRMbtBWUaE2h7gcQ+svZSwxDySmbdK9kHKiHcgDoTN4bqU9e/q
	RuZMm+71BsXwQQaGwRNcmLl2aM+A/5NFERWwg7IOSayCh47UsVVyigD5hrZRTC+JxrKmhhFm9V9
	x8+z8kQyzpWAQ+Nsv07swQnTpt8xG9isrROtayQ22I135qYdEXLUGww7EMQ==
X-Gm-Gg: AZuq6aK7UbkicNuCyTCxlHFqnyhdBYcHMhlwVENtJtqwngTVBt/UKtYdxsmSS5dKjmO
	aoqFLWTcYbQMBEFrt2FzIQbP+6MmFnIptg+Wdift8tLl6F3CChrfI3wOCW6DEQtMeUZ5dz0EHyY
	1F7WRhuHQ0NgGIdbw+tO+NftnwnSbS2dOIE66uTvb4RBA0XXJElPXcR6ea1PD0nG7nPBvUcJ/ao
	NHjp8qLlp3QRNUvZWoM3zP20TRJzQq0DdN3D6k4SVL3/lPvYKQFTsyi+DRBwDmT1Dx1H0w86mep
	cdzM8ms+qWsrZZAB4GvRvn+CWMYRChN3/9lNL6emhRgBljDpANluyrpJ+niXgAWpdsxPm4Gxe6o
	2BIdzgcy0s8Zu3Majh+hawkULxQ==
X-Received: by 2002:a05:600c:3baa:b0:483:129e:b573 with SMTP id 5b1f17b1804b1-4835b952e38mr29532765e9.18.1770810660589;
        Wed, 11 Feb 2026 03:51:00 -0800 (PST)
X-Received: by 2002:a05:600c:3baa:b0:483:129e:b573 with SMTP id 5b1f17b1804b1-4835b952e38mr29532495e9.18.1770810660222;
        Wed, 11 Feb 2026 03:51:00 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d82a4c4sm226143895e9.10.2026.02.11.03.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 03:50:59 -0800 (PST)
Message-ID: <d97612d0-09ed-4895-a22a-6fa73abfbbf5@redhat.com>
Date: Wed, 11 Feb 2026 12:50:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] iavf: fix deadlock in reset handling
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: ivecera@redhat.com, aleksandr.loktionov@intel.com, shaojijie@huawei.com,
 Jacob Keller <jacob.e.keller@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <20260207102245.812795-1-poros@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260207102245.812795-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258265-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 66B14123F7B
X-Rspamd-Action: no action

On 2/7/26 11:22 AM, Petr Oros wrote:
> -/**
> - * iavf_wait_for_reset - Wait for reset to finish.
> - * @adapter: board private structure
> - *
> - * Returns 0 if reset finished successfully, negative on timeout or interrupt.
> - */
> -int iavf_wait_for_reset(struct iavf_adapter *adapter)
> -{
> -	int ret = wait_event_interruptible_timeout(adapter->reset_waitqueue,
> -					!iavf_is_reset_in_progress(adapter),
> -					msecs_to_jiffies(5000));

AFAICS, after this change nobody waits anymore on reset_waitqueue, do we
still need such wait queue head? I think a bunch of additional code
could be dropped.

Thanks,

Paolo


