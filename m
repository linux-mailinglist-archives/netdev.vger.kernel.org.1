Return-Path: <netdev+bounces-56379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7AA80EAAF
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 12:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415A91F21E66
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B2E5DF3C;
	Tue, 12 Dec 2023 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4CWJjCd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F60710A;
	Tue, 12 Dec 2023 03:42:59 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c19f5f822so31127535e9.1;
        Tue, 12 Dec 2023 03:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702381378; x=1702986178; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1w6ExvjDA6MnJY8U+jRIIUUp1YLCQf5dTNoi7ve07KA=;
        b=g4CWJjCdC/QYaWa1T9BCEn3+RJj7eq15Cpul0krae7QmUUk4aTt+S5ZSduFIcT5pOx
         GL6nzMlZ9aAz869aJDwuNQGv/z0R/wwpjEI4WyUYRGHawiAfbB0ofrrwu7Z3VSCPxuOA
         9qbDdUcLTZu8w1t7d9H0BH63jWoibfEYAhbj5yqTD4BNkROOuRbkDX0HONvLMeKmfArD
         kdhhn162GQXpA1jw19GU5c+FsdAeveKb6BeiRQOjJkFGCX5RGgJG03sZzZRlszrnd+fc
         wWnozcozgF0/mhs0lWzKENg8oAl/XXu2rJ9bSPx0cjjTrSwq1Er+D9gsxT3JgjWelw6r
         ParQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702381378; x=1702986178;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1w6ExvjDA6MnJY8U+jRIIUUp1YLCQf5dTNoi7ve07KA=;
        b=DB5ize0bGu+bK9IRv+x2xkMvA0RAbbCNQ5w7kBJNBta70tJ2vZvYi3Ob2Cg0dxg/xO
         s/aW7hj+hC+rh3hgqpbK2S1gNbgo79LuVPeX8IkSjgeGOnD0ZRktmZrq4hHBR+0Jwhpn
         hAAejkIJUY8NyYUrlk+LOm470d9wBsLF8sfmyMZcfPD/6nRQK+9vUSdtnj1Dta0w5Jk1
         x+RK+J3peS1Vxs/UaTxXwjXSl+1gXlfkZUjbZO7LHsPnMNJHEH++m6aNyufqLi0IJDOx
         60dbHcm9teNtOtxSXUueKQstVmOWN22aGYBIhWQBfgHx37jjepN7zBXrjUe5mwtF7Fdn
         iOIA==
X-Gm-Message-State: AOJu0Yx5Np/heQvn2htL4+IE8l28OH6Pk3Z9HB60Or40gjOf3N3BZ/2T
	IovNINbciRBygFFXv0l44B8=
X-Google-Smtp-Source: AGHT+IH+LrqVSNMWmNIXgt/wkgZA74OEbbbxCoPzKyU1CbHG+AZPiTn3XEw8hq/wJQshl02uHSR55Q==
X-Received: by 2002:a05:600c:54c4:b0:40c:3984:4983 with SMTP id iw4-20020a05600c54c400b0040c39844983mr3052768wmb.76.1702381377720;
        Tue, 12 Dec 2023 03:42:57 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:4c3e:5ea1:9128:f0b4])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c358e00b0040c37c4c229sm13708499wmq.14.2023.12.12.03.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 03:42:57 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  linux-doc@vger.kernel.org,  Jacob Keller
 <jacob.e.keller@intel.com>,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 00/11] tools/net/ynl: Add 'sub-message'
 support to ynl
In-Reply-To: <20231211153209.2d526d99@kernel.org> (Jakub Kicinski's message of
	"Mon, 11 Dec 2023 15:32:09 -0800")
Date: Tue, 12 Dec 2023 11:38:07 +0000
Message-ID: <m2v8937isg.fsf@gmail.com>
References: <20231211164039.83034-1-donald.hunter@gmail.com>
	<20231211153209.2d526d99@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 11 Dec 2023 16:40:28 +0000 Donald Hunter wrote:
>> This patchset adds a 'sub-message' attribute type to the netlink-raw
>> schema and implements it in ynl. This provides support for kind-specific
>> options attributes as used in rt_link and tc raw netlink families.
>> 
>> A description of the new 'sub-message' attribute type and the
>> corresponding sub-message definitions is provided in patch 5.
>> 
>> The patchset includes updates to the rt_link spec and a new tc spec that
>> make use of the new 'sub-message' attribute type.
>> 
>> As mentioned in patch 7, encode support is not yet implemented in ynl
>> and support for sub-message selectors at a different nest level from the
>> key attribute is not yet supported. I plan to work on these in folloup
>> patches.
>
> Seems to break C codegen:

Ick. Sorry about that. How do you test/validate the C codegen?

> Traceback (most recent call last):
>   File "net-next/tools/net/ynl/ynl-gen-c.py", line 2802, in <module>
>     main()
>   File "net-next/tools/net/ynl/ynl-gen-c.py", line 2531, in main
>     parsed = Family(args.spec, exclude_ops)
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "net-next/tools/net/ynl/ynl-gen-c.py", line 889, in __init__
>     super().__init__(file_name, exclude_ops=exclude_ops)
>   File "net-next/tools/net/ynl/lib/nlspec.py", line 481, in __init__
>     raise last_exception
>   File "net-next/tools/net/ynl/lib/nlspec.py", line 472, in __init__
>     elem.resolve()
>   File "net-next/tools/net/ynl/ynl-gen-c.py", line 907, in resolve
>     self.resolve_up(super())
>   File "net-next/tools/net/ynl/lib/nlspec.py", line 53, in resolve_up
>     up.resolve()
>   File "net-next/tools/net/ynl/lib/nlspec.py", line 583, in resolve
>     for elem in self.yaml['sub-messages']:
>                 ~~~~~~~~~^^^^^^^^^^^^^^^^

