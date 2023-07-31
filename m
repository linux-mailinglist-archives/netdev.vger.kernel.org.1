Return-Path: <netdev+bounces-22945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F25976A248
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 22:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1431C20D0F
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 20:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A951DDF0;
	Mon, 31 Jul 2023 20:58:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7821DDD1
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 20:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261EDC433C7;
	Mon, 31 Jul 2023 20:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690837135;
	bh=r5eukuyVDYrGLrNULe36nyXrnyzoReTEKShm4Q8CiuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dCt+PG6O2oxSwfiG6ExP2KO9J0t7rdhKRbVUFewtDhwE1LAbAJYzX8EWR1LE2sh5v
	 gHgaCR6zrK9ZpYFSVVdvhgFH3L1P5+2jCytQ/okSBzgjGy9vXGKQxitU4tXzmNbOdj
	 jZWkd+WUc52ICEK1F1IxEl/IYq1/8lpqRP3dC6XsISK73poSKpXKv0KvyRFCgYK0pC
	 pm3JbaSFAUp3kTofXmIy5P1FVJljLXcs0BCO10yATOYNONfHqyrwxvaYcbu3u5afsD
	 MYvOX4PwewYY7bpkwaEU3NOYYI+HRnSKb+octG2CFPrIAuzcwhebDg1PLOI0Mjx9Qx
	 Xnvlml+b5BgKQ==
Date: Mon, 31 Jul 2023 13:58:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tahsin Erdogan <trdgn@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tun: avoid high-order page allocation for packet header
Message-ID: <20230731135854.3628918b@kernel.org>
In-Reply-To: <20230726030936.1587269-1-trdgn@amazon.com>
References: <20230726030936.1587269-1-trdgn@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 20:09:36 -0700 Tahsin Erdogan wrote:
> @@ -1838,6 +1838,9 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  			 */
>  			zerocopy = false;
>  		} else {
> +			if (linear == 0)
> +				linear = min_t(size_t, good_linear, copylen);

nit: would you mind changing to !linear instead of linear == 0 ?

Also - I don't see linear explicitly getting set to 0. What guarantees
that? What's the story there?

Otherwise seems reasonable. One more allocation but hopefully nobody
will notice.
-- 
pw-bot: cr

