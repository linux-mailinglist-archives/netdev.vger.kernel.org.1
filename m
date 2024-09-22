Return-Path: <netdev+bounces-129194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D7897E2A7
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 19:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62B26B21166
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 17:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0392B9A1;
	Sun, 22 Sep 2024 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjezbULS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828B92AEFC;
	Sun, 22 Sep 2024 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727024899; cv=none; b=IYi+L+eApRRWMimK0S5TNY1yNyla+/ymT6/Wme+7SUXZvPq/4BVvIFaOHbSNx57SYQ0n1O30Yeym9Y9f5b26BI9rokU/8zdkka6qYqjm4qeexZvLdtRbRZSjn6+KukpIbBI6VpeG5ZudLBydRqtgM1YdngPhdmV1KBodwxTudks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727024899; c=relaxed/simple;
	bh=kadefyW4xflqn3+lS+RNRI2zmfP1nPl+qO/iqN2/xcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nK6OVRuYO1y8T2kNRoVi3S+DtXBDZZ6Wm0Yh53z8ymyZ6MYg/XGQUpSO61XLi3V84Y/5wJcAq4a2NR1A4mQmwMmRQEiVgkPQjpphOB/lREx7xLeijunZxMAVmi8hKsaJFt+eXjdj1zXqfNselEoh4S1srkgv2a8yQJNEGv+AMD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjezbULS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8BDC4CEC3;
	Sun, 22 Sep 2024 17:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727024899;
	bh=kadefyW4xflqn3+lS+RNRI2zmfP1nPl+qO/iqN2/xcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bjezbULS1wB/4SSlIDBN25u70vDwPdKTT/f5jD/vGrDOv7BApMqCTeUrBQTlnKu/C
	 sIc2KGV1QEGTPRgnALMZXOGHxgUnvYa/WIndbYH68CQ6aN6JooCSi55b9ORFKhr8F4
	 HV06P9w6djaE6yuZpKFchgMoXMIMWpKdhVsaJDnvXZS27701B/3rYUpoSqiiA+ClXL
	 +SubP87Owne6PQtjb9GK6/SQYPZvBwQ7aKotKsof+daX6D4rU+YR+T//e4UprFNAaH
	 YZGeXikpq9UZGt4dGOYOQYVrUiozCd0xQPF26lVXFmeFh2L+5G/n6RxA8j231cSpY+
	 gJBTxawEiniEA==
Date: Sun, 22 Sep 2024 18:08:11 +0100
From: Simon Horman <horms@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Nick Child <nnac123@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Yasuaki Ishimatsu <yasu.isimatu@gmail.com>
Subject: Re: [PATCH] net: fjes: Refactor a string comparison in
 is_extended_socket_device()
Message-ID: <20240922170811.GE3426578@kernel.org>
References: <9ec752a8-49e9-40fd-8ed9-fed29d53f37b@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ec752a8-49e9-40fd-8ed9-fed29d53f37b@web.de>

On Fri, Sep 20, 2024 at 02:24:50PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 20 Sep 2024 13:56:44 +0200
> 
> Assign the return value from a strncmp() call to a local variable
> so that an if statement can be omitted accordingly.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Hi Markus,

This is an old driver, that doesn't appear to have been under active
development for quite some time.  And I don't think that clean-ups of this
nature are worth the risk of regressions they might introduce.

If we can see bugs, let's fix them.
Else, let's leave it be.

-- 
pw-bot: rejected

