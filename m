Return-Path: <netdev+bounces-202001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ED9AEBEA2
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 19:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D44AE7AEFC4
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 17:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AD32EACE5;
	Fri, 27 Jun 2025 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4OZVbf2H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79482EAB9F
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751046896; cv=none; b=AatadrSRtKSQcTqTijZ4eBoVxe5EOxxdmPvJYCe1n5uEyKA15Ia8PkBlGOhOn14UMtYh9XeTPPBDBzJi1BX0/wvKOCrZQ+pTBdnIe3qGEnfCOXXXCnbVxYjCnCOVJGuIQdV8b1Bzok6WJsHn7dVtQcaVqrRhtefuwgX3mtT5VZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751046896; c=relaxed/simple;
	bh=b5w+lU9rcQ+RqIIhXyZB3iTmrFa2oB+GQ5tTu0H2RRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWgJZkg3JJVYS2ML7GqQ/m4sTQsUm6xd2ies1bGsHH3ty5t9CD5xko0CN80NAPhKg/oS15Om47UZPurT7wC+keE4wWBsp1tUwIUUiV4s0PJPkLFjanb7DOQEbeMdl7gOEQ4OQn4q/GsCVCeo4JGa/aAu6rnAcRrf6JBBvGQQD2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4OZVbf2H; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b34c068faf8so2822484a12.2
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 10:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751046894; x=1751651694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5w+lU9rcQ+RqIIhXyZB3iTmrFa2oB+GQ5tTu0H2RRg=;
        b=4OZVbf2H6xUzhkjlWGg3PMHSuwVtA/R5RRFv6dAb9g05edpVpYsSbXkHkJR4TGs2+F
         fwGhMUaq/8hrjiUJdK7g47D+s/KrHVTNLnl0P3+B1t0XTcEXoszG/zJSA6yJMAzW6CtX
         IBEofFt9alXoOYXE/K4JwpwyqnzD2VyFUv+mgka1r9Y/gbhdoXXgYJNvjL1fedXUYS3Z
         fCkP8G14pkBTEN9KtFt8GUfTPUR5K11zp3FSGnQkAUmQDI4aN9Bqa8dOBD5wO5b8x/lI
         ggXnw/PwOQT+zwJP7fxQFONq3EGnkjmMu0AwDuKMRhKVwWq1lrjjTspzC+hkPreSXZ2e
         maYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751046894; x=1751651694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5w+lU9rcQ+RqIIhXyZB3iTmrFa2oB+GQ5tTu0H2RRg=;
        b=ni+mrOf1CLfl+TKMZbjsKlTDINP/6rmxiRUvBU0iS1SDfeyovxsHiJihdJddIiwHGk
         RG5fWolNwu8VWhYDPpX2OKOZiOrRbzJml3wyzsdP9WLofEAgNRi7y6zaOeZRB+XW0PaF
         rYT4d5FWUBaWQk7CsIyOwA8nHaXLJop3w3LTgNLBRZ4kYnZ2KKkXwFiuEkm+iWAXfCt3
         lAF1Vb8PodEZSEfaJdQGDk4fzRZHMuskY6jY1l1gq9cGi73DIr8jZT31dycdF3v92Ot8
         9LOgqcjFr6h51Qv91cwCMPJRlG2XoTyNIFwbnJaI+n4/ed97DgsVXjaZpWnsxJp69Y7l
         Kcfw==
X-Forwarded-Encrypted: i=1; AJvYcCWlfG5Ft2xZYGt/9iomUdVZg6nMgdMv8EYqBE/pjppkCMozn78pwXk24nufBnm2ToNwMj/cGEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh9Y+0FvLxU3BlMWHlrYfP+Qiv9tBcp9tX0PmItU/Ky0zrsVFu
	OK6CMogCkWQsVWapxH/qAOZM1abjE5ZfuiN1/kEaZiW+VDSWkym6OLT7x93mxOYfolPfEANto7U
	vszTM/XgFZsErFy3hzazRtJnP3FV2gE60w8eGbOOE
X-Gm-Gg: ASbGncvmkAy1v9e9c+fbvyUeF3gVgZ8DUlvRX/OngGzKcxjJPw7gK7vhysGbBcheBCf
	2sRujZyU0fmgPg0D1CgKK583CJmroCAjkjwRBtzIZJDoqgoIDfDinj9jo9kJqEsr3MJwkUZLqut
	YQoRpv5vpaxxCgrAKwUc0U3SFbAaPnywGtPg+Ky3omulFwsaZ35dOMh50jpfS7RsUSoshBi1AuH
	A==
X-Google-Smtp-Source: AGHT+IEz5VXwj1GYmNGJmEDfcwMZtECwIiU/xHxifSuXuaNMZLaxgOrLmS9VATNv/ybdUyfSYt9jmAPqzXMcSURh9x8=
X-Received: by 2002:a17:90a:f944:b0:311:9c1f:8516 with SMTP id
 98e67ed59e1d1-318c90f75a9mr6226632a91.15.1751046894024; Fri, 27 Jun 2025
 10:54:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627112526.3615031-1-edumazet@google.com> <20250627112526.3615031-6-edumazet@google.com>
In-Reply-To: <20250627112526.3615031-6-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 27 Jun 2025 10:54:42 -0700
X-Gm-Features: Ac12FXzwA-gz30EXekgtpxH0yBtBkUUnrO6RuFvwWsNFqOqT64HZ8XKz8BlSi1s
Message-ID: <CAAVpQUCTdDAmfWjz0y0RXkdWuJ-Z9cBGh1rir1GXGBNOxJKvjg@mail.gmail.com>
Subject: Re: [PATCH net-next 05/10] net: dst: annotate data-races around dst->output
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 4:25=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> dst_dev_put() can overwrite dst->output while other
> cpus might read this field (for instance from dst_output())
>
> Add READ_ONCE()/WRITE_ONCE() annotations to suppress
> potential issues.
>
> We will likely need RCU protection in the future.
>
> Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

