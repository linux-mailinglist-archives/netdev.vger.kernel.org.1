Return-Path: <netdev+bounces-99964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21528D7305
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 03:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45AE8B21006
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 01:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE0515A5;
	Sun,  2 Jun 2024 01:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNhlEbbA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B50A21
	for <netdev@vger.kernel.org>; Sun,  2 Jun 2024 01:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717292108; cv=none; b=YZ8TMuY9f4JIL+C0zSdRNQ5zc1hLsjHbk7KfpYkwxW5TCj2xoBJsyYYb6t/Rs5qSCAqM9vghk8mefZiCUIJjvZdp1SkStRxRAS2oy9pRMhg5sH14eeMNr7FDS9lZwfX+ZQqqvVFdDzoYBbOK9Nwz7V+2o7laPLFhfTJhEG6Rxqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717292108; c=relaxed/simple;
	bh=zOm8LsWoqxyyYNtXt1211IJq2j1oNCELPPYYsNwTw6E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lIROT6UWaKtzDzT5lDHB1ftN5p1CYPWH9L8CKDV13birz27a079AJVprH8k2hlzGxHKdR9j56wnnnQzZ4flHFaB50YxSM7D4THv82FXkXe2T3Tu4SYHIKwOYjKrG9Ic9/Pql9dIwS/eIYU8R7m3RSNZlyitKXSKcO9xg6K3F+bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNhlEbbA; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6ae60725ea1so13073016d6.2
        for <netdev@vger.kernel.org>; Sat, 01 Jun 2024 18:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717292106; x=1717896906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9ppVBOWciW7VBoZG//V8PspX74UoRB+vuqQeneEijQ=;
        b=PNhlEbbANmLK/0BAe5A3ME+CJ3hrUGhZl7onRYhYWD3FCi9ccCQmLbuDIDkXLHljYl
         1s1Y4m/0qILLNFP5ocNeAtdPyl9PrCMMBnH9vs1s9II9EsygN3CxffJJLGAr+jLsOW7C
         +XVK9wuPjkPY1uiy/gtir4+Ods59zhUR77q1jqy1PXhwD/O2WKGlWiI/7JA6r7IxPfNk
         fPXSMQC7I5VOGuGI5WgWEMaPh4NHed9eVw6IYYqB2MnIPmNb/T1nvSWi6eR29VafaDaM
         XDCtrqdT0sAsUdwXi1G8t1F3fRfPXcRm0Gj6BmASJNoKXWZZymVUpV0UWjwMZYgnXAJL
         puww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717292106; x=1717896906;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o9ppVBOWciW7VBoZG//V8PspX74UoRB+vuqQeneEijQ=;
        b=Kn8Z0d72zM2cKfLe5s+obbtZb2aWayL0rgwLD0sTGTMJ9OQjTZSA5JT8HAz5Ldao8e
         akFB9icxUmAlO874Wye6HZwmZzYURpJIYaxD5udHD9VDU6Fhnh9rbCsbWhuWBW/lzDEH
         B2TK0HOnFAfayIOn8De1uYRtqtgU0jxUUJyMkQOZwVvMDCESRYVVbi08r7KGZBECNOzO
         Dtc4yFuzKTr4T7qkPv1DeVcdz/SAp/sthbNHzerzYgoPx8j8xoqUVZtXxQPQYPJS7HKV
         aF0/HNvJ8GmD8ROzMZZH8X+8C9b7r/9PIHNXgDnjl9jnabMEOShQCRGhOpFtW2yyHyU8
         EeTg==
X-Forwarded-Encrypted: i=1; AJvYcCUg6kkFBw1u3YIkuw11r7i4IjYWsmCupEJLjFIj4CXcKNmFIHGRGYgMwuvVJamJXygZ9KS7waEYfvpUk0lxk1yh7qo+4eEs
X-Gm-Message-State: AOJu0Yzp3aGjRRUb1A8V/yEZ9uZYnogsXaaEdc0P9cfOP01RU6haNX2E
	wFERYtFvwbg/Tfl8lp6Kv/s06RdzLQcCKEsg5pNOrbMVtm5hY9Z/
X-Google-Smtp-Source: AGHT+IElFXjAaw0z5HqH5gIclh6dcm5V837UNKlZeT/cTKmlsFQ4NyXNqrVamMB3+jWq8tnRnjJO3A==
X-Received: by 2002:a0c:ef04:0:b0:6ae:d591:3a4 with SMTP id 6a1803df08f44-6aed5910519mr45849276d6.11.1717292105597;
        Sat, 01 Jun 2024 18:35:05 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6af3d644efbsm7047486d6.19.2024.06.01.18.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 18:35:04 -0700 (PDT)
Date: Sat, 01 Jun 2024 21:35:04 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: edumazet@google.com, 
 pabeni@redhat.com, 
 davem@davemloft.net, 
 netdev@vger.kernel.org, 
 mptcp@lists.linux.dev, 
 matttbe@kernel.org, 
 martineau@kernel.org, 
 borisp@nvidia.com
Message-ID: <665bcc4869dc3_94803294e9@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240601145620.065e6a5d@kernel.org>
References: <20240530233616.85897-1-kuba@kernel.org>
 <20240530233616.85897-3-kuba@kernel.org>
 <6659d38ac31fa_3f8cab29482@willemb.c.googlers.com.notmuch>
 <20240601145620.065e6a5d@kernel.org>
Subject: Re: [PATCH net-next 2/3] tcp: add a helper for setting EOR on tail
 skb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Fri, 31 May 2024 09:41:30 -0400 Willem de Bruijn wrote:
> > > +static inline void tcp_write_collapse_fence(struct sock *sk)
> > > +{  
> > 
> > const struct ptr?
> 
> Maybe just me, but feels kinda weird for the sole input to be const
> if the function does modify the object it operates on.

Ok. I can see that.

