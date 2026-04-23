Return-Path: <netdev+bounces-280722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFpqIVf76WnkpwIAu9opvQ
	(envelope-from <netdev+bounces-280722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:58:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDA1450FF5
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 574813002B69
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37ED39E191;
	Thu, 23 Apr 2026 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWi52aMf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Afwsa714"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7591A35C1AD
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941905; cv=none; b=XGmIh2UkoeaSXv8kDV2akMHCxVioSaEYVl16AJu1kQ4RSHrimMt+5FP/r3Vrc7nfpkiaUV+7jgjAzJNSJOAwi4iJxNFxUkoFsewqoKFDJCrz56nDABBBf+rijqI7pa01fgOUEScPDE0qa+RrdZr7rCIJpGmsHqcfsRP3dRi3JRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941905; c=relaxed/simple;
	bh=Xa+bG6qN1HYUdPh3Ry+dhLiasWfSYhw/BRfkFbL+dqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZC8ZJD+RGI2uPd/pspFLGZ/gTzo9MeFEoT27h/YHYu4mKC8a/hhFzeuoPYPZHCPR8FoucaEZbYjVG+NIhshA7g06UXo08yt0/a68Ld7tjHYgjMZhrudGkFdjS41Rng0PjdHDIrLCAk9JsmUHLVcdUhtFtGH4O+Os/B+6TNZknI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dWi52aMf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Afwsa714; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776941903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KBet+od90qNMkud3NOqhuOiwhH6Rxym+XJmlrlPXzjs=;
	b=dWi52aMfyux+vxadvKVlYN9W+rM/KQciH1Gac0KpYHSrQXNfm7NMXaZeAh0sBOCWxIFNrq
	Nev7/3CRHKLUUt7xlb8XaniRoNL9yzyr/BSVvaIRhbQ96wDz9760KFyKLMMFnOYrIG19bd
	xZESAywYVVpAjsHbKEg1G5a5roEGtwg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-gVsiufXsPTSWuIW06u9qOA-1; Thu, 23 Apr 2026 06:58:22 -0400
X-MC-Unique: gVsiufXsPTSWuIW06u9qOA-1
X-Mimecast-MFC-AGG-ID: gVsiufXsPTSWuIW06u9qOA_1776941901
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35e59791605so6876724a91.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 03:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776941901; x=1777546701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBet+od90qNMkud3NOqhuOiwhH6Rxym+XJmlrlPXzjs=;
        b=Afwsa714J/K4hzZ54ohOwghwHW41/2VlMAz3nuRK7UndbPFoOUc+sK3MwpkxJU2YS2
         hkp05NkPZ/X2aS6KE3dK1YKxtiayRbJ5DLHrkV7Fe9S3+7HynS6wzn/FTCzZkYXoxzO6
         JmesLQsJ9xA0lpa98qaSbuKWgv+VCNP34e52ZHekCQhpNe9ftDaafsbBk9UeMlswG0dS
         u4bKOMaPbiTFM2WGqtHN61fsZvLNhww57npo3pOTdzBp6QOYbpw0NjPyAcWDvPDQfkH8
         cnoC8D55hd4Hi8VwC3TCAfnwZFj+YOvaHj+iddum+E4ahTpZCrvXVMvun2iqDKhXd4Td
         umBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776941901; x=1777546701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBet+od90qNMkud3NOqhuOiwhH6Rxym+XJmlrlPXzjs=;
        b=kRlwdy4P1GGegXevuAHhyGY3BunGZ6MvGS20BQmXYXgjhDuTscky59aClY3L5FtnJ+
         x3bPq/5peRD01N97rZ4a1OAvfQZVh03vi7NQIRX2yICBHHkJZKEoJ4zVPecgwYeEWxyC
         sdNFnqHD13XqoNIb6utZx6j4xBgHxat8vrS8Fp6qojcQMUr7HSy7nK1r1yslhySx0jA3
         pebBbxaHyGN9TNGKntdoD7o153U2/GViWhpD7n8LRgozbO5ilMjdlWPlu+CuHw6Vu9WO
         Q7+eKMnpSXkVKhNOaAtlB2P+ClYI9wO0p6gxtkG319irk2CpQvD2aw2GnrmmIJISB3/l
         bhMw==
X-Forwarded-Encrypted: i=1; AFNElJ+lrB+P110GOxl7ZoXDerxehdmSZj8TDQW+4VLPZdJs8wCTpO8ZIhYhIwQ6PLjJbihnFn8mfm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIN3VPnbwxJfMcZmvIX9NX5dXPQcyCorgvg0JmUWZqD2r68Pte
	usa1IsGaznBMxf4x4kc8TSqEkZa/SE7Bk43S1AkPbKMl9/7m4rnGZSIu9837+wokCZ95Bz3ra8h
	xkGZse6FNsTVG9mdnDKhxVDu6yc9kg+EFM+4kB388eYWUJycm1xqU1aRgFA==
X-Gm-Gg: AeBDieumPxGdL1LG1/QTGgjf4SYwPbBs9fj/IlYJ7VCT/8ci2tipIWsnOhx48cn4Ol8
	KnY/ye7GeJ0dd0LDOW2pEHxvFVRIUw0rAZDPJbQYLF5eqMn5vrfoaV3i0iuqRz6ByMZs04JnoN8
	iIed4UuypYpKo953sZU5slV1bELbmtjRwEVWDt//sL2Xglbs6qj3ymKWvw5G7U3WFwz4/+xRzvC
	m5CqHvrY3gA/A+iFGJhQI8C/7h0c46C91SmOJzimVWzC9vdgzW4+dY0Q0uTGfthOT98pGToKKd3
	i/DaWzMTVyhuB70rwBE2g+h75UraX2oPU/39/yrkduBb49PtT5n2KbKnatupNaOlvrpbpPToN3C
	NtZPvg8nf6XPzOoA2xw7SeNYhM1xpdF4LZTbqEAKDA9Q2S6BK4qNBencQNhvpbrgKdrI=
X-Received: by 2002:a17:90b:2244:b0:35d:9c32:6219 with SMTP id 98e67ed59e1d1-3614040e440mr27528864a91.9.1776941901087;
        Thu, 23 Apr 2026 03:58:21 -0700 (PDT)
X-Received: by 2002:a17:90b:2244:b0:35d:9c32:6219 with SMTP id 98e67ed59e1d1-3614040e440mr27528825a91.9.1776941900601;
        Thu, 23 Apr 2026 03:58:20 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fba1436sm7249554a91.11.2026.04.23.03.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 03:58:20 -0700 (PDT)
Message-ID: <21c7e3e2-c264-4f28-841e-42f562440365@redhat.com>
Date: Thu, 23 Apr 2026 12:58:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipv6: validate extension header length before
 copying to cmsg
To: Qi Tang <tpluszz77@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260423102255.3752004-1-tpluszz77@gmail.com>
 <20260423103339.3991950-1-tpluszz77@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260423103339.3991950-1-tpluszz77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-280722-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BDA1450FF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/23/26 12:33 PM, Qi Tang wrote:
> Please drop v2 — it was incorrectly sent as a reply to v1 instead
> of a new thread.  Resent as v3:
> https://lore.kernel.org/netdev/20260423103238.3987364-1-tpluszz77@gmail.com/

FTR, you should have waited 24h before sending v3. Beyond keeping the
traffic on the ML under control, that helps you learning and remembering
the process.

/P


