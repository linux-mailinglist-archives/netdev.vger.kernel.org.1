Return-Path: <netdev+bounces-151061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EB79EC9E4
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 11:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6E21882787
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 10:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D31C8489;
	Wed, 11 Dec 2024 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uQEbUnaz"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BECB236FAA
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733911332; cv=none; b=MZ9LykIp1JSS6S4l5V/W2KZELGTtiguDkskzW3EgHQccRnGJb8CsLMi1oegZJnEDlBMEnAxR3nj8Gzyhz0Cr7ReBsXaeOF78oPGDJiLiUYHL7wzT9cpwQwZY3wrC61KBDYKnSj2SvHAcLQ8p3eKlvgJSeAzQuOXN+pjXF4JjjfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733911332; c=relaxed/simple;
	bh=Dut1NhVxVHSy/Ur7XDadQQlvvZTNCqRf9cylHsZK7ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXM4O3fifTz8v1X3E0gPRgtJRa6509IW+toxVdW7R26ReXt8nFbUidclD0QSihlA0vUSqNMvaqGTO028+MlqdqfvHsuAHyZOnFw79XFUyjHjHPXmSOcYz1j9lMcU8OD25TeKQ6Q78QGGlHwyBaLd10Z1kdvVfvwuOS1tEZcxBSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uQEbUnaz; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 081C72540224;
	Wed, 11 Dec 2024 05:02:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 11 Dec 2024 05:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733911328; x=1733997728; bh=csUAyW/GabKpNjwNH03rm+A8M4jUj03HMJL
	U/3eUnOU=; b=uQEbUnazMVaMM9JRXjtIQ8aBm9oILTaOra8lh8p+U9w1eccbZf8
	EN9sw6oH3+YQzS5eyQBvGaPx4EOIvzY7Und1cQz4TwddRJ0aZ90w7sMpI4qSZTH2
	W9dFH5i+Axjlg/aiQ1LyZFJ/M31R/Uzd+ZNBB+Xc0IK2IEym25bATcJpx26mPAEF
	ZmuUi7EGwhy0JPFfmsF/ObC2dh1JgYS5leqnLowqnv+SGuIQnvggZfsYeS5iR+Q6
	oc9Fm7rSFiy8CvEnBwEV43PrtEGZLiIBpD1d2CA3CrzW936BDjw0K2IR5vtVQPXY
	6jq1SbXrXT8YasP2JH0Iz37g2m4Bq4onWTQ==
X-ME-Sender: <xms:H2NZZ47X6z6ZxIn4X-WuzNLCf270MIW4qOegGwQDozTaZBUyT9Shaw>
    <xme:H2NZZ5538tA4hdtGMudolehalope1vSDxl2Yn0jf-kA-VelNuEklt3pq5cmw0nu4u
    suTa8WbpFROU1o>
X-ME-Received: <xmr:H2NZZ3c6vQ80i3hxTUZyb-m_XKFzBHyJ_z0t4gUs2ARQtTF4YMeULR33MeTFA_qP6h433pkI5Vcfia0sDcst5NPmV-E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorh
    hgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefg
    leekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthho
    peejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhnrggvmhgvshgvnhihih
    hrihesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehfvghjvghssehinhhfrdgvlhhtvgdrhhhupdhrtg
    hpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgs
    rgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtg
    homhdprhgtphhtthhopeifihhllhgvmhgssehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:H2NZZ9I6sBIZ-2iqfjfTVt7GfwCCwaBDBaLiDYPe8-37_60OSRmmvw>
    <xmx:H2NZZ8J7vdt8Yzbkgmyhp8BDWDqPKXrK3dRzGQQasZPjnqUSr5ZxkA>
    <xmx:H2NZZ-yZnKACAnuXXnA2F99lNXY0ozvNxsWLO7hElZJk4JR_RLfMZw>
    <xmx:H2NZZwIjJRVP1lB2dA9B9ndq8e-2aeMlemW6ED5LBguHVawgxPl2Bw>
    <xmx:IGNZZ088VmnxBEuix03XN5xImhHQpI78olybXhmcc8Oz8ZO8yua9ztOE>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Dec 2024 05:02:01 -0500 (EST)
Date: Wed, 11 Dec 2024 12:01:58 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>
Cc: netdev@vger.kernel.org, fejes@inf.elte.hu, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com
Subject: Re: [PATCH net-next v6 3/4] selftests: net: test SO_PRIORITY
 ancillary data with cmsg_sender
Message-ID: <Z1ljFkEk3jZHRGl3@shredder>
References: <20241210191309.8681-1-annaemesenyiri@gmail.com>
 <20241210191309.8681-4-annaemesenyiri@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210191309.8681-4-annaemesenyiri@gmail.com>

On Tue, Dec 10, 2024 at 08:13:08PM +0100, Anna Emese Nyiri wrote:
> Extend cmsg_sender.c with a new option '-Q' to send SO_PRIORITY
> ancillary data.
> 
> cmsg_so_priority.sh script added to validate SO_PRIORITY behavior 
> by creating VLAN device with egress QoS mapping and testing packet
> priorities using flower filters. Verify that packets with different
> priorities are correctly matched and counted by filters for multiple
> protocols and IP versions.
> 
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

Few nits that you can address in a follow up

> @@ -252,6 +259,8 @@ cs_write_cmsg(int fd, struct msghdr *msg, char *cbuf, size_t cbuf_sz)
>  
>  	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
>  			  SOL_SOCKET, SO_MARK, &opt.mark);
> +	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
> +			SOL_SOCKET, SO_PRIORITY, &opt.priority);

Need to align to the open parenthesis

>  	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
>  			  SOL_IPV6, IPV6_DONTFRAG, &opt.v6.dontfrag);
>  	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
> diff --git a/tools/testing/selftests/net/cmsg_so_priority.sh b/tools/testing/selftests/net/cmsg_so_priority.sh
> new file mode 100755
> index 000000000000..1fdfe6939a97
> --- /dev/null
> +++ b/tools/testing/selftests/net/cmsg_so_priority.sh

[...]

> +fi
> +

Unnecessary blank line:

Applying: selftests: net: test SO_PRIORITY ancillary data with cmsg_sender
.git/rebase-apply/patch:228: new blank line at EOF.
+
warning: 1 line adds whitespace errors.

