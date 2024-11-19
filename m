Return-Path: <netdev+bounces-146207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 188159D243A
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 11:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87B21F22BBA
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 10:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F661C4A03;
	Tue, 19 Nov 2024 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="uk4lWcT6"
X-Original-To: netdev@vger.kernel.org
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761EC1C07D3;
	Tue, 19 Nov 2024 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013711; cv=none; b=Y6eDKarqDHW4btV/AQLN5bNGuJ+KeLBdyRKeAHL1R/h2eXjuncbZvMqGU1A6ik2YmMJPck2Htt4Y3WIdxygOnWPf7eN8YdQ9GDRrp5K4qoFeHsVxNdE2J1XVeM3jD/jzZJtAXhuNg4StUuEwbGRAuylxRKXKiKD9pi6PGJuGXH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013711; c=relaxed/simple;
	bh=wSnrpm26gTZo4rHtAZAPpI+Rk9ESN7UlI8KwJwU60k4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rxv3qzAQJDiePruVG4nwDEq98bik2p6DdqYkAmoENe6wiYw3Cokz5sFV445VJH16oMl33wdV8atai3Ylo4cfWmWHlzJx4hCv/50YwLhLsePjJrD2z0AeF1f3y7rbp6rMpaExjscTZeK06hAkEK8Svv85EEVwTtMVzlFmmN7VFuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=uk4lWcT6; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:26bf:0:640:efa0:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id 5F40561544;
	Tue, 19 Nov 2024 13:54:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id usO0U3sOma60-vLRvFFuL;
	Tue, 19 Nov 2024 13:54:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1732013698; bh=wSnrpm26gTZo4rHtAZAPpI+Rk9ESN7UlI8KwJwU60k4=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=uk4lWcT6pKbUuoXoYHz8x/gBBW4UX3MgeZLq9TLH7uREN+7baPpqppAY+cJlm9TQw
	 xdXdvJI5wclfpMoEullgz05ZU50ZOA/q7KObIjp25BS+XIgumKCCRXErLMUuSg4iVd
	 CLqYpsoibOuUOsXl0Su9DzL4hfFOvemMPleW30B8=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <e94cb653-5bd3-4cb4-a3d4-3bac64f2ee61@yandex.ru>
Date: Tue, 19 Nov 2024 13:54:56 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tun: fix group permission check
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, agx@sigxcpu.org,
 jdike@linux.intel.com
References: <20241117090514.9386-1-stsp2@yandex.ru>
 <673a05f83211d_11eccf2940@willemb.c.googlers.com.notmuch>
 <673bb45c6f64b_200fa9294ee@willemb.c.googlers.com.notmuch>
 <d772d47e-5dc0-4295-a302-e17e75ca8dd1@redhat.com>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <d772d47e-5dc0-4295-a302-e17e75ca8dd1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

19.11.2024 13:51, Paolo Abeni пишет:
> I think we can't accept a behaviour changing patch this late in the
> cycle. If an agreement is reached it should be reposted after the merge
> window.
>
> /P
Noted, thanks.

