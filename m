Return-Path: <netdev+bounces-300009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Bvn9DXYUMmr7uQUAu9opvQ
	(envelope-from <netdev+bounces-300009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 05:28:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F26D6964C6
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 05:28:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GgHJfOy6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300009-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300009-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FD7F30BF58F
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 03:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534BB3101A2;
	Wed, 17 Jun 2026 03:28:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6ED3101A6
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 03:28:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781666931; cv=pass; b=F0sJEg9xJk7PoQJsgtadUe/02/rw55jFNiZrtfke70yXNMBkXUljKtkdCUFt7jaKnGk0RJ07PGERfQdUjoQOnsiP1ETQb81BkSQu1WyglJ4ZNOOTzmCqgwRC5upuEqJiUlHBttsUvHrdcBhqit9RqtpMNnkQbJJgepZ28sEjUTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781666931; c=relaxed/simple;
	bh=xqjJADKfrkn3rwMiranC8aLL0xJmVJkY2n3k9Sk6ML8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjJ3KoGSXxMolJTTi/273k5k1JDD6lGjbnxHjRGgSS4sOlEQz1WUbtWDbqLnPiV3UEz7LTluuDJ9vNoLEtIDsiG81I2WDgt4t67IjB4WRq2NlTKqi0uWba6Q3wXlTYPkUCX/LhNHk2i6sJoYBvyomTbUPPmfqwtQ9kNRXu5jgHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgHJfOy6; arc=pass smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490c1915793so43590945e9.2
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 20:28:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781666928; cv=none;
        d=google.com; s=arc-20240605;
        b=jYituoByjRoS2luX7AzpCsXkpUabPzKKLW9is46HY3BWmx0ZfUVf9/9YluCjtSPHk+
         B69fSLocNV/NAOPV5S+aNwUZp6MWHDgCi/TAFpArkA7PSGq62Lf2kcMnqGwAqj7CVW1n
         MK/zRSEdqNG66tcIawYE5w67ypPw/Obhm1b8ynSm8JGXhOnmKrZ93C+gDxHESoCYkpIC
         EMxFNuPzeXxsXGL6nCO8UqryWNl21LL+4hapnYSiCJlRuytZJdP9rylCfE5s1urWIOqp
         TDKXfI/ReVAdv/0ekz9ToHwAjW57oezMm7EoZtkuBS8h8eJLTgFtTwFY/ardGH5aCwKG
         x97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xqjJADKfrkn3rwMiranC8aLL0xJmVJkY2n3k9Sk6ML8=;
        fh=WSmEA6LQoq8/Hmq8y0OsXGV1slAArEdIvKJkQE9KS5Y=;
        b=hFWeG2Pa84t6Gww6bMecbmOT78zNRJSaMxo030R1htl/KrAwOfac4lC2edwGkXpM8v
         p7JW33n0Of3Df90sq12mVDWXFTmlglU+sBTPffkwIT7TJbLVShWUxek4hu080sYHj9Lv
         6LahRu60AH5xPc3kWyV7UvlUoOC0532s6jVMkqU7kTFx19t/Ni7qVMC290xTHRDiaCol
         Kh41pD0OKo1p5FHxsAyV1gp1qsf0E1PY/UX4Bdbrtcbg8u/unsgggN2dTGlZMu+bqmrx
         gitTeh199Do6B/aYYJWbw80N771NTzWb8IYEzXrCytFPFsXpUrRF0WKGKzVPU5x/Mq9/
         eCEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781666928; x=1782271728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xqjJADKfrkn3rwMiranC8aLL0xJmVJkY2n3k9Sk6ML8=;
        b=GgHJfOy6tCQP1zaGsFyadSQkRSzqxJ76rxT++mogPabMf47XHUAtrtQT+zCHN8oCP4
         dpk1zaNNdOb0mEhLcQXgsw/B97dofapvAZxX5A2LNxyatCx2Ld2gyEBXvDzEMCmIhYwR
         JAOmUnwlXj/a5nsWTk37Pp7XiYkUsSO3SV1thnp2ndnY+ITsgT0RAjq9c9Aqz3pYxIgH
         V8d68uY3ovpt+cQ4fuH0ZIJvCVRKGv7X8cr5IyZ3fHLN66Vp2dvCDMQ7Ih1RmWyfe32f
         iOEWpdw6bBQXog5NuU17+TNhwQPkQhNX7bTAMsR4FwXNP9ePriVCsLIlrWMh24L934P5
         NFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781666928; x=1782271728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqjJADKfrkn3rwMiranC8aLL0xJmVJkY2n3k9Sk6ML8=;
        b=bzH4KJcmFgPX66246BL6qjR0pROekj5oDx4O+/y+X5y8lkBDYgPL4IpDnynoJzvnO2
         PZBzdSvZuVDC9LVgvzdsPFs5EPoCsKMZZSqprYZVnPuXma4lsQ4NTcA4M+pr29P8ovzb
         L5UcdjvOKQDAPkaQmIVNk8x1Qh7m9w05IM4oLOctmU7fPsWRYEFiT5RrlJ4rdDChsBJg
         DrctlKuO7A+rYThJXX6OpNZmSCexapP847hKEhOqAcSKX4wJ62kxAZwwIWFJ+65bxH+X
         DUkQ9e1S8eqi4hiz66NIMmErwZ5dRHWzVwiY6l9YNLTCnHV98T5W98J5b74ot8J64ccE
         SbMg==
X-Forwarded-Encrypted: i=1; AFNElJ/7kADlhNP6oPhg0oUAnKOX5/3RybZ6n9JMqrwUE8WQmnFjN/CWOe0GTyGEaPAYw+RE3U6jfQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWiZ72ueBfEDsBrOlweUEbnGDaLa1wJkaaV2hJbM9/YQzXtloC
	+3+mDyVVpm8L8AkFtwmXtrsB6NdDcGkt40NOIUiEDw9jOekDlsj9WeIc+FQJSnA+Ve/i41P31qL
	PYPndl0h1gFexFY/H0Dns3z//Mmlf8G4=
X-Gm-Gg: Acq92OEuGNJqj55w3CNRHtaCaS0/XICw3ezip5oSymrj3b1YHhczl+n7fi23FLYziV+
	2+89wJ3O3KuSE06oFtzVa5Ug5usTQr04aHaaJyWbe2iHoa1TrvgrY/LFoRRcOrMDg2Sa170LbT7
	F0YAGJn6xiTAeKL0n6tngHHN3A6jm3WdG8L58fVX+7RHRKmg201TYN47yA4qSg56vTQMsQy29jf
	tCmIkpKcr0tt+7pFOeq05AXZ15DCb5ho5ilekhxxklFXFF/l2RMMesneJq4CWoqxtfePqAcgHZx
	ry+0PQ63ytBR3w67Wifm8S3O2NQ=
X-Received: by 2002:a05:600c:6386:b0:490:bcf6:469f with SMTP id
 5b1f17b1804b1-49234b36ee5mr1466845e9.0.1781666928162; Tue, 16 Jun 2026
 20:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614054137.32181-1-atharvapotdar07@gmail.com> <20260614220934.GA3575431@electric-eye.fr.zoreil.com>
In-Reply-To: <20260614220934.GA3575431@electric-eye.fr.zoreil.com>
From: Atharva Potdar <atharvapotdar07@gmail.com>
Date: Wed, 17 Jun 2026 08:58:36 +0530
X-Gm-Features: AVVi8CfdfZlZBVqdnYglgY6AP8H40unBYRMJY593sq35tGdRmOzNrSWrAmj-m_c
Message-ID: <CAF9AHva0TSFz5tedMEgJTkhThzDGqmW7MJshAtf3ULbLY4wd=w@mail.gmail.com>
Subject: Re: [PATCH net-next] r8169: migrate Rx path to page_pool
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300009-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:romieu@fr.zoreil.com,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[atharvapotdar07@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atharvapotdar07@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F26D6964C6

Hi Heiner, Francois,
Thank you for reviewing this patch.

Francois:
> You may consider fdd7b4c3302c93f6833e338903ea77245eb510b4 and some related
> changes around that time.

I am sorry but I don't fully understand the context of this commit or
the behaviour it addresses. Could you please help me regarding what I
need to watch out for this change?

Heiner:
> Assuming your link speed is 1Gbps, 470Mbps is quite low.

I apologize, that was my benchmark figure when I passed my NIC via
VFIO to a VM for testing. When I tested it bare metal again with
iperf3, I hit line rates of 941 Mbps.

> If I read this correctly, max_mtu may be lower with this patch.
> This may cause a regression for existing users.

My main intention for restricting to order-0 pages is to prepare the
driver for XDP support in the subsequent patches. I understand this
causes a regression but I am not sure of another way to tackle it. How
do you prefer I handle this to avoid breaking current setups while
still having the driver be ready for XDP?

> Did you test also on non-x86 architectures? We had DMA-related regressions
> in the past which showed up on certain non-x86 architectures only.

Unfortunately, I currently only have access to x86 hardware. I cannot
test this on a bare-metal ARM machine, only an ARM VM - which may not
show those hardware issues. How is the testing typically handled for
other architectures in a situation like this?

Thanks,
Atharva.

