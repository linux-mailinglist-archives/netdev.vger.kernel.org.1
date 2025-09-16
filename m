Return-Path: <netdev+bounces-223436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7D0B5920C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C48189671A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F3E280325;
	Tue, 16 Sep 2025 09:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0K7mnvA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDC2195811
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014642; cv=none; b=T+SWnuxnidilEJ20c8kdvu+WavJok51hOCJtO4217Cte+YetGUjl/nft3hEwb1JhQskiQdniN7+2bovcrn/UOcgPZ0jgFDr1bjJgh6gi44QhZgLd9FSzWOM842kn3URr7BYRMPuDphCyK/SWA++QRgQ/ZdeH4umIak5152qz9SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014642; c=relaxed/simple;
	bh=J99elNcr4e/+AnhHlkA2O7I3j26dzybE1tK07SuLLmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7Yn0hkhDy30UbMe5k7Kn8AnnaGTjHrltDmtGHV+oWE24L8W7eh4hwevTKJPTX/REqkGc6s4HRibynFn1kZ4zdRW9n5dVEk/CawBRRhcTqwIXPQhP2pbED8WTldj9BTXzP0ZhIyGRM0JEF1S4hwUzOa0ZpgVG8vI1jMLQL7jtn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0K7mnvA; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b08c940bd76so56560766b.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 02:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758014639; x=1758619439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3+3iYiVvbI4s7dsMC5XIvmLY+aeqtqnaQaCEIYxA1eE=;
        b=I0K7mnvACTjTYn4uU2dKWmiZMYdMnfnccVtMB/RyKEI80+XpIllRSrWcJCCuLV1Mb2
         ycG4m92cfjwOdE9uO8y0h0vX2TRjLXyHYiaNszWDpvISjxSqQt0jM8UH1F0New/lloKZ
         9WLiSQ2TiC2XiKM4AX6M092gNWUaw+MDr3CxyKEaeUiGPliUueRjfElZ5fTYilmRZfWv
         C0dNjezsvwrMboCHvo0ShVQxdtatFwUSJXT6OoR/2nG+EVjJB00KUeNarMIt9X8iVexC
         tORyv79t772ryT9nJoDp28EwPa5vs8ribpsBapMf1yljjHC5UKHasDTm8hh/9jjPfqsb
         p21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758014639; x=1758619439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+3iYiVvbI4s7dsMC5XIvmLY+aeqtqnaQaCEIYxA1eE=;
        b=oU23OLP+KpVdvHzt6zB+U4/EpKqjvtIbqo8SRUREyC6CQylZ4Ij1pMirOpgCpRY/oJ
         Z8avkXfVMhAz0vNdOMnCl2Ntr33W/q//6ytTNqiNvrwCdT4CD3fMTeO2j2AR0nCi2Uei
         OMfcbJt+Nth58qVG8MqgJJBQlaw4ilK8HQMWrGbsEVIbdFJEus/ikHmUYOoWWrRSivwO
         B/p2qUrPHfb/YKmzYXioO5rDXVWi+Ldfbqd89hWxEiQyLB2fUE4Bh5Zo5F4UTkS/OIR5
         7WJxsIG8ky6/UAb2FTv90E5eFnqun47mLanTEWphBp+od3VNUSvcDvIO0NrCjBAdkVi5
         kBAw==
X-Forwarded-Encrypted: i=1; AJvYcCU7g7r8Bke6BkSSZlwAH1YwONc06QiEUjnRF7DoEr+ih+tVHcbTZJOc1D/kv4FwM5HT3l9jsRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAAWWYYgp4QjYs7rLPh83qfABXqny/VWK1ftW5t+m05U63JFoz
	x0D3JfTh/zbQKrwj6bjSFNQASxK7J/9XWZRMKfHW9aOM9gU785ln34nf
X-Gm-Gg: ASbGncvERQryIsh98mSN0GWabiL9+is7JAlOwbIJ/haBTtLncfU5NBjOfdzMpseDT37
	goA1uX82alWdBX1KCm7W6/e8pnf1sAUYqrUCRGsUhs6ne0hGqLahdVQ7t8dhrMyhD3zWnTt0/4q
	LeGT0d8ZGXD++eZrpyEnmmnpbcvzaJe6mrzdMOot/iRp2udZybutlge7yTHyTpGKl100d0qMSPH
	4OgvIg3aJM8J/JrjbjK8NVKUb001Zd7C2TpATKkcEuRfhyiPT5tFA0sz0fxJ6Yg+G4PGQs6rfbe
	/9o25Ou50zZTHgRFN6TmdnptfRuTUDuULtVqr3F334QtqMgIpsxPRSmd+efN2AxA1SNrdrz2Nd8
	O891jriQhCZ3D1Js=
X-Google-Smtp-Source: AGHT+IHyLOKaBNGfKWN8XpxZI8qHpODzBMlJD6ECzSpUHvIu567ZClroWuGa5llT1POUqPXojFTkYA==
X-Received: by 2002:a17:906:794d:b0:b04:79ed:73aa with SMTP id a640c23a62f3a-b07c3547e31mr799330566b.1.1758014638595;
        Tue, 16 Sep 2025 02:23:58 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:2310:283e:a4d5:639c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b31715cesm1099372366b.48.2025.09.16.02.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:23:57 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:23:55 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 2/5] net: dsa: mv88e6xxx: remove unused TAI
 definitions
Message-ID: <20250916092355.d662ym42drhyjhej@skbuf>
References: <aMgPN6W5Js5ZrL5n@shell.armlinux.org.uk>
 <aMgPN6W5Js5ZrL5n@shell.armlinux.org.uk>
 <E1uy8uS-00000005cFB-2b1N@rmk-PC.armlinux.org.uk>
 <E1uy8uS-00000005cFB-2b1N@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uy8uS-00000005cFB-2b1N@rmk-PC.armlinux.org.uk>
 <E1uy8uS-00000005cFB-2b1N@rmk-PC.armlinux.org.uk>

On Mon, Sep 15, 2025 at 02:06:20PM +0100, Russell King (Oracle) wrote:
> Remove the TAI definitions that the code never uses.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

