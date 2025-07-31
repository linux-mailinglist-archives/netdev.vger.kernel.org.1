Return-Path: <netdev+bounces-211179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A8CB1706F
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 13:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606284E60A9
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 11:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEE322F164;
	Thu, 31 Jul 2025 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROCZsXON"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A642C9A
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753961878; cv=none; b=tkXVtbJKRYT7zrysMyD7avYGjYBIqiqCd5AAIyRO9mFZshgBbuhp7M0+D6LNE6sJIBqaKesdOBU9dfRloWDaq102Q5d4NeLpMUr//QqVmLL692u5/eJHGpFE7To0ijv43IuqN6a2fy/IwjBB+IckoD+ftIKfehWVcyegd2k5HJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753961878; c=relaxed/simple;
	bh=DWhH05WXap33F9lrpD9LSU71rzAi8g/fUe4rItnAGGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQisswP/kB92yOM0WbbVWQt47XKmg9kX4ch8ssQdMfVPiqj0YKmuN66VLDK/TOdNioGiKZrJaldMgdlPtsfDOvujyPwujCJhLZYLt3EV5dO15/73kPDnxo03WcYFf84D9rdhvw5tY19Od8N36HUUHEF3EVChTYyDxlZ3UxonwAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROCZsXON; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b77dece52eso64077f8f.2
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 04:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753961875; x=1754566675; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=reSXGoj441Ds4yLYqDZ0bS9CDxFLAQKOYbqGaKZ4rYM=;
        b=ROCZsXON95+gUiBFlMRZfMPVLksuwT+wQwWbnJGu6rX/3BoHEOTVAZFDiz1xk09UUt
         NRHcaKPGfgN87pg7Aoon08sKUG+sTWcxpS5R1xI4m3ABhQwYWTtEOD9vbTFGL83D0G8d
         MmQWHouOneyfP74aePP6i2xxaTOM3ONVPW9InXx36Igevb5vr1X/0rsK+D8BNGyV+y/m
         aWc9JBTbKLwupLIbdVP2yq/dQJTd3aKg6fBPITknj1nv8rcJJ7/HYTJni9bd9vjVRM28
         O4DkG8MZ/oC7O/xNXByZvZQMyXLkPmiYvpZS942/nap2xFJNrLv/3aQ6eGxudfaHBjeK
         S/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753961875; x=1754566675;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=reSXGoj441Ds4yLYqDZ0bS9CDxFLAQKOYbqGaKZ4rYM=;
        b=wfBR9PFXUPHKx+8jVKY85vrjtNo4J5fVsr1W3WLzSlkVnU2TDMfipyb6STk9MWKe1L
         EQE8QAQGmEjL6U/d5qEOPiWSVfPkqvEuOLCPjjVyAP70Y4pU2SaR4aTB/nq1g+S5Iuq3
         et0ySVegcvYUjZSoFWiU1vG33s8shcAnkXfz1EdVuKyiAjcme6SQ0vAXpaWw5hQISjqp
         SWSjA5E58H58F19dh4j5Lf3bPIh99eASb+RF83igFb9esLhYUpaduCd7TjaqHWPwM4WI
         HHdPonGJRmXEqipEgZCw2UwrbGjF1EM4Lj8bhHCI6de6M1mw59DtmZrK0ZEBcEpNBxfj
         w61g==
X-Gm-Message-State: AOJu0Yx6gnZ3g75uQCmYlw3gJg22VafN52p8ir3mlH2X8s8/NQTZXt+e
	ZdZGF9KMNgYUfAdYwLWmRbyfS9T7MHFaFszjK2xUBq0iHE6wynut/Gtk
X-Gm-Gg: ASbGncsFzR9av/n32r4JD0sZogl1ducazQVCDByNCRtXuSQkVWnNe7ObfPehOSf/haJ
	UnjS8VINxskAOEQ78ATiBoI5m61Bja7z+OOw2ns5EyF8YcUaeVsloPZY7e+LVHua/Mt0Y/S9JOw
	vjd/Cx8eRuPsvy+uzwsMWls+Ok/9y5GTQuiCyg/L96NxxSLCxLmH/Io6PXxddvmceEVQODt/zvQ
	M4eVKCotRSRfPFa2B5J8RhjTIpsrZ5lSgMarUxBO/eX8PtmDX7FVfrSBEOEiIIQ5DwDADPAoi/7
	u09OJ6NO7qNyCMivs7Tpgu6nM+8+e1Xlzz3sQA6b5iEbMH88cg7M+aO/Es5cCYkJyz9gY2mdtJO
	OJ3nFY33+ROmoiw==
X-Google-Smtp-Source: AGHT+IFoBa3vsv7CbxjIE/+YPmvFUHewPRcI+s0SoT/6QanTqk5rl2adxSnGxvjUYNVtwsiNBexL3g==
X-Received: by 2002:a05:6000:2287:b0:3a4:d4a0:1315 with SMTP id ffacd0b85a97d-3b794fe92d8mr2324480f8f.6.1753961874779;
        Thu, 31 Jul 2025 04:37:54 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d30d:7300:97a:e6c7:bad3:aa51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4a2187sm2212318f8f.70.2025.07.31.04.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 04:37:54 -0700 (PDT)
Date: Thu, 31 Jul 2025 14:37:51 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Luke Howard <lukeh@padl.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Ryan Wilkins <Ryan.Wilkins@telosalliance.com>
Subject: Re: [PATCH net] net: dsa: validate source trunk against lags_len
Message-ID: <20250731113751.7s7u4zjt6isjnlng@skbuf>
References: <DEC3889D-5C54-4648-B09F-44C7C69A1F91@padl.com>
 <20250731090753.tr3d37mg4wsumdli@skbuf>
 <42BC8652-49EC-4BB6-8077-DC77BCA2A884@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42BC8652-49EC-4BB6-8077-DC77BCA2A884@padl.com>

On Thu, Jul 31, 2025 at 07:55:06PM +1000, Luke Howard wrote:
> Hi Vladimir,
> 
> Thanks for helping me walk through my first kernel patch (I thought I would start with a one line one!).
> 
> > 1. You need to add a Fixes: tag, like the following:
> > Fixes: 5b60dadb71db ("net: dsa: tag_dsa: Support reception of packets from LAG devices")
> 
> Noted.

Further clarification: add the Fixes: tag if you target the patch to the
'net' tree (based on which it will also be backported to stable kernels)
or if the bug was introduced during this kernel development cycle and is
only in 'net-next'. A patch with a 'Fixes' tag for an old commit is
incompatible with submitting it via the 'net-next' tree.

In my previous reply I was only presenting all possibilities; it's still
not clear to me whether this patch should go through net or net-next,
because I haven't understood the circumstances that lead to it yet.

> > 2. The problem statement must not remain in the theoretical realm if you
> >   submit a patch intended as a bug fix. Normally the tagger is used to
> >   process data coming from the switch hardware, so to trigger an
> >   out-of-bounds array access would imply that the problem is elsewhere.
> >   That, or you can make it clear that the patch is to prevent a
> >   modified dsa_loop from crashing when receiving crafted packets over a
> >   regular network interface. But using dsa_loop with a modified
> >   dsa_loop_get_protocol() return value is a developer tool which
> >   involves modifying kernel sources. I would say any fix that doesn't
> >   fix any real life problem in production systems should be sent to
> >   'net-next', not to 'net'. This is in accordance with
> >   Documentation/process/stable-kernel-rules.rst.
> 
> Thanks for the clarification, I was unsure which to send to: I’ll send the revised patch to net-next instead.
> 
> Ryan (on cc) saw this crash with a Marvell switch, using some not yet submitted patches to support in-band switch management without MDIO.
> 
> Exactly what caused the switch to deliver a malformed DSA packet is unknown, but it seems reasonable to expect the kernel to be resilient to this (although one could make an argument that the trust boundary extends to the switch chip).

It does seem reasonable considering dsa_loop, but if we can first
characterize the problem to understand the impact, we should. Then,
this characterization should go into the commit message, to justify to
readers, backporters, etc, when they should worry and when they shouldn't.

If you or Ryan still have access to the buggy system, does the problem
reproduce without the in-band management patches? That is the most
important argument for targetting the 'net' tree. Could you provide an
skb_dump() of its contents? Are you even using offloaded LAG interfaces?

Another rule from Documentation/process/maintainer-netdev.rst is to wait
at least 24 hours between patch revisions.

