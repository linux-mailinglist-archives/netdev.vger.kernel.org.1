Return-Path: <netdev+bounces-15231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 915C4746379
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 21:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD0F1C20A27
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 19:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279FB111B3;
	Mon,  3 Jul 2023 19:44:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF7A100D9
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 19:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5F9C433C7;
	Mon,  3 Jul 2023 19:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688413468;
	bh=JhZb50vovyTnsLJREDIpXMbd3ET0Yiy5SJpuD7Hpuzo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fyYi2ewwMB5oM4c2XuxPDW769rz8FoMqEAXWFv0RHga4P7/zGbWzhBx/DubmJ090q
	 btmsEQyWKNnJPwyWP2SNNoBZle+lBO+8mSQwsynjbU38tlE1qwEHHJvp9PXcYH0n2W
	 fns1Qp5NpZq7LtAuc1mJZfafrIgMfKR4O4wa8USG3wnK+Ii8iyb/7WOUrCfG5/EOTD
	 usf6jQKU86toUKUlf8wcqwNFyR+udfuYDylrlwB66iU3hD9hOd/zl16UrrdbBEzUsc
	 yTp5lsVPQBFGLC/18U6i0cFvFvud7cmRmAoNYHp1D5tpkTxH23kEc779xuN6S3KRuA
	 BWsfmG1FCQipA==
Date: Mon, 3 Jul 2023 12:44:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: leitao@debian.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 sergey.senozhatsky@gmail.com, pmladek@suse.com, tj@kernel.or, Dave Jones
 <davej@codemonkey.org.uk>, netdev@vger.kernel.org (open list:NETWORKING
 DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] netconsole: Append kernel version to message
Message-ID: <20230703124427.228f7a9e@kernel.org>
In-Reply-To: <20230703154155.3460313-1-leitao@debian.org>
References: <20230703154155.3460313-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Jul 2023 08:41:54 -0700 leitao@debian.org wrote:
> +	uname = init_utsname()->release;
> +
> +	newmsg = kasprintf(GFP_KERNEL, "%s;%s", uname, msg);
> +	if (!newmsg)
> +		/* In case of ENOMEM, just ignore this entry */
> +		return;
> +	newlen = strlen(uname) + len + 1;
> +
> +	send_ext_msg_udp(nt, newmsg, newlen);
> +
> +	kfree(newmsg);

You can avoid the memory allocation by putting this code into
send_ext_msg_udp(), I reckon? There's already a buffer there.
-- 
pw-bot: cr

