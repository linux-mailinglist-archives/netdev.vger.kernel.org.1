Return-Path: <netdev+bounces-167391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC57A3A1F1
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 17:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1FF93A91B2
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 16:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA98018C03F;
	Tue, 18 Feb 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eq5KNrqP"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641721459F7
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894420; cv=none; b=AClEtSWbrSl7R+nOr2th+lesHULYup9jSk6aFU+iE2axAfftkuScu0O7gHOJCSmF5hE9r1nJh85TLhrsirdHijb5Eivi1f7NpdPdzAqCmZccW8Q9v3ZAlkfJ0Khu49hkaYETBOrmosYQzWQynWI10vuXbMMDBs5wgbcfWZMlmV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894420; c=relaxed/simple;
	bh=hHtYHj3QkVqLn3+B49q9SZJqcGXO10WYZMImh6cF94A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDv/mE4zcruIEFDKIH1OliqCtK09QhcTWbyFQEOe/AfvRgPwV1sKeqU7cPOAb8HSCY/GuYxysUqwhQZJR27RJTPylxl7nvtw0l6P02opsCoAPdVt1N6JcFCm90wafAw9FVFdLt+46XwaMWWAt0H0JUwY5KyLrxZzza5fHx/iKqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eq5KNrqP; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <427249dc-87cd-4653-aefc-3b8451b9bf2a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739894416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFEppCOsYoAmws7gd2b+/HH38xoPd7rswtetMcS8tx4=;
	b=eq5KNrqP67mWZTZnNfoWzrmYduP6f92WSsPdajqIuuJOgTJWWMM8LTmyzOSy5SUPltX0Ws
	gOu4V3fI7sEF3JPEWIE2BXB8bz3tWMMnstAp3pgkvPp5uDUa7inrGB3g8DmDRoZ5UM36A8
	BJ+Na7/hwT84+FGwhsOvOi/DH03tUMY=
Date: Tue, 18 Feb 2025 11:00:02 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/2] net: cadence: macb: Convert to get_stats64
To: Andrew Lunn <andrew@lunn.ch>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250214212703.2618652-1-sean.anderson@linux.dev>
 <20250214212703.2618652-2-sean.anderson@linux.dev>
 <d4e1438f-511a-45c5-8e77-29be1b85e62e@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <d4e1438f-511a-45c5-8e77-29be1b85e62e@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/14/25 17:59, Andrew Lunn wrote:
> On Fri, Feb 14, 2025 at 04:27:02PM -0500, Sean Anderson wrote:
>> Convert the existing get_stats implementation to get_stats64. Since we
>> now report 64-bit values, increase the counters to 64-bits as well.
> 
> It would be good to add some comments about why this is safe on 32 bit
> systems. Are the needed locks in place that you cannot see a partial
> update?

Well, it's no more unsafe than the current code which does RMW without
synchronization. So I guess I'll send another patch to add some locking.

--Sean

