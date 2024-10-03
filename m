Return-Path: <netdev+bounces-131473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D856098E930
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 06:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B5A1B20E1E
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 04:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4F113FEE;
	Thu,  3 Oct 2024 04:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sbb1OuUZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6862E22F19;
	Thu,  3 Oct 2024 04:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727930568; cv=none; b=jSpBKOkIfiuzzSr5M2+JBCxg4QbBWT2py0FB6lNREbzOv81Ht0WgODqd/2AH8lbMdquPE9ebfLifZaSVDmGSwH3j1f90tYdD+DCc03WpqQooaFUG2j96eQZZVkVhwvFzpYYE7AeqY2gq7zT2gD7LnkW2Zms7ULYnJV0wJSBeFuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727930568; c=relaxed/simple;
	bh=B2vd5ysaLPkXPVPxTchKQAjANgEFPxysVaohF01KmOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBOxOkGhWzqlLFki5nsSBuWvh3+rv87wzpb/Icr+C4O3zXCs+lQs6pKIJBdpmOHhNMhGGrkdp1Dp4OT/QVVru3mVIPrJFOCNnncKs5RRMeoIBmpSqnzsSUCLkP7mvnY0QA3/1yBIi429BOvStFUL98sgislNOSGMh6/gwNkZ+cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sbb1OuUZ; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6dbc75acbfaso4056697b3.3;
        Wed, 02 Oct 2024 21:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727930564; x=1728535364; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B2vd5ysaLPkXPVPxTchKQAjANgEFPxysVaohF01KmOk=;
        b=Sbb1OuUZVoTTAoyqHnTHeN/VelTi4FgLy8a4H1nlbXhRxjMaX5/BMHRMA9xj/tuRqh
         pFXohuZ9SUpMft8nWCvvXvOgC8c6Iml8grQYPgnRxuDqfn1Gn55fMV5tjj2gQMLf+zoq
         O90oect6L+wfHRfCCKzl0iCr5p4lKqZOMZiOqh7FBaJGjGNo4AB5d9KTeuIoUQPMN8Fk
         xhflAW1AQBhW5Alao6BANdl1Y6EP2yx/DVp9TMziyWDuI4Q3yrLbXvIxc73eH2PBL7FQ
         Zg/AxbPvrJESDZtjU/5PAHTNbuf5RFz9kHnQEzHGz0EZ7Pkqo46cbaIErJH3LU2kx0fn
         WkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727930564; x=1728535364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2vd5ysaLPkXPVPxTchKQAjANgEFPxysVaohF01KmOk=;
        b=lQp2HEKLjRXdakW9tTjfipTTaa6/f5rzzJkOI64g5hMTm3wXbEx0v92075NL06vFDd
         GIKloigCXMbrirsd4hw2uTe67b0XbEuxvWNqXubMN76z8LlR17yo6zANSXVka3xFKeNG
         kqzodngeCPWExjAq7QLycZ8QSJhQYFR4t769tpYi9fslrmOQW+3Rk4eS/c0uM/GWrO9q
         mhjz1nVCo4S+pL8kAfuJmuMYe4WR7RF0Fh4HbT94VjpPAjwF7HVnn65ecShn/r/kfYs3
         Ip5o56btBzG6a03lcn+D8gB6x6m+fd0Bh6qcgXSr3T+lzx7BY3J4Q+bNKk4V2SE/0+L9
         oSvw==
X-Forwarded-Encrypted: i=1; AJvYcCUEJV9PqZYwAS2jWdxYD2Sq5G2q7CWEB3pOdcA2ogGop9MxiqlkkrpwInRC0hpRh7t59q5LJP1m46wZHso=@vger.kernel.org, AJvYcCV3yNW/G/2x1AmXYWx1J4T51R5gmPYc8JT2eOeis7tI0FQkpoh7Q5Nhhfk+/L7nKWqeiXXkazQs@vger.kernel.org
X-Gm-Message-State: AOJu0YwuRz6B51z0I1XOCZ1Rrvlw1FPf7B0/D2+q/aHsBf7TqL20jHtF
	X4MuKyNWI93U/yUGV+Q3p5L0tcA+c0/s/QqmoGHadUrzMB0VVjiYT1gvtnIHkuYL2pZF6gHyn20
	RGXj0PC+42sTyKz73mQ33BqoINzs=
X-Google-Smtp-Source: AGHT+IFxeGp2cJa9eUrmr5guVnKMnxQfpgp6+VNuiseonSJhaDrOEF4hFD3Zk5KSV4xioFcyD9+kP17/khdxQ4e6kpw=
X-Received: by 2002:a05:690c:3484:b0:652:5838:54ef with SMTP id
 00721157ae682-6e2a3059b8emr40549097b3.37.1727930564336; Wed, 02 Oct 2024
 21:42:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002053844.130553-1-danielyangkang@gmail.com>
 <CANn89i+y77-1skcxeq+OAeOVBDXhgZb75yZCq8+NBpHtZGySmw@mail.gmail.com> <ff22de41-07a5-4d16-9453-183b0c6a2872@iogearbox.net>
In-Reply-To: <ff22de41-07a5-4d16-9453-183b0c6a2872@iogearbox.net>
From: Daniel Yang <danielyangkang@gmail.com>
Date: Wed, 2 Oct 2024 21:42:08 -0700
Message-ID: <CAGiJo8TaC70QNAtFCziRUAzN1hH9zjnMAuMMToAts0yFcRqPWw@mail.gmail.com>
Subject: Re: [PATCH] Fix KMSAN infoleak, initialize unused data in pskb_expand_head
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

I took a look at https://www.spinics.net/lists/netdev/msg982652.html
and am a little confused since the patch adds a check instead of
initializing the memory segment.
Is the general assumption that any packet with uninitialized memory is
ill formed and we need to drop? Also is there any documentation for
internal macros/function calls for BPF because I was trying to look
and couldn't find any.

