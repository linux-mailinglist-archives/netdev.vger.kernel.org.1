Return-Path: <netdev+bounces-176237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F90A696D2
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26E427A97A0
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0481E105E;
	Wed, 19 Mar 2025 17:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kE1Dm+dA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F966257D
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406575; cv=none; b=giJ7ctaY/ajItea3fCL/FJq4GKIcvErUJuaWtsGKc2hT/ta/YGLBjpQDVjhluVcyGG70kCoE3Q84KkwzvCbGVzcpkqw71L4jCLec0Ax4Yt0oMEI0sR09kJg9O3dSjIg7t6kjipAvoFdh/sveQj/JkZiP1NAGqMWRORQ+ihWmZkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406575; c=relaxed/simple;
	bh=3k4lFK1G2B3MD8DiP2ycvnIC7+F0RljGVUfLZDf/tes=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=O8lc7oU+HxJOTQNqEGLDnAPs+2Gmw/6z2A77yHFql2pEDEN9Cmi0z5zAqREkL74Mq5t5jZagUYM+E3a9Z4UFsf6YiCr87FtYFrotNzZPpWCjOR86Hy29IQkfsMe4b5AirNDXHos1LPCjgu97BiwfsIEAyEptOauAPAi+g1MOB8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kE1Dm+dA; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c3c4ff7d31so930603585a.1
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 10:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742406572; x=1743011372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUPzai8YCcwRIJyQvi5oAN53r7GkAP9Yx+jyPGgLezw=;
        b=kE1Dm+dAiIAkyFy5EjrlaLqfNCrxh2qaPLP8sdFSiC3TE+bsSOm11pFqhplkQorCJr
         +FUIpBEAcNEgjD7AzKzX9JwLa0WgfX2+TXTgLvs4+XY56LslfJYA+8aCUWfnzpewOAYm
         VxqVEm0qeBeL5XVvWfPYPm6opO3y2K2eWKH7PFVudeLrd9Zur5dGEFQq0OvpvRLqiK1n
         BbdxDmXW9TTA+khXhsnYpUaZmddnfHy1hLLEK8+4ZXWYD22j/8nTWAKr/nHoe1zf3VFY
         W/1y1nG/UHwIvDqqgaiZzQoPUOU5/eEdaXGNzsk+UT+aeHz+okStPLiRqKqeKR8rVuIA
         6oAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742406572; x=1743011372;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aUPzai8YCcwRIJyQvi5oAN53r7GkAP9Yx+jyPGgLezw=;
        b=wxgTdGs1sRHEub7Jd1TeRIHHBi0+A04oU0Hy7b6XDW0AwC3K944IA8hDCh71y6frg0
         IwQzm7a8e+8o4GCAPZsxRPuA7klBuXSTR6OqcnPaEiGpLjVrlCEI/R+ScBJURQ1/JbNe
         /UidtdoGJ1WQ+tEs/V5qsh4KW5IlT2bPrYEFzmNKeWz85QYxTJPFTBxeP/bKTRl0269e
         PRIUZz4sNi8wF+vqFJu30kL9sW3GNSzNVRmSxEwo9lKizzfImFPcjXVcpzX4qo2mdjta
         cnhLY/bRCpxE3j01p8If1uyvFDjGBF84Khnl1yCQbVnnNZbsNASdep4FflwqWYGXa6ou
         nGgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYaksTRw2Nj3XklNuftCcwPGho4JlMydy40XKsjTze4PAXBuX7mraXfHzm/11vZuWYPEQwrh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztETCMpCnIHohjmgn8Te93QCZ5OkiJkXc6S+8HAVlpVFq407Bt
	aGftUKn5Mkp34iulFNamhRDNsPWoEFGdcRGNzanWLvZ+ZmvL7Upe
X-Gm-Gg: ASbGnctKUf1T2Tm6hQa+tepJ+7ekTLKz8PMtJvfXrMkQ5mAFWtqsviifymsmsp32Pem
	lfyHZYDPRqTkFuX6s4KCEL5pUOE3NNkH8sZg3DCx42Bi2f5EhUa0SHqC41iujzOYQvJVItG91x8
	ypuOXrKq5rKGC/n+VwyHjcZr/youjn4EO8VDb04GYlSzq0/e6njNQ3ivCleXz15ashBB0JVJv49
	ooY/eLiPavASsK47xZYwUlDb5Gl4bkBYAPBk1Rfk2Ay2tEWvUggQeqDVcuDjHod2cXHHlpPKI92
	tuewN+tUpgJ/sWI5PFgoqz0RkDhXqi1/+lIr8RcPcMhl3oH2AjgXRHadjEpKOXqlFrBeCOoDo7D
	Zmw4s5oEH+hYfSIM/WKH2/g1qMKBPPTXJ
X-Google-Smtp-Source: AGHT+IHw/bvrDa7/yMsTTmzOOl6qEuXRKb9oyetPkbG0o31979DwnwGUIwuwJVtIDTho7svxaXIP1g==
X-Received: by 2002:ad4:5e89:0:b0:6e6:61a5:aa4c with SMTP id 6a1803df08f44-6eb293dd217mr60192816d6.31.1742406572430;
        Wed, 19 Mar 2025 10:49:32 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade34c5f7sm82668316d6.96.2025.03.19.10.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:49:31 -0700 (PDT)
Date: Wed, 19 Mar 2025 13:49:31 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <67db03aba87a1_1367b29420@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250318034934.86708-3-kuniyu@amazon.com>
References: <20250318034934.86708-1-kuniyu@amazon.com>
 <20250318034934.86708-3-kuniyu@amazon.com>
Subject: Re: [PATCH v1 net-next 2/4] af_unix: Move internal definitions to
 net/unix/.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> net/af_unix.h is included by core and some LSMs, but most definitions
> need not be.
> 
> Let's move struct unix_{vertex,edge} to net/unix/garbage.c and other
> definitions to net/unix/af_unix.h.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

One trade-off with these kinds of refactors is that it adds an
indirection in git history: a git blame on a line no longer points to
the relevant commit.

Whether the trade-off is worth it is subjective, your call. Just
making it explicit.

I still manually check out pre UDP/UDPLite split often to go back in
udp history, for instance.

