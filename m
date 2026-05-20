Return-Path: <netdev+bounces-289792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFYxGrlZDWpuwQUAu9opvQ
	(envelope-from <netdev+bounces-289792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:50:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF29058860D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4B8730205C2
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B70334D3A9;
	Wed, 20 May 2026 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THIjqPKX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCBF33F8BC
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 06:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259802; cv=none; b=pfyuRs3YkfglBz/EF7C84hdrAZqgbXzSlajeEjQg/hlFjFFkns74BCgdXtKErYf19VBc/xoJftA/+aab3RdJHQbGtS7gjdqbwZezRmwodZ1OPRNNYAEUiyR7gIZ8kYClgHpZULFlebYzBh6g1c6aHHIzn00crCc3Oubp6q8BEoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259802; c=relaxed/simple;
	bh=qt99GYg/1shljr6n/ZEewGKE7srK7gzVSvn5dxL10OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8OW6z4h83oz1T46fcwQ5cENu3rffKSgjMXfJ8T3HC3TkJZp/nWReVleYjY9f6irwP1g/vzxJhOUCsGMX6DLIeGVPk4/NHtQkv+CskYTgHfmI+1Vu4ljX8zXTfk023NoQtYy8a2zqsLQIxJgtstGOE7NPyMbpVJEY7I1NSh1FdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THIjqPKX; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44c350a5b87so2655427f8f.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 23:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779259799; x=1779864599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mchzN0Z6nfnR1XaYP0jBIFjxXcTRqvaSqlUOs9Gpon8=;
        b=THIjqPKXvpab7sWexlmGvwlBRXeI8Xr4JMcaEpe9e3GNYDOvyjr6yVQgBtit63oHmR
         dc5kbIZitf2GEI3wROs0vHQjdHqG8RbXc/GwInS52/FLnvOR/0rpqjKWSfE25KekSsHN
         r1vxyukCi+aFTCt52htCk7X3BHLW6tt96jjw+Xj4WbuTL+2mExn6colH0FTKRugsKu7k
         fXW4Ndl8YMDpWPE3bZZd3pJmtADOK8uMIEFwTyVJQvj/E+/hkOxNfhkc5yGhO7hzAcOj
         7c3d8tLz98ILPZVl/qOJyHvPH7inO2bUcdE8g4Walx5wQo9xb1k73Pd6fb+K9MsHqj/P
         wocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779259799; x=1779864599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mchzN0Z6nfnR1XaYP0jBIFjxXcTRqvaSqlUOs9Gpon8=;
        b=K7uZCYdwMjpgJeigQZi19Fy0u5lk0hx2yPD3ORCPXSpwXpLx9S6PTDGN64KBNhzIGk
         xWBdMLISaYYGPNm8Q4AOZKpvj0ahM2+zCcgHRLnvtBgWI6purZKEN31WHvPAfqm4+u6/
         YzpVe6TXQ1JMXxlNCVNuZ1LCzUWS7lirsK9IemFwhAOVfccuPM0tKbdxMwK01QTAXv+4
         oJVa8KEA78w0luYIU1fR25I+iYj4Rflij5ha2LdK6Yx86OEeTssDeCFhzBkqWNR6nxcF
         eu4k2a3+WaBaADVycQ1lo3v/A88bAgDocm2n7ujrepxmX4/edc9h80zX3vPJHkLEfE1M
         9itg==
X-Gm-Message-State: AOJu0YzQCGxfD/lK06Dr7iveIbUdwEvZpw8kMjidwSCsa/WLWi/rALno
	1JcEh1Fp3tqsLAHWw3qI82rCCWEJOSLpjGS+iYo8dlfPsh7eVrHAaZwh
X-Gm-Gg: Acq92OH3fabFIqUaVgpt5Za4PN9prhzm+PXfHzYblsjC74TFhV5bMZogzJp9VkM+jbT
	OGB3o2O6IcrmiLKI2iqvvKgjGqEw7eJBuCcMZQAv6E6eyy6HEFnSYCzYJp/khhnhDlTAvz7M2e9
	KHdZyBFOJfXZHeDZX4x6YEpt9DLPt2EBGnmlFiY4qVLWVAh2VcwVfALZCXOi5ttqtsdsyKP6+T1
	nFN92da+vzip9hcfoxOpDqjsfPKHwLSU2sfLEVUOhWV2mtYCLkNXVoilYBizBt4d2StgFUWhEdv
	Bg8RJi+LnESbPCiUEvVf+pg6qoL8WkwIzMtdRC3/cqRQLrK8pJWeXLAGiMz9dxonNPKk8/biHwu
	yFos65O3ukQFDj1OGSFZXtik7whbnjCaa6ZrgWfU6l5coF3RHWvdVGGAFCET0q64YXVh4FOa5TT
	GNFsNCrN45HCdTM1kimWW23JMARRY4o+6J8XUBIYkFx9qMsAtBaD3eSxJjPkYDRFxc8JR5rGOI2
	rdILiUTDQ==
X-Received: by 2002:a05:6000:2405:b0:43b:3e40:2223 with SMTP id ffacd0b85a97d-45e5c5b9673mr37127459f8f.19.1779259799002;
        Tue, 19 May 2026 23:49:59 -0700 (PDT)
Received: from [10.1.0.164] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a17ec2sm48407651f8f.24.2026.05.19.23.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 23:49:58 -0700 (PDT)
Message-ID: <ad1d07ed-2fe7-40c3-a043-dd6d2c1c4f8f@gmail.com>
Date: Wed, 20 May 2026 08:49:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] ksz87xx: add support for low-loss cable equalizer
 errata
To: Marek Vasut <marex@nabladev.com>, Woojung Huh
 <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Tristram Ha <Tristram.Ha@microchip.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260505-ksz87xx_errata_low_loss_connections-v5-0-da4002b21c42@exotec.com>
 <fe01752d-95d4-4686-b536-0acc8a2046cb@nabladev.com>
Content-Language: en-US
From: Fidelio LAWSON <lawson.fidelio@gmail.com>
In-Reply-To: <fe01752d-95d4-4686-b536-0acc8a2046cb@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289792-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[nabladev.com,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CF29058860D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/16/26 03:44, Marek Vasut wrote:
> Is there still anything left to do with this series ?

Hi, sorry for the delay I just got back from a trip.
Thanks for your feedback! I’ll fix everything and submit a new version 
today.

Best
Fidelio

