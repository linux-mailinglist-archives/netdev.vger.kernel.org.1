Return-Path: <netdev+bounces-293468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFGeC3CDHGrTOwkAu9opvQ
	(envelope-from <netdev+bounces-293468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 20:52:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E8D6178C0
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 20:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A0423002F76
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 18:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796E82D9787;
	Sun, 31 May 2026 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxTD1jta"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F5728469B
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780253543; cv=none; b=LBzzGzaFUd1q+wDDLcVWthEhAL6jXRxvB9gMFGQDzWCgBbm7QT8PjOsKtYvNSaeabtpcBNb8tvSCblufT+L8yuZbiMzxQtWC8zwMBQZqILkXXOJJzoQmsArRm/QAa/jCTPqbLgIlIUKbUO1CUIYgtCo1s+u0Xdhg3IMyLPsyacQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780253543; c=relaxed/simple;
	bh=e4MjOJtv5qcIimMFEGK1bXhy3EZIAaYH8VJGNkdHZ7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HdMe+tfodZO3Ze04FsOgMXwkiKvIsmjf2mvVDSQG4sr6c80HCZvW1qSZNPvsxrO5ObSnyQSau/gK8sGIm9J39wn3O4KS1+92MMqD7z3r+EOJbvKqPhbLhMuU+kEAyOCNOXsZrOZG3qhWiwOi53kl13uHeB0r53mWP31c4V0HDKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxTD1jta; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4906238c62eso73662525e9.3
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 11:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780253541; x=1780858341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCdHOua92Cb5cBkKb8ei10+dLLBwvJr9VX/dMVe/tG4=;
        b=mxTD1jtam5a33JFZt9rcLoQYYsMSnyi8CaWTwRNYCzqFRwt7ft96vs7kbxabQYPT2M
         4zVtD9AmxIXrx7QkUSOlMjJEDeW/Sk/pLJ6L/W1xSZG5mz/PzfT5e2UunnpGVYSx2ho9
         uj6ORldYRugHwrhEbVR0tIzOEQuvuG37Dad/vDaZyFt1V4hZi7gFkoJHx5NLC7WOps7A
         G9VqSLoGY5xJNtj9n2b240j2vBFWTcOcW6gRz1ku4vBnX70ak89w1FgHCPzVt33De3Fj
         2HuTGJlbsetzNOdE1KLXriHiNa7r1YKHdK1X546B3qnqcNcdIP2n2VMkuB20iFpcAHEs
         h00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780253541; x=1780858341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RCdHOua92Cb5cBkKb8ei10+dLLBwvJr9VX/dMVe/tG4=;
        b=sz229ABwULwGWhrLyu9hVTJkKajADupHTk6t8WoDtuBoL3grjyf5z7SKO1Oy1JxytW
         /yp21Sxpn0tTbwhSQ/PZL4OTrRSYMr2OzTO4rfASF49DfHAwd3oUlgcS/1XZAryydMb7
         yJn5xCly9ySkAGGuM65ZR92asY8YIy7lVHJBXHZxYUXtwcM1154NhMYUaN6iZjt1HOhh
         ivyG/TwfBr+TdosyDWkz4s8rG8GRsSOUS9x590qEaeOyuOJaTY1pHhWc3hP+prRLweCx
         AMf4i2FBgJX65ixGwzAMwdlLBc+C3lQ4F92bIf3lyEXfvvP/l/fChe3GniU4GI8n+udi
         wvcA==
X-Gm-Message-State: AOJu0Yw7tZFisRAYN7jE23hFi0CG9TchBBUy2MKtT9LSb3Hr+ZIdFQWx
	PK370qlc9C9fCLR38hgKAo+TQJxasKtxoF4UtUFGi59TJTVhUsdpYKZ9
X-Gm-Gg: Acq92OEXGWGX3y92Onca48chqt/yZS2o1MnQexVHhG2cF+x2BPaPip5xmsIJuXiYPwh
	455fHnbKlGliEG4VCzg57r2Uff1Fkx2X+5bJVXb9987VT4yytsjyAKCUq4W7wBRra+DXEOnsTy9
	IDsglkY7fM6BQK4HTriI1YC6P1aZiEC1h/NXm9JBf/q/L5EL5VJQY4c+Fi7nCTzOL9oFn7Pa0ab
	gP1H1p0+eL/1GsHDv5vf9on1+2q/3sdFCt8Z+XR8LyBNzzN5EAZqTpDp+VQsGNlyEgPAKQJkrlE
	FejwtTmd8zT2H9J5dxsIIWTUViiSJEw3z8kkYz7Z6GfMvR3GLK1gTG66FnHwpnxqCEhpFBRKtOU
	cv+kPGzbyrd/Z+YOLdF/GJxwxj1lMl3zyziW4xbviTYLeUuyFSJRXDY6Dc0TAqWFnVQE37DiN2H
	VgYlm6wULYJFM/YwtLNzr/c6WEc9k3JgcVkUFLgxeggOMOsK3j2vakduDJCPhNGPOJczL6doE=
X-Received: by 2002:a05:600c:8b77:b0:48a:9428:5522 with SMTP id 5b1f17b1804b1-490a293a0b1mr158612245e9.16.1780253540632;
        Sun, 31 May 2026 11:52:20 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34bd896sm18480387f8f.14.2026.05.31.11.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 11:52:20 -0700 (PDT)
Date: Sun, 31 May 2026 19:52:18 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 victor@mojatatu.com, yimingqian591@gmail.com, keenanat2000@gmail.com,
 2045gemini@gmail.com, rollkingzzc@gmail.com, toke@redhat.com,
 dcaratti@redhat.com, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@kernel.org, Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Subject: Re: [PATCH net v5 1/1] net/sched: fix pedit partial COW leading to
 page cache corruption
Message-ID: <20260531195218.5fe29990@pumpkin>
In-Reply-To: <20260531194241.7d5d7e6e@pumpkin>
References: <20260531123221.48732-1-jhs@mojatatu.com>
	<20260531171534.6aae381a@pumpkin>
	<CAM0EoMnKxEuexh43U7v8s3UwNfr5B=jXUQxw_fCw_tB-Li39cA@mail.gmail.com>
	<20260531194241.7d5d7e6e@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293468-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com,oss.qualcomm.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 26E8D6178C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 31 May 2026 19:42:41 +0100
David Laight <david.laight.linux@gmail.com> wrote:

> On Sun, 31 May 2026 13:25:36 -0400
> Jamal Hadi Salim <jhs@mojatatu.com> wrote:
....
> > >    
> > > > +                             goto bad;
> > > > +                     if (skb_ensure_writable(skb, min_t(int, skb->len,
> > > > +                                                        write_len)))    
> 
> You've completely missed that the above has to include the write_offset.

And I've missed that write_len isn't the length you are going to write :-(

This version is unreadable....

A few one line comments can make all the difference.
I put these two in for a reason.
It took some effort to find out exactly what they did.

> >         /* Ensure any needed headroom is writeable */
> >         if (hoffset < 0 && skb_cow(skb, -hoffset)
> >                 goto bad;
> >         /* Ensure the skb is writeable to the end of the area to be written.
> >          * The data is pulled into the skb header. */

-- David

