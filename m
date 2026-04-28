Return-Path: <netdev+bounces-281999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPCtCPHn8Gn2awEAu9opvQ
	(envelope-from <netdev+bounces-281999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:01:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C2A489871
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EE0F303D2E5
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C246533A9E9;
	Tue, 28 Apr 2026 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="gVFY5SGd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D562B672
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395247; cv=none; b=U5weI1Btu4tcWyPj+mVRYEY7573y4yhTOiAjjgo+mj6CZT57KBPhz97dFIAxux02nOGudT1saApIiQHZ8CNfJGO8vGgRnoO0HdW9saeHEv2ljivE4XvOgi48sZ3hJTbfySyE1slak4DhHwD3K3qnyS1iMYoDw2PpAvK2vGyGvwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395247; c=relaxed/simple;
	bh=rzWf/oQSHbkLcV8GwzpmrSWI0KfR0fCQpV3xi0rt5Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eOJzkMpXnS6BXFuqdaGHjBE5U4c12r2UFE3yxZ3zoOJxXirXpxuI2ODCcr9f3Gt+n7gRbZKdi3hhVhGO6bQgQPT0eaSpUairmrfGhacu8Pc/WrmGC0EuqwsxL/ZqXzlhAbBaOXWXWlLdydUwiOnw0uVzVRneIsw5cImQCfwWBEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=gVFY5SGd; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-662efd1bdd4so18547eaf.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 09:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1777395244; x=1778000044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3Z9r4IpEjJMUHPOqoRO6rW4qYst7QOqGLcntOF/K5A=;
        b=gVFY5SGdeZ2JrpdQhfBOXtmU5OBrbNQbhEkaFelzzC8oIWbT3S+tNOJrkfLM9fewnq
         Oh9d14toNjEhcJm8pUr4qhRqyuMFBdQBuJLymgs//dxzGjLfe2/k7B/8mJIT7/lci9eY
         lJMTxKnO9jwE194fEOlgT0QYHkmt9cDMVFPYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777395244; x=1778000044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3Z9r4IpEjJMUHPOqoRO6rW4qYst7QOqGLcntOF/K5A=;
        b=IkZrSiRbj8UN7T/ZZBinSYYODFG3YdOKMVlK6lxj5pdxKp9RjHtLgy4911HMhMnFDh
         LsN6SNZ/ryn9INpaVTEEMGk45Tub9rBtbctf0RR2AeQleNYIszAX77hwYQcb2o7miuS0
         BX3Ir3IQcE8bvJy7/2AzZIUs+E2SVyKWN7X1ZW0047d94vycRT/y1MR5P89u9bL7vBYi
         7alBOf8AMuveX8aDQIgCIx8xV5bdsO1lzYmwWa99/4Uy6RoqYTwrtEwFWFMp/8jrRBoz
         p/5U3i2ye6phQn01jeYDJmmITLljIYWa6al3bs+MhyqCIU9G4rpg4zeO/Yzk1GxASjUX
         Z+VA==
X-Forwarded-Encrypted: i=1; AFNElJ9AzEGNNnwH3E0iJ259ylV6XPDHKesjzJJ+K8bRp4pVlUeZO4ENHNdhAwHZSfgCv+EhjmT401g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDSXZgRnGMs1P35T+wbTo0HYIWgnKpG7LIiZ2f1mfPd5IfeLB7
	N5d7T2HmbmJblluvJuvO6vhtuyPrdajiaQzFOKp+/pidwsJoR250RofgbjOFVJoXaQ==
X-Gm-Gg: AeBDievBCyNa0chiUy38XzexM9lWjlhA2WxE1bcsK/Yw1MxQHuga2XJowlnxOML5/Ru
	WYg1a4g3G73ptidgFeAkYSA9ZF7UC93snuQnr3LIJOMIpFwvU5eDDQgfXrHBl6gr/bIOSm+Yxyy
	f02NEHj6ptKXDUUQEbLJFqTAFzQkG4ZfY9zMORyYXWJRUAKMQGLLnlmLxY1ygNUwNntd9pnf4AT
	VGndVYyMo20XIDlwOwYaHJr6n+47iOcscQVdYIBr6ui65scNpodS7RhyvjokAjtLecPl6PcWRSZ
	CBNZr+CfSzT4gXX9S3vdqLziL5RWXo8GXhblsmkDCY9UTSGCYPUuzhp9TYVuY0wjiGrhbNudv0n
	rkYQH34BLW0Mr1hbWXQFjj1CX5emojAGY4+sO5TN4OIdNOXfyfcL+do0P9oVBundWdE4Sttqgek
	0UKhw9sRV1bkE1HpIOot1TTnhnClN5eJei+roEkHl4Bl4wB7bnUN14nOI/kUcaAoFGh7I5Z7x+m
	yVce4g=
X-Received: by 2002:a05:6820:4b05:b0:696:13e9:6863 with SMTP id 006d021491bc7-6965c5ee294mr1871158eaf.2.1777395244239;
        Tue, 28 Apr 2026 09:54:04 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-433effdc79bsm2240677fac.18.2026.04.28.09.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 09:54:03 -0700 (PDT)
Message-ID: <aa2b2823-05b2-49a6-bdd3-622523497a0d@ieee.org>
Date: Tue, 28 Apr 2026 11:54:00 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/15] net: ipa: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org,
 konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com,
 simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com,
 jens.wiklander@linaro.org, op-tee@lists.trustedfirmware.org,
 apurupa@qti.qualcomm.com, skare@qti.qualcomm.com,
 linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-13-sumit.garg@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260427095603.1157963-13-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B0C2A489871
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ieee.org,reject];
	R_DKIM_ALLOW(-0.20)[ieee.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[ieee.org:+];
	TAGGED_FROM(0.00)[bounces-281999-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elder@ieee.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[50];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[riscstar.com:email,ieee.org:dkim,ieee.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]

On 4/27/26 4:56 AM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch ipa client driver over to generic PAS TZ APIs. Generic PAS TZ
> service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Looks good to me.

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
>   drivers/net/ipa/Kconfig    |  2 +-
>   drivers/net/ipa/ipa_main.c | 13 ++++++++-----
>   2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
> index 01d219d3760c..a9aff1b7977d 100644
> --- a/drivers/net/ipa/Kconfig
> +++ b/drivers/net/ipa/Kconfig
> @@ -6,7 +6,7 @@ config QCOM_IPA
>   	depends on QCOM_RPROC_COMMON || (QCOM_RPROC_COMMON=n && COMPILE_TEST)
>   	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
>   	select QCOM_MDT_LOADER
> -	select QCOM_SCM
> +	select QCOM_PAS
>   	select QCOM_QMI_HELPERS
>   	help
>   	  Choose Y or M here to include support for the Qualcomm
> diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
> index 788dd99af2a4..3cd9e44680e9 100644
> --- a/drivers/net/ipa/ipa_main.c
> +++ b/drivers/net/ipa/ipa_main.c
> @@ -14,7 +14,7 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/types.h>
>   
> -#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>   #include <linux/soc/qcom/mdt_loader.h>
>   
>   #include "ipa.h"
> @@ -624,10 +624,13 @@ static int ipa_firmware_load(struct device *dev)
>   	}
>   
>   	ret = qcom_mdt_load(dev, fw, path, IPA_PAS_ID, virt, phys, size, NULL);
> -	if (ret)
> +	if (ret) {
>   		dev_err(dev, "error %d loading \"%s\"\n", ret, path);
> -	else if ((ret = qcom_scm_pas_auth_and_reset(IPA_PAS_ID)))
> -		dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> +	} else {
> +		ret = qcom_pas_auth_and_reset(IPA_PAS_ID);
> +		if (ret)
> +			dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> +	}
>   
>   	memunmap(virt);
>   out_release_firmware:
> @@ -758,7 +761,7 @@ static enum ipa_firmware_loader ipa_firmware_loader(struct device *dev)
>   		return IPA_LOADER_INVALID;
>   out_self:
>   	/* We need Trust Zone to load firmware; make sure it's available */
> -	if (qcom_scm_is_available())
> +	if (qcom_pas_is_available())
>   		return IPA_LOADER_SELF;
>   
>   	return IPA_LOADER_DEFER;


