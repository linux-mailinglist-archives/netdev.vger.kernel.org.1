Return-Path: <netdev+bounces-226185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54BFB9D8A5
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 08:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61EB4A2E61
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 06:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DF22E8B96;
	Thu, 25 Sep 2025 06:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qqkzfmjy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A552E8B75
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 06:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780725; cv=none; b=XPWSQOYM6ot5WCbId1tmvYqv6Cw39J3NIsqhFXlJyw+1Qy1Si+SScJ5qn++Kp1Rfx6/QhfTabzkKOyI5b+ro6Cx8spwNcyvA/p2+0uiZ8Zmn9f4tDKq9rdrZJ2MQeRUWbayQUshMJFEdQteN0Powi6Qy/lh1H/3Wko2TlBi3MlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780725; c=relaxed/simple;
	bh=uSFb8MHXwLqA9OKwUwZ9qPfEDx9KKhVW9XfP9kuC53s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgQ8MBlbx4Vg1ku1EkpO3qu27/EatnqSP6vm/VUZB/TjfgAC/jmTpRG5LVchdfMtVDgB8EQl/8FFkwZkfXAzMM18ZY0G4nekVh16jiE2shuSUBrjO9oX8zVyjaPDud2NUsdKErG+cxgo1Ad1K6HJrF1cJ7RrH3ZGv+eWa8cu8Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qqkzfmjy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f3a47b639aso362491f8f.2
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 23:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758780722; x=1759385522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yEYWGfF11/g3FTMFlorTwEZrbGBIs3tO9z9pPNiHJAo=;
        b=qqkzfmjyigSpLUoNqAMuAQPl/zPXizRaJfpLiXhw2cfQSwVL8u7D95BnPvpPfPoA04
         c7DPuIq+tHha0AqLofEqBwuLohznbyQTmFnioXKf18DW04Tma9rsEaqu67ZxtHuW1YTh
         SEK+jdgVOgwOdcUUudwlrEk0K6tqdtiSgdFO3IR8N+KoEe/C8V9Nque9V3Jv/Xb3yNeB
         Gro94cqz5bWoY5+kR2qM1bVW6F41cM5/NlgqWbNlrN4E0uQ9Hy4BWBktjrMiCXWr82iB
         iIg3aGdJ586DTiy+EhmAXH+NVFYsSsAhMFOZPsE1NTTdlMOOZvEVlsgRFd82pyXpAxlP
         qQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758780722; x=1759385522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEYWGfF11/g3FTMFlorTwEZrbGBIs3tO9z9pPNiHJAo=;
        b=A4ypCpzTrFhNYpE+I5SnQc775xBf8S/M6Z5S2V/rhRRpW57Sn4WtHfZl1daHByi3rl
         /ntAKwyOwyIqUGnLGq/r/PKkLGZY6nTk2rzyv3PHJjossVlTLfKSh2bizD44Xz0knHCi
         lO3pqnQPr3sJ22z9X8c4aY2QO/d1MCihgcBz4XO/vFIEFYGRCWiiMzkT7P8NRH+aGwFB
         2PvXyJzfhhghiaKcGQYmUx+TaDOxs4LIcfrGaXDFnNmrfEDTKB5zfWapg8eImRN3CRrq
         MNRMiUtnHV/VNxxHzYkYvCUUY3BK7b5qqFCkXq+vJHiRszp/rUSWXiWRSqxH2VlZyU5h
         pBaw==
X-Forwarded-Encrypted: i=1; AJvYcCUom2ghywRPu8GPZsxC1hbDdCTRGrgeRZ5oAwl8iZMUoeVGox9rl8ZdTLGwVDwnchPq5PZzwJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzndrJ9nArlJYmU7vYMw2edly7Dfn7voOElcXFGFmqB+Nae695m
	bQTNiz+Iug/tMVO5J7Zf6ZgO3P41PG6gxn5gLk5yQrKll/3i9rmKPd5fTnUlXXYiIdI=
X-Gm-Gg: ASbGnctdqt3uKWcHpdL6KtK6zLKLhAJCGQfkdZFM6NzlQXMwaKqsoHLQaVBP11CzhPI
	tMfmR0fw5wlWnJwxYjcFJBbV5DvIUroQoHcmf6uYbiTd8PY6bfBu1WYeaixmuoymxu8UNXM7s/7
	VuPgy8eWwwOsHgSqkeKdeSS7JF3e22pO4JqA1OUqVqxsuDQoPBi8aGMxuip+8YzVB8rM+gtAcFz
	oyYksJg/iAwX+9cVF3LSTR9094JlHi2q1xpMuz59K/0Zcu6qS3Lan91DW3LhaLV/aYHJ4nwb1Ie
	fQLBt7IVqQKARvBAUAXDxwNp//Mrh9LiGuzSau7/gwqQMuLUXwHWLUlzg/yB8wNbIyHKzWHZEqv
	7nb7ghB/7w+WeW+fX+r9gsSEoW5Q=
X-Google-Smtp-Source: AGHT+IFRkpqclsNYUNbGMkAuZhXHS3Qv2yCkSEuPjzYXQeiL3SAyG+ATQky02YBh1lI/bsu4q3uPPA==
X-Received: by 2002:a05:6000:2381:b0:3e5:47a9:1c7a with SMTP id ffacd0b85a97d-40e4a52475bmr1878562f8f.62.1758780722328;
        Wed, 24 Sep 2025 23:12:02 -0700 (PDT)
Received: from localhost ([41.210.143.179])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fc5602f15sm1453105f8f.39.2025.09.24.23.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:12:02 -0700 (PDT)
Date: Thu, 25 Sep 2025 09:11:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Andreas Koensgen <ajk@comnets.uni-bremen.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-hams@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+5fd749c74105b0e1b302@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next v2] 6pack: drop redundant locking and refcounting
Message-ID: <aNTdLU7amoq0bCnS@stanley.mountain>
References: <20250925051059.26876-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925051059.26876-1-dqfext@gmail.com>

On Thu, Sep 25, 2025 at 01:10:59PM +0800, Qingfang Deng wrote:
> The TTY layer already serializes line discipline operations with
> tty->ldisc_sem, so the extra disc_data_lock and refcnt in 6pack
> are unnecessary.
> 
> Removing them simplifies the code and also resolves a lockdep warning
> reported by syzbot. The warning did not indicate a real deadlock, since
> the write-side lock was only taken in process context with hardirqs
> disabled.
> 
> Reported-by: syzbot+5fd749c74105b0e1b302@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68c858b0.050a0220.3c6139.0d1c.GAE@google.com/
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---
> v2: add Closes tag
>  - https://lore.kernel.org/netdev/20250923060706.10232-1-dqfext@gmail.com/
> 

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


