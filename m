Return-Path: <netdev+bounces-131218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D8498D3F3
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9102AB20A1A
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C1C1D015F;
	Wed,  2 Oct 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPpf3EzV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA9D1CFED4;
	Wed,  2 Oct 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727874161; cv=none; b=IyOJdzUmO2bOeSkNRAjPay5GGcYJLOy+MPTrNIf6cvJSGnDOBKz6jKM9QPGPawi62ViVcEO206EUWElJVJjda3YSnw+ZOCcM7uduyWXQUbVvRQGEGkuV4Y1u8jp8KFCxxX7UyROUVfr34HMDdh8GfwYJ6Klag4yzv46s17D3tdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727874161; c=relaxed/simple;
	bh=HYd1MB6DSWnu383/QHjlqzrNFSwhI+RUUYJ7zax6XOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jy7aXFbIoJA9srpheTNr0NOgK0/RZ1ahiBPkDEE5VsinVRL6Qw4GvnA90DfdDrVQFXAJVOYBAj+a/uWWrEiLvcDMx5rWQMQcmBypESLVtwqDvsZh0zvP0tTFVhgTnzJ7bW+ZzH8hSw+3sQ0dnWlvUTNS3rxfGdz33sTo21HR8pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPpf3EzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301EBC4CEC5;
	Wed,  2 Oct 2024 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727874161;
	bh=HYd1MB6DSWnu383/QHjlqzrNFSwhI+RUUYJ7zax6XOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bPpf3EzVW6PNkLJWfK+fNxZW52mcxQgQ0SSQ+VUkAtV+HoRjVd4/3JrM78cCquj+z
	 TtJ/TPlpQ0cXlKcyBIl2JsheM08j3dXo4r18ui//4DvT+cyHppH6Zru82beKzeIPtx
	 ZTg7wNkpLv2HwhQ4mLKQkhct/uJWypKTnfHRwUcG3YqLV0H/UZ15abGnSACGMf5Umj
	 ZSri/V9wN6Bc1kEmPFXo3MgiOcnGuObGAPfmtwEWrtkDJh5SsginnA8aPvoFY8KQ+R
	 zWx8dQsqXyjDoI0ushSblze/kdv2eMA+5N1xjpRKs1+2zCLrVEHnUN98dkDMYS0aac
	 wN/tSQec7oBaw==
Date: Wed, 2 Oct 2024 06:02:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Anastasia Kovaleva <a.kovaleva@yadro.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, <linux@yadro.com>
Subject: Re: [PATCH v2 net] net: Fix an unsafe loop on the list
Message-ID: <20241002060240.3aca47cc@kernel.org>
In-Reply-To: <20241001115828.25362-1-a.kovaleva@yadro.com>
References: <20241001115828.25362-1-a.kovaleva@yadro.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 14:58:28 +0300 Anastasia Kovaleva wrote:
> The kernel may crash when deleting a genetlink family if there are still
> listeners for that family:

Could you add a selftest? Should be fairly easy using YNL, ncdevmem is
the only user so far.

> Oops: Kernel access of bad area, sig: 11 [#1]
>   ...
>   NIP [c000000000c080bc] netlink_update_socket_mc+0x3c/0xc0
>   LR [c000000000c0f764] __netlink_clear_multicast_users+0x74/0xc0
>   Call Trace:
> __netlink_clear_multicast_users+0x74/0xc0
> genl_unregister_family+0xd4/0x2d0
> 
> Change the unsafe loop on the list to a safe one, because inside the
> loop there is an element removal from this list.
> 
> Fixes: b8273570f802 ("genetlink: fix netns vs. netlink table locking (2)")\

nit: trailing \ at the end of the line here

