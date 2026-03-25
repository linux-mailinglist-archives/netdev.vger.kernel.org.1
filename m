Return-Path: <netdev+bounces-271439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Aj1J7eOw2mCrgQAu9opvQ
	(envelope-from <netdev+bounces-271439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:28:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4188A320B20
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33A9D301F980
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C25364920;
	Wed, 25 Mar 2026 07:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8Pfbuyn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A2135B12B
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774423713; cv=none; b=daNsfglK41n2ffRRWjCvMnsyGlhMPT80HRK/vdOlVwKikziIJj7cXsvF563zktRRICIVQVTMPV0a8q7zMH/H/zZCvaLH9D+2KpTSbGGXLXfEnZ81Q677UKGbauih7UH5ejRgKEZAPQOLAazJhy3yLb93nBqH3j+FTbFZmrAKaH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774423713; c=relaxed/simple;
	bh=S/BaYDdPcQXTkL2SnY6Z59AFoydNh1oEXzUXxXeESmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPcpXT2tOne3+5JF+P9YYtbP/23XVDON2ssv5vYx06QYzNXc6brudZq5AkdTHK3Cq+RtuilAHGhUeBQPfo07W5Ni1EAGDG2VO7tKvY3iPBzkm9xv8PISO8+uBLBkhbEU2QSD4F8Ot9PGJOV5ZAortLpodNRI1MAFS1LP1i0vmjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8Pfbuyn; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-661d20c9787so3094498a12.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 00:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774423711; x=1775028511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xXcLoA3AOm8JsZyBFRvvn/2aLGbl2SRuVxCEIFV1m/A=;
        b=R8Pfbuynzy68urWZLJkASnZ3+9kYqcCyt/sSj3Ubahjjffw0/05utO4gY5/m8JhhCi
         t6wzAew/HBmrScLgU9X519rEOBW7kSP6Rt8hXWGCKRTdgj8tOjvyNPTtcAaMN8NYvLUY
         3M3NVD27n1r8tf/eGAiiLEh8xkEoIyeEQ3vOnBJfE9EGnlCn+F+2nxgBEbS4sVIxJ1XN
         1fZHjbVQYzAOijX2P4G6BRK1hBUnpkhJ3bIz1xwcgQqPSSQgYge79AX9meLht2uh03zu
         k/pl3n8IfJE2w9lc21mkNL1qApCqMiK78c//Kgz13gdIbRjuw+QNLTm3ELxR17emZBOK
         jUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774423711; x=1775028511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXcLoA3AOm8JsZyBFRvvn/2aLGbl2SRuVxCEIFV1m/A=;
        b=Ho7lo737LU6ULAsmC+c87xaXuLZiK0K/QeFr88zU4dqR9Gd4fdoh45uhXfOPP9hzsr
         pOKeKpk1tLEhAZDLFBcOT+cqsHD3JmeGQSwSLU778KRAPHZ1AiAK6cRuRppGZdkwb3/s
         pf/1quFIMqJxSKw80S1SwFDXaxR3sNq2jB+3bCbGzwKm6sYmpJr51ggR5eXfORW4TX78
         oD2w/Y6Icp7S35fulQEsJqZHliXyukpTSLTdBTobg9uVxOh8kZaDZdNt1Lj/36XnUN3S
         6LcWcqpw++zldufIvekXlSzjBOgIWx9C1wPHYUXG4BZCmSGknu2MwSnpdtSgXypnPoPt
         LITw==
X-Forwarded-Encrypted: i=1; AJvYcCV6eem67Qs/94gkZ996l78o3mke97799sqiFS6za/bg7HjHvo6l2tlj2dZFdC+7S1r4ExChSJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQom/FdiY/lqJ7NqtcJRV0lSgj6ZzuyvKSda5v4C9iqh8K1DmV
	BEOIYkO541aHsllNTSIh/l7yDkrMHXxaKs89s/VuLq1qRaxuIyJcFtDh
X-Gm-Gg: ATEYQzzdPBbt6PTMHPUA4XNKkBPgKoifFwZa0MV1bZ9IIeaPt2K2Sh4rHVcjCJ2IABl
	oCd/FYAcWvLr3kMLB3MRdbj0AoNA2lQ2OVO+m0E/oX+aAmB5G+RC417aicX+qt7VecFr4IlqmM8
	83LRtrAWCNHzzHaQhZKyc+V+K6RMdMePTW6/CpTcjgmn7RXftaOu0+2ItK2kMK3Vcha0WZkcrtp
	ft/cQoW4ltX3qf02xk3TfTicjyjAHlAEV2E6KhgEsZyZrDikocl9iTRO8TnQ8OO4VIAFoNMn330
	qQ7IDRxxqgHsVc9dK5E+6KRGxAq1YjHLXNcBd/BUvoZFhNVfiQfrHq3PA/CfifCiejg1p5R6oxz
	DdJetugIJpDe7d0ybhEke1T72eMQFL++17myYAWF8UprS3/gJqLdyId6OjewHwA97ZeuIB42MAz
	3NRWaTsoNR2XwowHnb3ah+/V33lipFicsJYgIay4N5ZHUD4LaYnN/sQcUXTnQ0lFwGmd/0f6+o6
	U1nGd/g3t+s
X-Received: by 2002:a17:907:d1c:b0:b98:6c41:a77f with SMTP id a640c23a62f3a-b9a3f1a815dmr138126866b.20.1774423710456;
        Wed, 25 Mar 2026 00:28:30 -0700 (PDT)
Received: from [192.168.0.2] (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b984b056f3bsm573597266b.26.2026.03.25.00.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 00:28:29 -0700 (PDT)
Message-ID: <abb8a10c-571e-44f2-a15e-1d5da288963d@gmail.com>
Date: Wed, 25 Mar 2026 08:28:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] net: bridge: add stp_mode attribute for STP
 mode selection
To: Andy Roulin <aroulin@nvidia.com>, netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 Petr Machata <petrm@nvidia.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260324184942.2828691-1-aroulin@nvidia.com>
Content-Language: en-US
From: Jonas Gorski <jonas.gorski@gmail.com>
In-Reply-To: <20260324184942.2828691-1-aroulin@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271439-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonasgorski@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4188A320B20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 24/03/2026 19:49, Andy Roulin wrote:
> The bridge-stp usermode helper is currently restricted to the initial
> network namespace, preventing userspace STP daemons like mstpd from
> operating on bridges in other namespaces. Since commit ff62198553e4
> ("bridge: Only call /sbin/bridge-stp for the initial network
> namespace"), bridges in non-init namespaces silently fall back to
> kernel STP with no way to request userspace STP.
> 
> This series adds a new IFLA_BR_STP_MODE bridge attribute that allows
> explicit per-bridge control over STP mode selection. Three modes are
> supported:
> 
>   - auto (default): existing behavior, try /sbin/bridge-stp in
>     init_net, fall back to kernel STP otherwise
>   - user: directly enable BR_USER_STP without invoking the helper,
>     works in any network namespace
>   - kernel: directly enable BR_KERNEL_STP without invoking the helper

I like that very much! This will also allow selftests for
switchdev/dsa drivers for correct (mst) STP state (change) handling.

> The user and kernel modes bypass call_usermodehelper() entirely,
> addressing the security concerns discussed at [1]. The caller is
> responsible for managing the userspace STP daemon directly, rather
> than relying on the kernel to invoke /sbin/bridge-stp.

Should the caller directly manage the STP daemon, or could the STP
daemon also just automatically manage bridges with
IFLA_BR_STP_STATE=BR_STP_MODE_KERNEL (and IFLA_BR_STP_STATE != 0)?

The latter would require less changes for network managers, as they
wouldn't need to be aware of (individual) STP daemon
implementations.

But I guess either is fine, as long as the latter behavior
configurable.

Best regards,
Jonas

