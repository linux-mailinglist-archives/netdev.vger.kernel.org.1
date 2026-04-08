Return-Path: <netdev+bounces-276511-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLYANPNP1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276511-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:54:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DEC3BC6BD
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51AB530053ED
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A3D3ACA59;
	Wed,  8 Apr 2026 12:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="xVcIaZEU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C7A3AC0FF
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652709; cv=none; b=MUwY2ywKgjqaH/3Hfic6i5pJN2vng5HoC2fW28dCYLiOftavXWl5axT/LHUv9AKY8u65/wV/LOSne8eQCkBGTEddj8DJ6vW0iIeYX637TNBEFwb5w4Nzt/g5r91QbNeatjQopOiPZGCxdMbeDF6dsAQUOWZNHfHXtB46P1ujsPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652709; c=relaxed/simple;
	bh=0vLo7tp497CFjsUg5IlBcVQ/iuP+v2IaN/Ud73bs17E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALRbfDhfPL7L7PqD88/Zv9EyTJEeDdLPUYS6SeInGqTk07yHeiIkdXYOd8Msm4zutii9vtMAuz3gihqQvzQowNhv6ydAsoDVTYiIC8coF/QuptNBL6zl2RXIKD5sfE5yCCB84j6Y2TLICWwpa11+2BUXgEZsbG5UKRtweN6BIHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=xVcIaZEU; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-688a8e5fe5eso776124eaf.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 05:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775652707; x=1776257507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zkJ3gH9TLnBN4l2XWLDJVveLcFNwieT7aov30h8JMgg=;
        b=xVcIaZEUQ5FEfLj1wGzhcYD191wDwGkSp1YuK90H9jXtvHxQ/erdbQUG8dvqQ0vcK7
         A7v6GUL726dZ9MCZvVgXmtYYMbzS3fankZuEjlqfl5HjneSPJaDaqv773inkpPNdBahj
         zn+taG8ITmP3qGZoo0tfai92S18q9mKXB4Upn7+tY/4AxXPwX3mJ0o0xadFXvFBXd4Ou
         z98OaZVRdLOndCfBAC3F890uTbt37T0ohHK+/TCmbX47jKvVNPqhtaaxDdDF6ADscH1k
         5ct/EDNh9UAemP2IhYGgbATvyrD6EM5qbW76bkNVLxeiYgt6WOpBCpARAbcdLe2a1qpn
         Wb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775652707; x=1776257507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zkJ3gH9TLnBN4l2XWLDJVveLcFNwieT7aov30h8JMgg=;
        b=Z9fQzDulVQGJzsoU2IPqau+Ixd0DsBTfdm8gEWDKXgsNqm1UNlish46s56Vj6umpV/
         E1F4KRnqwXgO+P0OPAdPk07BTFB/xGznGYQPhzEhmJJ1g+jKV8zoMvH6pD/tJoyOlz1z
         S5OGq51tEBO3qAYqAb8NErwWWC/kpLI4cXnHlyBuQgORfTTY2PxQLs+4tvUzRO/FwnxH
         Neg48TRYsGtBWQ8XZ6V8lf57EY59O1g4G+KUh4cDkWHSJZRW2eHhgfKFafY/bgwlOD6z
         EDXYRYlezSPnCOOUIKSwHaEXvyV8wrB8Acz3wp/yXlvSqGjiZDt380qSJPnTaiwhxRIG
         euMg==
X-Forwarded-Encrypted: i=1; AJvYcCXwPs0geZ56K/wUntLFmrxiZY0IDsVrAyMRG3MHNPxydDt8Rv2udYRD69vAptTDUauwh+M53bM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvNTdxJa4c97XEN1Ce8bvdkQjDokbK2FFmrszxFAVwYnB236L0
	RWtmwPTISuIuY55NBRM6JahgNkC0gbC9COKmmYTZyc8+GnNQ9/z+/tRUgrXeHMpLS3E=
X-Gm-Gg: AeBDieuqR9muFI2Kc+277T7h9Ani8XcwJLj9rAJB4YO8Tu04kftqpioKTfNN/or3ziw
	m/3VG8AW9HnYn0AosIy1GQejsumD80HpXA81O40C3WNsyNKO+8yO8L8Pztl0Lo+R0mO9KJP02yF
	P1NOt9ayfzosprdRX7Dr1khfiq9NnGafqlkC62l4vSjaVlSGLuMCdbN4V2/jfnelDtk74Qa7+1q
	JpVXLuJ3O4aJsZGokS5zgRfuVNTvXKXepc/gtRFK4wBqnq660ZJ8Jb3d89S9Yy3cD5opngffgel
	buAV55rUj5klgrps/7Z306vMjwXwF4W6rTj1Oa5wX/oxksWOqcSyZE/hEAqf0uXuKNPmwC/koaH
	LrOnfEFjIuyJTVkSn8TibJOMG1/W4Ki8BRKA/usD89YEkRNpNZQIeWhnjhdf6SjwWp6q6LIHxcw
	bHqDn67vLogGTb2Z60jtNkzkWkmtH9khz8vjq0Yu5+HFzIRf+zc+YjcxDa+uPeR7lKAC22s2ofd
	rCRjmgYrA==
X-Received: by 2002:a05:6820:f07:b0:680:322:4f36 with SMTP id 006d021491bc7-6821e261e79mr11791129eaf.25.1775652707173;
        Wed, 08 Apr 2026 05:51:47 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6892da88901sm1085560eaf.0.2026.04.08.05.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 05:51:46 -0700 (PDT)
Message-ID: <f3dc1661-02d1-4bbf-bf3e-c3d7d323b818@kernel.dk>
Date: Wed, 8 Apr 2026 06:51:46 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] io_uring: fix resource leak issues
To: KobaK <kobak@nvidia.com>, Pavel Begunkov <asml.silence@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 io-uring@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260408065408.2017967-1-kobak@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260408065408.2017967-1-kobak@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276511-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FREEMAIL_TO(0.00)[nvidia.com,gmail.com];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:mid,kernel-dk.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 37DEC3BC6BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/8/26 12:54 AM, KobaK wrote:
> From: Koba Ko <kobak@nvidia.com>
> 
> Three resource leak fixes found by code audit:
> 
> 1. memmap: pinned pages and pages array leak on WARN_ON path in
>    io_region_pin_pages() ? mr->pages is never assigned so the caller's
>    cleanup is a no-op.
> 
> 2. rsrc: kfree() used instead of io_cache_free() in
>    io_buffer_register_bvec() error path ? bypasses cache return.
> 
> 3. zcrx: io_import_umem() leaves live pinned pages in a partially
>    initialized struct on io_account_mem() failure, and
>    io_release_area_mem() is not idempotent (missing pages = NULL),
>    creating a double-free hazard.

General advice - anyone can point an LLM at a code base and get some
reports, but please apply some actual critical thinking to the "issues"
found before blindly sending them out.

-- 
Jens Axboe

