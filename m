Return-Path: <netdev+bounces-240933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BECC7C2AE
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 03:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B8344E032D
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 02:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8CA23183B;
	Sat, 22 Nov 2025 02:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmjpBe+Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF6D201033
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 02:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763777820; cv=none; b=bkRDEpaA47gZF/BYWbLnBEhKwzLZW73t6QYf4JYjRY4Yc37XhDQPWOe7tRkdPzUm6azrQW0C1CcM5EG0e46sNdqQkch6iJqNxH8kBjLh9aBbG8OR0GncwSIAiElF181gBJGQtmf+BZk35wjbkQnpHNiESKt/4XD7d+hcPn7zCig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763777820; c=relaxed/simple;
	bh=HcTrfLl0nwxO5b2LTWB2R002IRkel0ACVCeGY+W8t2Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=B+GgpcGWIrndCtc0EHgpPghLHK+ptaBlc8L+1mbDvUpu0J8MU3j8PL5e5wC5bFfRXfHWOukdMgVFABVYk5dqbsoXqcWgDtR+1nu5jPzHJvtywKib52ubXdkvgk4+QCHtoToGlRmTfcymDq3KfrGaRPRifE8qWbsxxpN6mvcdtxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmjpBe+Y; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63fc6115d65so2241104d50.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 18:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763777818; x=1764382618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZH1duZnEPXr5MV5XSfY2om1ciAirSpLv1SrLG39apQ=;
        b=OmjpBe+YkaMd06KW4juBXlmrzO5506AxVnV/FI6Fu27wVtgb8Yj+S7NHg0ZSEB7p6s
         gmlc/+8GhJj8Aki7a7D8Tp2gHkxrFORSFkcbH/RzG9j3w5AY3GyvMyWrifVwbleb+t5t
         GbT865EVyXawPMEbpD0rICtHvCPI+UxhewrHzQ3ETGonSxuzvGa8Ld8lYqO51LOYmFY1
         Unarl5Vq3ifIg6I4yxvFlFc/Gy5gEH1iAygdGNRe6yyoZNeHX/f5IaMJj4QZSVsHdBMQ
         2FdCDYiwtWEgvwd3ammzbPJ23U5bftyZ+6zBqAK72xqIUqzRIETg1tQ59DibYvrz8nem
         HbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763777818; x=1764382618;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZH1duZnEPXr5MV5XSfY2om1ciAirSpLv1SrLG39apQ=;
        b=tnaLRgCsqWPxA48Qc2vJYUZhIOqO0kMRY9Bz++P+pn7dGWcMXtZ8l3ix3R7Wm3L2oe
         iQL4PYI17foG3/w/GxXRLOSB8DeSS62+wJ+WcbwbZUaY5tf5ELOZztmj147mYIlPA6z1
         6SLtcV66V5+K4F+vijQtmw1SAABZjwbD9Yz7SlLE8qRC/pQbRxLIcMZPtT9AorMAtPuJ
         KP6/p6B/TMDlA5kavvSEnv02m4aev2/QnAeoCZtiWipLp76rPPPOGLqTtbJIRW0SSU3n
         gUgIv36j1tfpqE7eMPTSbua3XsqdjMEfgTUy1aMcZwtAk4NHdG5i++5tNeMVXmgHIYIU
         n8MA==
X-Forwarded-Encrypted: i=1; AJvYcCWcaiU++3QjyXg3nSFNUfsHRCoY+3teuXA2YAS6XDu9oxR0cq/gcHS6wORBnwcasPwZwXmkt28=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWE3W6b5UVQ8TZVkyx4bzd9S9EADmBz7pLiInOZnyWZI3F+3+D
	mm0CJNpIHTa8bQMjNqxyzBHSN6H/qLaBEhNmO0FDtK/aIBSKlCKJa33V
X-Gm-Gg: ASbGncsU5KFwyLt9euRL4hNix6LgWB9pkJPMjF6xkxkTPzBPfWAWKH2pZx37DHOYG+y
	zkEYAaIi+ECA8YXedAPjMXwYCScd9MlGnE2CNrcpQqtjqDcJ/82JUwB5yOXo7UYUV6J999LouvU
	sMfphQJbK4c1S4d/0FNpxMthxFz5yUyMAFrBHVJPnBykHwGo0iXDA9ujJfjWLh69+UWf3QvzZMq
	qLkoGEUDptSSS7dKBIfTVThF1VrGjaVr5AbzjDwuuj5jY435jJ1b1Tm+BWP4YXvpS01JATSXvvD
	hTSOLSPmrLeJnb5rQeyCW8SIyXUvQsW7eBUNLbFbHMJJkgaAmlAlIRThjwPb627aypwhixNfNee
	kRO4LUherCHlgsOykbrIrnd54M8qL/T+yATZB+5v5dacmtJaYfjnGYRq4fOIE2IpxHj5vlUbomH
	Fdtx8IcCuTyox9WQipKdH1rbrTm2Cpnc/27RwcnxIFl9tS+DqPuSjR2XKwT8RMd85QLHQ=
X-Google-Smtp-Source: AGHT+IHoO6qNAUPw4+8PucvKAsU+85vfg1dtDVD5lxUKXjlhSCB8zRWLNk0AzYZnMtp7pZX7xPRC8A==
X-Received: by 2002:a05:690e:1511:b0:63f:a324:bbf3 with SMTP id 956f58d0204a3-64302ab18damr3307134d50.42.1763777818152;
        Fri, 21 Nov 2025 18:16:58 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-642f707a9b9sm2278959d50.6.2025.11.21.18.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 18:16:57 -0800 (PST)
Date: Fri, 21 Nov 2025 21:16:57 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemb@google.com, 
 petrm@nvidia.com, 
 dw@davidwei.uk, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.53e77e2eea78@gmail.com>
In-Reply-To: <20251121173203.7bc1a3f4@kernel.org>
References: <20251121040259.3647749-1-kuba@kernel.org>
 <20251121040259.3647749-5-kuba@kernel.org>
 <willemdebruijn.kernel.224bdf2fac125@gmail.com>
 <20251121173203.7bc1a3f4@kernel.org>
Subject: Re: [PATCH net-next 4/5] selftests: hw-net: toeplitz: read
 indirection table from the device
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
> On Fri, 21 Nov 2025 18:12:16 -0500 Willem de Bruijn wrote:
> > > +	if (rsp->_count.indir > RSS_MAX_INDIR)
> > > +		error(1, 0, "RSS indirection table too large (%u > %u)",
> > > +		      rsp->_count.indir, RSS_MAX_INDIR);
> > > +
> > > +	/* If indir table not available we'll fallback to simple modulo math */
> > > +	if (rsp->_count.indir) {
> > > +		memcpy(rss_indir_tbl, rsp->indir,
> > > +		       rsp->_count.indir * sizeof(rss_indir_tbl[0]));  
> > 
> > It can be assumed that rsp->indir elements are sizeof(rss_indir_tbl[0])?
> > 
> > Is there a way to have the test verify element size. I'm not that
> > familiar with YNL.
> 
> I suspect the reaction may be because drivers often use a smaller type.
> But at the uAPI level the indirection table has always been represented
> as an array of u32 (I mean the ioctl). And in the core we also always
> deal with u32s. The Netlink type is not allowed to change either 
> (it's a "C array" not individual attributes so members must be known
> size).
> 
> LMK if you want me to add an assert or rework this. We could technically
> keep the rsp struct around and use it directly?
> 
> Not fully convinced it's worth a respin, but LMK.. :)

Not at all. Thanks for that uAPI context.

