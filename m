Return-Path: <netdev+bounces-51627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A857FB70C
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 11:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 932AAB213AF
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 10:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641014E1D4;
	Tue, 28 Nov 2023 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="de3wIVJh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4403FE4;
	Tue, 28 Nov 2023 02:21:48 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b472f99a0so13439635e9.3;
        Tue, 28 Nov 2023 02:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701166906; x=1701771706; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=doZxVarw4yWuYz9GLd1CkeNGgwRvUrOLU0u2bie84jA=;
        b=de3wIVJhO9Ovv0sSo7Klp4C3HtICepzp7wOUxa/udqSt36vfCy1Td48enGjG0+QTdg
         fgbBm5zqamjVW5hGoeUT5N89pg+/fjHox5rDXiFXOnfR2eroEjw47/oPVgdXFlrWIGYy
         dH4/s6eIquzLOFh+uIhMx/ed1RUlX5s2VypPSZ+x3NHtgOzcXnxb5uky13uc8C6w2KdX
         MGkbzKB47OckHDp8quKThQE9AsOyzkMd77kgTYxGyevWroOKtrZGEMB/kvXBme6Uphem
         rMzhMBtjrOb2m9HYpncNXkVFro5NOvW+peVXPXCJpJFVmucE48TMuGJnI9Ty0shj893b
         fD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701166906; x=1701771706;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doZxVarw4yWuYz9GLd1CkeNGgwRvUrOLU0u2bie84jA=;
        b=Y+EeUbD0cwBW+LbG4npiewZyiP7k9aNygKoZL6pOLGRhC+hWP/3EYNO7n48YyYEqxD
         mqtxnt1wjmhr5S4DUPYXH0Z4ZyjeGcdFIeTu9TFDszAwoVJDT4v0l25sCDy59am0Na+U
         jzqHIn2WXu6bfNbpDfdtqyPEph7Gpf6GouvXY5yJcmC7qVkNOYXRwdck2P/7WSiBIy6q
         14aVj8IISG45nnV71qZVJiu09YowM9KKKx4e4GBzgjUo8NximMA9zVDEck/sXux596Y4
         CgP77+ITAnBAN8QsUl/0NTHQupi+hVBcNutK+RPB/2eyMRw4ytWKYHCFKc3M43yl+17G
         qGHQ==
X-Gm-Message-State: AOJu0YwinHqnhEAlU6lHmE/frykqSEZ47hy3Y/EvsE0ZaMsbFgdVL7wJ
	DAIt0Ep6m/bwfIdgJ3gkNZm58rqQ1Fe58w==
X-Google-Smtp-Source: AGHT+IEViRgEV2pMIv6kyvj4s1ko5EpvSZDqRr/sFKlgMMcYYCvm9fSuVqeyovLGpF7jZ9b4Q2lVeQ==
X-Received: by 2002:a05:600c:1f93:b0:40b:3dc0:1ff with SMTP id je19-20020a05600c1f9300b0040b3dc001ffmr7878883wmb.6.1701166905801;
        Tue, 28 Nov 2023 02:21:45 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:804c:ab2b:6aea:3a2d])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c475500b0040b2976eb02sm16852740wmo.10.2023.11.28.02.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 02:21:44 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  corbet@lwn.net,  leitao@debian.org,
  linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] docs: netlink: link to family documentations
 from spec info
In-Reply-To: <20231127205642.2293153-1-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 27 Nov 2023 12:56:42 -0800")
Date: Tue, 28 Nov 2023 10:21:30 +0000
Message-ID: <m2leai89g5.fsf@gmail.com>
References: <20231127205642.2293153-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> To increase the chances of people finding the rendered docs
> add a link to specs.rst. Add a label in the generated index.rst
> and while at it adjust the title a little bit.

It might be useful to also link to the rendered docs directly from the
"Netlink Handbook" at Documentation/userspace-api/netlink/index.rst?

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: corbet@lwn.net
> CC: leitao@debian.org
> CC: linux-doc@vger.kernel.org
> ---
>  Documentation/userspace-api/netlink/specs.rst | 2 +-
>  tools/net/ynl/ynl-gen-rst.py                  | 8 +++++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/userspace-api/netlink/specs.rst b/Documentation/userspace-api/netlink/specs.rst
> index c1b951649113..1b50d97d8d7c 100644
> --- a/Documentation/userspace-api/netlink/specs.rst
> +++ b/Documentation/userspace-api/netlink/specs.rst
> @@ -15,7 +15,7 @@ kernel headers directly.
>  Internally kernel uses the YAML specs to generate:
>  
>   - the C uAPI header
> - - documentation of the protocol as a ReST file
> + - documentation of the protocol as a ReST file - see :ref:`Documentation/networking/netlink_spec/index.rst <specs>`
>   - policy tables for input attribute validation
>   - operation tables
>  
> diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
> index b6292109e236..2c0b80071bcd 100755
> --- a/tools/net/ynl/ynl-gen-rst.py
> +++ b/tools/net/ynl/ynl-gen-rst.py
> @@ -122,6 +122,11 @@ SPACE_PER_LEVEL = 4
>      return "\n".join(lines)
>  
>  
> +def rst_label(title) -> str:
> +    """Return a formatted label"""
> +    return f".. _{title}:\n\n"
> +
> +
>  # Parsers
>  # =======
>  
> @@ -349,7 +354,8 @@ SPACE_PER_LEVEL = 4
>      lines = []
>  
>      lines.append(rst_header())
> -    lines.append(rst_title("Netlink Specification"))
> +    lines.append(rst_label("specs"))
> +    lines.append(rst_title("Netlink Family Specifications"))
>      lines.append(rst_toctree(1))
>  
>      index_dir = os.path.dirname(output)

