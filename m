Return-Path: <netdev+bounces-198319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C166ADBD5F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C24F17200E
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C649521FF5E;
	Mon, 16 Jun 2025 23:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmndzdUW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348173BB44
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750115177; cv=none; b=FrX6E4/3fVwZL7w0zZppVXZqVan1BylWtiWCPD1HcbRKqIV17cvcSaxDGJoXbDuFFe2cDBysQtVpistw1GeC6X3oB3WvQhLUZ+6jtYYCUG7XePswd8qz4jyY8IrvK1NHgF3lJW4o4QdmnepcojsnlypCd1PeezGRaVdVxx1J44Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750115177; c=relaxed/simple;
	bh=UQxiR2x2W2gVmPqx11I332qK3VMEYsGhtsfvgzSmYoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9fgjpOzqnD6WxEZdar7slQQQD0DD1HmT63pJHfn+UlPxuZ0TUPMOSGe7FtCd1hVjfmjk+bj1M1TKJKjGfzgAjJh6UBLjbe4IPkJmJ+GD1+CP7v/5YA379sJAFmHpCoeGMARTWTTwu5kOc5WmgSPdoH/KufiC4Z/M3bc9Fd/6Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmndzdUW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2352e3db62cso45553815ad.2
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750115174; x=1750719974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V30QOYj53//NyQ3uu3IS4fBPwemLlqNqN4aPUJNJy4c=;
        b=UmndzdUWed74DLkP7WR8WRH8mYQb9M+1HQBuhaq1oytCFZn52NzLfRNxggUGcpxhgC
         M4giiweuiZxaB3yoonbSLv/q4Xo8vKoY9E1HDDS84Eg7DuYspCrep45MrG84f9U5F1D6
         CAn0tcYib+PmbYxulbQi/kryC3yXaJb9FyjHXAroXcYYhWX2EOQ8RfQiD9TPUBzGLL9n
         9EW0bFTv2UM4tR27FkxOsxNymo62HvjzZwqqFObM9vnzCJE8aCxCePsPi/RORjGilmu9
         B4jSsaUSWUEcj7juUrsX+2uHuX3jwIVoi/AYa9QGNytpZ22Soajg4NhOTiGp7qSftLru
         6X8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750115174; x=1750719974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V30QOYj53//NyQ3uu3IS4fBPwemLlqNqN4aPUJNJy4c=;
        b=F+askiFhTtsX5eq66hLmUckoJSNoPni3BwQdfBNNr+XC50OIsL/hWgJ7ju2yk+kaGJ
         aZY4z/TXSol4L6eMEwBvnVpN5GgqmjYseB+Q74RsV/+hCuUyHe/rv9+Z3SmiSCsyu2Jm
         1YerORlZf4ipuDZYVblZu2DVjORrpW6181Iv06k/K0EtuMeJCoFRfWXL1me7LkoRSPDy
         NGRVaWdKJ5fEzzdT4pucdlJ/Ly7vCB4ml7JuiHUWGfxxNCgEPKiXDTx+5fmrUyojR9S3
         QOTzVA+0vJc1OJ4nm+KXX+fTQhUQwWxZTReSUsv0X9mVLJbWD/I59Af8BdMJ3cu/NhEt
         2JTA==
X-Forwarded-Encrypted: i=1; AJvYcCUoC0Uy1ADGFfHiQJI4u+A3Ytf6DMHA9YJzckT1rC1PfhxstQB+9jxPNc1HXIKdzIBj+uyO/TM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNFRxOUsMT4ii5gr5LdEHx2Rul+EDYXOMil/F7ktIPRihkEYC6
	bW1taKBW5fyfLIYs8L8EWLWVwQVU6JNiY9yQU87bWwwwyud+NRONQhA=
X-Gm-Gg: ASbGncvxaF7e3uGtgcBpnzL568GWzr/e6TtzpyEotIGuiwHw5RN3jFs/83jtv0eq1h/
	HX5UdECK7AyzCv2FRbEtjspj7qsKYpkxtGJsWlkzI6+PeazTRHJcPb+uSJeE79nJas3auIUAItv
	KXdi0DJeKT1K0XROJTF+UcUyHXk7xeUXjDa/zamDiK+0F0i3ojJ/6P6IqRYOHGGZV1BuCVAW2Kh
	gKnYzCBM29NvMoHWzDcaGfS4RQKlO4Wx5+ISvObRRQwgh6ZvfVcVpy4cHqqU8849yXFN/Zpbq8J
	mXmnJrt3vl40e7jRSsAUqP9kL+CNse+Q9SVLdXQ=
X-Google-Smtp-Source: AGHT+IG1UxDE/e4KnN/duUHi0qHKdmIdTEsPsi5bNJA4mTkbKz1uvSnbF5/OAQWACnssSVmVKchzeg==
X-Received: by 2002:a17:903:943:b0:234:c65f:6c0f with SMTP id d9443c01a7336-2366afbd7f4mr137282845ad.8.1750115174348;
        Mon, 16 Jun 2025 16:06:14 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deca0f8sm67227685ad.196.2025.06.16.16.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 16:06:13 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: dw@davidwei.uk
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuni1840@gmail.com,
	kuniyu@google.com,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Subject: Re: [PATCH net v1 4/4] tcp: fix passive TFO socket having invalid NAPI ID
Date: Mon, 16 Jun 2025 16:05:45 -0700
Message-ID: <20250616230612.1139387-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <e725afd8-610b-457a-b30e-963cbf8930af@davidwei.uk>
References: <e725afd8-610b-457a-b30e-963cbf8930af@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Wei <dw@davidwei.uk>
Date: Mon, 16 Jun 2025 15:37:40 -0700
> On 2025-06-16 12:44, Kuniyuki Iwashima wrote:
> > From: David Wei <dw@davidwei.uk>
> > Date: Mon, 16 Jun 2025 11:54:56 -0700
> >> There is a bug with passive TFO sockets returning an invalid NAPI ID 0
> >> from SO_INCOMING_NAPI_ID. Normally this is not an issue, but zero copy
> >> receive relies on a correct NAPI ID to process sockets on the right
> >> queue.
> >>
> >> Fix by adding a skb_mark_napi_id().
> >>
> > 
> > Please add Fixes: tag.
> 
> Not sure which commit to tag as Fixes. 5b7ed089 originally created
> tcp_fastopen_create_child() in tcp_fastopen.c by copying from
> tcp_v4_conn_req_fastopen(). The bug has been around since either when
> TFO was added in 168a8f58 or when SO_INCOMING_NAPI_ID was added in
> 6d433902. What's your preference?

6d4339028b35 makes sense to me as SO_INCOMING_NAPI_ID (2017) was
not available as of the TFO commits (2012, 2014).


> 
> > 
> >> Signed-off-by: David Wei <dw@davidwei.uk>
> >> ---
> >>   net/ipv4/tcp_fastopen.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> >> index 9b83d639b5ac..d0ed1779861b 100644
> >> --- a/net/ipv4/tcp_fastopen.c
> >> +++ b/net/ipv4/tcp_fastopen.c
> >> @@ -3,6 +3,7 @@
> >>   #include <linux/tcp.h>
> >>   #include <linux/rcupdate.h>
> >>   #include <net/tcp.h>
> >> +#include <net/busy_poll.h>
> >>   
> >>   void tcp_fastopen_init_key_once(struct net *net)
> >>   {
> >> @@ -279,6 +280,8 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
> >>   
> >>   	refcount_set(&req->rsk_refcnt, 2);
> >>   
> >> +	sk_mark_napi_id(child, skb);
> > 
> > I think sk_mark_napi_id_set() is better here.
> 
> Sure, I can switch to sk_mark_napi_id_set().
> 
> > 
> > 
> >> +
> >>   	/* Now finish processing the fastopen child socket. */
> >>   	tcp_init_transfer(child, BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB, skb);
> >>   
> >> -- 
> >> 2.47.1
> >>

