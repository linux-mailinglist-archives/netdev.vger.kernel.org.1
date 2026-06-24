Return-Path: <netdev+bounces-301639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YjQfHGbRO2qwdggAu9opvQ
	(envelope-from <netdev+bounces-301639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:45:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EBA6BE3D7
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:45:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bynar.io header.s=google header.b=g8UnBYe4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301639-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301639-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bynar.io;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76E4F3004C96
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 12:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507BA3AFCF4;
	Wed, 24 Jun 2026 12:45:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD9C3AFAFF
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 12:45:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782305121; cv=none; b=kh9yXSkKBpMrLwuAqAORGvwxtl3Un+rsR8SJM4n2HVkj3I8GxUZUl/hCQj0jm+IP3wdxX4mJxJLZKHkB1rc4SzyxDDoM5MMedgnMNJW5ZVDMwPadDyfW/cYJiK3LHWTPUa/ENcCMP8F0Hhtd9oqP02JItp7J0Es4YLdI6xn+koU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782305121; c=relaxed/simple;
	bh=wburqNFqddDcYvdONGTxV4jyyRCt4GMG3P5jYMC/uQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4tpGOEMmrRFAIaCKu+Cxoix3g1+ZV0HA7CHOUdrjKcSZRXUtpjhlEpU/yy8V2YRAHzOKw7IwAn6NVW5iWNRMg2kXxNEYRlx1jovY7aaD6XX+jUOauu/yZic9ZGlVFnCEBz683PiiVnoyxN5XzTXGmO4HZ/gH80idHAyt+aML70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=g8UnBYe4; arc=none smtp.client-ip=209.85.208.47
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-695f539fc8cso3437214a12.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 05:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1782305118; x=1782909918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wburqNFqddDcYvdONGTxV4jyyRCt4GMG3P5jYMC/uQU=;
        b=g8UnBYe4DpFOrOHE0+e+n85LeCxJn9CRwTN21XlN4/x8vsJK5vdpHt3TPQfDLMLesM
         ra8JRLzVAnkWxFynqU/k3w56oaaWIZy2tWjjYI3ziBLlv/NoVF1VRL58zEEYxzB34M+X
         ZYMkMIDLa5eqZPp/L74JX5VNDVV0dD6Sx9VR1jPSvjVW+ji+WCPUVsez8huiof6YzIpQ
         eV3EzAiEYIpve8b2bd7hqCrA5PO8r0dcQpKg9b5GcBFN7j//cq5QPJZxKYMOziTqmhmj
         DRMdCp5kqwwzYK8U7TrzrT6aNH4xrw5DCRNjNGLF/nKWINt4/9yOs2fv6rzHT48GA3XC
         RuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782305118; x=1782909918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wburqNFqddDcYvdONGTxV4jyyRCt4GMG3P5jYMC/uQU=;
        b=NgR1Pur7l0Z8yfesKqj/+FMnBxQx9aHCmqOG3+uGNtg2vmsRo5Np80dZtRV/V3Ox5U
         hLfpNvavHPfEb3aRqOKYF3QBTg34i5RnFuaauFc4ne6Imq3adrUgHOGPex7dULeiTcpB
         s+g8/8P2tBgOuX/eSrceaM1re+B8+pKSleuqZQtCagV6Hp2DO8t9ZLtkClscNqR9OPWa
         dlnp/ilJ+4GjM7SnqtEj4BbQDDk+V3ltP2xVDfPGaREn8FBghn5LnJieCOaMUEvGNRRb
         L2wZ36UGArwVmChjLDmhZgw01tmNz5yWZBtMgy14I7z+NiOFI9stwoXiiko+ZWNvRbQC
         f4Fw==
X-Forwarded-Encrypted: i=1; AFNElJ9A1NykY/nw1zg5XtAfTU4qIq4qLEE82md1pJ7vswVzQgRZ7NoWVALUd9jMFVydFa9IAmXym1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx+l5OgEACNSlRS/zYVZeCYtAwAfk9j3LRh5G/ElYh2E0+OxHv
	JGpJrQZMSVtHwdMmAVPJCC13nvlnDcGVOmz9Mtnxifwcyh1I6YxOAhKr6C6Vhh+K45Wk
X-Gm-Gg: AfdE7cnjmG5bQN9phnCf8gIX8bO9kpikNp98fQ1C6NpNuBmP6b+2e+wPJ4w+4S4AEVI
	TwfwHG2BDNX69qFOqt93YpiaVCiWVp5Nu9D0mkp/0hOTPASfFq2cnmBjsDfZaXdYD1gxLw2ptho
	HdHTvE8P6LK/Qh8CikmRRCKr05KWxddRsrjBwLFbDIg0d+QIBN6nAPwyQZh/IBEbsjKxd+tu/Zz
	1ZjEs/QiMSskhZPJHGES1lFtNkxpd5EKiJQqIOHWm0HTm52Tisn7Tfs9R75IjLVv0hY36VgmJC+
	ky7xTIMoj7irTt3a7ZOkOX1IoMDP1AXuuwKfBcNmu6T3/Vx8s5H8ekya1FL2v5nvX3fRipHwnYd
	CYXbedRL8/RykwTBifzV+IxqiMchXH80l1uCB3OXL2whbZ4pa+MVKU2Y7UbAA8185Z6f/4tYJux
	vhvsKQwf7/6ZVyaZy7nCuKa7xV7bZKhdF3pLhTnEHwBKkEpA==
X-Received: by 2002:a17:907:c207:b0:c11:8357:40f with SMTP id a640c23a62f3a-c11835704bfmr177824666b.2.1782305117916;
        Wed, 24 Jun 2026 05:45:17 -0700 (PDT)
Received: from ?IPV6:2a06:61c2:d427:0:b321:1c7a:b072:326e? ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f49d73fdsm1040727a12.22.2026.06.24.05.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 05:45:17 -0700 (PDT)
Message-ID: <544f2aa1-269d-47a1-b315-5a6fce5637b1@bynar.io>
Date: Wed, 24 Jun 2026 13:45:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tipc: fix out-of-bounds read in broadcast Gap ACK
 blocks
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "tipc-discussion@lists.sourceforge.net"
 <tipc-discussion@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jon Maloy <jmaloy@redhat.com>
References: <20260623135443.3662041-1-sam@bynar.io>
 <GV1P189MB1988C9B05348C49E61EFB5A2C6ED2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Content-Language: en-GB
From: Sam P <sam@bynar.io>
In-Reply-To: <GV1P189MB1988C9B05348C49E61EFB5A2C6ED2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bynar.io,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bynar.io:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301639-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tung.quang.nguyen@est.tech,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:jmaloy@redhat.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sam@bynar.io,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[bynar.io:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam@bynar.io,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bynar.io:dkim,bynar.io:mid,bynar.io:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63EBA6BE3D7

On 24/06/2026 13:56, Tung Quang Nguyen wrote:
> This is wrong because the skb is not dropped as it should be.
> Note that 'ga' is NULL just for legacy TIPC that does not support Selective ACK.
> To correctly fix this issue, you need to set a flag (for example, a Boolean output parameter) to TRUE instead of 'ga=NULL'.
> Then, immediately return and repeatedly pass the flag to tipc_rcv() in order to drop the skb.

Thanks for the feedback! I'll address it in a v2.


