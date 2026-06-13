Return-Path: <netdev+bounces-298935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fPhNHmYhLWp+cAQAu9opvQ
	(envelope-from <netdev+bounces-298935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:22:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FC367E371
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:22:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="XoqOW1/e";
	dkim=pass header.d=redhat.com header.s=google header.b=UTNN6A5E;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298935-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298935-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D470B307A3C7
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 09:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59BE3B27D2;
	Sat, 13 Jun 2026 09:22:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9483636213D
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 09:22:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781342554; cv=none; b=lhEPrvDaKlobWTOpLsk9ljk1rYikeEJ1/OKORGPv8DUavnLL64PqCE1RnXDwmoPbQbUFDKDsGUJxxOPiKOGFSu572x6EBbbZZhpuyMBYFpKn9qC/FS99T6LveqaxIhs4sdYrQz+3N40Li16ul68llnJ+ThVTL7gOD25psSws9Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781342554; c=relaxed/simple;
	bh=helDrwuxiWtrf/iPIy4Y9R/hkLMVrwdS0rRl6C7Dn4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHhiyTt/Xmubh2pZk0ElJy/Uo5FmAtblohRR22x1dhCFCEiWgAEZV8c7CUCjR1X1IS2Ll30/6EuNACZ/BbDi7fvgvA3nzFI+gzsXenJA+a5wNpZElU6nskZSDEFbTbDKcNbId7bCx70EgRVuMi+MRXyBCgf01izp4gaLxjbTNL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XoqOW1/e; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTNN6A5E; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781342552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dkSlrlMGjyQ/p88XPP6jRxfxndrJ9//6XRAvhwfy0VE=;
	b=XoqOW1/et75dvB11HclyfE2WnENiZBvwch6nXEpzGWFw29SdKT8xDCRPruZrTgiIwG/E8k
	UJ207nbWddbHBtXKKo02I0d8XFoF58shDASVE11R0oQvteH7+Lt01TKS0xtXBpY4oIxNdY
	sqEm6P4CU1q9dwUYWeQqnPTocBLukeE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-310d6vbtPdujzGqj6ig86Q-1; Sat, 13 Jun 2026 05:22:30 -0400
X-MC-Unique: 310d6vbtPdujzGqj6ig86Q-1
X-Mimecast-MFC-AGG-ID: 310d6vbtPdujzGqj6ig86Q_1781342550
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-915c364ae3bso343321485a.0
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 02:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781342550; x=1781947350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dkSlrlMGjyQ/p88XPP6jRxfxndrJ9//6XRAvhwfy0VE=;
        b=UTNN6A5EXmo5DGdbgZPJq3NzPGlloswBBYBt/V3SJFB3/ElFP+vrbiAK2xm5MolmSK
         NFmsD79pZaMdF3lp6/IwypUjIMA6OXGVTHeWFA8zxpU0yPuEMA+uqdjzWzz0joT2NJRs
         598z3/9baZU5FJwl78/4iB5ZgorzMDFU0sD8wFIIHNGh0y+kC2nwEo8Gxx05L+JokBW9
         wPOx7PzHZNtpHcTgjvhjflqX7MLTa9135cApqT7iHR+5QWJ+MPrBUV3ZQKLgikuWwF5z
         DRWj580+wy8wmKofPZnDHhbR9tbKilNXkPnmuRO9OVKYdJS6Kq/i0WJuoIW8wwg5bRcc
         2HpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781342550; x=1781947350;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkSlrlMGjyQ/p88XPP6jRxfxndrJ9//6XRAvhwfy0VE=;
        b=dXNXIjA6K3mEGbk25E2AiEnoNWzd1p2pbfDtGPpSyiokw5ecXeB7g1gX6zN/SK3jay
         hfUAhjNWnr6nnoWEMmF0/nuLGeypn95QZ3iBGrQ/zac8Orng1CasXvbD0DBVxPotRu+I
         PgHKYE2i68JaSBR8+E42YpLq/hGna7crzJzyLeVHdSb+GOyqh7FoOF+4ohdhUIVo86EL
         D5uOkIjjAW8oK58IWNvd6ckFBrzbtwZMS8Yyg3KRDtGuSfG0j0mIsoLkaTwdfUmHSH+l
         XVPsLqefu1G23H9FkZcYXs/ryRKP8vPoq72DNKqp7OjUPkeC2mXCusX3LxyuyRfFvBGV
         SeyA==
X-Forwarded-Encrypted: i=1; AFNElJ8JJhkKCx4HssVk4WYm1St0t4w6I0sZy6cJ0Hv68gq1YXT2pAAe23t70SXp8t1rTDJM/8Ig+/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWBQR0pSjKRAkW+e1LH6dicGK38WJF9ebcoCvrFN29jlpKxVXv
	/h+trYxrRHDiVI/L0fV+NNuWiJyCTMVE9e2NoFhsNlCqazikU7JwNUaCAb1jsQMST54brz7QeUw
	J12G2wQzdRq9pNamQ1ZPEAUta4vFP/rqh65fEXqKg/U/AKnbbiKnoJ5iYTQ==
X-Gm-Gg: Acq92OFaxzPcLIbaWCWu4w0D3Oz15W/LQ8jNjMem9BiPxUA6V8bBHkA5G78KM6BvJTd
	l7ymxrIAOnd6C40XnMFsIQdH7/jpbZioToJDoKMVHVYTU52kPPyXk3UBreTbWsPVaocGz29XxF2
	HMIrN62xhdXd6EThcvnTAROlUOW5QQv6dCkgOOfpA565LVHIK3m8bYUoLEcTfvd/OuJcUJY6loh
	5TWXn8PmHkHxzJXMuuJvt0IOI2Mbg+4y6RDEaYTgQ6XXvJ6i71LmXJ3xovzXFYPo/4GhayupA5A
	F2rA2RTxdGCpqHkZFS0a+6srN98in7im8J3WGqcU1WLVHb6uQ5l+neS7ZXma6p9pMnh9woVzDSR
	V1USmtexKRM+ywNsuTXQZnFd8w7Fyg6dKqpRDgx4QGzl82Vw3Ndqb8+Y=
X-Received: by 2002:a05:620a:4708:b0:915:cf88:1e41 with SMTP id af79cd13be357-9161bf6c4bfmr926953585a.45.1781342549624;
        Sat, 13 Jun 2026 02:22:29 -0700 (PDT)
X-Received: by 2002:a05:620a:4708:b0:915:cf88:1e41 with SMTP id af79cd13be357-9161bf6c4bfmr926950585a.45.1781342549179;
        Sat, 13 Jun 2026 02:22:29 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.72])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f3c324sm454992285a.21.2026.06.13.02.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 02:22:28 -0700 (PDT)
Message-ID: <fe40891c-3fd1-417c-835e-6f1046db7844@redhat.com>
Date: Sat, 13 Jun 2026 11:22:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/4] m68k: coldfire: fix non-standard readX()/writeX()
 functions
To: Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org, arnd@kernel.org, wei.fang@nxp.com,
 frank.li@nxp.com, shenwei.wang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, nico@fluxnic.net, adureghello@baylibre.com,
 ulfh@kernel.org, linux-mmc@vger.kernel.org, linux-can@vger.kernel.org,
 linux-spi@vger.kernel.org, olteanv@gmail.com
References: <20260609142139.1563360-1-gerg@linux-m68k.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260609142139.1563360-1-gerg@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-298935-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gerg@linux-m68k.org,m:linux-m68k@lists.linux-m68k.org,m:linux-kernel@vger.kernel.org,m:arnd@kernel.org,m:wei.fang@nxp.com,m:frank.li@nxp.com,m:shenwei.wang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:nico@fluxnic.net,m:adureghello@baylibre.com,m:ulfh@kernel.org,m:linux-mmc@vger.kernel.org,m:linux-can@vger.kernel.org,m:linux-spi@vger.kernel.org,m:olteanv@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,nxp.com,lists.linux.dev,fluxnic.net,baylibre.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1FC367E371

On 6/9/26 4:12 PM, Greg Ungerer wrote:
> This odd collection of patches is aimed at fixing the non-standard ColdFire
> set of readX()/writeX() IO access functions. Instead switching to using the
> asm-generic definitions in include/asm-generic/io.h. The difficulty comes
> in trying not to break any drivers with this change.
> 
> The implementation of the readX()/writeX() family of IO access functions
> is non-standard on ColdFire platforms. They either return big-endian (that
> is native endian) data, or on platforms with PCI bus support check the
> supplied address and return either big or little endian data based on that
> check. This is non-standard, they are expected to always return
> little-endian byte ordered data. Unfortunately this behavior also means
> that ioreadX()/iowroteX() and their big-endian counter parts
> ioreadXbe()/iowriteXbe() are currently broken because they are implemented
> using the readX()/writeX() functions.
> 
> Patches 1, 2 and 3 in this series are specific driver changes that can be
> made independently of the final ColdFire readX()/writeX() change.
> 
> Patch 4 is the actual switch to ColdFire building using asm-generic
> readX()/writeX(), but also contains three driver fixes that are not easily
> handled independently.
> 
> Note that I don't have access to all supported hardware needed to fully
> test all these changes. I have tested what I have, a bunch of the standard
> Freescale ColdFire eval boards, and inspected generated code for differences.
> 
> Note also that patch 3 relies on changes that are currently only in
> linux-next, and are scheduled to hit mainline during the next v7.2
> merge window. Those changes are also available in an immutable git tree
> at git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git
> cf-internal-io branch.

I understand that with this series you are targeting the m68K tree, am I
correct?

A possibly better option would be, after that the pre-req patches land
into Linus's tree, to share an immutable branch for this series, so that
both m68k and net-next could pull it.

/P


