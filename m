Return-Path: <netdev+bounces-160100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A957A18298
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 18:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A606188BE06
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 17:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128BF1F5419;
	Tue, 21 Jan 2025 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1Pmt4Dt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F6C1F4E56
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737479397; cv=none; b=hPErHJI7sI4MW2Zgdb1N93ldNUTqss8cZ6JW/p0eRgZh2hH//nx7wnR6EtbiqdENyfrobjw8FVtDajRYvZBOVx1dVJJOz/UnTdoos3t9vOJknPLJ8t5wV1jYbgcuLYlpnaRF/qFXJV34lvUXTVMuHBN1WiezTrqN/cM9RmurUF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737479397; c=relaxed/simple;
	bh=q5pt8rBtniqfblaIvTHAjjF66dJy9eH0/hJnrHSRwm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+c3h0X5T7gngeDgbYc44RiskFYO565O6tJWOR1CO0SJP8dceT9ixWcPsltTqwlIpF44HmqsUO3Vsw750mMEsXcI0h8NtTpo2dhYEh9xm8z/9dj/GsLBBvi8tBx4N+3pZTEwmd0yYJs4Mb0VDZe5S2DwqlTD5ProqV0toYeIN0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1Pmt4Dt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076B6C4CEE7;
	Tue, 21 Jan 2025 17:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737479396;
	bh=q5pt8rBtniqfblaIvTHAjjF66dJy9eH0/hJnrHSRwm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b1Pmt4DtWowcr9TG1IgXLXu21fTJKZrou2o1BLF3JfaOh9v5ORteqC5xwZOSKH6xE
	 TWLseEd2Q+i3E+ZccP3AWQ5y0GQz8dV2dUqkhNGE0v540UmQ+E0GeNj/noUdvkedC2
	 p8gdoO8iIP8ujB2JP+jPMjZ3s/73MQIT1GCkBSDsqalPhWYG47jf+j5N0cvlQkex5s
	 m1MP8++lIXrllyIHpPifJqRYopQzNL7pIEXbTS2sbqkOqV1Uut+Q5XCoOpQLUuYlPl
	 qL4TX5Ibt3CpHH1kvPorvuM9TKKoopN5KCcEA8Wh7Pi2pfPn0gfOoLfVmUlMcZ9vYs
	 CtanSQpro103g==
Date: Tue, 21 Jan 2025 09:09:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 stephen@networkplumber.org, gregkh@linuxfoundation.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net-sysfs: prevent uncleared queues from
 being re-added
Message-ID: <20250121090955.25610044@kernel.org>
In-Reply-To: <173745203452.4844.5509848806009835293@kwain>
References: <20250117102612.132644-1-atenart@kernel.org>
	<20250117102612.132644-4-atenart@kernel.org>
	<20250120114400.55fffeda@kernel.org>
	<173745203452.4844.5509848806009835293@kwain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jan 2025 10:33:54 +0100 Antoine Tenart wrote:
> Quoting Jakub Kicinski (2025-01-20 20:44:00)
> > On Fri, 17 Jan 2025 11:26:10 +0100 Antoine Tenart wrote:  
> > > +     if (unlikely(kobj->state_initialized))
> > > +             return -EAGAIN;  
> > 
> > we could do some weird stuff here like try to ignore the sysfs 
> > objects and "resynchronize" them before releasing rtnl.
> > Way to hacky to do now, but also debugging a transient EAGAIN
> > will be a major PITA. How about we add a netdev_warn_once()
> > here to leave a trace of what happened in the logs?  
> 
> I'm not sure as the above can happen in normal conditions, although
> removing and re-adding queues very shortly might be questionable? On the
> other hand I get your point and that might not happen very frequently
> under normal conditions and that's just because I'm hammering the thing
> for testing.
> 
> It feel a bit weird to warn something that is not unexpected behavior,
> but if you still prefer having a warn_once for better UX I can add it,
> let me know.

IMHO it's worth adding, but I also don't feel very strongly about it :S 

