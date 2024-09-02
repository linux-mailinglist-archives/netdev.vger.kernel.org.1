Return-Path: <netdev+bounces-124205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA64096883C
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 15:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06D91C224CE
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 13:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243C5187355;
	Mon,  2 Sep 2024 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMiT5aen"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1E92D057
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282057; cv=none; b=L+opH2A4ulLpDEfWsGU4fdSPq9mMvLyFvmEHrnkmiMauUSbmwMC6JLsBF2J/0N7hcLZgaIJll52G1I8M7Gj/1KPhO+HNALmhMNqwtgnpWwljQDv90Jgp5wdV+1hKj8o58mYb5U7MgUfs7T+d8ZvhkarjAbLXiK5d3t23kzFN/bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282057; c=relaxed/simple;
	bh=uXEQ6BxtJfFYS9cmShOFHvqvBEK26Ggapmvll28AZIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRw94dbWkXnHD+JBOMMg7SpnSYnQNPWHRJwphPcCMRhzJ2DJ5Za31MOu2CACLo1x12OJKVgcEgCHfMrx5jtmZ2iQ6/YLK8FUNc2oeOTl5gAfbasn4ln3jFMWoqdfCSAtnpS2OgpR+GKk6G5UaOuzXbwHeIg9LPlB3JWnGAVyDbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GMiT5aen; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725282054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w4UjvHRX8Oj9LnIjMNRuX4yJ+xeGtxIsSsEqvGhv+ro=;
	b=GMiT5aen37jkaCY1sw62sZHP0fIiPzrkxaN8g2OCF8mQfVXzsJ6JSe4q2ofeo2enrl8AOl
	+u6mawodxcOknRL3YfWxWyyIbsymL1DfmubDaKFJcd4BkedS+xVJYd8uN3ea3MwQ1+3Y31
	ss/eHMGSMrsZdfv8wQUmczqP+kRDqvQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-SDN1o8NtPTKGADni9om6Ug-1; Mon, 02 Sep 2024 09:00:51 -0400
X-MC-Unique: SDN1o8NtPTKGADni9om6Ug-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a86824d2d12so375317866b.2
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 06:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725282050; x=1725886850;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w4UjvHRX8Oj9LnIjMNRuX4yJ+xeGtxIsSsEqvGhv+ro=;
        b=Eyo+C0WE5iRsvSIYYe6m1AequFIvOk+ZUKv4pNgeQ7xzI5JcPDE7AomV+iIsQRyWcS
         JCswPgLTeX+CJE9A4PvCtwotlxGQesjsp3VZjXjMmRfFQZ5N0MsmRH18hdeyK45ziWDW
         SySSWVzjfIF5qtugdMMDD167ir5t94GJS3TsvLqcu1gJvKI/BinDe1iUH7OxfpxyzJLn
         2GtFN+NVtwQQ9MMs30K5OdWramd9X58mH8ILKCn12tNG0H3xzQFtcP0qS1Q2W58Js13V
         OrDP0GSGiCv0VRzwWx/0dQ9XvM1rSEacjRlVekSDeyP0vwmJOlTS5AiGwOj9Ry9LUtno
         DDUQ==
X-Gm-Message-State: AOJu0YyZP+QOvcNTFCzhJJaOea+KvUKPdVhChh3rn/qVEzn82hApY0vc
	70zl9I27dpfjGuk9xrp/DZTY0gwo/YSys78r98Y9vk/xAYawsn7dNxrGMFxSHloyVsTXaZGryX7
	/BvIj8OIouri9l5JJC9VwZuKQ1jfZSJ5FqNlxD7/hbBnuXle98aC9kw==
X-Received: by 2002:a17:906:fe4b:b0:a79:82c1:a5b2 with SMTP id a640c23a62f3a-a89b93db796mr520934066b.9.1725282050506;
        Mon, 02 Sep 2024 06:00:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV3/o7Jt5WWnvqUynDWlp723LhO4YRZNw/QT+Vx1+d+P4KGzj5Soa66/PUkMxaEKejnjlOOA==
X-Received: by 2002:a17:906:fe4b:b0:a79:82c1:a5b2 with SMTP id a640c23a62f3a-a89b93db796mr520931466b.9.1725282050020;
        Mon, 02 Sep 2024 06:00:50 -0700 (PDT)
Received: from [192.168.88.248] (146-241-5-217.dyn.eolo.it. [146.241.5.217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900f6c4sm558071766b.68.2024.09.02.06.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 06:00:49 -0700 (PDT)
Message-ID: <7a7bffdf-b461-49a3-b410-c58d12762550@redhat.com>
Date: Mon, 2 Sep 2024 15:00:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 02/12] net-shapers: implement NL get operation
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Donald Hunter
 <donald.hunter@gmail.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com
References: <cover.1724944116.git.pabeni@redhat.com>
 <53077d35a1183d5c1110076a07d73940bb2a55f3.1724944117.git.pabeni@redhat.com>
 <20240829182019.105962f6@kernel.org>
 <57ef8eb8-9534-4061-ba6c-4dadaf790c45@redhat.com>
 <20240830113900.4c5c9b2a@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240830113900.4c5c9b2a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/30/24 20:39, Jakub Kicinski wrote:
> On Fri, 30 Aug 2024 12:55:05 +0200 Paolo Abeni wrote:
>> #define NETLINK_CTX_SIZE 48
>>
>> and use such define above and in linux/netlink.h
> 
> Aha, would be good to also have a checking macro. Maybe rename
> 
> NL_ASSERT_DUMP_CTX_FITS()
> 
> to apply more broadly? or add a new one? Weak preference for former.

I will rename it to NL_ASSERT_CTX_FITS(), in the same patch.

/P


