Return-Path: <netdev+bounces-102437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBEB902F2C
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 05:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7E61C21884
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 03:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DB115B0E2;
	Tue, 11 Jun 2024 03:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="W15sL+Fv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486B713DDCC
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 03:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718077318; cv=none; b=PIzAe3hxA/19XCgTJgBxsKbCrwlmm8baC4NGYCn5C7SU+JrC5IAIdILVyAcbIGY5xxLl9QjTQUs6JdbFa6V/PLzodKx6hZOSaxUZ+1FnS2L+jWIkX/tEFJQwRznjQfu5ukxvcT/1SurGGviaD2uuFUaZAHlWk8gbjgqy1mCE6LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718077318; c=relaxed/simple;
	bh=I3khNMZl0PkFJuuLwfTuDhBvGbiX2BGXToOqxq+Ds+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJw8iL1M+9zb+nqDk5S5bJBMF1HJCzsDcSAXIbqWvYvc7smF1TTYtK+/QScxuyACh17bEoHu0U+hfnHifzpeCmgg5I7UGXoUN8gH3fHmB6svOiicclYelLOsc7aJcamrawUyu6nelraS/Q/b3iWMXUaNeBXjmPhNmA82IiLolso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=W15sL+Fv; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c9c36db8eeso335624b6e.0
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 20:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1718077316; x=1718682116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=davzP0Io6xjz5I0QRv8FQB5a/+nQ+OD/Q8iXxEw30n4=;
        b=W15sL+Fvv/mPnLnMagl7AjWx0jYw/kwqoXCwowWqBDHXZbThN3i8jwwds+7PcjehFK
         4cWLdzI2e/zHFrhMHCb/R+vluSHY3Hk/7UzwFZa8Ue5wgb1dVhHhRbAFpY20jI0mtoeB
         7BgkMnZefeoQGvkkpvFS0w2c3y14zhQuWuBDBDhei/wb+WlpJw/Dpp5TfivYGodPra32
         Ya07ZI2LhTdWl8izopOw3Jny9dQ5Y07VS+M1Szvw5IUxQnNXPe5CnKr8mvc/4N2iuH3a
         IiMOkfBLju50xx62BYunJ43MBZaNSt2/dLPrFi4AlYNWezFTPokEwUnsZSc5M0J3daSo
         xZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718077316; x=1718682116;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=davzP0Io6xjz5I0QRv8FQB5a/+nQ+OD/Q8iXxEw30n4=;
        b=F39vuvLSWWFHkFBf2+zJhrpKkd7mZXY8lBGCx/wpFBLvYvuD1Ho9VWBFxqUsHwTUs6
         5dRttwRXkSQV5oFrS/Mky2y7fbpesOQEsaBexNgG84gLI2T+J3AUx8uMFsT8FpeDP+KK
         JV0kNQFe3WWPha0lhyeHV1s2lCWX3M8Sevr/DkoDBsNvwyt5QsI6f1O+s+Ul/qcikGbO
         CyXYHAFRlV3BTz3+XL5A7Rp/an2w5ye0Rl14A+zu/u3SgX4xnN2nnuj1qGD/wnya6eME
         9EMShxAaWGpWwJ8T+npwA+HcAP61KfD7p43pW95bYWNxaTofS4C2TKgBUsZjy8OvDMHs
         Qemw==
X-Forwarded-Encrypted: i=1; AJvYcCWb4fLoIpY90jtMn8Iz4UIc4jiZ5FOlOid80EEIM707ulmo45HQk6tPS8PUtz65+YIj/4B84MNSpUmyuPZOWdSj57wPj0Zz
X-Gm-Message-State: AOJu0Yw8j8bcz8A7x5xu5BJPtUdttS4uH8zjNoDITlcvHPo2EEN6vHge
	s9j37a1koGOunEiZr37LQhjhJmHi4nTVlYvjBhuCH9r1Uaec7pql7x85dJDNKiA=
X-Google-Smtp-Source: AGHT+IG4vNtXaZ+drWQUjdBm1Z1V1fyaDNRu6oQ5ta/ksA+uT/jERiptBOrKbIjMWZv1XIthwtIrhg==
X-Received: by 2002:a05:6808:ecd:b0:3d2:1db1:3e7f with SMTP id 5614622812f47-3d21db143c5mr10897878b6e.0.1718077316254;
        Mon, 10 Jun 2024 20:41:56 -0700 (PDT)
Received: from [192.168.1.8] (174-21-189-109.tukw.qwest.net. [174.21.189.109])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-704134b3ef6sm6005983b3a.50.2024.06.10.20.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 20:41:55 -0700 (PDT)
Message-ID: <b2dadafd-48c3-4598-bee5-a088ae5a4bc7@davidwei.uk>
Date: Mon, 10 Jun 2024 20:41:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 0/3] bnxt_en: implement netdev_queue_mgmt_ops
Content-Language: en-GB
To: David Ahern <dsahern@kernel.org>, Michael Chan
 <michael.chan@broadcom.com>, Andy Gospodarek
 <andrew.gospodarek@broadcom.com>,
 Adrian Alvarado <adrian.alvarado@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240611023324.1485426-1-dw@davidwei.uk>
 <e6617dc1-6b34-49f7-8637-f3b150318ae3@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <e6617dc1-6b34-49f7-8637-f3b150318ae3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-10 19:40, David Ahern wrote:
> On 6/10/24 8:33 PM, David Wei wrote:
>> Implement netdev_queue_mgmt_ops for bnxt added in [1]. This will be used
>> in the io_uring ZC Rx patchset to configure queues with a custom page
>> pool w/ a special memory provider for zero copy support.
>>
> 
> 
> I do not see it explicitly called out, so asking here: does this change
> enable / require header split if using memory from this "special memory
> provider"?

This patchset is orthogonal to header split and page pool memory
providers. It implements netdev_queue_mgmt_ops which enables dynamically
resetting a single Rx queue without needing a full device close/open,
and pre-allocates queue descriptor memory _before_ stopping the queue to
minimise downtime. It shows that, with FW support and carefully written
code, it is possible for drivers to move away from doing full resets on
changes.

My first intent is to use it for reconfiguring an Rx queue with a
different page pool, but that isn't the only purpose. For example, it
opens up the possibility of dynamically creating queues that share a
single napi instance.

