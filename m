Return-Path: <netdev+bounces-295186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B1DxM2BeIWrKFAEAu9opvQ
	(envelope-from <netdev+bounces-295186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 13:15:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCA363F56F
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 13:15:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=X6bP4QGV;
	dkim=pass header.d=redhat.com header.s=google header.b=jtejQYAR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295186-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295186-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27E583016905
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 11:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8EC409615;
	Thu,  4 Jun 2026 11:07:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A79C409602
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 11:07:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780571243; cv=none; b=H9Almf9UHDvODZU+fRWMXJUK3LHhaMVKhkInTnNoo+U1RIAAiPNFBPWTGfTewFqqL4MS0oCsLX+e+sfdXM3VP0O7Mt2LllbsuYPNe8H/S8vCzJd22gFRHNwfhpWzxX6vmFFSPXt3f3wBZjZWSaYXg73lRAvqsrAaXre5GXTpZjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780571243; c=relaxed/simple;
	bh=tBgp5vRQFOl7a8nBW4mepV+LziDESM9zSsnbBm6iXLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=XY6jWsZfbNXhfuZbIBEyAgWIufkvBQf3dOFSDV5PWdKdSkPDB666jFixoHReBxLdkO/PDMPcMtpFZMDn01NIvll3hPNbUPRifYvFxiBjm+RyWr+AQBJpkkAnU+eKmlY+RAgveS1RI0HXsn5sxEYmrTeBDQZ4RNbEi8SO541+7Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6bP4QGV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jtejQYAR; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780571241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AK5uzOYSCwraOmBHC9lcOGmnhT5oZxWafdDkYZzfB28=;
	b=X6bP4QGVYNF7Z76bUUhOHAM+6QBR7zmKQSSUw5rFMuRSlcSq5jETZK/Lvv7fhAmXnFsp5f
	Y59HFebyO1ma4M8GwOYFBU/duTqEzlkcWc8crF947Je0CIBdcoN3uo4+wwtoSjAPNFx3sy
	uP6A9cU7xGABRrZTsflPCWSAkp8zYuI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-NLfunxI_NAm2Zq6UTsgV1g-1; Thu, 04 Jun 2026 07:07:19 -0400
X-MC-Unique: NLfunxI_NAm2Zq6UTsgV1g-1
X-Mimecast-MFC-AGG-ID: NLfunxI_NAm2Zq6UTsgV1g_1780571239
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45eef10d5ebso301549f8f.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 04:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780571238; x=1781176038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AK5uzOYSCwraOmBHC9lcOGmnhT5oZxWafdDkYZzfB28=;
        b=jtejQYARh1ZcFlts6Ajztfi8j+ryKKybSzck+arZ2zAuD/r7nOW7gRvEO7CgSjwPKk
         DRICOVnk+HWp5DKKCLYjjt28QickP2QiDbHa6JyCMtCQ5GbgBOZArWsP6VFgZgVKXuwJ
         1vYRsrnl7PnULiz8sR6uIL49+SjShD4BJ+i90goi1bNHjm4fJg7RcAygjO6ZyYjmSR/D
         kJ3QTWbuMGPPQCESUjRQ/8nOdYDRPHlLz983GUTcb1R5OHIVjLGtndmmPaDnzmOZk0gq
         zLC+9F2tAShB6NYWrxjpBmXXm6amk0zIed6BCHSlI+5n0TR9bWyTvzQlaEfuStqj8uH/
         a7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780571238; x=1781176038;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AK5uzOYSCwraOmBHC9lcOGmnhT5oZxWafdDkYZzfB28=;
        b=JlMGA18uEPV/TAr0+o0gzYFW+cz2zYeH85hiC2Z9VKtLwACc6X1mVT1UvtMJhUuc/H
         hoJZpTmv7iYXHNluJ+sPbWd3VvpaFocz78HlfpdQT2+DF4i1wE1jJr3d09cm/fnTdgDC
         /yWAGyIclGbOac6mc9uW+Y0pbU2DcNvz6PzAS01HPngXNykNXss7JSxk10ZyAdIR6dAb
         OwgpFSC/HeWBdJWrYirT7cngRSNd1NGwco3+d47VtJMZF9MEmPC16DOsoxahrWZqZe4B
         nZqjhcy9S/2B0qRfg+/jexPKXHyZHTDocS9NkVjF3GfmmPB1YT7FcKDAEyxtPbe+rzOB
         JZAg==
X-Forwarded-Encrypted: i=1; AFNElJ+9+Ey9YTbvjUqyoPg5H8NPWfr1GaIDXvhJ/lsPeEBa4ZB0U9C8nKcNTiXS86CBgrBY5b908H0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwitaAnGziqKYjfyIReqM0ANryYxSVcBsX3W1ic+qxb2QJsca/r
	UKPbDvSbwDCFYSL4BCS0MxBDC1k71i7H+KEeERsmfLY0vlrLF2tG5hLP9hQR6U31nzT9KeqhTLY
	p8Z1Zq9ZBL1mNsuNCjiZqWPXeK6UdZiDMJw6oL6Z7VuqRmVQzKfi2bh3cuA==
X-Gm-Gg: Acq92OHjcDZ861DEGNL5DqOgUSg0cVEwL9jX7LtAUe1TGe2M/PN78sqPDBQ03P1s5Wq
	6mmLKRl4XOLzscKiL+2xodxLhKP+bQ71XvNGnNKFIvS7MR9DgEPRvX1z7XSFgqgCxxv94MIxrcd
	yWrmKYthk70+rR02EzEGanFzWaF//XOlBs5tCrqUQ8lX0sZ6KIz+zqkghp94I9MUanC/yA3g2+D
	7PblMIZ5DvwX1WvtU/qNLIZ3qdX/apRtVOti/pHgCoNsFXB9/lBavYUwhtGNZPyJZ9syntdDVPj
	RO7mUUt2brnRF4xzSojuJdLf6AysHjGLdUFVlUkWFyu8DwvR2bPMKlcOkwK0U9IZgGjxrH2c9j9
	wnkSWlRlfASRPq35RG23j0KWKpcbUmQ8crKnsRYBAf//Br+HrTPPUTxPBR0hLdTH2i+8=
X-Received: by 2002:a5d:640e:0:b0:43c:fc5c:a9fe with SMTP id ffacd0b85a97d-4602182bbe9mr8255849f8f.20.1780571238600;
        Thu, 04 Jun 2026 04:07:18 -0700 (PDT)
X-Received: by 2002:a5d:640e:0:b0:43c:fc5c:a9fe with SMTP id ffacd0b85a97d-4602182bbe9mr8255812f8f.20.1780571238218;
        Thu, 04 Jun 2026 04:07:18 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm15396808f8f.28.2026.06.04.04.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 04:07:17 -0700 (PDT)
Message-ID: <16b81f1a-ae24-4a05-a348-0259f8935378@redhat.com>
Date: Thu, 4 Jun 2026 13:07:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] net: phy: as21xxx: force C45 OPs for AUTONEG
To: Christian Marangi <ansuelsmth@gmail.com>
References: <20260601105342.28865-1-ansuelsmth@gmail.com>
 <20260601105342.28865-3-ansuelsmth@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
Cc: Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>,
 Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20260601105342.28865-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295186-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,davemloft.net,gmail.com,lunn.ch,google.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ansuelsmth@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:hkallweit1@gmail.com,m:andrew@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BCA363F56F

On 6/1/26 12:53 PM, Christian Marangi wrote:
> With further testing with 2.5G NIC, it was discovered that the PHY
> require the C45 OPs to configure and restart ANEG or speed higher than
> 1G doesn't function correctly.
> 
> To force C45 OPs with generic PHY function, clear the C22 bit from
> devices_in_package bitmask.
> 
> Fixes: 830877d89edc ("net: phy: Add support for Aeonsemi AS21xxx PHYs")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Sashiko has a few comments here and on the previous patch:

https://sashiko.dev/#/patchset/20260601105342.28865-1-ansuelsmth%40gmail.com

could you please double check them?


