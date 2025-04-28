Return-Path: <netdev+bounces-186521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64851A9F81E
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B377F1796FD
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F63B27990B;
	Mon, 28 Apr 2025 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="J/J5OtI+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A226D28E61D
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863960; cv=none; b=oL7k+1E2WY+0VT9odlnL4KQmpfAbkOKEdbJnpWmf7njMHu16G4cc/2APJiJqu5BB3j/3iEseSSzAz58SmjDd6W1WyLAu+i9dtQFJExSN9m3yktjrL+GAWt4kcCZCl5Gc856eOqVcU6/VCQATmXu/f0fb3Smm73p5GxC36qzpxbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863960; c=relaxed/simple;
	bh=MTZMiUXhle3fbYXt8bSe+B6sM9PLiDIQpJa0sk6gY38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HP73v/nhBlJkbCfJy2wsKOjXkbYzBSDxesY2bMSc6pzvbhMXXG6Dve6g9QFR5Ql9tJpaUfNLOJz0Thx0z1+so2d/xlDDVzvhJULTjTHErBV8Hs227WRvzziR3g4K6n0B936sQBrRYN8SfSUupLXgA3XStXtYeCwGd682tJwtvfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=J/J5OtI+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-227914acd20so52484585ad.1
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745863958; x=1746468758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Fz+SvETZhnz+h5hxaVzeh0d0f9bz4B+YPF1upbRgOM=;
        b=J/J5OtI+YPHfeq201mDEQHU6wT5kfMEGP5QZdtAaSxlN6p+TP1+bkJ8M84qhSmeuSe
         hqa/f+cwMs1BIZgTv8ssy2ay+rKuBFbskWoIOnNwngwCYznYPJ1vxr9Z8Ab6wypiTzHs
         ONKNZiDKvIhULAwFgmfb22UgAMaExI1VfjU0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745863958; x=1746468758;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Fz+SvETZhnz+h5hxaVzeh0d0f9bz4B+YPF1upbRgOM=;
        b=UkJp6un/FeH+r3wsamQdoMRrmdqripxUXAobMiD2o3nTZDqAzLGj5eAEsjfZfCpDMn
         CEJ/LpuPu+u/hualuGUiablcnxx1z9eI19ionnoas7uZN/uHX02NCUJ67eCVbs6rEa+c
         +0X0hP/Ea4YthaUDkyBdNpQxGnZCmDnZbGU1a0M64t1GmHZtu3/oZktv92ZUoH+8AZLA
         GWpyYziV/aJ+G929rv4QYY8bGocnadC8EANmbMp1xd8U0P2y1LVYYtQpZPaKQv0abAP+
         g3l5oJsvmvg09I3DHAZBpB+OS1wJLe9hMoiXgLpOUuhe1gbAsQ7wmoG14adzl6h/qhq7
         jRcA==
X-Forwarded-Encrypted: i=1; AJvYcCWKBT9GTtex+OIf6YmqptNTZqXxVzIV1CFJUkQuevi7V0dTYfz05JwClSm7zWbTpXn25IUHUNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD/2q3bs6rarBswJtqtaBLc+TP2SZdI3Ja/XJFE6INMSDGlv99
	EdRv/PjvuWUDt9AMycTleU4en4ElhgN2V9reJtCmimrDJ28rYT/Q4DE6pzvbfhbgvZpHeuInTx2
	U
X-Gm-Gg: ASbGncvSM+xN7TuE20cdD/jqtd7BgAg5wX2eDhdi3vldTB5Qqyd4pKzbIioQbuGpgFo
	wNwsQsY/8vypbyyoFHY8C4PQJm1d22MMp1I1EKsZ6v01iEFXYwZXmQ2l3mp3nMp2V1kvt1PkgO+
	y5HcJndm+Q2fsoGSftd8LSIT52FCT7YQV2n0f8MUB8VjNfWVzg0mVOirwuh4XKTn+esRSMCf15f
	lKipPaD1EJiyemuQPTBJXCbpPosGJc6MFk6OsqB6c3gQQk0jidckS+wHM4wFaUcKRAKnj/i3iNa
	XYjJkOTOHf3dePP9V0kZEEkZDYSYjgULQ75PPDa1rdgYKTAJMnh0lCVAK0imRhBi1a1uxj+m5Yq
	oL5CpeG8=
X-Google-Smtp-Source: AGHT+IFst6pgd2ZfLIOQE9rPIxyavv71RvRzsKJYJD05ve2YRu1dG6Nh3lEoVjA4AN3SDCVZJF61Cw==
X-Received: by 2002:a17:90a:d00f:b0:2fa:603e:905c with SMTP id 98e67ed59e1d1-30a22444767mr273361a91.2.1745863957689;
        Mon, 28 Apr 2025 11:12:37 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef124cffsm10350579a91.32.2025.04.28.11.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 11:12:37 -0700 (PDT)
Date: Mon, 28 Apr 2025 11:12:34 -0700
From: Joe Damato <jdamato@fastly.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5] Add support to set napi threaded for
 individual napi
Message-ID: <aA_FErzTzz9BfDTc@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
References: <20250423201413.1564527-1-skhawaja@google.com>
 <20250425174251.59d7a45d@kernel.org>
 <aAxFmKo2cmLUmqAJ@LQ3V64L9R2>
 <680cf086aec78_193a062946c@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <680cf086aec78_193a062946c@willemb.c.googlers.com.notmuch>

On Sat, Apr 26, 2025 at 10:41:10AM -0400, Willem de Bruijn wrote:
> Joe Damato wrote:
> > On Fri, Apr 25, 2025 at 05:42:51PM -0700, Jakub Kicinski wrote:
> > > On Wed, 23 Apr 2025 20:14:13 +0000 Samiullah Khawaja wrote:
> > > > A net device has a threaded sysctl that can be used to enable threaded
> > > > napi polling on all of the NAPI contexts under that device. Allow
> > > > enabling threaded napi polling at individual napi level using netlink.
> > > > 
> > > > Extend the netlink operation `napi-set` and allow setting the threaded
> > > > attribute of a NAPI. This will enable the threaded polling on a napi
> > > > context.
> > > 
> > > I think I haven't replied to you on the config recommendation about
> > > how global vs per-object config should behave. I implemented the
> > > suggested scheme for rx-buf-len to make sure its not a crazy ask:
> > > https://lore.kernel.org/all/20250421222827.283737-1-kuba@kernel.org/
> > > and I do like it more.
> > > 
> > > Joe, Stanislav and Mina all read that series and are CCed here.
> > > What do y'all think? Should we make the threaded config work like
> > > the rx-buf-len, if user sets it on a NAPI it takes precedence
> > > over global config? Or stick to the simplistic thing of last
> > > write wins?
> > 
> > For the per-NAPI defer-hard-irqs (for example):
> >   - writing to the NIC-wide sysfs path overwrites all of the
> >     individual NAPI settings to be the global setting written
> >   - writing to an individual NAPI, though, the setting takes
> >     precedence over the global
> > 
> > So, if you wrote 100 to the global path, then 5 to a specific NAPI,
> > then 200 again to the global path, IIRC the NAPI would go through:
> >   - being set to 100 (from the global path write)
> >   - being set to 5 (for its NAPI specific write)
> >   - being set to 200 (from the final global path write)
> > 
> > The individual NAPI setting takes precedence over the global
> > setting; but the individual setting is re-written when the global
> > value is adjusted.
> > 
> > Can't tell if that's clear or if I just made it worse ;)
> 
> That does not sound like precedence to me ;)

Sounds like you are focusing on the usage of a word both out of
context and without considering the behavior of the system ;)

> I interpret precedence as a value being sticky. The NAPI would stay
> at 5 even after the global write of 200.

The individual NAPI config value is always used before the global
value is consulted. One might say it precedes the global value when
used in the networking stack.

That individual NAPI value may be rewritten by writes to the
NIC-wide path, though, which does not affect the precedence with
which the values are consulted by the code.

> > Anyway: I have a preference for consistency
> 
> +1
> 
> I don't think either solution is vastly better than the other, as
> long as it is the path of least surprise. Different behavior for
> different options breaks that rule.

I agree and my feedback on the previous revision was that all NAPI
config settings should work similarly. Whether that's what I already
implemented for defer-hard-irq/gro-flush-timeout or something else I
don't really have a strong preference.

Implementing something other than what already exists for
defer-hard-irq/gro-flush-timeout, though, would probably mean you'll
need to update how both of those work, for consistency.

