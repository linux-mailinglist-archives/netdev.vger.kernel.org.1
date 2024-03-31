Return-Path: <netdev+bounces-83685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5FC893563
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 20:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F12284D50
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 18:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D576145B2A;
	Sun, 31 Mar 2024 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HL8hyC0W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B97145B1C
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711909671; cv=none; b=Z+ATVazlv8gReqQ3O6V2ljDwH9AwVO05JzOoWEYe76AlvZy2Dvc5E+QAZssbgNIOub50nPfV9fSjVAy7yOoRqcrSX1lquGGJjvayiDKCjoadoYpAj9y7IWLTAYGwSCyqTF91RvHfiCcewZZlSRj8+9qy5LNxurFJZVYUkXR4xTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711909671; c=relaxed/simple;
	bh=mqV57eRZ6VoXvr3aBmrVYg1f738OdoqmYDtIlFCSrY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTmGg7vz1j6jPGJvp1Fk+a8jmDNKo6m65XaMdmhS0Tr14JJ+cdXphSxeXNVkosChZrpwVNmYf4HeWHJLJF1+d5qFOAddF+zOpPMG/VvTCmrhGuzlp50gS+kVxLx+TeN7CbBVCYTjr1lyvf/8RBHXaTZqrupIkkky4YkxSBl0OsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HL8hyC0W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF88C433C7;
	Sun, 31 Mar 2024 18:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711909671;
	bh=mqV57eRZ6VoXvr3aBmrVYg1f738OdoqmYDtIlFCSrY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HL8hyC0WsH91RQqowJxxTGHU1PH70duMJZ96hHGu8QSp7WQbKC6XNFX4o9/PWJt8n
	 pxRmcI7c9hKqMLSja7rizQVs48arwZvX3x7xBq5TmfwAbBiMkj654x47C0CBHS6BEV
	 K1jVqR+FZKOp7Rb4lO4KS72T9swsVW274A4O1GM91c+Ac5F8VeW38+eUT1BmqEm0Li
	 3VMR2TkFjHgp+v+03tEj5fNC4+Ox+w2XDnDq2wGGEs2DZ8sUdvcW+EdSm7xStjjg8x
	 i6wT9or1a3BAT0bNEzvuOXBu5TSD3IKnPR/taVevfRKXui6Ix57VZWKH08YiIl6yXl
	 i1a4R2aZbv+7Q==
Date: Sun, 31 Mar 2024 19:27:47 +0100
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org,
	pawel.chmielewski@intel.com, anthony.l.nguyen@intel.com,
	Liang-Min Wang <liang-min.wang@intel.com>,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] ice: Reset VF on Tx MDD
 event
Message-ID: <20240331182747.GC26556@kernel.org>
References: <20240326164455.735739-1-marcin.szycik@linux.intel.com>
 <20240328173450.GH651713@kernel.org>
 <fbf9dae9-c023-4b15-b3d8-6b19240f59b0@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbf9dae9-c023-4b15-b3d8-6b19240f59b0@linux.intel.com>

On Fri, Mar 29, 2024 at 12:31:58PM +0100, Marcin Szycik wrote:
> 
> 
> On 28.03.2024 18:34, Simon Horman wrote:
> > On Tue, Mar 26, 2024 at 05:44:55PM +0100, Marcin Szycik wrote:
> >> In cases when VF sends malformed packets that are classified as malicious,
> >> sometimes it causes Tx queue to freeze. This frozen queue can be stuck
> >> for several minutes being unusable. This behavior can be reproduced with
> >> a faulty userspace app running on VF.
> >>
> >> When Malicious Driver Detection event occurs and the mdd-auto-reset-vf
> >> private flag is set, perform a graceful VF reset to quickly bring VF back
> >> to operational state. Add a log message to notify about the cause of
> >> the reset. Add a helper for this to be reused for both TX and RX events.
> >>
> >> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> >> Co-developed-by: Liang-Min Wang <liang-min.wang@intel.com>
> >> Signed-off-by: Liang-Min Wang <liang-min.wang@intel.com>
> >> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> > 
> > Hi Marcin,
> > 
> > If I read this correctly then a reset may be performed for several
> > different conditions - values of different registers - for a VF
> > as checked in a for loop.
> > 
> > I am wondering if multiple resets could occur for the same VF within
> > an iteration of the for loop - because more than one of the conditions is
> > met. And, if so, is this ok?
> 
> Hi Simon,
> 
> Good point. Nothing too bad should happen, as ice_reset_vf() acquires mutex lock
> (in fact two locks), so several resets would just happen in sequence. However,
> it doesn't make much sense to reset VF multiple times, so maybe instead of issuing
> reset on each condition, I'll set some flag, and after checking all registers I'll
> trigger reset if that flag is set. What do you think?

Thanks Marcin,

FWIIW, that sounds like a good approach to me.

-- 
pw-bot: changes-requested

