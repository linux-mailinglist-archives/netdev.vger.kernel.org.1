Return-Path: <netdev+bounces-261941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJf/DMPdoWlcwgQAu9opvQ
	(envelope-from <netdev+bounces-261941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 19:09:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 928BC1BBCB9
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 19:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6691322E9DE
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774F437E309;
	Fri, 27 Feb 2026 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmsD1PCA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3486B3803C6
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772215089; cv=none; b=hsEe1t8ETyxVa28xebCaRt8LbYwsQARdtXzEkVkZO7zV8s9a182mxko+5TGQreFzFkzFkgv1YsL+wVKAbsW7pRWJ6AdnNZWi61GlWcp3O6+O88qdX5I+9jhPAs4iktFsKu4IBzTQfgE9Lrf3gzf7LdvFm+IQqpZK8+PXdxtv+Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772215089; c=relaxed/simple;
	bh=NyeracdKWyNBn6pi+3wRTQr7zaPyuGI3as1kF+tbyYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=puG8SP23/EgsI9FN3jRxHCD451dxC/uUN1yMuMrWxHiL+yGT1WRwYdYZPRmKsCJ/2b34Oyf1TaxRpx1HwV9hFgbaVs01sBOHPOeY0nE6tsQZ3d8QxC1m4fiIZTrgx0e/qOvUwExY1j+YPiFgNcTBeLIR5SxdEcF1RwrwE4klWgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmsD1PCA; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb4097794dso213090185a.3
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772215087; x=1772819887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=34vu+zyJcMUEr5I7RyRzrgTOo0pG7MG27hmncLWw0zY=;
        b=HmsD1PCA26UYvzEN/95TQlVJ6/Pv11bmIwRD30dzEPLog5FsXL8PN8Y4Q6BHEIHTQq
         ck7w1l7oth+wgu6eMSirzimgdjsNwzPFuo3mCd1LztfOqevzHCVMy3CFxZPp4g9Nwrqr
         J0AEfgqKMfAAxq0o48R96bNXmhyXmKdsmUWco3V22MTpaTyANlFQjzqu29Gi+bcmn2jt
         1J8tc3p6iPZaHb2Ox2Q/tBFi/bQpKYVicwhFbv7RTiSbwJjssqanka/tnTmnJ271wGIU
         R6mKDtb1/4ULXHRES7gdczEEqIPIonDBGysMz7F6ntLsOGxwqF3S8lfNtECPdlwuPQ/H
         a0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772215087; x=1772819887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34vu+zyJcMUEr5I7RyRzrgTOo0pG7MG27hmncLWw0zY=;
        b=rfacQaQrx88K44wFLHU6wxIMSvIYN7dplgqRvxx1zGYXMQHBbfu9wACX+So9D/HeTS
         iEXRIhqS95L82Ezm7lbj033nbNk66/cASroEf2aBL7G/+NjkQRe3PLZSI0mslewXhCuY
         2EJywg5KjaeD8taG7xdG9yK0EET165midwCGjc1tedpFz2SvIPfpbTJZzNrzifAL8Y+0
         pEgMhqbM1OaNU8s4xmNl26WOKNjkfW+PHmtXkfRO/kXUDivRgcOclgYoU2zUtniP8rf8
         bGcNZi+oRLxK4/i03EfwETbkH1oQ7bZq3XRQ0wmBIs6fDbPEje5VbdkzqA0Qji4c4C2K
         DZgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT0T9IP1eWPTPBWn6ESheLDQFEau1Y6cvJjgOceldOH7DTVj8wIyjjci2G6K50ycBy0roEtDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfpZNjiWocMUpx/HHGcTkCRvcKM9UcapFnUkOPe2UlGaOgwqR2
	QYD63wvCHjpBAgD/uwTqvthv4vAOK7M6Pjiuci74RWad2bOvM5vlnBi1
X-Gm-Gg: ATEYQzyRWWsT9hMOLgLS8KfibaymULH0nJjQEB45Df8HDEbATG/6UYv7hihV5mLt2o2
	uvsQmxnTa0/xNdCWJDzcf9D/06xr2nTIXyISJLx3Okz/6BoaJ2Nm/Ip5mnWei61CbcWpUSrMwoT
	WWbrmBqy01vjP1gbNlR5T5i0nEnLKgF13MYo0MM/ZQofPLtzepTyMqCQQ/bNeiM4j0GUTGo72mY
	vOVUqBLQI1srUtxjU6LU+Vgcn1GIJ1Oev9SZzvZx6cK9mGFwOofCfl9uORQru5e8rTHown00Nzb
	KIIoBeFcI9gkECtjbP4Z4cY6G6TWMAiRLfUgol/oisoh4ZqoLFc32q4E/FAp/IApU0zb0Ue/EzZ
	xC3Hh+alGH3mdIKyAnCMUQ6w1Kkqs4K02uoK6hwpfbXbKDhI17GQHEDuwawuKkcQvzQtAbbEiFK
	YJ9TH+dTk8w+ekVKkpESZyCR7QmmhBGOz7u6tXuiovaqN7vP8vWWPWcz3Dj90q
X-Received: by 2002:a05:620a:4608:b0:8c9:f8e5:9f12 with SMTP id af79cd13be357-8cbc8dfb5afmr455318485a.57.1772215086986;
        Fri, 27 Feb 2026 09:58:06 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6f93b5sm510289385a.31.2026.02.27.09.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 09:58:06 -0800 (PST)
Message-ID: <eccf1d40-e4f2-4ea1-a8e2-328606fc0860@gmail.com>
Date: Fri, 27 Feb 2026 09:58:03 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: b53: prevent standalone from trying to
 forward to other ports
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hauke Mehrtens <hauke@hauke-m.de>
References: <20250508091424.26870-1-jonas.gorski@gmail.com>
 <ce4d9b7b-aaf6-4796-94fb-8c3d6a1dcd4d@gmail.com>
 <d7f9775e-0af6-4294-837b-47e31e0d30d7@broadcom.com>
 <CACna6rw1kF-r40dr-nxouV9E0AigmeVj9fxQm_Px34Z_n2up9g@mail.gmail.com>
 <CACna6ry9B9LiPbWdXzi7FCcaU1YC+HPkor53AiSEaRSNUMcLwQ@mail.gmail.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CACna6ry9B9LiPbWdXzi7FCcaU1YC+HPkor53AiSEaRSNUMcLwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261941-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,broadcom.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,hauke-m.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 928BC1BBCB9
X-Rspamd-Action: no action

On 2/27/26 05:32, Rafał Miłecki wrote:
> pt., 27 lut 2026 o 13:23 Rafał Miłecki <zajec5@gmail.com> napisał(a):
>> czw., 26 lut 2026 o 22:26 Florian Fainelli
>> <florian.fainelli@broadcom.com> napisał(a):
>>> Could you try to program GMNGCFG (page 0x02, offset 0) bits 7:6 to have
>>> the value 0b11 which is dual IMP port (IMPO is port 8 and IMP1 is port
>>> 5) and see if that helps?
>>
>> On my Luxul XWR-3150 (it uses gmac0 and port 5) the value of
>> B53_MGMT_PAGE (0x02) / B53_GLOBAL_CONFIG (0x00) is 0xc2. Nothing to
>> set there I suppose?
> 
> I tried other possible values:
> 0x02
> 0x82
> 0x42
> 
> None affected my switch / wan / lan ports.
> 

Thanks for giving it a try, how about the BRCM_HDR_CTRL register 
programming (page 0x02, offset 0x03)? Can you see whether it is set to 
0x3 or 0x1?
-- 
Florian

