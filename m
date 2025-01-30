Return-Path: <netdev+bounces-161660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A393CA2319D
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 17:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC331885D22
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 16:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423D01EE001;
	Thu, 30 Jan 2025 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FUI1oZOb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6115915382E
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738253722; cv=none; b=ALkDlvLkLVShayhVw79FXpvwHCjYExKJdQpqCbNqxBeXs2l0rt5R3IjHD/7mNC1MttKZm81wtNSzs5ZAjN6sfj3h/r/jTnGngRRHNmHjEh0WtTLSLipuNPVPW5J/iN7UGHPx1tbBNwqBkldquY1fdsfd5BquMMc4Wtp/WrhlG6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738253722; c=relaxed/simple;
	bh=dO+OPJCXXibwKzWyjQUcel5uqQk/wf0H/j7qRS1SYbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HY+9zta+nrw3N2RTWJ+jKsKz6O79802aGobWDGG6hwhoQNsAMxj4nly7ZiaZQ+Li8MUMdadMjE6cIIG1Gx9XfeDEPCNKxtDl1sQn3hWp76oph8wCs94ws9ZrVG/YcphejjblQD2/gg8VSAFd4K31EURVc2KUcUoc3RrFdgEHvTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FUI1oZOb; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so560734f8f.2
        for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 08:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738253719; x=1738858519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tJ5gAZC0bHzN8tU6kHMbxQ3VEtHEehzEjoAQRurzPa4=;
        b=FUI1oZObzcKk2iz0B2Qa6z/W/aCnRcPtTguKz24LZ1wewpQplNLfgsWBXB+B57zPLM
         0fhPGYEmva18x2QxE1y5RsXUCaC6SWA09ciQba3DytGW4dpIx3tqA/xyVjJfbpQDF3AG
         d8EmR6sv+lSzzkl8X9zXBP1YUdDsseb2RB2ctrF/kRXy3FrFUVwfF1KvDnsjRDow/PWx
         GYcuuJgZxTihfMbfbSGCdwJPn2KoTceNw+YyFF6QiVmP/dbfxX7Bb4z0b6ZpkSTGRE87
         tCU81CsxDEQB1PdNzEynCd58N/hCzXI/aKqbuMHZPigluxxfh3rV8CC4XFb1mjPWsGL1
         wsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738253719; x=1738858519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJ5gAZC0bHzN8tU6kHMbxQ3VEtHEehzEjoAQRurzPa4=;
        b=Xbp4DvZvXM92Re5VVQzqW5jScptxmF1XPnoLyBU2Fp1hVMJCPUKqZmt0QYoJ/XtFAg
         bV9F9ZB8G9VThj/JU2Z8EPHeW+JlriC/98WHOCbJdzTMsqBAM3yJh+orLtqVJeU160zL
         hGUA2kLxLOgJauiAlUyn4WTxa+1EsEYmM8XdS/c4JCpkTWUyXvPiIi2iMNtmYApY8o3U
         eCuRn/0wKpc/bMEejYFt7Pc1+rOwNNGHb2YVs0VnRUZpBqvtS0xVILESbN574feO8tIy
         KPSpamgjP1saFe/JlHqg9AteGb/JMgF8XW/Hrzi4HkOUrQkXqLmzAQM0amHN79dJDZfu
         5mAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtYFwmuzlIPdE1vs36gaN4aYpU3znXIhNGj5p8zqyfRKKWVIs5aMUewi0FmrtZHHxaYAcJOZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoP1UTNr2gVlThmfjUpQasGdA2CjYjMTc/p4/KW1dr7SOtYUmX
	zOr1h1A15x6pyXDm9WSHyPCVbG7r08gI8oTDA0NnnFA1tyKyRshSuEzNTJMoytY=
X-Gm-Gg: ASbGnctTRbxLV565307Xiqpj6NtiQY7Zle7N2M45y4EOLwodlqhdauMDnWRjQzAVyU7
	auv0+4x4ns1TFmy6N/UYRDm0RcOAbhE1kpEukLP8Am4IdwCvf/FOMGkm/ICdlbAquXCoYx/Rr6c
	pVzfVtOoeYlJwKeFkWXNf03F8r6arenyDdbeFlkciR7sskM6jLoNIis7cKrpvBIj9hGpEzxOrQ9
	D950E2lB5SrJXrRoxcvJASiUm11vpIy3KKhJXIl0AhtY1ECcL/wU3TPzJ311jXxrzI45TAfJo3+
	rpEEyeQuOun0zF36UwZB
X-Google-Smtp-Source: AGHT+IEWAxjoEy901q5jZtjgoOuXqWVHPE/3mfWiQmIt2BfJ1PCxbLkP3Jb1C2QUHIQvntE2tv4LNw==
X-Received: by 2002:a5d:6d86:0:b0:38b:ef22:d8c3 with SMTP id ffacd0b85a97d-38c5209395cmr8931986f8f.35.1738253718683;
        Thu, 30 Jan 2025 08:15:18 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38c5c1b5492sm2419555f8f.73.2025.01.30.08.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 08:15:18 -0800 (PST)
Date: Thu, 30 Jan 2025 19:15:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: less size_t please (was Re: [PATCH net] xfrm: fix integer
 overflow in xfrm_replay_state_esn_len())
Message-ID: <1ee57015-a2c3-4dd1-99c2-53e9ff50a09f@stanley.mountain>
References: <03997448-cd88-4b80-ab85-fe1100203339@p183>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03997448-cd88-4b80-ab85-fe1100203339@p183>

On Thu, Jan 30, 2025 at 04:44:42PM +0300, Alexey Dobriyan wrote:
> > -static inline unsigned int xfrm_replay_state_esn_len(struct xfrm_replay_state_esn *replay_esn)
> > +static inline size_t xfrm_replay_state_esn_len(struct xfrm_replay_state_esn *replay_esn)
> >  {
> > -	return sizeof(*replay_esn) + replay_esn->bmp_len * sizeof(__u32);
> > +	return size_add(sizeof(*replay_esn), size_mul(replay_esn->bmp_len, sizeof(__u32)));
> 
> Please don't do this.
> 
> You can (and should!) make calculations and check for overflow at the
> same time. It's very efficient.
> 
> > 1) Use size_add() and size_mul().  This change is necessary for 32bit systems.
> 
> This bloats code on 32-bit.
> 

I'm not sure I understand.  On 32-bit systems a size_t and an unsigned
int are the same size.  Did you mean to say 64-bit?

Declaring sizes as u32 leads to integer overflows like this one.  If
you look at integer overflows with security implications there is a
5 to 1 ratio of bugs that only affect 32-bit vs bugs that affect
everything because it's just so much easier to overflow a 32-bit size.

aab98e2dbd64 ("ksmbd: fix integer overflows on 32 bit systems")
16ebb6f5b629 ("nfp: bpf: prevent integer overflow in nfp_bpf_event_output()")
09c4a6101532 ("rtc: tps6594: Fix integer overflow on 32bit systems")
55cf2f4b945f ("binfmt_flat: Fix integer overflow bug on 32 bit systems")
fbbd84af6ba7 ("chelsio/chtls: prevent potential integer overflow on 32bit")
bd96a3935e89 ("rdma/cxgb4: Prevent potential integer overflow on 32bit")
d0257e089d1b ("RDMA/uverbs: Prevent integer overflow issue")
3c63d8946e57 ("svcrdma: Address an integer overflow")
7f33b92e5b18 ("NFSD: Prevent a potential integer overflow")

> 	int len;
> 	if (__builtin_mul_overflow(replay_esn->bmp_len, 4, &len)) {
> 		return true;
> 	}
> 	if (__builtin_add_overflow(len, sizeof(*replay_esn), &len)) {
> 		return true;
> 	}

This is so ugly...  :/  I'd prefer to just do open code the check at
that point.

static inline int xfrm_replay_state_esn_len(struct xfrm_replay_state_esn *replay_esn)
{
	if (replay_esn->bmp_len > (INT_MAX - sizeof(*replay_esn)) / sizeof(__u32))
		return -EINVAL;
	return sizeof(*replay_esn) + replay_esn->bmp_len * sizeof(__u32);
}

regards,
dan carpenter


