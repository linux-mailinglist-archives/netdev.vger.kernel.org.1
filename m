Return-Path: <netdev+bounces-270245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IkJEtfxvmlxlAMAu9opvQ
	(envelope-from <netdev+bounces-270245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 20:30:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3052E6FCA
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 20:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8053430060BD
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 19:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44333191A5;
	Sat, 21 Mar 2026 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=spreckels.dev header.i=@spreckels.dev header.b="98h88JpP";
	dkim=pass (2048-bit key) header.d=spreckels.dev header.i=@spreckels.dev header.b="ORptu2oo"
X-Original-To: netdev@vger.kernel.org
Received: from secundus.vsp.im (secundus.vsp.im [37.120.170.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A262773D8;
	Sat, 21 Mar 2026 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.170.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774121422; cv=none; b=JEswKe9x9Nuns2LRKgmmHbB4dPCZV3M2ReviZcTfle6ehdT9jmLIMkrUXQdcHBclht9lZ9DWuGTtle/MRUYzXs5H9sk/AQWDlThY59f38Asvt50HO2tNZdWXttD0yn8tsyVDf6OsT8DTfQuj3IP3fJnkG4x4JiMKHfoj+uoVuSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774121422; c=relaxed/simple;
	bh=zFkWy8J377R/4AcVMLoKJMS8w6SguvdsB0mx8OERXuY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FwzTeHwmlcRIqWJle1xhHIHNR1kyHGJlKJ3TbTq6BHgwlFAKeBG69JqBMMXPzqXzfHXVyk01v4is+Frudsk2zz4Kjlfe+Ak2pm2BSVtLQyNoXpYeMy7JOgxrHhrcp26lBcF6g9kDXl24xI/IXH6Tr1n/Ov8ZIh+UvLe4hJPrAME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spreckels.dev; spf=fail smtp.mailfrom=spreckels.dev; dkim=permerror (0-bit key) header.d=spreckels.dev header.i=@spreckels.dev header.b=98h88JpP; dkim=pass (2048-bit key) header.d=spreckels.dev header.i=@spreckels.dev header.b=ORptu2oo; arc=none smtp.client-ip=37.120.170.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spreckels.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=spreckels.dev
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=spreckels.dev;
 i=@spreckels.dev; q=dns/txt; s=s20260208e; t=1774120853; h=message-id
 : date : mime-version : from : subject : to : cc : references :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=zFkWy8J377R/4AcVMLoKJMS8w6SguvdsB0mx8OERXuY=;
 b=98h88JpPkfnmgT0843H5R+353PZyIE+mgK2sD9ysb6GFT0RlZHhhBCPlJBpvBrHOcnQNG
 YYu2p4XkPm7GsxMBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=spreckels.dev;
 i=@spreckels.dev; q=dns/txt; s=s20260208r; t=1774120853; h=message-id
 : date : mime-version : from : subject : to : cc : references :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=zFkWy8J377R/4AcVMLoKJMS8w6SguvdsB0mx8OERXuY=;
 b=ORptu2oomriETGtc8uO2mbetSXWU+FNjm/6cOJjPNJATdKs04Y1xIhTg0IOKli5I5Lvm0
 YA2bYjylVuYPplqD+j87E8RjuGNpOQGqs0o72mHNk4+ik3A7yAMB2HewYe26Q/iWvmL7m+W
 8S23mTbK/spkiUZcDNK77FPor9JjvlBm5EvRDDFuucMmIzCbL8Tb193WSqwbfSTtCMuI6/3
 VnsO7lgxyhCDinUTJRLZPix2rvsvQUGrun1+xTbJCMV5gzj98lz0jTdo14DAi8yn+KrAsYU
 QTWxmBlMuE1gaUPljGTt/128uIcgvt3XUk6ESKO41ThCTaPGELPklwjXHn0w==
Received: from [IPV6:2001:9e8:fb2a:e501:845:1723:955a:996f] (unknown [IPv6:2001:9e8:fb2a:e501:845:1723:955a:996f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by secundus.vsp.im (Postfix) with ESMTPSA id 9D9C7FF9EE;
	Sat, 21 Mar 2026 20:20:53 +0100 (CET)
Message-ID: <c486b63c-521f-4972-80bf-ebb2bfe04724@spreckels.dev>
Date: Sat, 21 Mar 2026 20:20:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Valentin Spreckels <valentin@spreckels.dev>
Subject: Re: [PATCH wireguard] wireguard: prevent ipv6 addrconf via
 IFF_NO_ADDRCONF flag
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260208170545.31942-1-valentin@spreckels.dev>
 <abHz3xcsLhIPc_Jn@zx2c4.com>
Content-Language: de-DE, en-GB
In-Reply-To: <abHz3xcsLhIPc_Jn@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[spreckels.dev:s=s20260208e,spreckels.dev:s=s20260208r];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270245-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[spreckels.dev];
	DKIM_TRACE(0.00)[spreckels.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[valentin@spreckels.dev,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,spreckels.dev:dkim,spreckels.dev:mid]
X-Rspamd-Queue-Id: 3B3052E6FCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jason,

On 11/03/2026 23:59, Jason A. Donenfeld wrote:
> Hi Valentin,
> 
> On Sun, Feb 08, 2026 at 06:05:45PM +0100, Valentin Spreckels wrote:
>> Use the flag introduced in commit 8a321cf7becc6 ("net: add
>> IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")
>> instead of mangling the addr_gen_mode to prevent ipv6 addrconf.
> 
> Can you give some more context here? Why was IFF_NO_ADDRCONF added when
> the IN6_ADDR_GEN_MODE_NONE method has been working fine? What's the
> difference between these approaches? I don't doubt that your patch is
> correct, but I would like to better understand this.

Only wireguard configures addr_gen_mode inside the kernel, otherwise it 
is only set by userspace; userspace is also able to overwrite the 
IFF_NO_ADDRCONF set by wireguard.

Commit 8a321cf7becc ("net: add IFF_NO_ADDRCONF and use it in bonding to 
prevent ipv6 addrconf") introduces the private interface flag 
IFF_NO_ADDRCONF, which isn't accessible by userspace.

Thus use the IFF_NO_ADDRCONF flag in wireguard.


Does that answer your questions? If yes, I will submit a v2 with this as 
commit message.

Best regards

Valentin

