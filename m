Return-Path: <netdev+bounces-99552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 327378D5420
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 23:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63EE01C249F3
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 21:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6F341760;
	Thu, 30 May 2024 21:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvjMqrUO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EE71C6A7
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 21:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103022; cv=none; b=koGt7Pqk31rENLTmNzBsIYwmC56htRl2qARTYxu6F3l5CdlLGuNH3pZoxyrAFUU5Jv8iLuEbn8LbNHRzNNYfJc2cP0rSVWV8b0SZCLfHLuwTpIbQA1ytXMRaL402geLfxTa9eIT/Lb7ZD0I+ul2PU1FoTq63viWr9tt+ac0KgoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103022; c=relaxed/simple;
	bh=aakk222XJJn0yOjFGKUtlApLFqtFrBAsIA+lA8IL0Gw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iJ3xerkw+4z8GsxMBMI2avb60iNGLqgF4tFWsUPvZvKjBlRL7iq/JVADrsnOtpBBZhyF43LZ0tPvWnQ5Rfzym9bAFTUS9IhCD1Vtl9+aYu5wX3KrxFMD8TjygS7fbnRNF2UV7bIv6+UyxtmAZdYH+griQVthM1GA6JeWAE9rdJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvjMqrUO; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b9778bb7c8so691651eaf.3
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 14:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717103020; x=1717707820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ef1eOM3G06hR82CS/dyU95w12NVRCZp9a9wtTh50Gc0=;
        b=FvjMqrUOnhPIAERofMHAw7tx1tuylWF3n/spkTYkksAikRKsSYjgvVCcnv7vdSDQxR
         2MZ4lVKNYRURzWBxTT7oWoR39yLCEETB6pEHZBzk+vUCX6WC24nplhM+Wea5gydUA6u5
         VmJTFPNsSdxgMvtB8fLFA3Oq5L1K2tDXtCW3VoqH0Q3yc4jJF3Qe/KQeh2M/tE3ZgCGJ
         BszpuM2hAcXVdEjtomsy132yLhpS5GBE8x8wTcU+mECD07YZ5OM0uwoIFbHFeM+jPQkQ
         IGt5LWdQYdc2LZOg2QA4sVkVDv/GEmud1Dz9hNMQyesUpSlXoe4mSzUlKzuCyikKFCmj
         AsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717103020; x=1717707820;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ef1eOM3G06hR82CS/dyU95w12NVRCZp9a9wtTh50Gc0=;
        b=f+eYjELUwe/nm22UFLNH31Va/junHjOcj5LOeSkFKzTdi+hZG4cEOJFJ8rKp0OxJ2s
         WspWNgx/aSN1+DhTCVQh6I1FPKCUZwXKx7TEcUF52ru4KR9s8o7LkLpC3EY18eUwoY44
         3AILUpcjL2NAPa3VSB6+XMr3xCGm6LKScvhToNGb+NLw3MaiicEg/p6IV5RKruGzaEep
         7STkKg6l8Gzi+vIBuQ0n1Ca1Hpjj59IEvtK7nkgkm37DhC6hbdA53V3HtN7wgSJtgvrb
         5l/agrkJEQx3OLE/uPMvm73qkoFCL1zKbwTdStH80XtI9p08zttfTmcq/Uc60i3gFH3q
         JvcA==
X-Gm-Message-State: AOJu0YzR3rA1dSUadeslkiTTRSxPR02ujV/TTXymoPWFZhlMZpe3DKrU
	uVmTodqep/2vzo1ueFLMo501tiz7oc+tQXMeJfg6Ix/5xiIUEh40
X-Google-Smtp-Source: AGHT+IH/lygpR5KO5hLxfrnDkYQ9hORqU5hXFyihjccbVxx+WJMKkM0b0tS5GgJUfd1+FPZU9dU2Nw==
X-Received: by 2002:a05:6359:4c9f:b0:199:2817:ab44 with SMTP id e5c5f4694b2df-19b48c31dabmr17663655d.9.1717103020049;
        Thu, 30 May 2024 14:03:40 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4b417ccesm1641256d6.122.2024.05.30.14.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 14:03:39 -0700 (PDT)
Date: Thu, 30 May 2024 17:03:39 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 borisp@nvidia.com, 
 gal@nvidia.com, 
 cratiu@nvidia.com, 
 rrameshbabu@nvidia.com, 
 steffen.klassert@secunet.com, 
 tariqt@nvidia.com
Message-ID: <6658e9ab567a4_3dd14c2943f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240530131510.21243c94@kernel.org>
References: <20240510030435.120935-1-kuba@kernel.org>
 <20240510030435.120935-2-kuba@kernel.org>
 <66416bc7b2d10_1d6c6729475@willemb.c.googlers.com.notmuch>
 <20240529103505.601872ea@kernel.org>
 <6657cc86ddf97_37107c29438@willemb.c.googlers.com.notmuch>
 <20240530125120.24dd7f98@kernel.org>
 <20240530131510.21243c94@kernel.org>
Subject: Re: [RFC net-next 01/15] psp: add documentation
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
> On Thu, 30 May 2024 12:51:20 -0700 Jakub Kicinski wrote:
> > > I've mostly been concerned about the below edge cases.
> > > 
> > > If both peers are in TCP_ESTABLISHED for the during of the upgrade,
> > > and data is aligned on message boundary, things are straightforward.
> > > 
> > > The retransmit logic is clear, as this is controlled by skb->decrypted
> > > on the individual skbs on the retransmit queue.
> > > 
> > > That also solves another edge case: skb geometry changes on retransmit
> > > (due to different MSS or segs, using tcp_fragment, tso_fragment,
> > > tcp_retrans_try_collapse, ..) maintain skb->decrypted. It's not
> > > possible that skb is accidentally created that combines plaintext and
> > > ciphertext content.
> > > 
> > > Although.. does this require adding that skb->decrypted check to
> > > tcp_skb_can_collapse?  
> > 
> > Good catch. The TLS checks predate tcp_skb_can_collapse() (and MPTCP).
> > We've grown the check in tcp_shift_skb_data() and the logic
> > in tcp_grow_skb(), both missing the decrypted check.
> > 
> > I'll send some fixes, these are existing bugs :(
> 
> I take that back, we can depend on EOR like TLS does.

Oh yes. Neat solution.

This relies on userspace doing the right thing by passing MSG_EOR
right? That is easy to get wrong. Should we still add a check or
a WARN_ONCE. That would be net-next material.

