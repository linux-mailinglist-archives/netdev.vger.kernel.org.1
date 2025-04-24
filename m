Return-Path: <netdev+bounces-185660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8A0A9B40D
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2BCF1BC108E
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7362281356;
	Thu, 24 Apr 2025 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETqUyE8I"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAA1280A4C
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512158; cv=none; b=fEtlo3XWE0gUK5eBPbKgZAo6IhDv1j3kLYTz8Y3hvX02pwXCkB+b0jmhikkuKh5imdw7T+ZzN4F9dHhZuOhaFtlm0HmEzC+f7zHVRGHotyNtw8Dvqgd44ACR7T2VxtWVQvw2tTqauFSs8NxR+28go8i5pjiWe6qFblHjgWlRLrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512158; c=relaxed/simple;
	bh=VuvWR/xR3+1XIIsqP3Mnd1zii5PRZEy6rSHMV+8vxQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ftEgtq0f36AKeOC8YqgB6OhYUiEWhTFnMvA1+8ObGWCdgicE+mkW+X48JNwOGJB8IAcSQPEBYQhEai2AJgoJ0kpiwHDJ3R/7FLmLF9lnfG6WYH7O91b6f9ynBBlG1N69PZP8aksJjCdjkVZMQMDvGsstYdQ/og1WDCJflBzmHFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ETqUyE8I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745512154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2uVAEopdtpgVlguQ5ktM175hscYiDLv9M0FIM/OwWmE=;
	b=ETqUyE8IRXWTFiZ1iz/j0CKkYPd5y/fqhDZMOoUCMzk2gzgny66RA0LngT1xolyZW0jpgD
	d53dgjxAsmSIuibmmUpSXIfStHylh8b4rbM0WFhlMvMncidTOYFJwbiZh/4zQ0DftCKKW5
	mVO9NUY+wWGUfQ9OAVSNpFqo76EAFzE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-ujNod1RPMM606MOUQpAlhQ-1; Thu,
 24 Apr 2025 12:29:13 -0400
X-MC-Unique: ujNod1RPMM606MOUQpAlhQ-1
X-Mimecast-MFC-AGG-ID: ujNod1RPMM606MOUQpAlhQ_1745512151
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5310F1955D86;
	Thu, 24 Apr 2025 16:29:10 +0000 (UTC)
Received: from [10.44.32.28] (unknown [10.44.32.28])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9F59919560A3;
	Thu, 24 Apr 2025 16:29:05 +0000 (UTC)
Message-ID: <5d035e9b-b36a-4088-89fb-b0f35d98a909@redhat.com>
Date: Thu, 24 Apr 2025 18:29:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/8] Add Microchip ZL3073x support (part 1)
To: Lee Jones <lee@kernel.org>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250424154722.534284-1-ivecera@redhat.com>
 <20250424155106.GI8734@google.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250424155106.GI8734@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 24. 04. 25 5:51 odp., Lee Jones wrote:
> On Thu, 24 Apr 2025, Ivan Vecera wrote:
> 
>> Add support for Microchip Azurite DPLL/PTP/SyncE chip family that
>> provides DPLL and PTP functionality. This series bring first part
>> that adds the common MFD driver that provides an access to the bus
>> that can be either I2C or SPI.
>>
>> The next part of the series is bringing the DPLL driver that will
>> covers DPLL functionality. Another series will bring PTP driver and
>> flashing capability via devlink in the MFD driver will follow soon.
>>
>> Testing was done by myself and by Prathosh Satish on Microchip EDS2
>> development board with ZL30732 DPLL chip connected over I2C bus.
>>
>> Patch breakdown
>> ===============
>> Patch 1 - Common DT schema for DPLL device and pin
>> Patch 2 - DT bindings for microchip,zl3073* devices
>> Patch 3 - Basic support for I2C, SPI and regmap configuration
>> Patch 4 - Devlink device registration and info
>> Patch 5 - Helpers for reading and writing register mailboxes
> 
> Whoops!  I just this second replied to v3.
> 
> This needs moving out to somewhere more appropriate.
> 
> Use MFD to allocate and split the resources, then the sub-devices can do
> the technical and heavy API stuff.

They cannot because the bus is shared and MFD parent device acts as bus
arbitrator. It has to ensure that sub-devices access the registers
safely.

Mailbox could be confusing for somebody but it does not have anything
common with HW mailboxes. In this context the mailbox is just a sequence
of register reads and writes in certain order and this sequence has
to be done atomically (I tried to describe this in my previous replies).

I have followed Andrew's recommendation to hide these special sequences
and provide sub-devices some simple API to use them without special
locking needs.

Thanks,
Ivan


