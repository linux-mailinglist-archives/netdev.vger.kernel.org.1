Return-Path: <netdev+bounces-94538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20938BFCD1
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8981C21367
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 12:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634C482D89;
	Wed,  8 May 2024 12:04:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D0245024
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715169886; cv=none; b=hXfijnO2s25ZP3+zqVUV242fRHdphoH18Soj+8Yh8+cfXEmDE+X2F25K0tdvkoSPJNpG+9/8EBCKUumdz4BFv3akr2Ut+OkdfaApaOXWXEQy3jiYI/3tGMzWLNYz5touycZ4FZi7HvMSDrEeurNw09kSLoEhnbKSlE6F05/2DYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715169886; c=relaxed/simple;
	bh=9Ynuyw2vunsUqUJDyMoWaos6fjx6xJhwuVmvUKbWtIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TvtUe5jmz2HNQMx1csR5fgmN0Rz5WtICKA+9QD9n+d/4IvF8DMWTtKRzZUPzwnqNhAMzYSQpX1/GUm5SWkDmOo9PU32uPcp8koplSUq+sjwTUXlQqU3TkV9dY1OgJSFaRe8Of1Ux5zr9DyF/RskPkHnQ+IQGE/J33FzFh8STPDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 89AAB2F2023E; Wed,  8 May 2024 12:04:36 +0000 (UTC)
X-Spam-Level: 
Received: from [10.88.128.156] (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 5C9102F20231;
	Wed,  8 May 2024 12:04:36 +0000 (UTC)
Message-ID: <f6bb076d-bdea-a31f-0086-054f597fcc60@basealt.ru>
Date: Wed, 8 May 2024 15:04:36 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv2 net] ipv6: sr: fix invalid unregister error path
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vasiliy Kovalev <kovalev@altlinux.org>, Sabrina Dubroca
 <sd@queasysnail.net>, Guillaume Nault <gnault@redhat.com>
References: <20240508025502.3928296-1-liuhangbin@gmail.com>
 <20240508094053.GA1738122@kernel.org>
From: kovalev@altlinux.org
In-Reply-To: <20240508094053.GA1738122@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

08.05.2024 12:40, Simon Horman wrote:
> On Wed, May 08, 2024 at 10:55:02AM +0800, Hangbin Liu wrote:

>> Fixes: 5559cea2d5aa ("ipv6: sr: fix possible use-after-free and null-ptr-deref")
> 
> I agree that the current manifestation of the first problem
> was introduced. But didn't a very similar problem exist before then?
> I suspect the fixes tag should refer to an earlier commit.
> 
Indeed, the invalid unregister error path was introduced by commit 
46738b1317e1 ("ipv6: sr: add option to control lwtunnel support"),
and the mentioned 5559cea2d5aa commit replaced one function with another 
in this error path.

-- 
Regards,
Vasiliy Kovalev

