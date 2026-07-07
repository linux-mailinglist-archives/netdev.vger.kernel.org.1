Return-Path: <netdev+bounces-305425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QNguE6zqTGousAEAu9opvQ
	(envelope-from <netdev+bounces-305425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 14:01:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8328E71B2D2
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 14:01:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OxAaE1xC;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305425-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305425-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2645303AA03
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 12:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873F93FA5EB;
	Tue,  7 Jul 2026 12:00:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106293F88AA
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 12:00:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783425617; cv=none; b=Zl2SSZoHXIa9b4H53rmnd1vT8DDZNbJNY6YCk8fU8OPo+HKIiD53zd/yf039oPv7j6A8EiLPe5mFkK2gWTWGcxgubp7sRaXL+4bTkos2G8bdPvn96EZm0+LbPFT/Vh3yMr2G9+HgJ2zZ3mOnwgh59jdxBxWduKkTK0zpcFJ0jJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783425617; c=relaxed/simple;
	bh=qlDJ746JGiTFJNRIapHXqXoAzifdALXvediQx13XyIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MVX4IIrFobRsYUTr9e74FMSWtseb2p3C7MDrUY/dSf5QyCodw8r0lfLqCOtxpswTVG+jcvrC43ypCerHnbAT0pl2bRxIrgjyuZhVjTmuYXfo4UPR4CimaABJCB3C6t8mYH6ZtzJvnydTp/6r7D8YhYFGC4Q/yhtBJ3ukqNy6pI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxAaE1xC; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493e497643fso1485e9.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 05:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783425603; x=1784030403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qlDJ746JGiTFJNRIapHXqXoAzifdALXvediQx13XyIs=;
        b=OxAaE1xC9empgB7Oh8znVpWuy/t/AqYZnOvpr6qkGq1FCl4Own//li1VQ3aUQ0qVIY
         +KfWwAzw7vxBiE3uaJk/rVVnxnqCSYabZel2F9YtMP5vnAYeC2N6L5LWRA4aPEyxbxsE
         iSHE8O5k1k2fdruGxV5+rYz4zN+HoLoA95mBJBztgdeAcPUrzO4qxSzDlA7TqRQCKxzl
         aYjEa3r5ab4wefrofDX/2kOZZS9pfIu+EzHsfTlMWpxX5Ehl2lPN08cOwlLXo/E6QFGc
         07vypalpD44TtQCXv+wrV0YqQ+EKR6v3hRffVt0gmCRcwcUlsb6yh9Ujqu9jclkSjtM8
         JCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783425603; x=1784030403;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qlDJ746JGiTFJNRIapHXqXoAzifdALXvediQx13XyIs=;
        b=fQbtY5BQbsDscz64LjFXFJBIn7sORw5IBRTB/Nma1luSjJALhzEE1yUASlYXcWewy3
         s2Z1O5qsBsgTnoTiNVV5n+WK5MkruZ/97b4RmdqvVpKum1RXERPESwpFi8E4yE5DchlA
         hazdgKJssuPuhkV/k9k/craz3ggL5doQOKyey/++iHF3DoBFTB59ejtxXP7a03rkpPSi
         RJPKU1QOUXulL/+Y49Zwr9dPxPOSPT7dGOnEpNqlmpqMncZBDYm2FE4adcrPVldwdeql
         KvPj9CIxM3laWgJ5x6QiwOTY4Pp+IJfZ4aqEy/1WE7zRd4aDZUszBsy4+EfHL1x5FUJk
         jhBg==
X-Forwarded-Encrypted: i=1; AHgh+RpmCJsGGTNMNlpe/mPJ+a3YEvh40Mtkx7mPVGjt8hjKl2HPki/MckEjf1R4Bzvs/BARrez+ySQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkjLpXuo51rhbdPVlVzfrreOyhVtAFQugsjZr/r3EFccWei6Fl
	ePDGmBd3FyDAB57vtA9IRIvGK5YFtsUr1PHP+Ud0V96P0k5ecY6r+iHx
X-Gm-Gg: AfdE7clssiiVLCW7qZexgeTEYAZcIczCYZ8fSLyhcG0EOK6PcKkvM0BdjQtbpj1vgUx
	KaGeE94sNWCO/blW82ggWcmZQ9480fDczbqKH9Tr8zx0+MuJQW4XUX7FKJak9DMhH3viaIIAXOs
	s0OH9P99GdfRwTx9tlJqgRbeodV9QW7vKb4x0BG03lMAssENLJSDyWn1BrVc5CPvSTAHZ2hmks+
	9lQ5Ty2yhjXJ/bJ1p610XTF7lHUQFaucAVc4yYcgP6sSoYz9v2qbnyrNfXvtwLixFqOLJXTvwgm
	PkbKSVdYSbMDoQK+Cb1+zFQ1jd9BWgqjFA5TB32FoBX92CqLY5gD0sqi7mr+9q+/8bzfC4X57Fr
	AtzDtlC9tdQ009Gq2qKvTiI9eNIDe8+F24f8+NScFNmX770VJic1yzMPwP4Q3amPBle/MSsY6AH
	I/rHgfUs3lEHAm6OWdahCKMCeAtdScJu5djPK9JeAOMofno+7ROB9bTrUc7tQP+2DqlA==
X-Received: by 2002:a05:600c:3b01:b0:493:a570:df7d with SMTP id 5b1f17b1804b1-493df080ce5mr49199465e9.20.1783425602811;
        Tue, 07 Jul 2026 05:00:02 -0700 (PDT)
Received: from [192.168.255.3] (85-11-142-46.pool.kielnet.net. [46.142.11.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f439fesm54216335e9.8.2026.07.07.05.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 05:00:02 -0700 (PDT)
Message-ID: <e5e61dab-5ff1-4a7c-9b74-d3ed61e6c81a@gmail.com>
Date: Tue, 7 Jul 2026 14:00:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/4] net: pse-pd: add Realtek/Broadcom PSE MCU
 core
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Golle <daniel@makrotopia.org>, =?UTF-8?Q?Bj=C3=B8rn_Mork?=
 <bjorn@mork.no>
References: <20260706112425.3149226-1-jelonek.jonas@gmail.com>
 <20260706112425.3149226-3-jelonek.jonas@gmail.com>
 <akvhq1YcUFP6eizf@monoceros>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <akvhq1YcUFP6eizf@monoceros>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-305425-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:u.kleine-koenig@baylibre.com,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8328E71B2D2

Hi Uwe,

On 06.07.26 19:12, Uwe Kleine-König wrote:
> Hello,
>
> On Mon, Jul 06, 2026 at 11:24:22AM +0000, Jonas Jelonek wrote:
>> +#include <linux/mod_devicetable.h>
> Please only include those <linux/device-id/*.h> that you actively need.
> I'm working on getting rid of <linux/mod_devicetable.h>, so please don't
> introduce new users.

I'll fix this in the next version. Thanks for the hint.

> Best regards
> Uwe

Best regards,
Jonas

