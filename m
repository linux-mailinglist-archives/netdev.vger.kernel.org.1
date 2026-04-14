Return-Path: <netdev+bounces-278295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HpkLqvX3WlLkAkAu9opvQ
	(envelope-from <netdev+bounces-278295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 07:59:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE513F5D55
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 07:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 396883004F75
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 05:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60423264D4;
	Tue, 14 Apr 2026 05:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="CbQM/Teq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9B932B9BB
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 05:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776146307; cv=none; b=pJQDmCNc2dIBQx0j3Ms7kvIK5u7iBTvUvKJl4ZZBE0EGozlGA5QThySP1svA0H79Zoo9krUSnOK4BCGo6seknig/lOREHWnU5Ky0U0USCpcG/HvNjdwM61WV+JuDOqw7R//p8wgTk1AEgRPwsS0IIG56qW34ktgPM22V3+pIFuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776146307; c=relaxed/simple;
	bh=J+58JVvgmPkz/Uja3EeKNxYGiOFl8cJS1uRfmONyULI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRhsiO/64zQYUs/VYQlEIaxY+4AS21i3zccaoreugQEn44xPTUTuIA5feihKnmuIxlSbtffCEm/7JHBLZA9sJaEL5KSI3SeuoQ4jX+HGiTgtyaPql+6YBuUg8g9nTj1kv4huYiS6ikVLC1qGhTouhbLMXrDeL01MNAJoykjvsY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=CbQM/Teq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso54841535e9.2
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 22:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1776146303; x=1776751103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yECXo4Epg3Jyagb8BkKIrO3Fh1Udts1mUjubk/LePXE=;
        b=CbQM/Teql9z0Bx3Xg1asc8MvQtieEKTES3xDHxZ/HtjGAD+QdFvbXmqNTXeA6txSSy
         05HWSZvSp5vXHiZMceo7EtmVzrMDoGS1AdAOnoib+K+84dvdyFSE4kC2TW/m4V/WyTz3
         6gaP3vjtq0AeKCdVIMlIH6fYfm3KncJn6PuJrVM3JNHKSm99myF+QPB4p4X990Xtjrl7
         6neb1jGGs/TgEE73b4Lg+Mplb9XJUbZbpCPuSl7hF7XzPwGrFGvhxBMbpKrs4qWAcT7s
         uPO8TfiqOHJwUyDIPJT9TnaRCpWuWxGqVFU7vfMMdaLR/i31pdxh6j2+XcpDO1ni0R5h
         2Zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776146303; x=1776751103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yECXo4Epg3Jyagb8BkKIrO3Fh1Udts1mUjubk/LePXE=;
        b=h8IiVa7kEGrcBSFZfCV4IegZMc7MqnGXObOa+poKA4IyY/9s4/OEaRTgktGJGvN9j8
         VfxqgZNzRx1XQNKn45zpDEK/CWubDivNjfMYradGtEiEAS2IbQI8Yc7tuIXGMq8JrnsI
         UfSjeJH+MyqqsDWEtullgnCqDgX2Ob6kWGlA2v589vk/mOTd4L/jdVSNP2W64ZJQnFmG
         38HKa9pJqdTheywrHN/oepLZjmlR59HqBK3yWiq5jFKQHRm7Lu4r5OfcMJfXOEDmajVJ
         CJfylZq/aNx6eGlj2ybBo5aE6fl2mCaKv2X9z6caWPzU+3loxmNXaz08gxVC63OFRaUf
         Vzpw==
X-Forwarded-Encrypted: i=1; AFNElJ8PMqr8WtpeDgxqolDW8TgzFx7zo7QGeqCzxCHeGBCQCL3+5RPTx8nlHuc4UAa0cG4qM4rsztI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOjtcHDH4iZP0ENXHm3l1G+LGyKULeY/N5l+y3kCgwbbHm60Pw
	jCV5cMKFunmnlmo1xaXcUEjqQVw/+8pxQZoMv/fvrK9yF96unexnxkdAbJpec7e1IkQ=
X-Gm-Gg: AeBDiev2S8Lo2xbVX2RWv9c54Ln4GxjaA7vJZXIZRQsR7pCIFfgXC03BiLcPp2ffSNH
	YmJMZ2hX8Fx7m4Sypiy19mCybDAD24hOtuZVxChixikLt6RApWh1RIoPz5bXgQ4lj1XztcWI6Ez
	5FQ+up7qweQRh2OJ6f6tMncaGeqN0pHl0szQY4Qpqmy9oc5N0iieC/DveVGuprmc5PcHLygA8G5
	w0bPN/rTW3fqrUslRWRgCKE4upjUSP5DKt9Ev9y15BCu8e/4ekEE6efzzuT5hE1b76zil4s8Cz2
	BDzYpFbGex1Wo9CgPlY9cnmHkronYF1t0UXRWf6CRoWW07kyrUxMWFJvVTnDG1E6BbKoLE/PoaG
	kfxw7DMTHUNz0KvCmj9UQzCnmzizKOCZEtK3v+ugvDZFDcd0pgupQhjbKwVp6MQ2FgZ4o2BnwNJ
	71u3HiLfbmbCwKrW3UzWBiRZrSEMy3jCRBRR3cT1j8ldXWtuKKj/6IcSk=
X-Received: by 2002:a05:600c:5249:b0:488:c40b:c8bf with SMTP id 5b1f17b1804b1-488d680577dmr211634155e9.2.1776146302813;
        Mon, 13 Apr 2026 22:58:22 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488eddb9751sm39011035e9.0.2026.04.13.22.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 22:58:22 -0700 (PDT)
Message-ID: <ef785cd2-2863-47fb-ad97-9eb209ee0a08@blackwall.org>
Date: Tue, 14 Apr 2026 08:58:21 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] selftests/net: Split netdevsim tests from
 HW tests in nk_qlease
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: kuba@kernel.org, dw@davidwei.uk, pabeni@redhat.com
References: <20260413220809.604592-1-daniel@iogearbox.net>
 <20260413220809.604592-3-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260413220809.604592-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-278295-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:email,blackwall.org:dkim,blackwall.org:email,blackwall.org:mid]
X-Rspamd-Queue-Id: 1FE513F5D55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/26 01:08, Daniel Borkmann wrote:
> As pointed out in 3d2c3d2eea9a ("selftests: net: py: explicitly forbid
> multiple ksft_run() calls"), ksft_run() cannot be called multiple times.
> 
> Move the netdevsim-based queue lease tests to selftests/net/ so that
> each file has exactly one ksft_run() call.
> 
> The HW tests (io_uring ZC RX, queue attrs, XDP with MP, destroy) remain
> in selftests/drivers/net/hw/.
> 
> Fixes: 65d657d80684 ("selftests/net: Add queue leasing tests with netkit")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://lore.kernel.org/netdev/20260409181950.7e099b6c@kernel.org
> ---
>  .../selftests/drivers/net/hw/nk_qlease.py     | 1142 ----------------
>  tools/testing/selftests/net/Makefile          |    1 +
>  tools/testing/selftests/net/nk_qlease.py      | 1168 +++++++++++++++++
>  3 files changed, 1169 insertions(+), 1142 deletions(-)
>  create mode 100755 tools/testing/selftests/net/nk_qlease.py
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


