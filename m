Return-Path: <netdev+bounces-269176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFfkENwEu2kgeQIAu9opvQ
	(envelope-from <netdev+bounces-269176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:02:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 981932C24EC
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50914313DC94
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F163DEAD0;
	Wed, 18 Mar 2026 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mv+QAkLb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEC33BED40
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773864086; cv=none; b=XhLjXgLNBTJiyoITaIhlXf8wIPIURf7tLSlLVPsKvJleqdXcck4BCnMdn1E2TXoa7YFNc2kOPIcLhqu7/zjzl6omNesv5wFnWb2XqsF7ae+G4v8ITb9TLz0LUpsYjjtcqLxu6p5Bna6gvOTyQWKTNisUfDDEtU6Wo3sLH+kUtwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773864086; c=relaxed/simple;
	bh=GGvtbmdrHpWov0hfduRttJHfpVecmu1fNiPKFMqC1Cw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qqPC3T2L1p/kpryK/XdbMQCCWKaXI5BPn3CxF1En7RynIpAXy7nvY5t9eCrgX7aR/kgZLTusWYG7xztsWUH0vVbA3itZaz2rHi+qLaMGbA60vlTV2epm/EvuRyTksU4xxVUU8TePgdhvYCNeUbyvvjxkTg5IV71OJ3HRURHDVWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mv+QAkLb; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a40fb9890so3433657b3.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 13:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773864084; x=1774468884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJ7Z8rAfiNkIJnsGGja0z7BFJa1lrhLafgp/LQadMbE=;
        b=mv+QAkLbbQty3KzD+iT6AyFWaebfR4sbkC1TuY7RqslFv4JKg4o1WkWuZxO0+S+7g/
         OQW9RX6rh0R1xFeIRtJ1aAQILiq+4lQUzGub7iTZNWqbvQeFB2QEge4qeov9objmGvnr
         4ydn18AQIBca6BZKMrdAtpFgP9KiBk07zq0ywRsMe62wljBmYoiT3hawelsTK5j6OKAv
         gitqBW2K3vrtuG6lXNUVZROD+ODFeWmB57x3rv39gSgA+tP7MbEaS5uvU+MVMwAgWVeK
         OkpvTSy5IfYabai2D42t31NHVjMUSa1zgvJ5OGFPpDrntAMZNilqGo55hnHYVjJ8v+FC
         LTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773864084; x=1774468884;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yJ7Z8rAfiNkIJnsGGja0z7BFJa1lrhLafgp/LQadMbE=;
        b=mU/DbrLz7PzTBXMAKUq7WnSBtQJAWWrTRMDiFIItrhXeQb4Atq1hISJLCEIfALiuiK
         5CfVFlInWEiq7qG0qwFTevBbPMxfWKvT1mn39jUH8XnzHN/WPDpPuI+pnB2hzgaCJ4Zk
         iQEcJiaGki+33JCmcFYc82eJALE/uTSD3kQ5XCXwS1n/DcF+6ekQAsGkYmZgPcGZAupn
         /hdE6iwz9y/0GWHQxsaOS/hK37w7BD8FaGmC20SaT9pYUJ8t1DcKH4EVxk72NnOeFvu6
         liPP9XY5P3Z2fhn5yPLDXyY4DPmdaI789SfG4YsacfWZafMX9ggsvwy/mdnS/UOtC1Q7
         8KaA==
X-Forwarded-Encrypted: i=1; AJvYcCWlzrfWXYGFSCj23u/UFzdRAPQieF/TXZ/uJ2kckkxr1XDgryiEb65ydaK9W86Q0PsXW/ueCnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy82iRnFyfor2yw1tqgtm/znpBsauN8Tvx3b0ZT75Mr2sh5PrAP
	xTjxxmGsHRF5xiiFz9hhWiJPrl4R2b9jWPTdRRz9ARlvp/NtRZQjBGV+
X-Gm-Gg: ATEYQzy5fLt0VsujiJUsd6F3Jfx4PJBxk1qCkjREKFFSJVvDuN1pa40ENcOptIK8Zmn
	jt4qUFLxpCmCOOG98TFxMy/E8WI/0BPPqh289VHpqM4dFthuqevcXdYPi/5/ebvo8JHdpTaMGf1
	CgHhI2BNYN9Ae39obrhzPVDw0+NobtCCEXaRoWPoxHH1ldKxN+FcQf6CGXFa0eHGG/AxC3V780O
	1KsDciC6Uh5ERXi0qzD7rLNdQBG2PLrxcUbBt4T+JPLZQ6mvpPrXL/KMMuHJdP2Uld5IVoTqux8
	tssN/jvXXibOs3doohjx/z5InHKX4XC9BxYO2e2ITIVFkFciN6RZ5AEpPvYzFqbAJdMN8IUh/TE
	HmTJX/apqLpkRf2HPJ9aNfWT/VIG3FmunFurckhFhrmKIlTgRZaxqB0tFm2s0wMoamxPwelp3SF
	50NYXDXBxkseIeFJuPbkjyqxxYg42PUX1iqwY564ADzxOKslc+5JfatMczzlGlx3W0t484BpCa/
	QKp
X-Received: by 2002:a05:690c:e3e4:b0:796:2dfb:4af0 with SMTP id 00721157ae682-79a718006a8mr49011147b3.10.1773864084200;
        Wed, 18 Mar 2026 13:01:24 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79a71603d17sm23181207b3.46.2026.03.18.13.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 13:01:23 -0700 (PDT)
Date: Wed, 18 Mar 2026 16:01:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Nick Hudson <nhudson@akamai.com>
Message-ID: <willemdebruijn.kernel.348794ac1e127@gmail.com>
In-Reply-To: <20260318134242.2725749-1-nhudson@akamai.com>
References: <20260318134242.2725749-1-nhudson@akamai.com>
Subject: Re: [PATCH v2 0/5] bpf: skb_adjust_room helper refactor and tunnel
 decap flags
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
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269176-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,akamai.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.035];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 981932C24EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Nick Hudson wrote:
> This series refactors the bpf_skb_adjust_room() helper to support tunnel
> decapsulation with L4 and IPXIP modes, in addition to the existing L3
> decapsulation support.
> 
> The changes are structured as follows:
> 1. Name the enum for BPF_FUNC_skb_adjust_room flags
> 2. Add new BPF_F_ADJ_ROOM_DECAP_* flags for L4 and IPXIP decap modes
> 3. Introduce helper masks to simplify validation logic
> 4. Enable the new decap flags and add guard rails for invalid combinations
> 5. Clear tunnel GSO state when decapsulating in skb_adjust_room
> 
> These patches enable BPF programs to efficiently decapsulate various tunnel
> encapsulation formats and properly handle GSO state transitions.

Consider expanding the existing BPF tunneling tests. Similar to
commit 166b5a7f2ca3 ("selftests_bpf: extend test_tc_tunnel for UDP
encap"). Given how far along this series is fine to do separately.

