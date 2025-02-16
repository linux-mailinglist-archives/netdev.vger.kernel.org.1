Return-Path: <netdev+bounces-166824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 690CEA37735
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 20:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 591387A30F6
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 19:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E481A3156;
	Sun, 16 Feb 2025 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1zBXtc6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCAE1A3146
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739734426; cv=none; b=P/cUs+YedfVXLs0Vue0gUC1tAjK8BZp55mTErqTvbAfTYF3yWUbLCHIwEe0BI/Cawxn5Wp4tDyzDDxRXfXDE1fPo+ZGpRowuHcuxokMD45uXa+e8MoLGMBAflK1SKfZqBtXqkHsPvJvC9STLHJWick52sZVtGOLfcDc3fs0Xwwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739734426; c=relaxed/simple;
	bh=bxFZkh3GxelTk2s9pdgdEfZyDa8KLecC+NZADbOkTxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSLTnoZBaM0s9wK6Gv3QytuAK+vHPEKTvozLyIjsrXaYXkptJ4nQ8QfBgDYfGjFUFkEs0EoqE6eqEL69WEKRbm3nAWdNBs4vw5NGSNP0HET01/EzAWeKc2CtoLvcpeG/Sw4cJNSxPrFB7L1iiXJts2/a7a5NK7c7+fDO86DVH/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V1zBXtc6; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5de3c29ebaeso4798931a12.3
        for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 11:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739734422; x=1740339222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+rdajbzChx3zXu80o9uC5gbyEQ6hbhHwr37XpGawygg=;
        b=V1zBXtc6k6e9kKaz2yQcgujZqI2RHU3LOpMAPsQFwRj6EmLdA1bf5HilLrqqlCuzB3
         NQ5YUpHzHQziPEdY46nV8GyjDNj5aMRbvyT+SPIZRnq/+ALd9oTEe8WI2JTeosLx0vl6
         ln3gM96FCRNKxe9SZ5wBFX0mNJI+tD/0EwaxGAIlFraY51Ta2ULq3+VRMWMZq4+tcub+
         kj0Lt9f6RvGVDKfwaEp/1OLvBf+RZW6bhcAVgaejM8laRfUqC8DFvsrfxVRrmdYTMjwZ
         DSy4dosb9fIiJA3Ngtpj37QnxyMpKA3nJKzjHEkqXGnzXuEIIp/Vm+WWqhPkQfwyxz45
         xREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739734422; x=1740339222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rdajbzChx3zXu80o9uC5gbyEQ6hbhHwr37XpGawygg=;
        b=Bq0dHk9vUyBcxU3d1FHWXf8zQsVBbMFHy9kN5YOdgmeyWxj9+4xV44b86/8z5rrjUd
         OOpwfRUCXyux+h8prmW5jnrZmrMmbsyCakpJi5tpMJISDvuxZU67mFYBzWBCqmqSO5aa
         70tlLtb3TNY7vqT/nSFEzQLhHQH9yzMFLkp1E9ZfRYoX0quV7XM88jPn8YVtquoBHqwH
         ge9QS/7C+xJnJPInwn/IrfKrcO0ZquWT21SAAZz/kpoOZqq9xIxO473tKXlrbF9PhzlA
         Utnokc+QG55O4uzquNuhHRo+MHoWn6ALSsdiJvh8XWpHfPzSyWphlDjR+OyUxtLw8cxF
         NOSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj8/o38F8OEUG+ixOng/ndNV/HifYCHUIjKtvDMvhSXx7MUp7H1zSbiaeKXyyJb7GoFqOLt1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy945nCdw8ozI+vkfqLYK7NMss4kKuauU57UZOId1im9XM38axu
	HZAO+P2WBCwttjE8wx+kLHFACs8pIFLcOSevI4g3hwtP5sdu0SMOyGEaMZQL3AQ=
X-Gm-Gg: ASbGncvQlngIT+tcJHqFDNhtkIIQTagyycngKORCxv+7jSy8xyeRlq1lZTCZSXoC0hJ
	yvx3xUTJj1korBy/7c04aM0LIAmyP6WNpBNl/EUucg5vRPS2L8i/eBifZ+XedpDpGgS8LvmEmmv
	BSjjqFDXOisfGQHoam8pyc5IQKeCAL4EowtL6u3fUkHTg2bOAQIbjSSBS4cWjn9KtFSp3x3h2Qj
	HdhEYoSTBklDu7+WElmr8xClIxxH6CRHZG2CXndEE4h7ASi/OHr6ri+oRGGR0XUm83bmaXfXt9i
	6W1ckdbtfeKa5UyOLL4c
X-Google-Smtp-Source: AGHT+IH1F3igbJlqramKS8IIZVfgTeP1tXThk89INYy49QTfryu4Jt4JBGKucuQ3oNfDdmwaojg53A==
X-Received: by 2002:a17:907:7752:b0:aa6:79fa:b47d with SMTP id a640c23a62f3a-abb7091cedcmr597981666b.1.1739734422335;
        Sun, 16 Feb 2025 11:33:42 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aba533bdd39sm747734166b.167.2025.02.16.11.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 11:33:42 -0800 (PST)
Date: Sun, 16 Feb 2025 22:33:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Purva Yeshi <purvayeshi550@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	skhan@linuxfoundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
	linux-sparse@vger.kernel.org
Subject: Re: [PATCH net-next v2] af_unix: Fix undefined 'other' error
Message-ID: <4fbba9c0-1802-43ec-99c4-e456b38b6ffd@stanley.mountain>
References: <20250210075006.9126-1-purvayeshi550@gmail.com>
 <20250215172440.GS1615191@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215172440.GS1615191@kernel.org>

I've added the linux-sparse@vger.kernel.org mailing list to the CC.

On Sat, Feb 15, 2025 at 05:24:40PM +0000, Simon Horman wrote:
> My understanding is that the two static analysis tools under discussion
> are Smatch and Sparse, where AFAIK Smatch is a fork of Sparse.
> 
> Without this patch, when checking af_unix.c, both Smatch and Sparse report
> (only):
> 
>  .../af_unix.c:1511:9: error: undefined identifier 'other'
>  .../af_unix.c:1511:9: error: undefined identifier 'other'
>  .../af_unix.c:1511:9: error: undefined identifier 'other'
>  .../af_unix.c:1511:9: error: undefined identifier 'other'
> 

Smatch isn't a fork of Sparse, it uses Sparse as a C front-end.
This warning is really from Sparse, not Smatch.  The warning started
when we changed the definition of unix_sk() in commit b064ba9c3cfa
("af_unix: preserve const qualifier in unix_sk()").

Smatch doesn't actually use these locking annotations at all.  Instead,
Smatch has a giant table with all the locks listed.
https://github.com/error27/smatch/blob/master/smatch_locking.c
Smatch uses the cross function database for this as well if it's
available.

Unfortunately, Smatch does not parse the unix_wait_for_peer() function
correctly.  It sees that something is unlocked but it can't figure out
what.  I believe the problem is that Smatch doesn't parse
container_of_const().  Fixing that has been on my TODO list for a while.
The caller used unix_state_lock() to take the lock and that has a
unix_sk() in it as well.  So smatch doesn't see this lock at all that's
why it doesn't print a warning.

regards,
dan carpenter

> Without this patch, when checking af_unix.c, both Smatch and Sparse report
> (only):
> 
>  .../af_unix.c:1511:9: error: undefined identifier 'other'
>  .../af_unix.c:1511:9: error: undefined identifier 'other'
>  .../af_unix.c:1511:9: error: undefined identifier 'other'
>  .../af_unix.c:1511:9: error: undefined identifier 'other'
> 
> And with either v1 or v2 of this patch applied Smatch reports nothing.
> While Sparse reports:
> 
>  .../af_unix.c:234:13: warning: context imbalance in 'unix_table_double_lock' - wrong count at exit
>  .../af_unix.c:253:28: warning: context imbalance in 'unix_table_double_unlock' - unexpected unlock
>  .../af_unix.c:1386:13: warning: context imbalance in 'unix_state_double_lock' - wrong count at exit
>  .../af_unix.c:1403:17: warning: context imbalance in 'unix_state_double_unlock' - unexpected unlock
>  .../af_unix.c:2089:25: warning: context imbalance in 'unix_dgram_sendmsg' - unexpected unlock
>  .../af_unix.c:3335:20: warning: context imbalance in 'unix_get_first' - wrong count at exit
>  .../af_unix.c:3366:34: warning: context imbalance in 'unix_get_next' - unexpected unlock
>  .../af_unix.c:3396:42: warning: context imbalance in 'unix_seq_stop' - unexpected unlock
>  .../af_unix.c:3499:34: warning: context imbalance in 'bpf_iter_unix_hold_batch' - unexpected unlock
> 
> TBH, I'm unsure which is worse. Nor how to improve things.




