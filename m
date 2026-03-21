Return-Path: <netdev+bounces-270125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zdcsHa3ovWmKDgMAu9opvQ
	(envelope-from <netdev+bounces-270125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:39:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FB12E2990
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DA46303AB41
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 00:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BA82FF65B;
	Sat, 21 Mar 2026 00:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iflJCwc/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2632690EC
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 00:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774053546; cv=none; b=GukKJImvESUJNER0xw78+wyWe6O05lcbx4j5y6GRkodvzuccQvIGoTyZTvyitVlPrEumgobeHIQVSvKxqsRrVY9BEgQHvGwUllx/tOLhsTxTEwzdoFntkarhV12QzwCsRFwI9ymIMOhLfqpDcgFcqVDc/zEiW4TeWLrV3MPv6OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774053546; c=relaxed/simple;
	bh=yfSV8JCn6AN544dTPrv9GzEX4LJxqfSd3fiWNhIPZVI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=swlpoXR5i7NIK4l319xguI5q0ZLcZ/pwavWfOkY5/SP6y0kwh9YJmE2EJjyYNs82m2vqynytJjac+cTl13pvYmvUfm06w7SfpYCxO6NLM8kbtOc9QouHdO3yZDO36ZN2j+3FzJhmAhW2ksx/A0tEBztsb4zJ4+hglaOm8Da5qCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iflJCwc/; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79a2ee65171so11764427b3.2
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 17:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774053544; x=1774658344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LL+iGW4qBm9PVZRdE0+FGsMc4rkgxKO7lAUUgZfh2Bo=;
        b=iflJCwc/XFr5HWycV4xlfHMorfUzqpYfR/pSRQ3/tVi7lrcrrzUKY95BpDc+g37B2T
         eDPByTltXdP5C/WZp/LH9YDVpASFXRF0d66GSw9r89XOyoNQVRK2Bl5bmDodv3UaIA0t
         VYKxd7H88faqya569jPlZaHw6uwfT3dSN0X+mqUbIANpBAqO2n7MzIsxju0MhTyHFT0N
         YjlM6guN3T6nEjUyre5ZQNOI0yOv8NYp1d7RhdDWklZnMQHu92U1TQWPKkWj9qJWlgrB
         nmglUJOeddZxOQK/TzN/wSP7ms5tsw6Sa3Z60G8UfO6zwMaF1vQJR8IOQkydfz3Z5Pry
         qkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774053544; x=1774658344;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LL+iGW4qBm9PVZRdE0+FGsMc4rkgxKO7lAUUgZfh2Bo=;
        b=PJ2lp1ReS05G+291MOgjNUXUQIOfjiRSJUR+Ger+ge4Sm9oS03salzCFhmC/i+MDkP
         KqQk7yNxVbDhBGWI0JEqplc2YEac7HjZEE/J3KCLM6D1H4KtdO+OqUfX44tzzSFGSlaN
         y0Y0gKUwYbhKwLhs28LYmKH6Kn2NgpArbY73+gLbFdxWfAHdOeeVtVAga9aKstUj8AxL
         A4gWJlAWoxm81KdiAh6ZIPrIxHVCntlpU3/+v5XEm9EiMLDLF8DyQnDjVwU6Er/35MOk
         +VmkAOzhpBtUnF6pEU7aSDG5gi7EiUrtPy8V01TbrtcIpcUCXu6W2jcwdXbucK2ia/cX
         pbKg==
X-Forwarded-Encrypted: i=1; AJvYcCUzGXGJDANb7HEzhuu2z2+PcH0wwarQfIUlVirAqUjfj7p7H3rNiNbDM3Tfe6fyRHIO8JSBR/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YywNkaKRvVVwM31N70Dp97pzOhZKI7cD+MOOwn8+Y+kSxMnb0Jz
	CSewdoaSmIkidtAcQsGjqDbuE3NYpg0pC4xWyK0s8swz3EQaD64YsbqL
X-Gm-Gg: ATEYQzzLbAcytF0GvcBc3lLxZdI6u5bpTJDjbFGA4NgsOQko/aiiaecUC7dUYoq+o/C
	flIDjE3tdCU4Q3TlwNytfmAO0qODuTvn9E3t/W5IKqf+x0S308Ht5JucjYWrzJ0Zs48lKP2CWWy
	taE76MKgO3v64AO/vR++j/GFBQGwLhfOipo3BOh7Jtk0qhNazTRMnn8oLuKrEd/7g9nEs/mbSRu
	54AEdYMBlMjskiIWvbBB7lF4MpoVzigzwWRK7aSletS/S6XQjccAFuK4l8Y9/6IljjQ76jvaqJh
	CKUXEZXG0uHMCjL6vp39H99mWC0jiQxT5Qw2V0/0rQsapfdMA/SsI1nIqhXg9KsYK62ith3Y9fc
	u/a9jmLMm3umY0rnW/fN5kBbZ1ixaU6dwUln8vU5iwv6894QI7cVOydwHTHugxPNUAGxjt4M/14
	wtLEXuretHjydaxLc4IM4c/Wh1OKEvuNRMOya7BvIpnnE+996f08QwTN8pYoM4FNrFA46I5QtUE
	MqR
X-Received: by 2002:a05:690c:ec5:b0:799:1c93:7adb with SMTP id 00721157ae682-79a90af72d3mr53810957b3.23.1774053544134;
        Fri, 20 Mar 2026 17:39:04 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79a903a2bc6sm24627487b3.5.2026.03.20.17.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:39:03 -0700 (PDT)
Date: Fri, 20 Mar 2026 20:39:03 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.25780616b4d@gmail.com>
In-Reply-To: <20260318134242.2725749-2-nhudson@akamai.com>
References: <20260318134242.2725749-1-nhudson@akamai.com>
 <20260318134242.2725749-2-nhudson@akamai.com>
Subject: Re: [PATCH v2 1/5] bpf: name the enum for BPF_FUNC_skb_adjust_room
 flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,akamai.com,kernel.org,iogearbox.net,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270125-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,akamai.com:email]
X-Rspamd-Queue-Id: 87FB12E2990
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Nick Hudson wrote:
> The existing anonymous enum for BPF_FUNC_skb_adjust_room flags is
> named to enum bpf_adj_room_flags to enable CO-RE (Compile Once -
> Run Everywhere) lookups in BPF programs.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

