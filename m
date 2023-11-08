Return-Path: <netdev+bounces-46698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F05E97E5F22
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 21:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA51228140B
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 20:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100913716F;
	Wed,  8 Nov 2023 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="PFmhlbFm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCCC30FAF;
	Wed,  8 Nov 2023 20:27:30 +0000 (UTC)
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4FB2126;
	Wed,  8 Nov 2023 12:27:29 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 30E3377D;
	Wed,  8 Nov 2023 20:27:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 30E3377D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1699475249; bh=lcpu4lqmDmvaxi98wOh6OW+as9ZncysjkXCYXHMXnNI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PFmhlbFmAJfzKQZ548sHjF5Hm1esnwtzv3TtqDzvBVoF59MY5fgzvrXPke6BXtnJp
	 mZE8INxabP9CzQ7aFFqFWIf7t7wN8Upq8gNaXpMJGTIkQlouhxvUdH2jEdunk+CIn8
	 JHWZez339Snxrs9OS5ocGX/HUjgzAy5VNiqx9c5VU/lu//SJeMAVguaPX4sdao82nW
	 BcDfU3v/I+ZJ8x+N5EL3GTw1hbH0FYZhG8sP2vTu3j1LDrFDLk5yO2eU2v9F+X+0kd
	 z7Kg6bTHy+xbZ+H4QDin+MSLfVHwB9ASAC6kQDO6Az0JMvB1mCNDkA0WwFAKvcQ9oE
	 uCbvFv9x+pYbA==
From: Jonathan Corbet <corbet@lwn.net>
To: Breno Leitao <leitao@debian.org>
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH] Documentation: Document the Netlink spec
In-Reply-To: <20231103135622.250314-1-leitao@debian.org>
References: <20231103135622.250314-1-leitao@debian.org>
Date: Wed, 08 Nov 2023 13:27:28 -0700
Message-ID: <875y2cxa6n.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Breno Leitao <leitao@debian.org> writes:

> This is a Sphinx extension that parses the Netlink YAML spec files
> (Documentation/netlink/specs/), and generates a rst file to be
> displayed into Documentation pages.
>
> Create a new Documentation/networking/netlink_spec page, and a sub-page
> for each Netlink spec that needs to be documented, such as ethtool,
> devlink, netdev, etc.
>
> Create a Sphinx directive extension that reads the YAML spec
> (located under Documentation/netlink/specs), parses it and returns a RST
> string that is inserted where the Sphinx directive was called.

So I finally had a chance to look a bit at this; I have a few
impressions.

First of all, if you put something silly into one of the YAML files, it
kills the whole docs build, which is ... not desirable:

> Exception occurred:
>   File "/usr/lib64/python3.11/site-packages/yaml/scanner.py", line 577, in fetch_value
>     raise ScannerError(None, None,
> yaml.scanner.ScannerError: mapping values are not allowed here
>   in "/stuff/k/git/kernel/Documentation/netlink/specs/ovs_datapath.yaml", line 14, column 9
> 

That error needs to be caught and handled in some more graceful way.

I do have to wonder, though, whether a sphinx extension is the right way
to solve this problem.  You're essentially implementing a filter that
turns one YAML file into one RST file; might it be better to keep that
outside of sphinx as a standalone script, invoked by the Makefile?

Note that I'm asking because I wonder, I'm not saying I would block an
extension-based implementation.

Thanks,

jon

