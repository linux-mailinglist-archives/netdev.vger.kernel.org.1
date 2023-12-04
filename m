Return-Path: <netdev+bounces-53556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA69803ABA
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7475B20BCE
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A634D2E620;
	Mon,  4 Dec 2023 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eq1+hsaZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DBD11A;
	Mon,  4 Dec 2023 08:47:22 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c0a03eb87so15155325e9.3;
        Mon, 04 Dec 2023 08:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701708441; x=1702313241; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8w8/NZodyasp/IFI+hRUIAjihChoTfPl5Cg9hVHbRM=;
        b=Eq1+hsaZr1I4IJrbzydbldqd5941FGCyABsntflEO44GuaQfCBm/I9/uIcSq5FTQh8
         wHcRMWzi6dtb4AAAuEQq/obJSiSzmFifgt8arUb7rWFvR/Nzn0FJwV9j+SHdbB8YNifX
         xKmQeR4CW7xDJSxIs0NZVoC8GLQFhRqjXMy29QIz4gCnL1VwbwMVga/sEqHEDuKzaESr
         khq3tbOrpfoP8bDzb4FJzKq37/ENRJWLHgp4cemms0zPmTFg+jyupwKTCAnNFTs7IKyj
         r4vDuCiX68JyxEMH4mxYNDqKbWpwKPUeX/QCu30J7Bw4TWyIFj4WnVckNQL47GfFKrYw
         hk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701708441; x=1702313241;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8w8/NZodyasp/IFI+hRUIAjihChoTfPl5Cg9hVHbRM=;
        b=IcXHd74IVm/RZEsUxOaI+GSwBS45tqVDDUqF/LmkgOv9UVPHyHG3QsnDfk+XrwW8Qx
         DcAsk14FcbD8Gld3Emo3sWynbNJ0pxZpZF+BWQO2BbzbpKO7al+OpwCiL+bKnxON3/2M
         lfjcAEK66kJtvuJqcTS8VV7h7KFldhVg8IJgA2WizqTexcSx6LXNfjHFSPSWaF+zUsos
         PzNN9FMwP4b9JvqR2UDKrZDQEENPytAlB5R1Sxg9BVKH7atuhtVUA0kjh6/48BwaY7J1
         881/ycgTDLGTfVdQXkv/hDI6YeSWY60zKTjMqnBUCQ/3QY+5ArSBDrk9R607Sjc/5LnI
         S8xw==
X-Gm-Message-State: AOJu0YynuCqM+awSDPDBcUm62qteDKTy81lrJoASE+PeYxzvQz4A6W3i
	yJByCioztCQi0uw+MR/Qd1M=
X-Google-Smtp-Source: AGHT+IHEmPcutxPPq5uSAfpi3ImyIAf1IA38LMe3dS4WVOcI/n4t1xYdGJ29dqBM2ZRAxS880RaiAA==
X-Received: by 2002:a05:600c:348d:b0:40b:5f03:b3ea with SMTP id a13-20020a05600c348d00b0040b5f03b3eamr1142847wmq.268.1701708440984;
        Mon, 04 Dec 2023 08:47:20 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:d9c9:f651:32f4:3bc])
        by smtp.gmail.com with ESMTPSA id b19-20020a05600c4e1300b0040648217f4fsm19297397wmq.39.2023.12.04.08.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:47:20 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  linux-doc@vger.kernel.org,  Jacob Keller
 <jacob.e.keller@intel.com>,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 5/6] doc/netlink/specs: add sub-message type
 to rt_link family
In-Reply-To: <20231201181014.0955104a@kernel.org> (Jakub Kicinski's message of
	"Fri, 1 Dec 2023 18:10:14 -0800")
Date: Mon, 04 Dec 2023 16:22:03 +0000
Message-ID: <m24jgy6iqc.fsf@gmail.com>
References: <20231130214959.27377-1-donald.hunter@gmail.com>
	<20231130214959.27377-6-donald.hunter@gmail.com>
	<20231201181014.0955104a@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 30 Nov 2023 21:49:57 +0000 Donald Hunter wrote:
>>        -
>>          name: slave-data
>> -        type: binary
>> -        # kind specific nest
>> +        type: binary # kind specific nest
>
> Just to be clear - we can define sub-message for this nest, too, right?
>
> Not sure if it's worth moving the comment in the commit, it's just
> noise..

Ah, good catch. I can at least put in a sub-message placeholder for
slave-data.

