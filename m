Return-Path: <netdev+bounces-206310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C70B9B028D4
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 03:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65CCDA62744
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 01:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8D1149C55;
	Sat, 12 Jul 2025 01:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="AcRek1df"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC7513C81B
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 01:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752283552; cv=none; b=Nvlc5rI1CdJNi9uQfOggjD4vBkoBq8j+mcoBLeYAkFwuJr9jKcrnAa9YAD5rNr8Ta3TU5Az5XLuIt8FwBgyhhAmqJGcXnE4KP92PmdaaAO2p7UX8bZ/k5za0nuOGCSYzhej/Qy1azoQZJ/5UHBMsHTAvwHT4BQylude009yDZmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752283552; c=relaxed/simple;
	bh=PS2YgBqI+n0K9OhdaYssPwqWk1XPSWBqfkuPRBvwZM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enpVIm63FXRxnEtyfsWbgvYeXigVuJfOT1GkqM5iNzMym7vzAxkmdN6NXIJjYu8Xuvhl25zN9PWWXaGqBISJ1oaQzbn6O7YaYVfkgjJLEwmOhT0O8ZY4d0xAH7lqEtMRjVEfKGLRTmyNwvdE7ectodT+N9IEUwxEfYw06H6B7J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=AcRek1df; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-313bcf6e565so373486a91.0
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 18:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752283550; x=1752888350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zm6O7L5piyBZEAF6L3BH1tqbFWWMqUD4pr03r8tz/i8=;
        b=AcRek1dfD6NvJvobvk2gb9M0zZKloTJD22zrSH6ZflwLglr3X6dwRbZOH1G1UsDCZn
         ZjpAo8NZ61BAUPo8AXFRT5AF98i0m9BG9T/0+vQg7n+pI/sxgtOgpfhTgaAsvJTJnu4C
         JnD35NQfIghkultM0Y7Q1Z8DNw1bMBY8SSdOBS8p/SjkqeAC/yqAuZjHvxazN9L676DR
         npdtcsc3f1nNZh9GF2n/RIDaGXyEOsq6qUVuAF55tW2deYW6uJevvbIKOCy6s/fpJeoJ
         gVvK/MqCgYm5Wr0j0HBB2y/L75Sd1yndJBF9mCb6m02bvGBotATIPikGeu7TBzOnDAEy
         skiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752283550; x=1752888350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zm6O7L5piyBZEAF6L3BH1tqbFWWMqUD4pr03r8tz/i8=;
        b=qw3Z1rrw5Y6NSknitPV8R6ZBpRXqsY96CMGj/uPJdW1wTLrTXyXtZBBVWUktMSVX+G
         QFq5xfNweYTj40ccbKlBd3YDZxqab8BSJChj1WgeOXRu5fSjP5D54TbKzENpig71tRvK
         TkvIF/WHIPAPxCfjcM28L3b9UCj374eGZSFqi9w20tXYEyAm7eW3+8FRYQjRz/JvG+VW
         oBPHXOKyhQaSxRNr8FhC/OCqeJXgp7quXABDTPwhy3oZX9qo/dGxr/dxFPZGnBEiSxsv
         af7/d749TL90lmkJeoi0/I73GkQOsG3WPto84NVqwo1hGa53oAcdNkOmzBd4g77Cbslj
         WxzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjhXbskZ9dU2x6l1gbRZwlXbb+HcCXuG3dG4rIvWLffuOAVXPeUu6sa+k5+7ZiZLxxWIG4WjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4UKfdUoVH5dCD28sd6/hnUDvdtavHCEXOWHThVe9L3GiyenXH
	DOZ+GOK4BA/ngLBH8yMeFipcSnhyn6AtZpv1vVBa7mWAfJ5W+6ZFZJoxGalfS+cp2qY=
X-Gm-Gg: ASbGncu3rSaTWNqgjRRQmvqDPyqcKLWgnvnxDCQWTGoUn3JtJpn03bPo+OCTr1Meksr
	KtM7p7S2Y54AWEl+CCA7RuATrizTVIBLIrdXTrl/hT4S6eRMLwHldF4HzYFEqcsGjn3UIIpo2k+
	69si6/O23bO+DceuHva8FE3Lq1he/t5jiAL+Rol8i3SOGjHCzteEJGUfp95q/03296L9CfZbLrz
	fzT2/J6VBr0CTWJ3ouHXNV/AeCexhtcUiqcWnvigZSpWAaEet3NYVUCysOo280bi6pKRX2gNrTe
	rQwGjHWwcMvs63TsFozINhKskegPaTPfKQznwK4kUY3d3gL2fUSuHekk4bW/20KkjwIZ7LJOfYs
	cKMokoYI=
X-Google-Smtp-Source: AGHT+IGZCes+k3Vgx7XWiAeA3ycb+6xDmUCazWi2pxvLOmeNDxdiC/fXDYp+kKtkRTAXwgnG+QF8Ag==
X-Received: by 2002:a17:90b:4e87:b0:311:488:f506 with SMTP id 98e67ed59e1d1-31c4f545d00mr2518810a91.6.1752283549493;
        Fri, 11 Jul 2025 18:25:49 -0700 (PDT)
Received: from t14 ([2001:5a8:4528:b100:e3b0:5676:c947:423])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de434141fsm53894615ad.168.2025.07.11.18.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 18:25:49 -0700 (PDT)
Date: Fri, 11 Jul 2025 18:25:46 -0700
From: Jordan Rife <jordan@jrife.io>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Stanislav Fomichev <stfomichev@gmail.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v5 bpf-next 10/12] selftests/bpf: Create established
 sockets in socket iterator tests
Message-ID: <4hymd6ivknwleq7fvdicod6fdnbtlf3fqwkbjadfg5dsumfhcz@7gdrkdbocywe>
References: <20250709230333.926222-1-jordan@jrife.io>
 <20250709230333.926222-11-jordan@jrife.io>
 <2c66f688-988f-4f55-a822-de5686178b1a@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c66f688-988f-4f55-a822-de5686178b1a@linux.dev>

> > +		i++;
> > +		established_socks[i] = accept_from_one(server_fds,
> > +						       server_fds_len);
> 
> I am not sure the final ack is always received by the server at this point.
> If not, the test could be flaky. Is this case possible? and is it better to
> poll/select for a fixed number of seconds?

Fair point. It definitely seems like a potential source of flakiness.
Using poll with a timeout sounds reasonable to me. I think this
eliminates the need for setting the O_NONBLOCK flag as well, which is
nice. I'll make some adjustments and send out another version.

Thanks for catching this!

Jordan

