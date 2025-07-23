Return-Path: <netdev+bounces-209467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CE0B0FA1B
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD81516B12E
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 18:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB81021421D;
	Wed, 23 Jul 2025 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFlaIKkB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365D94EB38;
	Wed, 23 Jul 2025 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753294642; cv=none; b=nu47yStHVmUCsYwvVAhGNJYBMFOqMwOiGUMJPFEUJY9RhqyTv+II8SU8JoN4ELtHS5Y81G26GvHHqc3h9R/rxPUocBp0Cnecz1Ae+iM/5tPeITBQNPE7TF0eRIxHswGM6fjrts3i8yZ0FMsNAHWUFc3zCjzO9ReI9k8LrkfEBp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753294642; c=relaxed/simple;
	bh=Mxapj/W6ghkGZsbzY4w3vXEDzVHjWtirUwe3EqUITS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ao+FhFr/TdZpY0Ae9JlcSzwU7yFgPwKL2VsCvWuXGZ4xg5cC7SOwG8dTD7YWLA3BX5wPXxQa/1YYzvnZ4jG80OZEvN1JSmO2FxNyRivT0KI80lXrmjaLwcQND2Zr0kxlXb/5itwMyVC3r6GViiRCe6nsWFAosETp4hlEzX/63tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFlaIKkB; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-60d666804ebso562415eaf.1;
        Wed, 23 Jul 2025 11:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753294640; x=1753899440; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RisToY55DvY0MLXrsGRlCU6n7jXckJ5IoAhRIn7EY5A=;
        b=XFlaIKkBjnikFw7vAIJSB2t7ICMoHSgNpNSoSX8PLOfBk2MjQduRdBjXoKr4DvyCUF
         byfqVADKxK6/4UNhhgnN8f3w7JT9p2Kq5cMNi/Gjuq17Q9i4NqMJhSsXL64GI7YEwlhz
         wEL/WRr2fz9JN2klqXSYx1o2yjY8CQydQkLVwLarewDN03jWb5ldx+JtxEESdTR9y5CV
         htbp1+AGR6mbrfa+VxOgk4QzrBOY1yaRlTJJtls1b2lr5frdgNx5cJWxnZde1tKNDPK7
         VJN23QRVHZQj9dkbdwBRy5sLF47OCuTqGaRW8aXRyJRALHIfYhnzZwh0ZgTv/JkwS7bq
         CQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753294640; x=1753899440;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RisToY55DvY0MLXrsGRlCU6n7jXckJ5IoAhRIn7EY5A=;
        b=ICmhTOuLVGdvi8hR2404fNBhNlqOgWtgq6daEIiwmP/b3R1my2EViyjV2LrV3mImMR
         edOynhn8+4wDTTEWy6a3Q/33M/Ola2LtNZd82Nd0K/yjo1cz+x4nBV5HpghKNaCOuej4
         6QqYl9esiIWJKtbX8RZ/n9wgt9I99SB6JPpwwCgQgtkMnafaiQ6PMJP1FUMqXs2S63SY
         zTFctkW6QIjkpZVkrRYglBvLvFC8n/T6/87PGA5mqxmrirENiGaKW0WIUAByZyfq1Bpz
         jH5nzmCFeWQCRqMsKXPsUpenppcKg3upC5hrU+vSeC38mqOZ7dtV8EdOYu/8PC0pLoCc
         IVMw==
X-Forwarded-Encrypted: i=1; AJvYcCWJeQic8GaW6Ix14mfdLOh/ETM8jlUEwIATOAVeesIQrN7A8r/QjEuHsJFaLmQl6rbAyVKiZ2BG@vger.kernel.org, AJvYcCXhRhDoyGIxtiAXi3VM/9hJBAhQTps0wdT1gtAwIcr7U1ajbW+K/axXUdrk39/yAD8HkZAcDAjx6GNMmKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7osVxD2FSVCvwFJfHfcoxm2ZiLi+S3JITdVsQ7C7HRmZKhEQh
	36zoLO/0d6QOGU9GYn5epcqOO19WxYKgos91KlFbM+jpElq01/N5iC4Ep2zQSZ+QFEWJI53Mzho
	uywSGQ0byHSZHTUvkk3b7enDpWtCSyEE=
X-Gm-Gg: ASbGncs5TjVjqnKN2iRjN4ZWQeyzJtSowGLA7ib79cOjOg8zblP9pyzY8gNvm2ZPZxm
	LrRbGEscBGmQ07C2kRi0h1UiDCNu4XO50Wmc7vI+CfhnxMfl8Xalmwkh5XMgenYvwcQrr54hRPV
	NkvC0IRwj8uIbcQMx60vpUqoRLJGyd9wSN7jKUd787/r+svCCI52XkB4KOc8plLOQpzulZPosiV
	+ohTxUw
X-Google-Smtp-Source: AGHT+IH0b5gniHC2oV6Q2cydxzDkfKC9O8de+o7IucN+Mu/rb3bzyZeGVWY4j+4HT2s4MTG/OFFbhDXhysYI9OzTKZs=
X-Received: by 2002:a05:6871:4681:b0:2ef:ad56:aaba with SMTP id
 586e51a60fabf-306a79e6abamr5612128fac.3.1753294640104; Wed, 23 Jul 2025
 11:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722071508.12497-1-suchitkarunakaran@gmail.com> <CANn89iJgG3yRQv+a04wzUtgqorSOM3DOFvGV2mgFV8QTVFjYxg@mail.gmail.com>
In-Reply-To: <CANn89iJgG3yRQv+a04wzUtgqorSOM3DOFvGV2mgFV8QTVFjYxg@mail.gmail.com>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Wed, 23 Jul 2025 23:47:09 +0530
X-Gm-Features: Ac12FXwzJdHhCWw-QUoBRjGVUQrpiSZCrI9ATw4JQ1XXd6D6Ht2zQKkMXPXNQEM
Message-ID: <CAO9wTFiGCrAOkZSPr1N6W_8yacyUUcZanvXdQ-FQaphpnWe5DA@mail.gmail.com>
Subject: Re: [PATCH] net: Revert tx queue length on partial failure in dev_qdisc_change_tx_queue_len()
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, sdf@fomichev.me, 
	kuniyu@google.com, aleksander.lobakin@intel.com, netdev@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> WRITE_ONCE() is missing.
>
> > +               while (i >= 0) {
> > +                       qdisc_change_tx_queue_len(dev, &dev->_tx[i]);
>
> What happens if one of these calls fails ?
>
> I think a fix will be more complicated...

Hi Eric,
Given that pfifo_fast_change_tx_queue_len is currently the only
implementation of change_tx_queue_len, would it be reasonable to
handle partial failures solely within pfifo_fast_change_tx_queue_len
(which in turn leads to skb_array_resize_multiple_bh)? In other words,
is it sufficient to modify only the underlying low level
implementation of pfifo_fast_change_tx_queue_len for partial failures,
given that it's the sole implementation of change_tx_queue_len?

