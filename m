Return-Path: <netdev+bounces-303820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FIQELUh6RWpjAwsAu9opvQ
	(envelope-from <netdev+bounces-303820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 22:36:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 137876F17FF
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 22:36:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=xobDnYgu;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=VixF3G5A;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303820-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303820-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDA1330ED52F
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 20:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0893B442F;
	Wed,  1 Jul 2026 20:32:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC133AF676;
	Wed,  1 Jul 2026 20:32:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782937976; cv=none; b=sb1vdT38c7WPOj7d1kT+aw6A8DKw+t8c9Fh1msAb90s4m6U00IuJJhzGvp0yzgms6R7fzuP2k2qzUYwQ/eLjsuPR2X5NMWw1lhZ3/N0d1kylEbJxShnVHwVSJVlb02R58azjwj54N3Kt8yxR5iZ+wi1whsysaL6L/PIugm+nHZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782937976; c=relaxed/simple;
	bh=qWm9LX37sYO0MkUyQuCpsu5534nbCncHhb+IAP5U1Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r56dFskOLQ+9k6fE0ps1dtgx6mNbqqA+uoZyzlUjqMRvQqjvm+x0H7OPSX7ihjOEADEfMAPEaiVPq9eKwAErJjYkl7mljCd9x9EnOmmqIs3XssuMfgpMB3lxmwmdwyPl5GHVWp0R0p4/rTlHXJhW4nJm/4Wionf2JlSYnL4yzfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=xobDnYgu; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=VixF3G5A; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782937972;
	bh=qWm9LX37sYO0MkUyQuCpsu5534nbCncHhb+IAP5U1Js=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xobDnYgu9VVvQz28oygfvZJZNauh97OQZsGq2yaEVk7jLuPz/k8vhjcK4ybIOBWkO
	 sIpK3nctIsDqNEB+2gFwrhJWfoz7ZYNoXM2TwvJzr3trMfRTqyt7OVeu4rGeJJ2Ova
	 wwiM7Ky5z6DiKvzrMuZCLnYLF4Jga+mrAyVdTxljACRjWtGOxtdAYIysr0/uxl2aP+
	 80ntNn8/vRQZCTWCmFNLbhZoI02TZzeZJ+tE74pL3YtD6K8o3w4a92A5h7P4CgiSgP
	 tmXPXQRrqUCJyMub9S+bwhx5m4HDxC1zO9XW+WRcFr/c1gZiR15V5/H9YEcNib1oix
	 /IiEiUkqlOQgg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id AFC764936B; Wed,  1 Jul 2026 20:32:52 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782937970;
	bh=qWm9LX37sYO0MkUyQuCpsu5534nbCncHhb+IAP5U1Js=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VixF3G5Afzs8LmtMRESvVVPLh5hZJpCmzAIWpIOyrDwhSfWqX85GIA6c+6UGl4zFR
	 oo5Jh0h5eDXb43T64ttlD+wGI1ksTeAO5gXS167Qw7ZEKjHLSxGMmiFn7Pum/XWbfK
	 H5xx8+7W8ETwSQPV2u2Cyd0QAs8yipMoP0Pgx+eISi5DwWjQgHGU3GDkDiRiYXVlaQ
	 RFASI8IwEJUdgHD8Ousut5mL5227Hxkc0/j5kRkWOS0yGzNizZAHSYZud/FV8Mtz59
	 GI3Qhi39IEaXAjtUyAXrvKv0gcLxLJBTSPjJMBFaxzuySeQLzCNuSIsSDRDETZ19xU
	 RGvtlfbv+aYDw==
Received: from [IPV6:2003:c6:9f1c:3c00:add4:fa17:212c:ec8d] (p200300c69f1c3c00add4fa17212cec8d.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:add4:fa17:212c:ec8d])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 3A2304935B;
	Wed,  1 Jul 2026 20:32:50 +0000 (UTC)
Message-ID: <6677d82e-2b8c-4173-ba6d-6743a5059bc1@birger-koblitz.de>
Date: Wed, 1 Jul 2026 22:32:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RTL8159 firmware
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, hsu.chih.kai@realtek.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, olek2@wp.pl, pabeni@redhat.com
References: <20260505-rtl8159_net_next-v4-3-1a648a9c4d8d@birger-koblitz.de>
 <20260701171327.2916132-1-kernel@jfarr.cc>
 <5dc0e654-0bdb-422c-9049-94ee6d8867e4@birger-koblitz.de>
 <8f349e00-1710-428d-8c70-5d1b1f4d42f3@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <8f349e00-1710-428d-8c70-5d1b1f4d42f3@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303820-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:kernel@jfarr.cc,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:hsu.chih.kai@realtek.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:olek2@wp.pl,m:pabeni@redhat.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[jfarr.cc,lunn.ch,davemloft.net,google.com,realtek.com,kernel.org,vger.kernel.org,wp.pl,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 137876F17FF



On 01/07/2026 21:29, Andrew Lunn wrote:
> On Wed, Jul 01, 2026 at 07:24:13PM +0200, Birger Koblitz wrote:
>> Hi Jan,
>>
>> On 7/1/26 19:13, Jan Hendrik Farr wrote:
>>> Hi Birger,
>>>
>>> it looks like the firmware file rtl_nic/rtl8159-1.fw isn't in linux-firmware yet.
>>> Could you send it for people to potentially test?
>>>
>>> Jan
>>>
>> The code to create the binary firmware file is at:
>> https://gitlab.com/koblitz-rtlnic/rtlnic_fw
>> But I cannot submit the firmware itself to linux-firmware, as the sourcecode from
>> which the binary data is extracted is published by Realtek under the GPL.
> 
> The obvious work around is to not convert it to binary.
> 
> 8152.c has a clear GPL-2.0 header. So you can edit that file, extract
> the two arrays, and it would still be GPL. You can make the firmware
> loader in the driver parse the ASCII array as it is. It also looks
> like you can .xz or .zst compress it, and the kernel
> _request_firmware() will handle the decompression for you.

The binary firmware file that the driver currently expects has the same
structure that is used also for the other supported chips, e.g. the
RTL8156 which were provided by Realtek and are already in the
rtl_nic directory of the firmware. There is a bit more information
in those files such as a pointer to the right flash update registers
and also version information to not update newer chips.
Another solution would be to publish the binaries with linux-firmware
alongside the bit of source code that creates the binaries. Firmware
file and source-code would be licensed under the GPL.
I still hope for a reaction from Realtek, though.

Birger

