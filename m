Return-Path: <netdev+bounces-131992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D2599018A
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 12:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8251F21EE4
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4842013AA35;
	Fri,  4 Oct 2024 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGPiIn2U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D62C179BB;
	Fri,  4 Oct 2024 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728038776; cv=none; b=Gz1tTm2JCoGtvJFxezZMvCXVF3nZ5Lbvr5tmwRrbYuWLSx3hEKY8BEJhpATBTTj9tgqyX2Yzbi92Q/KHwtg8riciydZiZRYY8mrlY30jalarZQwvG+x3BIUGLDYKSPXVLaAFZbTnqygBy9mUOzT9CEVi6cn9HQQmURIDZYJex/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728038776; c=relaxed/simple;
	bh=B8ZfT9sDJWNA2ZZ/GjSMk3QDZWUnW9h5HxHc1sUE5Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaIoQWoBAmmeNHpiGQzKLvDbfmOhRjJOGN/xhOg/1+vpzwJlJQI1Hoj25Dt2MuVuReVsYglgAE+B9MlMH0gPqenFEegMAcW295Zd9REF2I5FWa30CN7EGrf8SRx8cQzR3D2XF03a1IVSO7RSVYnwgGBGc6h8Xqll1aBzaOWBjxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGPiIn2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF27C4CEC6;
	Fri,  4 Oct 2024 10:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728038775;
	bh=B8ZfT9sDJWNA2ZZ/GjSMk3QDZWUnW9h5HxHc1sUE5Io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jGPiIn2UFQvTCg0slQtAATcMv+919vOElr0Rv/jVtg/0wKz8bH4204JEOMsanC8d1
	 FIujERpd+huQqfUlCfxmKN7qdmR/Ta7y6zxyeuXku7UaOdA75Ex2XRABocrVv/A1/G
	 LiCZ4qEYQrn14YXrPdtIDSjmBLQM8LJdAmTMY6NIrh5PNJMOVNYYA/qOV8SFd3F0G9
	 KKXiwybcqo5KlenddfLe9drdVFRmP3Iay7TyPbgMdEJnhEBgIK9dMsNRd9UQiHFaU6
	 QhKP1ckugsiRZau26IdctAq4VpDLPw3gtzBC3k+zpOUCxgk4KZ+ton+ePkzpqyMgXb
	 NjY+wNrYBkZdw==
Date: Fri, 4 Oct 2024 11:46:10 +0100
From: Simon Horman <horms@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Jakub Kicinski <kuba@kernel.org>, robh@kernel.org,
	jan.kiszka@siemens.com, dan.carpenter@linaro.org,
	diogo.ivo@siemens.com, andrew@lunn.ch, pabeni@redhat.com,
	edumazet@google.com, davem@davemloft.net,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix race condition for VLAN
 table access
Message-ID: <20241004104610.GD1310185@kernel.org>
References: <20241003105940.533921-1-danishanwar@ti.com>
 <20241003174142.384e51ad@kernel.org>
 <4f1f0d20-6411-49c8-9891-f7843a504e9c@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f1f0d20-6411-49c8-9891-f7843a504e9c@ti.com>

On Fri, Oct 04, 2024 at 10:25:05AM +0530, MD Danish Anwar wrote:
> 
> 
> On 04/10/24 6:11 am, Jakub Kicinski wrote:
> > On Thu, 3 Oct 2024 16:29:40 +0530 MD Danish Anwar wrote:
> >> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> >> index bba6da2e6bd8..9a33e9ed2976 100644
> >> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> >> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> >> @@ -296,6 +296,7 @@ struct prueth {
> >>  	bool is_switchmode_supported;
> >>  	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
> >>  	int default_vlan;
> >> +	spinlock_t vtbl_lock; /* Lock for vtbl in shared memory */
> > 
> > This needs to be kdoc, otherwise:
> > 
> > drivers/net/ethernet/ti/icssg/icssg_prueth.h:301: warning: Function parameter or struct member 'vtbl_lock' not described in 'prueth'
> 
> Hi Jakub,
> 
> Removing the documentation from here and keeping it in kdoc results in
> below checkpatch,
> 
> CHECK: spinlock_t definition without comment
> #69: FILE: drivers/net/ethernet/ti/icssg/icssg_prueth.h:300:
> +	spinlock_t vtbl_lock;
> 
> 
> What should be done here? Should I,
> 
> 1. Move the documentation to kdoc - This is will result in checkpatch
> 2. Keep the documentation in kdoc as well as inline - This will result
> in no warnings but duplicate documentation which I don't think is good.
> 
> I was not sure which one takes more precedence check patch or kdoc, thus
> put it inline thinking fixing checkpatch might have more weightage.
> 
> Let me know what should be done here.

FWIIW, my preference would be for option 2.

I think it is important that Kernel doc is accurate, as it can end
up incorporated in documentation. And moreover, what is the point
if it is missing bits?

I feel less strongly about the checkpatch bit, but it does seem
to be worthwhile following that practice too.

Maybe you can avoid duplication by making the two location document
different aspects of the field. Or maybe that is silly 🤷

