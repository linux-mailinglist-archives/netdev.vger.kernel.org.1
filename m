Return-Path: <netdev+bounces-268268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPe4BcVhuGlbdAEAu9opvQ
	(envelope-from <netdev+bounces-268268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 21:02:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 796EA29FFFE
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 21:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68CA5303C2B5
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459223CE495;
	Mon, 16 Mar 2026 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NR3qNhEp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A8B3DB633
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691290; cv=none; b=OaFw8W94jLTyc+0OVHWMgRSz4vudTG2zG1tvc+UejgNkXWc9962zXhTDEETCOoAFl2wV8Eld0ymOoKGoMAZwIAe9VEJjG6ZNuUWjsOxM/UZ3Y621Jrd9+3x1ItWJR/mXC4u2YEt8QE+W7sLyudubj8XegPCVSeS4Ct1zqk0vx+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691290; c=relaxed/simple;
	bh=u0/14efD16pkb1rp3dy8voyOR4t/An+rn/bU7o5BUto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O+sD2J3EUMsH9Xoc0z+mzlDQ6Bs7TZMIqIIKIrgI/objpVeuqWcfY8odgY1FAY+h6p6c8WIi9X7D6QwVCbqUFdTIJG8I43z462XrEj3PO+6Smkz+AcT4l5+UAlrw+81j3tn1yT0BoPNPWynGaRg8bRFgyBJYFM6G8qyZoiPJLjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NR3qNhEp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so57195875e9.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 13:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773691287; x=1774296087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AU6bRwwHhHizcJDXgyco5Q3uHZhupdZs5rHEwzQVTiA=;
        b=NR3qNhEpF4L8L1TVIbb4Q2LVX54/yTxaQv0IEaPQyw7+AObFEjT/6M+QpKudBgWXqs
         3Pisft6vF8gIdrptd4QW1x5pUxAQzEkiujUdkNGVVHXGxHLsgE4MKy7hndmYtzORuDZ2
         0wyNQecPr6nBwivdxUNkAnx1qmw8swSFsyirmQ9046m3LxDauIeX6AwTT4ziau4sb0e0
         urPB8dUddEYh2kPdxK5pgJVcguKWUgkP9tLasjr303zzbx9SI2bh+JkFXanmxv5HCwPF
         oMXXlEe/4Tyr8sKHLO0JvT49Une6NibWNR9GIlRouJ5zuvdsd/oTfYjuxBg6qBHoPMg8
         wp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773691287; x=1774296087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AU6bRwwHhHizcJDXgyco5Q3uHZhupdZs5rHEwzQVTiA=;
        b=DUd8jxEraxyMtWLr3Tvk4oGHm+++/uFQkMu+UpyCt1tBMs6/YkYcRUlDsLvsWzcPsR
         z1c4C+yjBYzq709LZBvJZWPwWelzqdz8jsXTZWfmnnJ8XqLMPw2j46oigmXxQhIjbTG5
         pNJ2s0GzXTDUVWaGSoZ3hShozbvzK7Yt5LHTY2168fuCkfkNsKkD0bsaFiMYrpf0hRsR
         I3vI2FAEvYlQatcpsHx6vjekjMA0Yf+Q3c+vwmCig3uct3DtB8xmOiUs+mg9a1rJB0Z5
         /fww1OABZu8QiJAqM7r7oBz6zU/CFbxXR7j5PCswVUASoLeGdiKtKPR+y0NguuS26ITI
         leEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVznJizB7pTHivyHXaZRRv0Dw1ohu04Xxite2qqgzjypJLYL+phaFFguQQ+MMofwwaxjQsfIjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx86sTnWiPwU1uTo7j+Bha2CIraizdrH1M9RqXDvn4nk2j4hFqE
	/nLNVAAYzJjPBOZHM3jRYKgLvT913JsZxXdLSUUiy2sM9dZM+MYBtUR6
X-Gm-Gg: ATEYQzwUzqc01rxphzDYtNdqP1HsTjfYIduHejFU5VJzoACaG6keyUuZotLBfQdrIDK
	fDfxPTD9DUkXfGSUq1DXWom1kTIHnO1MtXccULGw79Mc00H2tDRdUqptlQnztDZ7CIR8noS0B1f
	yVpdmYsuq8WtDdKpco+i3dqE/GY5naXKfMDEyAdNkad/8kD6Lqp1CojFn9uWdDZ9cKxA8ZloGiB
	1z+LeYl6I+mmNKl/B0snAazmdOVaK6TnEEzg5adjtqWCtVAn/sQg0kmciPowU7DPDHQ5JGpiq6H
	kf8kwpNMnOtV/+fBfj6ZIi3l5ckvBPJGPfQnSySZHSyyaUFIbinb0ix8haiWUcS8qoBZerY/abM
	NUxa7S5zki4T1FonNquFFRbHFuTddw9lDAYbeisIJyDOG+GYKMdLbZQB6+fPsRQrJHnfhHzO09f
	0yxy5GWx/PEC+wUlBTrEgh38Uv1vH5dIkAW32FbU93a65eqgYbvxv0wbk=
X-Received: by 2002:a05:6000:26d2:b0:439:cb3d:e42c with SMTP id ffacd0b85a97d-43a04d7a113mr26222518f8f.8.1773691286973;
        Mon, 16 Mar 2026 13:01:26 -0700 (PDT)
Received: from [10.83.123.35] (100.201.64.37.rev.sfr.net. [37.64.201.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b45e5c233sm9938587f8f.33.2026.03.16.13.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 13:01:26 -0700 (PDT)
Message-ID: <1b749c77-3ec6-4821-b4c2-5e8c3ab3033a@gmail.com>
Date: Mon, 16 Mar 2026 21:01:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/2] Add support for seg6 tunsrc
To: Justin Iurman <justin.iurman@6wind.com>, netdev@vger.kernel.org
Cc: andrea.mayer@uniroma2.it, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 nicolas.dichtel@6wind.com, stefano.salsano@uniroma2.it,
 paolo.lungaroni@uniroma2.it, ahabdels@cisco.com
References: <20260316162955.1253225-1-justin.iurman@6wind.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260316162955.1253225-1-justin.iurman@6wind.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268268-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 796EA29FFFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 17:29, Justin Iurman wrote:
> This series adds support for the new per-route seg6 "tunsrc" parameter.
> Some tests are extended to check for it.
> 
> Example:
> ip -6 r a 2001:db8:1::/64 encap seg6 mode encap tunsrc 2001:db8:ab::
>      segs 2001:db8:42::1,2001:db8:ffff::2 dev eth0
> 
> 
> Justin Iurman (2):
>    seg6: add per-route tunnel source address
>    selftests: add check for seg6 tunsrc
> 
>   include/uapi/linux/seg6_iptunnel.h            |   1 +
>   net/ipv6/seg6_iptunnel.c                      | 114 +++++++++++++-----
>   .../net/srv6_hencap_red_l3vpn_test.sh         |  65 +++++++---
>   3 files changed, 134 insertions(+), 46 deletions(-)

Looks like patchwork considered that this series has been superseded by 
the companion series for iproute2-next :-(

