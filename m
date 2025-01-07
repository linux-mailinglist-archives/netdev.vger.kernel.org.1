Return-Path: <netdev+bounces-155844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE92A040AE
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D77162823
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D223BBC1;
	Tue,  7 Jan 2025 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB6lZS40"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9632A259488
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736255891; cv=none; b=nKxGEd4V2lF1CAHAnDx+gxPJDUMLdykT+5cAA6/thqc3LN/RhYiRPnca17vH/M6RQ50PHmojoUFPBrwjugUWD7hwL7Lh+fYc7AXcPEbiYY1Ba7JomXUAjXA47dFaGmNcl1otw1u3VR+LsdU/Xm10JXo6o2T9YybzYAZ1pvDE5rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736255891; c=relaxed/simple;
	bh=YaPKkPnP7JoeY57vDBJ6Rl0YNxY0hz5ZM3BfdSfzAVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iCyc3qi9L47DvVjtKHFa2lQFWb6PZfEKjJdVLemBM1bg0knRjEA48Jv2Ftp6qBT1AB+hefub0GlVAX81PaYQgWw8xM8YxNQ8i3xVILqJ96xiQfJNy1muNKGJ8XI/BLjTRAsIY0Af176LG7yvicax8LRYoRWbNjTLsvcpyjQujsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TB6lZS40; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2166f1e589cso7955495ad.3
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 05:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736255888; x=1736860688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rlj1V/4ZlKvC1RLYE9iTLTd7mMBO7AlqmbG78cQd/I0=;
        b=TB6lZS40/Rko156YRTiJ8JRuEEAPeUobwtqF+i2J9zoWKu9rt/85j4KbOxpD6LJ/l0
         zBShANV6wtj29C5Ie0IvS7pKQYjAuicBk0eIZ0cFqvza3tuFIN6X3W53P9Iw77IDN8Mm
         mDJ665swXLSX8DmnKD8zSSGQEADXg5uvTuPVETunuBexR1lri9dTWqMSskeXTOV1A65a
         jkaDnlkB52eqxNSjRhIrkZv8RORVz09TW47PCTtuTmb165yVGcwxxXdrW1UL1Zt4+cn9
         mDmyGyKlgzjfJEZ2T6LE0C2cgdPgmkE5AG0BHL8/qEwzZHS/KKfRupUEy3Ksl9cWq61K
         9PSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736255888; x=1736860688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rlj1V/4ZlKvC1RLYE9iTLTd7mMBO7AlqmbG78cQd/I0=;
        b=EezOKdGMrlErMVD7QAiGtBVVDp2+AuYXoQpoZvgfNUTJe02yjLbhB6EFVzoGJaLiFg
         yfM04ScT4uCcTXyvyTAlkPWSlSJrE5NL4xrWBZjcdYnUAsbmaO0mhCgz0bvRrFNH09d8
         4B1ut2fCZesganYmUYPo0RnGtDYC8jnNGYVsJi+lcUBGuiILPmDBd8EefEt1XjYBSjBA
         ebEB47Ly1piMVoqXkmdg0QUNloB94Gg0WJGJRRT8Xknk9+kzz88tAem3qGf8ouJZptcE
         pbk/oMGVDvbdoUs91Jeyy9z5yeDrHwXHaVWu//wEQwkD9XDgiSMs1Fz5pcP2yUgf1npc
         vN9w==
X-Gm-Message-State: AOJu0Yxvx2qbdREv8aN00xPWmm9uWNsKXddIGsJdwyrc1+6mC0gYkffF
	rlxmts4B8/1+C4fgX8wLE58dIcu3sufHMQ0F0QA4EbdVYdX26VF1
X-Gm-Gg: ASbGncvPf+6wxfeD/RaMyYqrcOB0L6UsZ6c7rMWG2eweHv8WnUYCpi255QcoFHY94dR
	buawMThi/UFBQjoCylET+8PHGTu3oYblzmp3Uqw0KId5aekvFZ7028NrF6Czn2o2xcfPXZq5kNm
	LM5GWYUag43WIkft5QAxY6FXKCj58gZX6aFqIywv+QHEQKzPwIcoWLigeB3EwY4kOuymUPNJsR/
	dh50o3u682y9Qcz3NNYC8dor67x/MG4ItBNDbE1bG7UjRz3JvZEbzdgG0Gc1mcMGAIvqR4OlvjP
	12eE3EA3
X-Google-Smtp-Source: AGHT+IFKYaBvn8JGDBz22qWzCIzWl+kKlWGcpVcXKap3jKOji8PbAKPSA5V6VEZ1Ggdec8aS8f+Zkw==
X-Received: by 2002:a05:6a21:8cc2:b0:1e1:f281:8d36 with SMTP id adf61e73a8af0-1e5e0458dbdmr89868085637.10.1736255887759;
        Tue, 07 Jan 2025 05:18:07 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1145:4:bc22:6f0:67b1:dcdd? ([2620:10d:c091:500::5:f2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842bdfb5759sm26116137a12.51.2025.01.07.05.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 05:18:07 -0800 (PST)
Message-ID: <3ab1a86f-5c37-4421-b4df-5d73729f1381@gmail.com>
Date: Tue, 7 Jan 2025 08:18:05 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC ethtool] ethtool: mock JSON output for --module-info
To: Danielle Ratson <danieller@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "mkubecek@suse.cz" <mkubecek@suse.cz>
References: <7d3b3d56-b3cf-49aa-9690-60d230903474@gmail.com>
 <DM6PR12MB451628E919440310BC5726E5D8422@DM6PR12MB4516.namprd12.prod.outlook.com>
 <f0d2811d-e69f-4ef4-bf0f-21ab9c5a8b36@gmail.com>
 <DM6PR12MB4516A5E32EB6C663F907C24BD8492@DM6PR12MB4516.namprd12.prod.outlook.com>
 <cd258b2f-d43f-4ae6-bd7c-ca22777d35e3@gmail.com>
 <MN2PR12MB45179CC5F6CC57611E5024E2D8282@MN2PR12MB4517.namprd12.prod.outlook.com>
 <f3272bbe-3b3d-496e-95c6-9a35d469b6e7@gmail.com>
 <DM6PR12MB45169CD5A409D9B133EF3658D8292@DM6PR12MB4516.namprd12.prod.outlook.com>
 <02060f90-1520-4c17-9efe-8b701269f301@gmail.com>
 <DM6PR12MB4516F7998D67014D9835C5F5D83F2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <DM6PR12MB4516E1A2E2C99E36ECA9D87AD8062@DM6PR12MB4516.namprd12.prod.outlook.com>
 <9e022720-f413-411c-be64-77c8b324549a@gmail.com>
 <DM6PR12MB451618A6A98EA0F5D4A6A549D8142@DM6PR12MB4516.namprd12.prod.outlook.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <DM6PR12MB451618A6A98EA0F5D4A6A549D8142@DM6PR12MB4516.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

The json output looks good on my cards with CMIS modules. On a different 
card that does not support the CMIS interface, the output falls back to 
non-json, even when --json is specified. Maybe this should return an 
error. Other than that, looks good to me. Thanks.

On 1/2/25 3:19 AM, Danielle Ratson wrote:
> Hi,
>
> Any comments?
>
>> -----Original Message-----
>> From: Daniel Zahka <daniel.zahka@gmail.com>
>> Sent: Thursday, 19 December 2024 19:35
>> To: Danielle Ratson <danieller@nvidia.com>
>> Cc: netdev@vger.kernel.org; Jakub Kicinski <kuba@kernel.org>; Ido Schimmel
>> <idosch@nvidia.com>; mkubecek@suse.cz
>> Subject: Re: [RFC ethtool] ethtool: mock JSON output for --module-info
>>
>>
>> On 12/19/24 9:18 AM, Danielle Ratson wrote:
>>> Hi Daniel,
>>>
>>> I didn’t get a reply from you.
>>> Anyway, here's a like to my git repository:
>> https://github.com/daniellerts/ethtool/tree/eeprom_json_rfc.
>>> The last 4 commits are the relevant ones.
>>>
>>> All the CMIS modules dump fields are implemented were sent to internal
>> review.
>>> Thanks,
>>> Danielle
>>
>> Thank you! I'll try it out on my machines.

