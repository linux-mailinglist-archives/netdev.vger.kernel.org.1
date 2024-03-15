Return-Path: <netdev+bounces-80039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9A187CA49
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 09:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC6E6B20EF8
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 08:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7FD17581;
	Fri, 15 Mar 2024 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atURHY6a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDBD175AA
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710493126; cv=none; b=loLutRbSvk2OIwMsMjY40VIoxVMpDMcoOasqemBNwNXGWaCzaYFtgDfEdF8eMuDWUWWdSN42FekFz0HF5ehT9gVhUS6bPq1psVfNv18aBbO9QoR6UvISEK3+NB2iYf+fWQtbmvx+Tr00duJVcanc1PeKonriC6lTFf1kxuuy9bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710493126; c=relaxed/simple;
	bh=ISjqis1qw3ArUV30cjVtubLuAtwrK92YIb6wMQbpHfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5C58yaSTT9MCUSIfIONwdJJ4q5q2S1UsWFo7fUi197VOWSI3SKR2XXVf3w0D34YbxirLDmNSnGRhU/N9A5G4IYRQDab5RUJCEwrCfAlfiAmJ8LflG5mFNJCoVsgRNMvAQpf5v/Vc9YFZd+6zvbOr2HsHO/r/ZqoWhlhyUXB2Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atURHY6a; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a461c50deccso218980266b.0
        for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 01:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710493123; x=1711097923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISjqis1qw3ArUV30cjVtubLuAtwrK92YIb6wMQbpHfM=;
        b=atURHY6ajYqiMZeMD8MHNIaFjkUG8Y+I1wr/uqfvu2QKsuqiobXSccu3nuw7W42nB/
         0KOuZsFcuRIskuKDWVpfv3wOkIIEXs39nvaWhbwh09ItnzpfwFQsByIiKoJ6Bc4BR3eU
         rXeFhRBkBljyGhpic1nkL+6WCIQ9tDtxsRNlK/cl+sWynDOuCCiAlty0A13H/SN3WHLC
         DZpK3j5unlh8IYWClZOBLxlywuEtQbEhw8u3Cdd6/nynHoUFf7AltgjEDGdkcenSdoRY
         rINZCwbLKMaXooNhp9jrX6ahAnrlASQziyn/E1gNNqvPXWTZdiEhkP+x1h+4vwU995+9
         JPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710493123; x=1711097923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISjqis1qw3ArUV30cjVtubLuAtwrK92YIb6wMQbpHfM=;
        b=ZbIGXWW5UOuuPsyLKJwT29Afg7UbieKqacIYaCpK3iz0Re9V0ThWRwpxwIOEX6vkas
         cCq4ooReWdp5Ju9WlF+bABF9hGhynTkYM/9WWE2V4UEEECOoiv0ucZ/hw6DSo5TLKVbm
         5SKtbyLBaYBzunetWSZd0VwQRiVA43cVDM92YqluiKTAHP2h09PvIq0caq6hRyJUY+ZN
         LIldVuYMUuJimdct5BDiwQ8iTvhIc0yJih1ZbebhkpySwCkyTmNC/hUjk3RCUmlOg7iZ
         Y/Ajt1uDFwcX652OEM24w7mv1H+8XCqEp51jj9GFGU5EwX8A3+AJ2ykn6O0zboHzdy5K
         v6eg==
X-Forwarded-Encrypted: i=1; AJvYcCV115V/CJI8i9SLCPOa4fo0FVs1hd4fTWp+BiOnu76Kfp+z2oqN5M1YQhxrhmjpoLOzzdnJzU70Bzs5PANZ67Ax2Lofox6A
X-Gm-Message-State: AOJu0Yw7DGAYMC87DAVZYSPvegO+B1373aippE7RUTQcff9205+KAGog
	/S+nPSsUKGMrdhMfi6NXpqpmACJhrQqsROF9Vkj6Xn2Qpa+bON7Dhkle6hLphbl472e/dmY7vuX
	XcymQA0aqXiEcchE6p+DLmD/E+hJhRr3zGaI=
X-Google-Smtp-Source: AGHT+IGKid5izOBNUeKCoEfQXEyFmaJnsICRp+Iff0/dPAjkUyRxt5JgjJi7B0f1qIOwuwvJxT46erMmtFJfJ5WTgfo=
X-Received: by 2002:a17:906:f118:b0:a46:5597:596a with SMTP id
 gv24-20020a170906f11800b00a465597596amr2766122ejb.45.1710493122610; Fri, 15
 Mar 2024 01:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315084906.3288235-1-edumazet@google.com>
In-Reply-To: <20240315084906.3288235-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 15 Mar 2024 16:58:05 +0800
Message-ID: <CAL+tcoAHoBY8ObNQic-M7t831gpBOjqybkOS5BE0gwmkSQfvQg@mail.gmail.com>
Subject: Re: [PATCH net] net: remove skb_free_datagram_locked()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 4:49=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Last user of skb_free_datagram_locked() went away in 2016
> with commit 850cbaddb52d ("udp: use it's own memory
> accounting schema").
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

