Return-Path: <netdev+bounces-204440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439AEAFA736
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 20:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0FF3A6669
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 18:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302F52877E4;
	Sun,  6 Jul 2025 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="ZObrtIBH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B355A1C5D77
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 18:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751826975; cv=none; b=tfiXrJ2AFRT/txHhAgld+XmErLIc0KKFrlV/FWYa9jyG7HL2tF2CS5CpIb+7emMT4rfbxeewHuR3FPu4r4Tzwqzu64nMZmrlpLSgxIqudx6QPvPLfMiQqs9YIwHWaB3s7hOaVIc/vx0DPzivopjHQCPtwOo4OXtl40bs75byL38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751826975; c=relaxed/simple;
	bh=EaSyyumbPn/z7D+Peo+TAe7w8FD0BhRKW0vhSRvqVvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9/9N0p5BOrraflK8eEAfnqU1MSA7GTcpyaOqdXOL7jazveycPidMCpV1uyRIXUtaOIuZC0Bo7qUW7vxDeDz602ykmrmIehnX3iK5CQ/4+atuhI6Xl2pInHToaOPcj8Ed18yqr9g9XFw0UiHUMkuTA2KyPbyQ7tMC+Q0UDfWK7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=ZObrtIBH; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7426c4e3d57so399570b3a.2
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 11:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751826973; x=1752431773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EaSyyumbPn/z7D+Peo+TAe7w8FD0BhRKW0vhSRvqVvI=;
        b=ZObrtIBHEY6pPbYUQqBzAYsakvIjgeIsFRdEsBTqK7Xwgk1D4+5Q58wn/bGnj0oe5e
         y93APPaN7TUAoa8lAmH0VIXCcE0OIgwF/7t189p0jEu/q9AR54OBBhoB+0jx3ePJHayO
         0gMG4xBOxJeRecmmaZiS0ldW9sHJOKsk7jSweTaQUCr1+NLXbfMFbmqAFu6AOiRgaVPM
         ukgSTsGEY5sH2MwY17cLSHZ5tii7a6xOya3jyuoUb6kXpKtSrPe1OaVCCF/zx01XJemr
         uooeRI0UI8NLJXTHGw3y9ODEiZ1qW50ASqL58Rp9xJafMwfOO3K5JZMO8tG3V2npAIh2
         QzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751826973; x=1752431773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaSyyumbPn/z7D+Peo+TAe7w8FD0BhRKW0vhSRvqVvI=;
        b=QekUF5YBOwxbLws5XZUgHBef+meD3uBN0dg0JSS89VmLB7cYQuHkNbJXo1lU+ElZta
         cPKd8A89hOs5DSNqpTmptiz4vzZTtiJa/H6awY+S+EgXtxKT5OuksvYvK1WQINCPHjJc
         NMwn8Mo7wFQ7Ll38aZ6QmVzZU+VGWVoP5d4/nq69aIc6MFNJg+B1/nTJcFLxUwQOp8K8
         XH2Eadi4tbPbyEKvG2bSH36h8Ii1xPYt1ngXaB/THphlxjfD2Z12R/fr5V+LcsaFz2ib
         mtCwo9VGh38QmMWUE0nvAzW1iwS7NJG9XiDZQnoIotvW8ibUyvhfY3xItStiHKILo0DB
         SoQA==
X-Gm-Message-State: AOJu0YzzWEZN0uL1Rwgs4CAJGWIrDnOjnlwc/2jom3Y3WJ+IQiyYhTeS
	yGYGKAyEs6OzW3ShVMBQf0lmF3anyDFPDxvboKgAZeQWMqzhCBCNAah+ilYi3f4c9+M=
X-Gm-Gg: ASbGncteEERFQqveT4UpDodY9QvvKFq/paA/yuV9XY//5eWdEt2vML/WRwr8xLRBhbf
	nxT69+du5/W/g0VP39I9lVK8HU9TA/hO7U7pBD866gHYEg885Iv2/C4jhud+uxucaC3VUk0sKBp
	Gfdvy/P9uFEt+afR5H3Pid6ze+qeRO4b2iIpDZ8jCi4ug3F+Z+DMjHftEe7+QtiG0oUUA0METOh
	J0Z3/0Xv99tf2Ccb3KD4hJdjjvoxoWc8oNKySS4I2ktr1M0SZOj7ufhkk5quiO6zEWkiJrc373B
	pux9OhrExNS13whT+5xXpjb/5EcCDSOrmjyZ9aoVuCdjJ8B44QKqJC+NH0k=
X-Google-Smtp-Source: AGHT+IG91q24WBqoOFy3IButW8Z/B4H/etgIOaxw4tS2rHdcvGhID6hawdPFnji8oLdkp4ZpY0LPqA==
X-Received: by 2002:a17:902:dad1:b0:234:c549:da0c with SMTP id d9443c01a7336-23c87178d8bmr52961415ad.0.1751826972892;
        Sun, 06 Jul 2025 11:36:12 -0700 (PDT)
Received: from t14 ([2001:5a8:4528:b100:8dab:9982:878f:106d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431e15dsm66523425ad.36.2025.07.06.11.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 11:36:12 -0700 (PDT)
Date: Sun, 6 Jul 2025 11:36:09 -0700
From: Jordan Rife <jordan@jrife.io>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v3 bpf-next 05/12] bpf: tcp: Avoid socket skips and
 repeats during iteration
Message-ID: <s55nxnbs4gq56ytq627n7wanqkcrbn5vmbht43tdrrbcbe5jl7@uufojhrm6qyh>
References: <20250630171709.113813-1-jordan@jrife.io>
 <20250630171709.113813-6-jordan@jrife.io>
 <aGLYO7XRafb9ROQi@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGLYO7XRafb9ROQi@mini-arch>

> nit: let's drop {} around sk_nulls_for_each_from?
> nit: add break here for consistency?

Thanks for taking another look. Will address this and other nits in v4.

Jordan

