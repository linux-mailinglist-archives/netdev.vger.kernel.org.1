Return-Path: <netdev+bounces-57476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2461D81324E
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65FFEB2196B
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1C45789C;
	Thu, 14 Dec 2023 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W53XMcyw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB76111
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:57:52 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-67a91751ba8so48170336d6.3
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702562271; x=1703167071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4GG92dKTxNaTk9lUtZlAp+jFvDJQa6YTMq7X1xQGdo=;
        b=W53XMcyw0lUvCkNP3Cm1o6U78q/b+Z2KTeqY4ns6EwTfESY8dtzryp9le+0ftVAnUQ
         R/NW109J7SGjq1yLjp5CK6XW1wfWaB8//I1/SZZ7vWcEGfx04d6l+8OWPD1x97vPPwVj
         mwQZHwCQhAr231HRTkHl7sdtoPC9sdlwEKh+J82VvBXcVN9sRyBsjrI4GbhMIuE17IZ8
         kp7MimPb+Gn38IbPMscPJUMaKUQ1np1jq2InQx8Ask9Rt/YSLEqvVZpX36RJYVRewgDp
         2jrrTcDxMxleXwzf3SHMnaaRZfXRW6PvZBMz0kYuMuMiUJQZPS35WjmMeqaK53LBcX3i
         6QRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702562271; x=1703167071;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y4GG92dKTxNaTk9lUtZlAp+jFvDJQa6YTMq7X1xQGdo=;
        b=oJjXxjTP/5PnXpNtlCiE11TH5eZ92EL2hDsVvBZmsJ0hGjX+/hcwE2YAvKiXiqB2Qu
         DkK5LUmPXiqMmpYM7d4rwg8XxrgHFC5iMwz1P9lT1Us7CE4eP05+RXvwlFAtm5EcF+7Q
         DN0wSCLNhz0n76PgG4UK995IE2+matAcfHmXXV6pNlM1F2SsfxijbhcoXOzU6EbBgfum
         KvhG8KANvUoegPhS+2ORzDZ+ukYy62avgpiZC3E79QLA3g5TCNuOrTvAZqUmJYPg7Qwq
         UFRN8FkC/MgiC66MonlDja/3+mJH5sE1VwerPpITYhpSQeNZaL4kgfiAn2Ii+M23J1H5
         Jm6Q==
X-Gm-Message-State: AOJu0YzUfPDcX9UI/m4/UrjJLmGuTdMwZrpnbH/qMVNRlxYtbg1QbGbC
	xRX4VNQe9DvcdMs0jfbsTxg=
X-Google-Smtp-Source: AGHT+IEWXDHDHWD1wgDzVN/30yyUm6h2n9+lx1jwSR0X69nD365aI3YRO/rdJJFzvu7diUrYahGQvw==
X-Received: by 2002:ad4:574c:0:b0:67f:fa0:94ed with SMTP id q12-20020ad4574c000000b0067f0fa094edmr529607qvx.99.1702562271117;
        Thu, 14 Dec 2023 05:57:51 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id t18-20020a0cf992000000b0067aab230ed9sm5909265qvn.21.2023.12.14.05.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:57:50 -0800 (PST)
Date: Thu, 14 Dec 2023 08:57:50 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Mina Almasry <almasrymina@google.com>, 
 Chao Wu <wwchao@google.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <657b09de9f6a6_14c73d294da@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231214104901.1318423-3-edumazet@google.com>
References: <20231214104901.1318423-1-edumazet@google.com>
 <20231214104901.1318423-3-edumazet@google.com>
Subject: Re: [PATCH net-next 2/3] net: Namespace-ify sysctl_optmem_max
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> optmem_max being used in tx zerocopy,
> we want to be able to control it on a netns basis.
> 
> Following patch changes two tests.
> 
> Tested:
> 
> oqq130:~# cat /proc/sys/net/core/optmem_max
> 131072
> oqq130:~# echo 1000000 >/proc/sys/net/core/optmem_max
> oqq130:~# cat /proc/sys/net/core/optmem_max
> 1000000
> oqq130:~# unshare -n
> oqq130:~# cat /proc/sys/net/core/optmem_max
> 131072
> oqq130:~# exit
> logout
> oqq130:~# cat /proc/sys/net/core/optmem_max
> 1000000
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

