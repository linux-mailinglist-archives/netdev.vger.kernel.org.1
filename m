Return-Path: <netdev+bounces-178235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB09A75D5C
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 01:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D13B3A9140
	for <lists+netdev@lfdr.de>; Sun, 30 Mar 2025 23:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4E919259E;
	Sun, 30 Mar 2025 23:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Izq9SwJ0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CC32B2CF
	for <netdev@vger.kernel.org>; Sun, 30 Mar 2025 23:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743377549; cv=none; b=hIlx7INnr5hAkGlFx9DNyNOTPNyy/rRMPyaihW86VC+kKgZ+gU90TQHZJ/sI0CGJnEeXX6jn+La9ZbeeR7WEs7JQKf+kTdLVLizkRgyLURrjVPxN4nwQut4mwZ2iljk4d8Yj7dCKII20rOpWvMbsldde4fcvIi2aQEbtaJThZpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743377549; c=relaxed/simple;
	bh=ubOTaGccVyjM5jxI9jVSSL12WvpS5uEiqk00pDzWTEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOconbfy2uOAzRx5ER3fLMUp06ENJV2UqBo9vTP+UUVeOFy9HrN9QCiUfBStt+XrlfKWiCrK0Dt94KjQDdeYect9HUcnGeZOo5BfJ6GAHltjgQOS2n3JFRqZ1sP/rPNJy2PrBZ5xOyF2aJ0GgoKIfs5OBQDSELmf1yTiLT1riUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Izq9SwJ0; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3032aa1b764so4907687a91.1
        for <netdev@vger.kernel.org>; Sun, 30 Mar 2025 16:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743377548; x=1743982348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KuCIAzvn+ZxyxkSxMs5C0b5YboXJPBL4mavZXb+Xg/c=;
        b=Izq9SwJ0IcGHj2LQIMpRxH44URmElkFpRwS6glcCNt+QWRfKxuePAMlmZb57t8J2GC
         xNwVd/VFh+QCRvr2816fE/bArLJeMrF00ynVx7asYTeuAZGLa9fNJyjGx00ICoAEoMkJ
         Gmjf4WoSjDru2TIMsSyW0kcWnLhlWdYpEzqTlx8ItrBxHfZgo2qfsEVR2k8xaTn1oy3s
         K4Xi181JsUC+uA6cHoez7e75iyTewIqgm07fcKImAKmZ+frq6nO/h+PfpoXMIvquueU6
         7Wg2ii14VIF3bQ0s5LJ6EsYJwrV8yg/JK7jn25r0W15VBJP2kJQ0mI7mrU1DMwfGkFop
         sLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743377548; x=1743982348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuCIAzvn+ZxyxkSxMs5C0b5YboXJPBL4mavZXb+Xg/c=;
        b=Cad6dnPpfFboILAct1UVsuazn4VDurUsOoi/aEZ6SKOuPlWjx8sZespJW1m55Y0jUU
         K8Vhu+N0okTlMI860bKwnKOLkTewWnYcMBXknDRLLEpMzabDrTTwIsUE0mmfdpTNMLjx
         jzeTp9Stiftm1Gz9G+KJbIJFUZ4mgs2J5o3EfCNWGMytvQuxcgJMK8Y5qJhGHUxKXXm8
         0oWwLOEUV1FJ0qS/fcKa8ubC3eBrkkRU3Kb0pWh+rkAkJ8ZKFwZReeIikOAUtrU38Hfu
         WCEywr1tcWNSBMT6RJVFWI1hgMSYTJK4JoQ98dJqKohISbiyj4kAFFM2nBkQchXXWXO3
         nexA==
X-Gm-Message-State: AOJu0YyzrhPLe7jo2idxzEQ+ePbWx/Qwg0P3IVcNMHDkN9+HogxFP1Wh
	4x1DjaLJwbxcXl0+p1U8vD5IWyjU1mwpB+j6DeR1OC/rPdOm+z1/FGbX5g==
X-Gm-Gg: ASbGncuETukjgIHheEH3smRix18pGHwOcPDfOiL9S89GBSF+K8fYOOo4HW5OcZvohse
	XkI02qCQkNsJLlwXGpcHdDe3Zywp+Of9ycF0GH7oDJ4bdzMpifLimHcnpxa2/RvDenZWJi0vnM9
	uYdAbMogp0D/GTeEfAfDoMF3AMWNi4Pffq6f/hcFTcMCEyRn0b+JQzRMmnHH2IMb4q0Tvdym/+1
	/osqbQD+/cTN+N/nEhFrzHv5ChKqVfre13Bn3KzZ3eUFYbotusjtOnYCiD8I4T8NrdmgiMuOPD6
	UM8rX24AHe7iqhOXc8yn2RKZFjyOgShlmK9SnGqcut0E7nBLhH4=
X-Google-Smtp-Source: AGHT+IE0FxCFz4S325rS+8HT0pJlGxyJxdyMZvD21SUpQVf7yw8mXLCqWGX2yfAZ9rkekncuPL5VeA==
X-Received: by 2002:a17:90a:f950:b0:2fe:b8ba:62e1 with SMTP id 98e67ed59e1d1-30532147209mr10999609a91.28.1743377547609;
        Sun, 30 Mar 2025 16:32:27 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:b144:63a1:57bb:af94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1ce283sm57812225ad.126.2025.03.30.16.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 16:32:26 -0700 (PDT)
Date: Sun, 30 Mar 2025 16:32:25 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	edumazet@google.com, gerrard.tai@starlabs.sg,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: Re: [Patch net 08/12] selftests/tc-testing: Add a test case for
 CODEL with HTB parent
Message-ID: <Z+nUiSlKoARY0Lj/@pop-os.localdomain>
References: <20250320232211.485785-1-xiyou.wangcong@gmail.com>
 <20250320232539.486091-1-xiyou.wangcong@gmail.com>
 <20250320232539.486091-8-xiyou.wangcong@gmail.com>
 <3a60ae0c-0b5f-44e9-8063-29d0d290699c@mojatatu.com>
 <Z+cIB3YrShvCtQry@pop-os.localdomain>
 <9a1b0c60-57d2-4e6d-baa2-38c3e4b7d3d5@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a1b0c60-57d2-4e6d-baa2-38c3e4b7d3d5@mojatatu.com>

On Sun, Mar 30, 2025 at 06:05:06PM -0300, Victor Nogueira wrote:
> On 28/03/2025 17:35, Cong Wang wrote:
> > On Sun, Mar 23, 2025 at 07:48:39PM -0300, Victor Nogueira wrote:
> > > On 20/03/2025 20:25, Cong Wang wrote:
> > > > Add a test case for CODEL with HTB parent to verify packet drop
> > > > behavior when the queue becomes empty. This helps ensure proper
> > > > notification mechanisms between qdiscs.
> > > > 
> > > > Note this is best-effort, it is hard to play with those parameters
> > > > perfectly to always trigger ->qlen_notify().
> > > > 
> > > > Cc: Pedro Tammela <pctammela@mojatatu.com>
> > > > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> > > 
> > > Cong, can you double check this test?
> > > I ran all of your other tests and they all succeeded, however
> > > this one specifically is always failing:
> > 
> > Interesting, I thought I completely fixed this before posting after several
> > rounds of playing with the parameters. I will double check it, maybe it
> > just becomes less reproducible.
> 
> I see.
> I experimented with it a bit today and found out that changing the ping
> command to:
> 
> ping -c 2 -i 0 -s 1500 -I $DUMMY 10.10.10.1 > /dev/null || true
> 
> makes the test pass consistently (at least in my environment).
> So essentially just changing the "-s" option to 1500.
> 
> If you could, please try it out as well.
> Maybe I just got lucky.

Sure, I will change it to 1500.

Thanks!

