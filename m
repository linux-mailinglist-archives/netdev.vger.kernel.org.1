Return-Path: <netdev+bounces-53284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5E7801E6D
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 21:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193351F20FC0
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 20:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AEB21117;
	Sat,  2 Dec 2023 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lPUFDYRV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DCC116
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 12:23:08 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d3f951af5aso30904787b3.0
        for <netdev@vger.kernel.org>; Sat, 02 Dec 2023 12:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701548587; x=1702153387; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eqghGDzVaejmBMjkE70yjlZzwHnN8402o96hV9dca5A=;
        b=lPUFDYRVMUCDKxSkEOJyQfhb9jWzckjYOlB44Xu6JAjMsCWRmaoc0iu8YVa8yhXWtZ
         vM5+O0vF0O9PiuAvaLikG5+SRlKaGw5yWVt+SD+GuNdohsQLpKUFW+e/FJ6/+IWSoVFs
         zQl7RXYsDlghN/AX6+zrw/7QNehNAXxqxByN6jYQefMuuu6pb5JSxycj7AzqWrLtWe0B
         d02F1gK7b62xLrtLxjvY4SY+Mx9Gk7nBdY06Mdysoi/Z1PSilbXSgIYXCS5n2hlrqBxL
         PFq9pL8E0lqWS2xvyhExEn0/1BajKNoS98haR8K9Ujy+Sc5DkT3nYoqYWbz9AWJgVe3f
         yz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701548587; x=1702153387;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eqghGDzVaejmBMjkE70yjlZzwHnN8402o96hV9dca5A=;
        b=h963dqibhaGBV58HZyW4xS/5f7j+b4+Esa5KImV0Y21bp2XeumCWI5tWNxJbNuLyDU
         yNpsRWz+pLYeN0Co9KTpbWqhmZCY+8jOupdxkWcZlO+oOYoSHjOx/T3de0QuLK1UXt3z
         Xcr+ZLKYD8BI4y/38BgR3k58Fi3DhRbtjRvtgbP2ZfEJf08JbDoxsUTYkmvwzaUR0n8g
         N7dTsqr/Lw/FuFxybf9RKMx6XjfggmmqnJaLl+npZa0vBLH8enrjFXhMTq81ynd5zwWq
         QCCx/D35iZB2PR68kOqG3qARx5pK6Ad+So8NP/vRleO1XelU/yFCsyrifjBOyQ+TwOFy
         AwBQ==
X-Gm-Message-State: AOJu0YzB8Ju9p3eAG+315x+5UyQ35L0tTeQGU0aVhw+H8fyHbYNl3lu3
	kB+F29B2CHFjNDUYM335hgeAk/Bnu7I5ZA==
X-Google-Smtp-Source: AGHT+IHSs/b49wzG5nDTh99AzHU0Zm87W4AcpwItaRgr1x51e4XG+5GwlrxGT/4hFft0tUhwp9FKQ8/q7mMQoQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:690c:4704:b0:5d3:a348:b0b9 with SMTP
 id gz4-20020a05690c470400b005d3a348b0b9mr220467ywb.8.1701548587539; Sat, 02
 Dec 2023 12:23:07 -0800 (PST)
Date: Sat, 2 Dec 2023 20:23:05 +0000
In-Reply-To: <20231129072756.3684495-4-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129072756.3684495-1-lixiaoyan@google.com> <20231129072756.3684495-4-lixiaoyan@google.com>
Message-ID: <20231202202305.jizoinhgzo5c4gew@google.com>
Subject: Re: [PATCH v8 net-next 3/5] netns-ipv4: reorganize netns_ipv4 fast
 path variables
From: Shakeel Butt <shakeelb@google.com>
To: Coco Li <lixiaoyan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, 
	David Ahern <dsahern@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Pradeep Nemavat <pnemavat@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 29, 2023 at 07:27:54AM +0000, Coco Li wrote:
> Reorganize fast path variables on tx-txrx-rx order.
> Fastpath cacheline ends after sysctl_tcp_rmem.
> There are only read-only variables here. (write is on the control path
> and not considered in this case)
> 
> Below data generated with pahole on x86 architecture.
> Fast path variables span cache lines before change: 4
> Fast path variables span cache lines after change: 2
> 
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Wei Wang <weiwan@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Coco Li <lixiaoyan@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

