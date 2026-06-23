Return-Path: <netdev+bounces-301402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vdX/NmCsOmpgDQgAu9opvQ
	(envelope-from <netdev+bounces-301402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:55:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 829BA6B87A5
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:55:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ieee.org header.s=google header.b=TplHOpRx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301402-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301402-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=ieee.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD5603070F15
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 15:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4D33090C6;
	Tue, 23 Jun 2026 15:53:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD3C305689
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 15:53:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230036; cv=none; b=icCfNuaCz727zr6KqXuKBlBC4cwQu+B2+ZXSizgaU0KE5X9ioMp0KTMJBNqsCfPbeJLpZ0kL4WHCDzZe1B7Q31BWPWvMIZ1bf2CVaBLjvoasGUyUumjrR3ebvc5yCIDwYBDm/YOYvGL+VdcD6X3uu2+pBzMmgZ6VFnYGUOKrIcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230036; c=relaxed/simple;
	bh=zYXd6ReU2WdIxJbOFNrBVnjOGqbTxv1cNEEG6ENsyng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDMSUnq5oN+uEQtaKpdxDAzIpEFWsWssQn/SjCMcFza/j5VHDexsRQNsBlavghAVCK24AeFSSZ1ljOGSpiZzFJHG0JxZzZY5ufKLJy2087h3PPZA63Wg4iuFC9BZRp7psud7xTL3DBXU8WFAKHfVj3P8eGIpJ5hr3u4v9UCKMjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=TplHOpRx; arc=none smtp.client-ip=209.85.160.171
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5177945a279so60377101cf.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 08:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1782230033; x=1782834833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XqPTCm5YKqWQJxJHEkoz96y23iqGtdrjAIIsxTeKqR8=;
        b=TplHOpRxxkKEVbj69AkhMrHVomYawMCyP4bLfnOyq/jBZrXkIekITaun9qKutsGkS1
         MjiW19zEzdDDcdZHnY+Ji+ZyQUScG/8t+67fLBI6HA3KCcpg10kEqULJsZe81e9s9Z1h
         3t9FnqjKHNO9b1BFIkC7caopC7GFCAC7hReQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782230033; x=1782834833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XqPTCm5YKqWQJxJHEkoz96y23iqGtdrjAIIsxTeKqR8=;
        b=KutU9x8gfCrHsK1o1S4bQ/cNePKAkgcJ7/Ke2aqOdT6OX9vy7X2ArUWEM5cNUTtakw
         Hqb4tBcnKKYZrNRLWLF2P7c7W3jnYJeB7Asa2D8CsiRGcOM6ZIgvNyTCOsT/9ngvU0zq
         9MW5OqQur6JUl61dRZDWBFRwDsKDHkKfbySxY82UyH2SbrsS7poMFY6H/4oxrwbbLF6C
         CDhqZ0Pv+IoqYHkCAVT/+jWEP+psNM00c56dCi6irnKAlZWDztAYyNvbrgeJIYBerRv8
         fPybIVLqkjjfZ8wZ7M7sqJD+22WdZGnSWM/RLNLW2LXSKPqDhFPfHU9mqTJdiugjs9sb
         nBhA==
X-Gm-Message-State: AOJu0YyYQpFNY4DSB3hXKx/OLyqX9MfqKsjZ9l7DqyrgAbULBBXPjmXR
	UhhdHsbp28/k6uZ7drzP4M4pX/u4gaBaxSdZhsnI6Rhp6DuogkXSE2XpUIOKHS8nRg==
X-Gm-Gg: AfdE7cnFIZ/13nKAzCdTZ8ofN9d+ShXYTwIMN3yJwMDsCJF8hAfTf9EX8t/HhxRPRAR
	XI1FzQWFJMN/Rrtvn4BXI4pcSbkgRc1I/QIrkEIrnNVQapMQqjngjM+vSR0uI5oc0MA79/qMrxR
	7/W1sFlbsYqSivXm2Ph57pBPUgM6JxmLvFyPzy2GmCweTKZYcPQxfkIMFbXYmHgzIyU/wAccqn/
	A7lvaV3sqQThC9FOoUZsVo1xEpkwxlkcq/IGF+gEdG3Q1Mta+anf2eL9CPHvp1mBcV7qSP4YWgn
	1SH2h0K1IH9Dw/nfjYc4/PsPLNRZWK8Xi6zH17MZQzJsnevGzkUyBbzW7OFShoDQKN2u5sKQVhv
	a/42Nx4YSFYOKfMASW7c06iCj5Uz8szRf3x5zEdPTZbaWoxMTGNijB3dknUoAWIMlM12gkyggDg
	D2oTBQg89p
X-Received: by 2002:a05:622a:91:b0:517:9e5b:919b with SMTP id d75a77b69052e-519e4c8ed1cmr286911061cf.47.1782230032727;
        Tue, 23 Jun 2026 08:53:52 -0700 (PDT)
Received: from [172.22.22.234] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-51a514b4f5dsm26143431cf.1.2026.06.23.08.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 08:53:51 -0700 (PDT)
Message-ID: <526c68fd-684d-4593-8c6a-e08aafdada5d@ieee.org>
Date: Tue, 23 Jun 2026 10:53:49 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ipa: fix SMEM state handle leaks in SMP2P init
To: Haoxiang Li <haoxiang_li2024@163.com>, elder@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260623031831.1788454-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260623031831.1788454-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ieee.org,reject];
	R_DKIM_ALLOW(-0.20)[ieee.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301402-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:haoxiang_li2024@163.com,m:elder@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[elder@ieee.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ieee.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elder@ieee.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 829BA6B87A5

On 6/22/26 10:18 PM, Haoxiang Li wrote:
> ipa_smp2p_init() acquires two Qualcomm SMEM state handles with
> qcom_smem_state_get(). However, neither the init error paths
> nor ipa_smp2p_exit() release them.
> 
> Use devm_qcom_smem_state_get() for both state handles so the
> references are released automatically when the platform device
> is removed.
> 
> Fixes: 530f9216a953 ("soc: qcom: ipa: AP/modem communications")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

So I guess they were never "put" before?

This looks OK, but I'll just mention that the IPA code
doesn't use devm_*() (managed) interfaces.  So it would
be more consistent to just call qcom_smem_state_put()
at the end of ipa_smp2p_exit() for both ipa->enabled_state
and ipa->valid_state.

					-Alex

> ---
>   drivers/net/ipa/ipa_smp2p.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
> index 2f0ccdd937cc..d8fd56949082 100644
> --- a/drivers/net/ipa/ipa_smp2p.c
> +++ b/drivers/net/ipa/ipa_smp2p.c
> @@ -228,15 +228,15 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
>   	u32 valid_bit;
>   	int ret;
>   
> -	valid_state = qcom_smem_state_get(dev, "ipa-clock-enabled-valid",
> -					  &valid_bit);
> +	valid_state = devm_qcom_smem_state_get(dev, "ipa-clock-enabled-valid",
> +					       &valid_bit);
>   	if (IS_ERR(valid_state))
>   		return PTR_ERR(valid_state);
>   	if (valid_bit >= 32)		/* BITS_PER_U32 */
>   		return -EINVAL;
>   
> -	enabled_state = qcom_smem_state_get(dev, "ipa-clock-enabled",
> -					    &enabled_bit);
> +	enabled_state = devm_qcom_smem_state_get(dev, "ipa-clock-enabled",
> +						 &enabled_bit);
>   	if (IS_ERR(enabled_state))
>   		return PTR_ERR(enabled_state);
>   	if (enabled_bit >= 32)		/* BITS_PER_U32 */


