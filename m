Return-Path: <netdev+bounces-257519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MgdM8LDhWnAGAQAu9opvQ
	(envelope-from <netdev+bounces-257519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 11:34:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C771FCB00
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 11:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13A43301243F
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 10:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C697376BE1;
	Fri,  6 Feb 2026 10:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="ZxYieJ6t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8850537649D
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 10:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770374067; cv=none; b=li0HWw2/sr0jOTGrbm8lgXwp6vgqoCpgBJsTpatub4WZvZ1tp4EjWqJPBgW5SaDVI2sHriO23XGX1LmmnmZKTEHMr8bvFGnTFv1j9qawSrm8rmzNStPX7jwANmVh3bCBL06ruqmBVq6WfUOq2Rak+FDgGODeqYClxZ0AcusNn8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770374067; c=relaxed/simple;
	bh=6OnxLe8EyUUzTBtYYOFz/C0thedtH48VjMALAeoKO+Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sNcJATWy68thlDFwuRe1SYMlZTmhXFiSEDs09dGtgLpnf0/OL6ypxw2irXM1yFGohbBy9av1lvVi+IEKzaSdhmtkJaA4Jm7+T372juDdyrG06fvKUMAnSExIAfgPnov3q9ooiR8PTaoWyPt39tlmwi9mKSh+n+RnTPd0Tl0tJG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=ZxYieJ6t; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4362cdf1d5aso309312f8f.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 02:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1770374066; x=1770978866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LHMkTXnKnNt0ryQWtQStRCNfgK5XQzWzGDoLk6H5Ljo=;
        b=ZxYieJ6t9/kKFV9cSCpsBnpD/AjNohF2pqdWq8gNE+6SAftrNeRe1wgkU57a6caobi
         7ei0MucCaK6rGA4SBne2eAwJAB6/hUcO1nYrCtEzusI3YUsOE17kE7cLG2HhyEIx/bcU
         AUjyKwp0Ja1+he387ixfQHzLZwUnKLXAPsL7o8fnRL3ejORObukWtQtI2CFyhm46G+RO
         /qrZxlTifatGzg2Q5C2hLRVHIQK/EZ+jdYAIcMLRJuREovcPu+/c6cBo8dls7S3T1TsG
         n06hpngRDy8FAvSbYEt/fUHAWg851d6fCFqursDW1e/E7GpRN2KxPVlHaGdiOw1I/KrG
         VO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770374066; x=1770978866;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHMkTXnKnNt0ryQWtQStRCNfgK5XQzWzGDoLk6H5Ljo=;
        b=HFQkdJslgCvyAD7Rf/XUEK0zmXuKW29xYRiCTz4elbqAqDQOc507CF/7oJ2IDom67g
         33SlnfymNmk3RomIlk5U/Wiy5nrpQPO6+hY2nOygSQE1dKI5cDXiFbzroIQEobzcOX+3
         3fPcBhqwebRh1tERP1sTjbLbc1Q6XoriNZbzE0i+wtfZTaO/I0EAbDU4NQ7DS061pHpz
         vEOoaxjLUmnsT9ow7gme4jfDhx/ROYZghOR/ybfe+SbSLh9I1IJwz7fSuSVXNUNMONtr
         IYzJlcLqmD/3b+pDPEqTC0dDXrP4X6n/DSTZHcqQ3SZkkbyS5bT/99FAfm3ocFUpLdXo
         q4Qg==
X-Gm-Message-State: AOJu0YyFphAqjX7fRUE2l/jLqdxa+01EvljoQa/pRewnrrDp6yKiR0Nx
	KsSo0jwqLXBCGCTx9tQm2pFyqnOah3hc3W04McfKlwgIAjrmd0/ImTG3joHLJUQ8wvbIQcNdGZY
	bi9fW
X-Gm-Gg: AZuq6aJXnyaqkko2PrYljK0lVEK6CeNBdJEZCVar+ylCipb5uR1trZA+s0pDXrOw5i4
	OTaw/CbkYvyH2swPf06zgx5sD7OZBK8oOScknzcGp33EmXkpbUY44QjDV0aE0Kcd1GcNKBJJbDr
	ZhDciULrRR/vdUPcSHWlDChl1GCABmstPAk/S0Q3ecIzyxVCe3W/dDYd23riQiiqAAlYAGwrBSM
	RnzHhExKaNEE9XPTSFcH4836zmNXBrlxBmzY6kaC55vae3K48hc7sIMTjO/64hkMEY3cxJMUgHy
	ttLDtoB/FP9Kfbi95iA08/T6Jg9mQuHxUaHnMTorJbEpiJ0J+23TcDkXX6szdRrCe9TTtGjGqSh
	IffMH/vRulUaFFICqx+ESLZ7njdM77pJP2ShrfEFLqiYQzytdXT6jdDNHtSUobhNa06yfa2zA0j
	niWljwXw963sk3b6gE3tolnofGLP57SDSJY17A
X-Received: by 2002:a05:600c:348c:b0:480:462e:d640 with SMTP id 5b1f17b1804b1-4832022f781mr35081625e9.36.1770374065755;
        Fri, 06 Feb 2026 02:34:25 -0800 (PST)
Received: from ?IPV6:2a02:810a:b98:a000::159a? ([2a02:810a:b98:a000::159a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd1c9sm4602013f8f.15.2026.02.06.02.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 02:34:25 -0800 (PST)
Message-ID: <1aa615e2-1297-40a9-b7c4-beb943996721@cogentembedded.com>
Date: Fri, 6 Feb 2026 11:34:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [PATCH net] net: renesas: rswitch: fix forwarding offload
 statemachine
To: Michael Dege <michael.dege@renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christian Mardmoeller <christian.mardmoeller@renesas.com>,
 Dennis Ostermann <dennis.ostermann@renesas.com>
References: <20260205-fix-offloading-statemachine-v1-1-640224a531d0@renesas.com>
 <3b1405cd-6c7f-4883-95fb-151cab223a68@cogentembedded.com>
 <d6a9356d-6fd4-459b-9c5a-2f3e20368bbd@cogentembedded.com>
 <TY4PR01MB142829D9748A483ECAF19FD3D8299A@TY4PR01MB14282.jpnprd01.prod.outlook.com>
 <25ff0841-545b-433a-8e88-6e463ea718e7@cogentembedded.com>
 <TYRPR01MB14284CB75C7DCD35381BD17EE8299A@TYRPR01MB14284.jpnprd01.prod.outlook.com>
 <237bee8b-a7cf-4c14-9946-8bf72dbddde5@cogentembedded.com>
 <TY4PR01MB142829EB0EDDE13B588F949298299A@TY4PR01MB14282.jpnprd01.prod.outlook.com>
 <a4cfeba2-23da-4fdd-870b-6533b5ce267c@cogentembedded.com>
 <5b8bcf37-5cd0-4c32-b0ba-3386142b7795@cogentembedded.com>
 <TY4PR01MB142820FC29E751D8C7F0B7C348266A@TY4PR01MB14282.jpnprd01.prod.outlook.com>
Content-Language: en-US, ru-RU
In-Reply-To: <TY4PR01MB142820FC29E751D8C7F0B7C348266A@TY4PR01MB14282.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[cogentembedded-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-257519-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_NA(0.00)[cogentembedded.com];
	DKIM_TRACE(0.00)[cogentembedded-com.20230601.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikita.yoush@cogentembedded.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,cogentembedded-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 4C771FCB00
X-Rspamd-Action: no action

> Unfortunately, your argumentation is very _academic_. There is _no_practical_reason_, not to
> forward the traffic to the SW bridge via the HW bridge, even if only one link is currently up.

The very practical reason not to forward packet to SW when it can be handled in HW is - reduce SW load. 
SW cores have no chance to handle the load if you forward everything to SW at the channel speed.

The very thing I was trying to achieve when working on this offload support was - detect the case when a 
frame can be processed correctly in HW, and let it process it in HW, without notifying SW. And send 
frame to SW if and only if it is not possible to provide correct processing without that.

But this does not directly affect the case being discussed.

When there is only one port with enabled HW forwarding, there is no effect of keeping HW forwarding 
enabled, because the allowed destination mask computed nearby does not contain any destinations. 
Forwarding to CPU port was never handled via L2 forwarding (*), because L2 forwarding on rswitch 
requires explicit adding any possible destination MAC to the L2 table - which is problematic for CPU 
port, in generic case your software bridge device can be a part of a higher level construct, and you 
will have hard times to dynamically catch and process any changes in the list of possible destination 
MACs for the CPU port. For exact this reason, I implemented forwarding to SW port using "port based" 
thing, that is actually a fallback that rswitch uses when L3/L2 forwarding fails due to no table match.

(*) when virtual ports come into scope, a case for L2 forwarding to CPU port appears.  But still, 
"default" forwarding to SW is never handled as L2 forwarding.

Nikita

