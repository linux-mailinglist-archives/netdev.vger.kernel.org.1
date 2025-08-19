Return-Path: <netdev+bounces-214831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FFAB2B6AF
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 04:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808461891E1E
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 02:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFF5253F07;
	Tue, 19 Aug 2025 02:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmxdL9pH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C322118E3F;
	Tue, 19 Aug 2025 02:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755569239; cv=none; b=swgsKemIaMqXHV19LiIsCPYG45MP4nzAc8cOYjWK7TU1LLPPNrsOtYIitCH48PzOPZGF0kHwxpkJlAPzt61PuZjiyeZW3n5G718MNVDSKffrBJA8W4Z8cuOWEO2SdOENnty5sQIgfbl3LiLjB4Y4GyqRLom+HXCPfCyYXUS+UTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755569239; c=relaxed/simple;
	bh=si6Gz9rajRhkn8Qnimb7Qhr5mbOiIBXLKqM+VF3jSrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoYIf3TRgLtfXstTqdRc+EOy61eNsffWstPAp5/dqff08PXpgkcHcFzNUasNkDy5rsfdnsDYd5wrRVACUCCnCMYFm4urYXRzRmTVbPuLabIRXKcI7U8WKBiUK4SJmzCMnFMd+etBgkuPdIxNUXtJawOcd2pJUKB7GgC1yp+BbWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmxdL9pH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2430c5b1b32so35667425ad.1;
        Mon, 18 Aug 2025 19:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755569237; x=1756174037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7FxyaFBlLbAZvr1O4P5VecQz9oEB9CxW3R9/q85xaw=;
        b=dmxdL9pHkKEmN4jsIxjJO5dgAIZWalyynSFiC1vVfEb9yZ2IH3YMfkG1PrA+B9NwNK
         W4qRaPQM0atVXGYwYMzYF3ipNIYLVozTiXOueFvNYcbaB9xEASEREceEo9JuTvubnMjf
         29bm/C0aLP6imzY9K7S6bAMctXcw0E5tCjKXje0dJsDhGdcg5HaPt5TsF1pfJ6oZYkmR
         F/KCuW1d93nwXQ5De9Ti6JT/T26IKsMA9o3Md/7z2h/LTB/Oesb8XI6iMIXIPUsGxmgY
         pBjaOSXE61MmNwJ08baRqhs7XSMi7qbO1P3cpCcBJM9lrsL+G2FcfZvrsRv0U7UZelud
         4bNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755569237; x=1756174037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7FxyaFBlLbAZvr1O4P5VecQz9oEB9CxW3R9/q85xaw=;
        b=kVZjO5pM7wQfaxtJWoRqhhE4HFJbxR8No5ownHCGn02EVZCFnZNF63QHzqBuAsG+HJ
         JHbcMKrtrCcEWe5MP+g9hUwwAC7M0BOe5kX5GU889sTXGoStnLUKoMiQt911GUCu9HE8
         n1j4clFybsZYA0+temVNOz1dFHtAmR3Fg/HmZcOX8FTioOZBdtn8gktAMaruI9H06wv/
         ZIN9jcDZx1QwvF1HZpCJ3qYq/V8XMu2hCzTVqkshprXVeGReS428nVVqqmlqCUjHl2sp
         9QKAcRu8aI2tNEf/oLrmDl1jictBbcFaNaRiKzA5xI4yAiSRO4v2MTOo7OS2H0GQcblJ
         9THw==
X-Forwarded-Encrypted: i=1; AJvYcCVirz30Qtx4F14NCCuhlFy9P+6Eexf3n3w1YP5zEpszMMtINr6pW97hNr9+rzyyOKaOJbLHzSKk@vger.kernel.org, AJvYcCW7lIGkQ4SdN4GT6QgdTV81B79WCo/JUAsNK2ZebVHvt+05DFacqbXkarw0DDEtfqXNe4CaHroiQLNWKug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF4uUw9HLodMZhQosb/Kea0U+QsvOWF4VHp4dAb0V7Ns8V8ES1
	LU3SVxa+hxSByarwOAGF5SeNFFdeoFfnYf3u8KMAMybRvRRAea2bPCPG
X-Gm-Gg: ASbGncv98OE6NG6DWEHydt3VM5YOtKfo0uCPAJVVo/6kLe8FkJldAEcOkLe01y1AITB
	MRwGmG0zZBZSYkJPeTrPEkyuo5Mdy4VG5Em4AyAq2n/JtVsosXVW60a1ooOpAQkjE3bhwkZMSYv
	rplPJoFx53C5bJ5z5V1Sk6r69K8XD+wob1meW8025Yj+wy+V6LNT5zO5Podwow29vDqmy/Z66Bd
	6WdPSeGt8s0/z7CYONFQBILnzZqkJLwlfz4RtjxaVOw2Qe6aBPn0REDc2XtyFjTvFOlfUOW8Mem
	1bQrLt50lDxRrWimrfr2UwZvCALDcLHXg+Q5v4N9ofhF7DaNGPdqwveCbw+vciPWgw/cgLE73x+
	jctoqn46pCn9+SPH/JaJr7ZRQNUorbxxEOv2vbDo=
X-Google-Smtp-Source: AGHT+IHvoLgO/++Hv9TiR4/r5ATMwcVgrzOhdyOGWwsV4G24k7L99OvNyUWbIuIML4tX4KdWOW6Z9w==
X-Received: by 2002:a17:903:41cc:b0:240:5c75:4d48 with SMTP id d9443c01a7336-245e0f8c1ffmr8865425ad.25.1755569236961;
        Mon, 18 Aug 2025 19:07:16 -0700 (PDT)
Received: from C11-068.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d54fb54sm92358055ad.134.2025.08.18.19.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 19:07:16 -0700 (PDT)
From: Pengtao He <hept.hept.hept@gmail.com>
To: willemdebruijn.kernel@gmail.com
Cc: aleksander.lobakin@intel.com,
	almasrymina@google.com,
	davem@davemloft.net,
	ebiggers@google.com,
	edumazet@google.com,
	hept.hept.hept@gmail.com,
	horms@kernel.org,
	kerneljasonxing@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	mhal@rbox.co,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	willemb@google.com
Subject: Re: [PATCH net-next v4] net/core: fix wrong return value in __splice_segment
Date: Tue, 19 Aug 2025 10:07:10 +0800
Message-ID: <20250819020710.6681-1-hept.hept.hept@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <689de6c51e152_18aa6c2948b@willemb.c.googlers.com.notmuch>
References: <689de6c51e152_18aa6c2948b@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Pengtao He wrote:
> > If *len is equal to 0 at the beginning of __splice_segment
> > it returns true directly. But when decreasing *len from
> > a positive number to 0 in __splice_segment, it returns false.
> > The caller needs to call __splice_segment again.
> > 
> > Recheck *len if it changes, return true in time.
> > Reduce unnecessary calls to __splice_segment.
> 
> Fix is a strong term. The existing behavior is correct, it just takes
> an extra pass through the loop in caller __skb_splice_bits. As also
> indicated by this patch targeting net-next.
> 
> I would suggest something like "net: avoid one loop iteration in __skb_splice_bits"

Thanks for the detailed and good suggestion. I will correct it.

> 
> 
> > Signed-off-by: Pengtao He <hept.hept.hept@gmail.com>
> > ---
> > v4:
> > Correct the commit message.
> > v3:
> > Reduce once condition evaluation.
> > v2:
> > Correct the commit message and target tree.
> > v1:
> > https://lore.kernel.org/netdev/20250723063119.24059-1-hept.hept.hept@gmail.com/
> > ---
> >  net/core/skbuff.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index ee0274417948..23b776cd9879 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -3112,7 +3112,9 @@ static bool __splice_segment(struct page *page, unsigned int poff,
> >  		poff += flen;
> >  		plen -= flen;
> >  		*len -= flen;
> > -	} while (*len && plen);
> > +		if (!*len)
> > +			return true;
> > +	} while (plen);
> >  
> >  	return false;
> >  }
> > -- 
> > 2.49.0
> > 

