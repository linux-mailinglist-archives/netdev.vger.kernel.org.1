Return-Path: <netdev+bounces-58604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF361817790
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 17:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3321C246DE
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 16:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A524FF71;
	Mon, 18 Dec 2023 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jm1k/jcI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E2D4FF6D
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c3963f9fcso90935e9.1
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 08:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702917081; x=1703521881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSfFyev3M0Ii/CPggARf3Bn6NdpAFruv7rRm9uHMXYw=;
        b=jm1k/jcIQJ96pxwW+vbOq3c5fXv9ovdxMOdTcJ68VVYdchyT8kjLq1o6MYBpWBvgfs
         6nAuikHLhspTu5KJr4irnohA6CKV6mBv8nclXjntGrVK9bdmW+QgzjgEn0azy9JMELFv
         XNykGGeb2W0pZhjrnhcHe8tlxzqnDu09CqNU7ktTaKqgBfq6dnJZP8k55yC0eK1J6VPL
         +iE6Mx2BMjQnTPwL4FMfqxl/k+B82B+/rqcy42B9/gxq5UZczwKQ2u536txLW9B/qSDJ
         kecECB1kNW+axfWVCIWaeUvOHaYrceoVdP+6sf6tCHatK+ZpxXdPVjSABuvEOaFltmYu
         3CIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702917081; x=1703521881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSfFyev3M0Ii/CPggARf3Bn6NdpAFruv7rRm9uHMXYw=;
        b=G/vFNzzsVXP976tSwTf1khqawkEugZt5F4AnQqkVZz+wmdSandHq2HrMuMkxRHV5OJ
         NdPPkCWmuzAomgWwvcauSa9RqBYYqmY/ugTLinJLwnCWXEzS4Jn9agvb+PRs+IpEUSdy
         q2qAxEBcY/UMqyqKVdBBCqa6TKWiHh3xFHcDg0N7G5H4j3y14noofgsjiajsdnQiDn26
         R3a0MzfOBHXbPT4j++l7W5912cKni4TrB77KFJtzDUNV7bjkDqkgrj3tTy006S1OefBJ
         Hl0SbHdZ369fisiBporXdB1+Zpt2elsHwz6LTdFWbOuJgRYiJMwZsjgX9zaHDXid3M66
         28Nw==
X-Gm-Message-State: AOJu0Yx6yoms9eX2FfIWNIYhw+P4IS3WUmiGINw8lC7Sv+qLOk8jmC7e
	PKlAYBM/GsPIFDaSvsa2bIjH19bTiUpesM9qo3CgbfdhnWaQ
X-Google-Smtp-Source: AGHT+IHq0+yBnswrVMyNq6Z2SMPI0WrmsOtDXKIh7kKnrvI4BEP8iHd2zzYCYA3cAq8q/SSQTYewqWdArsLZY9cFlRY=
X-Received: by 2002:a05:600c:1d16:b0:40c:20d3:3a12 with SMTP id
 l22-20020a05600c1d1600b0040c20d33a12mr371086wms.2.1702917080670; Mon, 18 Dec
 2023 08:31:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217185505.22867-1-dsahern@kernel.org>
In-Reply-To: <20231217185505.22867-1-dsahern@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Dec 2023 17:31:06 +0100
Message-ID: <CANn89iLGSJ-TaKfH002pqMyd2xfGybDkdrcGOm_Hn=2JsOKa=g@mail.gmail.com>
Subject: Re: [PATCH net] net/ipv6: Revert remove expired routes with a
 separated list of routes
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, Kui-Feng Lee <thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 7:55=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> Revert the remainder of 5a08d0065a915 which added a warn on if a fib
> entry is still on the gc_link list, and then revert  all of the commit
> in the Fixes tag. The commit has some race conditions given how expires
> is managed on a fib6_info in relation to timer start, adding the entry
> to the gc list and setting the timer value leading to UAF. Revert
> the commit and try again in a later release.
>
> Fixes: 3dec89b14d37 ("net/ipv6: Remove expired routes with a separated li=
st of routes")
> Cc: Kui-Feng Lee <thinker.li@gmail.com>
> Signed-off-by: David Ahern <dsahern@kernel.org>

I guess we need two patches, one in net-next, one in net ?

If this patch targets net tree, it probably should be a plain revert
(no need to mention 5a08d0065a915)

