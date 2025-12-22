Return-Path: <netdev+bounces-245775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1833BCD7617
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 23:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 938B030625BD
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 22:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A568430C608;
	Mon, 22 Dec 2025 22:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAry3Sag"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED94730FC05
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766443352; cv=none; b=FH085Pl86nwvww0wUy1xzUuXgtVw2HbdYHLjkDab9VBZ4iI8VNhqkChdNosDx31QsF9zDU2HvuOIzlZK8DsUnDVVHIkNMBkXnqmm8H7Q5EDaJFSkj8MtBnED9heJYCiUsB15KfyL4GDOo5eUmB2AeCtTPpVgjvclb7XYGsaq/I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766443352; c=relaxed/simple;
	bh=nbvAp9lGgmeAHI82ou9Vpof0xEI/gJTFJ/RcmIgs90M=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=S9CrqytFjp1JudTn/HCwvDkJGcBWwVlDfxZ7PATqrD3v2VRch1NXBw4xBBOUlGLQ7eviGiYQGJYCRAV+aHbu4dzsgxFOuFw3fkXrteegDXKoFxKM2G6nhlNwignXCPG2oDISqFNDsXs5xuNDIuJ+iMUc035/m5W/zmQfOxwgibA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAry3Sag; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766443350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Nf8Y09hX+6ivSEyGT21ZNlAYEnQHEoRA/5t14BpHSg=;
	b=JAry3SagyoOVvsnTl596xylzozAXIfSv14JTXVGBsPekOr/j0s07a34lBMn6UrnhX1AxcQ
	26BLIov4JPN/ZW76VUYJwc8qzly5oTXqmL0BrSVX0iiX6LMXv7q9NFVeZ2UYEwyCgosC0h
	BFSri4UTIFsmBvuxpmIVdDfupWA2UoU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-KbwvaoBrNy6oUzT24nfA5g-1; Mon,
 22 Dec 2025 17:42:26 -0500
X-MC-Unique: KbwvaoBrNy6oUzT24nfA5g-1
X-Mimecast-MFC-AGG-ID: KbwvaoBrNy6oUzT24nfA5g_1766443345
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1A6418002DE;
	Mon, 22 Dec 2025 22:42:25 +0000 (UTC)
Received: from localhost (unknown [10.64.240.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 48DD8180049F;
	Mon, 22 Dec 2025 22:42:23 +0000 (UTC)
Date: Tue, 23 Dec 2025 07:42:22 +0900 (JST)
Message-Id: <20251223.074222.1040526801542772515.yamato@redhat.com>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 1/2] man: explain the naming convention of
 files under .d dir
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <20251222103209.0f9e03bd@phoenix.local>
References: <20251217154354.2410098-1-yamato@redhat.com>
	<20251222103209.0f9e03bd@phoenix.local>
Organization: Red Hat Japan, K.K.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH iproute2 1/2] man: explain the naming convention of files under .d dir
Date: Mon, 22 Dec 2025 10:32:09 -0800

> On Thu, 18 Dec 2025 00:43:53 +0900
> Masatake YAMATO <yamato@redhat.com> wrote:
> 
>> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
>> ---
>>  man/man8/ip-address.8.in | 7 +++++++
>>  man/man8/ip-link.8.in    | 7 +++++--
>>  2 files changed, 12 insertions(+), 2 deletions(-)
>> 
>> diff --git a/man/man8/ip-address.8.in b/man/man8/ip-address.8.in
>> index 79942c1a..e88a114f 100644
>> --- a/man/man8/ip-address.8.in
>> +++ b/man/man8/ip-address.8.in
>> @@ -331,6 +331,13 @@ values have a fixed interpretation. Namely:
>>  The rest of the values are not reserved and the administrator is free
>>  to assign (or not to assign) protocol tags.
>>  
>> +When scanning
>> +.BR rt_addrprotos.d
>> +directory, only files ending
>> +.BR .conf
>> +are considered.
>> +Files beginning with a dot are ignored.
>> +
>>  .SS ip address delete - delete protocol address
>>  .B Arguments:
>>  coincide with the arguments of
>> diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
>> index ef45fe08..67f9e2f0 100644
>> --- a/man/man8/ip-link.8.in
>> +++ b/man/man8/ip-link.8.in
>> @@ -2315,8 +2315,11 @@ down on the switch port.
>>  .BR "protodown_reason PREASON on " or " off"
>>  set
>>  .B PROTODOWN
>> -reasons on the device. protodown reason bit names can be enumerated under
>> -/etc/iproute2/protodown_reasons.d/. possible reasons bits 0-31
>> +reasons on the device. protodown reason bit names can be enumerated in the
>> +.BR *.conf
>> +files under
>> +.BR @SYSCONF_USR_DIR@/protodown_reasons.d " or " @SYSCONF_ETC_DIR@/protodown_reasons.d "."
>> +possible reasons bits 0-31
>>  
>>  .TP
>>  .BR "dynamic on " or " dynamic off"
> 
> 
> The man page is slightly redundant here. Already have a README file in the
> directory.
> 

I didn't know the README files. I would like to withdraw the proposal of
this change.

Masatake YAMATO


