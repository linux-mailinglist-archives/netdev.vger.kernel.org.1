Return-Path: <netdev+bounces-204416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45858AFA5B2
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 16:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BDDA7A9B80
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 14:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87A1231CB0;
	Sun,  6 Jul 2025 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeQfykwu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BA8145348
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751811020; cv=none; b=OfUiAxvr1znCj5rfJD/2E+WrI/JnC+RqgMKn/+RC50iiT8vpoxJxseNcyzMEEF6SNO9OkLkQY7wircgwzdMjdGDUQFjKD+FlIBqZHJWarFeDHE/8X+8yvUaQUaFVmHXJHQdvacEzKd3pagygzf7q5y1IOyEhJtwrlxtq8pK0Svs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751811020; c=relaxed/simple;
	bh=3ZLmOPQGHXtaSCTMyWzrwHpD+JeYJ8AhR0F8iLpTs1M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Wd/LtA3Fd1n2iu3cs/Irc0UP1nIrXrxAZ3LqHZL2zluhGC9WZvpLIXTLGIpYMnoM/BTbMQaQyWdvzzurnLcL6XiVjBLPjr8+swc3F8uTT33ffLylZSN11Mu3wNSdB+uGDBXgIw5S0oR4kEv9QVMJTiJxZXVrrWB3TnPSWyeP2zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeQfykwu; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e73e9e18556so2083880276.0
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 07:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751811018; x=1752415818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlWWRCxTqEArF/ZxA6ho8LHXX7FoEY4n7jhzI24fGbE=;
        b=EeQfykwuhoUAiAxSiWlTC3U4nzyQawxgmuqwbwFxTC9jlcnWmoUyXrKRw2qmohu1uZ
         nj1bP6RDULtrCy/i3b9JWfBzrnAAHgavCuLr4zmIB6oL4H9QeaI8S7cwUskhiDr+IJpQ
         A8wj1ZNGP0n97fsZLke34XnwUA6bfAVUyycnoks4zwSWnNDh8q7x+s1NsjO/DECi7fQs
         VR1rGs5d4Oia8Bx52YwiRDgx5Vbh1O21+MQSzy7AsjqJnIyIwuF+CA+rbwvbG7fySKO6
         YY8QusS94eSqWqGFJWkQn1zhZd4NJP4nCi7caySrVQwqCcqFKdpRg5SALD1/WJjd2nb2
         /eyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751811018; x=1752415818;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qlWWRCxTqEArF/ZxA6ho8LHXX7FoEY4n7jhzI24fGbE=;
        b=EysCfVEPauRXoVtPG47FIlQ+/UWpnetwwQB9r1mRJ6YbbsXDos4tLZfzlxB9DjxFHh
         E50pLZmv5VNDTQAOJNabDMF9aotU3ohUAxoBLjDDMk3zdKRmu7TVgJfo3HNzqev6NuEU
         +0E59WlTh7bPCY2OClXM2EU5KOdl3bPByJOVHQXNAOo54nAsdmZ5Nz56B3nsaFTZ7Jk3
         GmqnW9n8Ek28GKtjIuy8kzKMG8Xti30ruBugCFeyFXadjip3DFuIbZcH0e461ZaekzZW
         8sMjozybUkxExRC/rE+9gRGWIaya6zVPO0BkCJm/9gUW2u2GqadXtyZacSauDeEYwp78
         VOoA==
X-Forwarded-Encrypted: i=1; AJvYcCWqLcw7CoOq3EILHHaJTyIqHSnmNNBcSUcCoJJRJCFdwx/aNfgGIoL3MwzA05QtX+Q0LPRHAPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFr4eI29CQep9U5aIdCHRkc817qCsZ/H7ppciBAvnAiBBMsX+3
	76U0DU4VEermb61Z7v+J5VEs8I4gz+b3GCz/8m1XxWmGRe3RYwzq4dNG
X-Gm-Gg: ASbGnctRKWRq+Q7nxi7XxhC84GYDuK88Ev6MvdqlKnKR5z/Ypc+TGTtrfsUDr/EMsnj
	LvJLls5XK2YT2WjhRvqvOn0KxB9VukG26hkffar80wwlkVPwF6pMnHLYC9waI+Yffb/16eYULL/
	B9dEiydIUpdbM6cI9RclXvWFAKnuFTNFdBQX6OYYOMwGbBW+dEhSlFl9ZpHkekSdqv/CsXwME8T
	nsszdGciFLaXKBogelcKefrb3sRWsplM30Xy2F5tx35rppPzCoxYCyFFzTTsYvAoCCPJQzvja9s
	KLx0pazTSNrWAfJZt06HYW+Cx+t8bAb7BXk+85SAd1/0xY4+1khdl+2ncREMBCT9TCUFyNxxl8c
	zvx0j7StFOaDRLdTsDTGnf5IWMqQBGorxZxLy1tE=
X-Google-Smtp-Source: AGHT+IGZeFZ1v1Z9Q5l9GllphahCGMZ5CRccDSLJmoQmj2o8FzOaE529ayzde9A+47UtLx02Qca+ow==
X-Received: by 2002:a05:6902:154c:b0:e81:566c:3085 with SMTP id 3f1490d57ef6-e899d057e47mr11179278276.1.1751811018171;
        Sun, 06 Jul 2025 07:10:18 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7166598b418sm12373787b3.11.2025.07.06.07.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 07:10:17 -0700 (PDT)
Date: Sun, 06 Jul 2025 10:10:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <686a83c9444b3_3aa654294e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250702223606.1054680-2-kuniyu@google.com>
References: <20250702223606.1054680-1-kuniyu@google.com>
 <20250702223606.1054680-2-kuniyu@google.com>
Subject: Re: [PATCH v1 net-next 1/7] af_unix: Don't hold unix_state_lock() in
 __unix_dgram_recvmsg().
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
> When __skb_try_recv_datagram() returns NULL in __unix_dgram_recvmsg(),
> we hold unix_state_lock() unconditionally.
> 
> This is because SOCK_SEQPACKET sk needs to return EOF in case its peer
> has been close()d concurrently.
> 
> This behaviour totally depends on the timing of the peer's close() and
> reading sk->sk_shutdown, and taking the lock does not play a role.
> 
> Let's drop the lock from __unix_dgram_recvmsg() and use READ_ONCE().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com> 

