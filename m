Return-Path: <netdev+bounces-301921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kRQCM0D9PGqsvQgAu9opvQ
	(envelope-from <netdev+bounces-301921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 12:04:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3E86C477C
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 12:04:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bynar.io header.s=google header.b=ei+leeca;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301921-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301921-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bynar.io;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E78C30093B1
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 10:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9640A3CDBB7;
	Thu, 25 Jun 2026 10:04:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B6B3CCA11
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 10:04:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782381883; cv=none; b=uL6iOg0tHhsoUyGBm36AvQXS7uAahC+rLaY4/QcAvl66hSRfBBZsaMiYqJ0fqEja7qLQaD/FcAGL/9GJZ0y1dDqI7FPQ3JeR4s276gIPCvCU76RMIKfSi8acavnIZnSpwAmy5HKDEvXSoH2XAw0bgfV+4LwrPg11Puc9ezVaY1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782381883; c=relaxed/simple;
	bh=QDzsnUqwF537r9M0E1hQPClNIzZvDM04Y5WP6j505Wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GA451PGu20HHVEVzv9kmOdN/yqKjfS29LFyyRI8DWFSjCvWgAHMXzMa4hrjDk8B21G0DUfBNLhBKitYaCRmBzxNgeYf+CADglzprY1fJ3er3tduQbKIhzV/NG8fd3E6Rp3TKs/HqZw+EstcNBb8Qzw50+qpgNUve4Fet1pHGx3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=ei+leeca; arc=none smtp.client-ip=209.85.218.54
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bdb3fd39045so366955666b.3
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 03:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1782381881; x=1782986681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJYAU8T0dbhlhhmhVee2XR5nvnk6dSr8CYdyAa40XFg=;
        b=ei+leecaUiNHpzoJq5zGwFQQFuXAYLl5v1CQCsxXboYpvqbAfN194AluhmXOUgvbJJ
         lSIZT+cKy/QQ81e5LEu7DF4PyNTM4HPxwIY+xSVn95aw9N80abL59QXZsJbSMXIbQguI
         B4mcJAbS86MZaOmNy5TLKORTREi4E80meaal4J3e0a7T+3j7mglxutEyaTEuhtgcUpha
         g799wETasNy7+QE+Z1Ma77Ust9g3usnXqFv+EULoM+rqXhnWUZH2bVzDrBWVLE/MP1iX
         Utt1CG6QarTZwQ4kIhpu9wKFo2pnDKbVBmBreNKhXBMIkyTXxV8fCqg0N32+KAr1oXrR
         U9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782381881; x=1782986681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJYAU8T0dbhlhhmhVee2XR5nvnk6dSr8CYdyAa40XFg=;
        b=Lygi/fci3h5E7H8sxXb3URXXQ1pVaDgwhUvlk552yTWAAy3wzmQ28uuPGCeoexcFVf
         BxQVqZUN/bXQJvH67woIYOjFAlejY0wPYSGzZ/YUuCOo4k2ETrTUPn0wGZjo9e40UbvE
         NenXhc1UC0p+MCCD7rY4XSRm7dDHidvRd/4BcjFTnl8Fq6VMTUOC86s8NCGzaK/jLl0N
         F4+vScK9epT0LaGHgS3H/PejXtsRNRJPi09fwEQYr4T2RbnGzRqm8GLUxmK937u7uJod
         EOQxanNp0NV4FWGlo6xpLQsrgiGFYRLXmLxEY4hCg46qSYbWKNnkHTor9cR1GIwtouep
         iwSw==
X-Forwarded-Encrypted: i=1; AHgh+Rq2JgeDnnzeddaAJMWguw3auDgb2vxzxdUR7vabF9Br8ER9k62bq027ezu1KHmGaa+SpiFHQv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqE7fkD5I0UC2tEZ/ilLv2ncng5S+76PSPrBWLz+NywekLmxfM
	0uVV+TWh7PIrRrm0bySfok3JUy5WOlmHlqCpaDxngC0Ees8JyCLzv9z8behC4by+j4jw4piNrC4
	5PYgREw==
X-Gm-Gg: AfdE7ck1grtOEfb+aolDkPrPy/Hw0YKzaWkpktE4Hfy+kBzUfZiUn7zWPK/T8cIOWcX
	3Nwtp4YdmO2KatR7BPNjIVgQd8MEWwk3emKxhMjEzT54Cq/YLVtnUAQxn5FJoQryELDEC3N4Me5
	1vilgeFVBmImNmz/roKv5U6peiNNqJE93IvXFrF3htycJSXMKKGewW7qMp6px5gJb3gSpGBBmJy
	t2I9qbeHsTTOXJqC8FNaVowzf1ovDj7iOnSGUFUZpm8KL0t2Cs9FY2qXiBIY9zhePB+1zOQkAL6
	Z1C01mgzW4kAhVcmq/+oLJE6zZJiuxzuArIarYw7rmlaIU7Gd5lsQwIX6vVUk2sUkKqd8H44Pb0
	lbwaNE6DLhlmpIIwagfQNPJ2qXXeUOHoe3u8LKR9zJr2F1i1t6PdAEzRgBSfgbyAOxh3jm7Yv9a
	UAbdBWRwPAdLFZNjfh9LcR5PnytxfAQQEyNQiYnPKqQCdINA==
X-Received: by 2002:a17:906:f5a2:b0:c0e:840a:79a3 with SMTP id a640c23a62f3a-c12061eb76dmr128400266b.52.1782381879743;
        Thu, 25 Jun 2026 03:04:39 -0700 (PDT)
Received: from ?IPV6:2a06:61c2:d427:0:b321:1c7a:b072:326e? ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe05cb3sm150309966b.35.2026.06.25.03.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 03:04:39 -0700 (PDT)
Message-ID: <ea447873-9222-4b75-8090-68d08e53097a@bynar.io>
Date: Thu, 25 Jun 2026 11:04:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] nfc: nci: fix uninit-value in the RF
 discover/activated NTF handlers
To: Simon Horman <horms@kernel.org>
Cc: david@ixit.cz, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260623234126.214667-1-sam@bynar.io>
 <20260625091828.1170615-2-horms@kernel.org>
Content-Language: en-GB
From: Sam P <sam@bynar.io>
In-Reply-To: <20260625091828.1170615-2-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bynar.io,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[bynar.io:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bynar.io:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301921-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sam@bynar.io,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:david@ixit.cz,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam@bynar.io,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bynar.io:dkim,bynar.io:mid,bynar.io:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC3E86C477C

On 25/06/2026 10:18, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> nfc: nci: fix uninit-value in the RF discover/activated NTF handlers
> 
> This zero-initialises the on-stack nci_rf_discover_ntf and
> nci_rf_intf_activated_ntf structs in the RF discover and interface
> activated NTF handlers so that the technology- and activation-specific
> unions read back as zero when the corresponding length fields are zero.
> 
> Link: https://lore.kernel.org/netdev/20260623172109.1105965-2-horms@kernel.org/
> 
>>   - activated: with rf_tech_specific_params_len == 0 the same union is read
>>     via nci_target_auto_activated(); with activation_params_len == 0 the
>>     activation_params union is read by nci_store_ats_nfc_iso_dep() into
>>     ndev->target_ats.
> 
> [Low]
> Does the third scenario in this paragraph match the code?
> 
> Looking at nci_store_ats_nfc_iso_dep():
> 
>      static int nci_store_ats_nfc_iso_dep(struct nci_dev *ndev,
>                           const struct nci_rf_intf_activated_ntf *ntf)
>      {
>          ndev->target_ats_len = 0;
> 
>          if (ntf->activation_params_len <= 0)
>              return NCI_STATUS_OK;
> 
>          if (ntf->activation_params.nfca_poll_iso_dep.rats_res_len > NFC_ATS_MAXSIZE) {
>          ...
> 
> The function returns NCI_STATUS_OK before any access to the
> activation_params union when activation_params_len is 0, so the union
> is not read in that case.
> 
> The sibling nci_store_general_bytes_nfc_dep() has the same early return
> on activation_params_len <= 0.
> 
> The two rf_tech_specific_params_len == 0 cases listed earlier in the
> commit message do match the code (nci_add_new_protocol() and
> nci_target_auto_activated() unconditionally pass
> &ntf.rf_tech_specific_params even when rf_tech_specific_params_len is
> 0), and the KMSAN trace quoted in the commit message only mentions the
> nci_add_new_protocol() path.
> 
> The ntf = {} change still looks correct and necessary for the
> rf_tech_specific_params union. Could the third bullet be dropped or
> adjusted so the commit message reflects only the paths that actually
> read uninitialised bytes?

Thanks for sharing the review.

This is valid feedback, I'll fix up the commit message in a v2.

