Return-Path: <netdev+bounces-55851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AB380C7DB
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 12:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10CE628170F
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 11:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19D7364C0;
	Mon, 11 Dec 2023 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fS0qaeX8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CBA3454A
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 11:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2E8C433C8;
	Mon, 11 Dec 2023 11:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702293790;
	bh=RvXeZsCsTRB/ykFjhY8FOPGVRNC7qDb5nFcV0xvctXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fS0qaeX8EfWKEh9IFSNTv9viV0+RH5CMAUNGSPtr0gzzUh3wQ1OQWEYPuGog/n7qa
	 JG9vgFJieBvXCujm3q+AGF5r8aHBCkm8Ev14Zf9GpaVsm5ATjGJA7p0a6t3+RZgjjj
	 zHbJiq93+6efh3/fgpfwAV8HtmmyJwsDuHmkQMkP89sohR/RpB2vS0WAyxSdCLgRkw
	 BZ5Vf9/B4yqGg/VWi1U27vhwXs/xk2fU77XUQucztqh37e9OWdKr2hZIuQoKz+1Dpb
	 hy9m9kaBsWbkDmwO+cca9g0ykwF5DHT+pqop0MjRzCuWWFB1q8g9VMhPhAM2HGky7y
	 zoodfxRSjtLOQ==
Date: Mon, 11 Dec 2023 13:23:05 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Haseeb Gani <hgani@marvell.com>,
	Vimlesh Kumar <vimleshk@marvell.com>,
	"egallen@redhat.com" <egallen@redhat.com>,
	"mschmidt@redhat.com" <mschmidt@redhat.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"wizhao@redhat.com" <wizhao@redhat.com>,
	"kheib@redhat.com" <kheib@redhat.com>,
	"konguyen@redhat.com" <konguyen@redhat.com>,
	Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh B Edara <sedara@marvell.com>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [EXT] Re: [PATCH net-next v3 2/4] octeon_ep: PF-VF mailbox
 version support
Message-ID: <20231211112305.GD4870@unreal>
References: <20231211063355.2630028-1-srasheed@marvell.com>
 <20231211063355.2630028-3-srasheed@marvell.com>
 <20231211084652.GC4870@unreal>
 <PH0PR18MB4734652F50856F52507577ADC78FA@PH0PR18MB4734.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR18MB4734652F50856F52507577ADC78FA@PH0PR18MB4734.namprd18.prod.outlook.com>

On Mon, Dec 11, 2023 at 10:31:32AM +0000, Shinas Rasheed wrote:
> Hi Leon,
> 
> > > @@ -28,10 +28,18 @@ static void octep_pfvf_validate_version(struct
> > octep_device *oct,  u32 vf_id,
> > >  {
> > >  	u32 vf_version = (u32)cmd.s_version.version;
> > >
> > > -	if (vf_version <= OCTEP_PFVF_MBOX_VERSION_V1)
> > > -		rsp->s_version.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
> > > +	dev_dbg(&oct->pdev->dev, "VF id:%d VF version:%d PF
> > version:%d\n",
> > > +		vf_id, vf_version, OCTEP_PFVF_MBOX_VERSION_CURRENT);
> > > +	if (vf_version < OCTEP_PFVF_MBOX_VERSION_CURRENT)
> > > +		rsp->s_version.version = vf_version;
> > >  	else
> > > -		rsp->s_version.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
> > > +		rsp->s_version.version =
> > OCTEP_PFVF_MBOX_VERSION_CURRENT;
> > > +
> > > +	oct->vf_info[vf_id].mbox_version = rsp->s_version.version;
> > > +	dev_dbg(&oct->pdev->dev, "VF id:%d negotiated VF version:%d\n",
> > > +		vf_id, oct->vf_info[vf_id].mbox_version);
> > > +
> > > +	rsp->s_version.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
> > >  }
> > 
> > <...>
> > 
> > > +#define OCTEP_PFVF_MBOX_VERSION_CURRENT
> > 	OCTEP_PFVF_MBOX_VERSION_V1
> > 
> > This architecture design is unlikely to work in the real world unless
> > you control both PF and VF environment. Mostly PF is running some old
> > legacy distribution while VFs run more modern OS and this check will
> > prevent to run new driver in VF.
> > 
> > Thanks
> 
> Thanks for the review. This version validation only concerns regarding the control net API layer (which is used to communicate with
> the firmware). In the case you have described, this instead enables new VF drivers to atleast work atop legacy PF drivers (note legacy here still
> refers to PF drivers which support this backward compatibility), although they might not be able to use the latest control net functionalities that they
> have been enabled for.

The question what will be in X years from now, when you will have v100?
Will you fallback to v0 for backward compatibility? 

> 
> In the absence of such a backward compatibility, VF drivers would issue control net requests which PF drivers wouldn't know, only leading to logs of
> incompatibility errors and erroneous usage. 
> 
> Also again please note that this version compatibility only concerns the control net infrastructure and API (the control plane).

It doesn't matter, even in best scenario, you can't guarantee that code in VM actually
implements version Y fully and will need to check correctness per-command anyway.

Thanks

> 

