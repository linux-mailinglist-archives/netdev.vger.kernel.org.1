Return-Path: <netdev+bounces-230049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7726BE3375
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 14:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D552A4F2E40
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A73931B105;
	Thu, 16 Oct 2025 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="gA4BMrC/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643D53191B7
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 12:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616209; cv=none; b=PK2cCalo3vGgd4HPnRTcpofXf+p51BfN89lpaAmVVbodj5yau3EN6PEpQKpIKXHJWsUGNM8Z2YsY2lsmQ5asmOH4YSvA2FpmA7GyK/EQ2aKTJeBi0R0+jqG2lX1lTqFOuYUwvnMsufg2d+wX3ZDzx7y8euodPU8GHd3D7LCxvs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616209; c=relaxed/simple;
	bh=61Qj9uCJtR3JxkogyQ1RYk9CMDifJBMJnDbLr3JUky8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxCrOhSRyNB9Zrb7TU5kAn1jdLbrr838Qo64kcnWFfGwuBSNLrsBZrkGaXzFzhE043MEH2AhVNGKFiib1H4UxBmZlR8mrkJDXFv9kcMZk9hYilHJjlGWiaQ4nkC3XI4+f3aq4nYaHbQq3ibcneGV3sVzHwQ0Zn67UwyWZGDLmnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=gA4BMrC/; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-780fc3b181aso399076b3a.2
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 05:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1760616207; x=1761221007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=koSWt/QmN5K1cGrpwGYApXeWaMdRUCWhX2Ee9Hoze3E=;
        b=gA4BMrC/1+leZz4mQFL24yj+F5l4DRvVlALrXCmsQm6RDjp2MnSQnSQeg0/ng1jQAR
         macLI+HwwvcQsUy14qir7cZnf9+VXmwle32F9t1cB2xd7RIR6MMYKNGST1QsGoeA+SNr
         p6SIx+WS9VoFSty3QfeB8AkJcIZgAhfrWDnHERLxpeYhU5V3Eize/DGVD0JAjnGBCzMW
         d7kmW4zAaA1xUE6GAOAHMCv4UnHSMTfsAcPmWKxKiwyuG14IWbnmgdWW5+LlMtbeHrWR
         f6+4rtdC0kQQxIKrcnCGcDHe6JHWK+KA5vE4kfqSUijuywOU4TUUzi7Gum36iI+GXiZX
         nGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760616207; x=1761221007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=koSWt/QmN5K1cGrpwGYApXeWaMdRUCWhX2Ee9Hoze3E=;
        b=OHqIVixWY0eHA+9h3JI6o6kgvhw5yTcXx+trBY8UZcbAVUJ1roTdQBdbVvqe4KSOUh
         BZlc5na3pVcnP4NT86nk+vFEvLTSeOViBgvurV9sJio3tgF0kd/J28y2SPxL/Ivh+waA
         5jYa+gx4eWA0OZAiz6LVp4R9QJu03/mQ+KKtHnqW/2/PsiYWKKzz5EEMI75WhTn3Jlo/
         3yCg4GmHyhdeP+gQZMQVtbcdublueoA80N/JE6voecj6XH3FmCjhCbojeIqVVEFX6403
         N9G0Y4/itaz9W+see/+EcrWfL9Fk6pOAJsKByRpClqDL9AP/TfyOKW01YgI6SMj6Czpd
         psKA==
X-Forwarded-Encrypted: i=1; AJvYcCXJxSpHQvoU26oUlwrcFxALcuoCH1aibG2TTW2NSmJrkkjfQIwifA9SYhVBgph35HMvl9Hpxz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc1fibJnVurhvA4vAUuRYUb0h0kgrFf+b2ZWGCj7ifJ70hPsMg
	/TNFRKSZ+a9xVfnQspUdqa2RhrsrqGok1MFQhDF9VC37H4S8toUo3CTe/Kg1c15F7w==
X-Gm-Gg: ASbGncs31LtFPPRar7AXhz0JnRiqjEdMFJnT5Uyc4ajD+X6xJy7G9mSk0lc4T9htGmB
	LwhRx2fmbC4pCYD/lDg/gnYDdYvSP95CrRmA1L/plajIF2IKXuQlG6Ax9DJPuUVhSry9FOLGfg/
	8p20rW+3FqGxm2p9UFLQQDOuMZ2t8gI+Et0GBO1TG79XP5xMCTylGmhksD1/alBGVYi9XdLUAhZ
	j+JGEbc8DTv8ZTLFOuEKe7pVDfc2DiSXCloZi4F/1VUqhVHlGsAfHMI3zNzXw99/OrDvNVt9IbN
	BXMuQL7xL+vE3A5rxXmrToz8qn4T0m9qOGVqv1ECy6Q9oPbADwItfEG7pbvqQ43wHtJqcgwjhqi
	rXQtHHWPjXTwCrmtqPPvzWzHCy+NCU2lP1phY+UT5c+c+S4Mts6lh33BEKjdT4pH3AWZAIfLxb4
	dfKImgwcvQ2w==
X-Google-Smtp-Source: AGHT+IHhjucv5zxQDNT796WcRM+awmc6hwdDH2TqQunpsrrxBUF+mUylZScphcshKBYMdzFUoUH3OA==
X-Received: by 2002:a05:6a20:a10f:b0:306:51fd:553e with SMTP id adf61e73a8af0-32da8122a79mr41598723637.18.1760616207429;
        Thu, 16 Oct 2025 05:03:27 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c54:4efb::1c9d? ([2804:14d:5c54:4efb::1c9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d09ace5sm22229023b3a.53.2025.10.16.05.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 05:03:26 -0700 (PDT)
Message-ID: <a104dec4-9f53-4126-ab88-f722248f7e2b@mojatatu.com>
Date: Thu, 16 Oct 2025 09:03:20 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 4/6] Revert "net/sched: Fix mirred deadlock on
 device recursion"
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20251014171907.3554413-1-edumazet@google.com>
 <20251014171907.3554413-5-edumazet@google.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20251014171907.3554413-5-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/10/2025 14:19, Eric Dumazet wrote:
> This reverts commits 0f022d32c3eca477fbf79a205243a6123ed0fe11
> and 44180feaccf266d9b0b28cc4ceaac019817deb5c.
> 
> Prior patch in this series implemented loop detection
> in act_mirred, we can remove q->owner to save some cycles
> in the fast path.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

