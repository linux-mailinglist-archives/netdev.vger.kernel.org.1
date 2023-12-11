Return-Path: <netdev+bounces-55874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BB580C9F3
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820CC1F2109A
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 12:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457F13B7AF;
	Mon, 11 Dec 2023 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uExf5nda"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C4AA1
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 04:35:15 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1da1017a09so534622466b.3
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 04:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702298114; x=1702902914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=okeZz+/5q28Go+s8k/ynMlYtWODeKp/iZbr3JW3CH84=;
        b=uExf5nda+hurv4+9BRyNF+muklXHygd/5yJxjSTrL7sK475ZsuHwTZCwwjo/JE7EGM
         GvJmGm2EcNioTmH8tQgw7VUso++imaV3YEJy/Ozd3HjcCkR6jXDdlEfx94AfVKHlEeQ1
         jTCX4SCzgYgUjEDhdzcybnqHio+o5/QT8iw2NMMIsiX3ZTMp34kYwk8vmrmV3houKO28
         Mk5oLSlT8KrPEPvhB3DzZb0IqyyholUEfirIhJb4I8tU6haDM3xg8eC4dEvFr3+Dv4+O
         8sFTL8bPqysCL2+gVFAYWtYN/NETW5ihKL4KQgceNW20E3aj7i7VH286NAVs+KxZUUuE
         9Iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702298114; x=1702902914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okeZz+/5q28Go+s8k/ynMlYtWODeKp/iZbr3JW3CH84=;
        b=fASe4VEC8bkGneNqWl0ToP6+YBk62Aiab88jkFSNv2lDIMbB6FNqTnsxLJMARKcBkX
         KCvi8YTADqeLA7gKQOEhtj5Kad7WiE7S5qAIwm7NZGKpQvNtZjGCklnNZ/NnmWGUFYz5
         Y7u8I9h7F0MUhGpjXyzxaU2Iwo9DiKnQqUPuPl7pCz0gc1AQIsrZrzJyc0bdwAmFqM6r
         gCYSWRTLHi8PmN6rO6ADT8rSrvRGxk3jMoJiRm3Jyv93ByJW5U+eHEW7QBMP3bFBePDb
         FkmiK5oGB94xhU1di92KmdTuwBMorY0E6DR0iP5SIc1Dz7WjRWxTR+iQ/NQZqYkkOlHa
         rmGw==
X-Gm-Message-State: AOJu0YxcQnp+Ki2wAOU1V4zR6RPhvnyYksnw79SgfiHT7JrKhpNjxKVI
	MJXz4DdTw3a2mnIVmHHtdGUCuw==
X-Google-Smtp-Source: AGHT+IEeNSumf/Z5NdDQ1ZCLP4y0DB4LAifdgyxvXATDzBm3pM14+UCAg7G1tScr8WOo3kRn3GhEgQ==
X-Received: by 2002:a17:906:3519:b0:a00:152a:1ec4 with SMTP id r25-20020a170906351900b00a00152a1ec4mr2373236eja.11.1702298113511;
        Mon, 11 Dec 2023 04:35:13 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id so7-20020a170907390700b00a1f747f762asm4092619ejc.112.2023.12.11.04.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:35:12 -0800 (PST)
Date: Mon, 11 Dec 2023 13:35:11 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: swarup <swarupkotikalapudi@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH net-next v6] netlink: specs: devlink: add some(not all)
 missing attributes in devlink.yaml
Message-ID: <ZXcB/6tv/kuX4R91@nanopsycho>
References: <20231208182515.1206616-1-swarupkotikalapudi@gmail.com>
 <ZXbaauFOfttLCe78@nanopsycho>
 <ZXb+fRawVUgU+lrX@swarup-virtual-machine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXb+fRawVUgU+lrX@swarup-virtual-machine>

Mon, Dec 11, 2023 at 01:20:13PM CET, swarupkotikalapudi@gmail.com wrote:
>esOn Mon, Dec 11, 2023 at 10:46:18AM +0100, Jiri Pirko wrote:
>> Fri, Dec 08, 2023 at 07:25:15PM CET, swarupkotikalapudi@gmail.com wrote:
>> >Add some missing(not all) attributes in devlink.yaml.
>> >
>> >Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
>> >Suggested-by: Jiri Pirko <jiri@resnulli.us>
>> >---
>> >V6:
>> >  - Fix review comments
>> 
>> Would be nice to list what changes you actually did.
>> 
>> Nevertheless, patch looks fine to me.
>> 
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>
>Hi Jiri,
>
>Do you mean in the commit message, i should have listed all the changes?

In the changelog (the line I commented), you should try to describe what
exactly did you change from the last version, so the reviewer knows what
to focus on and what to expect.

>Please clarify, if required i update the commit message.

No, next time.


>
>Thanks,
>Swarup

