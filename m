Return-Path: <netdev+bounces-93929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9338BD9C2
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 05:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762371F2307F
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 03:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1743A1C7;
	Tue,  7 May 2024 03:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b="gh5OC/nW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp65.iad3b.emailsrvr.com (smtp65.iad3b.emailsrvr.com [146.20.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB94E1EB5E
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 03:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715053023; cv=none; b=UaKQSIFc4RVADZaSm4Beh0zP7a63+ogoo8sBrS6Iuv2BLXH5Eo6sRYOLmpYM/KmJ7ek4MfbDVTbwHd2XxJ//ZAJgA5rwHCc41lNcWmDeDW8KZ2DCoc/3yDR5CEqEnlh715ZlK1tYf3hUwx976pun864HRem8TQXfSzCDblfVqW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715053023; c=relaxed/simple;
	bh=cWMEq59X7zXzL3nJa3BLDmbI7tPBBw3giwZaDz3gBLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVr6WziMHGfRyvilfQ1QrL4PsEPhFImB5uKo645NuwOE4saQX1XwW6Yss9xOUFadDTovqXvrC3SBLdFej7G69WuIxrnagLhn/XUVQjLZAnQdWfFos7T0ykFSKuIrN2ZYhX6jcx4UWYUXEZk1bPpCHspf1B2JUaQCztOiaiR5YFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com; spf=pass smtp.mailfrom=oddbit.com; dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b=gh5OC/nW; arc=none smtp.client-ip=146.20.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oddbit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oddbit.com;
	s=20180920-g2b7aziw; t=1715051887;
	bh=cWMEq59X7zXzL3nJa3BLDmbI7tPBBw3giwZaDz3gBLI=;
	h=Date:From:To:Subject:From;
	b=gh5OC/nWu2m+qCk6m0PPZVQuqzfvydgDIjESDhRMMppqckZ/n5+QjiJhRy4hCYjND
	 59EjcycsEBuXz4t8EnBMrx/7wNVNtkJSZcs+vaPEmElxiYNIXw8Slbu5ct7020lsLA
	 IchtCetQlquQGfB2uJiffbK2EpbEY9NblZGnzfX8=
X-Auth-ID: lars@oddbit.com
Received: by smtp17.relay.iad3b.emailsrvr.com (Authenticated sender: lars-AT-oddbit.com) with ESMTPSA id B39DCA02AA;
	Mon,  6 May 2024 23:18:06 -0400 (EDT)
Date: Mon, 6 May 2024 23:18:06 -0400
From: Lars Kellogg-Stedman <lars@oddbit.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Duoming Zhou <duoming@zju.edu.cn>, linux-hams@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org, 
	edumazet@google.com, davem@davemloft.net, jreuter@yaina.de
Subject: Re: [PATCH net] ax25: Fix refcount leak issues of ax25_dev
Message-ID: <eb5oil2exor2bq5n3pn62575phxjdex6wdjwwjxjd3pd4je55o@4k4iu2xobel5>
References: <20240501060218.32898-1-duoming@zju.edu.cn>
 <my4l7ljo35dnwxl33maqhyvw7666dmuwtduwtyhnzdlb6bbf5m@5sbp4tvg246f>
 <78ae8aa0-eac5-4ade-8e85-0479a22e98a3@moroto.mountain>
 <ekgwuycs3hioz6vve57e6z7igovpls6s644rvdxpxqqr7v7is6@u5lqegkuwcex>
 <1e14f4f1-29dd-4fe5-8010-de7df0866e93@moroto.mountain>
 <movur4qy7wwavdyw2ugwfsz6kvshrqlvx32ym3fyx5gg66llge@citxuw5ztgwc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <movur4qy7wwavdyw2ugwfsz6kvshrqlvx32ym3fyx5gg66llge@citxuw5ztgwc>
X-Classification-ID: 523c2de5-7003-4c0c-8800-1836014b2a10-1-1

On Sat, May 04, 2024 at 06:16:14PM GMT, Lars Kellogg-Stedman wrote:
> My original patch corrected this by adding the call to netdev_hold()
> right next to the ax25_cb_add() in ax25_rcv(), which solves this
> problem. If it seems weird to have this login in ax25_rcv, we could move
> it to ax25_accept, right around line 1430 [3]; that would look
> something like:

The same patch applies cleanly against the Raspberry Pi 6.6.30 kernel,
and clears up the frequeny crashes I was experiencing in that
environment as well.

-- 
Lars Kellogg-Stedman <lars@oddbit.com> | larsks @ {irc,twitter,github}
http://blog.oddbit.com/                | N1LKS

