Return-Path: <netdev+bounces-117978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10959950244
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 12:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F8F9B21294
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 10:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E58189533;
	Tue, 13 Aug 2024 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i6y5LM4K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BD0208AD;
	Tue, 13 Aug 2024 10:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723544386; cv=none; b=AtO3M6OqHJ4ea4bIPz+BMxy2sC4exFeJkl5UmL+wZErQBcCTVe8J6CKYf8ySaVTxLSo/aMKGSvhYsdf8pNJ6czIWo5cmK7FCRHs+MKpd6BbIal3K5dpfERHUW0Ub80VlIhaTrCLvye9NKTwX5KoZ3L6gPvp9Hnd9IHsPVuPOVBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723544386; c=relaxed/simple;
	bh=YoGj4PVslA6UM46oWJ9gPIURkqWhOyAZEXZGqfEsu8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4b/obhsIeC4USTAe1g39ZqNFohJ/dSpcCK2vSEHpxHibo9svMawyNUaW94JLl0gKmfmpacew/ZneN5n4SsFNp8jUOsfrJ/S8s4Xob4mASYlwifxxMWxkc0keG29Llu2FekFq67DoGF8JkYg8EuWEIRaQJXuLyyalax8HVuyhJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i6y5LM4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361F3C4AF09;
	Tue, 13 Aug 2024 10:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723544385;
	bh=YoGj4PVslA6UM46oWJ9gPIURkqWhOyAZEXZGqfEsu8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i6y5LM4K03ldxlqN1WuTNmoc/qebzW8Kn7g7zIOccpgKHITcdwfwcpq0221b7yt74
	 IE0PQziJKaGrBcwcSKlmaSe0l2Q9kRrwpnUqyaayBZSy8FfpZCi0FoucDvVlmxCMO7
	 Y76v3B/0QuocahU+tVcatvjd60maZdEWC0WqCMAM=
Date: Tue, 13 Aug 2024 12:19:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Timur Tabi <timur@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
	Zijun Hu <zijun_hu@icloud.com>
Subject: Re: [PATCH 1/5] driver core: Add simple parameter checks for APIs
 device_(for_each|find)_child()
Message-ID: <2024081314-parched-salary-ec68@gregkh>
References: <20240811-const_dfc_prepare-v1-0-d67cc416b3d3@quicinc.com>
 <20240811-const_dfc_prepare-v1-1-d67cc416b3d3@quicinc.com>
 <2024081328-blanching-deduce-5cee@gregkh>
 <4f4095a7-2fd1-48df-b3c9-cdb9f7da0e79@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f4095a7-2fd1-48df-b3c9-cdb9f7da0e79@quicinc.com>

On Tue, Aug 13, 2024 at 06:00:30PM +0800, quic_zijuhu wrote:
> On 8/13/2024 5:44 PM, Greg Kroah-Hartman wrote:
> > On Sun, Aug 11, 2024 at 08:18:07AM +0800, Zijun Hu wrote:
> >> From: Zijun Hu <quic_zijuhu@quicinc.com>
> >>
> >> Add simple parameter checks for APIs device_(for_each|find)_child() and
> >> device_for_each_child_reverse().
> > 
> > Ok, but why?  Who is calling this with NULL as a parent pointer?
> > 
> > Remember, changelog text describes _why_ not just _what_ you are doing.
> > 
> 
> For question why ?
> 
> The main purpose of this change is to make these APIs have *CONSISTENT*
> parameter checking (!parent || !parent->p)
> 
> currently, 2 of them have checking (!parent->p), the other have checking
> (!parent), the are INCONSISTENT.
> 
> 
> For question who ?
> device_find_child() have had such checking (!parent), that maybe mean
> original author has concern that parent may be NULL.
> 
> Moreover, these are core driver APIs, it is worthy checking input
> parameter strictly.

Not always, no, don't check for things that will not happen, otherwise
you are checking for no reason at all.

thanks,

greg k-h

