Return-Path: <netdev+bounces-240845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DF376C7B0D4
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E0C26341D39
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323B1349AF2;
	Fri, 21 Nov 2025 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="fmlfBVvl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F96346E47
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763745603; cv=none; b=NVSRi4UAMoYCF5y70RC2puOYos70D+F+zAkF+p3F2BVyPwGtEe56PmDrtLetHdoyGdIWqQM5vftOAuMwuksqk+1JsarnMMw0s7+qsY8ta7Qffzm+tuvP7A3eFuCkamoUWx6rZASI+IMzpa1OE9NLbZa9z5rSn8fp43oDN3nYug0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763745603; c=relaxed/simple;
	bh=E9qvZHUbbIA/U2IZ/sax4ZhedwXdM9jpNlOoxHnjUtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZotnlge3SCRUMSEw5I3SUNgUWHL2jkUkM3Jw32KF+QlLAsLw0oEhX7Mzq5pwDwn3VmdkLZi4hj4/saCn3bzl452Hu+MMOR2UsKq/XniOHK+LbqyOe56SABvupQH3Y6MGz7ueIEwKNGwe+aVPTj1OO5HSrk0aWTb6JdU0fOADz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=fmlfBVvl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297d4ac44fbso18255515ad.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 09:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1763745600; x=1764350400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6EdB4CM3kXTcgrbd6/wn3VP/3gaiub/LeaYlls9sIOo=;
        b=fmlfBVvlqoMxrVIlHKZvisVVIlNgw0i3/a/MwOiJtq5nW18Ba4i0PvtLA/rb4vwza5
         fgYiJU3De/Frvh35vRLyq8L2iZR9BcoU5Md4nbWu+RI1ht6TaZGLt1FmAnXmcdKghtNA
         dG4LYwzuNsKIiBXa3b73BBV3UIdTmbyplcp04KEQ58QAJTs+Df5bhIWXGtt8RILVKHBv
         /L32ViqLp9fsfKqFUAQBaocWmzh/nuFEglqQM1ltWDw7TGCW7TmFQiK9OYTDXF0G/RvW
         3ch+H7IGPDz2Ty3Ay581V0mnAkORvLaDNOpmP8wOY8o71FfQSsgqWebixFxyUZhA8FGD
         8O5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763745600; x=1764350400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EdB4CM3kXTcgrbd6/wn3VP/3gaiub/LeaYlls9sIOo=;
        b=PCifn8pKBB/OrZnVniCzBe7W8XvhOgJL0XXT78b4idEsx0wcRgWiFAKt7vJtJgh45r
         bURHwsYldgrOHTNPqSMaldIc3msyEz1LYsafLUBMg862TNbQl/AXMWLzAw7AJtvXUV2u
         1Max0/oPX7GCsHBCqZ2YmVIevxTJFKb2HBR4XcOG1h6hhFKF0zCHlvtlrh6Odbu5HJTH
         lJAWjzKXyyMaGgf765uUslrXzsWtxwAU+bD9yRO5Ou9Q+mmeqkjEBmkXUUJUiEUvHzFz
         uSL57/UwxUfyS0PjL7TGquGRLu+QJyz1MVPWSQu0c4hB03pwQ8u0CR6mvwpRTnpDVfyq
         D4wA==
X-Gm-Message-State: AOJu0YxkSUVigVgG87hzoJyATxZMS2rgT3qJZ0BiqylWBB81kAtygg9Z
	DwYGqZr5GPgpmofyMLy9t2Bf47tLVOiQJidW0riwU4RJHeLWzeIf+hsIW7N81+Gjwqc=
X-Gm-Gg: ASbGncskXvbOqFSPN00oqjwWsAe5mfSSwde+bB+ijx29KYDfaWkUBwhNyA9dGuqAVu5
	ZhyhXGwNlg/H4PogD/4sPpE37tnaQG12HSek8JMx3C3iyw/cdcnZKtmZkzkCzfta9qhfgLt89TD
	Kv5hSn6viBAckLc4LSypaoHp/M2i30lT+zICrYvwah9mkDUKTcgPeUQBFKuRJ+jpPYKEeON23Jx
	WwExxUKnp8KkGewTD5qUg54FeYHrwgygF9e3A/XO1L2snED2mJJbHt0Vad0EbT8gPcXrbF+Lexk
	IFfGLWy5nnSouY3XPlEObIQlAGQ1hHn32UnQDWTrl11vSMfWMAXpBo1Oh0+OQJVyf1psoKigR96
	lsFBT+zAR3RKOjNOGRsnKMBRj35Kq94NeJfrWYEqSdfaGnHW3NfLIfg2UjYAumBmVrEZhlyyCU5
	13AJP2/zlRQ3QJIvegGwYfPyFnGXhKF8FKAedlumvkBH+rYd9zaZW6Qv/dXkZJ9+hziiwnODyr5
	ie0YB4=
X-Google-Smtp-Source: AGHT+IFiKVjPkW9JqL1W7B7hoTQtFA6EN9MdLt1KFDqPwOPhCDpnaSDzUhvdluClrarIamAl83dNxA==
X-Received: by 2002:a17:902:f607:b0:267:912b:2b36 with SMTP id d9443c01a7336-29b6bfd95a1mr33165515ad.23.1763745600183;
        Fri, 21 Nov 2025 09:20:00 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::7:9190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25dee4sm63141135ad.61.2025.11.21.09.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 09:19:59 -0800 (PST)
Message-ID: <5a7054c0-9228-4f05-ac25-b1812be6a077@davidwei.uk>
Date: Fri, 21 Nov 2025 09:19:58 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 4/7] selftests/net: add rand_ifname() helper
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
References: <20251120033016.3809474-1-dw@davidwei.uk>
 <20251120033016.3809474-5-dw@davidwei.uk>
 <20251120191916.4f91ee3a@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20251120191916.4f91ee3a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-11-20 19:19, Jakub Kicinski wrote:
> On Wed, 19 Nov 2025 19:30:13 -0800 David Wei wrote:
>> For upcoming netkit container datapath selftests I want to generate
>> randomised ifnames. Add a helper rand_ifname() to do this.
> 
> The kernel will generate a name automatically, why do we need to create
> a specific one?

Hmm, yeah good point. Was overthinking it I think about clashing with
the DUT. Will remove.

