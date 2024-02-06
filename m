Return-Path: <netdev+bounces-69599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4845A84BC93
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 18:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20A7289FCE
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 17:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EF4CA4E;
	Tue,  6 Feb 2024 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFfqQr9m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1FC134AA
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707242134; cv=none; b=hRG1M3Rx3j+Z1Ba7RJaDE0sLJgaWeb9HZBmFQbLJUhSEJC5Td+uMVlUz2NWD7tHxBWUTlu8m3PjGvlJ/Xtg6c8uF0kfboXt+tJfMf6CuGWggXbRQIw0z6yzMppxFrAfGlnxljamkTNVE6Ok49K+72gR6QiDQNlxpMLNtJjfOmek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707242134; c=relaxed/simple;
	bh=HcDkmBsFhnyU5rbwWI3oAT4kaqE7UquOzQKTZx5BPHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J3sQLwh7ONr43ZjHwUi+bdJpBkOksR8OXtqibzSUXci/QQeitpCo+c+Vw3N9yE2khKWplhaWUXX+A7WnxWakBZmL31xh9jOq7KM9NqJ6+CkybOkfSnF/Eu/ez/KjnC0NcXdJKx2yHpSlLutnnKtA02tAzk1lQF+0fz7tEiBDWAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFfqQr9m; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e055baec89so698330b3a.1
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 09:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707242132; x=1707846932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=a/BmeUVInIyHDCTL4se8RMMR8I9jTDDaYFkyAPbmr+Y=;
        b=iFfqQr9muike+qwyNW/9t3916mvk3sHp5l2OV9m2fRh2q62SalFkdTtGvKPmrkC6CK
         so4vjbEjxdl5+2z5sk731wITQatMJkWn98HL59kguwSWhxgMeH2PB9SUQ9L9CZU1G8mH
         0FqfOOXhqpIKhNJIJ9okO/ESPEprjEgWsSxwkt8mI35CbQSeigcrk970XTiqyeeBfmuj
         m4bZm5YoONYuQJniGdCBIfOI2/MqpBvaz6s7mqME3ySIHqHp8Mb7oT/BPQ3rWyqYbgk1
         UZ73cxWFC5P+iFh9HSRd9V2IkH4MxDTVcWrDJmJ8+MoUi4xFYgOduEr1ax9BbcGrggb5
         yTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707242132; x=1707846932;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/BmeUVInIyHDCTL4se8RMMR8I9jTDDaYFkyAPbmr+Y=;
        b=HFl3zjnA6Z6P9AZD/JShZ0gnm5ot09+D/kwyzwFr1tKntk2Y7x0eIRp5SMaAWfnyhY
         N8YYng3wyYT0MMMV2TcFjza+WriVLn6E1Pm2cEWr+C15QbnumnzYzSQwm23birVZyVgU
         Citv3b9ybfoEYDiA+pwV/RfRny1xVR/c+fFZyxgBHSx98H9cL77CRINOWsBJE7gO34Si
         PT6yJ6ZFyLdJYslKCsHr48CDv+pupEPtFimXhytY2g46LW/+Zoylk/87jWCu3PIyFZ0M
         50hG5X9mq0/FaJfr5h1uAIiHt4q3kszqOMGvk/H+bYoCq89Iw3FaNCtGCySqXw8uGrig
         Xa7Q==
X-Gm-Message-State: AOJu0YwXODSZwZH3cvm58hJtYxLkyeXc3DuTm6k39xbypXpc4ZphtpNO
	eOhVDX/wA6MFkKcXwvfvPA+FhvmON2Y6acepSmyfEspXgyFbZC1xRHLf5SZ0
X-Google-Smtp-Source: AGHT+IEu+0lFxKweihu5Dr8Ev9+SmgPYX/223dgdbcRMq8XdErBxgJVArFosTjAFThYKyu/DxL3Idw==
X-Received: by 2002:a05:6a00:3491:b0:6e0:4a19:8da6 with SMTP id cp17-20020a056a00349100b006e04a198da6mr339318pfb.3.1707242132190;
        Tue, 06 Feb 2024 09:55:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWphSMDuzHqgz9CLLu0kRGdX/QkB80JWBW1FO3bNcCU1tReDLKRmwXEeyKZdWFV3w1wfasgiJzUogDqytpu3yE3oD1BUfrI
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z13-20020aa785cd000000b006d9c216a9e6sm2222969pfn.56.2024.02.06.09.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 09:55:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6904162b-5ac1-4f2c-a48a-02c104f6fe4c@roeck-us.net>
Date: Tue, 6 Feb 2024 09:55:30 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Persistent problem with handshake unit tests
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
References: <b22d1b62-a6b1-4dd6-9ccb-827442846f3c@roeck-us.net>
 <ZcJihCDh30LD4NPy@tissot.1015granger.net>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZcJihCDh30LD4NPy@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/6/24 08:47, Chuck Lever wrote:
> On Fri, Feb 02, 2024 at 09:21:22AM -0800, Guenter Roeck wrote:
>> Hi,
>>
>> when running handshake kunit tests in qemu, I always get the following
>> failure.
>>
>>      KTAP version 1
>>      # Subtest: Handshake API tests
>>      1..11
>>          KTAP version 1
>>          # Subtest: req_alloc API fuzzing
>>          ok 1 handshake_req_alloc NULL proto
>>          ok 2 handshake_req_alloc CLASS_NONE
>>          ok 3 handshake_req_alloc CLASS_MAX
>>          ok 4 handshake_req_alloc no callbacks
>>          ok 5 handshake_req_alloc no done callback
>>          ok 6 handshake_req_alloc excessive privsize
>>          ok 7 handshake_req_alloc all good
>>      # req_alloc API fuzzing: pass:7 fail:0 skip:0 total:7
>>      ok 1 req_alloc API fuzzing
>>      ok 2 req_submit NULL req arg
>>      ok 3 req_submit NULL sock arg
>>      ok 4 req_submit NULL sock->file
>>      ok 5 req_lookup works
>>      ok 6 req_submit max pending
>>      ok 7 req_submit multiple
>>      ok 8 req_cancel before accept
>>      ok 9 req_cancel after accept
>>      ok 10 req_cancel after done
>>      # req_destroy works: EXPECTATION FAILED at net/handshake/handshake-test.c:478
>>      Expected handshake_req_destroy_test == req, but
>>          handshake_req_destroy_test == 00000000
>>          req == c5080280
>>      not ok 11 req_destroy works
>> # Handshake API tests: pass:10 fail:1 skip:0 total:11
>> # Totals: pass:16 fail:1 skip:0 total:17
>> not ok 31 Handshake API tests
>> ############## destroy 0xc5080280
>> ...
>>
>> The line starting with "#######" is from added debug information.
>>
>> diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
>> index 16ed7bfd29e4..a2417c56fe15 100644
>> --- a/net/handshake/handshake-test.c
>> +++ b/net/handshake/handshake-test.c
>> @@ -434,6 +434,7 @@ static struct handshake_req *handshake_req_destroy_test;
>>
>>   static void test_destroy_func(struct handshake_req *req)
>>   {
>> +       pr_info("############## destroy 0x%px\n", req);
>>          handshake_req_destroy_test = req;
>>   }
>>
>> It appears that the destroy function works, but is delayed. Unfortunately,
>> I don't know enough about the network subsystem and/or the handshake
>> protocol to suggest a fix. I'd be happy to submit a fix if you let me know
>> how that should look like.
>>
>> Thanks,
>> Guenter
> 
> I am able to reproduce the test failure at boot:
> 
> [  125.404130]     KTAP version 1
> [  125.404690]     # Subtest: Handshake API tests
> [  125.405540]     1..11
> [  125.405966]         KTAP version 1
> [  125.406623]         # Subtest: req_alloc API fuzzing
> [  125.406971]         ok 1 handshake_req_alloc NULL proto
> [  125.408275]         ok 2 handshake_req_alloc CLASS_NONE
> [  125.409599]         ok 3 handshake_req_alloc CLASS_MAX
> [  125.410879]         ok 4 handshake_req_alloc no callbacks
> [  125.412200]         ok 5 handshake_req_alloc no done callback
> [  125.413525]         ok 6 handshake_req_alloc excessive privsize
> [  125.414896]         ok 7 handshake_req_alloc all good
> [  125.416036]     # req_alloc API fuzzing: pass:7 fail:0 skip:0 total:7
> [  125.416891]     ok 1 req_alloc API fuzzing
> [  125.418439]     ok 2 req_submit NULL req arg
> [  125.419399]     ok 3 req_submit NULL sock arg
> [  125.420925]     ok 4 req_submit NULL sock->file
> [  125.422305]     ok 5 req_lookup works
> [  125.423667]     ok 6 req_submit max pending
> [  125.425061]     ok 7 req_submit multiple
> [  125.426151]     ok 8 req_cancel before accept
> [  125.427225]     ok 9 req_cancel after accept
> [  125.428318]     ok 10 req_cancel after done
> [  125.429424]     # req_destroy works: EXPECTATION FAILED at net/handshake/handshake-test.c:477
> [  125.429424]     Expected handshake_req_destroy_test == req, but
> [  125.429424]         handshake_req_destroy_test == 0000000000000000
> [  125.429424]         req == ffff88802c5e6900
> [  125.430479]     not ok 11 req_destroy works
> [  125.435215] # Handshake API tests: pass:10 fail:1 skip:0 total:11
> [  125.435858] # Totals: pass:16 fail:1 skip:0 total:17
> [  125.437224] not ok 69 Handshake API tests
> 
> I'll have a look.
> 

Since the destroy function runs asynchronously, the best I could come up with
was to use completion handling. The following patch fixes the problem for me.

Guenter

---
diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
index 16ed7bfd29e4..dc119c1e211b 100644
--- a/net/handshake/handshake-test.c
+++ b/net/handshake/handshake-test.c
@@ -432,9 +432,12 @@ static void handshake_req_cancel_test3(struct kunit *test)

  static struct handshake_req *handshake_req_destroy_test;

+static DECLARE_COMPLETION(handshake_request_destroyed);
+
  static void test_destroy_func(struct handshake_req *req)
  {
         handshake_req_destroy_test = req;
+       complete(&handshake_request_destroyed);
  }

  static struct handshake_proto handshake_req_alloc_proto_destroy = {
@@ -473,6 +476,8 @@ static void handshake_req_destroy_test1(struct kunit *test)
         /* Act */
         fput(filp);

+       wait_for_completion_timeout(&handshake_request_destroyed, msecs_to_jiffies(100));
+
         /* Assert */
         KUNIT_EXPECT_PTR_EQ(test, handshake_req_destroy_test, req);
  }




