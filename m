Return-Path: <netdev+bounces-81348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F22CB8874F3
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 23:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA6C1C22B8F
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 22:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073F282881;
	Fri, 22 Mar 2024 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4+rPui+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DEE81750
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711148151; cv=none; b=Pqu33MqbakU1hMRDB6rfElM+ypOqoYe45xAIMqYxZbLjWzJYdt8+gESnrUcihW5TudGfxBQooLiAKHVKVVRdu8zUpDrchaiLpS61bgL+71dlZgraSNUAH+zyrfRgyIdK3oRvYmu6dx1juqaQ5BwcfAyhknOFLPDWn/7XwzC78zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711148151; c=relaxed/simple;
	bh=XZZfzTHi7snr1nsrLxfaDOVvbSdaxsIvIbn0m6uGTtE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BzCXsJNikdlDxUr42HjGLRGEEOFbxHjlOqiPZYbMKGIfqGHERRJLbb2heHJg+8YYtpjYWonfboowJOUyhDpGFJMNd/YjqBDPz7dYXh/72/yUkTLu7cuilzXUwxqeomVTJJKjYC6gZCxF8J+RWb1gH9mwZB+YS1DpVibq7tdv3Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4+rPui+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B0EC433F1;
	Fri, 22 Mar 2024 22:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711148151;
	bh=XZZfzTHi7snr1nsrLxfaDOVvbSdaxsIvIbn0m6uGTtE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e4+rPui+jbjF3elpbrRaPpbEhyStmhhCAnbt4CanYumkePfOnKGoVGiPPDcjANLwz
	 2xIHIvuSRbkV2o57hSD3TUtmr7NXMAQ5NGeRly8EsOZFaMI1KWqc27nhyir+Myrmrf
	 iyZDWEwNFnxaPib6ze73vIqL+eC968zsoqT5PsbfxhvD6wFyuBTpNonRElUw6wIvq8
	 W3UnGBekczhjppx2X+x3pQIcF1vUJPmEx7sPJGAc+I+GpqzVrDo1l2UOPO1G/nG1Hz
	 TiI9lqUIQaofSKxr7us6+mTSkJft69iP3pbXzBkVV0Q5zOmVCldBuycWUOSsKWdqO3
	 DZcerpOJTYuYw==
Date: Fri, 22 Mar 2024 15:55:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 steffen.klassert@secunet.com, willemdebruijn.kernel@gmail.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net v3 0/4] gro: various fixes related to UDP tunnels
Message-ID: <20240322155550.3779c85a@kernel.org>
In-Reply-To: <20240322114624.160306-1-atenart@kernel.org>
References: <20240322114624.160306-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 12:46:19 +0100 Antoine Tenart wrote:
> We found issues when a UDP tunnel endpoint is in a different netns than
> where UDP GRO happens. This kind of setup is actually quite diverse,
> from having one leg of the tunnel on a remove host, to having a tunnel
> between netns (eg. being bridged in another one or on the host). In our
> case that UDP tunnel was geneve.

I think this series makes net/udpgro_fwd.sh selftest fail.

