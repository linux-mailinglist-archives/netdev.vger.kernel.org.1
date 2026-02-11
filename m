Return-Path: <netdev+bounces-258244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCOHLM5QjGmukgAAu9opvQ
	(envelope-from <netdev+bounces-258244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:50:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CFC122F48
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A5163008226
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CE535EDB7;
	Wed, 11 Feb 2026 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RM4jNTIs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YeQcXP+Q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793DA3559EC
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770803403; cv=none; b=XkrXF4jXRsINezKAdHdKJBD+zThH7ap7J07LzJNn89fvg9tbQvfsQPQgr9HxhJif3cHhVsT7AOzfyzG5t92/hKQgHgAW3gt814P1XHZIEyAZ8sM11wBwn8+jKgt1eAWafD58dtEnztb4jmz30ate2GZG8r4xtRmruu7C1UmRWYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770803403; c=relaxed/simple;
	bh=p+9Mz1V92ADmyMCcfSLuQ4l6/dlIQJQ9jq0UZ0sAfq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KETEDmj1u6lxXKTQHBv2jhqCrsumpyFgP6Om21l8Ubr/24V3UqnifQ2Kmzpimr/7r+KvewDKUr6pxWmeqzoYGTLebzg73Ew6wu8+lFuSuLiYxuLMqmq2ZJ0rGhji+w3R35svodH7WMRN0fhVu/nJi/cOtMRaQozYoS3q5yVivCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RM4jNTIs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YeQcXP+Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770803401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+EffqP6+wrHAj97z7BAWDhUHSAE9exzpLHL2JCVAtt0=;
	b=RM4jNTIsmz343mrKFRlJHGpH8uHrza9/JGk1hwkRM6Ifez1WVe6CxmEXQ3ABR6hMQUqmuM
	GzY5nPPpvoCJkucmGbOVEbA+i7+9D5ttmDzOaXNsrjQIfB0RnC8JtcXHmQIuhZDGhKI7NZ
	kyJO5P/LB07tKVO9AbC9rdlXTiXdp0U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-JCF-hJ9KPn640RsFXb58Pw-1; Wed, 11 Feb 2026 04:50:00 -0500
X-MC-Unique: JCF-hJ9KPn640RsFXb58Pw-1
X-Mimecast-MFC-AGG-ID: JCF-hJ9KPn640RsFXb58Pw_1770803399
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4801bceb317so19461645e9.1
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 01:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770803399; x=1771408199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+EffqP6+wrHAj97z7BAWDhUHSAE9exzpLHL2JCVAtt0=;
        b=YeQcXP+QaTt5zBZ39m2dDH/wLZhQ8MKrKjz/HG3+22SkY5/ZtvEog1QQsNw8Frx/Ku
         BUosB7E8QMSffTpFsv5rOoQZCdoMAg7GHbJslu8rD0ZRqsKePeiqDIBLlhM+WzW51SiM
         IdzMEqc+ZRQJaeQ5vpmtzjQ7hlauPNobWIlzXHN95NWfmBiNbOlEt9YTxhvF7QPJQyGH
         r7Ewi/pSzR61/RgBzO85oqefNNW4aQvRrWsKa3q6Og+nKwT3eaOO5FMzFyGQ+sSRgRZ+
         nqWNvvFPyEXrneKbqr7pt0sr9iRb1GriZNZ4hS4chvjlZxgplXuycPUqyQUvuEJRkQzK
         K16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770803399; x=1771408199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+EffqP6+wrHAj97z7BAWDhUHSAE9exzpLHL2JCVAtt0=;
        b=egd4E8KW4XjMbffFEi0mUVCUG09pxQZKdQcB31IGovdiX1lk7OvKuyMJrh+VW5KMv4
         fcJeZodZmAciBX9HBpeXj8mr2q9fJfww0Pz+zS7eRO/SOkLRPGzfA2RYPjnyFyNhjaQf
         h7CWrW6C2PrKBQZZqI6JqLMIt/Tn9Bml3XC+0B/5p27jG3KrF0Fw34oXE0tYqNoX8prE
         Dui9IOD0GODzZ1jSQoZU4z0niYCXlWK/mAWCzUt4OZzDYwVLd4lNcOuSe8AFC9zPrXfu
         So8ZdwBZg2LNkKMPrSlhL3f2Hs1LI4M3qLUYo2ELFE3oJKN1Q3CooYvFk6J4YALy7rSx
         CbRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCgoKka0cD9JG3uV5KtDSUieksWJiDQ0Xk8+xGw2CK7WXGM8UBbKMyiPuklXwCoYj1oNvDD2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBtRsraw/C9kqZddagDDbh8CrLfHF5Vf0S5mNY9eFl7RhhVaRx
	yIQzwGs6UoBBXlAEe7yDK5eYo1wN/P/a0VenjZSB8umhJZg+3IkCBDuCwuHx6nYlcRE/wiLPZQH
	U3f/qxhNzVQnRNG1I3eIWrPjD7RGISvD33zpEaOy+/sO+ivKXV0aJhQQLvQ==
X-Gm-Gg: AZuq6aJAhQVdQWAmSzPCWK0xlbiX3XLBmToaSMAhH8pWeTfxrg0wEzJH691XAebb/PC
	9E4AAmlfoqWnpKOpkwayD96zZENdgotnTSXulPmi6X+mFkrzolFaEAeD0bAGEFm2i1ZtWhVYxKu
	aaVPjQvhP2dAKCjK9+X+djxc4JpNL0bQq4nrhSvq2EEbXhPeQgP31/QW8IXLI4u5Q5x6XZaKgUG
	4UgV0PU0FlmYN5rrkyrpwVF827MAQ0tSKL+R5G5XuV4hm0eYoCar8MvhgAZdP4V55in3Kp+h0kr
	oBuzCS/mXn54TduOg/7uR3jzKFMXpFbB8N8HL7IwDwbHEaQ9VJ27JFDhxHAxWrAksCJ/StQzAnS
	ohlTmEcmqm05T39cHiDlIKOcqAg==
X-Received: by 2002:a05:600c:8b6f:b0:477:7975:30ea with SMTP id 5b1f17b1804b1-48320236963mr253144815e9.29.1770803399018;
        Wed, 11 Feb 2026 01:49:59 -0800 (PST)
X-Received: by 2002:a05:600c:8b6f:b0:477:7975:30ea with SMTP id 5b1f17b1804b1-48320236963mr253144465e9.29.1770803398594;
        Wed, 11 Feb 2026 01:49:58 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836131d4e8sm2908695e9.31.2026.02.11.01.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 01:49:58 -0800 (PST)
Message-ID: <d6393a14-fe50-426d-9dd8-5a33b2af0a0d@redhat.com>
Date: Wed, 11 Feb 2026 10:49:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v14 0/4] net: dsa: initial support for MaxLinear
 MxL862xx switches
To: Vladimir Oltean <olteanv@gmail.com>, Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Frank Wunderlich <frankwu@gmx.de>,
 Chad Monroe <chad@monroe.io>, Cezary Wilmanski
 <cezary.wilmanski@adtran.com>, Liang Xu <lxu@maxlinear.com>,
 John Crispin <john@phrozen.org>
References: <cover.1770433307.git.daniel@makrotopia.org>
 <20260207214733.m2zvh6ozo7vsc5hj@skbuf>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260207214733.m2zvh6ozo7vsc5hj@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258244-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,makrotopia.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55CFC122F48
X-Rspamd-Action: no action

On 2/7/26 10:47 PM, Vladimir Oltean wrote:
> On Sat, Feb 07, 2026 at 03:06:48AM +0000, Daniel Golle wrote:
>> This series adds very basic DSA support for the MaxLinear MxL86252
>> (5x 2500Base-T PHYs) and MxL86282 (8x 2500Base-T PHYs) switches.
>> In addition to the 2.5G TP ports both switches also come with two
>> SerDes interfaces which can be used either to connect external PHYs
>> or SFP cages, or as CPU port when using the switch with this DSA driver.
> 
> For the entire set:
> 
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> 
> with some minor comments I'll leave in individual patches, which I'd
> like you to address.
> 
> I don't want to put anybody in a bad spot, but given what time it is,
> this set should get at least _some_ time in net-next before the upcoming
> net-next PR, to allow for some reaction time in case of some unexpected
> reports like from static analysis or similar. 

As I'm wrapping-up the PR right now, and the series is not applied yet,
I fear the above is not going to happen.

Since a driver is involved (as opposed to the core stack) and there will
be the usual release cycle to address issues before the code lands in an
official release, I tend to think this series should still be merged -
unless someone voices strong and valid concerns _very soon_.

Thanks,

Paolo

So it would be good,
> because of that, for the fixups as a result of my comments to be
> separate patches rather than a new version.




