Return-Path: <netdev+bounces-299484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A2TDFrcMMGoWMgUAu9opvQ
	(envelope-from <netdev+bounces-299484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:31:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C479687316
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:31:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ivOvFk7v;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299484-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299484-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5247C312CBEE
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D383F825E;
	Mon, 15 Jun 2026 14:27:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A3F3EEAEA
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 14:27:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533630; cv=none; b=CC/Ow7l9HcYfHbGkix0rBLzr58KZrU4opjKHWPVODriv6S1jFw4GI7gjsbRQTmtyXSt1++UeLso7YGlXZ8cpD50GL/s2lRQ1ANs7xKA/lPpFTgNDdLoYR4c6pDofeNSbeI+JcLiBv/fVoUicd8Cmr4sbi0hgV2l327IdtB9I15w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533630; c=relaxed/simple;
	bh=j7+uubWqjHwfd1F7rjwIRnsarTP5b9XzajE97ofcr2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aR8bslGYSsVjortMyZh7ffFYuOF2NlqXeh01ZCkHmFxbf8KwmpwVxXIsCpG6zEAF9Ik4TpKyYlQeBYh9ul44/k3QxrKjvZnk9odHRlbkSJtcqmDBWA3YBeOlJcMt46l8X/3Y9ioxQgrVPFTh+HDb102ew+CMoIPgBF6VDd1rHIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivOvFk7v; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-46066e640easo1976780f8f.1
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 07:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781533626; x=1782138426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=m4TXTtdFs/UmLl+HYnmyNiKISILvfZx2SzEmdXfYHcQ=;
        b=ivOvFk7vOkZBbOFiKdbZF59WTRWUON7NhJvMeWXVYQYGBAojB8h32ET3YxgwrORAIE
         jMcOp2cBOqsWe+R7alJErluOjvefaane1lGSLQb1t+J7hdRXJgKi297mhQs/nT75OlZx
         7Dg3cjzYHgoGWBeGrHwtfcXVFzWVzE2bhVeHQ0NUWcLNPAgjYN69OKMDwmMvIcWqy8MD
         wpoXZho3dWV9jSAYxi7TbujpSj3l8Qr4/ObmkKcf2fubdiwhBK4eMJawiEqRhBv8YeHA
         mdIMfhLZXMvSR9z/Nfqr0ILomuuIzmnIfWnHPqpB/oh3yf+3yL8b7h7R8hK86a1u9YX9
         HkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781533626; x=1782138426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4TXTtdFs/UmLl+HYnmyNiKISILvfZx2SzEmdXfYHcQ=;
        b=mRdPC5lZghhZWgv2wTPHyqPtCBkDRZvHVIJoI4iK//z8VFaL1D3YOFbtMomYF9W3pq
         axH4kvPGICNLAarzxnpAbydFKd9Gw0oFyvv6KXsCCqi38FIcaEcWYzm1ERBYPIfwo5pm
         7p/j8rUlrys99kmwcWYb2oj+Vr+OSq7qbRUueOS7pg8G35NFosV1fxjjvwxG+XDR3CtN
         RQmdZBqIjxiHkgE3GpcW+F7sfFlqSVyqZKwONyrGMNlCkS4OxytRUAw8XhqD65t+udID
         UnlchtE78I+FjZGfZb8VLPRPKNKGnZ4dWgnk0kdz4fvYgf69RiN3KzvUr2A3SpI8m8VY
         YNEQ==
X-Gm-Message-State: AOJu0Yz05Ap2/KrjniNQN8GCWy0fJLz0wu1vT5hk0TgJNoV+d7dJe2iO
	oY70K5d2xG18ZjhioX4ZVzaESs5eXyRTB+SN3w44RPK9kaUX/Vp6IFIw
X-Gm-Gg: Acq92OHRbA2Sqijik1gzvlF9h09HlUq3lnQ+P+cRxQI4cZcljpERamwb1aaRxiSKjZi
	TMiQ8CewGEi2vlhrJ5XMeRUnnAZtRUhotNICfQ5oTKyT75oApq1/RUf52/1unX2M/S19GJ/bojc
	iAtMORhLaAnksKH4XXzUObtopuLcEzPt874N6B+vENQLioaMEec5uHv6Je6RrEf3ligXgsxTqb/
	iIm0xW3HnaqpgMtibMzsjcmUc61Eh/lT7tE46XuQjSHtzzeEkcwn5J+WybdekMNIjdZa5ZILfHL
	2GAIIg7dn336B6Df3F42a+JodQVbYJjUPuNbrh6xkSXYcWBHTvDAROw/RVQHtkNw5NdL8LnDZk/
	uR2zk3Ak8UaA0izMA4zvSGY9yXjPrwLGgEfmONG/kh1bQm3iS/tHbMFYi5moCuRai9tFQh1Z9gP
	koebxdvoMNtv3F5KJ3ABkn2kxKFZrpSET/VEbbnA71qNiN+0k3VP/ejIJz1ZlHphyfurod9f8i6
	94Ir0uSxFS4MWi4B9U=
X-Received: by 2002:a05:6000:2dc2:b0:460:3234:4473 with SMTP id ffacd0b85a97d-4606dbe5c27mr19933766f8f.41.1781533625617;
        Mon, 15 Jun 2026 07:27:05 -0700 (PDT)
Received: from [10.128.10.215] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f264333sm35600275f8f.4.2026.06.15.07.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 07:27:05 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <90f84945-e83f-40a8-8d9e-a477c45579e9@gmail.com>
Date: Mon, 15 Jun 2026 15:27:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 12/15] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
To: Selvamani.Rajagopal@onsemi.com, Andrew Lunn <andrew@lunn.ch>,
 Piergiorgio Beruto <pier.beruto@onsemi.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 Jerry Ray <jerry.ray@microchip.com>
References: <20260614-s2500-mac-phy-support-v5-0-89874b72f725@onsemi.com>
 <20260614-s2500-mac-phy-support-v5-12-89874b72f725@onsemi.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260614-s2500-mac-phy-support-v5-12-89874b72f725@onsemi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299484-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:andrew@lunn.ch,m:pier.beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[julianbraha@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[onsemi.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[julianbraha@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C479687316

Hi Selvamani,

On 6/14/26 18:00, Selvamani Rajagopal via B4 Relay wrote:

> diff --git a/drivers/net/ethernet/onsemi/Kconfig b/drivers/net/ethernet/onsemi/Kconfig
> new file mode 100644
> index 000000000000..8d72194151ea
> --- /dev/null
> +++ b/drivers/net/ethernet/onsemi/Kconfig
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# onsemi network device configuration
> +#
> +
> +config NET_VENDOR_ONSEMI
> +	bool "onsemi network devices"
> +	help
> +	  If you have a network card belonging to this class, say Y.
> +
> +	  Note that the answer to this question doesn't directly affect the
> +	  kernel: saying N will just cause the configurator to skip all
> +	  the questions about onsemi ethernet devices. If you say Y, you
> +	  will be asked for your specific card in the following questions.
> +
> +if NET_VENDOR_ONSEMI
> +
> +source "drivers/net/ethernet/onsemi/s2500/Kconfig"
> +
> +endif # NET_VENDOR_ONSEMI

When you put the 'if NET_VENDOR_ONSEMI' around the 'source', you're
making it a dependency on every config option in that sourced Kconfig.

> diff --git a/drivers/net/ethernet/onsemi/s2500/Kconfig b/drivers/net/ethernet/onsemi/s2500/Kconfig
> new file mode 100644
> index 000000000000..f2e8d5d1429d
> --- /dev/null
> +++ b/drivers/net/ethernet/onsemi/s2500/Kconfig
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# onsemi S2500 Driver Support
> +#
> +
> +if NET_VENDOR_ONSEMI
> +
> +config S2500_MACPHY
> +	tristate "S2500 support"
> +	depends on SPI
> +	select NCN26000_PHY
> +	select OA_TC6
> +	help
> +	  Support for the onsemi TS2500 MACPHY Ethernet chip.
> +	  It works under the framework that conform to OPEN Alliance
> +	  10BASE-T1x Serial Interface specification.
> +
> +	  To compile this driver as a module, choose M here. The module will be
> +	  called s2500.
> +
> +endif # NET_VENDOR_ONSEMI
Which means that when you add 'if NET_VENDOR_ONSEMI' again inside the
sourced Kconfig, it's a duplicate dependency.

I think putting the if-endif in either place is fine, but it's redundant
to do it twice. You could maybe consider using a comment for the second
instance instead.

- Julian Braha

