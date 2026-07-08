Return-Path: <netdev+bounces-305938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bvx7FF+STmq4PgIAu9opvQ
	(envelope-from <netdev+bounces-305938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:09:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B55B17296D2
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:09:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=gviw6Nco;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305938-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305938-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4BA130120D6
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ABA378D77;
	Wed,  8 Jul 2026 18:09:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578E7377006
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 18:09:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783534171; cv=none; b=ih9bg7rKdNSjUlJnnvXaXqzwgs6rJtEdh8YlbhC7i2Kvia4BfOxzVpLyxFcW6n+QQKUlRrMtz/B8D9wdk3KuAQ+Z66jrfDFKN3+IFiJtAghZ4gSwluZpFhvHffV8zGbEh+JodAoPpxhJMBNFro7tFI3QKXjXhYrKwfy/jqw96R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783534171; c=relaxed/simple;
	bh=1cslmbdwiNueRqfh2a3Jv4FoUlr/3mzm22PGhSNq6Bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyO9MAHd4XQG15RHrYOTuJ7VfVe/HGFkauza7mQLCxEisjapkRFmM0Be6Si26b3rEdhfJo/EN7oU6RU1a7xm+Rwz/yhleqqYlgFg24e15OvXB3kzOU/iltWEmuNZgFhCplAiXzLaTXAxAjHW1yBkcSrvh6hNjo5IXxJwcfVlWM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gviw6Nco; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783534169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t0l36wH7ACcSK7YRfFa0NfUzN3zxMisdAMh1oZ2Yw5g=;
	b=gviw6Nco2oDMPQkZjH6RI78w1mXag3N202scFUKVUMYbLU4CugrJNuxAURBf7Q8bl8jYTL
	qv+2+PkAFRMoJNiqfdy5y77hxI7r9Srkh5opxov+HQCdWv8fWj/Dck40yRy7roXY5268qC
	/oJhXvvILRlDcDUZT06ve1xm4nCMjP4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-DDAKTR9yNJmRpiw6FM1Uzg-1; Wed,
 08 Jul 2026 14:09:24 -0400
X-MC-Unique: DDAKTR9yNJmRpiw6FM1Uzg-1
X-Mimecast-MFC-AGG-ID: DDAKTR9yNJmRpiw6FM1Uzg_1783534163
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71B7319560AD;
	Wed,  8 Jul 2026 18:09:23 +0000 (UTC)
Received: from [10.44.50.138] (unknown [10.44.50.138])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B2C41180065F;
	Wed,  8 Jul 2026 18:09:21 +0000 (UTC)
Message-ID: <e7517908-f02c-4c5a-ac63-34a4d26edf41@redhat.com>
Date: Wed, 8 Jul 2026 20:09:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_zl3073x_flash=3A_utility_=22family=22_register_?=
 =?UTF-8?Q?=E2=80=94_0x7C_=28driver=29_vs_0x7D_=28Microchip_ZLS30733_referen?=
 =?UTF-8?Q?ce=29=3F?=
To: Mike Frandsen <michael@cambrianworks.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, netdev@vger.kernel.org
References: <CANEVyMq03cwnhjc_H5hWMXwC1CH=V8OZDQFNT+ufzpHOOYJaaw@mail.gmail.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <CANEVyMq03cwnhjc_H5hWMXwC1CH=V8OZDQFNT+ufzpHOOYJaaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305938-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:michael@cambrianworks.com,m:vadim.fedorenko@linux.dev,m:arkadiusz.kubalewski@intel.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B55B17296D2

Hi Mike,

On 7/8/26 7:08 PM, Mike Frandsen wrote:
> Hi Ivan,
> 
> While porting the zl3073x flash sequence to a small userspace tool for the
> ZL80732 (Azurite), we noticed a discrepancy between the mainline driver and
> Microchip's own reference flasher about which register holds the flash
> utility's "family" byte:
> 
> - drivers/dpll/zl3073x/flash.c (as of 01e0e8b6a2d7) reads the family from
>    register 0x7C and checks for 0x21;
> - Microchip's ZLS30733 reference code (shipped in their AZFB firmware
>    bundle) reads the family from 0x7D (masking the low 7 bits) and treats
>    0x7C as a different field.

In the reference code there is a confusion... There are the following
constants defined:

static const Uint32T HOST_REG_VERSION = 0x007C;
static const Uint32T HOST_REG_FAMILY = 0x007D;

These constants are nowhere referenced and the code uses hardcoded
values:

     utilityHash = HostRegister_read(pContext, 0x78, 4);
     utilityFam = HostRegister_read(pContext, 0x7c, 1);
     utilityRel = HostRegister_read(pContext, 0x7d, 1);
     ...
     if (utilityFam != 0x21)
     {
           status = ZL303XX_INVALID_OPERATION;
           ...
     }

So the family code reported by the utility at register address 0x7c and
should contain the value of 0x21.

> We have not yet confirmed on hardware which location reports 0x21 after
> the utility loads (our port defensively accepts either). Do you know
> which location is authoritative per Microchip's documentation — and if it
> is 0x7D, whether flash.c's check works today by coincidence of the utility
> images it has been used with?

There is no official documentation for this :-( but according my test,
all known utility versions reports 0x21 in reg 0x7c.

Thanks,
Ivan


