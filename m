Return-Path: <netdev+bounces-162745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A571AA27CFB
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C66F1885C8E
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029132054E3;
	Tue,  4 Feb 2025 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zbp+ElhJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3CE25A62C;
	Tue,  4 Feb 2025 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738702827; cv=none; b=mP8lW5Oj7KZ3OkoeLWzjRxL6FNGR7GoISG5xJ61MC7gnz9V7woOS0IprUZ/OIxPOmuomXhx+wkEjEjbPPOJHR4T8aWwqXKmvheJghUJKv2ya9Hems/G4Jf+CK91aEEVI6XhhEge8VYVRlgmjCk5U55YQeCXNoVIIxu3VM4pPcJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738702827; c=relaxed/simple;
	bh=W3IUp80uPm8G9kvSFtyK/LEkA+g/UOfW+rNQmYJ1D5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mkhr7gqBPN8IoSvguf0c4VBGAppPIsk7A+JxKT3H3a/iXpfuoW2vY5PLZWLZr6z+FUZaYuxPYYbguBZOCJ720u+lMkYNb9jSy0XX71bfbgGvLFlnQyVqJk6EL6LfJ40yTGjK6+Ybo+q+mM6JXzkxyeqFLWBEj1X9YPC1i+5fWlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zbp+ElhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1787C4CEDF;
	Tue,  4 Feb 2025 21:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738702827;
	bh=W3IUp80uPm8G9kvSFtyK/LEkA+g/UOfW+rNQmYJ1D5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zbp+ElhJ51fTx9UNtLXKEo3gtVIOMX7vulziTrxYpYa5ImkVs/pmNpYo63zuuOO6X
	 s9GYZRmh838dP54uC6thBFKlECADIbDLVyaV+IRg7XAh/7no7LaGfOkPPtU17WXoMZ
	 FUSmGP52A4GStL3biJaZfg3JFKFrRza7EPS5W6y9QG6niHkXA6ILWNuOGReIVhGCMW
	 rVnx86Z59f5M0GO1r4VXaAyBhzRW09nWtMbzZi1FwHvpsflc28+kX373rcMmuZFhy1
	 3lPuQVXJoopSkWfd8KQWztO/S2oN6j+SdPrQeae8vakn9WTa7kEil8krVPikHpEf55
	 /WkL0SPAF67gA==
Date: Tue, 4 Feb 2025 13:00:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Kuniyuki Iwashima
 <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>,
 eric.dumazet@gmail.com, rcu@vger.kernel.org
Subject: Re: [PATCH v3 net 11/16] ipv6: input: convert to dev_net_rcu()
Message-ID: <20250204130025.33682a8d@kernel.org>
In-Reply-To: <CANn89i+2TrrYYXr7RFX2ZwtYfUwWQS6Qg9GNL6FGt8cdWR1dhQ@mail.gmail.com>
References: <20250204132357.102354-1-edumazet@google.com>
	<20250204132357.102354-12-edumazet@google.com>
	<20250204120903.6c616fc8@kernel.org>
	<CANn89i+2TrrYYXr7RFX2ZwtYfUwWQS6Qg9GNL6FGt8cdWR1dhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Feb 2025 21:10:59 +0100 Eric Dumazet wrote:
> > Test output:
> > https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/978202/61-l2tp-sh/
> > Decoded:
> > https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/978202/vm-crash-thr2-0  
> 
> Oh well. So many bugs.

TBH I'm slightly confused by this, and the previous warnings.

The previous one was from a timer callback.

This one is with BH disabled.

I thought BH implies RCU protection. We certainly depend on that 
in NAPI for XDP. And threaded NAPI does the exact same thing as
xfrm_trans_reinject(), a bare local_bh_disable().

RCU folks, did something change or is just holes in my brain again?

