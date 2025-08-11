Return-Path: <netdev+bounces-212461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E59EB20ACD
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 15:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDC247A56BE
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 13:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392182367C3;
	Mon, 11 Aug 2025 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Y8DKXBJL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8357221504E
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920336; cv=none; b=GO5s1Q2mEWoT06h7D8YTpu13pCQr4lG5OYR8QI8Pp6RPCAU60tQe7Vl7673bf6m7e6n7Kolyb31yI3TKyHlZJIOaqUXpBnlMxwyiyZa/X0OMQbpnbsP4Gh564C1iH1pXxoDUy09agjYz34rMGqnV5/GFOTfuETxQUMA0ZmNRKT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920336; c=relaxed/simple;
	bh=5c0WB1RzFFmzbOp/NABg1wswKvFL35sxwt9YjE4qHNU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eRFwt2yZOuaoH49TZXlaqqhTNGNVnaBfTfFq59iv6TafjGF217BNIiiGs2rGbfZAYKindTG4ByntKlmixV4d08zvMJ/eaX7OjhiTRqeeDBhzkI5eIzhFEBpyTedRG+iPy9UytDyglbcCvv9mjv79pUtpz5YWC9A+Oz42ROE/2qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Y8DKXBJL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24041a39005so27573395ad.2
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 06:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1754920334; x=1755525134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZN2vVD8bu9LjGGLEp4YnRLfmphfRufPa600jGJm/zQo=;
        b=Y8DKXBJLC6nPQCd2JbM9VNL5Z7LQD96+PUoox1A5T0Gspe9veOCR7SJ2aC655FSk2B
         O+I9Ivt4NnIjlPfkpCP2yf4i2pS8/WcO0RmovGucOxfcC+jU4QKnuyfpEEhcOSJoVwrE
         yh7uG/+5/Ish/HfHzyGjGU+BKdhUeW5u9mBdKHrYHIWSwgN1eBbFCEnq6j7U3oF37AQn
         njcj3gk2nrZMigO3pp9MsAsMvqA0c5i4EN9x/VJhITTTbp9yVklgsIkRuungfQPtJ7N/
         aUK2byfTWkNfBs64LZ28gBrr5Vi16NrSwNoNOo+lGdBat+4h+J8s8dUwaDgr4RngYSZO
         ebkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920334; x=1755525134;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZN2vVD8bu9LjGGLEp4YnRLfmphfRufPa600jGJm/zQo=;
        b=CC63oH9/zQ5XrWQy4ZFoY9EYN8jBgB2V3al92suYJB0JY4pdwjB2LIiMYZ8lUJq/eX
         A5DdtWAvjePyjUe34z1xUYaDjEtEJloNiTR9nM3IxZQQaHFqiB9jdV7cZfNeQ5KHSfCb
         XpXVms9M83n40fLfOG/Q52u7R7X8hcW+YlwV1xjOHVMYts3Tjir5p9ne5yG/ho9rsCri
         0mtfm0EwdUcHLAuohjFLbkb79gkgWi1dNDBHst/Pz5XIvxr12oJ0/wUy+jo8b/Khva+c
         /aE3jFBZ+NOARkPyv2f0/GEEhu2OOMlhvIKNTRLeo3dY7rc7MG/pFWGZAUrTBj/pUApc
         MaXw==
X-Forwarded-Encrypted: i=1; AJvYcCUa+ULUpZDO94K5Vbmj5vFQhrmYwjAgHor4QGsMqCGF0vVs3i5K9sCmE2aujjX7fa8a7KFDqkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcUfvdanAv9/LjrVHlQikMzdM8cp7etOtt2rhLcqza4V7w4D2m
	Mjpk0ZyFzl5B4JB+d/yBGGjczwX94AbqrM4F/4PjBcm0OjIpyW6XajAhSAf2iO0kSQ==
X-Gm-Gg: ASbGncsRo10qX/teKIWlVhXqhX+cvF3IQwrT/xMOX4femIeeBs1tQKZP4n2fDK9qOz3
	7rMtx/735/1An09sYKwx3evhfkuL3jwkw8eVbeQ6qfqgqs6/WPARfmFbnk1ZizkXDJ+hqmDAEZ4
	s0EbIh7D2GKbZ/3CevwEFFd2CkqiMyTgUNd8CmRoF9rQNSdznyccxRVO6tfzMjQ2z4vvPRNaQzm
	8xYhju521MuuBfEJ2WgEV4Kz8zN4aHhYIcuBACDtbz6qKYolBEKu6gFzJbOZhK2+QvWHHa3YN2Z
	BPH/n8XDjFOl9tJ9qT2O6OeerpcDAXmAO/elwG8zIjP5nS0QqIvVUWpTTb95erzMBPv2y4y0mJ2
	n1yvIYl9UnZw2Vj79FikV2q3ygumjojTbxfhz0/SQoWa6tWTb+AhJ3+MdGXt/hm9wcGS5
X-Google-Smtp-Source: AGHT+IHaYMtibJuemzdjomSN0kWU+dOFQ3GsA9o3OEpvWT5jx6bZkj94PR0Evh72tx4vQEmQjFstKQ==
X-Received: by 2002:a17:902:ce83:b0:240:887c:7b95 with SMTP id d9443c01a7336-242c1ecb835mr166135365ad.5.1754920333623;
        Mon, 11 Aug 2025 06:52:13 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:a11c:ddd8:43e3:ca5c:f6ea? ([2804:7f1:e2c3:a11c:ddd8:43e3:ca5c:f6ea])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aa404dsm274378565ad.148.2025.08.11.06.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 06:52:13 -0700 (PDT)
Message-ID: <c3ffa213-ba09-47ce-9b9b-5d8a4bac9d71@mojatatu.com>
Date: Mon, 11 Aug 2025 10:52:08 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/sched: ets: use old 'nbands' while purging unused
 classes
From: Victor Nogueira <victor@mojatatu.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Lion Ackermann <nnamrec@gmail.com>,
 Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org,
 Ivan Vecera <ivecera@redhat.com>, Li Shuang <shuali@redhat.com>
References: <f3b9bacc73145f265c19ab80785933da5b7cbdec.1754581577.git.dcaratti@redhat.com>
 <8d76538b-678f-4a98-9308-d7209b5ebee9@mojatatu.com>
 <aJmge28EVB0jKOLF@dcaratti.users.ipa.redhat.com>
 <81bd4809-b268-42a2-af34-03087f7ff329@mojatatu.com>
Content-Language: en-US
In-Reply-To: <81bd4809-b268-42a2-af34-03087f7ff329@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/25 06:53, Victor Nogueira wrote:
> On 8/11/25 04:49, Davide Caratti wrote:
>> Maybe it's better to extend sch_ets.sh from net/forwarding instead?
>> If so, I can follow-up on net-next with a patch that adds a new
>> test-case that includes the 3-lines in [1] - while this patch can go
>> as-is in 'net' (and eventually in stable). In alternative, I can
>> investigate on TDC adding "sch_plug" to the qdisc tree in a way
>> that DWRR never deplete, and the crash would then happen with 
>> "verifyCmd".
>>
>> WDYT?
> 
> That works for me as well.

Sorry, should've been more specific.
I meant that the net/forwarding approach you suggested
seems ok. The tdc approach would be a lot of work and
I don't believe it's worth it.

cheers,
Victor

