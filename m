Return-Path: <netdev+bounces-53514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C888680377F
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 15:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73C3F1F21151
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 14:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2AF28364;
	Mon,  4 Dec 2023 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="O+uTqg/k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F582C1
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 06:50:27 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d048c171d6so27971685ad.1
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 06:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701701427; x=1702306227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=btpUEqWbcfNqu2hVQoYELh5QknSWZcTTeqNo3TCE8Bs=;
        b=O+uTqg/k+UoJlW+2urUzxvCnMV92t3/9FRg/toDH7SFjyAPsb9WXif+8VO4/+C941J
         irzhcLQ5jF/jzs1cqpKMuVTDqeUTZSQXcK/inSB0WqjE5f77yyc+OLEb4fB41QZhK2Eu
         d5lph9dIfTBv0FNCSqvaLRgMNGBrm4o7g6o4rEKZ5T3gNOK9aYg6SyV2orAf6baMAkmU
         PT49OBVnwImkBp/ESnynzSC6MJ+ZnQcuI65bAXmSPsTLz21fkRRB8Hx/xx8pJXOpFsmH
         GmlqiaqAFhz9KSK150qsPHDjz36DhhciadWJHLSvyTajDKeHdpJ8nJUTtQUZR4s9JfGu
         7mBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701701427; x=1702306227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btpUEqWbcfNqu2hVQoYELh5QknSWZcTTeqNo3TCE8Bs=;
        b=m0s9e8nBS503dX2E1ULTUJH9dIHsb6OechkB0pce8/A8VuygUZDBEEtsN1wsCYd+Ai
         +oAEykojv+mYvbxqek7u7rZQazOGYJoMg6jd9LjwdkDqxg0BvYMGpKR38Tw27IwQ3jaC
         Rf0PFfF79JuvJDAz0XRJh82fCqyl8WgOdPBZXCskxYxDX0EIgV+SEmtOSNePNrmMjHFA
         +iEq/xU3pIY+ZLnLRZuAKe2NCxEpWR5Os0OLJlGo18s2rAKHZIKqlnU8t9ocDSE+tCVI
         dJdpuMusOFaD9WEK15Q6hkCouZc1QCVsYFZvwTg5cg/4YQNNqGC4gOBLyS70+K9bhXrh
         +vVQ==
X-Gm-Message-State: AOJu0YyYy+hHJHIeQxqp8Av0TscpnaK/U2MaKMBMhWcpxpIOOPKuARp1
	EeCAYNcMUnU9b+eRU233Y1IG6jPMTW6L2ClXDK8=
X-Google-Smtp-Source: AGHT+IGK3ZdSTNJc5pk84MML1sN2+59hQmcqB9kiXlPeiErDftFNxxaTTzYBbHk7rVbBwqkcPKl51A==
X-Received: by 2002:a17:902:a585:b0:1d0:6ffd:9e38 with SMTP id az5-20020a170902a58500b001d06ffd9e38mr3957240plb.138.1701701426861;
        Mon, 04 Dec 2023 06:50:26 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id b11-20020a1709027e0b00b001bbb7af4963sm8667179plm.68.2023.12.04.06.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 06:50:26 -0800 (PST)
Message-ID: <f36d22d4-d21c-4f56-81e1-79cfce092f50@mojatatu.com>
Date: Mon, 4 Dec 2023 11:50:21 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] net/sched: add helper to check if a
 notification is needed
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, marcelo.leitner@gmail.com, vladbu@nvidia.com,
 Victor Nogueira <victor@mojatatu.com>
References: <20231201204314.220543-1-pctammela@mojatatu.com>
 <20231201204314.220543-3-pctammela@mojatatu.com>
 <20231202111812.0efcdd77@kernel.org>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20231202111812.0efcdd77@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/12/2023 16:18, Jakub Kicinski wrote:
>> +{
>> +	return (nlflags & NLM_F_ECHO) || rtnl_has_listeners(net, RTNLGRP_TC);
> 
> I think it'd be nice to have an rtnl_* helper which looks at the flags
> as well. With a proper kdoc. Maybe someone will notice that and remember
> to implement F_ECHO for their command?

Ack, will change this to a generic rtnl helper


