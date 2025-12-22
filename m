Return-Path: <netdev+bounces-245695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 991CFCD5CF0
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 12:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67D8F3020C4D
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 11:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA309316901;
	Mon, 22 Dec 2025 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnJlwz0s";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZkMNMRiG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021551EB5E1
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766402988; cv=none; b=LhrvhwyzV3ZznLRyTcmqsGxG0yM94E4WTcJbehp6/Vh1QVFOy73wTMN3teJcoffjAsRJA4R51E6FGWJgCjTCGR8WGkg3FZPTGo3QOh/MFSrjzMubKfQTtloOThBJV2yTRlHYflmuJyLMyB7hOn5St4N2oPnRmroJqSuVneO/Wjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766402988; c=relaxed/simple;
	bh=Zer3CVK2m9MjYeX50hwd+QTTd7kqcuce+uoTtUUy59E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCds6j7TtuXLEWYFrpCASbcpZPh30OPV7bHIhxuviJ3+LPtycQEyLrvncnLI45TGI3qLzrxa2tHDplYXna+v0qjGNgIcn3PGLOKg8/8ysE8aetPVSmG55cry252kfHSN3Fihun8oHS3X4/aWykHX7E1ObOAI97LT/Dd3ouJyjc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cnJlwz0s; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZkMNMRiG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766402985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=trx++4HMpngilAdOuEfxPo65asvqXjMgnOx2xz3iAd0=;
	b=cnJlwz0sTYwR9wtCtHLsqo4nujXwWpydQpZm4XUYozyf3+V0UOngtlBcSmOntr1V1VMst9
	G9+8ubgQzaHaOHpF3wnTsJNwQrcYsXlsEg/yEkkqg9vNUOE0XPzjLm5JpdGrYq0qD5CtEZ
	o9BqUBbYbgsK+JxDbtgxbSB++2KUPLA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-_4FWXrCMPbiQ_mqAgGIRGw-1; Mon, 22 Dec 2025 06:29:44 -0500
X-MC-Unique: _4FWXrCMPbiQ_mqAgGIRGw-1
X-Mimecast-MFC-AGG-ID: _4FWXrCMPbiQ_mqAgGIRGw_1766402984
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477cf2230c8so40032345e9.0
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 03:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766402983; x=1767007783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=trx++4HMpngilAdOuEfxPo65asvqXjMgnOx2xz3iAd0=;
        b=ZkMNMRiGvcKgoXwYxEgjVTNStJW1J0FYzVHOFNPnVE9VWJObq0/uU2QH4gm8l9KZiI
         BBXCU2WaUFBgeesiEjFNloicC04WrtO8oSUoPkI5FEBnBLCmPeLW8yaphYnwIMo3u9S3
         afUBl1RRokX1qFfXUYBLccp0JKdQHp4/X8ESqFaNo3ye+Rf0ucaJb11R40dWh8C0vBqd
         ThTVFYi/OM9cCwArOoXIfZcmhiCQj8wLDcx0Z/xdGiblISl9nVrj4KaKlhgESbzdSca/
         0lL/gzDuAWcXRQThnTKHRtpJTcJ3UdXiNOOWeX5T7PRI3osrRVHitCvGIsHMeuGcN7pL
         41Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402983; x=1767007783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trx++4HMpngilAdOuEfxPo65asvqXjMgnOx2xz3iAd0=;
        b=Di/3lku3N2rh0h3uc3gHMhCsb8VzMUZk3rBHaAJ3UhkK7yYovBB2vuSya82kyKIo2V
         mnG1uJr9Y7/1Lv8cW/KYkznA5w5gOqAZBh9mKdeynHm1H8PzCjuz78BdowZq6wbIVyCJ
         /9xTf4wc8Fc7puL98KVBn1mgduATdNDK7b9g96d2odtNh5pdqxvI10otwY4RrYPX2Fnd
         3IbPfFRNco30EJ2SBeXWL/lju6ziTd6wfPQ9OpUpTThXvla4c91iIUYVtJoB3I/OQyiw
         onuWv3poREk8BJNRw8S4bhs0LAro91t81xhdVqZhYg9H0TEa/5INtD7r5dL0Y+qE33bI
         gTAA==
X-Forwarded-Encrypted: i=1; AJvYcCUgURGBoWloSqGIoymkQFU5fSHyG2ZN57Yi930hEYQx3Y/ElkTGKbHM/F7pB1f10hjjKzrTHDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIusjeNWfQC9pDAy1w3OoRu3mGLyzNJl8SMlFQ8TjmN136yfTS
	dlRDMeOElfHopjCa1mf8vUMXcqKBHoL/qn/0xzIqRVZwRhYMrFuA+08AiogTMMvu+2uMZzIEsZf
	A+mPZRpQyH1MD8WVzlDY3dd5x9lY27lCf6Hb5mXwxVZg1mfdiNI28jGHTdw==
X-Gm-Gg: AY/fxX7kMk9witg3nVZiMJ5mQPe8ehJUANLeCwu7DS4McrY4BmOaDjSc/lJTGKc8hZV
	Vr+tpb5csflrNFDa/0A9ULlHl1jEZpTPb9kuR+amf898IZo8uA3amqG4yILLbW9cXdjJCBcrW8M
	KfgoPJMyHnG7bTMyXHQVlO01oeQKXL8Qft/hwNIsDsg+b2IRIldhnpLN/qOh8iHhAwvEf0mfG9b
	dNEOuOPMjrextMHjlnOr7/9BccZX+osQt4cwoCSxJctRQ4qbJsWmZiUlcTdmW1UiW/TcevTsD6Z
	bbmzLOgH5NvTFOC5NWm9UyZ49627IAjy8CN0vhHpMpxBUmlm4H4cs+pOwGJ1lreRhMByuGwyW5+
	m0WeDFjTiYB4L
X-Received: by 2002:a05:600c:35c1:b0:477:8b77:155e with SMTP id 5b1f17b1804b1-47d19553912mr131584915e9.15.1766402983490;
        Mon, 22 Dec 2025 03:29:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQPwvXcFbPSb9NY07dbnbd4DXj5rIgFgt2qbUUJFJjQWXgE5JBQe08t+55yWqaWXMM7Vqvaw==
X-Received: by 2002:a05:600c:35c1:b0:477:8b77:155e with SMTP id 5b1f17b1804b1-47d19553912mr131584625e9.15.1766402983067;
        Mon, 22 Dec 2025 03:29:43 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a6c9d4sm96503265e9.3.2025.12.22.03.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 03:29:42 -0800 (PST)
Message-ID: <edd72057-61b3-4bb3-b2ee-446d71e6f427@redhat.com>
Date: Mon, 22 Dec 2025 12:29:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: openvswitch: Avoid needlessly taking the RTNL on
 vport destroy
To: Eelco Chaudron <echaudro@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Adrian Moreno <amorenoz@redhat.com>, Aaron Conole <aconole@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, Alexei Starovoitov <ast@kernel.org>,
 Jesse Gross <jesse@nicira.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, dev@openvswitch.org
References: <20251211115006.228876-1-toke@redhat.com>
 <198C2570-F384-4385-8A6B-84DCC38BB5F5@redhat.com> <87qzswklc7.fsf@toke.dk>
 <E6D49A6B-A0F7-46B6-BC32-A5C4ADAFD6DC@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <E6D49A6B-A0F7-46B6-BC32-A5C4ADAFD6DC@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/15/25 1:31 PM, Eelco Chaudron wrote:
> On 15 Dec 2025, at 12:58, Toke Høiland-Jørgensen wrote:
>> Eelco Chaudron <echaudro@redhat.com> writes:
>>> On 11 Dec 2025, at 12:50, Toke Høiland-Jørgensen wrote:
>>>> The openvswitch teardown code will immediately call
>>>> ovs_netdev_detach_dev() in response to a NETDEV_UNREGISTER notification.
>>>> It will then start the dp_notify_work workqueue, which will later end up
>>>> calling the vport destroy() callback. This callback takes the RTNL to do
>>>> another ovs_netdev_detach_port(), which in this case is unnecessary.
>>>> This causes extra pressure on the RTNL, in some cases leading to
>>>> "unregister_netdevice: waiting for XX to become free" warnings on
>>>> teardown.
>>>>
>>>> We can straight-forwardly avoid the extra RTNL lock acquisition by
>>>> checking the device flags before taking the lock, and skip the locking
>>>> altogether if the IFF_OVS_DATAPATH flag has already been unset.
>>>>
>>>> Fixes: b07c26511e94 ("openvswitch: fix vport-netdev unregister")
>>>> Tested-by: Adrian Moreno <amorenoz@redhat.com>
>>>> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>>>
>>> Guess the change looks good, but I’m waiting for some feedback from
>>> Adrian to see if this change makes sense.
>>
>> OK.
>>
>>> Any luck reproducing the issue it’s supposed to fix?
>>
>> We got a report from the customer that originally reported it (who had
>> their own reproducer) that this patch fixes their issue to the point
>> where they can now delete ~2000 pods/node without triggering the
>> unregister_netdevice warning at all (where before it triggered at around
>> ~500 pod deletions). So that's encouraging :)
> 
> That’s good news; just wanted to make sure we are not chasing a red herring :)
> 
> Acked-by: Eelco Chaudron echaudro@redhat.com

@Eelco: your SoB above is lacking the required <> around the email
address. I'm fixing that while applying the patch, but please take care
of it in the next reviews.

Thanks,

Paolo


