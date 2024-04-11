Return-Path: <netdev+bounces-87161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB0F8A1EFE
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 20:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9049B1F2B9A6
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 18:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C41205E15;
	Thu, 11 Apr 2024 18:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gY0bJFYj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBB1205E27
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 18:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712861870; cv=none; b=D9C6DCzuLDtABQt2ti3/O9+Cz2+GAV69UF742tFWts2LWhUSwRz+aUmKgHEU2roShS3rDhk4fwhieO4hIVRzcPt791Xl6nWr9qo+yZ4n66eHT4hh70RWgfY5ErRvuPrspugCHu76Qy2CyTcderuP8XuIWx+ybUwTiHSxH18j7XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712861870; c=relaxed/simple;
	bh=kCf+dt4GPo8gJpW7jA2EsCc2kDPtGcSQI8K3gP9c3/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbD7yCSWsW4JJ+/OnByD/A3zmIyfc8++tFXzTWdFWxagYlqV/ZA/5lnSYMKSI7c4cpECSZjXSuDIDPH8DcOHXNk9239I6SMoNHiWlvkuNb0oBR77FLDaZMbdERh6rr6mJh8OU72NIUg+y9aOVnIAczMeFcOzjxLhqWewVvNlguQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gY0bJFYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C66C072AA;
	Thu, 11 Apr 2024 18:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712861869;
	bh=kCf+dt4GPo8gJpW7jA2EsCc2kDPtGcSQI8K3gP9c3/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gY0bJFYjKvXWpqDl9GKVj1Nc82oECHBqlBI90x9AwuzDcBeWiau8ZVrLpp5NoFFqn
	 MFwyvYFJcp03cqlzdsN7txs4y3vlcz9AB5ksoOtgWeqYxOOlI2+1/Lcce6ZoteA6op
	 v5sE6ivj8LjMg329Y2AIcfBN4niRj2lkkbCc8nDDSyrPwfdtmeEhsYYrwVVoczf135
	 XkCtOhWwTGEEkKxVKExG0OqV3ngAYsYA+Y9Hx2Od/nActYo8UKGklVFgDKNMRRlubm
	 ofqRnOkv6h5EWOQPVFFpPk49kHFIkIJeLEcG2X4vNb2YwZPHb58hvP2lNmt3/2lN3q
	 NU+A1V1vdkCGA==
Date: Thu, 11 Apr 2024 11:57:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, Stefano
 Brivio <sbrivio@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 dsahern@kernel.org, donald.hunter@gmail.com
Subject: Re: [PATCH net] inet: bring NLM_DONE out to a separate recv() again
Message-ID: <20240411115748.05faa636@kernel.org>
In-Reply-To: <CANn89iJne2+k+MJQzu1U7vO6eEbTLjD7QQxSG6hPgZ1i7+AutA@mail.gmail.com>
References: <20240411180202.399246-1-kuba@kernel.org>
	<CANn89iJne2+k+MJQzu1U7vO6eEbTLjD7QQxSG6hPgZ1i7+AutA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 20:42:45 +0200 Eric Dumazet wrote:
> My plan was to perform this generically from netlink_dump_done().
> 
> This would still avoid calling a RTNL-enabled-dump() again if EOF has
> been met already.
> 
> A sysctl could opt-in for the coalescing, if there is interest.

I'd prefer to keep hacks contained to the few places that need them.
Netlink is full of strange quirks, I don't think this one deserves
a sysctl.

