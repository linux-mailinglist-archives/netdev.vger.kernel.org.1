Return-Path: <netdev+bounces-154612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8439FEC7D
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 04:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EE507A1584
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 03:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F43F7DA88;
	Tue, 31 Dec 2024 03:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jO5bHsX8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B0A28E7;
	Tue, 31 Dec 2024 03:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735615409; cv=none; b=LOTEjnxdSMJ7ryX+Lq1V635TBZFvpAYofISfN6FGA7/YjOUOxvV4lwhN4CfGZ0IDsz/Tot4qRpoydtDkhHDyOx9GikBxoQnyXrnRB52EvDwORckZ3m7oVwekbCFjucXZQa/qLsvBx9CCGaBzhE9U8AkbHYXy5ekqL3wf+Eyc5HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735615409; c=relaxed/simple;
	bh=1BMCC/ejG0uVeQt4XhOANsrsiI4+TzlWT5g18YHtsXg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kLe3dejqdxykvHCVatcdUs5fuwaydcqWZtjdhJ29lD900f7R0JU1BxqP7aSSXa3iblFPKH8eD6TqjrN7H4pBvznnPJ9+RByuo6nCYQae4ChExy78qKuw7j0s0De8z9d0GBItzD8LAErszdfw92TitoPGG8JImN/FNI+bdJDBXS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jO5bHsX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D4FC4CED0;
	Tue, 31 Dec 2024 03:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735615408;
	bh=1BMCC/ejG0uVeQt4XhOANsrsiI4+TzlWT5g18YHtsXg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jO5bHsX8N3FWzmo67rXJ6Y5zvqNRVNTetasfEKgBtJXmwBDyRT4xBSIme057mr5oJ
	 3pSiJAqW0gG1/MgOZl5nR4lDwMiY9cAhtjTLAa+SJN9CMVgwBY0wcdJ7mOmZhm6MIQ
	 ckC1X+WEWXsKOWE7X6LgA+eaGDwQLUDZSfpTW90llao9GHvOsaeJTUz4E59NblNfrp
	 eNiYIpnIXD3y1Q0LA1a8WH4klJkMWOptcOj/dENrcoFhV+SqPP5KqOEm1e915oFMZf
	 UDQkULYP2aOgb0TX+GpsrmDZz5YRGhQ3T9DP5ni1Qdmljc1Uaoz6KiUW+KiqMNtQgM
	 oaTJEQI1gG7xw==
Date: Mon, 30 Dec 2024 19:23:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: <andrew+netdev@lunn.ch>, <cai.huoqing@linux.dev>, <corbet@lwn.net>,
 <davem@davemloft.net>, <edumazet@google.com>, <gongfan1@huawei.com>,
 <guoxin09@huawei.com>, <helgaas@kernel.org>, <horms@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <meny.yossefi@huawei.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <shenchenyang1@hisilicon.com>, <shijing34@huawei.com>,
 <wulike1@huawei.com>, <zhoushuai28@huawei.com>
Subject: Re: [PATCH net-next v01 1/1] hinic3: module initialization and
 tx/rx logic
Message-ID: <20241230192326.384fd21d@kernel.org>
In-Reply-To: <20241230141435.2817079-1-gur.stavi@huawei.com>
References: <20241227103134.21168df3@kernel.org>
	<20241230141435.2817079-1-gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Dec 2024 16:14:35 +0200 Gur Stavi wrote:
> > > The most popular combination in the last 3 decades was little endian
> > > CPUs with big endian device interfaces. Endianity conversion was a
> > > necessity and therefore endian annotation became standard practice.
> > > But it was never symmetric, conversion to/from BE was more common than
> > > conversion to/from LE.
> > >
> > > As the pendulum moved from horizontal market to vertical market and major
> > > companies started to develop both hw and sw, the hw engineers transformed
> > > proprietary parts of the interface to little endian to save extra work in
> > > the sw. AWS did it. Azure did it. Huawei did it. These vertical companies
> > > do not care about endianity of CPUs they do not use.
> > > This is not "corporate verbiage" this is a real market shift.  
> >
> > Don't misquote me. You did it in your previous reply, now you're doing
> > it again.
> >
> > If you don't understand what I'm saying you can ask for clarifications.
> 
> We studied previous submissions and followed their example.
> Were the maintainers wrong to approve Amazon and Microsoft drivers?

It's not a right or wrong question, more a cost/benefit question.
I'm not sure the community benefits from merging every single company's
paravirt driver, when virtio exists. I'd say having those drivers
upstream is somewhere around neutral.

BTW very often guidance for new drivers is set by problems with already
merged drivers. Not that it's necessarily the case here, just sharing
some general knowledge about the upstream process.

> I don't understand what the problem is. Please clarify.

Primarily the fact that you keep arguing as if joining the community
was done by winning a fight. If annotating HW structures with endian
is beyond your / your teams capabilities, that's okay, just replace
the "will not be converted" with "are currently not converted" in 
the comment.

For your reference here are the development stats showing that
Huawei is the biggest net-taker of code reviews in networking:
https://lore.kernel.org/all/20241119191608.514ea226@kernel.org/

