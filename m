Return-Path: <netdev+bounces-303862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HfGIAC+MRWpHBwsAu9opvQ
	(envelope-from <netdev+bounces-303862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:52:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA1B6F1F7F
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:52:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VB52gjnb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303862-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303862-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6141E300D9D0
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5BE3BD62F;
	Wed,  1 Jul 2026 21:52:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9973A5E88
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:52:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942762; cv=none; b=W8Aw93BxlfV7BHg5eqvSfknbuWbgrhN3tGx35CJwjjPD1k4+5g7u1ofBCi/mEXagLcmgSsB7bPqskj600jmia+rgQv3Te+w6ql+p0xvzdkcGozJLAFlwzxtpVyUqA4txaJWzxjishQDsqOCKzUlF6igIo9mh1x67umsLZBjZ6Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942762; c=relaxed/simple;
	bh=1Y6DjJ1LCeD3sBL3Az1XXEM2jcbtGBHHZuKScutYlCE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=beByrYF2xSoaDi3Y7zcyfZf6yuoOud20JDOHtT7ZQtwKv3FbXEYsBADLfwOw9Vep3L3cU1CLASiCLOksQGLDNSTF5IfG182DZXNUunQQL6n/bSZiXBaE58WbaZZobAwMLnJwT/wNqEAnG37djPDPgDcrwNxh9PxABmxa90Qq8+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VB52gjnb; arc=none smtp.client-ip=209.85.128.174
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-80e24970f1dso9845187b3.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 14:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782942761; x=1783547561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fecQlwD9cDVj4gbPcRpMSFTPB6deWnmpM1J4y46Iqls=;
        b=VB52gjnbFRBPGf+vpZHpRNhjJWzOmR4WTobLinp+ZhcgsKMaasNs+NWRlmLzxLYhvG
         gcrAWSmGyEETdo3M5K/a188nb+3cEu5gXlHKa1WOZD2p0DTbtHWyH8w68/XF/ev52hsk
         4ToQEOhHt+kjdE6InZ/79ZinOGCzD9ZNBtzP5UcdxZiZC0lxLa8dtVvjMQjIKGMVNq1f
         wW50t8PAw3XpBauO/W868SJcuS46CwcGKL0rkHheGMqpAIig/lOZd6WH3SrzuSKO59UD
         oFomFH7Qm5nbPqezpF0ee5o1/uwj0sFpN1AhioSIiIoIhV+cBXReAF/41Ra0cCFBicRe
         SyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942761; x=1783547561;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fecQlwD9cDVj4gbPcRpMSFTPB6deWnmpM1J4y46Iqls=;
        b=RKGnpPLBFptOXfzjk99ojoLeLtQicJ55UFdEyqc7f/1LlpQnsuZmCayG7bars+lXwh
         mGal0HtJ+gOysac5zvHgJ98saSUAgwXT39G8TAMP46gbdlZa4s6iQRW4Nt87eNh7Dc4P
         +plhoMNplstg+eZgCMc3EodgWmDUtZfdu4LlQ74JNe2ld7TTMAoIV8gzawMiuzsu1UHc
         kcTCbD2ONuRf/HszRgK5gl3Rryg8lWL9S6omAHNGae0TlUfM98joYUci3QSMo1f3CwLL
         Rs1czIlNCCdWXsPpjxub+MBdymJntm2wgqtZldNaFMofz2ZHwI+NWz9DygJhUSXjpQ2m
         OE1A==
X-Gm-Message-State: AOJu0Yx8JEBAx4SQfLGSLCyrHX6mtfh1aleVWxlZ++eV9spEYWRuIA2g
	vnGyos9vXmyY2IPBHhOhEvOJZ4p56Rmk5nGLQ513nOqn4fYuvLyemKRB4FYL9Q==
X-Gm-Gg: AfdE7clinBKEvmuAxLKiTaHQWzvCrwce+T3xqC6agIKTZb7UX8bqhTv1/wPNc6NimZo
	Hkg2S34bZGNdw2TGPNQXE5uCpWcuQRQFzOTYnR7eEn6FuHyMhfedUHJcuf+IIU2tiArIC6hLFfg
	NffIUcZKhlE6MljWDpgmBWYS/Ey+f3Gl5uGhbNrWQ0HyEIFQaJwd6bDUcMSo08YMd3nRo5jTbLx
	BJGRDmOYgFf+WFm4QJBScVlvzN7s0feDnb6w9DNdDbDwkSDBXOz1W4wTbh9GpHp5WS2yqqABqG5
	DWFOFPO4aLNSisdMKxMcjKurbDgG9lW4og0fDumdgTJwPtfqmvxtmyshHIdGvbI75eyO8n/wHGz
	dRTeBGZqe4zHuMxTt2E5vIQ2zSFc947T0suUyqeen28QO5zEf3Zag3FIsGvIxPChmTkg2GcBgrD
	5IaaEkSQ++/Uc8nKKa28lzRwqvdO25Ee/Pv29HJi3Jzg38/VtVKY6JNw2JLBFAWPyb4Q==
X-Received: by 2002:a05:690c:dd3:b0:812:c9fa:9910 with SMTP id 00721157ae682-81383427303mr29911927b3.29.1782942760965;
        Wed, 01 Jul 2026 14:52:40 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81448218f8dsm5218477b3.15.2026.07.01.14.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 14:52:40 -0700 (PDT)
Date: Wed, 01 Jul 2026 17:52:40 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, 
 sdf.kernel@gmail.com
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
Message-ID: <willemdebruijn.kernel.dd8394aa10b7@gmail.com>
In-Reply-To: <20260630-getsockopt_phase2-v2-3-193335f3d4d1@debian.org>
References: <20260630-getsockopt_phase2-v2-0-193335f3d4d1@debian.org>
 <20260630-getsockopt_phase2-v2-3-193335f3d4d1@debian.org>
Subject: Re: [PATCH net-next v2 3/4] ipv4: raw: convert do_raw_getsockopt to
 sockopt_t
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303862-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:shuah@kernel.org,m:sdf.kernel@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:kernel-team@meta.com,m:willemdebruijnkernel@gmail.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[debian.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BA1B6F1F7F

Breno Leitao wrote:
> Continue converting the proto-layer getsockopt callbacks to the sockopt_t
> interface, switching do_raw_getsockopt() and its raw_geticmpfilter()
> helper to take a sockopt_t.
> 
> The thin raw_getsockopt() wrapper keeps its __user signature for now: it
> builds a user-backed sockopt_t with sockopt_init_user(), calls the helper,
> and writes the returned length back to optlen. The helper uses
> copy_to_iter() instead of copy_to_user(). No functional change.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Willem de Bruijn <willemb@google.com>

