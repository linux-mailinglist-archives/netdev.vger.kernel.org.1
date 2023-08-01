Return-Path: <netdev+bounces-22990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB23E76A557
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 02:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8A4281640
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 00:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65ABE371;
	Tue,  1 Aug 2023 00:13:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4012936C
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 00:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FB1C433C8;
	Tue,  1 Aug 2023 00:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690848789;
	bh=ZI8yCDIeNTkfQnlmd6B5kwP+4TBnwO5nvgTxFD9jz2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CUznKra0eYFImTKweLzmwwIhuLwvF0ouZEMbrWqc0ARFBqd7Rqg/2C3Z+QrLbuEFQ
	 XxPyG1dOEA4Pl9gQWE4JMKz4OLoA1XdajwOVzqv3S/XqUCzeA2ZeKtZl4jdfc7Da8+
	 XPylBtXE31VaOsqxbWQ0rT6jyZ98prL7xEvk2ygw7nIj+T6tXcJY/TKexDPnKgP91o
	 hSMxnDkFCcqxQoc4nXGvcVLfoVR+tY78BFj922PE3uABlG8A9rwtFmrvZnP9onmvul
	 nLY0zzSB4jxyEIlq8oRzsWpmIj/cpIXptXe7fU+fYZrOLnqmlIZPStKJ84i4I5xvAX
	 DkS+4zNgn3ljQ==
Date: Mon, 31 Jul 2023 17:13:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>,
 <sridhar.samudrala@intel.com>
Subject: Re: [net-next PATCH v1 3/9] netdev-genl: spec: Extend netdev
 netlink spec in YAML for NAPI
Message-ID: <20230731171308.230bf737@kernel.org>
In-Reply-To: <6cb18abe-89aa-a8a8-a7e1-8856acaaef64@intel.com>
References: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
	<169059162756.3736.16797255590375805440.stgit@anambiarhost.jf.intel.com>
	<20230731123651.45b33c89@kernel.org>
	<6cb18abe-89aa-a8a8-a7e1-8856acaaef64@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Jul 2023 16:12:23 -0700 Nambiar, Amritha wrote:
> > Every NAPI instance should be dumped as a separate object. We can
> > implemented filtered dump to get NAPIs of a single netdev.
> 
> Today, the 'do napi-get <ifindex>' will show all the NAPIs for a single 
> netdev:
> Example: --do napi-get --json='{"ifindex": 6}'
> 
> and the 'dump napi-get' will dump all the NAPIs for all the netdevs.
> Example: netdev.yaml  --dump napi-get
> 
> Are you suggesting that we also dump each NAPI instance individually,
> 'do napi-get <ifindex> <NAPI_ID>'
> 
> Example:
> netdev.yaml  --do napi-get --json='{"ifindex": 6, "napi-id": 390}'
> 
> [{'ifindex': 6},
>   {'napi-info': [{'irq': 296,
>                   'napi-id': 390,
>                   'pid': 3475,
>                   'rx-queues': [5],
>                   'tx-queues': [5]}]}]

Dumps can be filtered, I'm saying:

$ netdev.yaml --dump napi-get --json='{"ifindex": 6}'
                ^^^^

[{'napi-id': 390, 'ifindex': 6, 'irq': 296, ...},
 {'napi-id': 391, 'ifindex': 6, 'irq': 297, ...}]

