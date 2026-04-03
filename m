Return-Path: <netdev+bounces-275031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N0bCMG4z2kd0AYAu9opvQ
	(envelope-from <netdev+bounces-275031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 14:55:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 590913943F1
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 14:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 601E43075D6D
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 12:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715DB3AE6EE;
	Fri,  3 Apr 2026 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j1jVQVS4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861FF239E7F;
	Fri,  3 Apr 2026 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775220555; cv=none; b=YU5RHyAgHOmJK0TtHB/mrII8y46GJr9GKRqAK8Lqk1h436Yzg+ZTmc8lU6hjGamyKcV9qlxrrnfh75mybFD/8Q4XsEpAkXxXdU7+LDRJlnZwzoRJ2nBVR9+kM2/fmjrLVyTxWFF9RG4WEFqKtwWYmn/oFX/UcalClvu0MI8whZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775220555; c=relaxed/simple;
	bh=+Gmps33FngXtRV+HbcVt1uHDIEW0qTrIRlrmLWpPgxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzlxQStfV5n+apwSRr7zw/iSCPyFWS21TsbtQBy/ZPtXKbsTy+FZ4X3SoyXSpvXIALKZzde0GeMlC+1VGNAv61mrtNpUqql3EoJT3G0rUBAW68zKnTFzfthhksazPdEVzQHwWBuxKeizGDn9m+AzvTToGaUswtmGfam4rbQej4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j1jVQVS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDD0C4CEF7;
	Fri,  3 Apr 2026 12:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775220554;
	bh=+Gmps33FngXtRV+HbcVt1uHDIEW0qTrIRlrmLWpPgxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j1jVQVS4CboefT/ydBqJV/WJLRbiSr2Vlw5cdSsqh1FRxxdaSK2DnseVCQHRn4D5c
	 LGXeGgzVX2qO2UsbBeoejZOPYqhynBoXV/x79SoyjrXKicJNo0XRMek61VwTHH0LQj
	 W5GLKTL4ZTM+tDLloJh4lLU0shva0G4RByG9T5QY=
Date: Fri, 3 Apr 2026 14:49:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "He, Guocai (CN)" <Guocai.He.CN@windriver.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	"Berg, Johannes" <johannes.berg@intel.com>,
	Friend <netdev@vger.kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: commit 0c4f1c02d27a880b cause a deadlock issue
Message-ID: <2026040349-chowtime-freeload-5ca4@gregkh>
References: <CO6PR11MB5586A4475A5EEC47FC10398BCD53A@CO6PR11MB5586.namprd11.prod.outlook.com>
 <PH0PR11MB55934A1C9A8C35B1E751C247CD50A@PH0PR11MB5593.namprd11.prod.outlook.com>
 <14d65103-8809-4a1b-b115-bf5f8d7110ea@leemhuis.info>
 <CO6PR11MB5586DF3964BAB4E6131A86CDCD5EA@CO6PR11MB5586.namprd11.prod.outlook.com>
 <2026040331-evasion-walk-f572@gregkh>
 <DM3PPF63A6024A9C09C1B13E5DF46C0B72AA35EA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PPF63A6024A9C09C1B13E5DF46C0B72AA35EA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-275031-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:email,linux.dev:email,leemhuis.info:email,linuxfoundation.org:dkim,linuxfoundation.org:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 590913943F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 12:44:48PM +0000, Korenblit, Miriam Rachel wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Friday, April 3, 2026 2:27 PM
> > To: He, Guocai (CN) <Guocai.He.CN@windriver.com>
> > Cc: Thorsten Leemhuis <regressions@leemhuis.info>; Korenblit, Miriam Rachel
> > <miriam.rachel.korenblit@intel.com>; Berg, Johannes
> > <johannes.berg@intel.com>; Friend <netdev@vger.kernel.org>; Linux kernel
> > regressions list <regressions@lists.linux.dev>
> > Subject: Re: commit 0c4f1c02d27a880b cause a deadlock issue
> > 
> > On Fri, Apr 03, 2026 at 11:08:46AM +0000, He, Guocai (CN) wrote:
> > > No, The mainline have no this issue.
> > > The changes of 0c4f1c02d27a880b is not in mainline.
> > 
> > That does not make sense, that commit is really commit e1696c8bd005
> > ("wifi: cfg80211: stop NAN and P2P in cfg80211_leave") which is in all of the
> > following releases:
> > 	5.10.252 5.15.202 6.1.165 6.6.128 6.12.75 6.18.14 6.19.4 7.0-rc1
> > 
> > confused,
> 
> The change is indeed in mainline, but the locking situation in mainline is totally different
> (that mutex does not even exist there)
> Therefore, the issue is not supposed to happen in mainline.

Ok, does that commit now need to be reverted from some of the stable
branches?  If so, which ones?

thanks,

greg k-h

