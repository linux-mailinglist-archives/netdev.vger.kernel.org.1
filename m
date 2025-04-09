Return-Path: <netdev+bounces-180571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 066CAA81B6F
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 05:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2EE882B0C
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 03:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E00B16F858;
	Wed,  9 Apr 2025 03:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/B9LyYZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8191829A2;
	Wed,  9 Apr 2025 03:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744169231; cv=none; b=m8hligKEENJq7pbQYkaNwor8ZTOxZdY8ddTuO76R/YwO5EusZU5g/qDxvGGDHC5aUVY1bcOtxMFho5iwF0Rxu9wFcTo0zXrNKZy9ihGsAMdVPuoVLvozGbxOXyEI3XMmxQYJEiETRef8L47RJyErmtistbkUq5rTCHGdTIIF9H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744169231; c=relaxed/simple;
	bh=D6EvTL4iYuuHIjtGTY4AYogyqtGWNblNDT64LnMhFrE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=p1oCx08Sd8gWB5wyWUraCEe4j2Zxv2GkvPiscLunCeGvZluBHvgqOjxydlUX+BxG0jI2o9AdYe6AVwPfV2N0/PBHXynGQyBXgcoirM2PueKefUfTncXmV4kypKOniatJ2ckVDqIbcfVug1UPjikk/uvQ3ljxIEP3cGAJI7u+B9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/B9LyYZ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7359aca7ef2so8914583b3a.2;
        Tue, 08 Apr 2025 20:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744169229; x=1744774029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a4jAE1elJcepr1tdiADTCAGlm7zbKPiv/FbJVtT5R04=;
        b=l/B9LyYZybwpSd2FUh5V/YCWwOI2WPV7JTAaYbKRl4whDLoIQEvnQ8FoUYpSToSpVR
         7hnRip1znXetKdM3P0BmWx8xTFfwRh1yVZ5mfX700msuA0HB7ZMG2EkHLhukXLKy4czS
         9VCPrwoei2e/QpRhJXTlpmcczU9GILlOGH1QujF2QOS8gsont6Y3bwT51+P0eaKj1TrX
         O1BDXBWGCQlQrtOuoVf9r7Gq69ZviW+gidesCT80GbYXCxLRqz2WrGRfoKdUYJzn1pFA
         P1kr1QHP1Rt/OaCyVN3VXLOst2SiR3CI2zmSLAlLrI7cqZYk/HaVRxcFLuNU4L/ritbA
         RToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744169229; x=1744774029;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4jAE1elJcepr1tdiADTCAGlm7zbKPiv/FbJVtT5R04=;
        b=ugPEAxeteTWYPjUm8Mo1H8GRC9rDar4tVZCSlK/aBBXMZ2BD3MPsBQVN5CUgp3ZopA
         ggsXzBR5eZed1mfveKdff4UwTtE/P9/HcE4PIbbc/Aj0UK3/xGCJuIZ0Y4mvYFnDanen
         fT6HNsXvy1mgDvFfB94NzD3S4g8KUritfQ2xHoCGjYv8WJqD3HLDIcTlKJNhNk8vbdaO
         A7K2DYDxhhPTjyX60cnQ+zAppRl+QAZ2HC0tE74sl+RORYc3IA58T9F5I6id6L5eb6JR
         xpnMobwr9OXmWhVaYWuKQ7zSu76Vgnui5aLzj4ry5oeOQVVLLZakWry50Gy9GIlB+HyG
         9bQw==
X-Forwarded-Encrypted: i=1; AJvYcCVDl+9u2LwV7p2kSbhA6ZlTg7jhRcDlUJxuy2z5wnm4dKlpcycZF6oNJ/TLdcc/kY4IwXin6xo3@vger.kernel.org, AJvYcCWUjfr/CXhMh/GeiRJPx5s2i379XhwRSwqPAV+YYA3J5FZxVQyqpxTEfKRnnI1NCwCw/0SKYwqR45BZDWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFfyJia8ttb/J799eBKOH6hFXY7nn6/DoViQ9cC/K9iTIM+bXS
	NBQneGUaeeejrBT617d0F5Mu47XqD46YH2iRCk/GLWna+G9H9go=
X-Gm-Gg: ASbGncslBxVQYM6BXZNdGlQimk7lx5LAHjqIqB+Cfy3/Y/mkHbGvpX9lsk3TXB+gnIX
	VN05AyS97llyhvXWEI3HtL2pXPjIZcLf9tnxpw03IxJ20B84v+ImF0ReyJzU5pSsv2sJIa6Azne
	v0F4FiZL2nOeGVWrP1YbGCnc8Y8sfRBft4y8YR0+pZ/ah8wdEpAfbpQ+s2oXgNi9CxtbGJidbJc
	2gVGvycxJ4SCz00kaiggJDZk9xm4EL72rqc10HVs4bP63foGtHQjmSh908mIFaB+TnE9wCIfJzK
	C/Ju4rQiSQOuIWxZ6sYi8B0gqeXgYEbDCZzhMoz0L5jj9dDni+mpwtyg3Tyyw0oauSwd+pjrK5i
	hqKl7RMDQJL26XOuagbsv
X-Google-Smtp-Source: AGHT+IFluP2lajffl9SoWcBd2FkHmaeG3wkjggTtla8rF5wyu2rM+lF5RAbLROcd8TQorKRJsHANww==
X-Received: by 2002:a05:6a21:99a6:b0:1f5:8b9b:ab6a with SMTP id adf61e73a8af0-201591956c0mr1731310637.18.1744169228551;
        Tue, 08 Apr 2025 20:27:08 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:115c:1:f94c:8e92:7ff5:32bf? ([2620:10d:c090:500::4:98ff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a11d2c1dsm192043a12.38.2025.04.08.20.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 20:27:08 -0700 (PDT)
Message-ID: <6d2abc68-ad40-4cfb-b6aa-bd724023f998@gmail.com>
Date: Tue, 8 Apr 2025 20:27:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] GCPS Spec Compliance Patch Set
From: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
To: Paul Fertser <fercerpav@gmail.com>
Cc: Sam Mendoza-Jonas <sam@mendozajonas.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, npeacock@meta.com,
 akozlov@meta.com
References: <cover.1744048182.git.kalavakunta.hari.prasad@gmail.com>
 <ee5feee4-e74a-4dc6-ad8e-42cf9c81cb3c@mendozajonas.com>
 <b1abcf84-e187-468f-a05e-e634e825210c@gmail.com>
 <Z/VqQVGI6oP5oEzB@home.paul.comp>
 <1d570fb8-1da0-4aa6-99f5-052adf559091@gmail.com>
 <Z/V2pCKe8N6Uxa0O@home.paul.comp>
 <b1d373d7-77e5-4341-a685-07a617935db5@gmail.com>
 <Z/WkmPcCJ0e2go97@home.paul.comp>
 <93ac7481-43c0-4207-8965-2d793c90263c@gmail.com>
Content-Language: en-US
In-Reply-To: <93ac7481-43c0-4207-8965-2d793c90263c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/2025 4:23 PM, Hari Kalavakunta wrote:
> On 4/8/2025 3:35 PM, Paul Fertser wrote:
>> On Tue, Apr 08, 2025 at 03:02:14PM -0700, Hari Kalavakunta wrote:
>>> On 4/8/2025 12:19 PM, Paul Fertser wrote:
>>>
>>>> In other words, you're testing your code only with simulated data so
>>>> there's no way to guarantee it's going to work on any real life
>>>> hardware (as we know hardware doesn't always exactly match the specs)?
>>>> That's unsettling. Please do mention it in the commit log, it's an
>>>> essential point. Better yet, consider going a bit off-centre after the
>>>> regular verification and do a control run on real hardware.
>>>>
>>>> After all, that's what the code is for so if it all possible it's
>>>> better to know if it does the actual job before merging (to avoid
>>>> noise from follow-up patches like yours which fix something that never
>>>> worked because it was never tested).
>>>
>>> I would like to request a week's time to integrate a real hardware
>>> interface, which will enable me to test and demonstrate end-to-end 
>>> results.
>>> This will also allow me to identify and address any additional issues 
>>> that
>>> may arise during the testing process. Thank you for the feedback.
>>
>> Thank you for doing the right thing! Looking forward to your updated
>> patch (please do not forget to consider __be64 for the fields).
> 
> I had not previously considered using __be64 for the struct 
> ncsi_rsp_gcps_pkt, as it is an interface structure. I would like to seek 
> your input on whether it is a good idea to use __be64 for interface 
> messages. In my experience, I haven't come across implementations that 
> utilize __be64. I am unsure about the portability of this approach, 
> particularly with regards to the Management Controller (MC).

Here are the results from a real hardware test, which validates the patch.


a. Initiate GCPS command to the NIC-2
root@bmc:~# ./ncsi-cmd -i 3 -p 0 -c 0 raw 0x18
<7> Command: type 0x18, payload 0 bytes:
<7> Send Command, CHANNEL : 0x0 , PACKAGE : 0x0, INTERFACE: 0x008cd598
<7> Response 228 bytes: 00 01 00 3b 98 00 00 cc 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 2b e5 fc e0 c0 00 00 00 00 
65 70 d5 54 00 00 00 00 09 50 66 56 00 00 00 00 03 08 a8 79 00 00 00 00 
00 3d 5c 44 00 00 00 00 00 79 38 23 00 00 00 00 00 02 fe 06 00 00 00 00 
00 00 02 be 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 b8 21 5f 03 8f da af 00 d8 6d 36 
00 73 a3 e7 00 17 20 70 00 00 00 00 00 00 d8 8a 00 00 0e 9c 00 56 4f 83 
00 10 17 e2 00 01 5b 76 00 13 6e a3 00 00 f8 cd 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 2c 20 55 f5

b. tcpdump capture of the GCPS
GCPS Command Capture:
         0x0000:  0001 003b 1800 0000 0000 0000 0000 0000
         0x0010:  ffff e7c4 0000 0000 0000 0000 0000 0000
         0x0020:  0000 0000 0000 0000 0000 0000 0000

GCPS Response
         0x0000:  0001 003b 9800 00cc 0000 0000 0000 0000
         0x0010:  0000 0000 0000 0000 0000 0000 0000 002b
         0x0020:  e5fc e0c0 0000 0000 6570 d554 0000 0000
         0x0030:  0950 6656 0000 0000 0308 a879 0000 0000
         0x0040:  003d 5c44 0000 0000 0079 3823 0000 0000
         0x0050:  0002 fe06 0000 0000 0000 02be 0000 0000
         0x0060:  0000 0000 0000 0000 0000 0000 0000 0000
         0x0070:  0000 0000 0000 0000 0000 0000 0000 0000
         0x0080:  0000 0000 0000 0000 0000 0000 0000 0000
         0x0090:  0000 0000 00b8 215f 038f daaf 00d8 6d36
         0x00a0:  0073 a3e7 0017 2070 0000 0000 0000 d88a
         0x00b0:  0000 0e9c 0056 4f83 0010 17e2 0001 5b76
         0x00c0:  0013 6ea3 0000 f8cd 0000 0000 0000 0000
         0x00d0:  0000 0000 0000 0000 0000 0000 0000 0000
         0x00e0:  2c20 55f5

c. dmesg log (Debug purpose only) to demonstrate correct value read.
[ 1350.369741] ncsi_rsp_handler_gcps ENTRY
[ 1350.369768] ncs->hnc_rx_bytes = 188542148800 (0x2be5fce0c0)


Let us examine the "Total Bytes Received" statistic. Specifically, we'll 
look at offset 28..35 (0x1c..0x24), bytes read - '0000 002b e5fc e0c0'. 
NCSI now correctly collects this value into it's internal structure.


I just noticed a warning regarding line length in the patch submission, 
I will address this issue in version 2 of the patch. Let me know if we 
need additional information.

