Return-Path: <netdev+bounces-110140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FA792B165
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 09:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727D81C20DE6
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 07:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4A8143752;
	Tue,  9 Jul 2024 07:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSVLd1Zf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A26313BC30
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 07:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510954; cv=none; b=sJ8n4USHCQ2JyYwHGbU8B5sDgEthyQiLDlSoHLccPe8N/zaunv5AWzyJQIjSFD7oUKHDhgSlgBmZBXtmBn9vNVRYYqy2fs9U//Rldzhanrx9bQFNeJDAAU4iqbWPbO3HTlPUGcZ0XbynVCK3n26cpJ57Dfcil+kCniRZHyB4S3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510954; c=relaxed/simple;
	bh=GBeiqwlDsV0o6ErL7k4rlnz6KPezop0q6y37fiUHMvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsWsgs8JDzBeXwaHArjrSzV1A0Dzdi0kh5vkJPwH2a5h7MS1bC8TJBX+/rA/eGw/jhijrBaQ0WnjEmlNfPbvbjHUoG0J/bCVGGMYuVEosdl21m9Y+JtxJ81N/7EeObpxMvOeJaWACmCLnKRYQpuK30QQ9vm6sK9kkixWVrNSxoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSVLd1Zf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917D6C3277B;
	Tue,  9 Jul 2024 07:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720510953;
	bh=GBeiqwlDsV0o6ErL7k4rlnz6KPezop0q6y37fiUHMvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSVLd1Zf6Tw2tO56UV/zCO9rhYfXQs/UUHdj5anLA8C2OvR/mtn4QZCRbB2V5TWVl
	 n2/mXtgxY5fy6ssu05acW4dZgOFG8cMnjI5xUnymS+a4khfz+vwxKaqOKp9tmc6Y0J
	 vctxqnxPtCOVTCMzk1UQic5QRnbocea7WRG7lSPj4KhGBU9mOy3LuZ+dBr/6AsMsk4
	 8SeG8D+FlQyXu/B14Z1jDnh2MP/VqyAXVlKnJmoD3P2TfIXsxf62nHFhBHRPTzepQv
	 ymPR6ger9Nah84bmO+9nzo+T1lRJq+u4bz54e8g26PCjzSWrYXnNgWIl2jW/ty7iuy
	 8M8fIACPQ4ZBw==
Date: Tue, 9 Jul 2024 08:42:30 +0100
From: Simon Horman <horms@kernel.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kang, Kelvin" <kelvin.kang@intel.com>,
	"Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v5] i40e: fix: remove needless
 retries of NVM update
Message-ID: <20240709074230.GC346094@kernel.org>
References: <20240625184953.621684-1-aleksandr.loktionov@intel.com>
 <20240627173351.GH3104@kernel.org>
 <SJ0PR11MB5866CE95533821CC0D31282CE5DA2@SJ0PR11MB5866.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB5866CE95533821CC0D31282CE5DA2@SJ0PR11MB5866.namprd11.prod.outlook.com>

On Mon, Jul 08, 2024 at 03:38:11PM +0000, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Simon Horman
> > Sent: Thursday, June 27, 2024 7:34 PM
> > To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> > Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kang, Kelvin
> > <kelvin.kang@intel.com>; Kubalewski, Arkadiusz
> > <arkadiusz.kubalewski@intel.com>; intel-wired-lan@lists.osuosl.org;
> > netdev@vger.kernel.org
> > Subject: Re: [Intel-wired-lan] [PATCH iwl-net v5] i40e: fix: remove
> > needless retries of NVM update
> > 
> > On Tue, Jun 25, 2024 at 08:49:53PM +0200, Aleksandr Loktionov wrote:
> > > Remove wrong EIO to EGAIN conversion and pass all errors as is.
> > >
> > > After commit 230f3d53a547 ("i40e: remove i40e_status"), which should
> > > only replace F/W specific error codes with Linux kernel generic, all
> > > EIO errors suddenly started to be converted into EAGAIN which leads
> > > nvmupdate to retry until it timeouts and sometimes fails after more
> > > than 20 minutes in the middle of NVM update, so NVM becomes
> > corrupted.
> > >
> > > The bug affects users only at the time when they try to update NVM,
> > > and only F/W versions that generate errors while nvmupdate. For
> > > example, X710DA2 with 0x8000ECB7 F/W is affected, but there are
> > probably more...
> > >
> > > Command for reproduction is just NVM update:
> > >  ./nvmupdate64
> > >
> > > In the log instead of:
> > >  i40e_nvmupd_exec_aq err I40E_ERR_ADMIN_QUEUE_ERROR aq_err
> > > I40E_AQ_RC_ENOMEM)
> > > appears:
> > >  i40e_nvmupd_exec_aq err -EIO aq_err I40E_AQ_RC_ENOMEM
> > >  i40e: eeprom check failed (-5), Tx/Rx traffic disabled
> > >
> > > The problematic code did silently convert EIO into EAGAIN which
> > forced
> > > nvmupdate to ignore EAGAIN error and retry the same operation until
> > timeout.
> > > That's why NVM update takes 20+ minutes to finish with the fail in
> > the end.
> > >
> > > Fixes: 230f3d53a547 ("i40e: remove i40e_status")
> > > Co-developed-by: Kelvin Kang <kelvin.kang@intel.com>
> > > Signed-off-by: Kelvin Kang <kelvin.kang@intel.com>
> > > Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> > > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > 
> > Hi Aleksandr,
> > 
> > Maybe I'm reading things wrong, I have concerns :(
> > 
> > Amongst other things, the cited commit:
> > 1. Maps a number of different I40E_ERR_* values to -EIO; and 2. Maps
> > checks on different I40E_ERR_* values to -EIO
> > 
> > My concern is that the code may now incorrectly match against -EIO for
> > cases where it would not have previously matched when more specific
> > error codes.
> > 
> > In the case at hand:
> > 1. -EIO is returned in place of I40E_ERR_ADMIN_QUEUE_ERROR 2.
> > i40e_aq_rc_to_posix checks for -EIO in place of
> > I40E_ERR_ADMIN_QUEUE_TIMEOUT
> > 
> > As you point out, we are now in a bad place.
> > Which your patch addresses.
> > 
> > But what about a different case where:
> > 1. -EIO is returned in place of I40E_ERR_ADMIN_QUEUE_TIMEOUT 2.
> > i40e_aq_rc_to_posix checks for -EIO in place of
> > I40E_ERR_ADMIN_QUEUE_TIMEOUT
> > 
> > In this scenario the, the code without your patch is correct, and with
> > your patch it seems incorrect.
> > 
> > Perhaps only the scenario you are fixing occurs.
> > If so, all good. But it's not obvious to me that is the case.
> > 
> > I'm likewise concerned by other conditions on -EIO introduced by the
> > cited commit.
> 
> This commit do not introduce -EIO errors.
> Before 230f3d53a547 ("i40e: remove i40e_status") some specific F/W error codes were
> converted into -EAGAIN by i40e_aq_rc_to_posix(), but now all error codes are already
> Linux kernel codes, so there is no way to distinguish special F/W codes and convert
> them into -EAGAIN.

Right, this last part is the nub of my concern.

> Our validation has been tested regressions of current patch and gave signed off.
> 
> Do you propose change 
> 	if (aq_ret == -EIO)
> 		return -EAGAIN;
> into
> 
> 	if (aq_ret == -EIO)
> 		return -EIO;
> ?
> 
> It will require additional testing...

If the problem I described is indeed a problem then a suspect a more
invasive change is required, to differentiate between the different
cases previously covered by internal error codes.

However, that is speculation on my part.
While your patch has been tested.

So I suggest, contrary to my previous email, that this patch moves forwards.

IOW, I am not blocking progress of this patch (anymore).

...

