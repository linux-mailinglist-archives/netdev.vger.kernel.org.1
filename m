Return-Path: <netdev+bounces-112020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFAE934934
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 09:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D985A1F22285
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 07:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9BB6F312;
	Thu, 18 Jul 2024 07:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhsNkJ3e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307A77CF3E
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721288956; cv=none; b=dHYJ7O1keahqkL6MKmCxHaJPFSyZl6hqMB7WyngAEin0zAh6MvlkPJcSLc45Y/0hXiow07Bp5lNtdNSXgC0lDfIKpPG6o4hqMjgXajiIVxLWTqBk5H8FoQfeDgx/dt/jtPY/FgrrNALBs8dv74m/qRWWx8USWxBg4CMkH8gKLqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721288956; c=relaxed/simple;
	bh=RyArBk57Wg2qcvjzc6Ynbf4X1sU+TR9SeIgR5+gOiVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OO7X9BO3lxeH9qijB9/yKUwHVfhSHHmo91ATBpPseggTBTe0qG1m83YrEY7e5QGrVhmHeJu00eKZPYQK4M9llL+V0gGsKc8Z4mF5yXbY3QGvB4zYro433P0KZwdLX5IdEhkHcy82Wby7+jOSxoIBe8wOoYexoZLX4mS9Bcb4Aq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LhsNkJ3e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721288953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/jsSOpv/topEHxrEoKqtalPtg+NFFfMqa3rhWyHbwc=;
	b=LhsNkJ3eJm2QQciv5W2izbacNCOPqkizQ1KokjJkRlk1FiHvG84Y1yyuuMcVdHPTBh9uQe
	bi1MSI2JrjPEMR3oExHVfOr5TwhYURbB21If+L6fsGEkY50XotYBszw44JwiFkaRY+6aZ8
	HMB7f5Bnb4a958lmA0aUmEh1UTMq6Aw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-dMFfG0w8PdO0PcasE31s5g-1; Thu, 18 Jul 2024 03:49:11 -0400
X-MC-Unique: dMFfG0w8PdO0PcasE31s5g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3685b7bff66so52067f8f.3
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 00:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721288950; x=1721893750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/jsSOpv/topEHxrEoKqtalPtg+NFFfMqa3rhWyHbwc=;
        b=AZZ5vTY29SSrWj7WmQN4QT8KZ3IbluT3j/SHCX9SBKs9omUpESFDedU/hGP16ewSmi
         hoHkkAoqTCyIF1ZpXyKDZXyPleoPQq3UqJz7iY7PU8rbbfeSAlSZozAiA5p49nyuCzyS
         0nyDMcedUG41R8LWPoK+VD6YHGL9DoMOWULpozinx2JUMznvJ0soZFy5tYs4QGQXDgVJ
         i8E/EU2oGhavs9zP65lvT/WRcZ87vKpF4y32+YsDpUvm97mhLFJ37AxY5WFWf5VgxOxB
         8t5wAlgqPkDRPNNgucQxI8JASTeiC1bvhAAXqI8taEe97yr676Y598IYg+avSvlaDEct
         +3RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtcKfgmB4PWYs90NXvqqjlRxlA1jVQp1n7FAg959BjpJJvc13l5oXbxc9ozefShGmgFeBvOrGTTmknAChX/Gew24ggwerf
X-Gm-Message-State: AOJu0YzfiTJRbJsW7O/kWgMHIpfWMrFVRw1GKzhFyF46sNlCMFXHvmoB
	9cQOHm12uYx0iYIWzCLr0/fLFLd5AbIML+9BmAtTr/htL1IfyIrLWMAJyWdr0I9o1WeT1kOod2x
	pKzPrHnHiJA6YdiIK6xtZKk19WiYrNqNT2k1ULusyK3/fnk6WHfrD4A==
X-Received: by 2002:a5d:47ad:0:b0:35f:2929:8460 with SMTP id ffacd0b85a97d-368315faa3amr1829630f8f.3.1721288950277;
        Thu, 18 Jul 2024 00:49:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOwSqkFCBYl+vpRki2BkvTQtGbBhu58SwvtAjQh2OZiquk352S608BaeruDC7K5HwF2uKP1Q==
X-Received: by 2002:a5d:47ad:0:b0:35f:2929:8460 with SMTP id ffacd0b85a97d-368315faa3amr1829619f8f.3.1721288949787;
        Thu, 18 Jul 2024 00:49:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b08b:7710:c7b:f018:3ba3:eb24? ([2a0d:3341:b08b:7710:c7b:f018:3ba3:eb24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a3c159sm901945e9.8.2024.07.18.00.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 00:49:09 -0700 (PDT)
Message-ID: <4d496d91-a83c-4ec6-ba69-ae594a50e45c@redhat.com>
Date: Thu, 18 Jul 2024 09:49:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tipc: Return non-zero value from tipc_udp_addr2str()
 on error
To: Tung Nguyen <tung.q.nguyen@endava.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Shigeru Yoshida <syoshida@redhat.com>,
 "jmaloy@redhat.com" <jmaloy@redhat.com>,
 "ying.xue@windriver.com" <ying.xue@windriver.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "tipc-discussion@lists.sourceforge.net"
 <tipc-discussion@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <AS5PR06MB875264DC53F4C10ACA87D227DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
 <c87f411c-ad0e-4c14-b437-8191db438531@redhat.com>
 <AS5PR06MB8752EA2E98654061F6A24073DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
 <20240717.110353.1959442391771656779.syoshida@redhat.com>
 <AS5PR06MB8752F1B379BB6B90262C741CDBA32@AS5PR06MB8752.eurprd06.prod.outlook.com>
 <20240717083158.79ee4727@kernel.org>
 <AS5PR06MB8752E506B21D2922F7D08BE4DBAC2@AS5PR06MB8752.eurprd06.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <AS5PR06MB8752E506B21D2922F7D08BE4DBAC2@AS5PR06MB8752.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/24 03:30, Tung Nguyen wrote:
>>> Reviewed-by: Tung Nguyen <tung.q.nguyen@endava.com>
>>>
>>> The information in this email is confidential and may be legally privileged. ...
>>
>> What do you expect us to do with a review tag that has a two-paragraph legal license attached to it?
> Please ignore that disclaimer message. I am still asking help from my organization to remove that annoying message.

The unfortunate thing is that the message has legal implication which do 
not fit well with formal tags. If you can't trim the trailing message 
from your corporate account - I know it could be even very hard or 
impossible - please use a different account that you can control more 
easily for formal interaction on the ML.

Thanks,

Paolo


