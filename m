Return-Path: <netdev+bounces-298082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DWVcHOWTKmpsswMAu9opvQ
	(envelope-from <netdev+bounces-298082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:54:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A46967111E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:54:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="IpIjhR/J";
	dkim=pass header.d=redhat.com header.s=google header.b="d/IYDeuq";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298082-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298082-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82B5A3003804
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F51A3CAA57;
	Thu, 11 Jun 2026 10:54:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CED3D9025
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 10:54:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781175264; cv=none; b=o8HiiJntDq7nNXj85ItgpYCm/SuuxVCrMQ8Kx84ibD2PEB6OCy38dxg/uVwixMocTsebjSie88mVu0G/VA50xuorrmUSnujNeHrJvz7BYgJZDeK4is/SHL4XQqcZGjVaE1YBABnnsXTUj2bpd+nn4XqRGsmjYVhqfquI+L84heE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781175264; c=relaxed/simple;
	bh=ZodCN4uhz6XrP7UbHa04RT9dDJXvk3/VxIn5MooEpsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6nBuObR9sjyR9EcxyrciVeOiE2Pyys02WzuhN2K9G94dDMnPcxBUmbnemqUdSAC9BCW3owQIwci9MiZzNf8k/FnDjVIKVSiVNolxGsYd3OEqhVrLnoPAtnzMSzPqwTJtWPhSpihvCanOwEyN7M/tHc+IxnxZJOqp2nusYUevGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IpIjhR/J; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/IYDeuq; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781175262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQ4Djg9Cs6sl+9Dlt7Aw90JJd6f3zXnnKudBQrDEDFU=;
	b=IpIjhR/JbitMPwWH7HdWUyEA7K95MJD4sk2KCwsn/ggOoXkgrxDqewm3ocarXzYg3T5EQx
	qkX13l9q0SwJ5TOg2K3NFAX5ba7kQ/4dDzRLwgIcuj+jrZQa1FJYUEK0P5+calkN96dm2T
	wCnadQKSPMHJOdtk9mzxMLhZkwTNu/8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-qgL8FewtM7GytS69ylqM9g-1; Thu, 11 Jun 2026 06:54:21 -0400
X-MC-Unique: qgL8FewtM7GytS69ylqM9g-1
X-Mimecast-MFC-AGG-ID: qgL8FewtM7GytS69ylqM9g_1781175260
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490e547f3cfso5063635e9.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 03:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781175260; x=1781780060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQ4Djg9Cs6sl+9Dlt7Aw90JJd6f3zXnnKudBQrDEDFU=;
        b=d/IYDeuqlfHhzyt2ZB3rnYvzAt4alXXV495lMRDErW3vqWcQExojiGXhQyTrvcadNU
         GQWhdvhzDUOLcPiejaMnBvcvbUa1KKOlpQPW7RUON6+lDThczMBI7swNR1XezB9mi37S
         lLKcxLEe6D+Cs423NjeE7TAzxTxGT3jc3gflCv0GHuhDm5WWlrAFPli79+gQ4jLiUCpl
         Bxqw6xijcZCcIq2/PXZRjO5+/0NQ4u3Rxcd4EJTB95iplsWY+74DAJigCktJSh/6k2xS
         kxG0383d1z1rrIDE3b32NINjFMWz6xVcKr8g0NEipg4OQ51nsrsLHTT0vEOvZa6LERFV
         lKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781175260; x=1781780060;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQ4Djg9Cs6sl+9Dlt7Aw90JJd6f3zXnnKudBQrDEDFU=;
        b=nDz2C27Cs6jF5H2JfMmr+emsAIvqWhswjbBqs+bG0MvHy2AJqNruccMHe6UEWDJUCn
         iAX1Dp2ZW77M8WpIXVcKN3hiAE23MTImb12YFztRq3oVgpMU98GfLEXYploYVlZdQoA6
         Ly7IugiKsS2XoZ8mZTXXGbAnXhvsJ5xikUz+msYXAt0nqn3LakwskpTBdWMnhQ1dyK3O
         UQMzDjC21mgC/ix36f/qdg7DHiUAnpQKJI9CO7U9Qc9H2nX9d34lBVMG+kvAZkUXqBfB
         stGEQ9wdg7WM4ixMowts5auSD9f5Ti5dRIFPoZbdw/pSMDq1Gd3hDmVnGZUjbb+bwr0M
         JFQQ==
X-Forwarded-Encrypted: i=1; AFNElJ8sYKhYXSOtaV/EfuVDLos+wDzPHgMw8sk0jUrwnrt0EnfjR844Rc0ea6/q7OqHcVNugtm8aZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHvE/niPlH9q8LGCIIlXXMalriUvgMNsGOu9b2bL3Li6OuF8HF
	xGaAFek/V+RHy29sx3aDex7mQNQ7rbjPB1oUslsbLjKLlSqiHdsHhneH9QsBBOUMUCnwyjRZphY
	cWBqT+FXg8TI2WhtjYHS66kSNYTvUyoXQDldfonS/nT9osOY3zfYEw1e24Q==
X-Gm-Gg: Acq92OGcR6/K+WQlzn2OFcwCsOnZ4vwqDbNdo0KckGvZs1Zja2C8qzmjXKiALdpC+ej
	Psai568wgrvjN/9Ci+HhlOhcF8+3lyiNoEvbmJVS3Hinv83r/ib5krix2/sLDNa3/lqKfwK9hoa
	wydV0TVmF6yLmkVfGZq0CRY+1y5HCvqd3SHZIRx4e/NMI1OuCuKB0qxEgjIaGpOBuasDq7dcm5I
	3tmZNnj43Nk1T3Oo5M1ppSui5hXWzfJgi1fJTtvuWLVeGK+aW0aXjpF3alWYIXYQBamDF9SHyqc
	AY+ih5+gKt9SieRbnhA3w3LqXyc3D/Y8Tm9YDtrLqAFnJ9lwKh+G8TylDdqI7ubWuxXvcG6vZNj
	yzvPE2ofHkpD7lngO4oxD0K4Uex8X5qzzN+KmF2+FM7ljYEBjhVl1qjmqz56eB0jocA==
X-Received: by 2002:a05:600c:c10c:b0:490:ae52:499c with SMTP id 5b1f17b1804b1-490e5619a81mr27893315e9.21.1781175259720;
        Thu, 11 Jun 2026 03:54:19 -0700 (PDT)
X-Received: by 2002:a05:600c:c10c:b0:490:ae52:499c with SMTP id 5b1f17b1804b1-490e5619a81mr27892825e9.21.1781175259311;
        Thu, 11 Jun 2026 03:54:19 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e52b361bsm36111895e9.7.2026.06.11.03.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 03:54:18 -0700 (PDT)
Message-ID: <01b8171c-f684-4525-8f98-2d41c9b62f80@redhat.com>
Date: Thu, 11 Jun 2026 12:54:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 09/10] net: dsa: microchip: implement
 lan937x-specific MDIO registration
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260608-clean-ksz-3rd-v2-0-6e61b7be23c4@bootlin.com>
 <20260608-clean-ksz-3rd-v2-9-6e61b7be23c4@bootlin.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260608-clean-ksz-3rd-v2-9-6e61b7be23c4@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298082-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bastien.curutchet@bootlin.com,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux@armlinux.org.uk,m:pascal.eberhard@se.com,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:tristram.ha@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[bootlin.com,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A46967111E

On 6/8/26 4:10 PM, Bastien Curutchet (Schneider Electric) wrote:
> All the switches use a common mdio_register() function that uses two
> ksz_dev_ops callbacks (.mdio_bus_preinit() and .create_phy_addr_map())
> to handle the lan937x specific case. These two callbacks are used only
> at this place in the code.
> 
> Implement a new lan937x-specific MDIO registration functions that uses
> these two lan937x-specific functions. The lan937x bindings don't
> have any 'interrupts' property so this lan937x_mdio_register() doesn't
> call ksz_irq_phy_setup().

Sashiko noted that ksz_irq_phy_setup() manually populate the mii_bus irq
array by mapping the switch's internal port IRQs (PORT_SRC_PHY_INT)
rather than relying on the device tree and stripping ksz_irq_phy_setup()
may lead to regressions.

Is that a false positive?

Please note that to help processing the series, you should comment
proactively on the AI reviews finding.

Thanks,

Paolo


