Return-Path: <netdev+bounces-240928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FA7C7C1EC
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 02:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB39A35F5F1
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 01:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D21F2135AD;
	Sat, 22 Nov 2025 01:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPgu8nPR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733423A1B5;
	Sat, 22 Nov 2025 01:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763776557; cv=none; b=cH0j9xB7QEGHrPFt04iEpCg2ufg7orvBmfRP8prCiaDqyj7gWBhgyZh7f9Dtq878PsKopW/KCQOPKD5JmSF9DrJrZf3fupBQbvzmr70v6ZFwX/jGzNLaO3Uv23NA0LWJxqW2dz5Z22MUg8J8xfWGQvoj3mrmhYlaqKP0sKQjCYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763776557; c=relaxed/simple;
	bh=PdHFwgfBrSp7W4J11DZPHxYZQV/N11nae/5XIfCwoeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hi3J1+jKDG9aBHSF9tkn7vxT+VtSY1d9wm3r4VRpmWxfrliNv/FpLNfsbTxRmZlxyDMOtZ8sEnWp4Bt15GL7Tgv6jFjGkzOztiwlTmmu95dWQLCbhTEa08JI9+9CqvtiyAYt1lPYVZZnXeRnA5G48+E4f5kCJcw4T2xZeO6V3Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPgu8nPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F017FC4CEF1;
	Sat, 22 Nov 2025 01:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763776557;
	bh=PdHFwgfBrSp7W4J11DZPHxYZQV/N11nae/5XIfCwoeQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gPgu8nPRH9VcOmVtjXaAq4N9k/KBdcnvUZI+AJhlqNkTQdMbnwlWvyNqyH7SBsXGX
	 iSRYbnTmsyJ10PJaCeSAV4Ee+EFU9QEauE6IF5TroiZ0iAgkLpTK34sHRvBi+58pK2
	 jDyjqT+/mR3L2ivVOphRDj5s7v64Jiygz2CgOegOJ1pG0YKvPHWvGfy2HseXeU4NW5
	 zc+o403dWTCpBifLU8EC+VofisaacJWdUr048Mph/MSCl01pjYguWtzI9klSihWPOy
	 Yu+HAK43YvoToPmpsCl1/kjHt3kynCSH4x+Og32wiuPzXK9Doh+Daq5Wuu0RKdNzjw
	 IIUnP8cuTfTTQ==
Date: Fri, 21 Nov 2025 17:55:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, will@willsroot.io, jschung2@proton.me,
 savy@syst3mfailure.io
Subject: Re: [Bug 220774] New: netem is broken in 6.18
Message-ID: <20251121175556.26843d75@kernel.org>
In-Reply-To: <20251121161322.1eb61823@phoenix.local>
References: <20251110123807.07ff5d89@phoenix>
	<aR/qwlyEWm/pFAfM@pop-os.localdomain>
	<CAM0EoMkPdyqEMa0f4msEveGJxxd9oYaV4f3NatVXR9Fb=iCTcw@mail.gmail.com>
	<aSDdYoK7Vhw9ONzN@pop-os.localdomain>
	<20251121161322.1eb61823@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Nov 2025 16:13:22 -0800 Stephen Hemminger wrote:
> On Fri, 21 Nov 2025 13:45:06 -0800
> Cong Wang <xiyou.wangcong@gmail.com> wrote:
> 
> > On Fri, Nov 21, 2025 at 07:52:37AM -0500, Jamal Hadi Salim wrote:
> >    
> > > jschung2@proton.me: Can you please provide more details about what you
> > > are trying to do so we can see if a different approach can be
> > > prescribed?
> > >     
> > 
> > An alternative approach is to use eBPF qdisc to replace netem, but:
> > 1) I am not sure if we could duplicate and re-inject a packet in eBPF Qdisc
> > 2) I doubt everyone wants to write eBPF code when they already have a
> > working cmdline.
> > 
> > BTW, Jamal, if your plan is to solve them one by one, even if it could work,
> > it wouldn't scale. There are still many users don't get hit by this
> > regression yet (not until hitting LTS or major distro).
> 
> The bug still needs to be fixed.
> eBPF would still have the same kind of issues.

I guess we forgot about mq.. IIRC mq doesn't come into play in
duplication, we should be able to just adjust the check to allow 
the mq+netem hierarchy?

