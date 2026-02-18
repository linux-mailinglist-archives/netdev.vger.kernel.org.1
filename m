Return-Path: <netdev+bounces-259371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DZcKOFElmmYdAIAu9opvQ
	(envelope-from <netdev+bounces-259371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 00:01:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3965D15AC26
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 00:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C51C3007AED
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 23:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B8F33A6F9;
	Wed, 18 Feb 2026 23:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGX/Meyx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675C63016EE
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 23:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771455687; cv=none; b=NrqnMWI3SCV4c+XrL55ci7fa99deOw0fX51uKLxL6tJzpaeblx8akQGzNQFkCieZh04s3pCc8CQSegUH3/0o6fzo5Oyq4w4q6a1ilrMTm6/YZZnBG588W/0XxL0qcYI+kkkdbtvvw/xIDlIlzki5n5aFMgST8Hv7NKcHjvQYcRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771455687; c=relaxed/simple;
	bh=7Fp7LCS6gSA1q4tnJoZToIeqZIHSRnN2c54fC8YGhrQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=DBzMwlP8KEfVFvH4COciSo0T2PZPQDOR+XAbJ9tE+fkV6UyYECh9X3PIbgs33mquYmQjppLCJcAGcw6ryNHf9951dcFUYHdyMS1Xb80PrhG1KK5ce2AFABdePl5b2ZUA47/2qf7aLElYmS3A0meTwbhmZawr8NYtQo/nF/DpKh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGX/Meyx; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-1271257ae53so290771c88.1
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 15:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771455685; x=1772060485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Fp7LCS6gSA1q4tnJoZToIeqZIHSRnN2c54fC8YGhrQ=;
        b=aGX/MeyxsIp7tSlHFvC56Y1T7hYZgkkUqn7CNd3iU+iz9d7tiNE4HZ4tx9Jx51rulj
         ADH7KtbZgGnRZraudOMq5iJdWOGmxtrivTRhcOTuGPUmGA/c5p8dJsNPVtRl7mbf6RT/
         5ngMD1rupLel1g05RpiMd9bh2/gQlDnN38kodp3sBW0QbzU8b/+AfX6yxTJ7cDBfPv2n
         g7JOh8bdpvfgSHOU6Ne30XBPv6JdZ9Zlr4rfkAJ3n29TXmwS2GytY/NjuHJbqoF7+gbS
         et1aa0JrAcffn8vquK9ncpwtM3NdRXWf/7WMBQmqo9tLglc0GeiDUU381N8knAhNDYpM
         Ij/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771455685; x=1772060485;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Fp7LCS6gSA1q4tnJoZToIeqZIHSRnN2c54fC8YGhrQ=;
        b=TY/0axv6+cD1n7GvbLyelmNJDdI1QPh/i2W4H8763O/qQvuV3DNoxKTCFPfkzhg7l5
         RcU+/K63yRWdJxwbwx1v8xS8POPlsjivyzU4D8NcvnuW6/aeQUl13JVUZg4z79FLd7Km
         VYxmDd4Ovcc3lhaO4aXMoYhqBHJedJFEq7CkfbY5jrNVE+K1tjYKVhnUeF4hBVCoPGd3
         73o63/t8BBx/NvVgipEumQckxEol4MQudIAO5avhakL6umTwqzG6f9xXWbjmkj7Crh/3
         jYTWwvnhIsP6XHSy+dqxm5DOeAvVEseCfAzGkmLpYpJe5pLnnwcITD+4uL3TMwPAnMwh
         yV5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5kLke8WHH0iHVg/RGm+3AIOy5eVuWKpT9YY7xKYekPMlP5aPM6aE++XY+ua9CpBOxEKI2wY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5n76VPHKn8GVZSdMSNLUrVlFl3NaIrimfTQOPTBuefeNNxKNl
	7KzTVoomSPA5ssX7wXi13MBUwNAY9nGSloCwfPCzzLkj++mekfMGlXUN
X-Gm-Gg: AZuq6aJlhPZjelep2x012ul4xSvdV/GlVMdPr7ZKKIkhp9AgqdewKsFKSMBkSw7oNck
	gH2aVgwaVowafUNY/r5EyA2FJzhz4WSYmb3PNAMjQuyqk0ktQihb0SNCj/prpb1t5dCHjfoPeU1
	znUhqX6qsJP0QHNglTTioT1E8S+IdIvoQrHHFqj44zJ3eNmBLMwT55FDP1IrpRPZX3AYMdw3/II
	ky9VK5TnyBK+/inMkbEMtadZR56IgbGzmyuFzp8Ypg8nmn0oBtwzCP2B6jWLQrjd10oHpUPxrtA
	nq7lb47gRmXTIdu02dHea+LHJr3QfniF8T1YeHrzk7t5oYyVLZjv6rrkGufcPYsxtpv1lfQxMyn
	BNS/W4jW40aVCu5UU5eoWAlPy3gouJCHrVYJJTvg9thrO3I5JUU7GVVFjzorrkO+8m6kwh9iIFJ
	tPzx4Ausy9uKAZye6odr57qf+wUKMc14PD0AEhWE3CDW8=
X-Received: by 2002:a05:7022:2397:b0:11b:a36d:a7f7 with SMTP id a92af1059eb24-12759a1eaf8mr1759048c88.16.1771455685235;
        Wed, 18 Feb 2026 15:01:25 -0800 (PST)
Received: from ehlo.thunderbird.net ([2607:fb90:3714:16ad:ad3:2951:6443:3ac7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742c64282sm26802662c88.5.2026.02.18.15.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 15:01:24 -0800 (PST)
Date: Wed, 18 Feb 2026 15:01:22 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_net=3A_phy=3A_qcom=3A_qca807x?=
 =?US-ASCII?Q?=3A_normalize_return_value_of_gpio=5Fget?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ba73d17a-1d7c-4e66-af6b-d8e5a37358f2@lunn.ch>
References: <aZYnWZqfzKwzzF4f@google.com> <ba73d17a-1d7c-4e66-af6b-d8e5a37358f2@lunn.ch>
Message-ID: <893C889D-3440-4DCC-904F-CA4228C48C50@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-259371-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3965D15AC26
X-Rspamd-Action: no action

On February 18, 2026 2:55:32 PM PST, Andrew Lunn <andrew@lunn=2Ech> wrote:
>On Wed, Feb 18, 2026 at 12:57:17PM -0800, Dmitry Torokhov wrote:
>> The GPIO get callback is expected to return 0 or 1 (or a negative error
>> code)=2E Ensure that the value returned by qca807x_gpio_get() is
>> normalized to the [0, 1] range=2E
>>=20
>> Signed-off-by: Dmitry Torokhov <dmitry=2Etorokhov@gmail=2Ecom>
>
>This appears to be a fix=2E Please add a Fixes: tag=2E
>
>Also, please put net into the Subject=2E
>
>https://www=2Ekernel=2Eorg/doc/html/latest/process/maintainer-netdev=2Eht=
ml

Will do, however I am not sure what should be tagged as "Fixes" - original=
 driver commit or the change in gpiolib tightening the checks?=20

Thanks!

--=20
Dmitry

