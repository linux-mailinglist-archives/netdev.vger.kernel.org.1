Return-Path: <netdev+bounces-255495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GWuNi1UfmkRXQIAu9opvQ
	(envelope-from <netdev+bounces-255495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 20:12:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A28C39FC
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 20:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED73430143D3
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 19:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C6836921C;
	Sat, 31 Jan 2026 19:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHfoQoCq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7D6368262
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769886763; cv=none; b=nDwsx9MbYSDRM7z+CHIkowfGBQXfuD9pSjqFga9uvt8VJX04alCqxOtTdXUB9hAIpUVs/kJR+n4nZSs702VzPwYAYie2GeBEIumn7dcG/L8bBE66JfE2T3MUNfhNkiVxH8WL1sjOCnrH1RYpUHTvKB9EcVtdy2PHTnRWO6jJzZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769886763; c=relaxed/simple;
	bh=MkHGJr7TIAz3dP/vzkYX5T9wz7nHuzLEizovDm2fJWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sW+f95iYyJrQ04ewmI7fP6aad1RyV+N1QbEtQYd7/lKuLmhzPxAdzM8e4T/8TtQ03dH8wyv4RU1Jyd5DP20kRHlrF0UP1eq57csx8Eao/NFjLRQf9YPsvRkDzurrVcJo1xrGHEMrimYe+NJLLzHcgoRO3ZetZEktnW4l2keeG3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHfoQoCq; arc=none smtp.client-ip=209.85.167.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-45c715116dbso2261366b6e.3
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 11:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769886761; x=1770491561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MkHGJr7TIAz3dP/vzkYX5T9wz7nHuzLEizovDm2fJWU=;
        b=UHfoQoCqHEpDby3OfXV4rtsZ6D5Gqhh2CNOH5SfnvuToOwukEqeuIhO7qApALiz48R
         2yaBvM91/har4Erj1Oivgxg93hTGdeKrY/ulF6lAQc/1Qw5Dtv+eJOrp+nywh4roBRjJ
         kBPGwHBSzhnU3fsuQzmU7AKdtUZb5cHs0X+zK5jArJC6N3bLgT6ErJ/srqEkFozA20x2
         +mmFnhEZF629tD2Y0XMIEseuQRTFCbCiUM9M9odoi3OpU7L8TUYus6ugTeAzgxv21XBr
         QsQXt3Kg49owm2OPo0G2iJ5d3FmZ3llmvs5SEWxz0t5Hiu9iiXtLtnMitpL+H1GiJXix
         moyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769886761; x=1770491561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MkHGJr7TIAz3dP/vzkYX5T9wz7nHuzLEizovDm2fJWU=;
        b=r4lnQfnk/QwHVZCxBAWHP1AnLMPugZXLl3E/MJuzxxaoDJIZodJ3weQjQcHX4u/jWO
         iy6u2Nfp/FeR8/3wP/OPTBgg9nM3qBR5PqJCFEBaeOSaQMLiAhCjSBZFn05F2/DXZtDL
         T+WJblZvwNujM0sXX4Frk8eZbTD+Qe4Npi6MyOT4/zrMEpjUQQlYq+mTiz7tb1t/whTU
         bDDGmRxtuWQqNQvym4/9bGb799LZBf+1+hAjCgW+GK+/h4CFeXGhcgDvkNm1sWlh4ijP
         fYd6ymbfXxHBWhYDBTDpL/auh2UPy9ddip4g4JGTCsyHgN5uAA4J79cHaTyteTHYKQ9y
         JOnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQqjJzV8Jtfl5TsmhredJFlbPWJ7gucZUlhSHzLQ0r+IvOCU0uccoJfaF9lpJsrjTiEt/VqQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu6mgAvh5APNhG9K/XnvORrIVlVEHVrfl1ZZZQ40fKCSSZPTMc
	aSpoleCguU+jOJ4shGyT/bMFU9mDNC0fTKmqUT1QpPoSdjmy42zL8WA4YUA4rSUJ
X-Gm-Gg: AZuq6aLBZGXTF5TVn+7/P0NlXT1IunmYLO+x2aunNHktjqg3eCP9B+2RS0caEGZiHSs
	OyudYp3TLAKbrnXcheeQ889Z1MG3Bf+pmjC1dVzWVbODZcTZeNr1LBE3Qe6XfdAdNbwmcYsc5cl
	MOElgzmPQdYuORuf/on91SM7xXCyuSMVIuLKp3hdro169grEDql9P2J3zTKUlXCG3fuyTowwFWq
	5wnq4zOcIv+RVgd0NbB59x4ANW59WrrqwXDrm4ij5xNFJqxRtFSDtZ04WROMaxPtnRs7MKiDqND
	bt1RJeNezBe2DqHVAe43ol522HIZRfw8IItcepnXHbtjEjqU8C9jAoiJxCU0gdDS3VOL59zWTKH
	LdMpHIGVTbjMCnES/euyw4qA853S7v/ZLXLs74EhItblIHm9+CkWf8FmOG12KHo0Zcm8bN2XKPO
	zbwXxWDODXEbAUB/Jy34GcKKMMDTg51DIVyS+Bfpkas9pOKJAJFWa7qpZtHj0ET09Ou5xVEtExN
	JiQzg==
X-Received: by 2002:a05:6808:4fcd:b0:450:a9d0:b790 with SMTP id 5614622812f47-45f34cfdf7cmr3166525b6e.46.1769886760690;
        Sat, 31 Jan 2026 11:12:40 -0800 (PST)
Received: from ?IPV6:2601:282:1e02:1040:95d0:252f:f0f6:b058? ([2601:282:1e02:1040:95d0:252f:f0f6:b058])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-45f08f60119sm6373860b6e.17.2026.01.31.11.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 11:12:39 -0800 (PST)
Message-ID: <d8fb19ef-b849-4af3-8a05-da002009f952@gmail.com>
Date: Sat, 31 Jan 2026 12:12:37 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] doc: add AGENTS.md for AI coding assistants
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
References: <20260124221439.234122-1-stephen@networkplumber.org>
Content-Language: en-US
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20260124221439.234122-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255495-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53A28C39FC
X-Rspamd-Action: no action

On 1/24/26 3:14 PM, Stephen Hemminger wrote:
> +### Line Length
> +
> +- Preferred limit: 100 columns
> +- Longer lines are acceptable if breaking them reduces readability
> +- Never break user-visible strings (e.g., error messages) - they must be grep-able

100 columns should be a hard limit. 80 as a soft limit with some wiggle
room up to 100 for readability.



