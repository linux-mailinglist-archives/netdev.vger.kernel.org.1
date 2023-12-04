Return-Path: <netdev+bounces-53558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C98CE803ABC
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE2F1F2125C
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8918E2E65A;
	Mon,  4 Dec 2023 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3LAZf6h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0A9B0;
	Mon,  4 Dec 2023 08:47:20 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c09f4814eso18431955e9.1;
        Mon, 04 Dec 2023 08:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701708439; x=1702313239; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=olO3IQ86VFY9/5sfsHJJjYomYTJFvoq2c3DIt7TVmCY=;
        b=h3LAZf6ha6yS1qtbRHFvz0MpWHvC99QYqsgkscbaE5hlIQW65iIrB4903S7ZeX8WVS
         Pia+keFACdlFDESKDhc1z4RhLUULkerQ6RXspKm1mcs9JJ0wOF3Z8iZ6d4NWjw4aJh3a
         tn6LLWsY8PKKxOc1Za/2o2r606GizsPhUWP1pNHrlSaUTfgyOKrmj4ff829S71gVfdvs
         yw613Fh77YRSm+POamUkyE0FaqmChKyHEm3WNYArj5T+VDpD8LlAkgNCA2Qm1qG64k9S
         n/o2BBnR6HfDa8YHW/LOBVJhlU2C1LFmRaBUM5mFvL4fsv4xOFjSIbGTcqcHQ/T3RAkB
         tehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701708439; x=1702313239;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olO3IQ86VFY9/5sfsHJJjYomYTJFvoq2c3DIt7TVmCY=;
        b=BrLTuNEE4U0i7toGwwwSZmTKp2eooPLvLP8UFjtU1uYwXlcRUrDpohxLhsOH+vpYLW
         rF7xj3cVAYX7IJXNoKAXxZ7cyRE7f1aABcFF3C0BEA8zLU4GANJhn9JZSMS9bRt8svr6
         9z2rlMaqxOU6C5sIj6eNc1oBTiEWKqJ4+NFqH5Hqel2Q3Ijw8MKPM2hEwQUi4dkPudyX
         G5+LvG7NO7B0y+zyTaW1Wqm6xoqwallHf0nF7gzkYRopXbdCAiGrrlFGnb4v6bWSUfNk
         VWA9ToIIFqKdAwUwFWVduN4eL3yZfqv1BaOADjNUUcSXC8qIbNSPZuYv+N8S55fzC8ca
         Fwvw==
X-Gm-Message-State: AOJu0YydYl2vd+kix/4oXr2b2jEk8wzcLpAfy9/eHOLZkOTnc8sXafxC
	PunAdcnFYgZIDZvaqwBVd3o=
X-Google-Smtp-Source: AGHT+IHY4++uBeyARvWwSTPeRaPMjjmyG45iKkunlVEDItMH7lpKdpvgJM6w9z9kK2qZgcFF3t1MYg==
X-Received: by 2002:a05:600c:3109:b0:40b:5e1d:839b with SMTP id g9-20020a05600c310900b0040b5e1d839bmr2703575wmo.47.1701708439332;
        Mon, 04 Dec 2023 08:47:19 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:d9c9:f651:32f4:3bc])
        by smtp.gmail.com with ESMTPSA id bg36-20020a05600c3ca400b003fe1fe56202sm15881936wmb.33.2023.12.04.08.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:47:18 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  linux-doc@vger.kernel.org,  Jacob Keller
 <jacob.e.keller@intel.com>,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 4/6] tools/net/ynl: Add binary and pad
 support to structs for tc
In-Reply-To: <20231201180646.7d3c851f@kernel.org> (Jakub Kicinski's message of
	"Fri, 1 Dec 2023 18:06:46 -0800")
Date: Mon, 04 Dec 2023 16:18:14 +0000
Message-ID: <m28r6a6iwp.fsf@gmail.com>
References: <20231130214959.27377-1-donald.hunter@gmail.com>
	<20231130214959.27377-5-donald.hunter@gmail.com>
	<20231201180646.7d3c851f@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 30 Nov 2023 21:49:56 +0000 Donald Hunter wrote:
>> The tc netlink-raw family needs binary and pad types for several
>> qopt C structs. Add support for them to ynl.
>
> Nice reuse of the concept of "pad", I don't see why not:
>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
>
>> +                value = msg.raw[offset:offset+m.len]
>
> What does Python style guide say about spaces around '+' here?
> I tend to use C style, no idea if it's right.

The relevant section seems to be this:

  However, in a slice the colon acts like a binary operator, and should
  have equal amounts on either side (treating it as the operator with
  the lowest priority). In an extended slice, both colons must have the
  same amount of spacing applied. Exception: when a slice parameter is
  omitted, the space is omitted:

  # Correct:
  ham[1:9], ham[1:9:3], ham[:9:3], ham[1::3], ham[1:9:]
  ham[lower:upper], ham[lower:upper:], ham[lower::step]
  ham[lower+offset : upper+offset]
  ham[: upper_fn(x) : step_fn(x)], ham[:: step_fn(x)]
  ham[lower + offset : upper + offset]

  # Wrong:
  ham[lower + offset:upper + offset]
  ham[1: 9], ham[1 :9], ham[1:9 :3]
  ham[lower : : step]
  ham[ : upper]

On that basis I could change it to:

  (a) value = msg.raw[offset : offset+m.len]

or:

  (b) value = msg.raw[offset : offset + m.len]

But the existing convention in the code is a mix of these styles:

  raw[offset:offset + 4]
  raw[offset:offset+m['len']]

Happy to go with whatever preference, though maximising whitespace per
(b) follows python style _and_ C style?

Also happy to make it consistent across the file (in a separate patch)?

