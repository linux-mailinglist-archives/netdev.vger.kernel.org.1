Return-Path: <netdev+bounces-118541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8AB951EF6
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 17:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE7F1F23CEB
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 15:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B291AE86B;
	Wed, 14 Aug 2024 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Fd6F1YzY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102361B5812
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650399; cv=none; b=Orxi8l5adJ2U03Ubrlt3CsOdisETENlicXXPIG8+fX8lFA4rivJTyAE0rYHMOfrBtcFsdYkB86j11VMsc4fpcld9EaYn1xLRNDB4thkWwc1P1iuS3rV+FOrSwLpFTizSftFhkUe0c4IER2KMYogFONISHMmX+XPIU9VUiMGp63Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650399; c=relaxed/simple;
	bh=3CZ+eZQLTvRe5s8+CdkE8KJ8fPl1lbuinuD2iVYUImE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6MeU30mC/QSmPAKeCvQdxxo+GtiVadmUM/+DrgVJ18HrKouOY3GHFmxq443OP358pCZRHlgGns/bbwI9PuRE2PvOgB4H/mXKVM0j4FK3eV5hGwb+G6mmFPHgt616Xz95ojsGs7EenxyJinoRpNihGXZjXCHLo7D3Ed0oQvkbSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Fd6F1YzY; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f025b94e07so523961fa.0
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723650396; x=1724255196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMvW5XN814MmHmeNdCsuQ+x/zBS9ZcHLiBHoPUEkIYk=;
        b=Fd6F1YzY7RgsiEhc4a1ml1Rr2waWCADgGhCnIqbCpF5cO93cBaPpzW4nrkxK7Rllqi
         m8iGbN9oxduu8REIlhm0oXvKqdTq6nRqp7FpN6smp/XWu8uHZEhYx0eiJ0yG1Mt942U4
         KiyqDwt6Zpqun9b6SPRd05oiHq/lDbNunTeTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723650396; x=1724255196;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMvW5XN814MmHmeNdCsuQ+x/zBS9ZcHLiBHoPUEkIYk=;
        b=Ytdl/znU6mtxeJB3ZR57Ekd8uJsMwF45EymJJ6+HnFDIeV+LCspb+wE13qxiUa3YxS
         yz0KYvWhN/3yrDuCpD/4eHMmVz2l3uFI6kRmYGMDoPL3cx6tot0mW9Qd32rMifVDwstr
         oYKIKVjVHZkC6IsLM2+5x8A1pLpvtx/ehD3gy1P7b7ARhv5K+Ap5ERInxJJHq8MxJvNa
         EwEOJGeQ5fkJJ5uAfT/nhcWy2bdrEVRmwBflMOmhXDdhanjEHDq9Za4elUwQ9PRCfpFt
         Mk+xvboSu9Stmf5NQyGeeU3VOu+DytyZblqfNwzavNiiAApFKdq/vOayittrjiV4QF9r
         uOvA==
X-Forwarded-Encrypted: i=1; AJvYcCXvJtZc5gTA8S+7zAEpjhqTkeWttm0UcbAc13VbDDyTt9WOdapCgOyF+vE/5FT1TCFEZXNctUv42eD6sgW/I1sGYYr7ONrc
X-Gm-Message-State: AOJu0Yy9ZhnneRNjIrhlaHsjD5j+lBX5nqSvH1Q0l5v/5BBDKGt5o4yR
	aCzBMQXLBeUx3UFLjLzJ4IgE3nQC0GvxFfVbQrQky/CO18YQNECYG4RszUdap0s=
X-Google-Smtp-Source: AGHT+IFAW+r4bsXhzgqn4nSPYnHoVTMgVTn+Fc+6nuodprTLSx0anVrp0sa8TsMaaN15SPWkigXMXg==
X-Received: by 2002:a05:651c:b2c:b0:2f3:a854:78f6 with SMTP id 38308e7fff4ca-2f3aa1de7c6mr25666671fa.34.1723650396054;
        Wed, 14 Aug 2024 08:46:36 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429df78a7c6sm18550645e9.45.2024.08.14.08.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:46:35 -0700 (PDT)
Date: Wed, 14 Aug 2024 16:46:33 +0100
From: Joe Damato <jdamato@fastly.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin Karsten <mkarsten@uwaterloo.ca>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC net-next 0/5] Suspend IRQs during preferred busy poll
Message-ID: <ZrzRWU_39wpePVvg@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <2bb121dd-3dcd-4142-ab87-02ccf4afd469@uwaterloo.ca>
 <ZrqU3kYgL4-OI-qj@mini-arch>
 <d53e8aa6-a5eb-41f4-9a4c-70d04a5ca748@uwaterloo.ca>
 <Zrq8zCy1-mfArXka@mini-arch>
 <5e52b556-fe49-4fe0-8bd3-543b3afd89fa@uwaterloo.ca>
 <Zrrb8xkdIbhS7F58@mini-arch>
 <6f40b6df-4452-48f6-b552-0eceaa1f0bbc@uwaterloo.ca>
 <66bc21772c6bd_985bf294b0@willemb.c.googlers.com.notmuch>
 <Zry9AO5Im6rjW0jm@LQ3V64L9R2.home>
 <66bcc87d605_b1f942948@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66bcc87d605_b1f942948@willemb.c.googlers.com.notmuch>

On Wed, Aug 14, 2024 at 11:08:45AM -0400, Willem de Bruijn wrote:
> Joe Damato wrote:

[...]

> > On Tue, Aug 13, 2024 at 11:16:07PM -0400, Willem de Bruijn wrote:
> > Using less CPU to get comparable performance is strictly better, even if a
> > system can theoretically support the increased CPU/power/cooling load.
> 
> If it is always a strict win yes. But falling back onto interrupts
> with standard moderation will not match busy polling in all cases.
> 
> Different solutions for different workloads. No need to stack rank
> them. My request is just to be explicit which design point this
> chooses, and that the other design point (continuous busy polling) is
> already addressed in Linux kernel busypolling.

Sure, sounds good; we can fix that in the cover letter.

Thanks for taking a look.

