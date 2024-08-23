Return-Path: <netdev+bounces-121270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B2495C6FA
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 09:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F111C21A37
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 07:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4662613C80A;
	Fri, 23 Aug 2024 07:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGW9XCEg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AC513C683
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 07:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724399513; cv=none; b=DT0pt+ewbNgqD64q3/jDqDS1EW0ziwi8BCIoyWHxxyCrmESK0Xu1IpllUTD4Rky73wwFAsT1k7p0ptYSehuPR3S1E9GUPEdlmUxBkzShEgZUt+4uw5ist76dFo7xh/dmzkNiMSedRAd5J+K5DTSPo4nCpfywIikybYccPlH2CnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724399513; c=relaxed/simple;
	bh=ybdKZPTJRqcPNiZ+Vjk3TFoIAwAdu57wucJRZemxiJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njolty8hclpKj0f1tw5rPYWXjy60YUkFAfx5obnCWzqB5Jycmz6p04abdFSsXhMna81j6XYCq7PZHH3Y8R9g0k4VnU/IjllUSja+xNH/rNB6758lxbQgWXK2ctrCZENar5HpCVH8QErXbCEwSQDjP1K5+lE6rVhM5coclfkInPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LGW9XCEg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724399510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TKJJtlIrGh+YEwQ9X1LKeIN3uP32Y3XCMgwtwpbB+u4=;
	b=LGW9XCEgzfjQ0VZerWqvRrhxH8P4BpMgXfopgtSk6K4ZnkB99pJ1o8bLj4bjtdGBHVQErx
	yZvcp0gz2keNJdKPpQ84LHBfXPOM67+wnZXKSM3edPoTQEWoebCtHrE0VaEArFctCMgwRt
	acrwpYZASPrth8wVZRQBVYtM9M5DwVk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-nBO6b-g3PUqhfBtD9AHBOw-1; Fri, 23 Aug 2024 03:51:28 -0400
X-MC-Unique: nBO6b-g3PUqhfBtD9AHBOw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-429097df54bso14504455e9.1
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 00:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724399487; x=1725004287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKJJtlIrGh+YEwQ9X1LKeIN3uP32Y3XCMgwtwpbB+u4=;
        b=EVe34Q72kRr/oDEEpbO2dQVfE3nZ89s97xNdlACTdNiBV8GbAwVoMFsIztvRMUZ4qb
         eiID/dt8hy4H4WsgfPNase5vJixHspILEixSbcj3CfygeIiAy8ffeWZ+wrAovTTJ70XI
         W9hSvH99E2STYE0T2kMtmDIpaMrdhd9g6Fn4puNTbJCXgGogirHNrHbNTRuTF7E/3krV
         20YUcOZ3hfBI5xDwDyS/ziT1uz9hz0a1z6TUOayQdBPNwnDQxsAj9t2A8ECDa6ZlMboS
         muWgjA2okW4XtgSVKvcXRs4jDTol8bzJDrxtFe2vVNHL+ZV6XQtGBSTI5Yk8kerM6Si6
         9ELw==
X-Gm-Message-State: AOJu0YxNdFO12nL7qUmPNQQaCPYSa3JxjOYuhpF54HTmBE9OXNyggUHc
	UATs/7uxUq/KVYX9LO5WvilhWE5xaYkXhjFsBCTjV0Lecbgj6ewwqhcPIHpQdcgE9SZO5217DEj
	WHn3EUA99K6kkHysEHPMnKDj48s+EsGwvMlOcHqD2GSKYqKGPvSVFXA==
X-Received: by 2002:adf:cb8b:0:b0:371:8dbf:8c1b with SMTP id ffacd0b85a97d-3731187d080mr773331f8f.34.1724399487286;
        Fri, 23 Aug 2024 00:51:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1wBpS9EO77gniJ2PMeuOYMzskSMpFwFHpblthq4NTNIaNJREK6x3eZEIQAvo77AQr1dwHiA==
X-Received: by 2002:adf:cb8b:0:b0:371:8dbf:8c1b with SMTP id ffacd0b85a97d-3731187d080mr773313f8f.34.1724399486756;
        Fri, 23 Aug 2024 00:51:26 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b51:3b10::f71? ([2a0d:3344:1b51:3b10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730826b10bsm3499994f8f.114.2024.08.23.00.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 00:51:26 -0700 (PDT)
Message-ID: <d9cfa04f-24dd-4064-80bf-cada8bdcf9cb@redhat.com>
Date: Fri, 23 Aug 2024 09:51:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 00/12] net: introduce TX H/W shaping API
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>
References: <cover.1724165948.git.pabeni@redhat.com>
 <20240822174319.70dac4ff@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240822174319.70dac4ff@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/23/24 02:43, Jakub Kicinski wrote:
> On Tue, 20 Aug 2024 17:12:21 +0200 Paolo Abeni wrote:
>> * Delegation
>>
>> A containers wants to limit the aggregate B/W bandwidth of 2 of the 3
>> queues it owns - the starting configuration is the one from the
>> previous point:
>>
>> SPEC=Documentation/netlink/specs/net_shaper.yaml
>> ./tools/net/ynl/cli.py --spec $SPEC \
>> 	--do group --json '{"ifindex":'$IFINDEX',
>> 			"leaves": [
>> 			  {"handle": {"scope": "queue", "id":'$QID1' },
>> 			   "weight": '$W1'},
>> 			  {"handle": {"scope": "queue", "id":'$QID2' },
>> 			   "weight": '$W2'}],
>> 			"root": { "handle": {"scope": "node"},
>> 				  "parent": {"scope": "node", "id": 0},
> 
> In the delegation use case I was hoping "parent" would be automatic.

Currently the parent is automatic/implicit when creating a node directly 
nested to the the netdev shaper.

I now see we can use as default parent the current leaves' parent, when 
that is the same for all the to-be-grouped leaves.

Actually, if we restrict the group operation to operate only on set of 
leaves respecting the above, I *guess* we will not lose generality and 
we could simplify a bit the spec. WDYT?

Thanks,

Paolo


