Return-Path: <netdev+bounces-239702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DCCC6B9E4
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 21:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B0D34F6281
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804443702F7;
	Tue, 18 Nov 2025 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SODY/Dwp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA483702EE
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763497225; cv=none; b=XjA9ZNtkKDW2xNBYLBZEMA5oaBlrA7xqeX6hECwWhqAKZS8VSY+/FCi3FK1q1eDN4+0K0DJvBWx2WFwQ5cNYey0bxW32nSSiQhn/YMR569uacWoMHC/xUrMncbywPqcVlUSbxkTOrGDw9aIuuf+Qq/OnnfRGTXwlZ/TUcd762AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763497225; c=relaxed/simple;
	bh=IbrP+RAFFs5uSyKH8DEgaYosOA3a4YB08+rNm2PfJmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QM1p0EDyHOaR1WO9NGsXEJ82BHPgSTrXFSaxkEYTfTGfiory3/bL6DJo6UGhhRENnVGjoRg0xBq95cpinF/RKF9vLs7gDKuEC76/Ih2Uqp9oU6xl4Oql6No6kOGOzmQ8QJtcbaOLJarM0XVlL2YflQmFSEp2ZGUTO6hvb3nIFsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SODY/Dwp; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b427cda88so4265126f8f.0
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 12:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763497221; x=1764102021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l0pKkIaEqkTeFfMBeLi6StcxmGY0QC1qizzrKLLRaeo=;
        b=SODY/DwptoES347ziIflWCk4w8S7ebnTasQFqlfGU6FywPE0LsAyXaUwno+JtNfmXi
         geU0lyU+gmxa5UlrlF20DVhmk7f9foLN3BIEeqsyIjKKgN5xhOsl60IGjztce9lVM+sB
         QqrHObsMRve8QyLemh1wkn/oymnTNrAaMQN4Ds1zSqP/poeeuWcx9XOWpfZ96v3GT0ua
         byhYU5L4aJDyTF3l4ibLfzNbNubAf3Pl3bn7vCgnDUNb92VByfAygJvJRdC04PRPDvrM
         RGYHa6Nm5f269SRZdh4HS/CfdbKJ46PAYM8NmuVGe4h6w4WCSYPjhVcZwyFU0dKFOB4R
         FOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763497221; x=1764102021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0pKkIaEqkTeFfMBeLi6StcxmGY0QC1qizzrKLLRaeo=;
        b=Ow8kP8+A4cZmQnE2M3D6dyuWc4J0IZDBL3uaAI2vylcZXvQUL6pBQipW2ZoDllIOt4
         cAkQ9uPPfpt/MEyt+mRbhW4vgsIKKDIqFyEm6whL4XY+bQ502iBM9WbsRDI17L5ulDjL
         IfOeH0z3W3L3VittPT4jyV1O3/cwdzeQJORNMJj5p1m8d9mLXBhaZjDWulzE3tQ/qC8m
         6xaMg/SyIaApV9zsjYRqKNqOjask9x9Z3W5xXz6EwMqraXvPqxHpc+9gr9QyVGMQ5olV
         nsLpBnTS3whqyPvnDArGZt0xU+psahEcRdIsemd0B3Wvjq+N/FC4Vfnw+PEwvmEZOHrq
         CYIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaL7gOnhb0i4UAlVtR6CR0YCInVSnJjZat1zdep/LnYJz7aHczJkjtGwm44G0EjkPjhTW+Ohs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf8RqisZ7Hcf+FcxQceqf1oxL1kFCGbEPcF9uRKxCmkesG4+ky
	39MifSBr1d/C3UeyAiyjO2I8AKu8JwSjgpe+xky4rgIfvSfg5TRFuBCX
X-Gm-Gg: ASbGncuE/2UUgV/nwuP4Yfdjt83afSbPEKab9X4AT3TKg4jOpUWtGvPuvmCcUY0q0am
	PYfHoEi1QV2SrmUkCStqcwjFNocDWL1sWw88RRPDmZtYn6ee9UMxDLPyt5jo2Zt++oBkuOoMd/a
	heLCxAP80qPOP3bwoO99Z/3ndPXOOdvWxPCt71eO2pshulJfE70BAlxuTyPkMsxAwMspa//L+0o
	NrXqtOzp26X0cyeQMesKFiwBEQz2JLLM2b+QZxIorcG0itSJqvwHcqw32H7rA5FEiDet9n23okk
	T+WcGgmMpIWv2maxLIJzxXuitZQVEvO9dcuYnRBJoYg6HIJEipG0yBrXYTUySYzyP0GfqXMZI8/
	rZGqEwWyhxuYm9c/rg2ImJ2X/rhDxgYXRb6o6oglOUAFm6zCETR34F3o231PpXAs1Kv/yt1vTJb
	iwRcbZhnJBnJARpX4dKO8cx82QAGqDh/T19SSw
X-Google-Smtp-Source: AGHT+IFewRuIeONGEHUMg5h6XpjXzlc8IyfzgPHPxe8zn2VsF2GBYuWpckKVA66DE8AtS4uUJlK76Q==
X-Received: by 2002:a05:6000:2010:b0:42b:2e39:6d66 with SMTP id ffacd0b85a97d-42b59339192mr17414878f8f.15.1763497220979;
        Tue, 18 Nov 2025 12:20:20 -0800 (PST)
Received: from google.com ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f206aasm34279654f8f.40.2025.11.18.12.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 12:20:20 -0800 (PST)
Date: Tue, 18 Nov 2025 20:20:18 +0000
From: Fabio Baltieri <fabio.baltieri@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Zimmermann <sigmaepsilon92@gmail.com>
Subject: Re: [PATCH] r8169: add support for RTL8127ATF
Message-ID: <aRzVApYF_8loj8Uo@google.com>
References: <20251117191657.4106-1-fabio.baltieri@gmail.com>
 <c6beb0d4-f65e-4181-80e6-212b0a938a15@lunn.ch>
 <aRxTk9wuRiH-9X6l@google.com>
 <89298d49-d85f-4dfd-954c-f8ca9b47f386@lunn.ch>
 <ff55848b-5543-4a8d-b8c2-88837db16c29@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff55848b-5543-4a8d-b8c2-88837db16c29@gmail.com>

On Tue, Nov 18, 2025 at 09:02:22PM +0100, Heiner Kallweit wrote:
> A contact in Realtek confirmed that only 1G and 10G speeds are supported.
> He wasn't sure whether copper SFP modules are supported, and will check
> internally.
> 
> I'll try to strip down the patch as far as possible, likely supporting 10G
> only in the beginning (as 1G requires some more vendor magic to configure).
> I assume the typical user won't spend money on a 10G card to use it with a
> 1G fiber module.
> Reducing complexity of the patch should make the decision easier to accept it.
> 
> I don't have hw with RTL8127ATF, so I would give the patch to Fabio for testing.

Hey thanks for following up on this, cc'ing Michael as well, as it turns
out he was also working on upstream support for this at the same time as
me, maybe he can help testing in more scenarios.

I did test 1G support between two RTL8127ATF cards and it works fine,
have not tried between that a 1G fiber only card (don't own any), happy
to drop it if you think it may not work but hopefully it can be tested
and kept, it was in the out of tree driver after all, I'd hope the
vendor did some interoperability test with that code.

Cheers,
Fabio

