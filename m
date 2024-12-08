Return-Path: <netdev+bounces-149998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18629E87CD
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 21:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CB6163F86
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 20:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF24E13B592;
	Sun,  8 Dec 2024 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="1+xDsx27"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5891D9460
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 20:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733690057; cv=none; b=DI05rUAWZkt3m3BIIzsInHkP6MF88Saz7ixukNUAoWNa9xznMHK45wUYu9OWoxVNXGwsOweEeGFn2Bcn4G6NKmafUYARNcZJH1YyuhNuBlJ+LSlrjZuaF0VvCH0xfkaXI7Cu0tQGTdZLDwnWArRhwc6iU0ZJgVmBtOseVH6sVig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733690057; c=relaxed/simple;
	bh=pNrqIk3HpjkzXjt78tMOqkOHaDPRWMm8HAACWjnoBto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfIy0ZYw0DbDK/iZFIa6Pf0J0MavRVuie+Og6B3stVev1sBjoJsju27jEz1xkKUVnmJgkpzRBb9ZwDQWLntXFqxlWmjSpPRIpA57PqF3n8gsqVoeQT4iWppwxGMlZmpNzfR+q17RAGKDsaukUz8SNxpGqWhLFNPUeYpqi7w8Qgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=1+xDsx27; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9C14D2C01D5;
	Mon,  9 Dec 2024 09:23:26 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1733689406;
	bh=iOAaPQH6Oq+/Dn/tDj2Rvor3y/O/oTixRDCGSQdLv8I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=1+xDsx27d3SfF9dA3MHfcuSxGQ52YgGAUmjwpRRkuJkv4MdNbJSljyWmoVn1mBdzt
	 uBenQBhBVknsqzmtJrO8d88/rB6XOTdK/06jpVd4zRnzlBKO8biQ73INY/rcPkmEAg
	 L1L6oaMx7iJQfLBFtEOdtv6gh0fLwrG/oOIyoynhNPwNZHmE0FFy5QxBLghX5dAvSJ
	 ovQLeeXTc3iTCYPgK4XPJLVrKMsNBETB2Sg+agw3D8VGkfVDC0Ec7cQY3TN5IaDMrh
	 W8zT4qD7++Azp8o+Sv+YL/czvDUNmiDt192rTVKUeRE/2QffhiWTjJo9AAQ+A56AfE
	 gpy0SsTnHczYA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6756003e0000>; Mon, 09 Dec 2024 09:23:26 +1300
Received: from [10.33.22.30] (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 8617513ED0C;
	Mon,  9 Dec 2024 09:23:26 +1300 (NZDT)
Message-ID: <a01c7092-2642-4091-a085-07272b450471@alliedtelesis.co.nz>
Date: Mon, 9 Dec 2024 09:23:26 +1300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net 0/4] net: dsa: mv88e6xxx: Amethyst (6393X) fixes
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 netdev@vger.kernel.org, linux@armlinux.org.uk
References: <20241206130824.3784213-1-tobias@waldekranz.com>
Content-Language: en-US
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20241206130824.3784213-1-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SEG-SpamProfiler-Analysis: v=2.4 cv=RLIQHJi+ c=1 sm=1 tr=0 ts=6756003e a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=VwQbUJbxAAAA:8 a=vivaPATRc73yjkcZA2IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Hi Tobias,

On 07/12/2024 02:07, Tobias Waldekranz wrote:
> This series provides a set of bug fixes discovered while bringing up a
> new board using mv88e6393x chips.
>
> 1/4 adds logging of low-level I/O errors that where previously only
> logged at a much higher layer, e.g. "probe failed" or "failed to add
> VLAN", at which time the origin of the error was long gone. Not
> exactly a bugfix, though still suitable for -net IMHO; but I'm also
> happy to send it via net-next instead if that makes more sense.
>
> 2/4 fixes an issue I've never seen on any other board. At first I
> assumed that there was some board-specific issue, but we've not been
> able to find one. If you give the chip enough time, it will eventually
> signal "PPU Polling" and everything else will work as
> expected. Therefore I assume that all is in order, and that we simply
> need to increase the timeout.
>
> 3/4 just broadens Chris' original fix to apply to all chips. Though I
> have obviously not tested this on every supported device, I can't see
> how this could possibly be chip specific. Was there some specific
> reason for originally limiting the set of chips that this applied to?

I think it was mainly because I didn't have a 88e639xx to test with 
(much like you) so I kept the change isolated to the hardware I did have 
access to.

The original thread that kicked the original series off was 
https://lore.kernel.org/netdev/72e8e25a-db0d-275f-e80e-0b74bf112832@alliedtelesis.co.nz/

Since the only difference is the mode == MLO_AN_INBAND check I think 
your change is reasonably safe.

>
> 4/4 can only be supported on the Amethyst, which can control the
> ieee-multicast policy per-port, rather than via a global setting as
> it's done on the older families.
>
> Tobias Waldekranz (4):
>    net: dsa: mv88e6xxx: Improve I/O related error logging
>    net: dsa: mv88e6xxx: Give chips more time to activate their PPUs
>    net: dsa: mv88e6xxx: Never force link on in-band managed MACs
>    net: dsa: mv88e6xxx: Limit rsvd2cpu policy to user ports on 6393X
>
>   drivers/net/dsa/mv88e6xxx/chip.c    | 92 ++++++++++++++++-------------
>   drivers/net/dsa/mv88e6xxx/chip.h    |  6 +-
>   drivers/net/dsa/mv88e6xxx/global1.c | 19 +++++-
>   drivers/net/dsa/mv88e6xxx/port.c    | 48 +++++++--------
>   drivers/net/dsa/mv88e6xxx/port.h    |  1 -
>   5 files changed, 97 insertions(+), 69 deletions(-)
>

