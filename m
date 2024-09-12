Return-Path: <netdev+bounces-127792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC57F9767F2
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 13:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19DCE1C20E35
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 11:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7CE18A6A9;
	Thu, 12 Sep 2024 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="a+bSlcPc"
X-Original-To: netdev@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BA1339BC;
	Thu, 12 Sep 2024 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140825; cv=none; b=aywKes6Z1FWvYuhMXxtjDhLcXVbUetlEtAug6he5Qtqg2F9j5M05y4zAxFDQxskAr6hK5jr15vy/ydLrEJCaCe+ZMRyJ5M6iFUfkbVBfJRDKg+3W5Pd5MA/TCB37en7rjeORHv/XfoKewESY/FvH0eBc3HJNEOVTN1kqphe1nek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140825; c=relaxed/simple;
	bh=0qyj5L1lY3J+eSYHvtfw7NpUKHPg++eN0xabTIOhBAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2h/Kvyosfzn3MCaC2GPrNzU1Bp8D18J6pbxSbatMkSttz8/6NmLKuyWMX/bJGrYTRRuZ3b2BKooRw1ZKfMkDa9BsCiyXhl6H5qt4WS0dNf6Fl/QV2/4h2VFn5wkAdN19TFQEMdQK9Mv56yk1cF4b6guL4kU6eNj+eYLqaz5xXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=a+bSlcPc; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1726140820; bh=0qyj5L1lY3J+eSYHvtfw7NpUKHPg++eN0xabTIOhBAc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a+bSlcPcvguA1OteUakBVxlz5axiVCjjAWURY36WTof4YAA5nk84R4tZqAY+8ZsK4
	 epgZL0saapGxzjaKhtmZO46IliYFqfBanmL0RsyvqfZoFZIxfOfkQU/aYfmeLTekYn
	 HtNRSm7rIV2fnqGwAMxZHcXeiF8WkEOKBVKVDXwg=
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu, 12 Sep 2024 13:33:40 +0200 (CEST)
Message-ID: <9b245c1e-997a-4224-a819-3a3f1aee8b3f@avm.de>
Date: Thu, 12 Sep 2024 13:33:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC] net: bridge: drop packets with a local source
To: Andrew Lunn <andrew@lunn.ch>
Cc: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, jnixdorf-oss@avm.de,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240911125820.471469-1-tmartitz-oss@avm.de>
 <210e3e45-21b3-4cbe-9372-297f32cf6967@lunn.ch>
Content-Language: de-DE, en-US
From: tmartitz-oss <tmartitz-oss@avm.de>
In-Reply-To: <210e3e45-21b3-4cbe-9372-297f32cf6967@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-purgate-ID: 149429::1726140820-E259D885-C8B33756/0/0
X-purgate-type: clean
X-purgate-size: 1746
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

Hello Andrew,

Am 11.09.24 um 18:33 schrieb Andrew Lunn:
> On Wed, Sep 11, 2024 at 02:58:17PM +0200, Thomas Martitz wrote:
>> Currently, there is only a warning if a packet enters the bridge
>> that has the bridge's or one port's MAC address as source.
>>
>> Clearly this indicates a network loop (or even spoofing) so we
>> generally do not want to process the packet. Therefore, move the check
>> already done for 802.1x scenarios up and do it unconditionally.
> Does 802.1d say anything about this?
>
> Quoting the standard gives you a strong case for getting the patch
> merged.

I have 802.1q, the successor to 802.1d, at hand. It's a large document 
and I haven't read
all the details yet. From a coarse reading I get the impression that a 
bridge entity could
chose to filter such frames (based on "Filter Database" information 
which translates to our
BR_FDB_LOCAL flag), or forward to potential ports.

If we say we still want to forward these frames, that would probably be 
OK. The main
purpose of the patch is to avoid local processing of IGMP and other 
stuff. So at a minimum
we must avoid passing the frame up the stack and IGMP/MLD snooping code 
in addition
to the current handling (which is limited to avoiding to update the FDB).

However, I have a hard time to imagine legitimate cases of forwarding a 
frame again
that we obviously send out earlier. This is not helpful to our overall 
goal to stop storms when
customers manage to make loops in their networks (remember that we build 
routers
for end-user homes and loops are a constant source of problem reports).

Dropping on ingress is, in my opinion, also the better response to MAC 
spoofers on the network.

Best regards.



