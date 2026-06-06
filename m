Return-Path: <netdev+bounces-296016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V20yKBh5I2onuQEAu9opvQ
	(envelope-from <netdev+bounces-296016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 03:34:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F94464C1DE
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 03:34:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296016-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296016-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CABCA3021B40
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 01:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A6F22257E;
	Sat,  6 Jun 2026 01:33:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E498207A20
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 01:33:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780709585; cv=none; b=ZzaC8xkx4ewLF1Ta4RlwOioDQ4UPQvNJfhCT5pal5hWOMMV1v819Aif4fecSnx2CjjhVrXLREUzyrpTn/vCkWZghvqCnUbMIsTDy3eWCqevGSGusZ4pgdJ+S/wz689SDO+qzWoNEHWhUt/Jd3OdSpziLMtRrW6spmvNsBSbpUgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780709585; c=relaxed/simple;
	bh=yCQB3YO9RGm7V3SVdvHqHsfBTMTLhHrqO7+YMHldsoo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nB42xOH0Es6BAj9Rcx5ZpIVTBAHenVetu4F5/+PZInEfsLIFhaka1ze1SeerapCnkc3usi7rfTqiHpg3auTKSF0VTE/mapbnjGzyJ4mmhxDdQSSUC6sWnKhV07XHSpoqA97sOKQjVY7PexlMWRWh6i8Xyx9SB0sno9Re8M9Cpyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.67
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-490b4a8e28bso20174505e9.1
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 18:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780709583; x=1781314383;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHl7B4Pdpkq6k1fa6b0ffg8CaxQkxmXR75ZusA7nDOw=;
        b=betij+tMd1oSPijMDfxbDW0LDICYSNIrugILuoAj5h53TSFDaGTWaA7QDQJ03lnuxi
         LUr7XqjiQoWWcVJJKbn61/OKZM/Jv9njdPPenKhhrMg9KC/NTs2BOZY1rdn08Kb72DjN
         SIEqd/LejVB21Zs7EXz+de6DFWTKbHUxMcX4C1h70cY3PsFMcZeJ0xsaWHsK30xONNoe
         8wqQKkUKIgrNUQJiyVPmYqvJuC/qkQ9pSiYR2BXAd3iLzmC+6oFgo0mBT6pRFRARfsxs
         xOIqs795SxW/udzzCl1/0ypgrshVLdwNx7JxxSO9u1TXriiTJCWGbvvb4giogtpWSjtB
         JJag==
X-Forwarded-Encrypted: i=1; AFNElJ9QUGOdLkkYojVsy14NjZzZPkcm+RKePdcKTvQrFhZAvf2Zx+uw56TPVpkuvuX+Bwg1yaUmGqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIaoSwyxA1lwnUaWgsXSqYwg1GMK9sqBG5VW8T2nBXMxyj84f2
	OU72BB16MXY7Nc93N08s8USg0EtG9fQDfc5BTTG/0UMR1vkMoYw72FZD
X-Gm-Gg: Acq92OHuTdFEUbURKpn60de083jmCL02aHLRhaYJ3kFW/Xec2Jd1tuVikMGqIog0xQ5
	em90qPC+aKhDaVzsMnCJMJOzS13cNZaQ3UXIc5nVdAqVGskRm9wHQKabVgoOGsLRoSH9SY2F7nO
	1hq2kwtflGXUUd/gz6QzWr6NWIRLwiHp4WXM/C/tTDPSPw8hb8vnGyAGKOEqO9H0+1GrWVFwj2N
	uCbhJjSmDTx9RABPlxAlYHy85p6doWgY7dyu11cV+0+mp/vv66BwNHw1aHNjZD2HbDQ2SvFv7wg
	spx6OrVudRbSmjvpBFcgyZnqkxcXdktWS6F7ufR7nr1Qp7Jmh0+DTTNnjJjON+LkMAHCHu/F1Px
	PoO+vam727QNF3ayUj0yuloZJDPJ6fCZo/anSvis7+EkXNSObKrwqRuGXukeCJSQ7p70O2dTmjP
	mSiCXGOosVRt+ZWUtwBh2VMr8PGlpECM9/9exilDVlpRgBwWcXCfrWWllr4a8Xep06ZQ==
X-Received: by 2002:a05:600d:640f:20b0:490:c2a3:3303 with SMTP id 5b1f17b1804b1-490c2a3337amr67695005e9.34.1780709582748;
        Fri, 05 Jun 2026 18:33:02 -0700 (PDT)
Received: from [192.168.88.241] (89-24-36-255.nat.epc.tmcz.cz. [89.24.36.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm51494708f8f.27.2026.06.05.18.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 18:33:02 -0700 (PDT)
Message-ID: <110f6d5e-85e6-4e60-8b73-4d3a85a9b08a@ovn.org>
Date: Sat, 6 Jun 2026 03:33:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, echaudro@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kselftest@vger.kernel.org, amorenoz@redhat.com
Subject: Re: [PATCH net-next] selftests/net/openvswitch: add flow modify test
To: =?UTF-8?B?5L6v5pWP54aZ?= <houminxi@gmail.com>,
 Aaron Conole <aconole@redhat.com>
References: <20260605124222.963815-1-houminxi@gmail.com>
 <f7tv7bwhlc0.fsf@redhat.com>
 <CAJ0BgHcEHi0Bjv4569MnQmVbJukdLfghWMTDYk3k6dRp86OH_g@mail.gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <CAJ0BgHcEHi0Bjv4569MnQmVbJukdLfghWMTDYk3k6dRp86OH_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[ovn.org];
	TAGGED_FROM(0.00)[bounces-296016-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:i.maximets@ovn.org,m:echaudro@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:dev@openvswitch.org,m:linux-kselftest@vger.kernel.org,m:amorenoz@redhat.com,m:houminxi@gmail.com,m:aconole@redhat.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com];
	FORGED_SENDER(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,ovn.org:from_mime,ovn.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F94464C1DE

On 6/6/26 1:42 AM, 侯敏熙 wrote:
> Also sending a v2 shortly
> to fix two pylint warnings that nipa flagged (+2 new warnings: missing
> docstring on mod_flow, and a %-format string).
Hi, Minxi.  Thanks for working on all the test improvements, but,
please, do not send new versions just yet.  Wait for Aaron's review.

Simply re-sending the same patch with minor changes flagged by CI
creates a lot of churn and discourages people from reviewing the
series, as they don't really have time to look at version N while
there is already N+1.

As a general suggestion, try to wait for a human review.  It's hard
to define what the "good" amount of waiting time should be.  But if
the number of human replies is noticeably smaller than the patch
version number, that might be a good sign to slow down a little.

I would also suggest to wait for the Adrian's fix to be merged and
synced into net-next before sending the new version of the test to
avoid any potential mishaps.

Best regards, Ilya Maximets.

