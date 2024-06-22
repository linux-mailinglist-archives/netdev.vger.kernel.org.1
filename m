Return-Path: <netdev+bounces-105842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D03B9131F7
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 06:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23FD2867E7
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 04:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347BC6AFAE;
	Sat, 22 Jun 2024 04:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9kPLP8e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EB95E093;
	Sat, 22 Jun 2024 04:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719031223; cv=none; b=an57czI7JtQ+53TmmYWTa8Pst9K4APrtEpY8boPoim5RJu8HlGT/oedmLNYlJgxsDnIzNYKEP8WLM7Rd4HPXQ0dVLkGmAw/jmqGa3L1jpXZYJ/JOX05af7oiNh6vxcWCXaIbDxYaJL1ZnSkj9S740Ix1+CHUTd7W/x26Te84LOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719031223; c=relaxed/simple;
	bh=35lPIAcl+pcqfcof5ywz9pzbSIwwh/OcPd7wfAdsxkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iahLxrhKyyFoh+JLfCYbvUoDDr7pB97ap4Yod3O8+KhkEXln3DoJCCleuDf8VGp59jb89OM6Fp/3jRVngghAe+JnQtQjyK++StNEidSt+zyNBLiZokoN96+u6P7LggOxAWDhiovBMnUaKO2kZAQlXlXYewfQhy7IxlV+XPXHjLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9kPLP8e; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7066463c841so336983b3a.1;
        Fri, 21 Jun 2024 21:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719031221; x=1719636021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cukKdkt4tFd+Q1wgdPSxE43mgLW9ldcQfOcQcI9wtyc=;
        b=B9kPLP8e+WE6GHIFSiHb4RkQuvEZ3uYkx0AZtRDp60R7jdMA62xPBBBBCI6orZurnK
         +53agDpA0CrGFIedZ4USW1QTc5LoteME5eVbSnSFoHaMDcDWZday8p3iwNM07LXIrJ2E
         3whsvpqqqLGjVnRki3RLywH34dXOj6Lzt6TJz+XNwXrSbphGPkpzbB5M6BSgLTriC3xZ
         KtYoT/yLYDsswokb78o7Xt2GKZvwRS3ti5DY9e7lg9xMSymAU2mQd7j6wRrExwuHRz9Z
         YLNswFIDFytZ9DjCOJlVVGBYRl5hGItkOY77ddOWTHNnbyN5Zmk5M2F0F94M3EWQqT4k
         hY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719031221; x=1719636021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cukKdkt4tFd+Q1wgdPSxE43mgLW9ldcQfOcQcI9wtyc=;
        b=kFZHQwznAdsr/BJ5+/cDilqBoJq9jx9BSXP2xAbyvTvkdGqJYQeQVjApFaqRPt39/I
         r3htycWBSzqF2KXzc+xqmD6GYWgxnHuYmisxhbuPqfXmb7HxG74kp3unY/KVuvHs3tfr
         C2Y1Ypjh9Uxu3+8NDWvVPYKlKCM+j1BdX3e4J+xK3dF+5ePaHxkXGtomC52r65yJWE6k
         kPkaWZqx5xbfBGLV0m9kcurno0aQ6l14wTrxcJUJvQtQoEeaGRSInQlcrCEyvtzSIiA7
         WTuAqJ70S+X47anDltdmOTm0MqwjZcYWtsCoOWOTgxj1Jv5GoqZQdCqITnqGjkAPzGQ/
         zPOg==
X-Forwarded-Encrypted: i=1; AJvYcCWB0fpZ08/NI5nncu2a4N0/c3d5hoeCqyH4d4G5nm3DFeiDyELL33hD1b1a3n2vULEeLr6OhtmKwGiTVAuvvaW9e2wW470TAzwh8tyNZ80/YXNwWRVzvspHU4trVPjK7RH5itDejfR7atABjVgpIEJjxoCy2aHaKy9q77WJIIf7cqi84orEhqPo
X-Gm-Message-State: AOJu0YziaiZC78tMj4GgrDu7ktNUVnbFybFVS2X8VfcJuO+AQ2VQq6Fv
	tHzy2jDcxxlShc47AHAAJ8GQ6btvyUHFOmpILhaXy4+BJoArCA0Y
X-Google-Smtp-Source: AGHT+IEOkOmeZGXSMZ71jSHndSpMWPeuFbLksWoSe5WdzNoeJi3Oa4TP58fPUoCbu/PdHGBN+IADNQ==
X-Received: by 2002:a62:6586:0:b0:706:29f3:1f03 with SMTP id d2e1a72fcca58-7064484f37cmr5938980b3a.20.1719031220892;
        Fri, 21 Jun 2024 21:40:20 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065e2c103bsm1235052b3a.92.2024.06.21.21.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 21:40:20 -0700 (PDT)
Message-ID: <d1889c3d-b910-4599-a666-ea9e1510e6cc@gmail.com>
Date: Sat, 22 Jun 2024 13:40:14 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/sched: Fixes: 51270d573a8d NULL ptr deref in
 perf_trace_qdisc_reset()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Takashi Iwai <tiwai@suse.de>, "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Taehee Yoo <ap420073@gmail.com>,
 Austin Kim <austindh.kim@gmail.com>, shjy180909@gmail.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 ppbuk5246@gmail.com, Yeoreum Yun <yeoreum.yun@arm.com>
References: <20240621162552.5078-4-yskelg@gmail.com>
 <20240621170546.0588eec5@kernel.org>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <20240621170546.0588eec5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jakub,

On 6/22/24 9:05 오전, Jakub Kicinski wrote:
> On Sat, 22 Jun 2024 01:25:54 +0900 yskelg@gmail.com wrote:
>> Subject: [PATCH net v2] net/sched: Fixes: 51270d573a8d NULL ptr deref in perf_trace_qdisc_reset()
> 
> the Fixes tag goes before your signoff, rather than as title.
> try
> 
>   git log --grep=Fixes

Oh, I'm sorry. I completely misunderstood. Thank you for kindly explaining!

I'll take your advice and send the next version of the patch!

Warm Regards,
Yunseong Kim

