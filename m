Return-Path: <netdev+bounces-157889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE1AA0C2C9
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 21:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB513A618C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 20:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF2F1CACF3;
	Mon, 13 Jan 2025 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlgXUscg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CF61C1AAA;
	Mon, 13 Jan 2025 20:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736801554; cv=none; b=iMQnJajfbbKokSItsLID/39VyIE6gOsQ/rqLWD7jOFxhX4xBzKsxwkjPrH8pn6I5fomnfLQ+u7zUJXDo+paHkgI9LKtFR40ccOF87HAn7jYz9iPVWCBAXZJy0VzUyRjOnS2EZpD6SCFE3r4I7vwLJIy466M84eYUR0/HrAnPt2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736801554; c=relaxed/simple;
	bh=JrJ/Ggv3NBm2XTLpZlcnzCagHej0Z7X9iX5HTrzFh3I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9X1l8YIP5jo91Lfidr1xM43QIiSoDINKVTlkN7vQYKF10plR71MAxXzlfVJcmfHYXq8blri/K39DXPnKO4I6IW8j+aVRItxytvaui9uJLMyQhoB+EfhIeDClfyt9RqvjZmZSDqO4thBYn6a6YxVlgQjxKSXtr+CXfzOLU43cn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlgXUscg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760FBC4CEDD;
	Mon, 13 Jan 2025 20:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736801553;
	bh=JrJ/Ggv3NBm2XTLpZlcnzCagHej0Z7X9iX5HTrzFh3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WlgXUscgeMq+UuMPqB78BhlTb1HF/SzReLO/Zcm2YhPMJpRxZA6x5PxLvFmpze3KF
	 AeIj9szMnZfJmr+ApAFVn5eU4oPpUpu3qBWrgeSMY950ByniXD0ktk8C1KDwFnymSj
	 PXMGwrcUImzYpv9mXU+jJpgCopqA6zgrIhzur76DbuWsS17ikXUIZfkMARe4bFllHz
	 i+5f7yMUO0yTwggDV/e0+j+9WRDS1IEY7oDOv7veMt41N0TNDetgrZLrjhVWD1h9PM
	 N9lDpl+AQAU55aIFHSms2eHcsGeOJI+MFo+SMbQI7+ZrKVatNcKKWDw4pjOkn2t1v1
	 SW+msKx6B0JyA==
Date: Mon, 13 Jan 2025 12:52:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Foster Snowhill <forst@pen.gy>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Georgi Valkov
 <gvalkov@gmail.com>, Simon Horman <horms@kernel.org>, Oliver Neukum
 <oneukum@suse.com>, netdev@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH net v4 0/7] usbnet: ipheth: prevent OoB reads of NDP16
Message-ID: <20250113125232.733fb088@kernel.org>
In-Reply-To: <e587e1c7-a2ff-4e28-9e25-b57f68545134@pen.gy>
References: <20250105010121.12546-1-forst@pen.gy>
	<dkrN8SbAXULmhNyPVFbHHs81wY3NqXPW7EVHB7o56ZQOvuzVkCH6ge0QWIGRDH5DvMOzaqFfljNXyqs1RPgHXg==@protonmail.internalid>
	<20250107173117.66606e57@kernel.org>
	<e587e1c7-a2ff-4e28-9e25-b57f68545134@pen.gy>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 02:48:58 +0100 Foster Snowhill wrote:
> Thank you very much for the review!
> 
> I went through the series again, noticed a couple minor things I think
> I should fix:
> 
> * Patch 1/7 ("usbnet: ipheth: break up NCM header size computation")
>   [p1] introduces two new preprocessor constants. Only one of them is
>   used (the other one is intermediate, for clarity), and the usage is
>   all the way in patch 6/7 ("usbnet: ipheth: fix DPE OoB read") [p6].
>   I'd like to move the constant introduction patch right before the
>   patch that uses one of them. There's no good reason they're spread
>   out like they are in v4.
> * Commit message in patch 5/7 ("usbnet: ipheth: refactor NCM datagram
>   loop") [p5] has a stray paragraph starting with "Fix an out-of-bounds
>   DPE read...". This needs to be removed.
> 
> I'd like to get this right. I'll make the changes above, add Cc stable,
> re-test all patches in sequence, and submit v5 soon. As this will be
> a different revision, I figure I can't formally apply your "Reviewed-by"
> anymore, the series may need another look once I post v5.

The opinions on the exact rules differ but you can definitely add my tag
on the patches which won't change.

> Also I have some doubts about patch 7/7 [p7] with regards to its
> applicability to backporting to older stable releases. This only adds a
> documentation comment, without fixing any particular issue. Doesn't
> sound like something that should go into stable. But maybe fine if it's
> part of a series?

Yes, it's fine as part of the series.

> I can also add that text in a commit message rather
> than the source code of the driver itself, or even just keep it in the
> cover letter. Do you have any opinion on this?

Maybe it's because I don't work with USB networking much but to me
the comment was useful.

