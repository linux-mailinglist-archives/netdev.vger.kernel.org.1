Return-Path: <netdev+bounces-214671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0891BB2AD2A
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 17:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D785C624A86
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 15:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B1B2C15A3;
	Mon, 18 Aug 2025 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XF4hqpm1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ABF25333F
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531693; cv=none; b=ici4qgKcHVubd9CwG84inX9UinK07BuiXxP96AHLGonNkykYP/G0PVRY8s5mP0URGVWnxqDCT9w0a7mweV3+85QQi7QsVgjbf5rJRf0TCIKyicP8foU15FXfLmB3S9+DrG1I3S+rsNX7L0pQxveXH97U8TVapXwhBUD5dy57rgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531693; c=relaxed/simple;
	bh=SM65S0fIjQgcwfWx9Dr6lpsIEC8fZdjVUs1KLxleLMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WyR7pWiTJqDLEmETMaVg2tKG4LhVo2Km+DFeE7wM1UjDt09zqcQR17MPVmGWVSzGkRNMqMCQ9v2cbRBqotRvBtOMn+xQFxfGpLO3ILgkuXnUR2TWuWf2ecW7Jmcm8c7l/JBifsx/0QGpGiEktvN7NXX7+wwnpgBdaZ41emNkodw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XF4hqpm1; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e570045e05so40068315ab.2
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 08:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755531691; x=1756136491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SM65S0fIjQgcwfWx9Dr6lpsIEC8fZdjVUs1KLxleLMA=;
        b=XF4hqpm1tFSI0TU1x7Sz3INU2bkhr+xN4wE+/AQiQhUJLquX2nRr+VrOf0R2QDMuOb
         123KND0/+oNdE5J9qlTNP8j/cL/6xZdwZQDXyhZ8bs5qBqGxb5SvpVUJgKV41gYXtQAm
         xAKf5r3/F3KMlSCiuZoufmUDfI7llwy12/VfwRknvK2ipSfiQ+uernDHAtdrS0YY4aiW
         HAE/mx9KA1Ipeso/ljK4rrp9hCgFMfWUQHk52vRczBgMZy7abLpPhcjx488wMJeFz/7D
         zhGlLktxGxziHVtQ9El4FYcGSz6cLvf19U5vI0yOlhsFbhERp9IIbrULm/IjdjM0pLcu
         alHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755531691; x=1756136491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SM65S0fIjQgcwfWx9Dr6lpsIEC8fZdjVUs1KLxleLMA=;
        b=HKE3W1p2SW+wqKghkC4ugL/ugIYkLoFPKd81U1rug80Xl/H5+jgLHkvv5xVYyDLD8n
         8dcH6L/0cIA7WW/2LvVdmoJUYCOl8aHI3BQJYxExVglpWIVNndJ01aUU0QJ8v3C9p6My
         2YXVbG45YGAmMSNjmB4vzBRQiG5a/dQVtlBJBdOw7dFPApocha/Ku4/Zcx4XSAUELI2Z
         rblBWvclefL6QwRjTwjt2BQf8eTuc3GhAurqOF0Xg4H9Pfz4s/3927tgYCP7kBIbU/Dx
         Ri3y7AXIvQPjxRP6cUB1AcUUqVockehYArG0WkBJMq4/fY2PHDxQS29ho++WtLUQmAPU
         ZGFg==
X-Forwarded-Encrypted: i=1; AJvYcCXrRAo8wAgXM2a4BIfoDWr9y1V80lX+HyWSb9pjx+Rz8uOihnYFDoNr3ylVnby9896PTLHl1kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG9AIFhmi5ItHQ8FYy0bMa3PMKW5lT2rfXT/NP3Ew+VQY2ka5t
	UiwXeECrm4E5dk9wKhYPNGlKS5sO/YevTwR/hg722oxu696dOdIaQ9Ud
X-Gm-Gg: ASbGncv8SMOa2LrSjzcqMQkels8Ifl43OezaI7shTpDMXovz+V8D4h0KCzbUw5rn75i
	QjklOL2bXKJQYEIcSKli+l+7Mi6o/R9yuYCrXWO8UzKqFzuc8/J65f4XhLfYGh93Fo3mMJPEdrw
	6JprRunf6ogcXSs9oE0dzeBRAtY6bXpBAqFPfNeLruqEt6Py6XGnMjvd+UA9YbfkHTkR8VP3l6p
	1VXbuNtJ1I8oNq1Nc9uJr8xZOIEn7S4+s3yQsInNGAz8g+nxDBmvq5Co9jEFhmy9pOWqYZujX+F
	xIWODTBK5IzJp3yirxJX5JE533IEVKEpwONBtT7q/0q+bJBsBc8nHo/AExOWXPrL4QbE8kHKsvy
	jAmfA0qk2GBObkLDHrASiAbVTMjdk2q/jUjklU27C1QZ7TzEyT/YATAfSZRdCravHyrXyC5ol45
	FqLCwpjJHr
X-Google-Smtp-Source: AGHT+IGPa23ZlE7VFrFMtEfOICtt8ioOwrczGlV6m2SIJk2fiHRl4ZfHreH7dmizB5IiFOTWPBAMkw==
X-Received: by 2002:a05:6e02:1545:b0:3e5:262b:8303 with SMTP id e9e14a558f8ab-3e57e9cb9d3mr241333815ab.20.1755531691112;
        Mon, 18 Aug 2025 08:41:31 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:e053:c52e:48c1:18df? ([2601:282:1e02:1040:e053:c52e:48c1:18df])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-50c949f6bebsm2634397173.71.2025.08.18.08.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 08:41:30 -0700 (PDT)
Message-ID: <31e038a1-5a17-4c13-bf37-d07cbccd7056@gmail.com>
Date: Mon, 18 Aug 2025 09:41:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v3] iproute2: Add 'netshaper' command to 'ip
 link' for netdev shaping
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
 netdev@vger.kernel.org, haiyangz@microsoft.com,
 shradhagupta@linux.microsoft.com, ssengar@microsoft.com,
 dipayanroy@microsoft.com, ernis@microsoft.com
References: <1754895902-8790-1-git-send-email-ernis@linux.microsoft.com>
 <20250816155510.03a99223@hermes.local> <20250818083612.68a3c137@kernel.org>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20250818083612.68a3c137@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 9:36 AM, Jakub Kicinski wrote:
> Somewhat related -- what's your take on integrating / vendoring in YNL?

I feel like this has been brought up a few times.

Is there a specific proposal or any patches to review?

