Return-Path: <netdev+bounces-270811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPC0CXjOwWnhWwQAu9opvQ
	(envelope-from <netdev+bounces-270811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:36:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A79932FF039
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DDB6305C91A
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B8A381B06;
	Mon, 23 Mar 2026 23:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmxaN9Cj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792471DF248
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 23:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774308879; cv=none; b=EA3cIH93sWcHwf+ppxF/2eIVZI/dO89JqaGuBlWWewnA3fbWIhyB6YnC4zlJb0pBm+cwWIhzjBwp+K0vB4aDskk3TFonxtQRwm2zjXCofWMXMJGR4artX60GamF5KMUnZeUQyjld8tzAFGFbYoniSPOpDRtlmD5uaiRClehtotk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774308879; c=relaxed/simple;
	bh=L7QMz4vB8Os/q0WnDww/RrHmjg8XTp1gsTUZvu9eBzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDPTsdF2LOtPmutZJfrIJDVUPR8BJOg3AyhR0n8KgLdP5ELps6OSKQRl3F1eLObRj/fhg4ZSannWoiiF8glr0i0raBxlIKVRyYfnCmHnqSlAb4OcHocrs4a2g5fT/sOelXiDEZwfHzvvfeS8yDJbXrcarAjeq/JJzBpPD2zznME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmxaN9Cj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso6170965e9.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 16:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774308877; x=1774913677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JBzDqN+VYDz2vR5aa/Cc8K96YpoxwqdxcpJo417Auok=;
        b=lmxaN9Cjrh7jhqE82yq1mLV2uA17l0MPHwHVnW3R51nfz4AQz/CZD3FZK8ueuHug7t
         Dty8IANq3YODau+4pZW4viyJzhhDQHGkOw7H1LOKzlPgnjXzv586lGzczJMf6MDBxtcF
         BSC+8RN50RF0hGkP66JGP/LyzgwbLmXhV9CIDV2+wwu5p7areabgpJJFComBhEp3YKyv
         mMr5Cdg/gtppQSXfy0kIN5wZkd5Xv4oDxsrb0olh6FUyonx5KT92DUthmhm5bQxSA1I0
         X9D+Mz0zFDZpfM1+U27b2VvZo/9xFTYfiT7EfQGqFWRVHPkOjlzdoFHNsuHhlAZtczDE
         eD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774308877; x=1774913677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBzDqN+VYDz2vR5aa/Cc8K96YpoxwqdxcpJo417Auok=;
        b=HrKSGmod3NyijJXQgBWQVouXplw75czKu9qDjS2ziflF0rnNJqgsKOFCFU2aTFeYA5
         bhyEm0pVZKI2CtTMxn8EAgREOm0U23DHcDHfGFTjSzFlS6/M1lnrJ7+tV6OcxEWeJtbm
         lufdiddrnb+0YefrXzb//dPMb7W8Ulvo8ZSiRt5dHoQX6uZThrTr2EMOUX5Tef0hIQoC
         PHzCEIKgxPUKkJ7CbCyyMzomb22vyc77PT4JFE3A4NCrY2kBk8IVPFfQHg3qakO9sFLk
         ebB1beIYVn638oUblR/ixaVG6O8xVM2jvh+ELcsvQs0VGzkJujghU9A84BKF0BNku0/1
         OmFw==
X-Forwarded-Encrypted: i=1; AJvYcCWgTT9qokMiuALdo8XpTJ8NHQzm8I656lE26n6fQU9iyWNf6+UPIM/X9o+MTKXxrq9y8rXC+cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3k5RNA8xpphAuRKSJak33OVVpVs+wclpQZz7rLpicNsdUJTNW
	2Illxqnf76XCOzha+/NSEruGwQXFHw5VBkALpsPaQwikY+3EQ9RE293f
X-Gm-Gg: ATEYQzzYOu+qFU6TaP0I7Q2VE90YylpT+EY2Pre88MyWJQykPa2QLt8LVBkxmw2umWW
	3SOdWGAuPjdyPDe3BDTqwfbLwtUqTGWsqdl+j96NwmDZHli2aUCNTEALbJ/7rnxwkOyRqcGwejF
	2gstxTS4/Pknthj1EK3AY0GyBijkMBU0TcRIsZ4aHb9tzT6Xj9OhRmb0BbRYbnAdx1hYFbhYm1e
	oQCSnjFUr0UACTa7Cw8naitM4Ywp1Vcyooyaf+KnVgTKm9X1M9pXuLmvvelsk1yOva40HWvW08g
	8z3HMAwefXorq4RrE3NHx3L7m0irWlmGkE2M6/7mgzVUm9SLZz7O1amSmF3ImRz2hc27iujr5l0
	55ooZQ+K78Z//2WLziKTsX8nAJ7S2i81rwCx1Ff0S4u4C+r7idK9yhnfUgW7CW6A3oJrKEay1VH
	XyW/MSIZfQZSrNi3TurtkNNdGd3R0VUlMlERWfd7KtWmcWh5CPHjqTIN7Drj7orPDP0yIAbsgSN
	kQgLarpNH+azA==
X-Received: by 2002:a05:600c:3495:b0:485:3b00:f939 with SMTP id 5b1f17b1804b1-486fedf6b7amr194358585e9.8.1774308876702;
        Mon, 23 Mar 2026 16:34:36 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4870f6c116asm8123625e9.1.2026.03.23.16.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 16:34:36 -0700 (PDT)
Message-ID: <0296e62f-999a-4622-af3f-e0ea40989135@gmail.com>
Date: Mon, 23 Mar 2026 23:34:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] sfc: fix spelling mistake
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
References: <20260322150733.45817-1-med08elkadiri@gmail.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260322150733.45817-1-med08elkadiri@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270811-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecreexilinx@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A79932FF039
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 22/03/2026 15:07, Mohammed EL Kadiri wrote:
> Correct the spelling of 'adress' to 'address' in a comment within
> mcdi_pcol.h. This improves code readability and documentation
> consistency in the Solarflare MCDI protocol header.
> 
> Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>

mcdi_pcol.h is automatically generated from definitions shared with
 firmware.  I have passed this spelling fix upstream for inclusion
 in the next regeneration of the header.

-ed

> ---
> v2:
> - Specify 'net-next' in the subject prefix as required by netdev CI.
> - Change 'Fix' to 'fix' in the subject line for consistency.
> 
>  drivers/net/ethernet/sfc/mcdi_pcol.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/mcdi_pcol.h b/drivers/net/ethernet/sfc/mcdi_pcol.h
> index b9866e389e6d..a9a7076c00e4 100644
> --- a/drivers/net/ethernet/sfc/mcdi_pcol.h
> +++ b/drivers/net/ethernet/sfc/mcdi_pcol.h
> @@ -21387,7 +21387,7 @@
>  #define          MC_CMD_PRIVILEGE_MASK_IN_GRP_ALL_MULTICAST 0x200 /* enum */
>  #define          MC_CMD_PRIVILEGE_MASK_IN_GRP_PROMISCUOUS 0x400 /* enum */
>  /* enum: Allows to set the TX packets' source MAC address to any arbitrary MAC
> - * adress.
> + * address.
>   */
>  #define          MC_CMD_PRIVILEGE_MASK_IN_GRP_MAC_SPOOFING_TX 0x800
>  /* enum: Privilege that allows a Function to change the MAC address configured


