Return-Path: <netdev+bounces-235792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4B1C35BEB
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 14:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48CAE4FA5DC
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 12:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8DD3161B5;
	Wed,  5 Nov 2025 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3dNsm8S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DAC30FC39;
	Wed,  5 Nov 2025 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347547; cv=none; b=SHziaXBSu8dtbhFu0nycHDsvS938clc9gkZnuhYS5D5rN9FiQEmFT36RjakpPDad7Mt9iMsQqD8+/bORuIoXbOxo3Gfg3eTulyWqX3t57vY+3db5gErbUeBKR6XWRH5bJGU7XXB+kQWUaaj5bwC37ieUYpF3P5eF+SvLcxqt1AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347547; c=relaxed/simple;
	bh=XCz4zyomwz4Pm68u6obSXj/qzg4qfpMUjyEgdyQv+Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLXiHU4Y9hiZ6/jLo9fgUzPXB8c66dd06f+gQE2L4zb8ccPRPkJeI873pGbRDHf9VhwfEb4xzSb3/f/EJSwnnnrI0r5kMCKDK3hWH0zi1ndR3st9MSjY89hliy8H7sVDy4ca2n25OVRTuic2wiXJPswyx1j48Nan5BvNtI/runk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3dNsm8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60376C4CEF8;
	Wed,  5 Nov 2025 12:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762347547;
	bh=XCz4zyomwz4Pm68u6obSXj/qzg4qfpMUjyEgdyQv+Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3dNsm8SMMD1zlF/aVuQ0M5nZi7sRqjNLChqODtRDuV04j0XJ53jIAP5pn0F9fVtU
	 JqZUC6oqOiaJHtUDNIze6Qmiifig74NBSHTRhF5CzkGflGrE44i2p+KnnQv8fuIAeb
	 vqM/nlpIUkb3N1AiF9rBHOFZ0aytktjc0JvgBiLsOSwHH6Wm1t9vr6bhE6jmEE8yn7
	 ItBe+fW1K6IXIzt87A0MZh05AZOsQ1KqNknL7+4qfkEON/5iiY+Dc3EOmkMC54HFpQ
	 toF4UmMTtvKzQ3m98slgf3+jIypK8cYCl6xoS6n3M/iZghMoikmevyfaafolw/Jg0U
	 qYK9wD05TxNRQ==
Date: Wed, 5 Nov 2025 12:59:02 +0000
From: Simon Horman <horms@kernel.org>
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: davem@davemloft.net, david.hunter.linux@gmail.com, edumazet@google.com,
	jhs@mojatatu.com, jiri@resnulli.us, khalid@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	skhan@linuxfoundation.org,
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com,
	xiyou.wangcong@gmail.com
Subject: Re: [PATCH v2 0/2] net: sched: act_ife: initialize struct tc_ife to
 fix KMSAN kernel-infoleak
Message-ID: <aQtKFtETfGBOPpCV@horms.kernel.org>
References: <aQoIygv-7h4m21SG@horms.kernel.org>
 <20251105100403.17786-1-vnranganath.20@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105100403.17786-1-vnranganath.20@gmail.com>

On Wed, Nov 05, 2025 at 03:33:58PM +0530, Ranganath V N wrote:
> On 11/4/25 19:38, Simon Horman wrote:
> > On Sat, Nov 01, 2025 at 06:04:46PM +0530, Ranganath V N wrote:
> >> Fix a KMSAN kernel-infoleak detected  by the syzbot .
> >>
> >> [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
> >>
> >> In tcf_ife_dump(), the variable 'opt' was partially initialized using a
> >> designatied initializer. While the padding bytes are reamined
> >> uninitialized. nla_put() copies the entire structure into a
> >> netlink message, these uninitialized bytes leaked to userspace.
> >>
> >> Initialize the structure with memset before assigning its fields
> >> to ensure all members and padding are cleared prior to beign copied.
> >
> > Perhaps not important, but this seems to only describe patch 1/2.
> >
> >>
> >> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> >
> > Sorry for not looking more carefully at v1.
> >
> > The presence of this padding seems pretty subtle to me.
> > And while I agree that your change fixes the problem described.
> > I wonder if it would be better to make things more obvious
> > by adding a 2-byte pad member to the structures involved.
> 
> Thanks for the input.
> 
> One question — even though adding a 2-byte `pad` field silences KMSAN,
> would that approach be reliable across all architectures?
> Since the actual amount and placement of padding can vary depending on
> structure alignment and compiler behavior, I’m wondering if this would only
> silence the report on certain builds rather than fixing the root cause.
> 
> The current memset-based initialization explicitly clears all bytes in the
> structure (including any compiler-inserted padding), which seems safer and
> more consistent across architectures.
> 
> Also, adding a new member — even a padding field — could potentially alter
> the structure size or layout as seen from user space. That might 
> unintentionally affect existing user-space expectations.
> 
> Do you think relying on a manual pad field is good enough?

I think these are the right questions to ask.

My thinking is that structures will be padded to a multiple
of either 4 or 8 bytes, depending on the architecture.

And my observation is that that the unpadded length of both of the structures
in question are 22 bytes. And that on x86_64 they are padded to 24 bytes.
Which is divisible by both 4 and 8. So I assume this will be consistent
for all architectures. If so, I think this would address the questions you
raised.

I do, however, agree that your current memset-based approach is safer
in the sense that it carries a lower risk of breaking things because
it has fewer assumptions (that we have thought of so far).

