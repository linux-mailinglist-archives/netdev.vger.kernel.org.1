Return-Path: <netdev+bounces-123350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5536A96498E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30371F21F72
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6681AED49;
	Thu, 29 Aug 2024 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qBUA9cqF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A5F14A4DC
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944371; cv=none; b=nD97dqq+OsA6A1Ac1+J7SRhTVgJcIydKyXi0VClx7faWztuHSWmZvBhBN2x6hWsYkM9dgNVKSdiVbPLRDr01WPZohmSgh5+PN5rHFVXw0m4/k018U6Zrz5JLOQXYssx9CdikFwo3KwliY7c5RHlcrES90TsjPys1AwtC4iS4UOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944371; c=relaxed/simple;
	bh=2YXp9wBZW4mi1UokoEwKLrQnbqcDa1ydPJd6ME7GmkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqGYqGxdx5q47V3Z7cZM9MKd7wc/TjJJy2ugQ7O7BS+Wf5br0BqNp8ag56WX3v80CT2+5BAJcN+BoCp/SLEahNwVXt0VXvG3uPUR/ZJA4WoO0pr1wa58GvoEV7w29brnLPJsvv/9wDqHiRJbDvez1vY4q9gk5JwQvGl/k+wO6ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qBUA9cqF; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bec4fc82b0so3230711a12.1
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724944369; x=1725549169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YXp9wBZW4mi1UokoEwKLrQnbqcDa1ydPJd6ME7GmkU=;
        b=qBUA9cqF7pAeSJXdsI1IeYrT4XxX+JoNhS6RLz3RpBmSEDF9b7L9HM0kcpJ+WrnNkd
         L+rZnB5sWMtrRO/cVz10OMFAJ1XDWFBZ7USKOfoIzFPaIVD2VenDI5s/Ve0IL0N8AB+M
         iW5aNRHS4oBKgaNLCQPnCpQF2AvoTVOHCO+Z6PTJEBZwhO25wiO2UNhWjIjqsohBDOZR
         jM8z0OAcxvMF7KzWRwLUuMViKzE76Zh39dYWJUWnTzgnPAvWdcTN/hjyG3fWK5fyyjx8
         XxKAmh+JK9xENix8B0tvJ5mRy6PS27zau7PqGxFilVL0mICs1k/JuCd1/3Im64llyj0A
         jNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724944369; x=1725549169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YXp9wBZW4mi1UokoEwKLrQnbqcDa1ydPJd6ME7GmkU=;
        b=nyoUBZ4JeetsDdPLIkviDAiiNKSmzr+TxedQxbfaLYAeCGbE8PTWAkWw7LvKN5RS6C
         QaIn11MoCUcGOGrtMnzYlEtSwYkFDByq+spYBAGY1SQdEGE9X8XlcDPrWT5U1QGTVUU+
         OEGqHA1pVr4UzrhgAAtS/YHMWgXv1ZVel16Goa4Mc1It0izzhxzBXsjltNodirw/FeS6
         AD9eMGrX1jrfmTRN7lRNcVntrVURdc4NryQeZVu+vge3yGajWPR8EL9cs9ZYWmIMJ+/1
         EowqL+FHeaGaeHdFjB3bX8HOjSMoc6QXthKM9gRJgPYOoGArFRgFL7xJd/TlReefg+H0
         2Dqw==
X-Forwarded-Encrypted: i=1; AJvYcCV9/udA4/iZM4InFvoGZrVilCCB5dg9WABrm1T4dEw9xdb6XHaWdEai7rgR1XNhUsf+Cxhxq7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtZLzebWXlZnJN1jJ4woyg2PJIa5+aFNjIX2cgAeSILeY3dI+K
	L8lIjOWTVF/g7V+G4+dwM+Nf/9j3/F7qNibnG1bILcOMaPAT6M2qrH3lC9Ms/sE+PYAMId4PPYX
	NhQwtUPh9cmlvpUNSDTFmu4hC96KgvdgKxenj
X-Google-Smtp-Source: AGHT+IEl6sdW5951wOI8mwP8AVpQKe5mxCQYpTR9SzoZXOqex4+EEI+X4CYbpYBqfDnml/GAPcGUwGZj+BcyT6bcSgw=
X-Received: by 2002:a05:6402:2483:b0:5c2:1905:49cc with SMTP id
 4fb4d7f45d1cf-5c22019e036mr3706356a12.18.1724944367809; Thu, 29 Aug 2024
 08:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829035648.262912-1-aha310510@gmail.com>
In-Reply-To: <20240829035648.262912-1-aha310510@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 29 Aug 2024 17:12:27 +0200
Message-ID: <CANn89i+sy3Sgg8Ux8M1rmdKhBTv=vJfzVB06MS0tk6uztr4Eqg@mail.gmail.com>
Subject: Re: [PATCH net,v7] net/smc: prevent NULL pointer dereference in txopt_get
To: Jeongjun Park <aha310510@gmail.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, dust.li@linux.alibaba.com, 
	linux-s390@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 5:57=E2=80=AFAM Jeongjun Park <aha310510@gmail.com>=
 wrote:
>
> Since smc_inet6_prot does not initialize ipv6_pinfo_offset, inet6_create(=
)
> copies an incorrect address value, sk + 0 (offset), to inet_sk(sk)->pinet=
6.
>
> In addition, since inet_sk(sk)->pinet6 and smc_sk(sk)->clcsock practicall=
y
> point to the same address, when smc_create_clcsk() stores the newly
> created clcsock in smc_sk(sk)->clcsock, inet_sk(sk)->pinet6 is corrupted
> into clcsock. This causes NULL pointer dereference and various other
> memory corruptions.
>
> To solve this problem, you need to initialize ipv6_pinfo_offset, add a
> smc6_sock structure, and then add ipv6_pinfo as the second member of
> the smc_sock structure.
>
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

