Return-Path: <netdev+bounces-64399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E12B832E2E
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 18:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E631F22C00
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 17:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F9B55E7C;
	Fri, 19 Jan 2024 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="U/9xZHaQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A870C55E70;
	Fri, 19 Jan 2024 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685397; cv=none; b=eU4HaYZPqimF3ZFK1B7YrNQxJ+Kzp2mWynq5P3hK3pHnIqT2T3TbFVPXK8CNMFluIP1kCXPBAJrpEumUtBMPKdrIKLQ+LEnZejeS6JH9E+5Mb0GTXXSXEtLnm3be/FM4LrA0RxeNnKBo9nZYeL5z74juM49UEdq15+JCZabhRmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685397; c=relaxed/simple;
	bh=Upvyt/oAj+lccPbq8zyjj8LYO2UwaPzjMahikAPz8zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDu/MKvK56glT8Zmb6NIMt5MwsbNlPL3IlNFMwhfjqVjyoco7mkxn4jcylEujTQLmZaD9aKYQoqaWtLip5nMeplVbkypVXpJ/6CHA09Qhuj5D+8cqQInxjkm8+QYZ10RRk7NZLI2ANAAG02kO4kWThA0UbCJmmYnOruhZ7novWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=U/9xZHaQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=fmnFjcGqCcC7uuE7wYDHjW/TOHnvXy2QmQyU8wJSCgg=; b=U/
	9xZHaQVb4l4p/gs3tqxkOlUtbHh9JN+bpXPHz9YlIMt2U+gLl/Ut5fnSvuqe5gGO7B22SUnek33bU
	unR42VWf0cAfY3zv8ChJeowtKZPGtVr/gPDtLpP5PZI/ShFBi5PM4Bj2qTNKNnb0BTKM2syMh8ogy
	T2AOfr+Blsdc6+s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rQsgK-005Zs4-3P; Fri, 19 Jan 2024 18:29:28 +0100
Date: Fri, 19 Jan 2024 18:29:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, Paolo Abeni <pabeni@redhat.com>,
	Zhu Yanjun <yanjun.zhu@intel.com>, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] virtio_net: Add timeout handler to avoid kernel hang
Message-ID: <430b899c-aed4-419d-8ae8-544bb9bec5d9@lunn.ch>
References: <20240115012918.3081203-1-yanjun.zhu@intel.com>
 <ea230712e27af2c8d2d77d1087e45ecfa86abb31.camel@redhat.com>
 <667a9520-a53f-40a2-810a-6c1e45146589@linux.dev>
 <7dd89fc0-f31e-4f83-9c02-58ee67c2d436@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7dd89fc0-f31e-4f83-9c02-58ee67c2d436@linux.alibaba.com>

> > > >       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > -           !virtqueue_is_broken(vi->cvq))
> > > > +           !virtqueue_is_broken(vi->cvq)) {
> > > > +        if (timeout)
> > > > +            timeout--;
> > > This is not really a timeout, just a loop counter. 200 iterations could
> > > be a very short time on reasonable H/W. I guess this avoid the soft
> > > lockup, but possibly (likely?) breaks the functionality when we need to
> > > loop for some non negligible time.
> > > 
> > > I fear we need a more complex solution, as mentioned by Micheal in the
> > > thread you quoted.
> > 
> > Got it. I also look forward to the more complex solution to this problem.
> 
> Can we add a device capability (new feature bit) such as ctrq_wait_timeout
> to get a reasonable timeout？

The usual solution to this is include/linux/iopoll.h. If you can sleep
read_poll_timeout() otherwise read_poll_timeout_atomic().

	Andrew

