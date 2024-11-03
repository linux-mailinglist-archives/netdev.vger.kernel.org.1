Return-Path: <netdev+bounces-141256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CCE9BA376
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 02:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEC01C20E05
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 01:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C241CAAC;
	Sun,  3 Nov 2024 01:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjNVQsZL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E402C2FB
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 01:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730597436; cv=none; b=DKWTHoKfnL3NVDoRsR1DHJ6Gwqn+h+0wv2tJRf8028lli9JAAZDgwVOibJLD/pXCGt0o/2xdUC4E7ZWNZIJWQl/B5tKdLGSP2SIJNhKKU4lnjLsvb+eRldMimINcoslrqPciIwcg7PTELfasuqDeX7dcFcyOUok2g/HZrGzutw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730597436; c=relaxed/simple;
	bh=P0RJ9mzw08AOi4abG+5xsIbVMnLA5j+e5bSc57X+Sq4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=g1TVSS9s+pcZXNQrJ64Y93d4gvyNFfQ1V1swwtUaO85U7YMZ0UXjW+zhT8N0ZHF7H+18oiX6H2BmHSlwWVbHhxGGi6pkjzHogYc44XjkQiMyvRKHXq7QKR52MIcJFLW9I94Tpm3Dt6Q7Ozj71wNCZ5mPGpCDXXqgX78FudR1i2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjNVQsZL; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b14df8f821so277591185a.2
        for <netdev@vger.kernel.org>; Sat, 02 Nov 2024 18:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730597433; x=1731202233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=841QDqoDbsBUo6+w55wSJ6n6FTRdoRriylyWyrz5PvI=;
        b=TjNVQsZLOWuEiJWaJixdqUqtZMx72u2wRXysQNRHKQasL0fliAmmtHYRAYmEI0pOZH
         O7W364lE53uflWwboOmnP9eCFVOWKDW78mgGgVQtbhFXo+YmPkMf1AikBHiIyigEzLjJ
         pBk/kOvqsb6xsru7R6+wBHtgTxCRaqqMfGemXb8h0ByVOY95yvSEr4ZE2H1tHyemGZf/
         OHuN7Z7s4STxPj6L3ZqwLGki9aBs3TDljk85o8gxh8Rsii2D0Q8jQDLPZJQrFZGObPPD
         Az6WCgdOUgVprmSx6GSIskJFlxyGCS0xP++nhSqANEsr07qAyk6jb+H7xH8+CfDWldaT
         xA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730597433; x=1731202233;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=841QDqoDbsBUo6+w55wSJ6n6FTRdoRriylyWyrz5PvI=;
        b=dFPhJot+JsujrhuygbjWhimbeaZqT/agtFFh5GF07BxdVoORhY0px9MCKk5C5HOnib
         tDRaNDoJbEPqUgNbGCg0RBTpFafozTEnqS59+iHposc6lYWLkfSTxpq49ZTW1UQkDtBi
         iMghUkIjeEoIUJUBztAx3Zl9GXoBJhPPc/j0hsa2SEkW5YoQtvMGdkguQfj9XZmoI983
         sQxT0Fc0uqh0mYFLncEODgqnyEAof/E43AEpe39D4TXWb2lhCgEG1PtWMS8OsbRxrC6o
         3fZQysnDU6hM/e1z5uGBFfeLhA2wngnUiTYwDuZ+1wLSDp90jAFti1hdpr+wmflssjsJ
         M1BA==
X-Forwarded-Encrypted: i=1; AJvYcCUSGLu6HFN9jQxbm0/Zjh4pz2fPC+DZLD42sYX0HuofolGPr05p9UT8gYohaY0S51gaGaqE+z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdaxvATwOwHiklhFPZLAKXrR5jUs1acUG+IkwwElbzd9uLKkE8
	ej3LtqgJb/ELu3fBMBVhqW0u2rLv/fo6gVTlcfuMFDkzuu7PJM4S
X-Google-Smtp-Source: AGHT+IFHJ8yH9kpfy6KQXp99Fi9XH90/9by7wEoXbCZcgptBvYbzhwTmxegeJLCaPgaL37eQl5uNJw==
X-Received: by 2002:a05:620a:370c:b0:7b1:5424:e997 with SMTP id af79cd13be357-7b2fb978b56mr995170785a.14.1730597433353;
        Sat, 02 Nov 2024 18:30:33 -0700 (PDT)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a0c199sm303430785a.64.2024.11.02.18.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 18:30:32 -0700 (PDT)
Date: Sat, 02 Nov 2024 21:30:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>, 
 netdev@vger.kernel.org
Cc: fejes@inf.elte.hu, 
 annaemesenyiri@gmail.com, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com
Message-ID: <6726d23863738_2980c729459@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241102125136.5030-2-annaemesenyiri@gmail.com>
References: <20241102125136.5030-1-annaemesenyiri@gmail.com>
 <20241102125136.5030-2-annaemesenyiri@gmail.com>
Subject: Re: [PATCH net-next v2 1/2] Introduce sk_set_prio_allowed helper
 function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Anna Emese Nyiri wrote:
> Simplifies the priority setting permissions through
> `sk_set_prio_allowed` function. No functional changes.

tiny, only because asking for changes in patch 2/2: please use
imperative mood: "Simplify". And maybe mention that this is in
anticipation of a second caller in a following patch.
 
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> ---
>  net/core/sock.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 7f398bd07fb7..5ecf6f1a470c 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -454,6 +454,13 @@ static int sock_set_timeout(long *timeo_p, sockptr_t optval, int optlen,
>  	return 0;
>  }
>  
> +static bool sk_set_prio_allowed(const struct sock *sk, int val)
> +{
> +	return ((val >= TC_PRIO_BESTEFFORT && val <= TC_PRIO_INTERACTIVE) ||
> +		sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) ||
> +		sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN));
> +}
> +
>  static bool sock_needs_netstamp(const struct sock *sk)
>  {
>  	switch (sk->sk_family) {
> @@ -1187,9 +1194,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>  	/* handle options which do not require locking the socket. */
>  	switch (optname) {
>  	case SO_PRIORITY:
> -		if ((val >= 0 && val <= 6) ||
> -		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) ||
> -		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
> +		if (sk_set_prio_allowed(sk, val)) {
>  			sock_set_priority(sk, val);
>  			return 0;
>  		}
> -- 
> 2.43.0
> 



