Return-Path: <netdev+bounces-162505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87625A271CF
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 140DB1640E7
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 12:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E936E20DD79;
	Tue,  4 Feb 2025 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpf4dkAg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E46420DD5D
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738672166; cv=none; b=MYdEJnXGcrz14NFYvxy28+GcOhOQ2Q5LXkfwff5FeK/5RnV/PAAp9Gxds1NRiotWkPl3vXgkqEeB5nJWjfzn8qkqicCFdE9D04rPm4SIcpYpdsNbOq3R3hteNNqEsUhtA53PS808WLC+clgm4xkOs2urHkCQASMHneeC6m/kTj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738672166; c=relaxed/simple;
	bh=u6K1gc6fqbQ9CyQmR1XZtEDc+/599QHfU81+5JM+XJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhunIFrmbg62xND0vptJW89LqvKvTJF8ZVL+yuxKFGPYNSnot9Q0X0/UbUNjLVjVvbj2KtTkepMWkvrDximyKPb21L941ZjWNaFwjTwlfb3tlg1HyyNb+x392F3eeIZYUn0SotYr0nWbWjQ1L0Gw0ruxq7Lh+KldgzrWfHF92Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gpf4dkAg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738672164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVt11t4VdzXmaGrVYonLKU4tNbyq45g4LumiKNuZLV8=;
	b=gpf4dkAgfZJjGroqrLhLo3yFumiFQAk31z5ESXLMhDdRsT+lQuGavqltxlpN/7zOUmC8nh
	aTwS84LAU+1deAaNSOI9AuQ2yVC1ACrk8zt+e2NXiwMKgha1x6qno/cGPZp+dWxl/+QdRm
	nlNcTk6Bf1bHEzcw+QtC4YaaxFYDY2o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-aKzzkNhlPnm-dT5-EBA7SA-1; Tue, 04 Feb 2025 07:29:22 -0500
X-MC-Unique: aKzzkNhlPnm-dT5-EBA7SA-1
X-Mimecast-MFC-AGG-ID: aKzzkNhlPnm-dT5-EBA7SA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-438da39bb69so39078415e9.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 04:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738672161; x=1739276961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVt11t4VdzXmaGrVYonLKU4tNbyq45g4LumiKNuZLV8=;
        b=sFjZz3eacwVKh+NlZrhAn854zeCHPwcw+Mh444tvI9VWJ2ZLNKtKhj4rt6XHVWcXQL
         MH103Qn9QjUe4bh6jSRp/s63iJOHc6cNocUayltI14pD65aimd5rI7jA1EvnrnqQMSp6
         UKo8nhO2uj11Mke/QA1ZUQF1F61+MA22eEvlH+CWlXM+3gkcwRLvgBhkNnU6NbggOMCd
         PSAm+0HaBW6svyEgavN2DRLoEPAl1T76ZAVBTox+yD6inih4ieh1qGP21Mbts7AAcqUi
         vG01Ri4iYhajRnrE+BiLMFSEiYwdehM11OwvfXiTY9Ce3semyVoUDj+rA0SpmU6GinCx
         iWog==
X-Forwarded-Encrypted: i=1; AJvYcCW9wHQ9mZE6cWJjjK5ZeUMTZkN6mmtj4hoQXaPglZC1VKPq4F5ZHDn++NjAn0IHWbh4Tte2Uho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr1gXzylmwoI1GprYO0HU9FtnebWnMTnsb11qBrFOqda8SEY0n
	MGadjJKcRB3zjbRIpKkP0ggBCQuMt/GbUW8Vs2Ahzohq9cGjFJykafg14wG7ouhQVPuc5zt55l1
	CZLL4vL0DU9KxUCMwiyfKF5TDRlffQDEkLD6eSPHa6EpCe4V7MWStzg==
X-Gm-Gg: ASbGncuB5YPZ/oOzvgFC9AdCZUjBKe12qx3bLycpRzND29kRV+FhpKGWiqosOD84B1N
	m2OapW2zPtHkQlzSRGD8xm1XvWLgmzFhf5KV0l5DuYq6dgVwQ49jCTBTYaSERxlXV/RCi+uToTs
	LkH2jdH9SvvUq2xygBx2O2iTF5hdup+mDfAbmfRPC4f4H0fiiwgTB22USMwHWJp4byPYiMHL+Is
	cg1YqP3S9R5iw7BFkwdlI/nosF7JIy3lgVmxs4cfakTj45s1Tag6OheHSdLQUAbS5A86KO+C3AB
	iM6Xa8pnOvPqecoL9zW7YDo+HaC0A+OwDQo=
X-Received: by 2002:a05:600c:5248:b0:435:32e:8270 with SMTP id 5b1f17b1804b1-438dc3cac3cmr242156305e9.14.1738672161577;
        Tue, 04 Feb 2025 04:29:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6sf3mUWx9f6oCktAawZ1NkGZse1Cb+QiEWr0dnqS8PjvhkiCOef50Jj0CTOWCanLTCjNSYQ==
X-Received: by 2002:a05:600c:5248:b0:435:32e:8270 with SMTP id 5b1f17b1804b1-438dc3cac3cmr242156005e9.14.1738672161191;
        Tue, 04 Feb 2025 04:29:21 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc8a59dsm228847985e9.40.2025.02.04.04.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 04:29:20 -0800 (PST)
Message-ID: <c8dd0458-b0a9-4342-a022-487e73542381@redhat.com>
Date: Tue, 4 Feb 2025 13:29:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/6] selftests: ncdevmem: Implement devmem TCP
 TX
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kselftest@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk,
 Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>,
 Pedro Tammela <pctammela@mojatatu.com>,
 Samiullah Khawaja <skhawaja@google.com>
References: <20250203223916.1064540-1-almasrymina@google.com>
 <20250203223916.1064540-3-almasrymina@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250203223916.1064540-3-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/25 11:39 PM, Mina Almasry wrote:
> Add support for devmem TX in ncdevmem.
> 
> This is a combination of the ncdevmem from the devmem TCP series RFCv1
> which included the TX path, and work by Stan to include the netlink API
> and refactored on top of his generic memory_provider support.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Usually the self-tests are included towards the end of the series, to
help reviewers building-up on previous patches knowledge.

>  .../selftests/drivers/net/hw/ncdevmem.c       | 300 +++++++++++++++++-
>  1 file changed, 289 insertions(+), 11 deletions(-)

Why devmem.py is not touched? AFAICS the test currently run ncdevmem
only in server (rx) mode, so the tx path is not actually exercised ?!?

/P


