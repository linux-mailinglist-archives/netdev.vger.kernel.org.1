Return-Path: <netdev+bounces-210517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2884B13C06
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75BFB3A6B83
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 13:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1707126E706;
	Mon, 28 Jul 2025 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4sRG9pD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E207A26B75A;
	Mon, 28 Jul 2025 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710660; cv=none; b=oMiZRLHVdlc1UHpfFNq/9yNk2WE7bUQ16Oy5f/9NQxjRMGGAGK8hRHLm3cPCKatkK+2wAWj/zpv+tdKK51E1lqfXQJeY0/2WG3X+UHkZJqOi2fu2Xb1kgesJToIRCZiGAKvb/Y38hyGm9nkWjKB45mYyWbAL2M51qHg8A6Q8V98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710660; c=relaxed/simple;
	bh=4pbNI0SICMOu4Zo8/H01bCrOP5bo1xtHTwzmH+cI7gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADg60F9jpDIYd9S+itQPvNOwtey4zrbsdxkvlBpiaDMPFH4qwBH6eHXQu/hkgZ/DOHF3u1eIRbwjal9M470PChxcFDtfI+r2mSyuEkL6Zbd+X7E4q3DrJZAKI54sP0hCKfXg2DCg6eFpkm+BEd3mP0/2FFJJEdg/SK0Z7OVlFHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4sRG9pD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FA1C4CEF7;
	Mon, 28 Jul 2025 13:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710659;
	bh=4pbNI0SICMOu4Zo8/H01bCrOP5bo1xtHTwzmH+cI7gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A4sRG9pDsDloV+pwcP2poqgvO57NZiupR72zuDifjiJChNhhqZ0qqVELzK4I+4qLj
	 1F7Hy7eIkCBdSb2v7hg/0ibWSEPERSEai4RZpB4RETFGpLXVxoaE1vky7XNQzP5gAJ
	 efltHWmgHYpvs+Brpf5JP6Q1X4CvjQtuBz+XrtzT/2VLlJNAbZIWj9zYB1jpWEhgzj
	 EX/Y0dzwuUTTCo+t7rd85f8JNNoEc/FoBUrhfyvB8RJs6fFgLtFopl0dnnrratgQsj
	 LOnJC2OqnlqSnunqL+41ExhwkHCr3ro07iU/SoWwO0PtOPF8b3AzTPrFgQnatDs4Ps
	 JVZLy3KYXea6A==
Date: Mon, 28 Jul 2025 14:50:55 +0100
From: Simon Horman <horms@kernel.org>
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: ipv6: fix buffer overflow in AH output
Message-ID: <20250728135055.GA1877762@horms.kernel.org>
References: <20250727-ah6-buffer-overflow-v2-1-c7b5f0984565@posteo.net>
 <20250728113656.GA1367887@horms.kernel.org>
 <871pq05w74.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871pq05w74.fsf@posteo.net>

On Mon, Jul 28, 2025 at 12:36:18PM +0000, Charalampos Mitrodimas wrote:
> Simon Horman <horms@kernel.org> writes:
> 
> > On Sun, Jul 27, 2025 at 09:51:40PM +0000, Charalampos Mitrodimas wrote:

...

> >> Changes in v2:
> >> - Link correct syzbot dashboard link in patch tags
> >> - Link to v1: https://lore.kernel.org/r/20250727-ah6-buffer-overflow-v1-1-1f3e11fa98db@posteo.net
> >
> > You posted two versions of this patch within a few minutes.
> > Please don't do that. Rather, please wait 24h to allow review to occur.
> 
> I'm aware. The reason for posting the second version so soon was because
> I did not want people to get confused about which syzbot report this
> solves, as the one in v1 was the wrong.

Understood. FWIIW, I think it would have been better
to respond to v1 with corrected syzbot information.

...

> This is much better actually, thanks a lot. I tested it with the syzbot
> reproducer and no issues were found.

Excellent.

> > I would also suggest adding a helper (or two), to avoid (repeatedly) open
> > coding whatever approach is taken.
>
> I'll do that and go on with a patch targetting ipsec-next. Is it okay to
> keep the the versioning or it should a completely new patch?

I think that keeping the versioning is fine, although it is up to you.
If you do so, please do include a link to earlier versions
(as you did in this patch) as I assume the subject will change.

-- 
pw-bot: cr

