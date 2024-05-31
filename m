Return-Path: <netdev+bounces-99599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AACA8D56F4
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 02:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C5B2872D7
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 00:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB027360;
	Fri, 31 May 2024 00:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apNRvaXX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F974A32
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 00:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717115605; cv=none; b=m9TfH1mc7N3IjtiBRxg6oNxk/1Sxiy+FWLCjMufUMtxjnkKuOZqcVpnbZUh5CoF9zI/N40UBvHcIAVj+gN5iMJw+hzpU6cwIo7mG4CU5tZQ0LOjoelnZyxsJ3jUehS7XdtkznO5kISrQ4zMXB9KEYmz1HN12zHNin8H1At+lltY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717115605; c=relaxed/simple;
	bh=D95IV3NhWEB2yX+ShrdmQ9V0xhZkwGaB1P/AdxInIlc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcSupCql3OfByLuPxmo/1gyA8+HPSaQ7x7fT6YBvbRWj96yhJQUdXnri5ShwofghHUM9LsrJaUbFNoZi9zkzn3ZUymSoEqfkSyfSqZ9rGwexsDAbQJE20CJsbrq/Qxi34m2pXW+tA9zsNpfmQaBszsiUm1o+1f8DA/2NAR+g3s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apNRvaXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1352CC2BBFC;
	Fri, 31 May 2024 00:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717115605;
	bh=D95IV3NhWEB2yX+ShrdmQ9V0xhZkwGaB1P/AdxInIlc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=apNRvaXXO+KLap2TLr8OwaG2gho0yzsed6dWuEiI3vmvAHl3zVkqtKnRwxKYgThPk
	 7K9fRf2jb/ZVL6hzBANEaahfEomEUkC00cF6ck9gzgm1wKjrP6ORBURVT5xRn9W/XB
	 1AcdaPWyPYVyFMXSvG68TllM7mTMSKo9ewbzT/QPwPLPmafDXh8AUSW/zJLgtOwEyc
	 wTc/j6qBSeQEOsco3zMY4z4F8rwR5+VBf/yp/AzaPOIg5zc+9LC8qOWjOgyVZfW/Xv
	 gu3jvToebMUCB8OJBXfgbIV9GepqmMVRhzggyLEOH6OLl1YSg1wCTBNXR2lHmJzIpN
	 p9RlUzs0YOGzg==
Date: Thu, 30 May 2024 17:33:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: netdev@vger.kernel.org, Igor Raits <igor@gooddata.com>, Daniel Secik
 <daniel.secik@gooddata.com>, Zdenek Pesek <zdenek.pesek@gooddata.com>
Subject: Re: [regresion] Dell's OMSA Systems Management Data Engine stuck
 after update from 6.8.y to 6.9.y (with bisecting)
Message-ID: <20240530173324.378acb1f@kernel.org>
In-Reply-To: <CAK8fFZ7MKoFSEzMBDAOjoUt+vTZRRQgLDNXEOfdCCXSoXXKE0g@mail.gmail.com>
References: <CAK8fFZ7MKoFSEzMBDAOjoUt+vTZRRQgLDNXEOfdCCXSoXXKE0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 09:52:38 +0200 Jaroslav Pulchart wrote:
> However, reverting just the "use xarray iterator to implement
> rtnl_dump_ifinfo" change did not resolve the issue. Do you have any
> suggestions on what to try next and how to fix it?

The daemon must have rolled its own netlink parsing.

Could you try this?

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 96accde527da..5fd06473ddd9 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1912,6 +1912,8 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 			goto done;
 	}
 done:
+	if (err == -EMSGSIZE && likely(skb->len))
+		err = skb->len;
 	if (fillargs.netnsid >= 0)
 		put_net(tgt_net);
 	rcu_read_unlock();

