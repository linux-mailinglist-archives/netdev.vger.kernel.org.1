Return-Path: <netdev+bounces-298941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rXu+E4soLWrTdAQAu9opvQ
	(envelope-from <netdev+bounces-298941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:53:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC32867E4AF
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:53:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YlTjjlMc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298941-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298941-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90EC63013B70
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 09:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9840E38D3E8;
	Sat, 13 Jun 2026 09:53:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7D015ECCC
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 09:53:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781344392; cv=none; b=Bz/eTGIZ1Co7eVRE2hTI+QdURgK4w0b+QlDONUthTnnh4YFhRViB2XNJG5hrQwp8MXZApFv45wHlN+hBv9g+GL1Pf5DAqUqSuyxHa6AM85/l2SCEQxKJH8XiP613Er9N2BORSA33IcAeIVrw6WE4/3C3q34K2jLlGbMtbBAgnCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781344392; c=relaxed/simple;
	bh=nsa/xqFgCfQ6As/U7LFHNU109oPvAMtkmMVTthWUFv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+L5wHb5R+VZ9/bUotJ6xFI976uiP0jedN6HFLkHakf5T5FKCqs9FpOEvkI6y5PNwAYvYFANAbqg6kVmQqWTGlMRFB8X96x3e/XTz8L2Rx07Dk8zPQaM6NN/YMTcHJtbUzGDfNQ60CIoRcc5NXX4CkyoF3EG1PWgDS8ovB45LsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlTjjlMc; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b12270b3so10851625e9.1
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 02:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781344390; x=1781949190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LDr7uB+HqKTFCCswWELw3SFqptqHrXh1cl865xzwKVM=;
        b=YlTjjlMcLnEJF4QjvoLAtM/+lSg9o8/EwVOb+33HTMUvQCS08DweroCh83jGelnvyA
         7Wlxlil2YZxqDxtLo+fu4wWzZbqyuvyOoKJ2gdoR1KM1buXumw1UGZanrAXDRyfAlqUa
         xZsPsGB2YNzhZ5TIp4nQ8GOGZrjq3VJ84RAQWb6aKpK+OrC2GwXveYHnCXPV4Sqe/9AC
         Zx0Qc+W+/hWUMXedm6rhQlgclsNIEVhIChVozUQHRfkUggerhfOGEHUbdTWa/isOgbXn
         CAsAd3Jzgxud9WMFzpDN0LFUFIYKNLPMcZ3MKqq3gnAg5uOcgUCvoAHybemL+MOiR7x1
         jW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781344390; x=1781949190;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LDr7uB+HqKTFCCswWELw3SFqptqHrXh1cl865xzwKVM=;
        b=iUHVLYc38pvmJ0ktfzoiqzLP7yaVf/b5fRbDjPpNi6D+3AHYY6HYT8EVGQzYoWZk2e
         77PO7L8YsKMiibHKwHyLpr0ivh/7Eu8AnQ3BYR3CFveog+XSlgFXVl5IPEQS9L1jAbU7
         q401JdQM3HwnNt924dE4mwQfhQpvJLiWnC1bIEOV9h0ljOXHL4QqlZaTA8rcyeA+kdV7
         a8jhajToSzGrTjueKjcSt5CPNV6ITq0+mTyX4cwqOH9UMI5Dglr5a/+k7LaMKQwrn4WY
         t9FlFLmQLGiQC8nUOv3hHb+5VeF5xPbrKJNK739J7XzC6NzfM1prgOwXffUAR0I/IePp
         1hNA==
X-Forwarded-Encrypted: i=1; AFNElJ/39P7immHw7haHtAEjryiBrRjaFpQVkpKncEdT9uoGSPO/n2WI9NCDPB+HGfy7ByjAdfN+C1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfWDS5FZtOQji/yQUOSOLgBpOwWf/fTwsPAclldsgQhBm+v5fo
	xrtkup+2ZnP4bSjZP/XxPngYe135LmxN4A3nDhf05tXT5CVQCMbvDd3U
X-Gm-Gg: Acq92OG0hp2mjtZcx76g6E64zS4c+jtZrU/YJejdH2C3HpMrcuSlyexB0gqBW6mRZbx
	1VhNxHXzGpBUvilS9EXB8e+59BihNOJHCM0tC+qscstKk0pP1R5Hg+FHYZJi8MnffnQuKqdP9xL
	72mISFvT/xpXNIh/MZX/bkkgxGO+P0ZpJYTNKyrnLgUZyr/npKUwAy2D+e1m+bpI9J/uTeCcvAM
	pKzRcpeNvp+xnfKN5UGMGf3Tvfrll971sb9CWDwLd2IWOnrc7azhivVTAWRMqjiAnP+7EJgZDwj
	cZw1xC37nAKw1XUkcyw125trKcoj6ymbFfm3H44vmVuR1S2qu4N8eUB4JyI+3ebVFO8kUe74XjA
	kXY5FLhtDFs/GeBURLwGeSr8AIRuwJrvoKK06N0jLe+QORy99rww4tb6A6vYjisOVaDyBRdG7CB
	t26BBCo8PYv+Bi3qgnn3mBsMzKsmKHCM08a3QO8EIsRYB37C3RgD7Wv7R6YGXd1lVb69xFMY/LY
	JEfpYuHZmv889tSL+bBjaD0M4Oz+Y0wzgvmb1z8K9IQb0TlRWvs/bxSoo+dvhE+BPECt3JAZFBm
	vg==
X-Received: by 2002:a05:600c:a210:b0:490:e60b:5fcd with SMTP id 5b1f17b1804b1-490ec521002mr49829595e9.32.1781344389840;
        Sat, 13 Jun 2026 02:53:09 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922035b4absm64807955e9.11.2026.06.13.02.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 02:53:09 -0700 (PDT)
Message-ID: <d0401fab-61c5-43e7-93ae-d4757433eb7a@gmail.com>
Date: Sat, 13 Jun 2026 10:53:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] netdev: expose io_uring rx_page_order
 order via netlink
To: Dragos Tatulea <dtatulea@nvidia.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jens Axboe <axboe@kernel.dk>
Cc: Yael Chemla <ychemla@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org
References: <20260612211709.1456966-2-dtatulea@nvidia.com>
 <20260612211709.1456966-3-dtatulea@nvidia.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260612211709.1456966-3-dtatulea@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298941-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dtatulea@nvidia.com,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:axboe@kernel.dk,m:ychemla@nvidia.com,m:tariqt@nvidia.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:io-uring@vger.kernel.org,m:donaldhunter@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[nvidia.com,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,kernel.dk];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC32867E4AF

On 6/12/26 22:17, Dragos Tatulea wrote:
> This adds observability for the io_uring zcrx rx-buf-len configuration.

It might be nicer to look it up in the queue, e.g. rxq->mp_params,
and make it a queue attribute instead of zcrx specific one. In either
case, no objections.

Acked-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


