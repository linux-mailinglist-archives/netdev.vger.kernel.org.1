Return-Path: <netdev+bounces-160210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 157B6A18DA1
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 09:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8676188A4A3
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 08:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E07E20F07D;
	Wed, 22 Jan 2025 08:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzJRbTmq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285A5188721
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737534879; cv=none; b=kNoM9zUGPX9j2Hc9Xx+8yasobrdE3G+UkVJQ3krOVoGURdxnTd3TPy/A50ZMKmFMTL6mrVjPwhBBx/JjOE0hqZAIfb/PmBQeAS4vl3EaCs8zZH9gmWbsFIY03/4F7nZgNqLtKmsG+vaVC/zZX+Qv6OvulFfwHNvOHz4RMxx2Y4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737534879; c=relaxed/simple;
	bh=kYfkQj9BWBxJa6n7oDivFH+K+SUV5EFjAs8wdQnA/Go=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=uMauGe/JgoiiWwDjGJObHgV84DyB5t9t7MK01Fe0X7naPufgaiCzOxIEUlOS3jZJFpEZNOktfA8JXMGMyC1p6oQneV+suWgCkpPKCsYK4Q0NPRBBZKtQzu8r2DjFCsV+afIOVsiAZ+TVbINb3CP0u17r9Bhlhn3pcedmA9fx5Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzJRbTmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F63C4CED6;
	Wed, 22 Jan 2025 08:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737534878;
	bh=kYfkQj9BWBxJa6n7oDivFH+K+SUV5EFjAs8wdQnA/Go=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=YzJRbTmquFGGVNWOf3EjjFGmtw6SMXETqDyHs529Wsg2/h5Bfq9cKsW3GFcZs58VA
	 ljf9YkW0LaIo6zXe3pUdAS+JsUTv7HkrmJGikZJeqbI4FUX6dO8i+DxNnMeZnoeg6d
	 c4muC15Ln4ARt3WCYanFb+uVRuXqH3ATEK4LUl61UYK9oXY+lJMe3n9nZy5KkQF5Er
	 HP1LWzHmpkM2HKd8vfKJfoG2wog0k3bbAK6wmqlwDBfeSu4Ll6crf7TvggOPjDm4/K
	 LZ9iPeGU1X3ZksM5Rvjvg7NLKaYzSri8Ec7DaaKh+sAUR8rl0Kg0ztOC2Rihmi6t+m
	 calZ0lBYgmlnQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250121090955.25610044@kernel.org>
References: <20250117102612.132644-1-atenart@kernel.org> <20250117102612.132644-4-atenart@kernel.org> <20250120114400.55fffeda@kernel.org> <173745203452.4844.5509848806009835293@kwain> <20250121090955.25610044@kernel.org>
Subject: Re: [PATCH net-next 3/4] net-sysfs: prevent uncleared queues from being re-added
From: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, stephen@networkplumber.org, gregkh@linuxfoundation.org, netdev@vger.kernel.org
To: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 22 Jan 2025 09:34:34 +0100
Message-ID: <173753487461.42919.835203071839984908@kwain>

Quoting Jakub Kicinski (2025-01-21 18:09:55)
> On Tue, 21 Jan 2025 10:33:54 +0100 Antoine Tenart wrote:
> > Quoting Jakub Kicinski (2025-01-20 20:44:00)
> > > On Fri, 17 Jan 2025 11:26:10 +0100 Antoine Tenart wrote: =20
> > > > +     if (unlikely(kobj->state_initialized))
> > > > +             return -EAGAIN; =20
> > >=20
> > > we could do some weird stuff here like try to ignore the sysfs=20
> > > objects and "resynchronize" them before releasing rtnl.
> > > Way to hacky to do now, but also debugging a transient EAGAIN
> > > will be a major PITA. How about we add a netdev_warn_once()
> > > here to leave a trace of what happened in the logs? =20
> >=20
> > I'm not sure as the above can happen in normal conditions, although
> > removing and re-adding queues very shortly might be questionable? On the
> > other hand I get your point and that might not happen very frequently
> > under normal conditions and that's just because I'm hammering the thing
> > for testing.
> >=20
> > It feel a bit weird to warn something that is not unexpected behavior,
> > but if you still prefer having a warn_once for better UX I can add it,
> > let me know.
>=20
> IMHO it's worth adding, but I also don't feel very strongly about it :S=20

Let's add it then; we can always remove it later if needed, especially
as the series will live in net-next for some time.

Thanks!
Antoine

