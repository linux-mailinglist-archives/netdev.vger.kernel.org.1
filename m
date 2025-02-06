Return-Path: <netdev+bounces-163368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0555A2A066
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 06:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B50A161F6A
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 05:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA021FCCED;
	Thu,  6 Feb 2025 05:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yRL96M9N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EF213C80E
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 05:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738820960; cv=none; b=UwMEsUD2c1d9roWLyPxfM2YYdLdslH9zfS7ade0gbIFaLS0KN7chyXW5tsplV/6t30QrfPtOU4Wkbq5StTHl+GYpLp1noecPMLVZdjYRZVlTPZ+o1H/SN5H3h5P7ZIXQg4DKbj4yZy+vjoBSVPjGoEAVw6ClDaDqgocK15AgzAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738820960; c=relaxed/simple;
	bh=2EV+0dVO+9e3OU9XcmDSi8tIgcbigrMWknYTtdHp5RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s16kDKh51fBtEUd7BmvugMCDtXrBl3TNCrmrgGB9rELO4UOYMT//f/19hwdxQ4z4w0cSt0T7/x1r0p80PvbwF2GV15+ZVZsAwOB2JfUaaU9bdsM5As0vX1RUUEDsA53nDDp3jWgpdwcP7XI3vUfNbl66MShU8nveCfPxHny9P9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yRL96M9N; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-435b0df5dbdso33385e9.0
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 21:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738820955; x=1739425755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EV+0dVO+9e3OU9XcmDSi8tIgcbigrMWknYTtdHp5RI=;
        b=yRL96M9NDsJK61wi9kCVMIlZKAf3H+SpXuBW5s9pQ4ob32s7Yo/PYf2TCUqTtJPDiJ
         v754V9Odl9WpiAcMmWlOw+oUCisT4gAr3rhQUJPsRk69EnUA+SoKSvyyDWvEe1RDkkQv
         A2Z7L/VVr+Nfz0DIbjYEf844YJzqeyU6umUY5KwBdJF+lbgbfKnOqPxC0GJ76A3WzLJx
         LWtbuCBaF7G+NjTziDmUoeHRip7Re2CTF8BjpIAkPu3jKixEof3tQIr2Rt7Sz7CMbGby
         XCjoKhktPG8s54aoSpJWxM2MsnlHF4wJZalZRrKHGRVI4oFDRnWEMTsmJ/2CGwIrgcLH
         FKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738820955; x=1739425755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EV+0dVO+9e3OU9XcmDSi8tIgcbigrMWknYTtdHp5RI=;
        b=XBXtxD84mPv6Gf6QgNvjgeN8/poRtsJLgEmRUSXNRF0du2iERfHA7VHSmcYtDC/Stk
         KWmqBbQiOkTe6yspIPOEZP3oAGfXbHwrZMQ7LhvOd/krPxdKJx9w2Rv0/NZ8aGNaYEIo
         K3PTdgifAsdU3KHzk3vUypxXpzT2OHssRXxqzlfcwVV5imSLIVn6CojuTT0j4H5mS7Z2
         iPUm3gqvhCSvtpyjT8MwqQrc+6+SzaiR47uHL1g5JaKInkMI5RSbV62SBYQnIanSTsj6
         kXDH3t0KFN9Mti6elzuApUULC3l/Rv4dpWqqtWgEIPFkGjejR3YTzONFfDcFl2YVmXhy
         RpYw==
X-Forwarded-Encrypted: i=1; AJvYcCUEEtJVGtTyQdxH/ZeCYm/HBBXIMzdHvT/5nC+O+B7fcKitcWooAXXQDyKURa9F+slA92SSYLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuKnxt7iJKl/w5uGMvKB7SYXDSwvLN86sKmB6zULFqzXd4fPle
	2alrTPzo6TCUU1MEos0nRiqgreaWBEyYr3PMPXDcxlRMlyr2TUzJ+Sdcy246x39Y+he0JDMfJRi
	5Hfe9sBPnpEnDAxHtD8rCPiSOQwEBcDCsFWzT
X-Gm-Gg: ASbGncvmdqnortOgSLuRK3OOpQ2Eu3ftu+JCUjxeDhDpfMbo9MPLdHl3tA+/UD74HKG
	Ol8EF2IdSd9pPTyakvGtuuhDkrbO10bjKFWhKrzqcxkyQpnPGyFtF6vR65tlRexKHPzpIYLD3SS
	uYQkYpNyG+FFBM8VjLQigOqgngUQ8w0Q==
X-Google-Smtp-Source: AGHT+IEkWEVDmlICL9iT0oymS6WBfnCOi9Lt65B/wurCQmCJ8meLePdtLtlEVmpuFhq03p4wV6VEhAMcMHhPfhOcJrQ=
X-Received: by 2002:a05:600c:1d14:b0:434:a0fd:95d9 with SMTP id
 5b1f17b1804b1-4391a84fb20mr397565e9.5.1738820955416; Wed, 05 Feb 2025
 21:49:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205001052.2590140-1-skhawaja@google.com> <CAA93jw7tVyiz6Kj8B5zXMqYKxLZSnctGiwbH5hC+4_ZTWpg3fA@mail.gmail.com>
In-Reply-To: <CAA93jw7tVyiz6Kj8B5zXMqYKxLZSnctGiwbH5hC+4_ZTWpg3fA@mail.gmail.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 5 Feb 2025 21:49:04 -0800
X-Gm-Features: AWEUYZmInHWIYAo2TJm3R4r2_Yaw_QajD6vum33kRTSURSn3tSl4I-N8bEcRgrE
Message-ID: <CAAywjhRd-tQz3ra6uUvZf_rwTT+5a04BfeA59bcG8ziW_4FLWg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
To: Dave Taht <dave.taht@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 9:36=E2=80=AFPM Dave Taht <dave.taht@gmail.com> wrot=
e:
>
> I have often wondered the effects of reducing napi poll weight from 64
> to 16 or less.
Yes, that is Interesting. I think higher weight would allow it to
fetch more descriptors doing more batching but then packets are pushed
up the stack late. A lower value would push packet up the stack
quicker, but then if the core is being shared with the application
processing thread then the descriptors will spend more time in the NIC
queue.
>
> Also your test shows an increase in max latency...
>
> latency_max=3D0.200182942
I noticed this anomaly and my guess is that it is a packet drop and
this is basically a retransmit timeout. Going through tcpdumps to
confirm.

