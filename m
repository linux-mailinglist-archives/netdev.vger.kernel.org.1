Return-Path: <netdev+bounces-162670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A508A27923
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 18:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEF8A1887F14
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E3521764E;
	Tue,  4 Feb 2025 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ey8mhd/p"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8928C216603
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 17:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691791; cv=none; b=DBKBgUfo44ewF2DZaEAllBMdJ/MAhM/PiLj47+MVzXbCmqvtCEjvFJrUyPN2clqR33qvC6Cv+Nav9XCYD+EKCTif2lxfPSW5hvNBG+f4N+Q7KCFQ28xpfsb4GvwRCo8Qxb1tLCaqGoR7Uf4kl6j3PZdEWMtlIPVr10/PzadNl54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691791; c=relaxed/simple;
	bh=m670b6vZ0EmsoJkmownLJxz8JU2YptA7G45HSbgfDp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wx4qYJTzudgXlmzsIUn7iSqmhSkjQJqppS7jMqNsfLMyV0iEA/+veP8L3OJznyFRlRveVdGAhY2ajMVF/JVEX4ulbgQoKlzjgif1YCi7/Ze4INb7pmKXH8s1UwVQWeev6xE+o3ysJv1MyyMt+MvfRi06hfT4MY0XCYkjKTF+PT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ey8mhd/p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738691788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y7rTv22+08/qF0nM+ECThVkoy0LVlXk9luYfrRe54qs=;
	b=ey8mhd/pYZA6DoNO4vZ54Y9nUxbUHyxdeNonzRQUgrCq5R6+bVyCR8VEQgzIOTgs3E4RRM
	A75/QZoG0qfU0kH8rWMVUopIP3ZRa8HeSF8jz5dq3ylkGNceyLJo7XmC/fVeG/InbD63jZ
	GsWuG8VEu4R6ryBXMNccsiNs5C90DRg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-E4RPyZkqMbq2JZMEDSQdWQ-1; Tue, 04 Feb 2025 12:56:26 -0500
X-MC-Unique: E4RPyZkqMbq2JZMEDSQdWQ-1
X-Mimecast-MFC-AGG-ID: E4RPyZkqMbq2JZMEDSQdWQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361f371908so42306035e9.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 09:56:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738691785; x=1739296585;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7rTv22+08/qF0nM+ECThVkoy0LVlXk9luYfrRe54qs=;
        b=oDJEcHVXHT6dPYHtWkNmhc+sxa8P8nPMfRr9c4Mt3WY9/zClhp+oucJ7YomajHJAN5
         8nMr9r7KyTe5aBJeyw0hS5uAJm9D7GSfWn2sujwX1BWviLwNwSPuvC7nMigjUmQdUU+C
         7USEvpJUirrrAbvGDy7ijAJivrtuGiqeRNLoAMoWnx8TlR3LLzafaP/EXkF4OjcDGF2/
         c8ufwaN12v8WIuBmYouWseKnR1lDRn8XW9Q9UZmO8rRBqEPiYCuQ9m71yjaCw+4bE0xE
         cy6KMW9lKZ3q4mc5Rj1GEHSKs4JyzBV3SiTE34EUrhUBZvBDiE7UKnu5x3H9fM5L4pEB
         oixg==
X-Gm-Message-State: AOJu0YyIUmg/Cu+UvwIuRUZ6c65bVz+Fidv5czU3lPvIPZG8oINIUEiE
	l7MJQPO5ytJ7Dvhn0Q+m5Y2vU/S5Nd7GCHSDggVBIYVJVzMA8vL0dhh/zDDbDsOtNTC48TtVvJA
	hCc1YkMpqYXgHrPBnlg6sxl9TQqnGMdUDr5tblnJI4TWwC1ULg3lwjg==
X-Gm-Gg: ASbGncu+qiuS5kwkmFQed3ax8Reel0jgilcYSseXlsBUJOxyXpjcHxbJVq8aL8D7H0H
	Zercd/Q1li3azDrsBiS6s/CbO3San5XbiOmbgU3xTjPbNEPspB92O3BCfvryrYxBhUMe+MMBswu
	R8koRvAF1jMTTS4qyjJHgko5Q8fxUH7HusysegwTC+M7x7eLfwpq3AfcRpLUFAU58tsZUXzpke2
	i6x7d2SL5V2WinbdHa0avNJGzgNO7EPKxkBJrqEE0StAeO5uoxJ3fQrbR8eJ6r/eBzphKmJPh/8
	3KRWKhv1rPFC8a8FMgAq12LmmMczr/+aaoo=
X-Received: by 2002:a7b:c347:0:b0:436:6460:e680 with SMTP id 5b1f17b1804b1-438dc3cc9e6mr253181015e9.16.1738691785273;
        Tue, 04 Feb 2025 09:56:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCE1OD75AvFxX4Ocn0Vn8riU+bmAUBASRVK771tFjkbz9SV1IT6+srLah/Dv8CbvHWMOv8og==
X-Received: by 2002:a7b:c347:0:b0:436:6460:e680 with SMTP id 5b1f17b1804b1-438dc3cc9e6mr253180785e9.16.1738691784822;
        Tue, 04 Feb 2025 09:56:24 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e245efbcsm193857215e9.33.2025.02.04.09.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 09:56:24 -0800 (PST)
Message-ID: <71336d4e-6a75-4166-9834-7de310df357e@redhat.com>
Date: Tue, 4 Feb 2025 18:56:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/6] selftests: ncdevmem: Implement devmem TCP
 TX
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Neal Cardwell <ncardwell@google.com>,
 David Ahern <dsahern@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk,
 Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>,
 Pedro Tammela <pctammela@mojatatu.com>,
 Samiullah Khawaja <skhawaja@google.com>
References: <20250203223916.1064540-1-almasrymina@google.com>
 <20250203223916.1064540-3-almasrymina@google.com>
 <c8dd0458-b0a9-4342-a022-487e73542381@redhat.com>
 <CAHS8izOnrWdPPhVaCFT4f3Vz=YkHyJ5KgnAbuxfR5u-ffkbUxA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAHS8izOnrWdPPhVaCFT4f3Vz=YkHyJ5KgnAbuxfR5u-ffkbUxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/4/25 6:35 PM, Mina Almasry wrote:
> On Tue, Feb 4, 2025 at 4:29 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>>  .../selftests/drivers/net/hw/ncdevmem.c       | 300 +++++++++++++++++-
>>>  1 file changed, 289 insertions(+), 11 deletions(-)
>>
>> Why devmem.py is not touched? AFAICS the test currently run ncdevmem
>> only in server (rx) mode, so the tx path is not actually exercised ?!?
>>
> 
> Yeah, to be honest I have a collection of local bash scripts that
> invoke ncdevmem in different ways for my testing, and I have docs on
> top of ncdevmem.c of how to test; I don't use devmem.py. I was going
> to look at adding test cases to devmem.py as a follow up, if it's OK
> with you, and Stan offered as well on an earlier revision. If not no
> problem, I can address in this series. The only issue is that I have
> some legwork to enable devmem.py on my test setup/distro, but the meat
> of the tests is already included and passing in this series (when
> invoked manually).

I think it would be better if you could include at least a very basic
test-case for the TX path. More accurate coverage could be a follow-up.

Thanks,

Paolo


