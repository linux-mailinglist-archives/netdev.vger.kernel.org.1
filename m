Return-Path: <netdev+bounces-134530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6CA99A009
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 11:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94741F233A4
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 09:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E70820B21C;
	Fri, 11 Oct 2024 09:21:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from gw.red-soft.ru (red-soft.ru [188.246.186.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B228F1F4FA8;
	Fri, 11 Oct 2024 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.246.186.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638468; cv=none; b=de8/IQhTgZoYywujN8IIWkYgQMD01zBb6Md+jULcx42i6xIsg+IpsvoOWkagJ4QmGuz+V2T1TrxEOIMcR9J3Gqer/cI0qNyJlVAqloBbxxMk6JCg6HDw9fwIeVgW8thgo7gZoqoU8YZuWUcv+Gmz8reH+RME9t/pblpYgEJy/KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638468; c=relaxed/simple;
	bh=jU9b8meyfFqhj4XP4F0wIIf+V51oNcfs0XY3vOEztmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThKzkUEZC3O2rCFE9z8TPiNgKcRVhT+u915a2rouDm0gqH5rxz9BLVui3y0ZiuhdPkHq/uBvqk7r/NOpoV/JDjenGUjmlfaNVOwIyBa0zxu4Na1jmMXvtKEByB5QOvjkKLRtyHzqfK3pc6ihyX72joKZqvl7m/1QUk+1Cm9C5ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=red-soft.ru; spf=pass smtp.mailfrom=red-soft.ru; arc=none smtp.client-ip=188.246.186.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=red-soft.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red-soft.ru
Received: from localhost.localdomain (unknown [10.81.100.48])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by gw.red-soft.ru (Postfix) with ESMTPSA id 00F473E1C0D;
	Fri, 11 Oct 2024 12:20:55 +0300 (MSK)
Date: Fri, 11 Oct 2024 12:20:54 +0300
From: Artem Chernyshev <artem.chernyshev@red-soft.ru>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net] pktgen: Avoid out-of-range in get_imix_entries
Message-ID: <Zwjt9pz3uYoK+Jco@localhost.localdomain>
References: <20241006221221.3744995-1-artem.chernyshev@red-soft.ru>
 <20241008182319.0a6fe8ad@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008182319.0a6fe8ad@kernel.org>
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 188374 [Oct 11 2024]
X-KLMS-AntiSpam-Version: 6.1.0.4
X-KLMS-AntiSpam-Envelope-From: artem.chernyshev@red-soft.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_from_domain_doesnt_match_to}, red-soft.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2024/10/11 08:06:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/10/11 07:41:00 #26731420
X-KLMS-AntiVirus-Status: Clean, skipped

Thank you for the review. I will return with V2

Best regards,
Artem

On Tue, Oct 08, 2024 at 06:23:19PM -0700, Jakub Kicinski wrote:
> On Mon,  7 Oct 2024 01:12:20 +0300 Artem Chernyshev wrote:
> > In get_imit_enries() pkt_dev->n_imix_entries = MAX_IMIX_ENTRIES 
> > leads to oob for pkt_dev->imix_entries array.
> 
> I don't think so, at least not exactly. It's legal to fill the array
> completely. It's not legal to try to _add_ to an already full array.
> 
> AFAICT the fix needs more work.
> -- 
> pw-bot: cr

