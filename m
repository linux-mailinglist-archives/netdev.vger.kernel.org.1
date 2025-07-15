Return-Path: <netdev+bounces-207282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64126B06921
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0C9E16B6B8
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 22:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C4C2C158F;
	Tue, 15 Jul 2025 22:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Myg1qsWM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711CF14B08A
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 22:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752617646; cv=none; b=BYPmSJVNooDSVzUpGsiPBJ+/tsshqDQ8y9T9f743q/e/6wZvCIVOLwibXGvgkr8/ZMCyaF+2fgezcARnmqD9uq7VPyHjxXCMP0iO+7lXb5wIJ8yYgEVB+VyyJWVdvormu2oKSl0ulo09tJUA6X5b6STc5sAYj5T3CkYKBE8fL9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752617646; c=relaxed/simple;
	bh=9unkbb+digCC/RSTta8zvzheszaF3akf/FWo3P9GnFs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uoz+ioWsUsu0RUUlanpmoxR9/twIaNlefygzbWJfV70VYZtaucpE0+zEzKLXJIggO9UUxn42PgfldWqDdbgfS9rV4lhxolqd6d+TgcO5fKsjUqvdDqg0jjUPbzIMXWZemI49qkedj8uKwMt9mNyi83JpHdniGSDv0x9EWopgGV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Myg1qsWM; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23632fd6248so58622545ad.3
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 15:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752617645; x=1753222445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SLj4jehQsIo073ngckKcOxgDkyfk0C1kjZ6lTDpSxro=;
        b=Myg1qsWMaogJSN39hRPaAltzJfJLVhQLbKA5DIYBbxZMAmIp4N5pvTv1w9+eiWXNbA
         JKz5xHhaHajZYcDeRMoVZY2nfx+AcStbNd1otOPSTwO8gV7XQ2nBBDNPN28OoUPe/Lky
         PzBNuk2Yk3GkCgTJL6NDo5w2nbOsHhy9nNV46tYaNyzInbdMlsbc/aHn/Ei4u0Nv+Pdk
         1/Xsb+1+gHMDfCbLQaETothmWNT3trEMs8hbyfPma52Ow8DDmMfgVIc3fH4aeBBXVJv+
         Rhx6cpkdYOmtgwtkJsVtYMzhXgTRmzCwV/uMXFgharcja1dlI2GEDonZ7vF4q03+nhU/
         nKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752617645; x=1753222445;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SLj4jehQsIo073ngckKcOxgDkyfk0C1kjZ6lTDpSxro=;
        b=sne54MaRlIEiikFogSsvMQHFnBM3lhuwLhK2aeS6iZKEWqHkWKncdyYIyiE96ynWsh
         RKFkQ1ygaV6OwQUuNQvqbIcKk1KPupGp9VKAMUQW5laTMFEp2FewOIY58GdF5oAX3S3X
         gQ8OijPArcK3LcoJyJ9Go1I4IsLcV4EE6sufinvLmXkFP53GwPXGqmh9sp1BoPQOt55z
         NcCvB7vTe72iIRwcMTYxbGfNLJSeptXW+ux5A4WH7Oxavozm7hkCluOWJzMHPSAD9/M1
         0/vVXRu2G+AZSEll5NPo6cQytd0HR6IXVOs2kjLjeN/pYGI8dgVsmylZW2Nh7miPoyPU
         9uCg==
X-Forwarded-Encrypted: i=1; AJvYcCVAUZ2G1SBo0nvTx7enRSdQZZXKN0LC+9xG1YpdiYB+aY/HlslZ18cMP4RxWMVDidRM2wm4WqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH4N508GcT0cKoaAOD0BoKBRTh8QZA52oUNW7BSYkx55cU2yxH
	8++HLt61AOdlkyXx3D3ckozDD0JDKXo9LMcjGRkt5a0A7z2+mJMmV6dHPRBwDPvdPEzaE63vmNC
	3zQ3csw==
X-Google-Smtp-Source: AGHT+IFQ6KNYaLj1GO+LXqw7FJLIO2JGvORU6MZLol7Oecx/HZ1VDHVoLnEBoRV3TIoB2MYd2sHC045nRJM=
X-Received: from pjbee13.prod.google.com ([2002:a17:90a:fc4d:b0:313:551:ac2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:fb0:b0:229:1619:ab58
 with SMTP id d9443c01a7336-23e25770d12mr5431475ad.43.1752617644715; Tue, 15
 Jul 2025 15:14:04 -0700 (PDT)
Date: Tue, 15 Jul 2025 22:14:01 +0000
In-Reply-To: <20250715201637.GA2104822@ax162>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250715201637.GA2104822@ax162>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250715221403.1339526-1-kuniyu@google.com>
Subject: Re: -Wuninitialized-const-pointer in net/phonet/pep.c
From: Kuniyuki Iwashima <kuniyu@google.com>
To: nathan@kernel.org
Cc: courmisch@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, llvm@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 15 Jul 2025 13:16:37 -0700
> Hi all,
> 
> A new warning in clang [1] points out that dst is not initialized when
> passed to pep_find_pipe() in pep_sock_accept():
> 
>   net/phonet/pep.c:829:37: error: variable 'dst' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
>     829 |         newsk = pep_find_pipe(&pn->hlist, &dst, pipe_handle);
>         |                                            ^~~
> 
> It looks like this was introduced by commit f7ae8d59f661 ("Phonet:
> allocate sock from accept syscall rather than soft IRQ") if I understand
> correctly. Prior to that change, both calls to pep_find_pipe() were in
> the same function with pn_skb_get_dst_sockaddr(skb, &dst) before them,
> so dst would always be initialized. Should pn_skb_get_dst_sockaddr() be
> called before pep_find_pipe() in pep_sock_accept() as well

This sounds good to me, and AFAICT, there's no fix queued for this uninit
issue in net.git.

Could you post an official patch ?


> or is there
> some other fix for this? I am not familiar with this code, hence the
> inquiry.
> 
> [1]: https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd091d441f19b319e

