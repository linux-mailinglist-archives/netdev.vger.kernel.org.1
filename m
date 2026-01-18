Return-Path: <netdev+bounces-250843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD9BD3953D
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 14:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA1953009F47
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 13:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A43B325723;
	Sun, 18 Jan 2026 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="in1DnlNT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E11128AAEE
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768742513; cv=none; b=C1gh3SFKzTWTweY3RlIh0ikSSWcenxuO+Q+t1bstS6c46f6XPZB1V7Iq5yCK3vywnMIpPCThNJfXQMPskZ7clzaZ6s2W0WJf8pJW+ZoLntymhhCP/Tl9sNkFLl9X8S80XODOnvf7jJ8xW7sXNSpLLHgYjru/gjzge9W3GjVTvM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768742513; c=relaxed/simple;
	bh=G7VoZ04tuBvWggvA8HTQ6TA65SL47mNoJkVWqgJnq+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVUcO1KuNEwAjZX7Rvd3gBrw9M9TKz07CDXmXmTk4nJ2XxZGGPXmPB4C8SA1NkeUyolE0AOVxzc2jl5l691CIWHcOcktKu40toK6IxzK9wP7ajVCgVqnCPHt1y9sTVxGWu8+8AJGp0lkPHSz6EXrNmdcuDb2zSSXX/roNEbUACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=in1DnlNT; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-81f3d6990d6so1984113b3a.3
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 05:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768742511; x=1769347311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qw9ZASoTlkokvDF3mq4I2MeyWKgBz6aieOIs9LY/qAU=;
        b=in1DnlNTlCjJI6tCnBt1o1fbbCwgDicGK4DOr6lB8MfAVrGU7+4MY8Ajh3mJFrHGmk
         b8kfdgwcv/rc6BXRvgqtOI/zdn7Am8Y/6y/oY9yRes4evHIHdF4ZX+xBEw55/x1725KF
         AZESGnqAlr6IUEdT+6T23z1ypFJTopOOmnORlUCuyrgRZQjxS3S02BeZiOThcotL+AUp
         Xbbaq4YhXn278HPi4rL/mG+8+Lf1ciykzSvZl5rI/AvOu6bWD0jon77QAre5pn6fwEwd
         3EzR3NTUzE2kF36j04SLRrvqaaDk+G6EUBidz+aEyOayamlpakQj/GikEr28WchSe735
         aLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768742511; x=1769347311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qw9ZASoTlkokvDF3mq4I2MeyWKgBz6aieOIs9LY/qAU=;
        b=GewAJXv8qGnw6r+OXDcXgwkOlOGn1XFi/Md4FQtEwtCX553nRZQLM9jdnzQxX2jnm0
         OMzDeJzNiFVknpGTnIWg6/fvrgC6JlX61bAngkRhHYQNGZHewaNg7XUsLV8tF7j84iQR
         c9KLkdoPvPqWuO5jAuqIToGU2BB6l4TzFHwmWsgdA4WK/O986IBRIviMamMu5FPNSJHW
         Sqj4uc896feF4Ynug68aH6sKQfjcxzdiQ1SRaLj4m2bvxFrqRGsZ0/rcYAXZZbuz2yyJ
         0SZyBJeXSVl5lTplbBrJ6MMPw0YYh1K1LDQ+5N4kRA6LZpv0bQXd+8fwtWom4GSv5b7E
         U+uA==
X-Forwarded-Encrypted: i=1; AJvYcCWfAngxIqU5QLAk0EoIGWn7U/oWOscRV0oaX9GFJJ6OCEE4mMEouBHlERr3oG3q4qcl5KN+cUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA+lroluwkgEqB6qI/TjQMlBWK75ioI5F9Zc27Fuq76wxBHrmU
	81mIWfolAfeENR9U/5R7sSnCPKIQi7PHYNJ8UWH+tuwN5XrbTc5aZDny
X-Gm-Gg: AY/fxX4zmAZh5+Vd8pu0cU29KjtYAECMXKRy0SC6jNjHRMON8plIe2RrUjcxcfDT8ii
	G8Voc0ux5Vscy8ieN45Pq+A/h257oUSSgnL692cKRoZG1OE/GLihUvFG7smq5fe2uVrFRdXSKrO
	YtyAbXIEQInfKHG25w0TFaqqE7TCK664FcDoGIJd67UuvJ3fHoubcJC8N6hRhUxsrIIV3rot2uq
	gHADyo41moH3VF58iDMalbe2BhJaMV8EgcvN30wdubJzIkLDE8OUdK4uskVo7q9+FDaJwXLhhNG
	rF0Ekavvm/ZQD91H8jMW+DuJ9PfjqDlYOS4GYZaMPu6Y/9UNkhkKFeZUfQ86HqFK2ivSwy9bfcf
	3ZlL+J+HRMEbCQOoncy9tLFO+27T0yi1fT4JRYxFfG7rDfmocvDFgEsixmA678ThIc1ShYKCXuD
	CakOHzUJis6fI=
X-Received: by 2002:a05:6a00:1793:b0:81f:52d9:605 with SMTP id d2e1a72fcca58-81f9f7e5b54mr8588361b3a.6.1768742511381;
        Sun, 18 Jan 2026 05:21:51 -0800 (PST)
Received: from inspiron ([111.125.235.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1277a23sm1143687b3a.32.2026.01.18.05.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 05:21:51 -0800 (PST)
Date: Sun, 18 Jan 2026 18:51:44 +0530
From: Prithvi <activprithvi@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot+df52f4216bf7b4d768e7@syzkaller.appspotmail.com,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	pabeni@redhat.com, linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: Testing for netrom: fix KASAN slab-use-after-free in nr_dec_obs()
Message-ID: <20260118132144.6zax7pp6bktafpgz@inspiron>
References: <69694da9.050a0220.58bed.002a.GAE@google.com>
 <20260117065313.32506-1-activprithvi@gmail.com>
 <20260117094745.6fed3c45@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117094745.6fed3c45@kernel.org>

On Sat, Jan 17, 2026 at 09:47:45AM -0800, Jakub Kicinski wrote:
> On Sat, 17 Jan 2026 12:23:13 +0530 Prithvi Tambewagh wrote:
> > #syz test upstream be548645527a131a097fdc884b7fca40c8b86231
> 
> Please do not CC the main mailing list on your testing attempts. 
> Just CC syzbot

Apologies for the inconvinience. I will take care to not repeat it.

