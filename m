Return-Path: <netdev+bounces-92615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E3D8B81B3
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 23:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B928B20426
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 21:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457A41A0B07;
	Tue, 30 Apr 2024 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QT+YxEKZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE868F6E
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714510861; cv=none; b=DLIfspjNaRauWQfNZb/zUNTQBjhn0UWtP8+c69YMGTq/gLZ9oxiEXvpJYSwti5hymEPBQIU9pNLBp/dLYcIz+J3qdtCF0FY53NUfJx6c5qkcCm8R3ES+kWJqM9CZCDoFjKBUztDaso+eR3tWAySUaMcF2Vk9iInxWXzVMGPnJmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714510861; c=relaxed/simple;
	bh=9sgfqtMsWzv9o+g9mJtMOps7EusW138bXsllLt5r/dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlAIvLoHHDs0xfpZBRZSLkrKlV9dqkrBFz2DwBtnNnMrryZ/+5VdRu4A1FC9Nw3xDVm9UmkKhyFGPa+0v+CvNWw27P5rnAj8nU2M9uDk/s+pG8Qr3Z3zhrurVSrdGlAK+mGsKZRRW8hkDkESd2aRcYa82WStKhG592c6S1W/Hsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QT+YxEKZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e5c7d087e1so53559595ad.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 14:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714510859; x=1715115659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+xIU8q6pWM6w3NaeJRA8h8N2JrHznXlpLpQKHyO9q7I=;
        b=QT+YxEKZtYluZXnVbk5NdogepPybv1HDFeWh5NSGV45V3wCpBtvYa9QrKGLCNBS23m
         YpNSgCvLvbYH1kOop5lg3GIEXIW9J9hQNXIB5s4HZONXEDOtbxXnBlPVWsWVWWs88DE0
         HYTfN2XDACzmZ0sH6mvc/LXFGSb0Aozqp4KLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714510859; x=1715115659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xIU8q6pWM6w3NaeJRA8h8N2JrHznXlpLpQKHyO9q7I=;
        b=ahONMLhfxVX+Nb9UgDa2giVBgF9f3wKkilLpzMzAjwHYOhpza9dQcvpoFouNKJ5zBT
         jNesfZ6psgWhTjzmcuxcT+XoJRCJdY4SlLaf2mBridZhZGjlAySQMREtfu9mqo3b8/TX
         tspKucMHMuYE3a9SmegOSRs4c1Ms9JLlG6+c0DdX8AROPsNwEBO/C8UVlX2BajFjjJBU
         WCBdqZleDgnw/bZSGxe1n4IiW5qeaWnwjEr41I2FuuTSNBAlwPK01lWKkbShLvjpqtRM
         xrK0HMgHhfo2k2JViM1jZqmAQX7h7DAYDu2PXfRaBnF73ZjOX/Y9Bg4o7UM7r0NBFIYK
         7f3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAvipcH+MmfDxMxtX0GHJrgudO95HqLPeGjO8tKdiglxgCgAlCYzDClpSklyRRsr6g9FLfOAaBUWrwNXa2JaTCbnf4pqgR
X-Gm-Message-State: AOJu0YzsHCRQt0yt0N3IW/JTyMvMVXu3gEFkJnZRCd7vje8Ri1X1a+Jo
	+6md5SndkC+OAeiR7nEja666mwjycp/sSFCrtWVgO+B3vUYnGmEc4wJUf20o8A==
X-Google-Smtp-Source: AGHT+IH/WlfSNtBhlJT6297Q0jgt35RvMUkm+sIKHyYlwaLfwwaWwP3me/gfM/Q1DQBlkcUJBS1qxQ==
X-Received: by 2002:a17:903:228c:b0:1e5:9da5:a799 with SMTP id b12-20020a170903228c00b001e59da5a799mr676864plh.6.1714510859313;
        Tue, 30 Apr 2024 14:00:59 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902c3d200b001eab1a1a752sm10560810plj.120.2024.04.30.14.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 14:00:58 -0700 (PDT)
Date: Tue, 30 Apr 2024 14:00:57 -0700
From: Kees Cook <keescook@chromium.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Nathan Chancellor <nathan@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wifi: nl80211: Avoid address calculations via out of
 bounds array indexing
Message-ID: <202404301358.CEA4B3D@keescook>
References: <20240424220057.work.819-kees@kernel.org>
 <e2f20484fb1f4607d099d2184c1d74c6a39febc1.camel@sipsolutions.net>
 <9983345a-d590-4a78-94ca-6d96832860b1@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9983345a-d590-4a78-94ca-6d96832860b1@quicinc.com>

On Tue, Apr 30, 2024 at 12:59:57PM -0700, Jeff Johnson wrote:
> On 4/30/2024 3:01 AM, Johannes Berg wrote:
> > This really doesn't even seem right, shouldn't do pointer arithmetic on
> > void pointers.
> 
> FWIW I argued this in the past in another context and Linus gave his opinion:
> 
> https://lore.kernel.org/all/CAHk-=whFKYMrF6euVvziW+drw7-yi1pYdf=uccnzJ8k09DoTXA@mail.gmail.com/

I was going to make the same argument. :) For this case, (void *) is
superior because we need to perform byte-granular arithmetic and we need
to use the implicit cast to the assigned variable's type.

The reason not to use the channels[] array is because we're not addressing
anything in the array -- we're addressing past it. Better to use the
correct allocation base.

-Kees

-- 
Kees Cook

