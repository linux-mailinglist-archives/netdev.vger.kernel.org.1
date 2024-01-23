Return-Path: <netdev+bounces-64928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D31837E52
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 02:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7CA1F26AAF
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 01:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CAC56775;
	Tue, 23 Jan 2024 00:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK6sjKdz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1642C3984D
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 00:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970521; cv=none; b=iYSex/lET7Vm74b4PGo5RWr1Is1EMkFoh6T3vUu4uV5ayX1ZitIdQ7hE9XuIY5iGMlsyvDmaw0jrMhkPFubUuXFdiFqEpSW/Zo0EwIhBKqPgMQjRsJpaf69Hre+ltmcjNitKoZouBKn1OKiAie3zdOqcySnQCctBKKTWdRLldqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970521; c=relaxed/simple;
	bh=bBLScMOQcBvVNOy/zJDQHVZUw/QdrcCI7ya/rWvm2Kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGvTHQh6cdf8i4xnDkiyzNuY2Rfv5s/1/HlcOf2ZtLIIfCDGFVV7o+TCa9M20Re9MHgja9N5hpLiT+6x6MDr6GCnz3c2/53bye0vovqCjD1oBBkMf5DcWROE5beSwexvBd7F4YP4JS3RZNcdbxHpPiEUdWzFBTSP8XBuFOHOAZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QK6sjKdz; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3619e804f3aso13270975ab.2
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 16:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705970519; x=1706575319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9msZ1BDws4gmxhQ29cGonhe7XlKkP+NlpnlynOK523s=;
        b=QK6sjKdztlzuYzSLU7/8nr2aKTqLF3/wXCsWg6INLObJhH6Faoqyk1b0N1X+fe1280
         m4ftC7ZjAKc2DweCy3aYhCU5FXygwe6ltM1RJlO8s00KExx5QvUG34gASQB4NuFAb2+j
         FS3S9fWRN4I9fTKQZY/s4JaVs8vsT9KtT0RxK2ar6kTF1yQ0JUynrVqUqrYYjkDbDXzC
         Q6PcfLvUs2nM58l4WiQcWLdIgLRpY8UMgwWNk6DPA4pabY/iLWkPKI9g0vG/bFqkJAiF
         /16fsMMXuccYuknr2n+ZwlbeG9m77BNaN4Q9jB6eJ0HlyKkq7ZLe2zIhM2Pq8ma25YI/
         vplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970519; x=1706575319;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9msZ1BDws4gmxhQ29cGonhe7XlKkP+NlpnlynOK523s=;
        b=HpvNb+o3XPiS1/jHNyHWhFniV3BlsQQ0MbBH0T8DVJjxnqSQ+yAn6el0lFy8T9bxAo
         m2X4HKd4PQmwMPdgeCHcRsXI6DgKZ3eJUpTUECRUQnHOSPAt9Kxpdyd9OW0EnHXdK5Qv
         yXoxRlAHMSs+4YlI5OuadugYV60haggFo7rWVJGF/BrF9hdQDz7+WAvOcVGA8ZrvIg3k
         kBubFmA4auJTkWwLGkJeOogL+5Ln7oxsMGGlqW82kfsCL9oaa9NK3TDB7lbBef07jZuR
         ZgQnGhR2DZGF8tDIGKJfF5Cwhlf3c6W1G9XXoyB240KD9J1q6yJw5xyhvcohRgcveyWC
         eBsQ==
X-Gm-Message-State: AOJu0Ywjc4Aq5PeCsfuZoQtyp4SJW5CM+jFOWFB5gWGD7Y/Wv5CMCk6z
	z4opKThMb9HE2HRG87+kBlN7Nanw1UDDDBdIudhLuT96WMFEBobbWckoFBK5
X-Google-Smtp-Source: AGHT+IG4uS9u21Y1QMq6cjqeCpviQHzow+mcR9/+4u//+4H0HTrc5iy4gYcV1ODHx0Rdn/xcf8FNIQ==
X-Received: by 2002:a05:6e02:1a8d:b0:360:fe84:1ee9 with SMTP id k13-20020a056e021a8d00b00360fe841ee9mr4589926ilv.120.1705970519042;
        Mon, 22 Jan 2024 16:41:59 -0800 (PST)
Received: from ?IPV6:2601:282:1e82:2350:3c2c:1afc:52ff:38e7? ([2601:282:1e82:2350:3c2c:1afc:52ff:38e7])
        by smtp.googlemail.com with ESMTPSA id y18-20020a056e020f5200b00361a70e112asm3025925ilj.59.2024.01.22.16.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 16:41:58 -0800 (PST)
Message-ID: <f24380fc-a346-4c81-ae78-e0828d40836e@gmail.com>
Date: Mon, 22 Jan 2024 17:41:57 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] vxlan: add support for flowlab inherit
Content-Language: en-US
To: Ido Schimmel <idosch@idosch.org>, Alce Lafranque <alce@lafranque.net>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org,
 Vincent Bernat <vincent@bernat.ch>
References: <20240120124418.26117-1-alce@lafranque.net>
 <Za5eizfgzl5mwt50@shredder>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <Za5eizfgzl5mwt50@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/22/24 5:24 AM, Ido Schimmel wrote:
> s/flowlab/flowlabel/ in subject
> 
> My understanding is that new features should be targeted at
> iproute2-next. See the README.
> 
> On Sat, Jan 20, 2024 at 06:44:18AM -0600, Alce Lafranque wrote:
>> @@ -214,10 +214,16 @@ static int vxlan_parse_opt(struct link_util *lu, int argc, char **argv,
>>  			NEXT_ARG();
>>  			check_duparg(&attrs, IFLA_VXLAN_LABEL, "flowlabel",
>>  				     *argv);
>> -			if (get_u32(&uval, *argv, 0) ||
>> -			    (uval & ~LABEL_MAX_MASK))
>> -				invarg("invalid flowlabel", *argv);
>> -			addattr32(n, 1024, IFLA_VXLAN_LABEL, htonl(uval));
>> +			if (strcmp(*argv, "inherit") == 0) {
>> +				addattr32(n, 1024, IFLA_VXLAN_LABEL_POLICY, VXLAN_LABEL_INHERIT);
>> +			} else {
>> +				if (get_u32(&uval, *argv, 0) ||
>> +				    (uval & ~LABEL_MAX_MASK))
>> +					invarg("invalid flowlabel", *argv);
>> +				addattr32(n, 1024, IFLA_VXLAN_LABEL_POLICY, VXLAN_LABEL_FIXED);
> 
> I think I mentioned this during the review of the kernel patch, but the
> current approach relies on old kernels ignoring the
> 'IFLA_VXLAN_LABEL_POLICY' attribute which is not nice. 

Common theme with vxlan attributes :-(


> My personal
> preference would be to add a new keyword for the new attribute:
> 
> # ip link set dev vx0 type vxlan flowlabel_policy inherit
> # ip link set dev vx0 type vxlan flowlabel_policy fixed flowlabel 10
> 
> But let's see what David thinks.
> 


A new keyword for the new attribute seems like the most robust.

That said, inherit is already used in several ip commands for dscp, ttl
and flowlabel for example; I do not see a separate keyword - e.g.,
ip6tunnel.c.

