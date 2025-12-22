Return-Path: <netdev+bounces-245670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD448CD4A58
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 04:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C4C83004B81
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 03:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC20324B24;
	Mon, 22 Dec 2025 03:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgDBP7A6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CC517A2EA
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 03:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766375031; cv=none; b=gVbDLQYQNF0d/OWWVb1BrL0YOP1pPvxx9SB5jYnIaSQ/tWFnmN5SOxZAZsrzqozNKM/ip5JVug/VNwr5+c3PY4dOLphnkT6KirDitoGtgRg8GszcVS+S3cfWdWPdt0Hr82Am9JQZYdKTJ6r9T1r+x4RCSmjcV5SXsLHd6b8ptsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766375031; c=relaxed/simple;
	bh=PKAGzgb/Zd1Z/NoTNkPvPfJMdXdKkewUlJ4xrWrrGjA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fqLIh6OXfbZYcVEUErd8xSu7nSf+P3ex8/z2aDSjxovLD9EpyroKiC46DvLpXU6SIKMagYkLqQGi4GP2wvEbAITPlhX2RUYrsQqOZAr76UT4zkuGfud2f3b6UDfaHvUrOVTHvMUp5nBjWsnqONoEV2MZ5i85Nhdu/feiyv/zpjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LgDBP7A6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766375028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ta2wLVzBTHlVXInWiT5YUMxSAbDKFEkizxmHqpapJ4I=;
	b=LgDBP7A6mo/zXcmcwrKkGDvzSm6diaG1hRNitfFyb3l162rgmRlUXLHZGcLfrkW4C2g/4T
	xR4PX+ksOsZWCQJoURaF1RuTc3o7dqGikezGAaX4vJ/JcTaqUm7kgH676qJz8arDl5hfs2
	QwlWCHyseG6iNMiroWY0R2bgakp0SBc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-KVROk91JNYGP-Ul_ndNOpw-1; Sun,
 21 Dec 2025 22:43:44 -0500
X-MC-Unique: KVROk91JNYGP-Ul_ndNOpw-1
X-Mimecast-MFC-AGG-ID: KVROk91JNYGP-Ul_ndNOpw_1766375023
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5D661955F34;
	Mon, 22 Dec 2025 03:43:43 +0000 (UTC)
Received: from localhost (unknown [10.64.240.82])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5670B19560B2;
	Mon, 22 Dec 2025 03:43:41 +0000 (UTC)
Date: Mon, 22 Dec 2025 12:43:40 +0900 (JST)
Message-Id: <20251222.124340.998808926839564611.yamato@redhat.com>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 2/2] man: explain rt_tables.d and rt_protos.d
 directories
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <20251220173827.5bc4e2b2@phoenix.local>
References: <20251217154547.2410768-1-yamato@redhat.com>
	<20251220173827.5bc4e2b2@phoenix.local>
Organization: Red Hat Japan, K.K.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH iproute2 2/2] man: explain rt_tables.d and rt_protos.d directories
Date: Sat, 20 Dec 2025 17:38:27 -0800

> On Thu, 18 Dec 2025 00:45:47 +0900
> Masatake YAMATO <yamato@redhat.com> wrote:
> 
>> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
>> ---
>>  man/man8/ip-route.8.in | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>> 
>> diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
>> index aafa6d98..d30285a4 100644
>> --- a/man/man8/ip-route.8.in
>> +++ b/man/man8/ip-route.8.in
>> @@ -1474,6 +1474,20 @@ ip route add 10.1.1.0/30 nhid 10
>>  .RS 4
>>  Adds an ipv4 route using nexthop object with id 10.
>>  .RE
>> +
>> +.SH FILES
>> +.BR *.conf
>> +files under
>> +.BR @SYSCONF_USR_DIR@/rt_tables.d " or " @SYSCONF_ETC_DIR@/rt_tables.d
>> +are also read in addition to
>> +.BR @SYSCONF_USR_DIR@/rt_tables " or " @SYSCONF_ETC_DIR@/rt_tables "."
>> +
>> +.BR *.conf
>> +files under
>> +.BR @SYSCONF_USR_DIR@/rt_protos.d " or " @SYSCONF_ETC_DIR@/rt_protos.d
>> +are also read in addition to
>> +.BR @SYSCONF_USR_DIR@/rt_protos " or " @SYSCONF_ETC_DIR@/rt_protos "."
>> +
>>  .SH SEE ALSO
>>  .br
>>  .BR ip (8)
> 
> This results in the same paragraph twice??
> 
> FILES
>        *.conf     files      under      /usr/share/iproute2/rt_tables.d      or
>        /etc/iproute2/rt_tables.d    are    also    read    in    addition    to
>        /usr/share/iproute2/rt_tables or /etc/iproute2/rt_tables.
> 
>        *.conf     files      under      /usr/share/iproute2/rt_protos.d      or
>        /etc/iproute2/rt_protos.d    are    also    read    in    addition    to
>        /usr/share/iproute2/rt_protos or /etc/iproute2/rt_protos.
> 

They are similar, but a little different; please look at "rt_tables"
and "rt_protos".

Masatake YAMATO


