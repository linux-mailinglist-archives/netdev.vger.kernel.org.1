Return-Path: <netdev+bounces-53559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC61803ABF
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98047281494
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3311C2E828;
	Mon,  4 Dec 2023 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjGC3zyx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDF1CD;
	Mon,  4 Dec 2023 08:47:24 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c032962c5so28353195e9.3;
        Mon, 04 Dec 2023 08:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701708443; x=1702313243; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UGiPJeGaBfI10fSKuBLYJX6P363I/UXfQapTU3xntlE=;
        b=UjGC3zyxLDNrLp4rGH/T9e+30ZVg3meyUmoeMdsNYX07QrZOz4BGx9uIbcz5QHyjlH
         h4TWcRv223lSjqdk4V/kgKwVNXAXuGwiiFu7d1T2mIRWOf0CzfMfw02Hpx7o1/DlKgFP
         TllBG/VpdjA+roAbt6rB9UjmUk263xhnVHkzJy6iZEO0uQywr3BDaNWxA9CyfQLBNsfh
         czjkLmZovKVf9duIth+ZgH09v2PrQBbz3GZzak1T+pbMCsgbutb7s8KPV8ErV0nOYqGz
         Apmii2Hs0bq1kVQ69UGn7BNNdVHNKlKvFaqF7oHOZIQeVWu0AjUHgKeVfjzx4/j1TfUc
         T0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701708443; x=1702313243;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGiPJeGaBfI10fSKuBLYJX6P363I/UXfQapTU3xntlE=;
        b=R4V6ajd/Ceha6m7ok+zWS7hChGY+UnSvCTyOZnEDPUOhtjtIpOO4X0oA4qnvWRzuZR
         gfOL9NUj6/57zNbU0Fhzuu4vgnCTS3GOgMefAvuchKuxQnzjYVkYasqGo2aqnZ2kO28c
         N1uI14Du01XSR1kEjX5zMi3I9YA2QAkQctnmLJiEezC2yjj8JvV5/gfcr3Mvr/9AP5D2
         PscgsEQ5yY37lws+thVlGaePSdpFl72Q4M9tErfVS5JeUhJ0/+rzRxtkodfm0cTsspLR
         ASiV1/yOUpPG0oNfg11p6LnYQVjvpGFF1zIkkVT6So8qHyGyqo2XhRx9UYe1dqu4+jLV
         lV1Q==
X-Gm-Message-State: AOJu0Yw8D3zgYCUYJuQKyvkDvixzEh96HrsF6+z8KeCCdrvB9WYPL15u
	u5lfuhMKvx87NNtw9CZRw7s=
X-Google-Smtp-Source: AGHT+IGSF1LrH1BjH8ri/jcfCuSLXRh++RjEzT1bBJMNDbXAbhTph3h4onMkOMNHeTYsex3d3NUjyA==
X-Received: by 2002:a05:600c:490f:b0:40b:5e59:99ac with SMTP id f15-20020a05600c490f00b0040b5e5999acmr2048843wmp.204.1701708442796;
        Mon, 04 Dec 2023 08:47:22 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:d9c9:f651:32f4:3bc])
        by smtp.gmail.com with ESMTPSA id a13-20020a05600c348d00b0040b5377cf03sm19408669wmq.1.2023.12.04.08.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:47:22 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  linux-doc@vger.kernel.org,  Jacob Keller
 <jacob.e.keller@intel.com>,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 6/6] doc/netlink/specs: Add a spec for tc
In-Reply-To: <20231201181325.4a12e03b@kernel.org> (Jakub Kicinski's message of
	"Fri, 1 Dec 2023 18:13:25 -0800")
Date: Mon, 04 Dec 2023 16:27:24 +0000
Message-ID: <m2zfyq53wz.fsf@gmail.com>
References: <20231130214959.27377-1-donald.hunter@gmail.com>
	<20231130214959.27377-7-donald.hunter@gmail.com>
	<20231201181325.4a12e03b@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 30 Nov 2023 21:49:58 +0000 Donald Hunter wrote:
>> +      -
>> +        name: app
>> +        type: binary # TODO sub-message needs 2+ level deep lookup
>> +        sub-message: tca-stats-app-msg
>> +        selector: kind
>
> Ugh. Meaning the selector is at a "previous" level of nesting?

That's right. I wonder if we should use a relative syntax like "../kind"
for the selector. Will either need to pass the known attrs to nest
parsing, or pass a resolver instead?

