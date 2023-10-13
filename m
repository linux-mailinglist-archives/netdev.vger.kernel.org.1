Return-Path: <netdev+bounces-40889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB527C905C
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87015B209A0
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 22:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A285241F3;
	Fri, 13 Oct 2023 22:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKmjpQzW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA61107AD
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 22:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BB8C433C8;
	Fri, 13 Oct 2023 22:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697236984;
	bh=tWTCttui4UFyt2yeWYK9aIb7UBMshVr8qR5BhDqrXNw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tKmjpQzWW/VWRluLD4JeRBorppjaZOyu92+11TACEcSPm0MIbe19kTLiEpQPh6Oca
	 Xqdu8P3nXtvgRQFC9Wj9V+UZ6d8pPCUmGEwOBDW9OM0z9/H5D2Q9U/3pg7OKWgvaSQ
	 G5mD/630665MNRz2AZiULwyJjNdNUZgWefA1GEOvpR3QFl+PxKKEu3wX4f4lAjBGxs
	 TV+9igkGDxkeQkq7EhCIAEG8/5yVFvc7mu7MS6CF6k2uOOlq+eO71Lokz78B+x6l/w
	 hOOOcbW3fFppnLnFQcIexWN6XpEzRnldI8WNutPU5MVqrYXReK0Zre+5k5u99TKQ+I
	 fto+fFjjdhCXw==
Date: Fri, 13 Oct 2023 15:43:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel =?UTF-8?B?R3LDtmJlcg==?= <dxld@darkboxed.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Richard Weinberger
 <richard@nod.at>, Serge Hallyn <serge.hallyn@canonical.com>, "Eric W.
 Biederman" <ebiederm@xmission.com>
Subject: Re: [BUG] rtnl_newlink: Rogue MOVE event delivered on netns change
Message-ID: <20231013154302.44cc197d@kernel.org>
In-Reply-To: <20231013153605.487f5a74@kernel.org>
References: <20231010121003.x3yi6fihecewjy4e@House.clients.dxld.at>
	<20231013153605.487f5a74@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Oct 2023 15:36:05 -0700 Jakub Kicinski wrote:
>    kobject_uevent(&dev->dev.kobj, KOBJ_REMOVE);
>    dev_net_set(dev, net);
>    kobject_uevent(&dev->dev.kobj, KOBJ_ADD);

Greg, we seem to have a problem in networking with combined
netns move and name change.

We have this code in __dev_change_net_namespace():

	kobject_uevent(&dev->dev.kobj, KOBJ_REMOVE);
	dev_net_set(dev, net);
	kobject_uevent(&dev->dev.kobj, KOBJ_ADD);

	err = device_rename(&dev->dev, dev->name);

Is there any way we can only get the REMOVE (old name) and ADD
(new name) events, without the move? I.e. silence the rename? 

Daniel is reporting that with current code target netns sees an 
add of an interface with the old (duplicated) name. And then a rename.

Without a silent move best we can do is probably:

	kobject_uevent(&dev->dev.kobj, KOBJ_REMOVE);
	dev_net_set(dev, net);
	err = device_rename(&dev->dev, dev->name);
	kobject_uevent(&dev->dev.kobj, KOBJ_ADD);

which will give us:

	MOVE new-name
	ADD new-name

in target netns, which, hm.

