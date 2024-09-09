Return-Path: <netdev+bounces-126474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBA29714A6
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 12:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395751C21E6D
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3611B2EE8;
	Mon,  9 Sep 2024 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="d62zX++U"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782FA171E5A
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876138; cv=none; b=mDC0qBRVn2B1G/4ncGC3mmaAZLgIN10/fuLweSSo+EDcuncstaXr053wm+dhDdr+0WEg1KvtyJwyzPmcG2rjcYvJtnSYImKRlUJrCgb3iPMoPJbITHHp/Ae/DX5WW3/z9K/5vhh8kWHWB0NosSwiuXjyFqIIHUpo982oDy4FNbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876138; c=relaxed/simple;
	bh=ieaS7jQF44W1bo28wkYhwQVDzOJZ+fk9FAyRyOqXxsQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpUwGxI44GMDKv6tKlBrRjOHurGotl2FVnEzqWzqJplrbavKhmc4WZP4s4BAdX+Nxj2Qozq1gKUKiUTfmvf4ZRLmkJQFRNB99GCceWOJgulxJHbw0yDGP8DPFiLHl7DTPYRbeVjcfdgdHdcMoJtek4WvBMLvAs4euFeT327JPww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=d62zX++U; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 852912084C;
	Mon,  9 Sep 2024 12:02:13 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SXQf1FwO6nQq; Mon,  9 Sep 2024 12:02:13 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 0CF09207F4;
	Mon,  9 Sep 2024 12:02:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 0CF09207F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725876133;
	bh=zd4eEy8tI8318pxCs9WJlDDHpq3bsRSKtcQQu/0ivMw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=d62zX++U9cJf+5tMbMBzA5y94vG7CzFFtDuswbkOuHJcSnPF6XnlShPA67cmzHXdw
	 fcB7wGoUC9/gaGo3CFgY/gNnwLq0bY/ngnV1qUNYBYwNAWbENHWhA4SIVV5ASMnPY/
	 SpcpQmFxJ+qJBeHJryAFa+poRTvT0sWGqpbNxNqtuNG0D/mhrl/aLXzLvUpPBsWBcr
	 1uPn3+1Xju7Nav7U8Kur69igyFunUlV+S7fFBHuJtwyT84q2E7jkeeTisY7O34iVrq
	 Sqt+/haE+ZT6mNfbCwuqfuGDRmkqVKO96oWlEBVIzL4yAKFsZ5FrNCFzOfy0ES/8fz
	 pJftoZMLizecQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 12:02:12 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 12:02:12 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id A72CC31829F0; Mon,  9 Sep 2024 12:02:09 +0200 (CEST)
Date: Mon, 9 Sep 2024 12:02:09 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Feng Wang <wangfe@google.com>, <netdev@vger.kernel.org>,
	<antony.antony@secunet.com>
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
Message-ID: <Zt7HoePVT9N0W1zP@gauss3.secunet.de>
References: <20240822200252.472298-1-wangfe@google.com>
 <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
 <20240831173934.GC4000@unreal>
 <ZtVs2KwxY8VkvoEr@gauss3.secunet.de>
 <20240902094452.GE4026@unreal>
 <Zt67MfyiRQrYTLHC@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zt67MfyiRQrYTLHC@gauss3.secunet.de>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Sep 09, 2024 at 11:09:06AM +0200, Steffen Klassert wrote:
> On Mon, Sep 02, 2024 at 12:44:52PM +0300, Leon Romanovsky wrote:
> > On Mon, Sep 02, 2024 at 09:44:24AM +0200, Steffen Klassert wrote:
> 
> Anyway, I'm thinking about reverting it for now and do it right
> in the next development cycle.

I finally decided to revert it. Let's work on it after the next
merge window.

