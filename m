Return-Path: <netdev+bounces-252528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPKQCJuEcmkrlwAAu9opvQ
	(envelope-from <netdev+bounces-252528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:12:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 427B96D5AD
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A74230107C7
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B6939DB28;
	Thu, 22 Jan 2026 20:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsCIm77d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBBD3803ED
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769112725; cv=none; b=D+N3gbyXLRtpKcLCgA8WFnHvfeyb6nZo1MchI7BUT00qy+ibu18zaRzBYQEFaprpKhwwlsnfz1beqQyyHrE9zKAnqs1eQD23rbbI9K0o2I0gHuqyGPzZClUpbRtazltnvQsDXVeCmhaIaaZfhTHU9sfIsLpuo8B4FKFjOM7kvC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769112725; c=relaxed/simple;
	bh=SENpyB9AVSM6aGpKBfO+VZEOuzUU6Av5VAMGeTiWdIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Laoyo/yUa0vh1j3y2/ZreJ2AEYi+KrTdwziyiuMdd8BTWI2SeJ7Jifrk0OEwvfoOEjf0hgmNIOaWUxzJMdg2CCBOs7E6byNdoGnbvo0IwD5s6Dnwiqrxhy5SEhq8gprEruxqyaeVziz6Ty+N62IiFO221zaeeZiaMaRPYEiVBFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsCIm77d; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43246af170aso811756f8f.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 12:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769112715; x=1769717515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4PTMWZ1WhD/oas/WRbF1tXYFUwtQejildx7bZPHy8bI=;
        b=UsCIm77dCvLX5Xc31WCj+e+/WCe8GCDZq1ssbL1L1/HzAlqO/xvuLnfYiIEwBx8y7j
         TiEQtTuhUnL648P+GiJoVDjQoqcod6f/glue8pMMA83Z4sdQ7N9C4ugcaoamLLNDT0rW
         dK9Q+4RyLj9XA3/AiKdyDxRxt8AX8QzroANTdkzlchZzYBjfFI8OHQCPnsZntompXaqD
         qV3e7WEKwwqv+kHLq9VgA0lTHUfZXnKJWPej21JfNryx9Y4vE+U6VYFV0mNBEpM+FoBy
         hu1slylMVWtGE+sBNMDrBMWT4slv5pqqSGUXkcm4qIBdboWJLDwwVXeiWxPt6AVg+755
         YlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769112715; x=1769717515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4PTMWZ1WhD/oas/WRbF1tXYFUwtQejildx7bZPHy8bI=;
        b=HTDYp5fztNZthVkui2A8CbsU77Vq9LsvWui8CvuAz1O+QhoyKdEbZZrzxa6QMgFPQv
         HIHscgsclDpR3TxBgftY562ggTMau4vsVhusq1kWut9cUmANSWy2asui2mue/MeKYOwk
         P58Xc2wMdcaUUPkpO5aHM5YFLObAL8c28oYfnberZzMmjlFyTRRLyJzkJHdM+1XVOl7v
         PYIGyxC2HDpqLjH8qwq32upcYeMetRbfVq10OEiFw4gLG8cmCG+L4r8zClkZw1JVOuy4
         MJXxINVYdq+ebjFFOGychGFHpuMNyuLxfKkT9rDsu0QUB4CzJ2T5FEKBdrzI5NpIkudc
         iC4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfdK9Zb1Rx+yY+qSkcBnwGC2TMHqtNWuD4kV7Q3fhYY8UcnxtnlDEJnH1M5YQws4t0kwNcrII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlz8U4LvlXjABLTIqBFc77DNleRkvjbDmqWVDloYZqwCwY8TaB
	iksT/ymVYoQ2usgag+ClcdyQssfh3g+vMHn6qYOu13FmTihD4/FljKXWxk5QYQ==
X-Gm-Gg: AZuq6aIMeBRRW9sYUz2xvz0xmGcxEKmfzu1ABh6Y1rxtP4zwtwug54GFsNlOTUPH5lL
	2usgyzeYzWbR4MbAe3B47lh3o4UOt3qYJ/PBDY9qpK05ho0WZ2rhj0RKNFQANZTLNn2BbPzIJPC
	Kic8J624UN4MMbrkG4xek57zNJGkddvtVutLDeVZ1cLkgdshfcc89OFbhAey1CF3xvL8zAK8V49
	njOqGVPGWklN5YTO5SIObeo3me8YefL4ifhQzh8V0QrdUQ6ubqKPI7pd/gl6lIQpxIlgqlMI9eP
	vP98g5ErVlCdvVIRE2U5P/YKE5WId4O4Zr44d9VNCkkEWR1qOKtZXMIhQxoyUmM+Pdix4OMKxqO
	kf6MdgqVFgjIaMSMGmIT2hCoy1hALeGwzSBp2u+bOOPoh1L1SEq9+w3uQC8aubqQ2jkD8C4n7MR
	ppzglP8RryLZWSRXTC+O/pMt8PXJ0c/XFN9Jle/PAjdbrEbNOOSwKhBphLXtm8rXockXndDycQX
	Q==
X-Received: by 2002:a05:6000:420c:b0:430:fdc8:8bd6 with SMTP id ffacd0b85a97d-435b1ba2feamr1030500f8f.31.1769112714838;
        Thu, 22 Jan 2026 12:11:54 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e715bfsm1079901f8f.22.2026.01.22.12.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 12:11:54 -0800 (PST)
Message-ID: <1bb7607e-b078-4e30-bae3-9d9a8ab627f2@gmail.com>
Date: Thu, 22 Jan 2026 20:11:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1126015: linux-image-6.17.13+deb14-rt-amd64: ethtool -x
 <sfc-net-driver-ifname> causes: rtmutex deadlock detected
To: Ben Hutchings <ben@decadent.org.uk>,
 Salvatore Bonaccorso <carnil@debian.org>, linux-net-drivers@amd.com
Cc: 1126015@bugs.debian.org, Damir Mansurov <damir.mansurov@oktetlabs.ru>,
 netdev <netdev@vger.kernel.org>
References: <176891113233.1085.14440184213728685693.reportbug@elrond.oktetlabs.ru>
 <176891113233.1085.14440184213728685693.reportbug@elrond.oktetlabs.ru>
 <aXBdvYZIePCFGtY9@eldamar.lan>
 <e4dcf5497e3840706b2e13d10c7efff1819c14a6.camel@decadent.org.uk>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <e4dcf5497e3840706b2e13d10c7efff1819c14a6.camel@decadent.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252528-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecreexilinx@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 427B96D5AD
X-Rspamd-Action: no action

On 21/01/2026 12:39, Ben Hutchings wrote:
> The deadlock seems to be quite straightforward:
> 
> 1. In net/ethtool/rss.c, rss_prepare_get() locks the net device's
>    rss_lock and calls its driver's get_rxfh operation
> 2. In drivers/net/ethernet/sfc/ethtool_common.c, efx_ethtool_get_rxfh()
>    calls the chip's rx_pull_rss_config operation
> 3. In drivers/net/ethernet/sfc/mcdi_filters.c,
>    efx_mcdi_rx_pull_rss_config() locks the net device's rss_lock
> 
> Step 3 seems to be a workaround for missing locking in the ethtool core.
> Since that locking was added to the ethtool core in 6.17, it needs to be
> removed from the sfc driver from that version onward.

Analysis looks correct to me.  I think the appropriate Fixes tag is
040cef30b5e6 ("net: ethtool: move get_rxfh callback under the rss_lock")

Unless you want to do it, I'll post a patch with Damir's Reported-by:
 and your Suggested-by:.

-ed

