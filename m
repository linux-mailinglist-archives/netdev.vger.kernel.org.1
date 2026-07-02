Return-Path: <netdev+bounces-304188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cibGGdFkRmpeSgsAu9opvQ
	(envelope-from <netdev+bounces-304188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 15:17:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C436F8384
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 15:17:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=aYcsmMnu;
	dkim=pass header.d=redhat.com header.s=google header.b="l+OG/p+E";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304188-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304188-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7117D30C3A3B
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 13:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CB5426400;
	Thu,  2 Jul 2026 13:11:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6430428837
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 13:11:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997887; cv=none; b=gVlReQ56dMXqo+nbAQ+Z+6yBABWffrjqwIC06WQxEnLFpthQhlL6afDxVSwdfWLkH59KGkb7nofv3v04a1kMj7Ha4CzqfmBCCVBfFPWn8QG33cxjuEbi0bXNBfWuMvGwq61f/ypkBkNurtv9r4p8vYo3WEZUYio3jC2vXay2Yig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997887; c=relaxed/simple;
	bh=X+2sChOYkUT/PVLP7kRxWUdmrfGO4tIVnJ0El7RrAck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jbmx0MPxHgjhZU4f49y7KioMAnhBWvUFlwQp5ZqUwipbKnTTPEj7it/+rCfiBjbETt8O3CAlSsGmzHepTgdSR3mTELTwJWGqqUhB7LuGnDTpVsSH/tG16XJ6ENrTn7T1xqplTFVLNUfzumM1tTGF1mAllSLjbEh5mQpIyNhJZDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aYcsmMnu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l+OG/p+E; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782997884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9DXpy/5eH4Jy+s+jrmwnZyLuwa9SpvZoqoZkDy7ACTM=;
	b=aYcsmMnumRE+ueW7f3dYIJbKpAVDRcf4wfPgjdw6lh6FHTKvEX4Ed7l5SGM65B+NX8bgKz
	Gsz1VefUzZX1mEbUlk8xTyBARkcRTLLlVpgpInYd47fayL4H0S8s6174SjyDm1Vi53jffK
	OHnDm+KDsO2P2vt9wrsvGIkq1tHV/w4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-9dqgfsLMMKi9ezT5J_sb9g-1; Thu, 02 Jul 2026 09:11:23 -0400
X-MC-Unique: 9dqgfsLMMKi9ezT5J_sb9g-1
X-Mimecast-MFC-AGG-ID: 9dqgfsLMMKi9ezT5J_sb9g_1782997882
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49260d6eaadso11917625e9.2
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 06:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782997882; x=1783602682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9DXpy/5eH4Jy+s+jrmwnZyLuwa9SpvZoqoZkDy7ACTM=;
        b=l+OG/p+EnTnRi6chkqxMSonMKtM829YvQJWG/B0n2O3GXdNCWuYfMb+f46/+NfiX3b
         WzN1TWNhHZdQ881rgePOhrX8xeGSJnytFcFYqBmAN5Ue4HfgJklWRde3+dVaV4rJ8Cj3
         d+xxqkWskGklP7bqDt9Vd4VxYeBUlXeMGkuq0pHM4j8tyj8UTweBNBuVlJfEE8l1b9+P
         UpudmA7LuvVn1K8asYeMFZRyesHMzVWlCuHdKHYpLCcxnLG2FPYjgjGhKukiHbnq2EFv
         blWw7BI61BgEEBxIZ2XHBM8UemqsQfQ9MdOiZF4TZ85z3cDPvNbboBzxiUInJxhNeR4k
         w6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782997882; x=1783602682;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DXpy/5eH4Jy+s+jrmwnZyLuwa9SpvZoqoZkDy7ACTM=;
        b=cLCPK0QKE2nhV1efVvmKDb6IXPgsK82RI/JZ55gMgxJAEmPnJxa0DrO3vMPFTRQMtf
         fYsjVnDukz6yqUD82b/JyeuQZmbgcMsU1jrPEhdzKYhdsVPYAyZyLWbrcxA9YV8eujxf
         z6na1PssINFDhK2QY13gW6siS9+1KHpYa7u0OO0t//MvI+jjboKIYeKC6lb9eHCFn1sB
         vxksHodkvphn8TguavF/dHt1JYYyf+e8hTDXJV+nyZDji91MV6aG1nmULe09qi0YNtm8
         6MqtKORcXTol3jOy07pRgq7ClyGOLgHD+4co0fr3MMEyLT5c6IpeIMSjaCxREP65r1Us
         087w==
X-Forwarded-Encrypted: i=1; AFNElJ88xTWcRFnAe6GDN4hpBgmfwhGvci6SXf9S0L3zrcwADaL1Dd00RWaDW8DPATNYnVkVJ2yuREU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXRYDeQaWIwXsvPmxUo/y/5wKYwgoqa0OsFjylE+j6dYnsR0DU
	e93Qu5804QtXA11aMd9nJe3TQD9/MMIMqzYkYWo4OcoQGci2aiLh2gf7ddcDwPPAERoSNEW1SSm
	1t3sVLIYq+MJP8qVdAsQCVXJiMgj6lhqxs1/yFHeGovNoHFacyadzKOuhXg==
X-Gm-Gg: AfdE7cmJIdb+ClUJqJBZgaOXvbYPz7YDZuzx0aS1XZp8m+xoVKcY1oeWgdRAESXaJ5j
	nsBByxeKju44UwCg69DyxBg2Pbb45qTuNKBTfScfwhGBh9w+F4hMm4fVpFk1g+2l7O0vdW9A6hS
	9juK6ymdrsX6E/CB0Xa8gWbImZqkiyO76+54+xoa/l0N2zEMRLDyR3n4esmjQ2vjOvWz5qeymmL
	R5vJypgo+hdzI2SqxdlxMnqI/lH45PLKM2R2CUZkHpM7KxmGNiEAMvMUxzJVgobETjnUUqmn5zD
	5tbLH8JRHVOB1LYXhwnBikeIcc1Ty0QOfoPlPa8UtCr5kU7d3Ftg0Dfbm/lkmNpET5O1kK6d/DV
	K6N6bfT4pbZCCxvhFlTKTNVsnEMqSIh/ewn7pO3x0fnEHjrvTPVz9WZbrYLD6iXRmdDCyxynC4T
	jbWp3xdVUUKA==
X-Received: by 2002:a05:600d:111:b0:492:4717:59fb with SMTP id 5b1f17b1804b1-493c2b5879cmr68423755e9.17.1782997882208;
        Thu, 02 Jul 2026 06:11:22 -0700 (PDT)
X-Received: by 2002:a05:600d:111:b0:492:4717:59fb with SMTP id 5b1f17b1804b1-493c2b5879cmr68423155e9.17.1782997881591;
        Thu, 02 Jul 2026 06:11:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63bfba1sm54586555e9.15.2026.07.02.06.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 06:11:19 -0700 (PDT)
Message-ID: <438b6055-e4e1-45dd-a149-0fd63dc625f4@redhat.com>
Date: Thu, 2 Jul 2026 15:11:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] octeontx2-af: reserve 4 PKINDs for skip-size
 custom use
To: nshettyj@marvell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 hkelam@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 Kiran Kumar K <kirankumark@marvell.com>
References: <20260630062145.2533816-1-nshettyj@marvell.com>
 <20260630062145.2533816-2-nshettyj@marvell.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260630062145.2533816-2-nshettyj@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304188-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nshettyj@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:kirankumark@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C7C436F8384

On 6/30/26 8:21 AM, nshettyj@marvell.com wrote:
> @@ -4218,6 +4248,12 @@ int rvu_npc_set_parse_mode(struct rvu *rvu, u16 pcifunc, u64 mode, u8 dir,
>  							  shift_dir);
>  			if (rc)
>  				return rc;
> +		} else if (pkind >= NPC_RX_SKIP_SIZE_PKIND &&
> +			   pkind <= NPC_RX_SKIP_SIZE_PKIND + 3) {
> +			rc = npc_set_skip_size_pkind(rvu, pcifunc, pkind,
> +						     skip_size);

Both sashikos noted that the driver allows unprivileged VFs to modify
global configuration.

Please follow-up on that issue

/P


