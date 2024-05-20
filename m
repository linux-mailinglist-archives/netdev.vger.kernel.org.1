Return-Path: <netdev+bounces-97221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5384D8CA14E
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 19:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD68281DAE
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 17:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7DA1384BC;
	Mon, 20 May 2024 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="3Wgca8wm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E846B1384A8
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716226026; cv=none; b=ckVIyC0SwoKhPNjQ2Np8LXWoEjX1x3UusVgjh+NiEdxeza+Pd62xE6ngchjuBmL2jIoJbIeCOVzeYkDAYL6SMKb0v1CumlUQ64WgbQEAO1ndwlLxJUcp1pB0iYZX5avF8S1/e90A6II/myG8s6om4ukcgiIGPBcv6D4aGoWa3r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716226026; c=relaxed/simple;
	bh=gJionPJ472/yk8wS2uPDB77ENhe05RuHWRUzcheWWUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1pDEJdgJjNAN9ul1R1+dUKNFdlZOjvaSlCGUcse4JlFLh347+nmpFQnFSdu3xLxs0g0FdRfgJl91WEpEtzFedfdb+Vque1gmKD4Po9cdEJse+tiD7FvP3GzOXZoteiIs7cjEWvfSPHE4aDuLtz1+VKUgOlM2oUtQy1grHBBVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=3Wgca8wm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f082d92864so82121215ad.1
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 10:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1716226024; x=1716830824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R3s300s+eRItiZsWIWpZ9cPe8WeTqKCXRM5Vucr8exE=;
        b=3Wgca8wmk7SQVUh3q2iSaWaZ3fJbBdIsmx2ipKQQvC4d+8UxB1ncvz3/gvSdopZkYR
         4tDqVvGTqyxykdIftC+HeKL6692CnzRm4OoIPcFJaIois6EAYLq4MGljueuqhH2MBvTm
         O2a1pzDfhxEjPB0loKCdXFArw9EOzrQZ+39gS/7DAj9ikmWYiOFispjO4I6xaP4LvxzA
         zL9RywQ3RQGmbRIacwtF2m3qyz+SZ9WRBoQUUxJMF0ttGDoRhxv+kd2TRLgzQ1FUP2jw
         RpTc0V551pi9B2gkwE4IflIdpTuSGMw0MEZjvxoJBixepEdY1QYvMbRl8StekN3eV4iY
         FZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716226024; x=1716830824;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3s300s+eRItiZsWIWpZ9cPe8WeTqKCXRM5Vucr8exE=;
        b=SdECrxjdloyH6P1q9a5gGfpivFsZv/7T+BaWtcW/COrqgzuNLF+Ul7lWtEN17ql3HB
         yVSQ/gpmFI37CQSFIafV8XW3qSyl9V+8ucXiVXIH4bvX8qFwWZHzHAkqpJYl5Nd6YHD2
         u1Kptm6241KvwCa5r1TOH48NcocQKR/ClbhZCFFRzlDPoWrVMrCnVg8a8Axeh08ESgtx
         JLNbsLsJjtXzdOYxm1qu6lnqDVsn5bUlR3hj1hXEy+7l++uBuEExyohhUoCt3HJu/YCq
         y1bsOiesGts85fr5ojLP4JHZvhZTw1KwoXe2AIgU+8qtfqNmgNEmVLn8Xmm4pIqbe4E2
         yA2A==
X-Gm-Message-State: AOJu0YwG8b6WIzNE0nsxl7ZLrmDFd0p8+Ej5DJF3C/0hKAnT91NNbBQf
	9EfyQR0j4670TJE7lvKCxDKEMLuVGgcEuQ7jGtVOJzN9KbXP2CZ+pJKTgrpLy14=
X-Google-Smtp-Source: AGHT+IFfScuKSWYT7LnaHkWdBwB74S/62Fylm0oGC7fkF0kh9NLQCJkPdFeDyIIgL69BZNLWfTwZow==
X-Received: by 2002:a17:902:8f94:b0:1e3:c610:597d with SMTP id d9443c01a7336-1ef44057ca0mr260527645ad.60.1716226024087;
        Mon, 20 May 2024 10:27:04 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:40a:5eb5:8916:33a4? ([2620:10d:c090:500::4:d4e8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2f46c28desm37860325ad.221.2024.05.20.10.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 10:27:03 -0700 (PDT)
Message-ID: <713182b5-5fda-48a7-8947-8dc3d10c42b1@davidwei.uk>
Date: Mon, 20 May 2024 10:27:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] gve: Add flow steering adminq commands
Content-Language: en-GB
To: Ziwei Xiao <ziweixiao@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, pkaligineedi@google.com,
 shailend@google.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
 hramamurthy@google.com, rushilg@google.com, jfraker@google.com,
 linux-kernel@vger.kernel.org
References: <20240507225945.1408516-1-ziweixiao@google.com>
 <20240507225945.1408516-5-ziweixiao@google.com>
 <a75ca51c-89b1-4f90-be52-e5fb71ca519a@davidwei.uk>
 <CAG-FcCPnrN8Wodn0+UYPJ4XpvDpVyhCzvGPx2CnDit8adwKYSg@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CAG-FcCPnrN8Wodn0+UYPJ4XpvDpVyhCzvGPx2CnDit8adwKYSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-05-09 17:18, Ziwei Xiao wrote:
> On Tue, May 7, 2024 at 11:24 PM David Wei <dw@davidwei.uk> wrote:
>>
>> On 2024-05-07 15:59, Ziwei Xiao wrote:

[...]

>>> +/* Flow-steering related definitions */
>>> +enum gve_adminq_flow_rule_cfg_opcode {
>>> +     GVE_RULE_ADD    = 0,
>>> +     GVE_RULE_DEL    = 1,
>>> +     GVE_RULE_RESET  = 2,
>>> +};
>>
>> Could these be more descriptive?
>>
> Could you be more specific on which needs to be improved? Is the enum
> name or the field name?

Sorry for the late response.

The enum field names. GVE_RULE_x is too sparse for me; what rule? To
match the rest of the file maybe something like GVE_FLOW_RULE_CFG_x.

