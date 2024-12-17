Return-Path: <netdev+bounces-152653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674F89F50F5
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 17:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB4A171C49
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4B01F76A8;
	Tue, 17 Dec 2024 16:18:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5311F7072;
	Tue, 17 Dec 2024 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734452328; cv=none; b=br9WDlmX3JrYXwj5kMIqi0i6FOmovjq/roirCtXaK2SfMJaszxuXtkyQ8GoKq0Vh3OfPIaCC9eo1T5HmVn31037eCGXj63+JAPedvYqhj6fXzaRp50M/wnRKyxE2Lxq6fWhur146tmCEGNZGOkePn5e7H1wQaH9auAqBzp7meMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734452328; c=relaxed/simple;
	bh=I93e/VnWVescUTGnvK3q6Y6qvBqAjHA5yDdSXSqpBwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8m4DD9udlKr1WueJl1Kjwk3nZhNE0+hD2hIGiDTKsLZtYhoQPYSxXFbzRkB/PZp+BjsLepxFnTgJgSgdZe6BMmA3LBwPH83me9P6pA3/w38hp04PgQaNMTUKePk75nIdTmzmIYyLgxCdYT47IFndfYC9eG0gSRniB8ogUgsJ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YCMSL0YPrz9sPd;
	Tue, 17 Dec 2024 17:18:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id snivsrQPPmxU; Tue, 17 Dec 2024 17:18:41 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YCMSK6qHhz9rvV;
	Tue, 17 Dec 2024 17:18:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D6FDE8B770;
	Tue, 17 Dec 2024 17:18:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id q62DS3lFN-fC; Tue, 17 Dec 2024 17:18:41 +0100 (CET)
Received: from [192.168.232.97] (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1F2758B763;
	Tue, 17 Dec 2024 17:18:41 +0100 (CET)
Message-ID: <c1d52a7d-b6b2-4150-99c7-a67b2a127a18@csgroup.eu>
Date: Tue, 17 Dec 2024 17:18:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: sysfs: Fix deadlock situation in sysfs accesses
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 TRINH THAI Florent <florent.trinh-thai@cs-soprasteria.com>,
 CASAUBON Jean Michel <jean-michel.casaubon@cs-soprasteria.com>
References: <d416a14ec38c7ba463341b83a7a9ec6ccc435246.1734419614.git.christophe.leroy@csgroup.eu>
 <c0a07217-df63-4b5d-b1a5-13b386b0d7d7@lunn.ch>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <c0a07217-df63-4b5d-b1a5-13b386b0d7d7@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 17/12/2024 à 16:30, Andrew Lunn a écrit :
> On Tue, Dec 17, 2024 at 08:18:25AM +0100, Christophe Leroy wrote:
>> The following problem is encountered on kernel built with
>> CONFIG_PREEMPT. An snmp daemon running with normal priority is
>> regularly calling ioctl(SIOCGMIIPHY).
> 
> Why is an SNMP daemon using that IOCTL? What MAC driver is this? Is it
> using phylib? For phylib, that IOCTL is supposed to be for debug only,
> and is a bit of a foot gun. So i would not recommend it.
> 

That's the well-known Net-SNMP package.

See for instance 
https://github.com/net-snmp/net-snmp/blob/master/agent/mibgroup/if-mib/data_access/interface_linux.c#L954

The MAC is ucc_geth driver, it is phylib for the moment, it is being 
converted to phylink in net-next , see commit 53036aa8d031 ("net: 
freescale: ucc_geth: phylink conversion")

Christophe

