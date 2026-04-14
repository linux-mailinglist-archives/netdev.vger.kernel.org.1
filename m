Return-Path: <netdev+bounces-278327-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNZJF8703WlolgkAu9opvQ
	(envelope-from <netdev+bounces-278327-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:03:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2EC3F6E2D
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C59A300FC76
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 08:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A754738B147;
	Tue, 14 Apr 2026 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DouCmozL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7685938AC97;
	Tue, 14 Apr 2026 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153636; cv=none; b=MFPfm6ECZdjhlr/Kmg02wyf3a5V3q9mmDsUDnjmbSgf/zN/fuWiT3ArbS2dBKnVKJkNanEuE81rvTOFfgLzmd1SI/6TTnbZyypY3H25O4gZg0T2Y5vF2hrnI+VaDImwyE2kczv0D+Wd9FUrFj86gJdOE8yLB0NkFUxzLCZ0ZDsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153636; c=relaxed/simple;
	bh=wVp6VFTURygsoghzYoYKFP8ZTFf9WBviBiJBhkIUNAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPYNR3s/kgNsXFf3lor/MPf8DsQMRd7wy91apm3Y5FAH1Jr4Jr+Yc7z/Wzt3c3/Wmqa9SdscLJwrkQkkrEAHinQe7jt+XP29hFcDiGaa0tGk+vcGtuIqPiSn6Xglkueke4d+88or9MeWtApuzv98J60lCqxM+Vou0kVEzjcGkJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DouCmozL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1922C19425;
	Tue, 14 Apr 2026 08:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776153636;
	bh=wVp6VFTURygsoghzYoYKFP8ZTFf9WBviBiJBhkIUNAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DouCmozLwuDvvUGnIMpqz0RM3dfCWjXbeibZx/ghMTjGwjW/c8XS5RUuVETaXBPAB
	 KAg6/HcgBzBDtA+8G3sobBBUQ+aADKKK6j0mo7SoA12I18pmJdG5PziSWRlXKN4oPY
	 rjIvhmTqjCzzD3eUE+FgBlyp2zPisfgq/i69k/Ac=
Date: Tue, 14 Apr 2026 10:00:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable <stable@kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH net] idpf: fix double free and
 use-after-free in aux device error paths
Message-ID: <2026041432-tapestry-condition-22ff@gregkh>
References: <2026041116-retail-bagginess-250f@gregkh>
 <afefe8b5-5bd9-4019-9d12-5ee2a7f577a2@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afefe8b5-5bd9-4019-9d12-5ee2a7f577a2@molgen.mpg.de>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278327-lists,netdev=lfdr.de];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[mpg.de:server fail,intel.com:server fail,davemloft.net:server fail,lunn.ch:server fail,linuxfoundation.org:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[andrew.lunn.ch:query timed out,edumazet.google.com:query timed out];
	PRECEDENCE_BULK(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[linuxfoundation.org:server fail,davemloft.net:server fail,lunn.ch:server fail,intel.com:server fail,mpg.de:server fail];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,mpg.de:email,davemloft.net:email]
X-Rspamd-Queue-Id: 0C2EC3F6E2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 08:54:55AM +0200, Paul Menzel wrote:
> Dear Greg,
> 
> 
> Thank you for the patch.
> 
> Am 11.04.26 um 12:12 schrieb Greg Kroah-Hartman:
> > When auxiliary_device_add() fails in idpf_plug_vport_aux_dev() or
> > idpf_plug_core_aux_dev(), the err_aux_dev_add label calls
> > auxiliary_device_uninit() and falls through to err_aux_dev_init.  The
> > uninit call will trigger put_device(), which invokes the release
> > callback (idpf_vport_adev_release / idpf_core_adev_release) that frees
> > iadev.  The fall-through then reads adev->id from the freed iadev for
> > ida_free() and double-frees iadev with kfree().
> > 
> > Free the IDA slot and clear the back-pointer before uninit, while adev
> > is still valid, then return immediately.
> > 
> > Commit 65637c3a1811 65637c3a1811 ("idpf: fix UAF in RDMA core aux dev
> 
> The commit hash is pasted twice.

Argh, when I cut/paste from my terminal that happened, my fault.

> > deinitialization") fixed the same use-after-free in the matching unplug
> > path in this file but missed both probe error paths.
> > 
> > Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> > Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: stable <stable@kernel.org>
> > Fixes: be91128c579c ("idpf: implement RDMA vport auxiliary dev create, init, and destroy")
> > Fixes: f4312e6bfa2a ("idpf: implement core RDMA auxiliary dev create, init, and destroy")
> > Assisted-by: gregkh_clanker_t1000
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > Note, these cleanup paths are messy, but I couldn't see a simpler way
> > without a lot more rework, so I choose the simple way :)
> > 
> >   drivers/net/ethernet/intel/idpf/idpf_idc.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> > index 7e4f4ac92653..b7d6b08fc89e 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> > @@ -90,7 +90,10 @@ static int idpf_plug_vport_aux_dev(struct iidc_rdma_core_dev_info *cdev_info,
> >   	return 0;
> >   err_aux_dev_add:
> > +	ida_free(&idpf_idc_ida, adev->id);
> > +	vdev_info->adev = NULL;
> >   	auxiliary_device_uninit(adev);
> > +	return ret;
> >   err_aux_dev_init:
> >   	ida_free(&idpf_idc_ida, adev->id);
> >   err_ida_alloc:
> > @@ -228,7 +231,10 @@ static int idpf_plug_core_aux_dev(struct iidc_rdma_core_dev_info *cdev_info)
> >   	return 0;
> >   err_aux_dev_add:
> > +	ida_free(&idpf_idc_ida, adev->id);
> > +	cdev_info->adev = NULL;
> >   	auxiliary_device_uninit(adev);
> > +	return ret;
> >   err_aux_dev_init:
> >   	ida_free(&idpf_idc_ida, adev->id);
> >   err_ida_alloc:
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> gemini/gemini-3.1-pro-preview has two comments [1]. Maybe the driver
> developers could judge their relevance.

These "pre-existing" reports are getting annoying.  While they are nice
to see for driver authors, it makes developers sending bug fixes in feel
like they are forced to do "more".  I think they are trying to tune this
to be a bit more sane...

thanks,

greg k-h

