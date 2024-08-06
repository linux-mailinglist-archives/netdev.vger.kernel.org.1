Return-Path: <netdev+bounces-115924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50871948679
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 02:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877E6285BE2
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 00:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9053329A1;
	Tue,  6 Aug 2024 00:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V52gv7Rc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B98DA35
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 00:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902459; cv=none; b=PhT8AvKq357dUIqhDT62PJfWFrC4JO2+VDInCwFLS91FSyjsRFUt4HXyQTW1Pkv1nvd67OEPE/NU3PDt96rdjegLEQd2HdCqxs3fgX3BfGv8Fkvb0nSZxr56yglUW9rYlfgnrqUPxZZKnbDL89kVizwolOXQCWkcCmyTT90Jz4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902459; c=relaxed/simple;
	bh=5e3wZ7gyXtsPvm0P1NvePliPNLmjTKINaC6NltjfTW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+lKRggsdkhx3UA3HL/nBdUC02oGbtyIiouMtR3uJiVdOTJoDplnAhDGWyyL5aR0OrEU1J/wCAdy1qS8lMIYRZRGMes2roip0TPubRyOL17UMJoNGee1RjPIqPLBFz/bNvnjam50a/WE80g46StkSu4tOLiqMIELS1GLRZ0wqZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V52gv7Rc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DDFC32782;
	Tue,  6 Aug 2024 00:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722902459;
	bh=5e3wZ7gyXtsPvm0P1NvePliPNLmjTKINaC6NltjfTW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V52gv7RcGpIRlZXzUfZtmXKvNw0lcjEEd81iLQD2pMnMSD782PkMH7kwlsS2vw1WJ
	 mx6QJF33O7N1xHZDioSXJtRRyJS7qF9A3cG3oCLLdkzyDf7qJh4CLVMLz6klGzmS7l
	 wB+hoU2UxZv8FnOUF2DTjkhtJQCRo8BM0Pkt4Eu6FTUSyzGloqoHCH70z/fxgS3r/P
	 DLo7VcrYaAloAbu++49qgAnqPtsA++p3GkJou6yUzZs8R3lozPOOfxxz2Emlm9Kk3g
	 pAL6GVcDPMqNMBuePrzWYA8FWzCwLFrLaLC3QuKTPVuwwWEBxdFT3xsIMtq8UU4xGz
	 KrBfWUXHT+x2Q==
Date: Mon, 5 Aug 2024 17:00:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Tom Herbert <tom@herbertland.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: kcm: use previously opened message only once
Message-ID: <20240805170057.60b06b2c@kernel.org>
In-Reply-To: <20240801130833.680962-1-dmantipov@yandex.ru>
References: <20240801130833.680962-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Aug 2024 16:08:33 +0300 Dmitry Antipov wrote:
> When syzkaller reproducer injects 'alloc_skb()' failure at line
> 817, 'kcm_sendmsg()' may return with partial message saved at
> 'kcm->seq_skb'. Next call of this function will try to build the
> next message starting from the saved one, but should do it only
> once. Otherwise a complete mess in skb management causes an
> undefined behavior of any kind, including UAFs reported by KASAN.
> 
> Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
> Reported-by: syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b72d86aa5df17ce74c60
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  net/kcm/kcmsock.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
> index 2f191e50d4fc..fa5ce5c88045 100644
> --- a/net/kcm/kcmsock.c
> +++ b/net/kcm/kcmsock.c
> @@ -766,6 +766,8 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
>  	if (kcm->seq_skb) {
>  		/* Previously opened message */
>  		head = kcm->seq_skb;
> +		/* ...should be used only once */
> +		kcm->seq_skb = NULL;
>  		skb = kcm_tx_msg(head)->last_skb;
>  		goto start;
>  	}

Not sure how much this matters but if we clear seq_skb then handling
here:
https://elixir.bootlin.com/linux/v6.10-rc4/source/net/kcm/kcmsock.c#L940
will work differently.

