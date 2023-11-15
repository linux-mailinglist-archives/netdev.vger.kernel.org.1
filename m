Return-Path: <netdev+bounces-47940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741717EC05D
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 11:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF4D1C204BF
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 10:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A396AD6;
	Wed, 15 Nov 2023 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzRN+vhe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AC7E555
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 10:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AA3C433C7;
	Wed, 15 Nov 2023 10:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700043789;
	bh=DWYELWdhnmyOJkCXuhTFzSkejMRb7zklpUwmxG2CRGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lzRN+vhe015zWHPFTdSqu5jvlbLrYQk4W6HYXNX3lzL9UlQl9yMZnsFuthl1oCQKs
	 SAhdmhbkrlNg7hi6myCW/MdrNIRLKqh/eiSsy8tdKOSWkULpjoAnj1VqRqQd9PcZ/5
	 hxWaj4cc9mi6WOLzHLWW62YuvN8/N/77X6ABaFZSq3pBxQO+E6wrIGo1HWlJkhqet6
	 LTGWIUZnVlvzd0k0bX/r3r1Xl7off4Bl3qodZT7RAhnZ2nP7q69fGq2akd7I1T3qXS
	 sA+/QN6h6piiEBXfW5/HkRMLV/NVUmtrPrsrkEd4xxJHDdd1OjEoqwOgPmqDEp4NtT
	 63TsJhLhX/yxA==
Date: Wed, 15 Nov 2023 10:23:04 +0000
From: Simon Horman <horms@kernel.org>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Paolo Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, dust.li@linux.alibaba.com,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] s390/ism: ism driver implies smc protocol
Message-ID: <20231115102304.GN74656@kernel.org>
References: <b152ec7c0e690027da1086b777a3ec512001ba1f.camel@linux.ibm.com>
 <20231114091718.3482624-1-gbayer@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114091718.3482624-1-gbayer@linux.ibm.com>

On Tue, Nov 14, 2023 at 10:17:18AM +0100, Gerd Bayer wrote:
> Since commit a72178cfe855 ("net/smc: Fix dependency of SMC on ISM")
> you can build the ism code without selecting the SMC network protocol.
> That leaves some ism functions be reported as unused. Move these
> functions under the conditional compile with CONFIG_SMC.
> 
> Also codify the suggestion to also configure the SMC protocol in ism's
> Kconfig - but with an "imply" rather than a "select" as SMC depends on
> other config options and allow for a deliberate decision not to build
> SMC. Also, mention that in ISM's help.
> 
> Fixes: a72178cfe855 ("net/smc: Fix dependency of SMC on ISM")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/netdev/afd142a2-1fa0-46b9-8b2d-7652d41d3ab8@infradead.org/
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

Hi Gerd,

In a similar vein, I am wondering if the forward declaration of ism_ops
could be removed.  In my very light compile test it shows up as unused when
CONFIG_SMC is unset.

