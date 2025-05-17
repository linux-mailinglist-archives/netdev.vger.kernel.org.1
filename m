Return-Path: <netdev+bounces-191261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8889CABA7C6
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 04:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF314C756E
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 02:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A7B7261E;
	Sat, 17 May 2025 02:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKo1riSQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437C919BBA;
	Sat, 17 May 2025 02:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747448246; cv=none; b=AROS5TEzRDDczJVY3R6UoWy4RKb649HGGRWfjBRkEKmg+1HHu3tcU2YBy6G+VDf2KyzqGBryVFiCFlmRBlHWiGJH+hUap7CxFVS4kg608YYDTrHMlt+W0d03wp8e7SBatMaaIudK5KxLE4t5o6MExHGt9T+QYfqrUkRMB0sgFsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747448246; c=relaxed/simple;
	bh=O2ZIio8i7ARQ5KA1lZfFJ4h4CacdEJXKQUBPverKB2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZC8IcgNU6hJlc9DKLxQYoU4vCkN3Vi4CbEyry9eLB04FkXVUUv8VWOG1PIZfBLiqy0PPds5mJ/xXJthcgA8Nb/FVgzIWvwntJmrSCSFeW4zURF0pelvZHX7WqNp3Zd0A96uz6zkNhEVnEfkqiknq+oFE2qQ8TdM6iWIgY7g6quw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKo1riSQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22e331215dbso28381335ad.1;
        Fri, 16 May 2025 19:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747448244; x=1748053044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QRokhHnHRykUKq7zmUc1xE1/P+xdDIxaYLQgCRuwa5U=;
        b=WKo1riSQIU069Ujg6kMARbJTOvyrFPb+ZkjKSJ9JtNwKstr9et0Ts7qX2kaY9HoOqW
         j/cEaZQFHX4X19ofAqlxviIQzd1tbVlnJigLQhbNMxRnao52t1TfjQ2pNjkJTdMlIS/O
         e8QozDqyuMshJ3Bh25CJsRGbU9p/kfRli1HY+qaUmiat+1xjWfNKpcngr7j6Rwp0itAm
         bAE7SbrAk46pMtE/kKYbj5bOShsEyCfJ3ZhiEL1fzy9hOkEwakceJ8R4nA4RIdwpPBPt
         9wcSZdSOncypniUz5FW3fHEqhPF3B+CW/UZ5btvLh/RJE0kdovfPVYuZyXJYhlcOzjbi
         czYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747448244; x=1748053044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRokhHnHRykUKq7zmUc1xE1/P+xdDIxaYLQgCRuwa5U=;
        b=p5zRIOh8aGloKzF3AcmDZgUexslg2oWWHmbCT1YMnyjneW8Fi9wqtA1y3nMapXWkHO
         MfIb4Gd67agMx639FL1MhZrik5Cwome+dNTO6HkbUuu1dykd2XzH1NI9aOrBWonICuZn
         ztev6XKPDZpNrYgjWR+3TKUqM/25/F4CBLKFh4CFluaswAbkFPG/rtIyza/Q+thbhW5H
         eM2oxXb6PnFobDK23bHtRSvODIvOipiAqrN8fJnT2+eMj4Gm/gTGVEOGSdjC4ZBwwnXa
         yCMiDNQS5ls54zV7wivihGzCMy7BMoxrPSX6QtmSoZqsKnDmstmN4Gm2C8zE3v4clh5Q
         BBHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTHyQrkOTpHuVdyfFWLNdWK7BVKUCHuFnaY7gveS3YaqvEB/lzeG55aArgxdXJweB38PVBIrrFJGGzw+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpN+mAX6isM3G+OQWTzuykn6JDX0rqA+2tCimtVMTMQWGGaMjk
	2GOf4wlF0Y4YO+ebABkKLQTLGUjUuGarPlaDdVolowCROfLIpcTWod9+tM0bEIk=
X-Gm-Gg: ASbGncuSBxR2FAc9jTo9FIBRd/IDz5hUeK+sJnloIyw4Fhdl/RMTudGvTLFQImxO0de
	6/bSjn8TO217U+WQh4AjvIxgppaSVK/zU4H1WOFNBwvYpOkUJN6uLe6tF4LMEaa0Zph4Jej1nsl
	S5u9YUM7D9aTtEJUMTTIg8wxZ615Hi0POEZ81/TKZ8MAzgNTdOYM9uVbJ7reEY8B+X34ym2Twjx
	sihdz8ws+kUGsH2Ba3+jFzuRxa8gsCdwKLH0d+chrvo+frptQKuJ1/ycla0tyo9rVGzF8Jc5bpj
	3BHwpOSF+9j6J/clJZmu0D+rvzZLz+5zsrhMmcYb/NbE355USRhl2GBALI0HFb6QNk5wWLL5i9M
	dFhR80+05K4g5
X-Google-Smtp-Source: AGHT+IFNtNRRLkM4ibVOIc6wBgTB/qpZDJrg9cQAGTsFphRbIzh0ihrOhLhzrd9rPKr+PpkiwCKZXA==
X-Received: by 2002:a17:903:1b48:b0:22e:4b74:5f68 with SMTP id d9443c01a7336-231b39acfbcmr151920415ad.19.1747448244332;
        Fri, 16 May 2025 19:17:24 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4afe856sm21022455ad.86.2025.05.16.19.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 19:17:23 -0700 (PDT)
Date: Fri, 16 May 2025 19:17:23 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	willemb@google.com, sagi@grimberg.me, asml.silence@gmail.com,
	almasrymina@google.com, kaiyuanz@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: devmem: remove min_t(iter_iov_len) in
 sendmsg
Message-ID: <aCfxs5CiHYMJPOsy@mini-arch>
References: <20250517000431.558180-1-stfomichev@gmail.com>
 <20250517000907.GW2023217@ZenIV>
 <aCflM0LZ23d2j2FF@mini-arch>
 <20250517020653.GX2023217@ZenIV>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250517020653.GX2023217@ZenIV>

On 05/17, Al Viro wrote:
> On Fri, May 16, 2025 at 06:24:03PM -0700, Stanislav Fomichev wrote:
> > On 05/17, Al Viro wrote:
> > > On Fri, May 16, 2025 at 05:04:31PM -0700, Stanislav Fomichev wrote:
> > > > iter_iov_len looks broken for UBUF. When iov_iter_advance is called
> > > > for UBUF, it increments iov_offset and also decrements the count.
> > > > This makes the iterator only go over half of the range (unless I'm
> > > > missing something).
> > > 
> > > What do you mean by "broken"?  iov_iter_len(from) == "how much data is
> > > left in that iterator".  That goes for all flavours, UBUF included...
> > > 
> > > Confused...
> 
> [snip]
> 
> > iov_len. And now, calling iter_iov_len (which does iov_len - iov_offset)
> 
> Wait a sec...  Sorry, I've misread that as iov_iter_count(); iter_iov_len()
> (as well as iter_iov_addr()) should not be used on anything other that
> ITER_IOVEC
> 
> <checks>
> 
> Wait, in the same commit there's
> +       if (iov_iter_type(from) != ITER_IOVEC)
> +               return -EFAULT;
> 
> shortly prior to the loop iter_iov_{addr,len}() are used.  What am I missing now?

Yeah, I want to remove that part as well:

https://lore.kernel.org/netdev/20250516225441.527020-1-stfomichev@gmail.com/T/#u

Otherwise, sendmsg() with a single IOV is not accepted, which makes not
sense.

