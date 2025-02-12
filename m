Return-Path: <netdev+bounces-165339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41747A31B39
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A1216664E
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 01:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465983594B;
	Wed, 12 Feb 2025 01:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhtfBkhX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F38F18651
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 01:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739324120; cv=none; b=sVoki6iFtgroh7c7yvmcUnRtyF6ifS8QXVHvoGALvlOoYqkSz1Htumnn4/H24N+n/Q7dsARwrlpzKywliWZkteAw65AWL/BOXVrvlJjDHNNP46NJ7TjiFPkX4/Mv9JE9lsBVB/znWBDDs+FXF1aoWFfetDppMEB7RjNcXivYflg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739324120; c=relaxed/simple;
	bh=vO+WJ4VJXR7bbXMtYnlPlG0k4IRBuX2zxZR1cgxqtEE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Q4H186noyyxy9NGuCGeA9sWy3ItXvS0RRN/iYCcBQLmbjv+GwhnsK8udI9JMFuaKftbqW7Rp1HaKnnRgxylNCRHqC52qDQqD1CmIpkWeGJXUeWChcJ37UNxFwBYM9FPdM55pN8U8K2QouU/+4OGxNecq2zjljJgiw4n41nUOrfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhtfBkhX; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e442b79de4so51484186d6.2
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 17:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739324116; x=1739928916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mgfbwos5PFULrwjZnRvt/VVwqXTiuICudXc+3HMLz5w=;
        b=VhtfBkhXKyjb/lC9xkKhFiWHNNotn3Eo1brubd6ccNSv+WK5X3Xru0lpUDFKUXWLK0
         lit5/xclHKn9Dx5N++V8kQE4jFyFmQfa/GISlnJjgF6uiFrefZr+9bDj30216wcm6G3/
         po0A/leqI0DvYZiNozxa2ERUlMp3PyQCFNFHY1+/TB0mgLTHPoY81ty0y2SqIcM7NkwF
         +qB1RdrRSt2R1QIg2J081gfh9t5lAwLs9EjB/PK96L8W53AOoQ8zfzKn3lU52tJh5YAc
         K0jIux8rHn5y2F6tlEFO7KFvCdLVEXkivn3ULFwExMlWj1J3Jz6CC8Tqj9pdG3UI5YFh
         QfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739324116; x=1739928916;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mgfbwos5PFULrwjZnRvt/VVwqXTiuICudXc+3HMLz5w=;
        b=DK7zRG5F/JF1d255is+acMXQjzXoHG/wWvcOf4/26mO/CVdfLLGVztmZst32eZS7B4
         jakX5jMJ6Md/JB6LVdNDrr9NTRoK0WZ6taf44DOHpaa4ZGQiohxkPmG6IAS7tYH7ZV7N
         wWwpUI3FWO+LG3DGm4s77LGxd3yp2ayg8GqOA5Hedb/lRFmu66gW39ACsp329rPnKq9P
         eeSmLO26SGGm2M229gSWZIzGYhibkgQ9tU9MoXbo8YNitmTNTUW0Wbaq8RiQF5XeZ1C1
         U9G9lF/Dk+W4ijVLK0pNggX25FhaiN2luZWwbwusoKV4lY0MJemtbdsQUOQr4cX4z9zO
         eFYA==
X-Forwarded-Encrypted: i=1; AJvYcCXudKoJAjFDyeqWIA+Qk1f59VqhomF/cH6DuNbF3pIt5H9kUhRPfQw37ekq7pXEcUqVdBBkTqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxuqvWQH1zjTeUncXHGRiW2j50NKg8LguzqPKzzEyznPCYZEvm
	0BYueAGmPfGnFvHXB7ZLmoz48Vvm7XelzHOLtvPsCvzVFgfwI1OP
X-Gm-Gg: ASbGncuhvfXnA/zBuLCnEm8kIPhNoXnq8zATWVlsSp28SnbKyQXPa/cTP9485wVvueY
	mDd3pbeqVAIjp/D+7xf/VVRtYTzpvpow9tJ1JGL6bO1a5xqV66yV7mBuiaIxw6OLtw80ZjDsHtv
	YA+7wv70tNamPr/iz2MUd5JSDfi3ePfCXvYjsAPtCjWNyC4wLPihrz8vxg1cZ6MDeMx01rQBbpQ
	Akr1OlgFB2eiZtG2qI6IEngitBL8dZ2GOqz/+FP1lDPLUWTxkA+glmjnyuyQKVWhNNoMXV5PT16
	ZXyJS4aKOuhZMjEGmkAp7oFXJSvbQDvhVMYlG95OhE3rWFoSv+QK+USpLzGlXOI=
X-Google-Smtp-Source: AGHT+IG9Mv6Pc7aKX5rI/G7i8wbmGj4+0PYrp5rZETEtA6tFBye0xEvUxeSXKsI8VdUpB85EoYGUvw==
X-Received: by 2002:a05:6214:d4b:b0:6d8:a5da:3aba with SMTP id 6a1803df08f44-6e46ed8a83emr29232876d6.20.1739324116488;
        Tue, 11 Feb 2025 17:35:16 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e455fdfa75sm46056876d6.60.2025.02.11.17.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 17:35:16 -0800 (PST)
Date: Tue, 11 Feb 2025 20:35:15 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>
Message-ID: <67abfad3bec90_155892294aa@willemb.c.googlers.com.notmuch>
In-Reply-To: <dbd18c8a1171549f8249ac5a8b30b1b5ec88a425.1739294057.git.pabeni@redhat.com>
References: <dbd18c8a1171549f8249ac5a8b30b1b5ec88a425.1739294057.git.pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: avoid unconditionally touching sk_tsflags
 on RX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> After commit 5d4cc87414c5 ("net: reorganize "struct sock" fields"),
> the sk_tsflags field shares the same cacheline with sk_forward_alloc.
> 
> The UDP protocol does not acquire the sock lock in the RX path;
> forward allocations are protected via the receive queue spinlock;
> additionally udp_recvmsg() calls sock_recv_cmsgs() unconditionally
> touching sk_tsflags on each packet reception.
> 
> Due to the above, under high packet rate traffic, when the BH and the
> user-space process run on different CPUs, UDP packet reception
> experiences a cache miss while accessing sk_tsflags.
> 
> The receive path doesn't strictly need to access the problematic field;
> change sock_set_timestamping() to maintain the relevant information
> in a newly allocated sk_flags bit, so that sock_recv_cmsgs() can
> take decisions accessing the latter field only.
> 
> With this patch applied, on an AMD epic server with i40e NICs, I
> measured a 10% performance improvement for small packets UDP flood
> performance tests - possibly a larger delta could be observed with more
> recent H/W.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

