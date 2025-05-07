Return-Path: <netdev+bounces-188600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D60AADD12
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 13:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB6D9A3294
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 11:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122E8217730;
	Wed,  7 May 2025 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPWkwzfN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BFF1F5834
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746616524; cv=none; b=WXlOcuYFF/dU0UdlCwtSHyTC8Yn2FthYTpTDrpZc4Ibpmyqdh6RduEEDEJKukVILuLjTO3dEZAaoZsW4YUHjqHC2HJmaVn3egAndvZP8nWZTll5wqZCwSTEwNLh7cuGmOHLBtP1a56j4mcOSifm5Hgy9buZAXt2NYqgrjfYtUxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746616524; c=relaxed/simple;
	bh=QWVX3iDf6LXr5Hm+XGCNLQa53hli5HTgk7MeJYq3ptM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=dY+586LqxyN4KVK+zeZkH/QrINY4id+sIjXvevQxk8JX4VBmLDzfmU1ef8kqII8hdtmKAjhuJRn65W5SHeknj1/v7JmCzgNt/YPO6wOmbJENCeipRfMoeBCcibIEWEzGQevjkV3WCbdxiqAhIwkAmb1qHCglIa5t/WsebW86vW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPWkwzfN; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso7287738f8f.0
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 04:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746616520; x=1747221320; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QWVX3iDf6LXr5Hm+XGCNLQa53hli5HTgk7MeJYq3ptM=;
        b=HPWkwzfNPdauTysaWpoK90WqH8piz4rfpMMsEtXPLpZnbu2v9n0bG0SogkxULnDkHx
         dm19ONxrI++hENXIY6SiAgJmZARpoI4HHE7x/X8eD2ggbe88lcQytC0M6wNTflxZVZj2
         TGfXiW+/hQMAJ7o05oquDYpRUcC0fBsONiBG9XTYSojGjeorkSl//Z12U6NCR7yVGB4P
         DOFeALNtl5+m11LYnAiSMfU9yyjbXNQVSCTt5pqYyr9DDvj/D7o0Cbgz5bZOyYh7iAt1
         KenE2HkkeT1GpJiA/xewEpdbPa92l0nj6bai5uKbzXTUkahKkHEjzDQMW2hMzvbDV7Dm
         F2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746616520; x=1747221320;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWVX3iDf6LXr5Hm+XGCNLQa53hli5HTgk7MeJYq3ptM=;
        b=WvKJq/M0PN6rHPRRYyXYlbc5bqNvQ2/eQvbKpB1BgN34cMDHXOKzhiqXREOABsN9Ei
         3Y12CV1R9W5wV4gX4gnvxjzB6g4kFlVtmhzFvVzrLw06z/Qxjd8Cf86RhlLxG5ebrBCR
         9SPU921Nt24s5RdVahylR+55XAyc8u6PzOnmATzSt05BFwQYtUNnmDWtjYUAcl7J08uQ
         ZtXZF0it3YdiJCvEvOMgxjdtLyproFYRKkrSMJhcl7dQsKQfk4KUBynJpdeIYlEB0JxG
         NHslRkFAJkZtOasDrt+RFNh6URm4YytWg03GnrEW1Bur5XDNq5JWt8NE6KjuuhXxGhdK
         YIRA==
X-Forwarded-Encrypted: i=1; AJvYcCXVSea5vLfyNBxfJggMGl95SRFdwQHhEXNgCJjViI/rsjn1SuGhFo7bg1JeQmXBnt193TMG7ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU9YJS7yhThbAyinixGyEdQVosYFsHb5D0nSTBde5H+9a/R2ME
	TiUY6F6Ux+UjsCy1KRI4/mvL5SxhXCwsh3of/DvN9uTK2u9XRyGB
X-Gm-Gg: ASbGncuQm3W+qG7m0Z10cR2h+IlNjbnV+hoFzujxxSBuK+mxn6eGhV9fbZSdscXEUvr
	XaERCZwPpiDwOMgsCH1kEJzoJvOjvPfXgjXHXrMYEPyK3ygnxh8iNZaugTFfX97v8ZuBIVKmbWD
	pDtuAuSLvsUQLrInTxYtukK8NXVMVZtLaRZ7iafvqbUzbdPIwtc3RFQqtg9uFM6NOvv60E2TAa1
	rK1acseKC5pf0VDXy3OxfaM4cmkrk6FiSDuRbeAIS3caU47xhDtJPUCn/TzQkNBWj4486nyPAvE
	07/lgei+zoT46IK3cKN52T79IVI5yY/F/0ONzmlFfAcNKXK4BglCKg==
X-Google-Smtp-Source: AGHT+IHhVL0sb2Lm5+t0dLifa1Q0D2TK+cNwKMaWKsDQvx367YchrJp+DTQbt46fSg8rxez3HLZLtQ==
X-Received: by 2002:a5d:5f4f:0:b0:38f:6287:6474 with SMTP id ffacd0b85a97d-3a0b49bb4b5mr2620893f8f.15.1746616520358;
        Wed, 07 May 2025 04:15:20 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:dcb5:58d9:1622:6584])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a0b6a2d8ecsm1118934f8f.53.2025.05.07.04.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 04:15:19 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  johannes@sipsolutions.net,  razor@blackwall.org
Subject: Re: [PATCH net-next v2 3/4] netlink: specs: remove implicit structs
 for SNMP counters
In-Reply-To: <20250506194101.696272-4-kuba@kernel.org> (Jakub Kicinski's
	message of "Tue, 6 May 2025 12:40:59 -0700")
Date: Wed, 07 May 2025 11:54:07 +0100
Message-ID: <m24ixwofn4.fsf@gmail.com>
References: <20250506194101.696272-1-kuba@kernel.org>
	<20250506194101.696272-4-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> uAPI doesn't define structs for the SNMP counters, just enums to index
> them as arrays. Switch to the same representation in the spec. C codegen
> will soon need all the struct types to actually exist.
>
> Note that the existing definition was broken, anyway, as the first
> member should be the number of counters reported.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

