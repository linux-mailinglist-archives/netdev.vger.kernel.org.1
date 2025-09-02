Return-Path: <netdev+bounces-219380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DF4B41106
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20E970016F
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2945C2EAB6B;
	Tue,  2 Sep 2025 23:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENI/H6yY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AC82EA72B;
	Tue,  2 Sep 2025 23:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756857268; cv=none; b=Q0BcSOCC7AWioJAfBZJcq61ZUCsFQRYo4t64NZKKFudA2uF3wW+YAbZucO6XXY9QcwNTtmQFwl1RpWMq0JjdTuXig8g096Cn0zc4L7yfwmbltQLh7gAJsiRMLOhfDnXHF9xZJJ2PHkmyPGLFbpI6GhU2URuWOOduP30+DhG8vdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756857268; c=relaxed/simple;
	bh=/HzkzVw/sf8/Kz6qLXNOLv8z0OEtNS0Fgza/c2GFMao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EnW0S1dshEC9RXRrSbY00AN2yR4hOxoUqePjfwiMtTSe2nluzW+U7Uy5gYXChqsi0qeifBQ+Qb8PSyNQKTnoqM6s7nFLBC13WNl7gUUSx7sX21uY0r0LcoIoGYc0AjBFaNB9Cw3v8a7upcvpqHgiACBNaAKq7XMFvgQvatNtEms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENI/H6yY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D95C4CEED;
	Tue,  2 Sep 2025 23:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756857267;
	bh=/HzkzVw/sf8/Kz6qLXNOLv8z0OEtNS0Fgza/c2GFMao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ENI/H6yYT8CCs9f3TtPOE46g0RwCmIbiW0K2aCH6zoPAQHI2nqeVm+nW4mkp8lh57
	 W50SQ897Fxq7XMud3xiiy7wJgF/8lJH7nwhx6WbyXo+lwtiJx56MJlyGTT29A+VyBZ
	 ubOBbYe2dn8nAn6nnBfmHKO6v8/eaB+kYWCHZvIe2MFEUnAb4k9REX+ZYLgYw+fR8V
	 JEC+bV1r/7rIMGI2TeMbTCAZsMWi+ziWyle4vzIHk52MxV43GHtGfn22SOxrc1vVB4
	 jhD7y8ieKomAwYhRYDtIzBxrUjaxq8YlUyjhgbjem1z2MR2GLDpaWkcCCT1pxOj2Vs
	 hLWawdQOiyBkw==
Date: Tue, 2 Sep 2025 16:54:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, david decotigny <decot@googlers.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 stable@vger.kernel.org, jv@jvosburgh.net
Subject: Re: [PATCH net] netpoll: fix incorrect refcount handling causing
 incorrect cleanup
Message-ID: <20250902165426.6d6cd172@kernel.org>
In-Reply-To: <20250901-netpoll_memleak-v1-1-34a181977dfc@debian.org>
References: <20250901-netpoll_memleak-v1-1-34a181977dfc@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 01 Sep 2025 07:29:13 -0700 Breno Leitao wrote:
> I have a selftest that shows the memory leak when kmemleak is enabled
> and I will be submitting to net-next.
> 
> Also, giving I am reverting commit efa95b01da18 ("netpoll: fix use
> after free"), which was supposed to fix a problem on bonding, I am
> copying Jay.

Please post them together. It looks like there may be more bugs here.
-- 
pw-bot: cr

