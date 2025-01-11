Return-Path: <netdev+bounces-157336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3B6A0A00C
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 02:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 509AD7A2E13
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 01:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8E82E403;
	Sat, 11 Jan 2025 01:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0WWIKrO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB49828370
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 01:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736558737; cv=none; b=pAOdKE/sfEa4VnvuEAeqUPxHzrWPDJ3F+nbRFkb1RT1BN7eExT/zvxMLBQxVnMcUvoVgOeHvDDmtsxps1QNgg128Ql/LzruMtQViyS96eOq4BAhjec5kumy1hmETpCXi1uhsRXPpx8jkt6xcU5ormnI65qPr2lC2OJ/VzQDJe6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736558737; c=relaxed/simple;
	bh=lzbrKQhZYNhaqsce52Nn4TtWDkUtjybvDXHuvA2JmC0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtK5ab0mUWNZN+dDI+lx+HlZcC7ekg/W2CtG+dkkMwLM+Q5TNdnzrR+zNYeSC73vTfV8yZxEdnPHjZmnyZA3WQt4eTVmAC1amkqRh0ZOFq/8bBEb6Xydy/HOILorvQUfVCU/bGDnYMpyEISuyRA9bX4GqwOm2+ncr7Qv068c0qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0WWIKrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B154C4CEE0;
	Sat, 11 Jan 2025 01:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736558737;
	bh=lzbrKQhZYNhaqsce52Nn4TtWDkUtjybvDXHuvA2JmC0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I0WWIKrOgyUwc5ZrqExjY3TQZUvRVmjEsUCvWlfrI7eucQjSbnpSiNo/2zvdzQjDm
	 yUBdnsr/l0c79L64z7EJaiMoUrNilEuc8dCyJnfLV2zgkqlBUHwhtRAgvKy7Gs2U/J
	 ijP9J9AswhVqlwCObgGpHFEbiVatLBsBxIkf3rpASHaL6BGY31on/8SZZHJQXz6huE
	 7171FGCKjTW+ee5FpfYKiZ2KIG8dgr5XLGFiFRzBDGyeTr7/oBTtskGJR9funEO7uR
	 FzAnFccFxc752xodRNgSF0QBtHi7R/pQ0NkHhbCUucvWzMBkvm7rNolJ/Aq3jCT1Ne
	 OIh0o0R7/XpFA==
Date: Fri, 10 Jan 2025 17:25:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
 <netdev@vger.kernel.org>, <anton.nadezhdin@intel.com>,
 <przemyslaw.kitszel@intel.com>, <milena.olech@intel.com>,
 <arkadiusz.kubalewski@intel.com>, <richardcochran@gmail.com>, Karol
 Kolacinski <karol.kolacinski@intel.com>, Rinitha S <sx.rinitha@intel.com>
Subject: Re: [PATCH net-next 08/13] ice: use rd32_poll_timeout_atomic in
 ice_read_phy_tstamp_ll_e810
Message-ID: <20250110172536.7165c528@kernel.org>
In-Reply-To: <55655440-71b4-49e0-9fc8-d8b1b4f77ab4@intel.com>
References: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
	<20250108221753.2055987-9-anthony.l.nguyen@intel.com>
	<20250109182148.398f1cf1@kernel.org>
	<55655440-71b4-49e0-9fc8-d8b1b4f77ab4@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 16:50:44 -0800 Jacob Keller wrote:
> On 1/9/2025 6:21 PM, Jakub Kicinski wrote:
> > On Wed,  8 Jan 2025 14:17:45 -0800 Tony Nguyen wrote:  
> >> --- a/drivers/net/ethernet/intel/ice/ice_osdep.h
> >> +++ b/drivers/net/ethernet/intel/ice/ice_osdep.h
> >> @@ -26,6 +26,9 @@
> >>  
> >>  #define rd32_poll_timeout(a, addr, val, cond, delay_us, timeout_us) \
> >>  	read_poll_timeout(rd32, val, cond, delay_us, timeout_us, false, a, addr)
> >> +#define rd32_poll_timeout_atomic(a, addr, val, cond, delay_us, timeout_us) \
> >> +	read_poll_timeout_atomic(rd32, val, cond, delay_us, timeout_us, false, \
> >> +				 a, addr)  
> > 
> > Could you deprecate the use of the osdep header? At the very least don't
> > add new stuff here. Back in the day "no OS abstraction layers" was 
> > a pretty hard and fast rule. I don't hear it as much these days, but 
> > I think it's still valid since this just obfuscates the code for all
> > readers outside your team.  
> 
> I assume you are referring to the abstractions in general (rd32,
> rd32_poll_timeout, etc) and not simply the name of the header (osdep.h)?

I presume the two are causally interlinked.

> I do agree that the layering with the intent to create an OS abstraction
> is not preferred and that its been pushed back against for years. We
> have been working to move away from OS abstractions, including several
> refactors to the ice driver. Use of "rd32_poll_timeout" is in fact one
> of these refactors: there's no reason to re-implement read polling when
> its provided by the kernel.
> 
> However, I also think there is some value in shorthands for commonly
> used idioms like "readl(hw->hw_addr + reg_offset)" which make the intent
> more legible at least to me.
> 
> These rd32_* implementations are built in line with the readl* variants
> in <linux/iopoll.h>
> 
> I suppose it is more frustrating for someone on the opposite side who
> must content with each drivers variation of a register access macro. We
> could rip the rd32-etc out entirely and replace them with readl and
> friends directly... But that again feels like a lot of churn.

Right, too late for that.

> My goal with these macros was to make it easier for ice developers to
> use the read_poll_timeout bits within the existing framework, with an
> attempt to minimize the thrash to existing code.
> 
> Glancing through driver/net/ethernet, it appears many drivers to use a
> straight readl, while others use a rapper like sbus_readl, gem_readl,
> Intel's rd32, etc.

Ack, and short hands make sense. But both rd32_poll_timeout_atomic and
the exiting rd32_poll_timeout have a single user.

