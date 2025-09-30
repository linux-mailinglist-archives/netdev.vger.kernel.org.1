Return-Path: <netdev+bounces-227355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A18BCBAD0EE
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 15:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD02162417
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 13:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60E3303C93;
	Tue, 30 Sep 2025 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjgiDAm6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147D72DF158
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759238933; cv=none; b=WUIOxKFWwPJlellDDZdDZF4YrdcRY9hRD5WrINP93Tegi30dR8iLvvKPeXPcRowU+I0PElb0TpNBxwHaYGRKLsEWry8lLFPdjPTfVb4ChC3/96Hahu9jTXdGt8NIjyehiKs2+4jJBAWQ404ZmovaFB85DcNgIY68MT7Djmxxvw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759238933; c=relaxed/simple;
	bh=5VfR0+ZpkXifBGlKA227sKAgFzJSeMlUIjsSH2QVw/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lb/JvGZXDz2fz/ByqoTuX3Tjro5PtI9++18ktWbVYTW14mwIv+0IFKQi7UClgfhPTAPmgckBgo7rHYd6VrjSpPZB6GXJhQ7LbUZfg3Zke3GpXBR3bHN5jdTR+5AT+WlOlVoRLEIN6TrIAg58lEeaJ2dyP3YPbQ6r3cvZxA6LSw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjgiDAm6; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3da3b34950so432221966b.3
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 06:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759238930; x=1759843730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VfR0+ZpkXifBGlKA227sKAgFzJSeMlUIjsSH2QVw/c=;
        b=YjgiDAm6eY+UkUSBYSZn0Sk2Ax9nGsWUueV9rmcCSQkxCXyKHNC05yRmGQZGTlRFNo
         64Wo4iN0ACEQ6Edm8GeV7V8OhtjJKwnfOsZw63k9YxVWi7CH7jtDS/Mt9QoIqKNWmlfo
         yovJWq1q9BqUEyDszpShmrvqPvDqwcHCbfo2t8km/zSiN5Pbc9cMc/MUJSYGCsOPKIwC
         OfaTRfIEsGRVFWvaeP17hOgf6JC8vZW3LoXXaQDYzbRMWpup6OB5H9U/N3EWN52+hASb
         8m7slGXb4WWnTIsabL5ZOu3mhj03hKBGdarlBbyudTPuJBANNRQ9ZsXpXnF9+CKx0sB+
         iyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759238930; x=1759843730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VfR0+ZpkXifBGlKA227sKAgFzJSeMlUIjsSH2QVw/c=;
        b=mPT8dhbhima10mNT8o8WDYwshHpKMnXi8vXvB5YJcGDIOzpwaYn3mcVetT3lBszCh2
         6FtVtkn+kI4g3KFjaZpGn6ShGasKggW47Bt2c8bdIN/jMQ3vjj3a2sPyTQgbli+g7vGV
         o0f7lRfGbnysMosDhx0Q+Q7ILFAcLnRMPAYQJUT/dAT7LfkKku+DQFSh0q+V75ovxUYf
         yX9Fzy2gbKJsc7oone+CC92kU2SJCHvRvqWFI0poYwebhjjr6lIdSevpz5ecQ9QFFKzy
         POxnFf9MG5qhENP3vMooYq0bAav3iC6xWRqtjun8jResUDEFUwMHQ9eZ/xjBgVx1O4Vl
         Hw+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWq7n8KILyJWUw19vVsmeNweNGlTAynjFSv+0Ih2ktbfM/J1053xpIC+hi8zZOw134FilQWYoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMKw5Q1EQlAVCy0XaXfKRN5AwaddE1xmekJn2uyxUQbFi0PKLH
	ygkokPcYh6x8mBbN30sZ0OorR038xsr0Z2GNCKPcaifMJcVBjJY4kD7P3b1/YGTix/owOpfTTOw
	cO0Jam3jic8WEE9AHY1+RRt2wUAA8IJk=
X-Gm-Gg: ASbGncsi5NWKe3lU30lDjRvcCc7oPkb+In2LIo+eU9MWusnPfiv5ymxwT4C1yrEdQEX
	xxBEv1sSAiAvYYVRkLPx6FcYwcNhqNjF++01WVHpvypw3Nc+G4m8nexfFXkTfF7By/Xh4M61tbm
	VM3sk/KSfrBJP8iiG36O/F9hxkMW+u/rF5Kx0gZoMjbrNsvT4UyAWckfY+8XNhtgTkeeOYXx4+S
	/uzTRdg00hp+tdWukjkDLPRc1aoB7RvLxrK0l3NodKLBgMxFlxP5riCqciwWKU94ru5STI5tdp4
X-Google-Smtp-Source: AGHT+IHaQVYd6ImpL5YTGVs15/2JsWNu+7AeBWUGR9qjk8XTSmLtzWaty3ikvQfPDC2IEaImvJGIcGSNpk+GMDcILok=
X-Received: by 2002:a17:907:7f0f:b0:aff:16eb:8b09 with SMTP id
 a640c23a62f3a-b34b6449b22mr1942736366b.5.1759238930230; Tue, 30 Sep 2025
 06:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930120028.390405-1-sidharthseela@gmail.com> <willemdebruijn.kernel.30a447f86eaaa@gmail.com>
In-Reply-To: <willemdebruijn.kernel.30a447f86eaaa@gmail.com>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Tue, 30 Sep 2025 18:58:38 +0530
X-Gm-Features: AS18NWB4ZnK-hPHM15k8TTyVg96siZ4T3dlet_JRM5E66GuSMxv9aaJCvUWVRAM
Message-ID: <CAJE-K+BN8iAShdMkPUATbDD5pAgSrMUakst2+OzOvH3WkZWEfQ@mail.gmail.com>
Subject: Re: [PATCH net v5] selftest:net: Fix uninit return values
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: antonio@openvpn.net, sd@queasysnail.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	kernelxing@tencent.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 6:20=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> Since it's now only to ovpn, better prefix, which matches other
> patches in that directory, is "selftest/net/ovpn:"

Alright, this makes sense.

> Btw, review the posting rules. Leave 24 hours between reposts:
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Thankyou for pointing me in the right direction.

> stray line
Ah, will remove in the next v6

--=20
Thanks,
Sidharth Seela
www.realtimedesign.org

