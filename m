Return-Path: <netdev+bounces-29013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7997E781676
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 03:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33045281D6C
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 01:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ECF634;
	Sat, 19 Aug 2023 01:46:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DD67E4
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 01:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5D4C433C7;
	Sat, 19 Aug 2023 01:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692409609;
	bh=4aZ+zC6/s4isGMHOIFZxl3OM7a+uB6FHX+BHCSXvwsQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ijRBIHnvFNZziKaDwTz8K6lVRzSDvlMkmwnc6eWlBOcrc0lcP+j+ZX42OQs2YHw/0
	 zwO3EyCBwxUNSe4ylABUhWDjNO0BLc9Uos5YS7GMP9LFUeULcL/OKsSLM4P7RAyK2P
	 QI9l+Ehwk3zc8Gt9yITXAamSx3rjnRydvrVoqRloDv55ev2+W2lgVrMY2u44IsOJg3
	 4+V5S3Yy7TOEuEn8T9iAZ4Vu9aOL1K9lQco9tZOxLLFJ1szIt909uJQNVIRVt2blbz
	 kG7LtAxBIrXapgm2+Ylpu5Ha0aFk5g56Fy74/SZb3szJnQQlxsK28kIaBk3MspSdrP
	 YbjCh3eUnUyuQ==
Date: Fri, 18 Aug 2023 18:46:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Scott Dial <scott@scottdial.com>
Subject: Re: [PATCH net-next] macsec: introduce default_async_crypto sysctl
Message-ID: <20230818184648.127b2ccf@kernel.org>
In-Reply-To: <9328d206c5d9f9239cae27e62e74de40b258471d.1692279161.git.sd@queasysnail.net>
References: <9328d206c5d9f9239cae27e62e74de40b258471d.1692279161.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Aug 2023 17:07:03 +0200 Sabrina Dubroca wrote:
> Commit ab046a5d4be4 ("net: macsec: preserve ingress frame ordering")
> tried to solve an issue caused by MACsec's use of asynchronous crypto
> operations, but introduced a large performance regression in cases
> where async crypto isn't causing reordering of packets.
> 
> This patch introduces a per-netns sysctl that administrators can set
> to allow new SAs to use async crypto, such as aesni. Existing SAs
> won't be modified.
> 
> By setting default_async_crypto=1 and reconfiguring macsec, a single
> netperf instance jumps from 1.4Gbps to 4.4Gbps.

Can we not fix the ordering problem?
Queue the packets locally if they get out of order?

