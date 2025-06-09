Return-Path: <netdev+bounces-195702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3CDAD2003
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 15:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581CE188FAE1
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 13:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A88825D8F7;
	Mon,  9 Jun 2025 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TyRl+orA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7D025D527
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476909; cv=none; b=ooZwKAS3EHGfNkUi/7ajY5XCRDSAbJ6vD974cEmgyFk4KhRHcmmcFGe26xTAD5OnGIbsBBmJ5gnrJD8AQouEIUWeOQWdvB6IuRDih/O3qIec+9RVnysV2DLogD2UTcMi40E8GYS403Emq7DOt77eJl7vF+0FncVpPwRWmpc/nWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476909; c=relaxed/simple;
	bh=485fyvGXJ9MMD1/ohEoMDj2zFfDhnj7+hP7ypaSWGPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KrvNwKZKSWYBUeQ8gspQ/Ca3JdtW8bKP8mZHzcYx1aKYhoqK2sGnjQaOMG8/+XRjgLZx2YIE7r+yz89UtTOQ4c3+YwRSj3C4LiNxHCHjBMejBy+uQ5jes/+gHbVb2lwRCtjU6wvMnX024CsQj1KiPSJA9V5m7n+rhv1xYs1usKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TyRl+orA; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a43afb04a7so22960471cf.0
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749476906; x=1750081706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=485fyvGXJ9MMD1/ohEoMDj2zFfDhnj7+hP7ypaSWGPI=;
        b=TyRl+orAdeM+kSyFtEn/rgN4TxHdtaCmhz/4184iew/t0sNu+BaRiKwEJZm701urXL
         RaWYRrQlaK4eIrhLRIytu30QBHbbX5sd4XWuNy6DUZPXhWPt8DpOwjV/UaDLITEzsQ5j
         /LVMoDmORxVC3d03NDO6ZCVmhkyE6utYUM0E/ivEdROaITOtq2+XxpZ58Rb9+d+2EhFf
         3rlyUgHZrC3Qzx8N0570bQcs7HfklPonFWNdE2qxmzbNmeuUGzlvNqS/y01HTNKRPC+6
         TbrumHaWrkq51UZxrH1jz0WFlR5NMYZ53DFkWQy2Xxmbf1J9jpHUU7EPeG6JejOG6/o5
         BPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749476906; x=1750081706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=485fyvGXJ9MMD1/ohEoMDj2zFfDhnj7+hP7ypaSWGPI=;
        b=ZAlpNygPS2XFgHOAsxbdgWN7cnVJjqXUKmvfB7P7ywWnLgjxeUktzGbnA2SkFFSKgL
         lAYQaw24GqbnB5NPHfj65jim6ybTdDvhW/LVHcGVvMU+T3uyEngKyw8VGGLK9nfFat9Z
         HTmhJ6jqx8fvBKz2xRUFdR+6qVmxqJXjHObTANeT73rIxOuSRwvZfXBj44+zldmPEjic
         NlO5/cU20JPn90afJxeC064U5NZ4mp0iEhvqVkv9aiP/lyXOaV2wVKUPbnKZxedp1W5I
         0Qf1VcpDTtlOqSdbEkYGzzbtPkaMFyna/YdbK03J36PH4gKLuoYTGOPZpQdviJ1V7xhc
         7gpg==
X-Forwarded-Encrypted: i=1; AJvYcCVsUZdv8kXgM0FeSA7XWLMJnSLu/M5ogTWi49kJByuJrWFIFbZkaoMPgoVL44UIfDg7KdUa1Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIsCnQNinud2bY9S4rinKXp66sA8MFH5yRIT1UnZlB4+9zH6N2
	cTpJNZaZVPA2mTXVPkS2zrPCerZbk2a/NbXNuzf0IzL03QgcvuXtRfoeG44RLe/rryQ5yKAAgce
	LF0bqU+fXhjyCJugtghufkn6hPC9ftWepPXZxDfTZ
X-Gm-Gg: ASbGnctNVYbJc/TcLJtHwyOYkFomHeU978QkpVrX45c4qwrwv8LAAeqi6Qx+F7Ncn0f
	Zn+65qUmZ4SwkeWux0F3qYbfp/PCOfX0b5ipo7OpoPjDds5a+pri6Z2iMByw4aUwYFIwAakADdu
	sl7SrH8sHgbO89Bu97TDqw1p8ue19S/+d/k9FbvCN67hgkwkAFE7bOYZcrTAR/KD5HxJlFSkcTf
	fDd
X-Google-Smtp-Source: AGHT+IE3VXGpsTcil/6jK+ogtLHJlRhdVPrKlqQYS7O9rWrsXLIw0bXWqEqC3qusiBCZEvD2v85r+CoU+6GH74+Sv+w=
X-Received: by 2002:a05:622a:4889:b0:4a4:30f5:b504 with SMTP id
 d75a77b69052e-4a5b9d38035mr226482661cf.27.1749476906141; Mon, 09 Jun 2025
 06:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOU40uC6U3PS3cu7RmK71DPA_jbW_ZY0FBkBjCdjVArCiZO-fA@mail.gmail.com>
In-Reply-To: <CAOU40uC6U3PS3cu7RmK71DPA_jbW_ZY0FBkBjCdjVArCiZO-fA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Jun 2025 06:48:15 -0700
X-Gm-Features: AX0GCFvv8uJmmzoYzfjPQESNuX3bBtkvCudYICdz2lLUWLdVMF8b44y8kUhuTD8
Message-ID: <CANn89iKjjZ2rBBFjMZsPgGWi7-EwVUpJ=jMdkn2s-=BJEjvvuw@mail.gmail.com>
Subject: Re: [BUG] WARNING in sendmsg
To: Xianying Wang <wangxianying546@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 6:40=E2=80=AFAM Xianying Wang <wangxianying546@gmail=
.com> wrote:
>
> Hi,
>
> I discovered a kernel WARNING described as "WARNING in sendmsg"when
> fuzzing the Linux 6.8 kernel using Syzkaller. This issue occurs in the
> memory allocation path within the sendmsg system call, specifically in
> the __alloc_pages function at mm/page_alloc.c:4545. The warning is
> triggered by a WARN_ON_ONCE assertion in the page allocator during an
> attempt to allocate memory via kmalloc from the socket layer.

linux-6.8 is not supported.

Please do not send us syzkaller reports on old versions, always use
the latest trees.

