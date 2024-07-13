Return-Path: <netdev+bounces-111236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3881B930557
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 13:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6EC281710
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 11:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C63071B40;
	Sat, 13 Jul 2024 11:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MDTpqaRO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C76E4AEC6;
	Sat, 13 Jul 2024 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720868756; cv=none; b=l1mOskc2smIIO2a9EQXzPBR6bd2CgSiZZ1tD4X4O4Bvjdl/iDLMI52Yl6BQEJYWMdZf9VOZ18o+FOgtOOvTXcZUyjv/qQq6s1FaLlIP9BSgMHc5ikUjMUpSy61dERz9SmN13k0HHFS6//GLDJJy/GWHjhxJNEclRi2qoXVg4OY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720868756; c=relaxed/simple;
	bh=/aQEoAtJevZOtnhQxzPJg1RlTHsJoGK/euntEf/HqRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfMgXYoD3TvEiFppgcSkuRndlk7kDRwx8jZGx7dy6/k9+hW5kuY7vUlV3UPZ5B/i6s8F6N7swBNLZ2yQbGsdC460UObcTPT1mi6gB0c09qij3mCu6/YreZct2OfX3mp81btwHlIMl64XBjtiRlMVkKvANgNnx22OiTeOI54kChg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MDTpqaRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180FAC32781;
	Sat, 13 Jul 2024 11:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720868755;
	bh=/aQEoAtJevZOtnhQxzPJg1RlTHsJoGK/euntEf/HqRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MDTpqaROuDDJA85T2CmWV2lRTEQ5+ynWicXt09KcKOGIohfPbeK0E7/Hj1OJx2hhm
	 z+yEaoX5eSJC8hzy9UiYDddQ0z9kf6YI8VnebftV2PAEpnNAt9+VStC96lmqHLPzrJ
	 Zm0QmI65/r/pFYUVj9n1X2U+fyFhiy011WcX8tFM=
Date: Sat, 13 Jul 2024 13:05:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ashwin Kamat <ashwin.kamat@broadcom.com>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net,
	yoshfuji@linux-ipv6.org, dsahern@kernel.org, kuba@kernel.org,
	netdev@vger.kernel.org, ajay.kaher@broadcom.com,
	vasavi.sirnapalli@broadcom.com, tapas.kundu@broadcom.com
Subject: Re: [PATCH v5.10 0/2] Fix for CVE-2024-36901
Message-ID: <2024071323-disarray-moody-1e0b@gregkh>
References: <1720520570-9904-1-git-send-email-ashwin.kamat@broadcom.com>
 <2024071313-even-unpack-9173@gregkh>
 <CA+tTbbvb04ZuTY+5pH+Yf5-OKJnx5RqvyjxfDixWhinwvH_hFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+tTbbvb04ZuTY+5pH+Yf5-OKJnx5RqvyjxfDixWhinwvH_hFw@mail.gmail.com>

On Sat, Jul 13, 2024 at 03:16:15PM +0530, Ashwin Kamat wrote:
> Hi Greg,
> The patches get applied to 5.10 stable branch with an offset [i.e Hunk #1
> succeeded at 240 (offset 19 lines).]
> To avoid that I sent separate patches to 5.10 and 5.15. Apart from that
> there is no other difference.

That's not what I asked, I asked:

> > Any reason you didn't actually cc: the stable@vger.kernel.org address
> > for these so we know to pick them up?

That is a requirement to get a patch merged into a stable release,
right?

thanks,

greg k-h

