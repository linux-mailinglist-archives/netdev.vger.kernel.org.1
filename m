Return-Path: <netdev+bounces-117516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 491A794E27D
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 19:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237631C208A7
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 17:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2175D14B097;
	Sun, 11 Aug 2024 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+TxMG/+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7AE28FC
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723399046; cv=none; b=NIUpU39MNzJxUaz1yjKUeDybA7X5zCCkBAZxN8yt/sAKNZVIEe+4VUKQOgDq4Vz/nv3b+WhPfhgWsdOJ/7hmP4VO2e5sEJgzfTuGDNvJmfpVzfvJZec14i8m6WfYsVEc4Ud63J+KRTIgjMs7Qfo5DEOazcplOQMzFWImhEvFbSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723399046; c=relaxed/simple;
	bh=umr0sNtpHKBBwH4G+x1qdqGhky6alTpohH2FdlnVDAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYJkU27EqvHMnh9SJh5RDphRD0xf9TpPcrbl8LFxlVNa4XyGHWQ+s8q0joKYXPUqdnwiUO+GsFzvwhJeNJuEgTkPBTjQNlEJtC6V0a7zaQEvVGxV53zxUmI3EuSDwaUrm1k9T9er6XNL6Zin8rT2T2lIw90cM1gYQ8v52EV9Gak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+TxMG/+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fd78c165eeso28760205ad.2
        for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 10:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723399044; x=1724003844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mmIOT3RGjohKgqwIouc8ZUvGmcOc7wwSjlRkZiX7GhU=;
        b=a+TxMG/+cyUhqmt+1Nw7XiEVBydRJHMheVX7cyziRdwP0WDbugssfeuo+ltf/pf9Kq
         F15+p0W2WVpFvaRR7+BpohEcKPrbpz8hPi6gDizfiZeD9TiYV/TPuOX+frUUi/+5wbr0
         HeevBwOqoDJqLhKRAogloJkeaulhf4o+GUvyeehX4XlgpBGF68LiKBWdHYOZShxYEZ/c
         KwbOUNsAZvoKUOa8Fp+bLjdiYpkgdEi5VZiEWdl6mzOZvtQ5Uovzh6qWbPvGYsHjRkwj
         1uAvzoQaymevmvcPQYMw32b3t9krhAeoek7AR0/btWkZtBl4DYSDTOED6CF+oyCVcc2U
         NdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723399044; x=1724003844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmIOT3RGjohKgqwIouc8ZUvGmcOc7wwSjlRkZiX7GhU=;
        b=Aw+aFvZZisIybdQ8AsPX++/PSUmbeUxMz9Mq+nIoq/xlkOXFqiYvuw0qGLGTfZJiXh
         dqGKcuEsQDm3QmSVBmT1/vHp1bw0YEsOrkGZg4dPTU5o2D5UUm4NS2YgIZWHwoRELjm6
         P9W0lLGOexeXQliRXWqcWehOuo5UBi/xwXOL/IX0ttPSphTy6ySfH+BMnMAqQ/Xgkvt1
         qM7nDCFiur5DkM9dw7cew+ZynQKmuwbJfla5DczcFnATvk2aaKA2hTbqxsPb7juiNv8M
         W+EgKSvvZrzRnUlSH7jxYY6u95xZxCB3Gh54J5fCyf7ROc9cAhZakTMvTrmKwmPEnkGj
         74NA==
X-Gm-Message-State: AOJu0Yw++idvHN9tmMxy/sGy5xQOGeTgdfL6v+VG62f8wAojwbNN7oiO
	8ALtm7+z8JMzHA6r7I9w/pDEDIfxo4zT4IpHYIYDrSgS7C4apeqH
X-Google-Smtp-Source: AGHT+IEKmmgbCinkaYqs+KbSO0cLDDIimv5mo6/JVPvpw5qR7u2nfxM41G23eWhKWUPvRUKhlAJlNg==
X-Received: by 2002:a17:902:db04:b0:1fd:9420:1073 with SMTP id d9443c01a7336-200ae5cfb80mr107326125ad.43.1723399043819;
        Sun, 11 Aug 2024 10:57:23 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:8ec7:dbc7:9efe:94d5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9b47b3sm24930665ad.138.2024.08.11.10.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 10:57:23 -0700 (PDT)
Date: Sun, 11 Aug 2024 10:57:22 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	tparkin@katalix.com,
	syzbot+6acef9e0a4d1f46c83d4@syzkaller.appspotmail.com,
	gnault@redhat.com, cong.wang@bytedance.com
Subject: Re: [PATCH net] l2tp: fix lockdep splat
Message-ID: <Zrj7ggOFooYu0hHE@pop-os.localdomain>
References: <20240806160626.1248317-1-jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806160626.1248317-1-jchapman@katalix.com>

On Tue, Aug 06, 2024 at 05:06:26PM +0100, James Chapman wrote:
> diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> index c80ab3f26084..2e86f520f799 100644
> --- a/net/l2tp/l2tp_core.c
> +++ b/net/l2tp/l2tp_core.c
> @@ -86,6 +86,11 @@
>  /* Default trace flags */
>  #define L2TP_DEFAULT_DEBUG_FLAGS	0
>  
> +#define L2TP_DEPTH_NESTING		2
> +#if L2TP_DEPTH_NESTING == SINGLE_DEPTH_NESTING
> +#error "L2TP requires its own lockdep subclass"
> +#endif

This looks a bit over-engineering.

Why not just #define L2TP_DEPTH_NESTING SINGLE_DEPTH_NESTING+1?

Thanks.

