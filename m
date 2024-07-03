Return-Path: <netdev+bounces-108659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA1D924DE6
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 04:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ED72B27503
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 02:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0521E1FB4;
	Wed,  3 Jul 2024 02:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="rvzpSked"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54A2523A
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 02:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719974373; cv=none; b=ks62r8oYMXfKB4Mi/UtujuMfVuiJxCqb8CBoOCTjw7z6oaTiAU245Z78D+jh1aNh4Ri5SJLz86fEzdMbPORWcqMcR8lHQ1x+1E/FOYHf9Wx1UXdOrnx4uB956KHsGCJmznrlrZIyQOmQHMt9GkdYNOJ5q3ocMUVWTTWipIVI6zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719974373; c=relaxed/simple;
	bh=nesRTquYSmAgGVBGCb6VKWwFQ3BzkeM3+SZXjJ0qOSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEeJBOv2rERXCeGQSepPVdsEgTPVAiWiIRi4VMxAVJvcn+OnNgoREwTD2k0kuWlXeKegHU3Dyl1RFr8GMF81QL8igiIn6jScyaFSJwvN/fCMEjFsj2Ro7OhMyeAQD7G49F461d5nw8Cm42SawECsdjP1KIuVLZf5CH33YJidebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=rvzpSked; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 8F7082C044B;
	Wed,  3 Jul 2024 14:39:22 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1719974362;
	bh=mSPdwjA6VRheCRrQxnrkew5mjmQX0ILCVy3v5OXgySM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rvzpSkedJ7CyBO8MdjZPYq5M5JkPmqpS9lKgIzDAMy09c4u7rCWVYhOuDNP3jltWA
	 pSLOJ7jdTq/MEZ2Eshp800RzozG3qfolob3q9n2BtC6EQ6MGiZUHZRPm/ixRXpDGFh
	 Krj8RZdwhqB/im71DwvglQCHe54s27aum8x1eluTJzUxs4c0x2jtvE1V4pThwYlBkC
	 pSM9IK33DmsBHVcOlFfRRfCP0TqAUoEaWc8xbgIDaTyN3TURnPx47kcvx9CwpkF5Oi
	 EnihWH9g0CS3O1J937xz081PMyxTe1FUnzDB4ePk5zpidtOta8Iuqa6N+Nw9OUe21s
	 vFb4x9YJRgzTQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6684b9da0000>; Wed, 03 Jul 2024 14:39:22 +1200
Received: from [10.33.22.30] (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 6627D13ED5B;
	Wed,  3 Jul 2024 14:39:22 +1200 (NZST)
Message-ID: <c8132fc9-37e2-42c3-8e6b-fbe88cc2d633@alliedtelesis.co.nz>
Date: Wed, 3 Jul 2024 14:39:22 +1200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: net: dsa: Realtek switch drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 "alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "olteanv@gmail.com" <olteanv@gmail.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, "ericwouds@gmail.com" <ericwouds@gmail.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "justinstitt@google.com" <justinstitt@google.com>,
 "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
 netdev <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "sander@svanheule.net" <sander@svanheule.net>
References: <aa5ffa9a-62cc-4a79-9368-989f5684c29c@alliedtelesis.co.nz>
 <CACRpkdbF-OsV_jUp42yttvdjckqY0MsLg4kGxTr3JDnjGzLRsA@mail.gmail.com>
 <CAJq09z6dN0TkxxjmXT6yui8ydRUPTLcpFHyeExq_41RmSDdaHg@mail.gmail.com>
 <b15b15ce-ae24-4e04-83ab-87017226f558@alliedtelesis.co.nz>
 <c19eb8d0-f89b-4909-bf14-dfffcdc7c1a6@lunn.ch>
Content-Language: en-US
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
In-Reply-To: <c19eb8d0-f89b-4909-bf14-dfffcdc7c1a6@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SEG-SpamProfiler-Analysis: v=2.4 cv=CvQccW4D c=1 sm=1 tr=0 ts=6684b9da a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=CfxWgEXZv7hflEJXd20A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat


On 2/07/24 14:50, Andrew Lunn wrote:
>> What would I be loosing if I don't use the DSA infrastructure? I got kind of
>> hung up at the point where it really wanted a CPU port and I just couldn't
>> provide a nice discrete NIC.
>   
> DSA gives you a wrapper which handles some common stuff, which you
> will end up implementing if you do a pure switchdev driver. Mostly
> translating netdev to port index. The tagging part of DSA does not
> apply if you have DMA per user port, so you don't loose anything
> there.  I guess you cannot cascade multiple switches, so the D in DSA
> also does not apply. You do lose out on tcpdump support, since you
> don't have a conduit interface which all traffic goes through.
>
> But you should not try to impose DSA if it does not fit. There are
> 'simple' pure switchdev drivers, you don't need to try to understand
> the mellanox code. Look at the microchip drivers for something to
> copy.
One reason for using DSAI've just found is that in theory the RTL930x 
supports a CPU disabled mode where you do connect it to an external CPU 
and the data travels over SGMII like you'd get with a traditional DSA 
design. It's not a mode I'm planning on supporting anytime soon but it 
might come up when I get round to submitting some patches.

