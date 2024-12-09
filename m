Return-Path: <netdev+bounces-150040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CBF9E8B6C
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 07:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93B928164C
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 06:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EE62101B1;
	Mon,  9 Dec 2024 06:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="f+e7Zpag"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EB317C219
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 06:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733725003; cv=none; b=uPXC1omeXghnCHGKNiCKCivlqNfcwjqonL6WAiejiXBg1BP3RYyz3W/nJb3SZrKBbQBYdHv/KIz0f35vstA4Aswv7YafS33oF9cf2CsLST2nnBEveSGFP3gyuiQO4AkZ+egNyM85/hfCrInyxeVyB/+w7FSx6shu9QK2Wn4ZNck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733725003; c=relaxed/simple;
	bh=tXMGy0VjAzO3AXyM4HXvfVrm17uQsP4qhxGDZ8hym2E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SF4wf9h6KUi0PY/ahQaQi2Auc29f1EOIqV28PhOJV5WXoP9b2zdcv6k7GtQwgWaAPtruMoe5Htg4NkCWN1xwi6TV4ufPjWZY9gGg5RYrsOCiPeAZpFhLKDYK3dO32J+ZrZdEqTxkxGm5uiYtZhNET4VhK6xgFfuH4pWFhQJ7lW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=f+e7Zpag; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1733724993;
	bh=tXMGy0VjAzO3AXyM4HXvfVrm17uQsP4qhxGDZ8hym2E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f+e7ZpagL6g9BXXWWhQW0xTca/gXnk8Ejc0PBKZRy0bNZB37rG8K2kK7eK6+uqm8I
	 dC6PRFoOzI22Ri1JXNqBu4Rt5aLvS5gUZJGTtDTS98foz/eycryFm/gdBW/N1ECjB0
	 dTz/qnm6b8vNDIaeXTKMq/6aJ/zmzswGhg9tN/9S+JkVmCaIi2SVznVzRjr2kMSFVc
	 dvYEZxPV39S4SwxsQSiyqgRz5cYdUfWaKay5Xm5PBJO/mdh3bgJH4QFCL+PmIl3tNt
	 o6A6XQZTj+aF8uWzWhWVQgqVRb6tjeSxW++yOxsqdIbYzZrvwy4GrCJS4bqn44KCbR
	 SdgPw8CLmKZzg==
Received: from [192.168.72.171] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8CE156C643;
	Mon,  9 Dec 2024 14:16:32 +0800 (AWST)
Message-ID: <96efebff0479a48a3a577f236fff659387f29c4e.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next] mctp: no longer rely on net->dev_index_head[]
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	eric.dumazet@gmail.com, Matt Johnston <matt@codeconstruct.com.au>, Kuniyuki
	Iwashima <kuniyu@amazon.com>
Date: Mon, 09 Dec 2024 14:16:32 +0800
In-Reply-To: <20241206223811.1343076-1-edumazet@google.com>
References: <20241206223811.1343076-1-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Eric,

> mctp_dump_addrinfo() is one of the last users of
> net->dev_index_head[] in the control path.
>=20
> Switch to for_each_netdev_dump() for better scalability.
>=20
> Use C99 for mctp_device_rtnl_msg_handlers[] to prepare
> future RTNL removal from mctp_dump_addrinfo()

Nice one, thanks for this. All looks good testing the RTM_GETADDR dump
using the usual tools.

Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>

Cheers,


Jeremy

