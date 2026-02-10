Return-Path: <netdev+bounces-258126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC+DDORmi2kMUQAAu9opvQ
	(envelope-from <netdev+bounces-258126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:12:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C1511DA81
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F299130059A4
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 17:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197F83803F9;
	Tue, 10 Feb 2026 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GXngzJVS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0CF30FC18
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770743522; cv=none; b=V1eDrjRDWP1rLdJinw2ty77XQNbR3tyyS71wy7tPSXujPVkVoeS6lhlZ5y9CgBacvkpvUUARyiPq1//Cn/QTIZrzvx1HQ9k2Q1yNkWxwyGpsPJ1cQhgeuKmdWxcptEgDW6deQBBd646QNImngPPmb1Yq+XyIMlpXarVxyINz1lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770743522; c=relaxed/simple;
	bh=6E4AVcrqhq0Rc/Kz44W7TtsleZubZ1VsQKehow79XBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OtGZ/uB2/x5vQTfw5gjUcpLy8UnkGmcgACpnJO0hcHHhs01Q43yNrZRG4tSWBV5yz4yFqibbh/hBn9QCJIccpfZmio5u44TEAceb7HC3hP4nQyVYEMcegHexwRHUlQEcfdq9OKJUX2sZjBG9RO4Z51eTezqSG9V3KNrX5U6OuoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GXngzJVS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48068ed1eccso58825315e9.2
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 09:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770743519; x=1771348319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Euu3zswO79B4329lA7pwpz8390Xu/2KZ0WRYAjQPlpI=;
        b=GXngzJVSNzJSG09BxsAO+Td+b7+4nwsSuacI3tspndp5bsETZbH9stNkF84mG2xWIS
         Q1z9m9kbIAbdXN6wZ9P5QTSasWJDXgpqxGtBsizk2CDbNiehMJAi9xVwU3dm1KYJYGS5
         sUFOXBocAPogcl7Ux5QI2qNExHhUatmDV+Z+/tgky9ecbxVsAhl68cKzWQbcDPPWvyhc
         GWFAB1obAMdO/6B6LDDEd0+ZDeXSvCgMjiy+P3iyvHyn1jLo0uO65usWPbkZB33uW1dX
         oI89SdG/ggvF5CwpiBPIa92Hr0qmlMfCmz5oCHa1TJUp3ryBuik55FaHELUE9oKvvAv4
         JL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770743519; x=1771348319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Euu3zswO79B4329lA7pwpz8390Xu/2KZ0WRYAjQPlpI=;
        b=vituHJx4ERPJjvpEDdzfiDKtKRlfuPPdyyMuVDUl7rZ+DZSEHME9m82wovAFKF2MX9
         WONwAoXuNNLvyMcxCvtIqHkeWJplWj6Z7LGO6xK74ugnoEKop4AoQxQvgLa3QPH7Ksgz
         KyfJ6pPAMiaccOTBbsb/ri7+xWu9K9aMJHPEqp56scUs1UJZOPHVmdIbciNTF0OwmeTB
         xOTnccWomzXUAo2JtA8s4bvnyi+nU2J1i6ALab+PhWZIFmwgpg0HprmJ4nGUeJSpYa3L
         MtG4S85OBYNIK6IuPm7owY7paevPjShHRxKVVxGBTc09zbWUgbcVIE30buWue8Wp3qbK
         WjFg==
X-Gm-Message-State: AOJu0Yz0aeX6oy3Bjf9iNE/AjA0ilHQ5OL7FDxXV9A6wfLb6m+ofMenn
	D+++GLz5T5+2tFwnLaHtJpKMQtnrFKvc9fkDB/EWroR+M1OZFJOp8VORoMt+SeMuusSwrerhtKU
	Iu6Pe
X-Gm-Gg: AZuq6aKsnMjPgcWsWjHPMrcoLVqikPu1iJbv4v/8NZUURbVCuCV2UfLNdxS702Mkk+i
	JtGkVCbaNHEFxgqhEVrOzCQ2dU3EwLHnIf+Eq3TERUg5TUUtOxGxuVutTxwjCiTmVpISm14UAfz
	0CqoapJtmI1ZZwm7D0L/EbB4QG6bi/2eqhx2+KeCl2UUYkUd+3ShN8W0HP6/mMy2b8MHnkT8puL
	QQ1gGQlZgEhpTg6gq3Z42+aN04shG7DXtDmD9pPh9mNdK6uCRVdVi31ZD72+dW4e+TTrZCsA+y6
	am9TGNs6gfqk3gBCOMaFhS6LUq8fpZbx/tbBGP8XdQ452ypJzxxT6dSBA/UaMeVZQAiRlPUorQg
	EZt4u2R3RUTOG7Hsvm0Mi6XwW3MAf4XM+rBT4LUn4eVTdzSqENrVk6+CloeNE4QsMMbrJ0OMzUd
	ZedyleOE4OxexcW/2j6IHfUrzQbxacXbCAk8m8T3kM3L7O99IGdmaOshVlP4dVDD9UwQ==
X-Received: by 2002:a05:600c:548d:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-4835082d198mr45460625e9.27.1770743518926;
        Tue, 10 Feb 2026 09:11:58 -0800 (PST)
Received: from ?IPV6:2a02:3033:28e:5b9:65c7:cd84:ea3b:5d6c? ([2a02:3033:28e:5b9:65c7:cd84:ea3b:5d6c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483203d60d0sm129416785e9.1.2026.02.10.09.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 09:11:58 -0800 (PST)
Message-ID: <98556af0-cb77-4f8b-a8f8-a121a66a8a76@suse.com>
Date: Tue, 10 Feb 2026 18:11:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 1/3] net: usb: divorce private data and cdc state
 in usbnet
To: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Cc: netdev@vger.kernel.org, hayeswang@realtek.com, o.rempel@pengutronix.de
References: <20260210151416.42254-1-oneukum@suse.com>
 <20260210151416.42254-2-oneukum@suse.com> <87ikc4mumr.fsf@miraculix.mork.no>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <87ikc4mumr.fsf@miraculix.mork.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258126-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 92C1511DA81
X-Rspamd-Action: no action

Hi,

On 10.02.26 17:27, Bjørn Mork wrote:
> Oliver Neukum <oneukum@suse.com> writes:
> 
  
> But I don't understand why you make struct cdc_state special.  That's
> just confusing.

Because technically it is a layering violation to put cdc stuff
into usbnet. I want to do so that I can remove the exported symbols
from the cdc_X drivers and put them cleanly into usbnet.
That is the medium term plan.

> I know I intentionally made the "control" and "data" fields of
> "struct qmi_wwan_state" position and name compatible with
> "struct cdc_state". Maybe not very important.  But adds to the
> confusion if we end up with a double set of those fields.
> 
> Or should the qmi_wwan driver split out the
>          struct usb_interface            *control;
>          struct usb_interface            *data;
> 
> part of its private data and put those into "cdc", allowing us to reduce
> "struct qmi_wwan_state" from 5 to 3 longs?  I don't think that's a very
> good idea...

Well, QMI is not CDC. No use pretending.
But we could put them into struct usbnet as primary and secondary

	Regards
		Oliver


