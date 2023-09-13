Return-Path: <netdev+bounces-33533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E09379E68D
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 13:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD751C20FF7
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 11:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294A41E529;
	Wed, 13 Sep 2023 11:22:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1151E519
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 11:22:30 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD8A2107
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 04:22:30 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52a250aa012so8649955a12.3
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 04:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1694604148; x=1695208948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s23NwptxXgwMhjYgfPFfccnbnMtPnmjMW4LFTGr/juM=;
        b=fewQJrSBIiS64vUXIlBhQ0AvXC5+pyx40ArbeMtTOF2ki9CuSWcyo+gimICIfjOMtX
         gjkMEU+V+k5FkZVdg+QhT1KAJmTdfjZDLU4zmVr0HjJvhVk0+dM66mbWd3gWsCEzscCd
         CQdxs3TCt+jIKGPuMgCNdGLyydXVwzGSmc4EEKX7iNziQ0XhWX4fN/UNIYGhqeWYin93
         jBcZsrlMBh3GT392TJMufx/rIunhsn/dZsB/SgM+MPJf5VylQd9dQl+6NDGwnQNS6Zsh
         4c6Eo6UgwxZYXZSDccLS7PLX9KmzX/n4ug+/jseS5uMYAyHYedMT1MI8igOIct/fPa5p
         F3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694604148; x=1695208948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s23NwptxXgwMhjYgfPFfccnbnMtPnmjMW4LFTGr/juM=;
        b=Hwp6MXgnild3+6DfMwKpB7Xq3r66ZfwEarYH5qb0arV7SM2ombmpcLU6W0wVNNMmZA
         o7yiRPMdGs7qe5Kax5j/xfteI//GbaZdzhrKw500Wv8kUdMd0koQdEzfR/4jqjIVMSb+
         mCnenO2Z3EFcFatncs29UqJfUOmbjH1PQHGsaXKdFoA1q14FYpFM0P7awzqjEt3NMT2s
         l2+bzBNpYql3mw4uMOGZW5BTD0BPNJq+sMKzb3pbpC5e8ssshhsTtwgf4RNcZMRfLJi3
         aLn9HTHVRDvVS3i1KdenBYTYsfEIJnlVQ0qOIvS7t0EdYGbgHqNmRO4LA3BUwdw5zm4a
         INlQ==
X-Gm-Message-State: AOJu0YxMCMn06XvWQW3QR3GI1ViVuRzQekQPIxPRgnwt5ACvscIRrIGl
	l6PlEvLe9M83q1KkSjka/zPC8g==
X-Google-Smtp-Source: AGHT+IFIxh8OIrQhIvvvs3k63T9JV0geALfuEaIlb/5HAxJAZOjIkPqLPX+Dy0b5V3fFDV7ZNWdP/A==
X-Received: by 2002:aa7:da11:0:b0:52f:46ee:33cb with SMTP id r17-20020aa7da11000000b0052f46ee33cbmr2256357eds.24.1694604148349;
        Wed, 13 Sep 2023 04:22:28 -0700 (PDT)
Received: from fedora ([79.140.208.123])
        by smtp.gmail.com with ESMTPSA id w13-20020a056402128d00b005227e53cec2sm7178995edv.50.2023.09.13.04.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 04:22:28 -0700 (PDT)
Date: Wed, 13 Sep 2023 04:22:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel
 <idosch@idosch.org>, Nikolay Aleksandrov <razor@blackwall.org>, Roopa
 Prabhu <roopa@nvidia.com>
Subject: Re: [RFC Draft PATCH net-next 0/1] Bridge doc update
Message-ID: <20230913042224.1e44dcaa@fedora>
In-Reply-To: <20230913092854.1027336-1-liuhangbin@gmail.com>
References: <20230913092854.1027336-1-liuhangbin@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Sep 2023 17:28:52 +0800
Hangbin Liu <liuhangbin@gmail.com> wrote:

> Hi,
> 
> After a long busy period. I got time to check how to update the
> bridge doc. Here is the previous discussion we made[1].
> 
> In this update. I plan to convert all the bridge description/comments
> to the kernel headers. And add sphinx identifiers in the doc to show
> them directly. At the same time, I wrote a script to convert the
> description in kernel header file to iproute2 man doc. With this,
> there is no need to maintain the doc in 2 places.
> 
> For the script. I use python docutils to read the rst comments. When
> dump the man page. I do it manually to match the current ip link man
> page style. I tried rst2man, but the generated man doc will break the
> current style. If you have any other better way, please tell me.
> 
> [1]
> https://lore.kernel.org/netdev/5ddac447-c268-e559-a8dc-08ae3d124352@blackwall.org/
> 
> 
> Hangbin Liu (1):
>   Doc: update bridge doc
> 
>  Documentation/networking/bridge.rst |  85 ++++++++++--
>  include/uapi/linux/if_bridge.h      |  24 ++++
>  include/uapi/linux/if_link.h        | 194
> ++++++++++++++++++++++++++++ 3 files changed, 293 insertions(+), 10
> deletions(-)
> 

Not sure this is good idea.
- you are special casing bridge documentation and there is lots of
  other parts of iproute2
- you are introducing a dependency on python in iproute2
- the kernel headers in iproute2 come from sanitized kernel headers. So
  fixing the documentation would take longer.

What problem is this trying to solve?

