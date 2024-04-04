Return-Path: <netdev+bounces-84710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD49D898212
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 09:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919451F27353
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 07:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAD85675F;
	Thu,  4 Apr 2024 07:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Hi4CzWSM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B233D56471
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215186; cv=none; b=bMPlYiHqA4MYCpYEK+kOu4aowU+K0fIDxq+Gul3M+cFl8z1GKQwzYB/byM4AISCZb7qY8MpERbUHnNCBuloq+z5J2ykCbVnJmT9qzOPc3DzWUIkpNLex99AkvRW82D3voeLIXQTJo/YpANGozOMgTb45MJiTG1rfqJUKc2KNf3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215186; c=relaxed/simple;
	bh=MrauLE7vTIJ56o0G5yI1/rmSGSVS4GvOYwtIC8oySNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcsCtYVcog8Gv/9gLdpxJeszCrvo5rErAKd18bsGSsL4Cufe09l+oodARIGdOi7NGDiRu1HmzhNzmVCUJ8B8OjoKZEt1TwB/7lmpocrnpMBvrfTuWRHdGFbUSTyhOUEEZIBLxZT/JG0ytfCoOBBS/dTQpDrVakA9dLs5aJRfKtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Hi4CzWSM; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2a2ec65332fso15336a91.1
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 00:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1712215184; x=1712819984; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MrauLE7vTIJ56o0G5yI1/rmSGSVS4GvOYwtIC8oySNA=;
        b=Hi4CzWSMouNbTxluuPyfv2/tC/xpCNV0SFYOlnCMwfbIGtjvNIsNVJfTLhdeFEyRpZ
         +aMpsQaeXZBcAMcJWJyvRjW0tAWNvkZWkzDG2CQa4lwOwfLsuOi+MSL/wIuSRWWWiiWi
         ay4wtPx7r2eyexSZ94W5eCLjc8jLgZ63mJua3BVrHM1Nc3Zj6FcVWhfJ4qug+kKOA2Eu
         vBALYewB7BsTYI6CV1wkWq3XwCl+WRPN5WmBrvWO9kyaoDF/RLybvN3l7+Lcb/hOxTyZ
         B+K474R72OzhlDTPDnWOwm8cu6bHeewVlXbQt/qsAq/vjsM+XNPRChQDcTQ2b/83JgEq
         mdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712215184; x=1712819984;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MrauLE7vTIJ56o0G5yI1/rmSGSVS4GvOYwtIC8oySNA=;
        b=A/XmUQCP7vZRBEt+11YWmNy9FsUvVBUeSg+RNI5mZUdvEj/HtjElmKYRFoR41cQ+te
         UBB0b9O4uxCWs+vOwwvWX/LRO5pFf/ygdhtPlUwEUkJKeRlnHx355blARUK3BmDLMdeU
         6ilgqp7jZIvWI/cWixfJrhSXiyldUSThJbBGAqvxK3heyL4d2y6DQaRTa0d7tU3Ja0N9
         DF82bMij6YUCqQ0RF9iDLib2lQwRTXaw1wYx+oYFE7/gifsKc1YDkBAYRI059wT2WBfE
         LE9xtnP0bKN+sRNtaacNQFaOt/oU4G8jySMZ98b4TFUVALRZToOOTW2h4XODkX/UK+1V
         LT5w==
X-Forwarded-Encrypted: i=1; AJvYcCV4BbLEDERlgaRezQKwmJZW/Tpg5gcADzgDPUYWVZov62+AV3sRWWWn7vjVu32r/XW99T63+KxuXYhVXUkFA9Inm6kPoXJu
X-Gm-Message-State: AOJu0YxDuYijcg0rhLY3iMZLzNaWH6gDewSAJuQlVkXlaiR6TbMr06Kd
	vEq8qGFnSPsVUf09prX6VFZEKkoO2DySC8bPu/n/IvindFDtApVC/L9HO58lxKtzlRWLpUIQ+XQ
	sSsw7YvJTKukpnI57MDFZsJMww28SPhVQi3SLHw==
X-Google-Smtp-Source: AGHT+IE7hLc0KU41lfeyZ5mhDd+vhkeCDZ3N7EoxWcq+wVQbO1BvLZF5gwDyuYi3X5t/OVuCi8+zSSgKaqcO4KrwP94=
X-Received: by 2002:a17:90b:b07:b0:29d:fb03:48b0 with SMTP id
 bf7-20020a17090b0b0700b0029dfb0348b0mr1548139pjb.44.1712215184061; Thu, 04
 Apr 2024 00:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000008fc7ca06153d5d30@google.com>
In-Reply-To: <0000000000008fc7ca06153d5d30@google.com>
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 4 Apr 2024 09:19:32 +0200
Message-ID: <CAGn+7TWFGTrhwRfoPWdd52eZgym8+K-moLq5r0ubWDj_HxdHWg@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in pit_timer_fn
To: syzbot <syzbot+2cd91b51c468ad5df25b@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz fix: bpf, sockmap: Prevent lock inversion deadlock in map delete elem

