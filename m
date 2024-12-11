Return-Path: <netdev+bounces-151166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B11F79ED364
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 18:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5639E18835A5
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 17:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546FF1FECBA;
	Wed, 11 Dec 2024 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuSKulOu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E7D1DDC19
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733938088; cv=none; b=mWRguDld7QMUFj5FdCXej0sFq14XLIvzgby6eoWTrGGL7O10bTaw41Nfn2FUEQfq1gYCNsox69IO2AfGHtYEmvvu+FLbzuHipihbtdLk8J1vtT9nOZiuIdDalAehDAc2ztUO2aqL50VxVo/e9JinmREq6Gru4XNeDAk+bJX0ujI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733938088; c=relaxed/simple;
	bh=BwrYP4rZa8+6N/CHyImeXEUNeA9Q8Igv2STjvJlNv/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgxvjoPJckVP/RU1wAIM8U6F/EHAdGjswUGD2EfGeuRHutXafvD291556j+pBQcWDG6OPqNlNbWCmpekF6XGxLxC5X2KB8pk7jfiv+i6mt7zZ9//K4OgeT5+z5DZXqyL850SrkqitHl0DMEgASwWPjD5nDSWP/I1ldB3/nqijoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuSKulOu; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b1b224f6c6so737114085a.3
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 09:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733938086; x=1734542886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n2ztBYOKr6JK/9u6pjsQU2PxAy8Aj9EMyYBnyo7ShGg=;
        b=DuSKulOuknn4mCT+iOV7carOuw2JMoTaUDYi7JzOwXJgOeLVSj9xT6urHu77HqcXBC
         bMDB5d92cmp50D5fLT7URURPzNZ4dVNy/E4XzXDQtZas4iE/tixU5I/MryATgRF927Rk
         1UgNqFOtpDAno1PH8WVwfxWLOR/xBkcXKWiP9BzErjwh+mmaZQFnoi18sHgPrzcm+UEn
         hXd4e/+qrdEIZzLCVs1chhDISgbdZF6Rpk81woogwX86mj/dE3Vi5bd5WbqzMyIFlgCG
         O+nf6odUw6hoNNGKFXawEqojEdHDWuFg4fjOYbOHFU8iLJj9SMhdFunpv9rKz+3+acoj
         VFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733938086; x=1734542886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n2ztBYOKr6JK/9u6pjsQU2PxAy8Aj9EMyYBnyo7ShGg=;
        b=n3/6oMWCTeWlh+oo9vQ91yVti+tFh4iSVVvThos3f5hW0WeRXa+sq2H6F4orXLPpb9
         uy2+ITZEHBfjuGEh8UKxF2Dss+h3THgHZHD56DvCF9GPlk9YOLxJmHjFb6q6uy/EDK9W
         WVmmVRTOjbfetemfVcnRYA6jhdN92+6XwJjZ4F0GibNqobv051azLeov3b4jw3/Ozz6K
         eby1fgmsbjRQJm++3JTJCoQp4IhawG7J5c3qKT9nGrrBkJqzNyV5sDvKDlzfxgBG78dJ
         9Rsyifv4XQ/23kMwTRjzvhhJVzoCLp3tY0m/KHJKhRtoCAnYEBFtGfbUCwNXkQZ+U16A
         oFcg==
X-Gm-Message-State: AOJu0YwWhswAwhbUOEmmca0dv/s3n4yue4+sTRZ9svkDiYGBdIS1cXBw
	aJI9RCln7qT3jF8A/RVNouWGEWN9qBg5RHQA3uJGTXUS1S2LUFh3/3q1Hg==
X-Gm-Gg: ASbGnct3bBb6+n27k2DfDqbkKEFpPXaKrTLRRr0cFE3ai1gRcPjVgSlQ8q3xUT0ld8q
	FQ5egJouspt9vSiI0tOBqXb2x9d+dMkmDVRdHMQkQ+3uMqxpuXU+hzqFhAS65SjK8l6k95X+0+H
	gEaPjF9bYskd0s3w9cUI/kmg+7BEp/4fudaGXZl6+OTuHv2dCilM3WnGbKYzLjR4/kPcUrigRmR
	vOAmCFiIOEGbbMgpZJIeYMg6yZ/xJJlpIzhxTUNyWLcyB+GBJv5mvJiijO98DFfZkrVRw6NbCjb
	9JqfqFeq
X-Google-Smtp-Source: AGHT+IEmCWL/g6aQB3a9IwSgnNXT9NcxVF6HlIw+eOaebQCdo2p1NO/dbAyKy3CUpgG2pGEd49xTTg==
X-Received: by 2002:a05:620a:28d5:b0:7b6:d910:5b1a with SMTP id af79cd13be357-7b6f259353fmr13625485a.42.1733938085739;
        Wed, 11 Dec 2024 09:28:05 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1145:4:e156:2188:4a2:8ecb? ([2620:10d:c091:500::7:412e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6f11d3fe8sm23142485a.20.2024.12.11.09.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 09:28:05 -0800 (PST)
Message-ID: <02060f90-1520-4c17-9efe-8b701269f301@gmail.com>
Date: Wed, 11 Dec 2024 12:28:04 -0500
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
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <DM6PR12MB45169CD5A409D9B133EF3658D8292@DM6PR12MB4516.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/28/24 5:20 AM, Danielle Ratson wrote:
>>> I believe I will send a version about two weeks from now.


Is this time frame still looking good? If you push your work in progress 
patches to a public git repository, I can test on my machines, or write 
some code to help finish the implementation. I have a need for this 
feature, so I would like to help get patches out for review.


