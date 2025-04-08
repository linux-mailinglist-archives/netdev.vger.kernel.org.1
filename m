Return-Path: <netdev+bounces-180507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F0CA81945
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD1E8A39D1
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 23:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476E6255233;
	Tue,  8 Apr 2025 23:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JL9OLAUu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA71B25291E;
	Tue,  8 Apr 2025 23:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744154628; cv=none; b=YErEj9DxtPvnNzfcRp0VW/03CxRpXA8rqGVf/STMg74qwAtsXgmWLabgPBYH5Niepo6AeK/peHcZl6O5hmIXrqZAEIoCSdPXcnyHoCI3PkX5mLIPvtxyAvtiy8k/BrT6+9eL+OymcpvruwlorPGVES3ib6h1RCZuXma/E3Jd2eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744154628; c=relaxed/simple;
	bh=H0XMTlNnGNJTLmiGDH4a+wLj1hWrBoxh71FQw71GxLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lcQ5cCzA1qkPDFBHjVUoqqq1v0RzSfJxOiWlq/6RbahlUUCV1BidEZ/TQa74vxIDLEGaohVEQ7sw/lNXHlhym6lGBqwOJBmmLMzae0EBXHVVKhNOFf/PvqJF3dSgsoWs1hhHSvoOlnSZVD8gjrxonAIjFz52FvzMvaNjO5qZsus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JL9OLAUu; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-af51e820336so5783922a12.1;
        Tue, 08 Apr 2025 16:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744154626; x=1744759426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJsDFlUL6Zd7eUl9Dh4knyb3AG+zCCjQeQsb2X2t9Bk=;
        b=JL9OLAUuTF3/AUD7ShxQJEEPxxONZ1/oSAOYvQIJQ3awGHRhtRWEnopgrBIMe3U7S+
         fucwj/K+R910KPOLJcep7FKdNCaqyNk5c78l/Bn8gUMfoaiiNnduaGiJR5vTqoyF6BoD
         wNsG2YfOgnYwaWwKG2uPBtrvcuKvuS5XgwhrW/nc4jkgOK5MykNVYgkuqKDWgYZG5BC7
         t/XrgX3ZSSRw5oVSJrRXiDgr3UnutXInC5nJUxJrEtlFW19c4W1FIv4pbLiyjpLYZwjq
         q53v5hyN+EeX5LiaIsMf8cFDd4insBfB19RdfTaVZBZtQYlwV4BIruQV76Kl9KsesEVu
         G0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744154626; x=1744759426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJsDFlUL6Zd7eUl9Dh4knyb3AG+zCCjQeQsb2X2t9Bk=;
        b=LgKhl6qMjbVnvBYOSmz5jl2aRDPPeD3ocq8R6pAmfnsl+VY8kVnG/OWFvMM1e/+SB6
         3GjkC8p1jEpi+ZQ7v3a3/0GKq/M9y4jp8TVDDp+WJyTZKkPztvrtiyGSUN47bZEIO9fI
         eVOv15CUEuv0x/UDxP6uilxWnl8SK5bpnRcDkCWvQilHdUyXqerT2nKMifTv/4pfUG4r
         0ImBDgF3QPgW+srxpXvpIoQ5yIulaHYKpEAiLQkYlUDVwEjhQR04/qGOnaFaMshOzkO5
         pV6/o2WYJyxB+HlmZ4U7BoN61Gd0MuDw1hA30ydLzZf1dAYQy517R12DmGF4NU5AFUeB
         efsg==
X-Forwarded-Encrypted: i=1; AJvYcCVBhnVQlJkCAfcUH40xKGNigJGLCAMwC5P7MbvPgx+x3ND6sYW//eCBSI3u2JEseRm7irn6Ky6Q@vger.kernel.org, AJvYcCWeTXMV7xbG42AQ/zsgcvq6Yw/xTlyzhEJfBxdGSjWBRPYMInv1xtT8H59Ff5pI1DKmksUbECZYNm3YEyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym7ytM1aze6DkbsIoZmvlQBAJGRAKM9qg6CCNrLqclQa1Ty2w6
	CtBqQ+0qZxIwXblHedgLjJpZY4O2Jg6CGQ7oUEkvgIiJPR5yhBQ1DgmfMJTdZaGu
X-Gm-Gg: ASbGncshg+OK9iDn9qrDPy+hXNs2lvQ/Q2ho+/XnXm+EmmfzhpcB1GLC2SF0u189cg7
	ZQQ3LBdNgDmNR+modQlwI1VMPOiYMWOEn32a0SwlQOxPzqhMR4y+p6A2sac08CsIC0B/ExBzBn7
	/uNsr4tqXaTjikqMg0GQdvaRaCov20Tob8p6jPQ2Exyh1pAKcSxHfWDaD8CgVu2LlFcmOjiZD6G
	6mIMA2Ji3HDHhmULA7YKSYrDORFXE9lx9BNRQYlxSNkLlKAIAifL1GXHkZ0TRix7HenTDWditTa
	k0K64M3TFumKe4EDiMwiKu3BsR4FG9GfyKdm4DD1bRbXnTOd6QWeKVKIGaZRp5e1aym4+mH4HbG
	kJmjYeed/MbrRAHZM82KR
X-Google-Smtp-Source: AGHT+IFFouWJcmS4FsC+uzQYbefLVU/J64864RiYNcgtYEjIQGYjhLjftfFGyU9f6PSM9PUWQtkJ9g==
X-Received: by 2002:a17:903:1447:b0:223:501c:7581 with SMTP id d9443c01a7336-22ac29a6710mr13568425ad.16.1744154625913;
        Tue, 08 Apr 2025 16:23:45 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:115c:1:f94c:8e92:7ff5:32bf? ([2620:10d:c090:500::4:98ff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785c01b7sm106231095ad.96.2025.04.08.16.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 16:23:45 -0700 (PDT)
Message-ID: <93ac7481-43c0-4207-8965-2d793c90263c@gmail.com>
Date: Tue, 8 Apr 2025 16:23:43 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] GCPS Spec Compliance Patch Set
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
Content-Language: en-US
From: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
In-Reply-To: <Z/WkmPcCJ0e2go97@home.paul.comp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/2025 3:35 PM, Paul Fertser wrote:
> On Tue, Apr 08, 2025 at 03:02:14PM -0700, Hari Kalavakunta wrote:
>> On 4/8/2025 12:19 PM, Paul Fertser wrote:
>>
>>> In other words, you're testing your code only with simulated data so
>>> there's no way to guarantee it's going to work on any real life
>>> hardware (as we know hardware doesn't always exactly match the specs)?
>>> That's unsettling. Please do mention it in the commit log, it's an
>>> essential point. Better yet, consider going a bit off-centre after the
>>> regular verification and do a control run on real hardware.
>>>
>>> After all, that's what the code is for so if it all possible it's
>>> better to know if it does the actual job before merging (to avoid
>>> noise from follow-up patches like yours which fix something that never
>>> worked because it was never tested).
>>
>> I would like to request a week's time to integrate a real hardware
>> interface, which will enable me to test and demonstrate end-to-end results.
>> This will also allow me to identify and address any additional issues that
>> may arise during the testing process. Thank you for the feedback.
> 
> Thank you for doing the right thing! Looking forward to your updated
> patch (please do not forget to consider __be64 for the fields).

I had not previously considered using __be64 for the struct 
ncsi_rsp_gcps_pkt, as it is an interface structure. I would like to seek 
your input on whether it is a good idea to use __be64 for interface 
messages. In my experience, I haven't come across implementations that 
utilize __be64. I am unsure about the portability of this approach, 
particularly with regards to the Management Controller (MC).

