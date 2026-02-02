Return-Path: <netdev+bounces-255968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAf+MxvegGleCAMAu9opvQ
	(envelope-from <netdev+bounces-255968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:25:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D73BCF92E
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 021F2301ECE3
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 17:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0119385EF5;
	Mon,  2 Feb 2026 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikh7Opdv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C3C387346
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770053120; cv=none; b=tNv0iOKqc0o088dc+byjnKsurI1xwbsTLQ1uSRJnUYOsr53QqblrgrRgb/XfcjIHl0z/895zGl8vx6+6abpZQ6QTvH8cZPAaQ75DAXegv9USZAKYJioI/H2Wy5caSOrCK2ansu3BVITYkrQzpxr/hSEYuORy4GXGKdrtDplXCxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770053120; c=relaxed/simple;
	bh=N5emsJVnbYDypIuMxaWYpQNd4XXz+i3X9KxdIpzvmYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVDFt6WBMRukWq5HDvSZo3z5eqQPd8gA5e62u/gV72Nl7rZiPjzaR+UkIHUA3DpXmc/9XRswpbmAs/WG6d/IlhMRfqkZtmhGlkyJUR2aem5yOAJ3Tb1QqGqiacyZGL3czxeDUU40OsmKJlaFnKz18Df/Y5UIlYFdjgH2sfgKdlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikh7Opdv; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59dd263bf42so4951376e87.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 09:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770053117; x=1770657917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHlrgeVFZ66XfJyR0Ky7VPQSi5vlBXbdXZD7jGGpR6c=;
        b=ikh7OpdvXkYof18sKHYAhCW5gsH8KsrikELQRX9PJ2oSueqNzL09JAQCM0zlSG4OwY
         FuJgudO7NCK17lQHywVbHpVfrle+rYQRVZj5vkhIJRvfZqiXcTpF321X9tEq3S/6vJlc
         1jeptKcxH86oQGabn/N44R2hOAhRegk9LMO4/4jA+F5XxXh1NTH7UiHHdSWx1by3cyy5
         /wGDQvR7FqtpFh3IZGjoj4AcWBXw3tu+psqx4bDcnivj2HfJvQzAoUf7r3MlkZUglEaD
         OogJVMcG80VAk2sY4KoV0noJ7+DdOC1a252aw1bdPFM6Rb6758JBTvgzsoF5slj8ETjr
         aI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770053117; x=1770657917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHlrgeVFZ66XfJyR0Ky7VPQSi5vlBXbdXZD7jGGpR6c=;
        b=WM2WqBLtsXYZoUwBOQGC8NjQxTMcCoPKJqz8fCw7VFtgnhIiPUBufXu/sDTOBumMLH
         PgqiVzFmgNmVkMSLPpBhuoFDGdv3LfWAic8pMdDarhDl1wP3T90J8526AjFbIBKImsBJ
         TkYJ/bOum32/bzQKB9P4gdu7gv63aHu0m3XWTS673GCb6X+Eu71KHqZoV2NwEsURJaRC
         dVrLtakyQ3xM20dprppO9EyQVuZ5SQNx9g72HzbAvQSJwgAnRmdzstEr+/EyLIrhsQiM
         qfyTJq8vjzUC4q2G7mgF1FWxmufG714z6NqwwB9XKxAr1su1Q6lUzEoAGD40+GkGjUQ7
         OjRQ==
X-Gm-Message-State: AOJu0YzyCvBzzh8/mDouSuOFZoxxLlkzPSqm5d6f+jtA0ALB4JORkm16
	6D7TaVS3VXwwaGqJd06QZ2WHGmVAf+jKD4wfhP1chtRuZHnGSRSzPQ9GE/kqtA==
X-Gm-Gg: AZuq6aJtXVaVVyc7OTwvAXM7mIRQp9R/PFRwv8pUIK9RhqdvVL3S1sMP05vWnC3B1ZB
	lLOecWWZeSEHTSPtFkxgquiC+G2hVtyjqOSkFJigl51nAhELjL2gzLxGo1DRLEt8Qxom+6GliAW
	QVu2HCZezguLrWxe7ci8ppkwUYGAouAC3gjdOAv+JLT0fI1xOAZnM3ham1p76Tw+jkwh1HMXwyi
	oLX4Dmv4A1pcwk5gj+OzD8q7mmFIWJHSHT2tHOa5MMHU7kLi6hykH7XdOeym2GGBTODbpS5FU47
	AZkmjfMTmi8s3+r0NktgzSX7fyZCO2nwF48B7pnM8ib2E6SKjQRqc4rGxzHsIbavdwEdn4WhPT0
	0mlekGnRVP79CQ29eIO2kWnehi5f7bIUbkfV1sYmzvzYLF54PfYLq9ELELr44OCVcko6uHlERtj
	0X11s1c6XdCCm7MZtTzZJv2iSqPkHcD51u2u3s1LAZlsIRfTffcgFQTjM9pkyalitiSjjnOSG5I
	+GECNoM4kdmf+eS6bxHrrrEb8WxLuYYrezNJOS85Y2cekLl
X-Received: by 2002:a05:600c:3148:b0:47a:935f:618e with SMTP id 5b1f17b1804b1-482db45ce3amr158497445e9.15.1770053106341;
        Mon, 02 Feb 2026 09:25:06 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4b:2a00:742c:21a1:3b90:f2? (p200300ea8f4b2a00742c21a13b9000f2.dip0.t-ipconnect.de. [2003:ea:8f4b:2a00:742c:21a1:3b90:f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e2e3beadsm94827185e9.20.2026.02.02.09.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 09:25:05 -0800 (PST)
Message-ID: <602a08b9-134f-421e-bc2a-b89b0867b2e3@gmail.com>
Date: Mon, 2 Feb 2026 18:25:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Weird issue with r8169: shutdown on carrier comeback
To: Tanguy Ortolo <tanguy@ortolo.eu>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Francois Romieu <romieu@fr.zoreil.com>
Cc: netdev@vger.kernel.org
References: <aYDYSHhaF1vQSxdW@ortolo.eu>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <aYDYSHhaF1vQSxdW@ortolo.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255968-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D73BCF92E
X-Rspamd-Action: no action

On 2/2/2026 6:00 PM, Tanguy Ortolo wrote:
> Hello,
> 
> I am experiencing a weird computer issue that is at least partly linked to the r8169 driver: the computer shuts down when the Ethernet cable is pulled off and plugged again. Or when the switch goes down and up again.
> 
> To be more specific, the computer is a [Trigkey Key-N100][1] running Debian Trixie. That computer has two Gigabit Ethernet controllers:
>     $ lspci | grep Ethernet
>     01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 15)
>     02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 15)
> 
> [1]: https://devhome.corp.adobe.com/docs/default/component/ethos-flex/docs/devhome/prerequisites/
> 
> One of them is configured, and when I pull off its Ethernet cable and plug it again after a few seconds (or if I reboot the switch it is connected to), something simulates a power key press (log from systemd-logind: “Power key pressed short”). Even though I configured logind to ignore such events, one second after this, the computer shuts itself down brutally, as if experiencing a power loss.
> 
> After a few experiments, I determined that:
> * it happens on both Ethernet interfaces of that computer;
> * it happens only on _configured_ interfaces: in particular, it does not
>   happen if I unplug the Ethernet cable, run `ip link set enp1s0 down`
>   and plug the cable again;
> * it does not happen with the proprietary driver r8168.
> 
> I am not really sure the r8169 driver is at fault here; it sounds more like a very weird hardware issue in specific conditions, which are met when using it. Anyway, I though you deserved to know, in case it could be useful. Please tell me if there is anything else I could do to further diagnose that issue.
> 

Thanks for the report. Interesting issue .. The network driver (r8169) has no link to the input system.
Therefore it's likely your network manager which is causing this behavior. Maybe r8168 is different in what
network notifications it sends. But hard to say w/o knowing what the network manager looks at to detect
link-down/-up events.

> Regards,
> 


