Return-Path: <netdev+bounces-89741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1F28AB64F
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 23:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C220A1F21201
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 21:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07942A1D8;
	Fri, 19 Apr 2024 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="silSMtvm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D281910A2C
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713561255; cv=none; b=AV+GKF6H9dbj4OC5FKQEZpI3/0yB9pitSzf2GPPQE4wougHgWhDzAhHwyqIDXsbXqT4CXbihuljWrw9CjXGBf7rbnFE1cmEpk5+JQRroqRJsxnLecFHioRjYDKkxWCy1bJCSXztIUAcFhM5WPDW8rslDnwepWdltfMgRR5lvo50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713561255; c=relaxed/simple;
	bh=cOKeXEUg5br8gzuTXgmqcbv9hutN0QyrIb3NDat6XFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbQYkwgfNbVORScfV4aIiKNDkRgdlzgdf+txuT9aPwbZTIMjAPKuBEl61kk48Y+/VbDxvAu7YD1Uz0uWYvAabEDyOT4+TcQnr481KFNdTtBareyTHV8cbWo5r2210YDH8e5lAVUGgM9SFXjTuo9AlRS2o1F2XGgW4Ey8QZJ6Waw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=silSMtvm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=5zxuZ657eUPYgR33Hu1hgoRc2uwWsqgLb8RlDaFpwfc=; b=si
	lSMtvmJeN0gHh7vUMEXxJ7bBy5UHBmDwjJiZ768xETyJu+9hjgWP9eh2PzvES8QrpauFb4ZamifuT
	xxMYmGSMHeijFMZIs++eU17NetWSZsQMNGex1VFag/HF2h1vfIcn3ZLxBYFhKwtaEszCIAfdZM+/6
	GgkhUdiIC3kjDJI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rxvYg-00DTy1-BO; Fri, 19 Apr 2024 23:14:10 +0200
Date: Fri, 19 Apr 2024 23:14:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Peter =?iso-8859-1?Q?M=FCnster?= <pm@a16n.net>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH net v3] net: b44: set pause params only when interface is
 up
Message-ID: <876ff4fa-1744-4929-9da8-8a10016c2f30@lunn.ch>
References: <87o7a5yteb.fsf@a16n.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o7a5yteb.fsf@a16n.net>

On Fri, Apr 19, 2024 at 10:44:28PM +0200, Peter Münster wrote:
> Hi,
> 
> This patch fixes a kernel panic when using netifd.
> 
> Kind regards,
> -- 
>            Peter

Still above the --- . Don't use attachments.

The best way to send patches is

git format-patch

followed by

git send email

https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format

Alternatively, look at b4:

https://b4.docs.kernel.org/en/latest/contributor/prep.html

Interestingly, patchwork does seemed to of extracted the patch:

https://patchwork.kernel.org/project/netdevbpf/patch/87o7a5yteb.fsf@a16n.net/

So it could be the patch can be applied as it is. Lets see what Jakub
says.

Anyway:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

We are picky about things like this because there are a lot of patches
flying around, and we need to be efficient at applying them. So we
want patches in a specific format. It takes a little bit of time to
learn to do it correct, but once you use the tools correctly it
becomes simple as a developer and efficient for those receiving the
patches.

     Andrew

