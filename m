Return-Path: <netdev+bounces-254816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPvYJClqe2lEEgIAu9opvQ
	(envelope-from <netdev+bounces-254816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 15:09:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E06B0BDA
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 15:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE57D3004078
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBE037F749;
	Thu, 29 Jan 2026 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XnXAtHFI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqDzCI/T"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08548341660
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769695733; cv=none; b=M56eLpgnG6HvMqNqhe7QI4L2Z73i5xd2WectJ8BKmWp38QZ6FVViOVjKuBNvYRPk9I4rpMmE+7mtbEImNdrGO0K9J3Je9XASOS+0JnKs7k39+8xORSr6GBrm0EVVkk3v6lg/2Ja5AKsWFf5A3gStk/z5ctzER4G9fUNBvpZiVSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769695733; c=relaxed/simple;
	bh=O7hoovYiGhQ14c3Rl6ksEXi28ZIhAz9OKfVontyZ6gQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JT9tW2OBvqwWhgppHX3Eb6AvjLnxbiV4zRH17aVIWsO4IzgNemZfZs1ZB9b4/7t41RDHG4Fzdj69Z36z2mu33+WC1nGBFdzt0BcflwJWEHhS3wHwFD8O49jXYtDu7HQ1yN0pPpj5mtz8urw98NErDSXuy3XkYHIqTwUxaMQuIes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XnXAtHFI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqDzCI/T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769695730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/yDdc0aOssQmwPiAEAMbLVrZwNafZDqUbaKFlwp9zUo=;
	b=XnXAtHFI8wHf7kLpUQwf55i1WrR/BMdIOuXCck/GyT7oztL8kcCtSDTg8/KVPYto1a03Us
	I9/55eK96DQ/svwjkqAKr8vffoq4LUdSbmV2HjT9hbPHFTGA1JBN5cIqeaV9eQKje6YLla
	TvkyoFvB+dl0KJPbwNcl6VTZPN7ZS4g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-WPZgWHd_Np2SsvNlUnhXiQ-1; Thu, 29 Jan 2026 09:08:49 -0500
X-MC-Unique: WPZgWHd_Np2SsvNlUnhXiQ-1
X-Mimecast-MFC-AGG-ID: WPZgWHd_Np2SsvNlUnhXiQ_1769695728
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47ee1fe7b24so8784385e9.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 06:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769695728; x=1770300528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/yDdc0aOssQmwPiAEAMbLVrZwNafZDqUbaKFlwp9zUo=;
        b=bqDzCI/T8Skdr117gGj4p7MvrP/ZqGfe+bWINSa5o31WX/LG5qwi2shY4zUKgAKzX2
         QDZDSE1r30/uHOMBNVWqXSUBpK5V4/q7GWGZFWyl0o0lZFBnxKDhUUmaX8LBrPUf1sXD
         9WCaLWzPzj75SX/4da+XHt2twrCscvHU6wgJjgqAgct3hCS+Ti0XaHJJyX5cB4fR1iQN
         D8ahaXcLKZs/8wfHx0MBGNMDtfmDdiyjz5kGYeaD48nB3gfGpPbkzkopMNsEp4vLLaRc
         UuvQoUkcmSfbH9WeVOWIhXFZk0WCX67T0VPr64ozMLS4yZUPeb7mh3SfRnZDbvbW/JNm
         lFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769695728; x=1770300528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/yDdc0aOssQmwPiAEAMbLVrZwNafZDqUbaKFlwp9zUo=;
        b=fRwn0fMvON2Ev/pc1r23hlG0cQApoDVYMRjv9S4lIyBmeux9py7a/6esfdFzBzxfMg
         6EsfeUWQO7mj3DL2QzXNUpQaibBWioU/0SiwgklSEc7H9sDLW8BqVIlErKcE+mcgMjSe
         Bf6tBDgAbsoRKBCU51SQYwjJhmnAUD4kLzLQJNgBtdnrWLCk5nS8xSFZoPnhacSOsbXF
         lK1bex+8wwLdqnOiBWG5szgpshIEeItB+BFM5l/f+wbMMzTS89wdp8QdnRYNdF2j4j3z
         2ZsoYc8JpvNAfqUsCV3U9muAE6FCeQSkulfedxBgoMO7uqFfyhxi9hadluVq4xxlc7Ol
         wxfA==
X-Forwarded-Encrypted: i=1; AJvYcCVkg645cpfwD2fz8+EvXyczfJTCWLEjJnmUEsSjR7stf4h0UTJwxuIKZEYrHUjg32BgDXZb/ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrjPfbZ4YgHm/Lm7zjznfQRpPfC64z75fEDBhUMD8EJAjqsBJf
	ebmYZrDW02BuVU4gHEZSj4UHB08OhBdJJCWT+4wP1ydD8ENFzxWZkjPqOO4WIgWSA+WaIbJnme/
	lK1d7OMyqOYe5EKLfoKeT/LkBqHcAtFB7gf5HNXumt9327zNfdMLe9UayuA==
X-Gm-Gg: AZuq6aKYi3+RBXwM2Nltp094vG6PHXuyJKQ86Kwx4RhtVWfcJDqACljHJh1ULqZuVQr
	sfIuoWlKqD3UNMCfblGrwR66i1rOhhYVeoUD3b3U93nbaux5Fypeyki/euzcP8TOg3zVukszrAM
	fhnJy2lYgsCXhKvl01VBHkkOoudat2KJLpNVqmof5Oykhf1PSw2s4A/B02QP6SzM8CPRwiuekfy
	MJGv3ay9FYId48wshCDFsS7g69atSAzda12f136hcg0EzYssc9BXscEvcLam7xTEV5ruqGX8BHF
	8xtcU8MS3MunRoDqJvVzKAz0kB1RASdYyN3JkrvrDFB1qYmyjJdfV8T1b/eO30y+ie1fR7Q/yVM
	FIoSX/RtFRmaV
X-Received: by 2002:a05:600c:b8a:b0:480:3b4e:41b8 with SMTP id 5b1f17b1804b1-48069c7586amr115691815e9.33.1769695728079;
        Thu, 29 Jan 2026 06:08:48 -0800 (PST)
X-Received: by 2002:a05:600c:b8a:b0:480:3b4e:41b8 with SMTP id 5b1f17b1804b1-48069c7586amr115691455e9.33.1769695727626;
        Thu, 29 Jan 2026 06:08:47 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bee7d0sm213363445e9.4.2026.01.29.06.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 06:08:47 -0800 (PST)
Message-ID: <b0d6887f-7946-46b6-986a-bf410b832d66@redhat.com>
Date: Thu, 29 Jan 2026 15:08:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] wireless-next-2026-01-29
To: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
References: <20260129110136.176980-39-johannes@sipsolutions.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260129110136.176980-39-johannes@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254816-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A5E06B0BDA
X-Rspamd-Action: no action

On 1/29/26 11:58 AM, Johannes Berg wrote:
> Here's another set of changes for net-next. Two things to note:
> 
>  1) This introduces a couple of new sparse warnings, because it
>     cannot deal with guard(spinlock_bh)() which the drivers are
>     now using. I previously fixed sparse for that for RCU, but
>     given the context tracking work will remove this validation
>     from sparse entirely, I haven't bothered trying to keep up.
> 
>  2) There's a core SDIO patch in here, but that's intentional
>     and we agreed with the maintainer to merge it through this
>     tree since only two wireless changes depend on it.
> 
> Please pull and let us know if there's any problem.
The CI also report a 32bit build failure, but with a dangling link to
the actual build results:

https://patchwork.kernel.org/project/netdevbpf/patch/20260129110136.176980-39-johannes@sipsolutions.net/

so it could be a CI flake, but could you please have a look?

/P


