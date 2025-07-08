Return-Path: <netdev+bounces-204853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 308EBAFC468
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A029E4A4227
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 07:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CECE29ACCC;
	Tue,  8 Jul 2025 07:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njawUlCQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E4A29824E;
	Tue,  8 Jul 2025 07:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960603; cv=none; b=AKOEZiVyc+D2f9b9nTuOkZPRmidNjy4tiD4kn2UNRSyvr2LM33RrFU8btPT1Vde31mldaDZCiHkUMPkwYL33lxpCfH1/2ni8CB+ox80Bj05ggWBfjUheztMhp+dHoxXhIx7T1ui1pSh1cibscOq+7AV4nt5HGahlsq33JMrfJfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960603; c=relaxed/simple;
	bh=WXnYEsgt8EkM7+1QtfQfG21cWViulnbPG8Tn85Ma+FI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=U6ZDpF4qr5FNsZDUFzjCOmfMH4jbUDtPxHUDGIuC6QxqEst7+8zKTGjLABEvseTM6Qo6lzQfJy2XN8kC1yFk211ffdyRi1cFunnONiO1hBD1KCRwd9EpLuzINL3i2YyQY0ugxu4wT36Wdoy3ksJmtkcUMyW2LWT9GHIjGAlTJPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njawUlCQ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32cd499007aso30102821fa.0;
        Tue, 08 Jul 2025 00:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751960599; x=1752565399; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WXnYEsgt8EkM7+1QtfQfG21cWViulnbPG8Tn85Ma+FI=;
        b=njawUlCQdfon3wjb5ejUV+qhrbiFAGJljiCnWFWCyncViWWfDwwRt03H7eunX6i6EW
         FeAs7fmNjDJiYLs3rJzSd/K6ufzyDzBYiYVbz/mqkrqvi2xUN5aHMrdLblm4eWY8K7BM
         HV/iC3pIeWdPscfTQE+hzVuyCklsGn0Ypfz0TVWvYHBeM8q4NfnyKcn68kDNdnvoo6d8
         Rn+5QYLTZN1zIScjyslYLeVB8mkmzGul3Bk3ZUpLkswHH/sXmdw2QdSACMf8glAf3whe
         mc5F9cxdwxC56P/GuijBSTDPg+D/oS0i10wnxUkk8Rapivkhgid9Z+NriwqH7rib+xy5
         3LmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751960599; x=1752565399;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WXnYEsgt8EkM7+1QtfQfG21cWViulnbPG8Tn85Ma+FI=;
        b=obCmkEKuCLTOy8oBEpqvHpbwXlk7X7xk43OR8IidmZfTDp8gdizmvX7vrLaYD8h/ya
         32bv6bqO8iW5/gEsWDoE+qeXtVPVlK7ymRslxyWFgJRP80690alcsjNAytE97/O90v/Z
         yiU6W6wwHOYENXTaJFeoqQPX9lq1iMfTv9OzP4XGJaDERboRoVwOp5KCzPn/OPpbX3tr
         lFb8W3Gg+mn+TWAri2DRq1uyI1p/g3JRXGH7/9qVn1asdw2PqJhKoe51Nqi6dZWMgKzZ
         zkJ3dMnCwhTmmXWlh/xHRZ99S5OaU/9eFqxpity5lMFRPeX4E1FBL9QkkVROfoHReih0
         TBjw==
X-Forwarded-Encrypted: i=1; AJvYcCWB16JIkFn6RT5hGunEOjFeN1se2NuU9JWVTj/c8tWRFc+dNBlF6n/wTt6doGxC5o+g1l5vPK44MvKQgpU=@vger.kernel.org, AJvYcCXAlesNlTJ/t93edRrQvlnBguLbtfo3ENFLezEX6fz85eiRkempgtvGEU6WwqOSt+/aa0fu9SGB@vger.kernel.org
X-Gm-Message-State: AOJu0YyzN03KJUWgTpngBMk2RyP+mgIv4MOCTRIkJdvNzs3ujxYrIj3V
	8WnBKeQFzWAEDXCO4ag9bkRlOcYMF7TtNfd99lm9K8ga5YqVU7iaHzUIQUrYQX8ia92HoCEybm/
	9J+H9PQOtjRfBrf362qE261w6kAG9PAQ=
X-Gm-Gg: ASbGnctxLPzIRDJ9vVLtTqbYgVLuJnZEFAyHagfi1NDBQLpA/DKuC66juoBvjcDlwd5
	s0oFNEp7zejAa6hA8jok0Ubkw7n0T0V8AW3t8IYLchuOwL9N5K5KJsIU4ppaDHvjvlp1zSYaP5J
	XBj3DfDIintBRODUq53ruOMP9p/E8OjvGwMBc0Gwf2kyA9XdpZPfm9BkKtRwPAzxZQpw==
X-Google-Smtp-Source: AGHT+IHj7b8BFhk02QojVJv7fUrt/DzFhmFBeUT06DDd8nATDyrjjYnj2M7X4eymt1S8bO5Yzyx7oD3zxcxLKk6CLPg=
X-Received: by 2002:a2e:bc14:0:b0:32a:847c:a1c0 with SMTP id
 38308e7fff4ca-32f39a9bf1cmr5570881fa.6.1751960598472; Tue, 08 Jul 2025
 00:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Tue, 8 Jul 2025 15:43:05 +0800
X-Gm-Features: Ac12FXwLKmtq9b4rALUpM4p0I9NPjfvL8j7YJUwyBKRKi4ziLIoSlbrhCZsN1PY
Message-ID: <CALm_T+2C9=XT-9R+DyRVhHfADDtsbMxh9u3q1fYKiPHkyo917A@mail.gmail.com>
Subject: [Bug] soft lockup in xfrm_timer_handler in Linux kernel v6.15
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Maintainers,

I hope this message finds you well.

I am writing to report a potential vulnerability I encountered during
testing of the Linux Kernel version v6.15.

Git Commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca (tag: v6.15)

Bug Location: xfrm_timer_handler+0x824/0xbb0 net/xfrm/xfrm_state.c:718

Bug report: https://pastebin.com/mSiia4CU

Entire kernel config: https://pastebin.com/jQ30sdLk

Root Cause Analysis:

A soft lockup occurs in the IPsec state expiration handler
xfrm_timer_handler(), caused by excessive execution time during state
notification, likely due to long-running operations in
xfrm_send_state_notify() under high-resolution timer context,
resulting in CPU starvation and scheduling failure on the softirq
path.

At present, I have not yet obtained a minimal reproducer for this
issue. However, I am actively working on reproducing it, and I will
promptly share any additional findings or a working reproducer as soon
as it becomes available.

Thank you very much for your time and attention to this matter. I
truly appreciate the efforts of the Linux kernel community.

Best regards,
Luka

