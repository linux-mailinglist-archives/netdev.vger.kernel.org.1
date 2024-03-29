Return-Path: <netdev+bounces-83422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 242358923BE
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 19:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C3F286DB7
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 18:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463F82D603;
	Fri, 29 Mar 2024 18:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbmMQRT8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8225B1DA5E
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 18:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711738687; cv=none; b=MeZpMuFCcKC8xKv3OcqKAj0Zmk2gM011+kJShhXeVGnmQfEWwrqmyOoWQpQbVlieqh+msL/5CcGiLqfQE+tdOByIVde2EaOnl+94a4aDsQCAufyfhFkWeqYU63tRAayhRfLnzwB0yf8vX6+7GyGI4EY4Rac6PQTOu+nkZoSdCkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711738687; c=relaxed/simple;
	bh=2G8dMSgNF4KoD5LZNOG1TPHGo4bTqByXtaH/mThuBXo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=rF+k0rwLU57Oo7XFZ/yIwmXaFsjg+NMOAotZUHdrqbMt/MOdM0nw83VzZK7LhoeW73ut2++8nd21bZoqEARns0KnW44l/TFtZtDuXvRhmmsgve0+iCOaSaCyfcjwjDPHDNZ0JcR/7Tmjubut9CmnlRG3OGZ9mfw7vmgK0H8jiyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbmMQRT8; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513e10a4083so2545551e87.1
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 11:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711738683; x=1712343483; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=48mci/pDZnhCMSbvKXEITuIIGd16776VX6sVUJ3t11A=;
        b=QbmMQRT8H7SSHC00VVGo876ROy90bBNRfdC6wdkoYT14rohtbDxJ4KQKhpH40BUm2E
         n2h1SCC30OPFw5ZjLMbCd/B4PYPDGUfmBBvGV1vQQyDXhM9ZQEq61WhbrE0KV7wVfWIz
         fRhPvrdvNlV+7zCv7/MWap+EH9av3yIP9zCiJ3mUuyR2X+na2dpym6txmBQlqEPZxil7
         otC5e0wYCvMDDjatCvwSNjHKvNTOG1ZczwUahZE0uIQ3nIty4Z2mtXbpqg0VQGW6Txpi
         Ew2iTclThHRTJv8WDW3D+57iDp8IY7WbFHZNq4IMfAW9Mg+SkBCOexOe8GjVHGiWGpoI
         tmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711738683; x=1712343483;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48mci/pDZnhCMSbvKXEITuIIGd16776VX6sVUJ3t11A=;
        b=OXkJJLF1bsqP+EVkpYoN/Q1rGechvckTUpgAVG88wNdZSQF91cvOl6PkF26AGiFyfA
         LmMOLpIrlzxnje7rkJoopcdd4pKgYR83uU74w561vQxyol+mXaYRvgMopTqhPmTqUHOc
         aYyQEMkNBhmWJe4f8bor2myoemfQrnL0JAQ47xOQ+nC9Lxl0RCibHS8DXmm4Gx8Tk/cd
         Hpie7ox4/fDxphV/y0kIfhcfyQk68NdK8xjNna+z0TMBoqXc8Q5RI4BWtvOeOjpvdhj7
         vvtascp81YYVbgsz5f0k2i3I8hE4aLwHWYui4T/0GQ3qoQlYDrRujHFqcnUyFqhmbeY+
         23Jg==
X-Gm-Message-State: AOJu0YxJyldq+0SGGFUB87+eAyAvOBosNk4ws/MvbdHJ81iONrR6LmjP
	vEib5R9eUBByO1+SXEXEhfZ0h5RjmVyrhsLug++FbPJrD5IrdpMj
X-Google-Smtp-Source: AGHT+IE9BxerfhV68aZKRqPgbxx40GiwX+2HjKRoCeRaEhebIKV9qWooIzYFUpc6E3zBrK9JJrb3vg==
X-Received: by 2002:ac2:5a5a:0:b0:515:a62a:8e3d with SMTP id r26-20020ac25a5a000000b00515a62a8e3dmr1919950lfn.11.1711738683296;
        Fri, 29 Mar 2024 11:58:03 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:3c9d:7a51:4242:88e2])
        by smtp.gmail.com with ESMTPSA id u22-20020a05600c139600b00414906f1ea1sm6180785wmf.17.2024.03.29.11.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 11:58:02 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jiri
 Pirko <jiri@resnulli.us>,  Jacob Keller <jacob.e.keller@intel.com>,
  Stanislav Fomichev <sdf@google.com>,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 2/2] tools/net/ynl: Add multi message
 support to ynl
In-Reply-To: <20240329084346.7a744d1e@kernel.org> (Jakub Kicinski's message of
	"Fri, 29 Mar 2024 08:43:46 -0700")
Date: Fri, 29 Mar 2024 18:57:28 +0000
Message-ID: <m2plvcj27b.fsf@gmail.com>
References: <20240327181700.77940-1-donald.hunter@gmail.com>
	<20240327181700.77940-3-donald.hunter@gmail.com>
	<20240328175729.15208f4a@kernel.org> <m234s9jh0k.fsf@gmail.com>
	<20240329084346.7a744d1e@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 29 Mar 2024 13:37:31 +0000 Donald Hunter wrote:
>> > We'd only support multiple "do" requests, I wonder if we should somehow
>> > call this out. Is --multi-do unnecessary extra typing?  
>> 
>> I prefer --multi but will update the help text to say "DO-OPERATIION"
>> and "... several do operations".
>
> Alright, technically doing multi-dump should also work, but maybe
> there's less of a benefit there, so we can keep the multi focused
> on do for now.
>
> Looking at the code again, are you sure we'll process all the responses
> not just the first one?
>
> Shouldn't this:
>
> +                    del reqs_by_seq[nl_msg.nl_seq]
>                      done = True
>
> be something like:
>
> 		del reqs_by_seq[nl_msg.nl_seq]
> 		done = len(reqs_by_seq) == 0
>

Hmm yes, that's a good catch. I need to check the DONE semantics for
these nftables batch operations.

> Would be good to add an example of multi executing some get operations.

I think this was a blind spot on my part because nftables doesn't
support batch for get operations:

https://elixir.bootlin.com/linux/latest/source/net/netfilter/nf_tables_api.c#L9092

I'll need to try using multi for gets without any batch messages and see how
everything behaves.

> My other concern is the formatting of the response. For mutli we should
> probably retain the indexes, e.g. 3 dos should produce an array with a
> length of 3, some of the entries may be None if the command only acked.
> Would that make sense?

As I said, a blind spot on my part - I didn't really think there was a
need to do anything for None responses but if get can work then an array
of responses will be needed.

