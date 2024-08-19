Return-Path: <netdev+bounces-119531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184F995615B
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 05:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91C38B2178E
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 03:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F5A13957C;
	Mon, 19 Aug 2024 03:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a/EaUiMK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ED7A48;
	Mon, 19 Aug 2024 03:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724036898; cv=none; b=LE/U+uFuO7FBHdB5FBODwgsSOUI9aJkC4/Wy8vUTx8RiOHLZFnQCXhd2/pEDxkdKmrNTUXjs/pEf5wk6qPDRYzGPYZcdlg13143aqrtrAF10aoFTZ+nW/rNC7Qod70FgQwZWWk/OLF87kGmEcQSyf8oGQ4HWbb1K0HiXIrSaVO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724036898; c=relaxed/simple;
	bh=iIvtIz7mzaReDZSr1aoEFrcCrYeAs0i/x8lAESqdY4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H94Eyeomcbq7sP+bZWd8mmVyBzJsuwvrVgp+CGR482745Tq9/f5csb2992r3z2pn0gNkYX4ET4Dhkg3d3x76rsyNIhMRGLwrIWU+mJtVBPIK1TCC3h242FON1ILjUR0aCT1BV0d122UGsUeH+tc4wMcBIWwPmtmofg3sOtemizY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a/EaUiMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93939C32786;
	Mon, 19 Aug 2024 03:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724036898;
	bh=iIvtIz7mzaReDZSr1aoEFrcCrYeAs0i/x8lAESqdY4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/EaUiMKSv1DEkpq08l/YJQXIUEvPz/rz0mbz/zeDYAGSAGMmx0+w7fOZJxU1gDnq
	 a79LSpfrU+MWfRLpxPREaxapFabB04QCmHK8K2g8SmCaZGfO+aYPF2D8S+2jr4nvFD
	 RVogHEjSs8hI4kzxMNYFT8FHk98T9xbNNGeAeoTE=
Date: Mon, 19 Aug 2024 05:08:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Young <alex000young@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, security@kernel.org,
	xkaneiki@gmail.com, hackerzheng666@gmail.com
Subject: Re: [PATCH] net: sched: use-after-free in tcf_action_destroy
Message-ID: <2024081929-polygraph-moisten-44f2@gregkh>
References: <20240816015355.688153-1-alex000young@gmail.com>
 <CAM0EoMmAcgbQWG7kQoe335079Y2UY_BmoYErL=44-itJ=p-B-Q@mail.gmail.com>
 <CAM0EoM=qvBxXS_1eheyhCKbNMRbK_qTTFMa1fFBFQp_hRbzpQQ@mail.gmail.com>
 <CAFC++j15p9Ey3qc4ZsY4CXBsL3LHn7TsFTi6=N9=H+_Yx_k=+Q@mail.gmail.com>
 <2024081722-reflex-reverend-4916@gregkh>
 <CAM0EoMmUSGEY_wGHmZJkP5s=sr0zPJ2sOyTf3Uy6P3pN8XmvhA@mail.gmail.com>
 <2024081839-fool-accuracy-b841@gregkh>
 <CAFC++j0y7LZuZaZrVa01o3d1OSbo1VOccEw=zhJ+nc=-6bZOQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFC++j0y7LZuZaZrVa01o3d1OSbo1VOccEw=zhJ+nc=-6bZOQg@mail.gmail.com>

On Mon, Aug 19, 2024 at 09:10:45AM +0800, Alex Young wrote:
> Hi greg.
> Thanks for your suggestion. I will try to use the new kernel.
> By the way, the 5.4.y you mentioned does not fix this bug either.

As was pointed out, this looks to be resolved in 5.10.y, not 5.4.y.  We
will gladly accept a working backport to 5.4.y of the commit to resolve
it there, please send it to stable@vger.kernel.org to be included.

thanks,

greg k-h

