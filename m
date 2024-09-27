Return-Path: <netdev+bounces-130115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EED998860D
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 15:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81B71C21DCE
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 13:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7401A18DF7B;
	Fri, 27 Sep 2024 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AHSOVqLH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF0718DF78
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727442255; cv=none; b=ofGLvLgymKtmfn0B/UJXg1yC+GxabF7HA9wD4s+JLyIAkx22lQ6rKHaPlvTNlk6mkuK5A2DeTB+g+6hfP4a6qrj5Eh/YZKje46dSdYyPpidD6qGXNEPbrfW6QKhNeFjNG9oK30CcUqbftvQDDhzg4UAI8h0K2rRbEWBpRKKMW4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727442255; c=relaxed/simple;
	bh=uL+y94vB9v8pjC9CzPeotiZpB8amHOd2/EPnB6UsuZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s/wiRqGZY5SrULxHzD5LArPoujCCQe77yhmF+LLsGQntuwb6NzqbFJd7HZi3ZO3VIakaF+vA1mIpyP7ar1RkOy1fjsSeeTHIU3InEHwLyu4Bfsefo6a+kDbxBVU9KhHI/3wljAIK8Nnr6r+3vp9UxSd7qRL2a5rb2Ln2kBF6gDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AHSOVqLH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20792913262so23878885ad.3
        for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 06:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1727442253; x=1728047053; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uL+y94vB9v8pjC9CzPeotiZpB8amHOd2/EPnB6UsuZs=;
        b=AHSOVqLHSlswZ9ga28I+rUj3ExdW8j/i+5efKz/JgcNK8VdX/TwttIiByMWstks4Ky
         ilRA8Ys4wp5tff9kDw7iVAH2iD7dPklJTcB/jk4rWYmO9v05WclHNbFYgp4+DRZCem9a
         lz94sykWT+bs6ewzrkoJk/JRyG4ljdZv9WaD0pXZ7V2c/CckCBr+90Th9JlH46pLAPU9
         fATczzF5OuH5DJfATP4ezefBElYa9DRAj0lYDzP56JhtE2poeUfRcJYi5EZXTiuiH1k9
         les/G/ha9WbWlD8w3EPSx/HDpcWzyWSc13aqsefBrhpJRj/fUOWNHqpdLWBmVDwqWnkh
         rAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727442253; x=1728047053;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uL+y94vB9v8pjC9CzPeotiZpB8amHOd2/EPnB6UsuZs=;
        b=Kkg+o84l6p02BWEVKMw+/jdIuuodnC1Q9mAeyDxye3vJSyvY8wQ0YzL6k0/LsnmI3F
         S9SUClDfWP7Lh7llu4t9ym73oHtOMaqVoSwupkJjd+kAT0oUVnajNcmJ9tNbrkxRSt/U
         zcaQ7KBh+o71CWMRvgbNTDcs4J2jO3jk5wunwhuSVk57E52lEpgIxt+pKnIV8EDYXGv8
         fqkbkHezKO6I1xi+wCC7/9K9xjQtFMrwb4GZ+mlXPZavLYF7UvkKWUTMCIDGzGNt1/nY
         zfAoiIJk0iROQhx7DwARflYFUZnu9btryA/j43nvWIVfUm1NdOY6UQGX5SIAx9yNU/Sv
         4MLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh1CqpXLHSNyepIQIVPfyFmEelWYF6qlbYGtfB/75g9ZoH65Fr90gz9O8cOvDbtqFtydVZO2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUcLobpSTSzYZJM27rF3piqOXT519E4mgRMd8y7fl+ex5mkup0
	EKPpPpqBbnDF7IxR8aIZrSpyOAkvKcfMHk3nnntQ0+x+aqfxFzZ039VCjW3SwTM7dV2/zehBukm
	auwE=
X-Google-Smtp-Source: AGHT+IEV4V9yd9Jy0QYO/4LjqFQ4eTG/J2Pc7mUZmt8VmQgOoQIvLiuXUSG8uyzsb9Kd1wS9CnD8Ag==
X-Received: by 2002:a17:902:d512:b0:207:182c:8a52 with SMTP id d9443c01a7336-20b37c0e8d5mr43831435ad.58.1727442253240;
        Fri, 27 Sep 2024 06:04:13 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:5a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37da334asm13375065ad.105.2024.09.27.06.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 06:04:12 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Paolo Abeni <pabeni@redhat.com>, Dmitry Antipov <dmantipov@yandex.ru>
Cc: John Fastabend <john.fastabend@gmail.com>,  Cong Wang
 <xiyou.wangcong@gmail.com>,  Jakub Kicinski <kuba@kernel.org>,
  netdev@vger.kernel.org,  lvc-project@linuxtesting.org,
  syzbot+f363afac6b0ace576f45@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: sockmap: avoid race between
 sock_map_destroy() and sk_psock_put()
In-Reply-To: <80a295b9-8528-4f37-981c-29dc07d3053f@redhat.com> (Paolo Abeni's
	message of "Tue, 24 Sep 2024 10:23:57 +0200")
References: <20240910114354.14283-1-dmantipov@yandex.ru>
	<1940b2ab-2678-45cf-bac8-9e8858a7b2ee@redhat.com>
	<b9ff79ae-e42b-4f9c-b32f-a86b1e48f0cd@yandex.ru>
	<80a295b9-8528-4f37-981c-29dc07d3053f@redhat.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Fri, 27 Sep 2024 15:04:02 +0200
Message-ID: <87bk096yf1.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 24, 2024 at 10:23 AM +02, Paolo Abeni wrote:
> I guess that the main point in Cong's feedback is that a sockmap update is not
> supposed to race with sock_map_destroy() (???) @Cong, @John, @JakubS: any
> comments on that?

Looking into it, but will need a bit more time because I'm working
through a backlog and OoO next week.

@Dmitry,

To start off, could you ask syzbot to give your patch a spin by replying
to its report? See instructions following the report [1].

Thanks,
-jkbs

[1] https://lore.kernel.org/netdev/000000000000abe6b50620a7f370@google.com/

