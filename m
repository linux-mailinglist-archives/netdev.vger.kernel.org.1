Return-Path: <netdev+bounces-252263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BmQGJP5cWmvZwAAu9opvQ
	(envelope-from <netdev+bounces-252263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:18:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C91AC6522D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A70A4E2A6E
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86C738A9B3;
	Thu, 22 Jan 2026 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMrLj/ds"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41D63B8D6A
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076849; cv=none; b=EO14NOQqP+LAYYxEMi3lIlmzBpxc2exqlO2azHKOzHG/iQ9Mw0LbcgBcLCZFXZH0iAIEJXpqvMAQ5+0QpN/vrDOQBewvW8DiiFL+OXTYL6avTFPRdJksHN36OKLsNmmxZmjqNZCnbO91HInQ7Om9ZiWKscmwfAwR6lSK9tBuRns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076849; c=relaxed/simple;
	bh=not4uNUIV4Fq1tsg7OIn0IGL5/1z7aHYp0CczKY7Ntk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRLaT7heHSuMXrUYMjcQv7vtit8sFrMLn+cVybRxlaIK4vV7QOWCYLleF7P1Q/I+9CEEg3fbUqmZLuBJetI6QLuI1u4HSo8xlWA0GOjaaKWSLNWy3t/4YOaz/EkvInyU1peQMIvvpfumpYMyh1ZwwnFk7Qsi5L+u7rvurm0pURQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMrLj/ds; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4359249bbacso1171714f8f.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 02:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769076845; x=1769681645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=not4uNUIV4Fq1tsg7OIn0IGL5/1z7aHYp0CczKY7Ntk=;
        b=EMrLj/dsfMeijJywKVWXMQcbwH15zMf54o5vX4EnBwW8G9DIDUafNztc+oOwciX+4l
         lgmhsI1rvbgYtrcxUHvpMT1HuCLSGHUjl7XAlfsX6M5FePEoOBuvGoLzTJ2r/znu0XSa
         ZUkNfkSwcUuNduW/WJIPvwTs0kW8YCikjdsGIe+52q9I+JSvFvxeUXJ2BnXvN6Zc1xAV
         3ot+frXuswlzeC/puWNW1Q2+Ww40ZhiHdVUfoLNB/FeO/zQGEDEPAgmVkmvFQj65co4a
         lgPlyI8CoxnQdQd3FFr8Xi07fM9Io5OCvlFMoyEB8q1G5ebW/ojwEM6nF5XvaQZxJrhP
         nXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769076845; x=1769681645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=not4uNUIV4Fq1tsg7OIn0IGL5/1z7aHYp0CczKY7Ntk=;
        b=BSI8mlpu4NxuYwsdEzWqCHxLuQyJtPguOsjDigKgPnVikweKeeDqkryCs13l7Z//QW
         wo3M6je0Ju88IW79MrB0BlEb02TVseNc8KFlYxpfTxzdi1jja++He7Sjl9x0TsYpfZX1
         doqAqkL6Rtr5uyjH8qnykoT64zyJE+WjwdWR9remqnTb4aBzLVmyp2V170uiPTyYiSpG
         x4zAOFfvhfKMEw69f8vRwi/qhfy8CJ4FcgmPII8cJwKcqleFmF4wVxTV8KNo1U8Dd/7L
         ItKbI85rnmOYQ6qR2I3KahPcWJ3srDo+rSThkl0Ir1fnw31T/N57XD1QlxMjMDRGdwuY
         CP6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhCmpnSiDl94/gLz/+DpFjdv0tOCyE8qzYRsKpi/tfSD5clEBYjOGHwstS3N21N6bDzLU4/PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkLatOYZbuehP6BO+UURFKc6KfnX3XDpczQ+iNezsiYyiXcl8m
	3WRV/+/dXRdJ+MzamMJ0mOnVqNPohsVidm4/FndModorNiO9FyL4AHtB
X-Gm-Gg: AZuq6aKU/nN7BnAln7eK5Ns1Rg0v15a3Q5alq0Tco64MLmT3ASGIvl+sJ3666GEjfLU
	YzTdH56sWhjION3sOemUmng7s9pKVV/crNjHfOotsTAF5ME2NMgcsNGkvIGZ+HsZKEpJQl8RCi4
	D4BEI5oQPesd8DZ7oaOCc+5J38wbEzPwUkQJ3bdpneBjdy4Iz8/qx2UQbs0oyArXa3Tw9mKODpi
	7z6g8pMj7GtBTNhfTZDwykCFW/Zg6rZhu0z/t9TU4Bh50JuN74IyNN6d2hL+APcjb6Q2Vwu+flN
	iHR9t9Yu04YGisaY0WQtGHzmjOa/ecsLHw6qyQAPrh65ClMjY8tN7hy9ETEk1N7r4qkPrtPqNew
	GtW0FU/kvxoM1JLqwg5s/ssRADke0IqsWLVJV5oHx5F6/Sfp1XCZ6x/MRowW0220lw4eKz+zCVJ
	OG4BViJCqxlQsJcTnE6f8MoYWbG9ds
X-Received: by 2002:a05:6000:420d:b0:425:7e33:b4a9 with SMTP id ffacd0b85a97d-435a5b80722mr5037324f8f.0.1769076844496;
        Thu, 22 Jan 2026 02:14:04 -0800 (PST)
Received: from [10.35.35.136] ([195.37.88.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435966322a2sm14652459f8f.38.2026.01.22.02.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 02:14:04 -0800 (PST)
Message-ID: <d223bf52-ba2a-4185-930d-e9db9dac9d80@gmail.com>
Date: Thu, 22 Jan 2026 11:14:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5] net: sfp: extend SMBus support
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
References: <20260116113105.244592-1-jelonek.jonas@gmail.com>
 <6a87648c-a1e8-49a2-a201-91108669ab44@bootlin.com>
 <6987689b-35ac-4c15-addb-1c8e54144fa7@gmail.com>
 <5e7c71f6-80dd-408b-a346-888e6febf07a@lunn.ch>
 <fcf7b3f2-eaf3-4da6-ab9a-a83acc9692b0@bootlin.com>
 <fe1bf7b6-d024-447c-a672-e84f4e77f8d7@lunn.ch>
 <91442f3f-0da9-4c52-89ce-2ca0a3188836@gmail.com>
 <66e8424c-86c9-4ad7-a3a7-3c277bfa5432@lunn.ch>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <66e8424c-86c9-4ad7-a3a7-3c277bfa5432@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_CC(0.00)[bootlin.com,armlinux.org.uk,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,mork.no];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_FROM(0.00)[bounces-252263-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: C91AC6522D
X-Rspamd-Action: no action

Hi Andrew,

On 18.01.26 16:39, Andrew Lunn wrote:
> On Sun, Jan 18, 2026 at 10:43:12AM +0100, Jonas Jelonek wrote:
>> Hi,
>>
>> On 16.01.26 15:25, Andrew Lunn wrote:
>>>> But let's first figure-out if word-only smbus are really a thing
>>> Some grep foo on /drivers/i2c/busses might answer that.
>> Did that and haven't found any driver in mainline which is word-only.
>> All drivers with word access capability have byte access too.
> So for the moment, maybe add a WARN_ON() for an I2C bus that only
> supports word access, and we can deal with it only if we ever get a
> report of it firing.

Should it just have a WARN_ON and continue (so it may work in some cases)
or fail at that point? 


Kind regards,
Jonas

