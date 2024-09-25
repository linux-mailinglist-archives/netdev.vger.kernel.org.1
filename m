Return-Path: <netdev+bounces-129810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF139865DF
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 19:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF5D1F225BB
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 17:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E248785628;
	Wed, 25 Sep 2024 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S7E9AvB8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBF884037
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727286247; cv=none; b=fhxtEDer9Yyer+oH5jlxraLLYBUZ4geSa8rZa9dKekuqSja2qSqoWHx0Mw1RjoBOYS63yLGt6OaslQmO9flrD+5PvWkUASzNIzB5OojsQNmCj7GZa+moHcr74yQ2rvYfHJKh5t8uKqjFi6zYa3RD6EXY7VifZvA6zGqYdu1GSzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727286247; c=relaxed/simple;
	bh=mdOJO1T2SXtgXhpZ8IXEcyfGOLgVnBuAE9fSfJICRmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0YkgLc3d7rZVOmtjDzLq5hu+xEoLEuHroseKXWUMsLgZd4ezvF6CyyRaCIQNOQc+FC5YkmfqoyXvudeKQcI2ydXGtCzQfTbtmq0uRc9D4uFfUX9RC0tEfRzsYQGXNk9iFW6rsq0FSCSbi0hxKG/Vvo7pImkePQl7urku/y9gfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S7E9AvB8; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a0be4d802cso485925ab.0
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 10:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727286245; x=1727891045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1NOQIHvoS1b32+JnBJFUorwn4fOby0JeQc5DVFR9XI=;
        b=S7E9AvB8z9vhEKVxqeOY3EdmweLKcSMceSz9dRv4NyFaQbru0zdCiB1lzgxnqoKW4M
         HxKWfW1ecyDsEZxPxQBrPPMxwQVgJrzsQ8g81PThpkCF2/kt5A3bUtxIAjNf0jLAXRvY
         R3rnJy+A8XnIt7aSrbivsyU67NaF+rE3JZFjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727286245; x=1727891045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1NOQIHvoS1b32+JnBJFUorwn4fOby0JeQc5DVFR9XI=;
        b=KPI285TtGtE0EXprys9IuN1GT4FQ7SCH8+o6PtKVXVSoPju7YN5wJmYcm6Nt1fPKPo
         R+Ng42BTK5dFUCJlAgKKQTuuhm5PZCpiHIYgjFenbVXj4zbomEgew/gKsLI2Oz+3yFFw
         dBQ9l1fgaNzTWUsCv3IXP/oxRFMUSjr2r9E+Gq9s17z1OCczgCWPhP18Ewt5eDJphvvF
         DIyl3CJsyZSr9ng0rBnzGUXuuhI+3zbFdWX6VAxfo7dfcf3m52X0eTONu+AE2Qdp2MMn
         3das7+JgveVf74T0Wycim8VN5U2ix0VEPs6Yi+0XEeYn+LaUMOxuAtR807qIiq+1nBDO
         hPKg==
X-Forwarded-Encrypted: i=1; AJvYcCUDUtP8wsnkaGWWh5VB1Mrrw627WACH2fcsrwZR9qaYW+9FOD/PFoyPopghwKwvt0VEFs6FR8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMYztxujP2Lwbh6gbKvoPIZ7lMVfL5mEW03x0o1aSSEkl7Vz9b
	iyTnxhSTYCMtgbiSDFY1gftBOXqYhmwMg/S69zM6SMd0R1R7MeEptv4TepsdhtM=
X-Google-Smtp-Source: AGHT+IGU2iXvHZXBx7d7MTmHzpaHRYoM0isbxb+yjYZRM40BVKEyJurIZQMglgYHXU0dupnd4jnbLw==
X-Received: by 2002:a05:6e02:13aa:b0:39d:4c8a:370d with SMTP id e9e14a558f8ab-3a26d7a0ed1mr37529425ab.18.1727286245036;
        Wed, 25 Sep 2024 10:44:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a1a5713ac4sm12296485ab.68.2024.09.25.10.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 10:44:04 -0700 (PDT)
Message-ID: <576dd993-1428-4be0-9e5d-abec44a039c5@linuxfoundation.org>
Date: Wed, 25 Sep 2024 11:44:03 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests: exec: update gitignore for load_address
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-mm@kvack.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240924-selftests-gitignore-v1-0-9755ac883388@gmail.com>
 <20240924-selftests-gitignore-v1-4-9755ac883388@gmail.com>
 <e537539f-85a5-42eb-be8a-8a865db53ca2@linuxfoundation.org>
 <70864b3b-ad84-49b2-859c-8c7e6814c3f1@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <70864b3b-ad84-49b2-859c-8c7e6814c3f1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/25/24 10:25, Javier Carrasco wrote:
> On 25/09/2024 17:46, Shuah Khan wrote:
>> On 9/24/24 06:49, Javier Carrasco wrote:
>>> The name of the "load_address" objects has been modified, but the
>>> corresponding entry in the gitignore file must be updated.
>>>
>>> Update the load_address entry in the gitignore file to account for
>>> the new names.
>>>
>>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>> ---
>>>    tools/testing/selftests/exec/.gitignore | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/
>>> selftests/exec/.gitignore
>>> index 90c238ba6a4b..4d9fb7b20ea7 100644
>>> --- a/tools/testing/selftests/exec/.gitignore
>>> +++ b/tools/testing/selftests/exec/.gitignore
>>> @@ -9,7 +9,7 @@ execveat.ephemeral
>>>    execveat.denatured
>>>    non-regular
>>>    null-argv
>>> -/load_address_*
>>> +/load_address.*
>>
>> Hmm. This will include the load_address.c which shouldn't
>> be included in the .gitignore?
>>
>>>    /recursion-depth
>>>    xxxxxxxx*
>>>    pipe
>>>
>>
>> thanks,
>> -- Shuah
> 
> 
> Hi, the kernel test robot already notified me about that issue, and I
> sent a v2 to fix it shortly after. Please take a look at the newer
> version where I added the exception for load_address.c.
> 

Thanks. I saw your v2 after sending this email. I have a comment
on v2 to split core and net patch

thanks,
-- Shuah


