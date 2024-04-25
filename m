Return-Path: <netdev+bounces-91354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 966908B24CB
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 17:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7AAF1C21341
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 15:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFEC14A4FB;
	Thu, 25 Apr 2024 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CRh6ysxa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B72A5B1F8
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058017; cv=none; b=Y5I1VKRY5/xCZDPQVG6D9vQmKCiKaE6cw0qnvZ2LaVtaYGnpJ/OISkZPQw+1VFvaWFaHNRlXIqz5/0ioQWg+Ue3OTxH4Mil4Xuz7K4nSRB+uuyOIpkqpKTcOOFMM1d5rlsUaQ0f45QjkhGEEZ/khQtLHokZlVK63/uO/EOODlxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058017; c=relaxed/simple;
	bh=hFpK8XSM1/HUq6bEn8zUIMT1/gjUrzh2BfkVUYpzBzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYFG+jbnybdrefPxpqsZjr9Od/oVP4AxqeQp74ZVCOkvskfWt1Gu+sEWMPHWGVH5Vm22A30Sdu+68sL4JrX6F1N3KQF2ZCMprWPaXAIB4IuekS9RgPO7uO6bBPqPW08GolgrvV8CW3HM3tVB6A7irxKo/MA7Hx9FB2bdez9Khe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CRh6ysxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9EEC113CC;
	Thu, 25 Apr 2024 15:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714058016;
	bh=hFpK8XSM1/HUq6bEn8zUIMT1/gjUrzh2BfkVUYpzBzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CRh6ysxa9sJaAMLsvJaxwXwEf56EUsPIpJeW5jU0sbMcvvsYbA8O+dDWREIKjLk+o
	 lmVl+KF0/IL2F5H/e7uGhPSjVgjM09y+OZzdI6kO+uA/RWUYprocIhrtSz16QQ3hTI
	 djk036VoVhxFZiZfYJBBWX+LAaQ8zNfo6dp2dyso=
Date: Thu, 25 Apr 2024 08:13:28 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: George Dunlap <dunlapg@umich.edu>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, wei.liu@kernel.org,
	paul@xen.org, Jakub Kicinski <kuba@kernel.org>, kirjanov@gmail.com,
	dkirjanov@suse.de, kernel-team@cloudflare.com,
	security@xenproject.org, andrew.cooper3@citrix.com,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH net] xen-netfront: Add missing skb_mark_for_recycle
Message-ID: <2024042544-jockstrap-cycle-ed93@gregkh>
References: <171154167446.2671062.9127105384591237363.stgit@firesoul>
 <CALUcmU=xOR1j9Asdv0Ny7x=o4Ckz80mDjbuEnJC0Z_Aepu0Zzw@mail.gmail.com>
 <CALUcmUkvpnq+CKSCn=cuAfxXOGU22fkBx4QD4u2nZYGM16DD6A@mail.gmail.com>
 <CALUcmUn0__izGAS-8gDL2h2Ceg9mdkFnLmdOgvAfO7sqxXK1-Q@mail.gmail.com>
 <CAFLBxZaLKGgrZRUDMQ+kCAYKD7ypzsjO55mWvkZHtMTBxdw51A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLBxZaLKGgrZRUDMQ+kCAYKD7ypzsjO55mWvkZHtMTBxdw51A@mail.gmail.com>

On Thu, Apr 25, 2024 at 02:39:38PM +0100, George Dunlap wrote:
> Greg,
> 
> We're issuing an XSA for this; can you issue a CVE?

To ask for a cve, please contact cve@kernel.org as per our
documentation.  Please provide the git id of the commit you wish to have
the cve assigned to.

thanks,

greg k-h

