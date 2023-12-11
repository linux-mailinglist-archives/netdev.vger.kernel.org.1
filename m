Return-Path: <netdev+bounces-56144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C034580DF87
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 00:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB889B211A0
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FA756762;
	Mon, 11 Dec 2023 23:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScKffoZK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF2656474;
	Mon, 11 Dec 2023 23:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05D1C433C8;
	Mon, 11 Dec 2023 23:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702337530;
	bh=dyaQf9Q18rWZhluPvQPLmi22lq8IE/bEvHJE3Sm+87s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ScKffoZKXmUwDG7/QeNhMSBdavQtJZHuTx/PjXlvCKwqB0tHODY5+4vCqB6Q6jfsK
	 d845nxcEAMwJ62ZH++MQ4GZaqf84eeR927ZRl68glOM8W8rbfsZHmbTWm2q4vcG3MF
	 Ua/nGd3vB6CnjlvaFdHZBbctd8TIziY2C57AcVx5BFZDYrF2YCH3S/jfJWURuy7EGX
	 tFBwXdaEEZtfgELKq5d9MHZiOpfe1rNnjYspRIQ3o1IB29mC3BAaCw7UjIMkPBxScL
	 rDkCduRAan4UG+C9eNNAZNrXZva+kXqoIhMBp35AoukCHJ0rhotKUtTbilqnQ3YuET
	 IIbd98cgIxxfw==
Date: Mon, 11 Dec 2023 15:32:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 00/11] tools/net/ynl: Add 'sub-message'
 support to ynl
Message-ID: <20231211153209.2d526d99@kernel.org>
In-Reply-To: <20231211164039.83034-1-donald.hunter@gmail.com>
References: <20231211164039.83034-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 16:40:28 +0000 Donald Hunter wrote:
> This patchset adds a 'sub-message' attribute type to the netlink-raw
> schema and implements it in ynl. This provides support for kind-specific
> options attributes as used in rt_link and tc raw netlink families.
> 
> A description of the new 'sub-message' attribute type and the
> corresponding sub-message definitions is provided in patch 5.
> 
> The patchset includes updates to the rt_link spec and a new tc spec that
> make use of the new 'sub-message' attribute type.
> 
> As mentioned in patch 7, encode support is not yet implemented in ynl
> and support for sub-message selectors at a different nest level from the
> key attribute is not yet supported. I plan to work on these in folloup
> patches.

Seems to break C codegen:

Traceback (most recent call last):
  File "net-next/tools/net/ynl/ynl-gen-c.py", line 2802, in <module>
    main()
  File "net-next/tools/net/ynl/ynl-gen-c.py", line 2531, in main
    parsed = Family(args.spec, exclude_ops)
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "net-next/tools/net/ynl/ynl-gen-c.py", line 889, in __init__
    super().__init__(file_name, exclude_ops=exclude_ops)
  File "net-next/tools/net/ynl/lib/nlspec.py", line 481, in __init__
    raise last_exception
  File "net-next/tools/net/ynl/lib/nlspec.py", line 472, in __init__
    elem.resolve()
  File "net-next/tools/net/ynl/ynl-gen-c.py", line 907, in resolve
    self.resolve_up(super())
  File "net-next/tools/net/ynl/lib/nlspec.py", line 53, in resolve_up
    up.resolve()
  File "net-next/tools/net/ynl/lib/nlspec.py", line 583, in resolve
    for elem in self.yaml['sub-messages']:
                ~~~~~~~~~^^^^^^^^^^^^^^^^

