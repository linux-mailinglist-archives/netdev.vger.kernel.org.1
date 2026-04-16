Return-Path: <netdev+bounces-278971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFK/Hk2f4GlukQAAu9opvQ
	(envelope-from <netdev+bounces-278971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:35:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A4040BA34
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B4CF301C91E
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 08:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A604392831;
	Thu, 16 Apr 2026 08:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CP5gIDlM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsTsjsWY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF083921E6
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776328225; cv=none; b=OhetdVgB3wZjrbZpUTpqh0DQI2+0g82jGkKu+0CF6MIcnJkyTjzA8mcDg1W58Yiy+wlxSe2rdH3aknA/IsDt2FclGCh9Dx+ocei5WLg2cQjKGnxlYwc4d3gn9AeuyA1KP/RDzc+UDmeeR3VX+VeDgfmyKcLRTeWlgs0lbA23Au4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776328225; c=relaxed/simple;
	bh=MgB84sI+aPQk6PJENbmbPfGksdVTNyZGfOgLktludpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=luAyznb2gorz5L8f5rKGCqcWqS0ND67pKgDMQ3H+zxs+P89zxOaM0wOu33ULxk9TPWoVuG4pAsfFY0yrliYRpUnB7SErIlXHzJ+wxZSIBx4HGcaPinwTtu2Zg8upv1/DteB3ZoRZyWJKPbViezO86yAUFYg8bym5yqWd5P9cFjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CP5gIDlM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GsTsjsWY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776328221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ok2jOImuVFQ7GtPJheZIafb+EzCFhJ0KF74mw1kUE3Q=;
	b=CP5gIDlMF3ioldvSXc22QZ6f6e2AkkViWWg1BdyYy4+QW8qXzMzW9WMPRidq/uJhZxe47y
	juDG9UUd/18U8xgqrM9IymDCNEgPl/FA7arq56QiP0omsSMVf2LZiQSPgFvaYknBw3YZY4
	hNr9AbJSAZ7WPpQEMMTvsPspb9yHwUo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-jz1U_X9jMmi4havYsojmwg-1; Thu, 16 Apr 2026 04:30:19 -0400
X-MC-Unique: jz1U_X9jMmi4havYsojmwg-1
X-Mimecast-MFC-AGG-ID: jz1U_X9jMmi4havYsojmwg_1776328219
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488c2a4e257so50166535e9.3
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 01:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776328218; x=1776933018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ok2jOImuVFQ7GtPJheZIafb+EzCFhJ0KF74mw1kUE3Q=;
        b=GsTsjsWYvCqTjYSGDS4NRo2x3Wun6ihelUxEyvSGH9EfZ/LqeuIHn8QKC1bpyeO1JQ
         a0x7pgYYKlSK5PCn9XGK1I4yRiG6/qyqE2Df0m5y75Zc6IYT/i2ijWKy6r84ftcWgmsF
         iiNbdIJ0hLnGPdOKGjpmZr4nkZZrlLFbafuuAXuOFk1yRtJlwTVvwlV+wVcaEhTFZ6yd
         LnPnfQcFte11pH+++k/vl6WlStqccpxu37AqmSes/TkdXcuxODKpUBTbV3BqpPiKMI6u
         chwBaNrlUSVdVgXPyqlvlw6X27u55xQaMeB1960vJm6T0fJZZtbaXrc/awuMasG58Zce
         5ZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776328218; x=1776933018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ok2jOImuVFQ7GtPJheZIafb+EzCFhJ0KF74mw1kUE3Q=;
        b=FN5Ypgb79uzpvJ3k3HjExYYKKPqFK7UxOf8iPRP0sOe1m9NobcmDM0OM8UE2ztP8IO
         PJXyZDw6Ugvnh8VSuD1EOVpocYrnVUOXV1TR8IU8iAkShJVr6iPGwCNeGfwoyvxNB4I5
         FWNXXHxVbor5u8svLEoKsIZ/ZSHhEZkcgtWgYHOwrTrx6CUksNAES/YT6Bw+xoTQwOmV
         SpEh12xZKRdtOO7hZQXjHfTn0YQYQELq3rIg9FQazx2aRT3I6QuSyuJ/ZGT2tvy8Mr1J
         YjyHGMltPrNk1oDy8TeLfFYd3oJR+k9o+nzhOjLaaxpdsQeXm7/9UEtoHMS1Bmatst5+
         kfpQ==
X-Forwarded-Encrypted: i=1; AFNElJ+nvP+ZTSa/D5f8i7Mz4Co1S9fjn0eanPgH6/G7GhGyZPaJyms+SPKEFOvDJHktjbjDUj8AJNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9uQlv8P3E5bl/L5gZWVUduD7m4gpmXqA85Yfo2yZLSeXsTb/F
	tDMz/xE2Nw2JThQiAb3lWQdgOXJEjywhQhEasat9q6DU1dZ9e9wgu1t+9fTErCfB6FEozBLaeoq
	o56uVMujsy1Gp2BHr0jOTuAgQEI3z5qSOFV6r5b1I2D0gAbC8tzszSMXUxg==
X-Gm-Gg: AeBDievGhF+eOnpSo3l5Kd2AxNuIbzWliGc2md2zYS0gqNS8P3EajdTyWsT8KEbyjkU
	WPEVcL/PmZcPlwaGM6jcMmU8QIQU2znoWcp5z9GFtR6EpBZ9wD0aFiPDUswFOXIU99fDFF86Gjt
	/hU1vY45E9mF4QMGYS/9N+Eqn83icD/1wEUWvepiwhTieJnlDGn65fb+H4HmfY/UWluXnRXYTq+
	MYTbakRxcZI46I6ZSSZzRX+nHcPhDzrKlbkdmONjQ4Ap/Ma8TIWOm6756eEe/GWiZIK6SbgMAfx
	uYjcW6UjdXL0SbxFTWzqvTrgST+lhKeOamAxkF8eMgbu654Pr5jX/1C6cYafMAujSNufKvp7WeD
	b5Us9j8SWoJ+X6NZzEhxjwqu7PY81VIbak+wtbb125drC3yP+Qxj2M3ZuoFAHKAsF/i8=
X-Received: by 2002:a05:600c:460a:b0:488:a824:fdff with SMTP id 5b1f17b1804b1-488e00fdbc3mr164789595e9.22.1776328218457;
        Thu, 16 Apr 2026 01:30:18 -0700 (PDT)
X-Received: by 2002:a05:600c:460a:b0:488:a824:fdff with SMTP id 5b1f17b1804b1-488e00fdbc3mr164789225e9.22.1776328217972;
        Thu, 16 Apr 2026 01:30:17 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5813970sm34344045e9.1.2026.04.16.01.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 01:30:17 -0700 (PDT)
Message-ID: <acd54f40-fcd7-44df-9fe6-0b278f4a3476@redhat.com>
Date: Thu, 16 Apr 2026 10:30:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: mctp: don't require received header
 reserved bits to be zero
To: wit_yuan <yuanzhaoming901030@126.com>, jk@codeconstruct.com.au
Cc: yuanzm2@lenovo.com, matt@codeconstruct.com.au, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260413080333.73086-1-yuanzhaoming901030@126.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260413080333.73086-1-yuanzhaoming901030@126.com>
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-278971-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[126.com,codeconstruct.com.au];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[114.105.105.172.asn.rspamd.com:server fail];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lenovo.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 11A4040BA34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 10:03 AM, wit_yuan wrote:
> From: Yuan Zhaoming <yuanzm2@lenovo.com>
> 
> From the MCTP Base specification (DSP0236 v1.2.1), the first byte of
> the MCTP header contains a 4 bit reserved field, and 4 bit version.
> 
> On our current receive path, we require those 4 reserved bits to be
> zero, but the 9500-8i card is non-conformant, and may set these
> reserved bits.
> 
> DSP0236 states that the reserved bits must be written as zero, and
> ignored when read. While the device might not conform to the former,
> we should accept these message to conform to the latter.
> 
> Relax our check on the MCTP version byte to allow non-zero bits in the
> reserved field.
> 
> Signed-off-by: Yuan Zhaoming <yuanzm2@lenovo.com>

The net-next tree is currently closed for the merge window, but IMHO
this change could be considered a fix. Please repost for 'net' and add a
suitable fixes tag.

> ---
> v2: https://lore.kernel.org/netdev/20260410144339.0d1b289a@kernel.org/T/#t
> v1: https://lore.kernel.org/netdev/ff147a3f0d27ef2aa6026cc86f9113d56a8c61ac.camel@codeconstruct.com.au/T/#t
> ---
>  include/net/mctp.h | 3 +++
>  net/mctp/route.c   | 8 ++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/mctp.h b/include/net/mctp.h
> index e1e0a69..d8bf907 100644
> --- a/include/net/mctp.h
> +++ b/include/net/mctp.h
> @@ -26,6 +26,9 @@ struct mctp_hdr {
>  #define MCTP_VER_MIN	1
>  #define MCTP_VER_MAX	1
>  
> +/* Definitions for ver field */
> +#define MCTP_HDR_VER_MASK	GENMASK(3, 0)
> +
>  /* Definitions for flags_seq_tag field */
>  #define MCTP_HDR_FLAG_SOM	BIT(7)
>  #define MCTP_HDR_FLAG_EOM	BIT(6)
> diff --git a/net/mctp/route.c b/net/mctp/route.c
> index e69c6f7..62517c9 100644
> --- a/net/mctp/route.c
> +++ b/net/mctp/route.c
> @@ -439,6 +439,7 @@ static int mctp_dst_input(struct mctp_dst *dst, struct sk_buff *skb)
>  	struct mctp_hdr *mh;
>  	unsigned int netid;
>  	unsigned long f;
> +	u8 ver;
>  	u8 tag, flags;
>  	int rc;

Please respect the reverse christmas tree order above.

/P


