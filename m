Return-Path: <netdev+bounces-305479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ub1xC5IETWo7tgEAu9opvQ
	(envelope-from <netdev+bounces-305479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 15:52:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 912AE71C235
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 15:52:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=hz6mcsby;
	dkim=pass header.d=redhat.com header.s=google header.b=M9jSULh0;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305479-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305479-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C24B30B8A55
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 13:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A9E41F7D6;
	Tue,  7 Jul 2026 13:46:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8143D47DD
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 13:46:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431970; cv=none; b=F1gFyCPaf9+E6AjT67yI7RL/i6TB2iL5IisgY+6KPw9qdlzsyH4AhntpPX1IjJkWJpKLwa90301nW8kd5zDlGcOtAOA8YKEU69vq/+FttBA6WVnJmd5sRgQCW580XgNOFvAFQIcqkPEcPNDhV2tuuTCOHKz0JDF0yl6Rg42cPgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431970; c=relaxed/simple;
	bh=4W1pgRGkuKaRZDd3G2M9VDfahtzQlthBqgxJx4Z3V1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ysr7brMR2xIKPP2SfQb0HyfTSdujn351RvQmce0qA/5AIzxaeWJu4UxrUpXmXF1SjHFAJbt4UbdHEBpM5D9KKD7RXs2ZNb610tPOiJXSyYycsIfCt7boJPkowL79Ju1g/dqGJwTSqpWxsMqt8dbw23B4HVCIEJP803Pwgq2sf00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hz6mcsby; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M9jSULh0; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783431967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAzeUKz5/N2T/7rInHarhTmhaFb8U+NoRbSx7BOs71U=;
	b=hz6mcsbycuZgBRAzLiPWhiJKF37tIBs8XUtlUg+gyxu6VFVIM2P2G+mq3VGelAfseePbG0
	+ij7vfexYDnE/+T0rdK9TOoFPZRvPVQkKp6zooP/pkbr+TVUWG16NMGPfJx1so3Zz/aEwa
	6JOmvJ548JVB30gomgYi3rA62gDVaZM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-ayJuM21WP0-lNXtr-aCLtQ-1; Tue, 07 Jul 2026 09:46:06 -0400
X-MC-Unique: ayJuM21WP0-lNXtr-aCLtQ-1
X-Mimecast-MFC-AGG-ID: ayJuM21WP0-lNXtr-aCLtQ_1783431965
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4773d2405c5so3388285f8f.3
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 06:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783431965; x=1784036765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JAzeUKz5/N2T/7rInHarhTmhaFb8U+NoRbSx7BOs71U=;
        b=M9jSULh0WqAD44nKGU8eoMmEyavMtw3MMiqvW1pkilJWvDDELZ5/vwN4ilSHYsoxNd
         qP5+Pvb/W+uyDnZl3/6o64FGhWvmMby7Th4F5S0SBGzh3aPsceUfN1AiTBGhXAotpTjV
         ir+7cM/inPHNnGsCPmqO6aZl5YmbfmRX/0unDZ9R+Ddni7+nMFTTGYkczNHt965fzgA7
         AmsjhzCx6oMwq4ikueMu5q6SodAduA8eE3JBm0I43Ms8+VswgV0tQp0obNf106YbvjCc
         IZBswXvjRBqSKFHVn8Xqi581Z1+xbDFeJS/DJ+debomOUVynyez7Pg1e7xmCzbv/hSjH
         NKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783431965; x=1784036765;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JAzeUKz5/N2T/7rInHarhTmhaFb8U+NoRbSx7BOs71U=;
        b=nTURt3coNIngPuXQkPcR5IQutKQhtWi1Ee8dTXXrj6pT4YMIp98avxx2DBgZePPI2L
         xvY6WdAJUnLFxRHfJ2x4RkIE6ODJbKeZsCXBMg89eNYrsYPRH9h0aCRdRzqsGj7kXUYg
         dIbpjUvyEUKmTt6Let2+j/tLOlnni3KymQdAAZk7d287NuJCuU2oicm1wbiXoE4PHI9T
         gXJftCrFIkxyC/YKPXqniILOaYzkmZ1D64epdn2hbuJxxpK2crrbzI/gFxsnZI4z4Iqo
         2DQlMEHiosiW/kwnIn5uXrlQ501qs68dJur8vYZxoGK8tSfF1yKTbjDVuXuqKYcEoGEl
         b8lA==
X-Gm-Message-State: AOJu0Yx00RXlWCgltUwgFYBqjy8hntf4HG4HoXxMV/up2VyrNtS0wqA7
	C8nt/c8eiOX+QQw+HUaBtQQaHPZAQwzqROh9LnCPI6mRNZjN0xDdCZy6WyFFRUnj4edQuVl6a96
	BW6iT8bluZyxAXFswtBZe0PInudfZAwajIqdb6Y/I5I1O9uRnbNlIOTDfYg==
X-Gm-Gg: AfdE7ckdFqH2NN+Yxk107WS8ApuipFPZl4aG3C46/8GlNYE/FRo410p9G3xHfGcUbm7
	0wBhWNbRx08FAobdn2KNOn2A8MBDYCSM4E6YTcL6cN7Fs9RwQJ4nqVezSMQbdfibJ/4wClNNzrh
	KhMh3a/sYROzozFXt2ujvPLlFAYILcVUpOqPw5ucY6koRYfCrfXU5YXP/ayJigHhFcaWN5N04Cc
	3IFFFHxbleeWH04pJdF8mJk7fdQYfBtoI8CD2/QEGy6OlKJqlClhaZm86Dhe3nCHdAUPXvfbVvR
	7zUn5ZQceNHCoegyN/X1SDK8QYe610r5qP09w3IrLRimI8ump9b9Mx5IkJ1aUdyp014G4EYOPBH
	WGFoc7CHRs0se6ywrrFrcNf19sFsX7OffY+GuJyJWip56Dci+okWuwgND5VizRJBj4OEgOtvdvA
	/JDfRHz/WESvlp
X-Received: by 2002:a5d:6385:0:b0:474:7bf8:15d4 with SMTP id ffacd0b85a97d-47de6644b0dmr4377333f8f.36.1783431964826;
        Tue, 07 Jul 2026 06:46:04 -0700 (PDT)
X-Received: by 2002:a5d:6385:0:b0:474:7bf8:15d4 with SMTP id ffacd0b85a97d-47de6644b0dmr4377262f8f.36.1783431964162;
        Tue, 07 Jul 2026 06:46:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f213e8sm31190523f8f.34.2026.07.07.06.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 06:46:03 -0700 (PDT)
Message-ID: <e1034a59-1ab0-4a41-b709-9da253d4901f@redhat.com>
Date: Tue, 7 Jul 2026 15:46:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 09/10] net: ethtool: Introduce ethtool
 command to list ports
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Frank Wunderlich <frank.wunderlich@linux.dev>
References: <20260701110427.143945-1-maxime.chevallier@bootlin.com>
 <20260701110427.143945-10-maxime.chevallier@bootlin.com>
 <aaef7304-573a-419e-b631-30b300373a08@redhat.com>
 <7f47104f-8333-4c10-aab6-90552daabefe@bootlin.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <7f47104f-8333-4c10-aab6-90552daabefe@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305479-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:davem@davemloft.net,m:andrew@lunn.ch,m:kuba@kernel.org,m:edumazet@google.com,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thomas.petazzoni@bootlin.com,m:christophe.leroy@csgroup.eu,m:herve.codina@bootlin.com,m:f.fainelli@gmail.com,m:vladimir.oltean@nxp.com,m:kory.maincent@bootlin.com,m:kabel@kernel.org,m:o.rempel@pengutronix.de,m:nicveronese@gmail.com,m:horms@kernel.org,m:mwojtas@chromium.org,m:romain.gantois@bootlin.com,m:daniel@makrotopia.org,m:dimitri.fedrau@liebherr.com,m:frank.wunderlich@linux.dev,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[bootlin.com,davemloft.net,lunn.ch,kernel.org,google.com,armlinux.org.uk,gmail.com];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[vger.kernel.org,bootlin.com,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 912AE71C235

On 7/7/26 12:47 PM, Maxime Chevallier wrote:
> On 7/7/26 12:12, Paolo Abeni wrote:
>>
>> Both sashikos instances points to multiple races with dumps. I suspect
>> some explicit locking is required.
>>
>> https://sashiko.dev/#/patchset/20260701110427.143945-1-maxime.chevallier%40bootlin.com
>> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260701110427.143945-1-maxime.chevallier%40bootlin.com
>>
>> I *think* this is hopefully the last pending issue.
> 
> True indeed, the other issues are sashiko saying "what if we detach a PHY and attach it
> to another netdev", which can't happen :) I agree with some of the locking points that
> were found, I'll address that likely as a separate cleanup.

I'm sorry, but I think it's better to address the above problems with
the main series to avoid a window of opportunity that could cause a lot
of quite randomic/drop by submissions to try to addresses them with a
lot of noise on the ML.

I set the series to CR.

/P


