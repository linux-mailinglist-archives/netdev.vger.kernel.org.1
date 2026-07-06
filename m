Return-Path: <netdev+bounces-305054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SyxVGhHES2q1ZwEAu9opvQ
	(envelope-from <netdev+bounces-305054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:04:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D02647125A5
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:04:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=R+S3EXN9;
	dkim=pass header.d=redhat.com header.s=google header.b=IjG0q4CK;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305054-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305054-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD35D3270C09
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1692BEC52;
	Mon,  6 Jul 2026 13:35:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6EA28D8D0
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:35:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344950; cv=none; b=YyezxPhqID3e15Uo6DiNI7a8wWYa64ERCc41qkVmpoaKngL+7uNvA/nGGgiaz1VWIVa21KJowdGD07OHPw4jofni0gp21nrpSzZmayi/H3ux8EYWfHz0RwV5dXVcIgulQ/9sJqIfAbENZKkOUlWRa3q11jDoASWSzDDp7tYVmH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344950; c=relaxed/simple;
	bh=eG2g92HpxADpaewQr6kuNzXlZQd2Ti0PWMpSl/JUR74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kvt609xA6TolZI8GoQICHGFPjvW2l4xMqob9E+kjEWDkhmRLchRCul4e1UlBuKyMmtDFMjp/iUjKd8YeflHbnushJtTfCUW7BMbLqHbt6EYzXeRZaWHlki8fQ9o4TXM2VaoKxDeNzcfslSsBWMBfkZrpAVVM7wgDEwwPtv9DRUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R+S3EXN9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjG0q4CK; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783344948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3Anvk5g2W6Ax5Xx12MjDPwqLCiF744jyWfZgTib1bI=;
	b=R+S3EXN9qYrv10/oS9VWMY1WXF2H/ap2I22kceHus7NIKDfVCTIta1EKYXFLCwdqg4tODU
	4DRC/QODf/zTPVYgDwd4QFw+VGLMDligj7behBb7z50nMDjPfY1nqAT/Ug/Cm8P6D0IcrE
	k9ifCDWsRTcEN+j+UisoVi3WP0G0RV0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-yz55puyTPpeOPE2EVQ5gTw-1; Mon, 06 Jul 2026 09:35:44 -0400
X-MC-Unique: yz55puyTPpeOPE2EVQ5gTw-1
X-Mimecast-MFC-AGG-ID: yz55puyTPpeOPE2EVQ5gTw_1783344943
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493b0fe95b6so17060075e9.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783344943; x=1783949743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N3Anvk5g2W6Ax5Xx12MjDPwqLCiF744jyWfZgTib1bI=;
        b=IjG0q4CKDj3qDuprZ0mYTPoN+ct+9sM3qKcK/J05gYszA82WP8wnfKchxl6dOoc6Ut
         s3enpdOI2sUi1+OwLNfipcNqrQF/RslgK5Mz7vG6WZwWGp8bRScTUm59Z7pM6t/jBuq3
         cvd4DfEcT4Tf3pXsUy8RBan81eNgH7EPiUpvP2iRlqi/zw7ZmSGTxLMFD0L/SqGMETZT
         E+ZqCpDtPqY8V04BHoa0qXDC99p+AxerMVm7vo1l94cix85shuwmEBv2DVzUrwV45XZ6
         ljIrYVYNor5Kh22JPY+NSBfp5JQ6n4e1mKndSHB/exCr6NnFJub6jU7qop9oHeW7cw+U
         BFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783344943; x=1783949743;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N3Anvk5g2W6Ax5Xx12MjDPwqLCiF744jyWfZgTib1bI=;
        b=C7TSDIEGiXzee5Nm7k+dU1ku7wqZpWuAAiBqH3rXr/s3aGjvMK15Z8osU2xWzRsJDA
         WIAC5CjgH5kyk0ogexsJJxTT+YqXPBU1O4XQMkdTgkTa6lI/kCRLUFx+2EcUXuvpLZHo
         n6+u3lNX/o2X4evrUfHuv06udeePEEe+BzG+kX8OYYeqcH4spF3hYWLeGzxW3Be2k1G7
         yj0TPxABXPD+5mRVUhgB9hnx+dzk+nsGOuLxp1sjVGowejGFGeGUvvOCW9bbKgR3LT4e
         qznZz3BryLnaCRwF75R0LMe/jsx+5n2bh+jRI67vp9hDseZ22E9EAe5Q5CJhJNllnVVk
         riZA==
X-Forwarded-Encrypted: i=1; AHgh+Rq9Qy6RTEoCf+ZE/oINxHV9fsgXynI6MAHgSaWYL3fITTgmbE65OdpawXFHtX+zhygowy3pbYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNTNSRnmh7k7GOeaWs+g3PcGg8YRJ4+RLrM0N+KKRaYNsh/aq/
	yoUFwS9k0TcZS4jmdGeK2QTlIshOgtqFhdGpFhft5rlPCRI1cmVPkATgHMft1sw5wWN4yaIcxDp
	7CKknkRtAJcmUsxI8nfhsK1tiV/37g4cLMEbLaLQrlTPvvthCX4r8Fwn7lA==
X-Gm-Gg: AfdE7cn7b0RxZ4SIo36k4B95lcsYFMlmb9x9NkqWivBeiidbPDs7bLe4CW6tbg3Y1cE
	ynTooy0RCwSWKtuoKKNnQMfOV0G5QVLZUHYZFbMtefP+iuQKMBAuQHkBc/zwRuJI/bBCTNUtlAb
	7kpX8z0o4Xw+hWNm+ev/UqHUF0hnYmhGkPM0ONAn+oeYm8PQ/JE6fLwrlwrp5zqBFDpFEW7FvNs
	KT+1TQ8QQQVbzXJfA93iUairKQWNrbXLw2wzk+nAWXJyL/kiagzyFcVbF5/ULvYNEcXMY/NxUwd
	QsXJi3H/YAlXLpxAXxefVvARaYxvq0dY/PSOcrEkpqJesrN7NfCM6oNC8X4LbeS7E+jT2dF1OBs
	+Uvm/bcHVTXG9q/23sqDBx1VFKoHvi2lHKRCeQfcWlg0PuBc9Rc+6LeJQsbjlJ7xC9u/LDFUu8N
	55b1zwiHafTK9a
X-Received: by 2002:a05:600c:4f87:b0:490:be14:bfda with SMTP id 5b1f17b1804b1-493df17fcb9mr3435285e9.6.1783344943170;
        Mon, 06 Jul 2026 06:35:43 -0700 (PDT)
X-Received: by 2002:a05:600c:4f87:b0:490:be14:bfda with SMTP id 5b1f17b1804b1-493df17fcb9mr3434775e9.6.1783344942712;
        Mon, 06 Jul 2026 06:35:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce11497sm308056635e9.12.2026.07.06.06.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 06:35:42 -0700 (PDT)
Message-ID: <41d0e6d6-f1fc-425e-a122-b0433a925a3d@redhat.com>
Date: Mon, 6 Jul 2026 15:35:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 6/6] riscv: dts: eswin:
 eic7700-hifive-premier-p550: enable Ethernet controller
To: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>,
 Andrew Lunn <andrew@lunn.ch>
Cc: sashiko-reviews@lists.linux.dev, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org, Min Lin <linmin@eswincomputing.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260630063123.1118-1-lizhi2@eswincomputing.com>
 <20260630063445.1226-1-lizhi2@eswincomputing.com>
 <20260701063512.9ED051F000E9@smtp.kernel.org>
 <5de09a24.a11e.19f2207d7d2.Coremail.lizhi2@eswincomputing.com>
 <58532b95-bb74-4d87-acae-e67b41dd7d57@lunn.ch>
 <f21ffca.a15e.19f25abaea6.Coremail.lizhi2@eswincomputing.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <f21ffca.a15e.19f25abaea6.Coremail.lizhi2@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305054-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lizhi2@eswincomputing.com,m:andrew@lunn.ch,m:sashiko-reviews@lists.linux.dev,m:conor+dt@kernel.org,m:robh@kernel.org,m:devicetree@vger.kernel.org,m:linmin@eswincomputing.com,m:netdev@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,vger.kernel.org:from_smtp,lunn.ch:email,eswincomputing.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D02647125A5

On 7/3/26 3:50 AM, 李志 wrote:
>> -----Original Messages-----
>> From: "Andrew Lunn" <andrew@lunn.ch>
>> Send time:Thursday, 02/07/2026 21:22:34
>> To: 李志 <lizhi2@eswincomputing.com>
>> Cc: sashiko-reviews@lists.linux.dev, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, "Min Lin" <linmin@eswincomputing.com>
>> Subject: Re: Re: [PATCH net-next v9 6/6] riscv: dts: eswin: eic7700-hifive-premier-p550: enable Ethernet controller
>>
>>> Hi Andrew,
>>>
>>> One question before I prepare the next revision.
>>>
>>> As discussed previously, the DTS patch was included only to provide the overall
>>> Ethernet design context during the review of the binding and driver patches:
>>>
>>> https://lore.kernel.org/lkml/64bf6b40-b947-4ffa-8d48-4d6341931327@lunn.ch/
>>>
>>> For the next revision, would it be acceptable to drop the DTS patch from this
>>> series and post only the binding and driver patches? The complete DTS
>>> enablement is planned to be submitted later as a separate series after the
>>> binding and driver have been merged.
>>
>> What normally happens is that I give an Acked-by: or a Reviewed-by:
>> for the DT patch, and you submit it for merging via the DT Maintainer.
>> Everything then meets up in linux-next.
>>
>> Why do you need to do this later? Why not now?
>>
> 
> There is an another seperate DT patch series
> [https://lore.kernel.org/all/20260615122016.1110206-1-pinkesh.vaghela@einfochips.com/]
> which is under review.
> It also introduces DT nodes for reset, clock, pinctrl, HSP power domain.
> 
> Therefore, our planned steps are as follows:
> 1. In the next net-next v10​ patch series, drop the DTS patches, and submit only
>    the bindings and driver.
> 2. Wait for Pinkesh’s DT patch series​ to be merged.
> 3. Once the HSPCRG patch series​
>    [https://lore.kernel.org/all/20260605060730.1605-1-dongxuyang@eswincomputing.com/]
>    is merged, submit a new DT patch series​ to extend ESWIN EIC7700 SoC support​
>    for all HSP modules—including USB, eMMC, SD, and Ethernet, since they are all
>    under the HSP bus node eventhough ethernet doese not depend on HSPCRG patch.

In v10 please include some actual description of the series, beyond the
changelog.

Thanks,

Paolo


