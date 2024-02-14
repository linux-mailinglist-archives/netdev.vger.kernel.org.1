Return-Path: <netdev+bounces-71727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779F7854D69
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 16:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7DC41C285CC
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 15:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1065F869;
	Wed, 14 Feb 2024 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibRqrl21"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D00A5EE7E
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926081; cv=none; b=GNQyKUMX35hGFGOXSSH82J5X3OFwUXGx+LhrD+KJjExGDbYol9tLfIEooU9maxbD5WPZ6WDdAUVSsaAmjTLW0zHADtovznI3Wtr0sCATPXHR5efDTqXVJmivDQT80c31CSev/LhOEjussA1iQcskn1l+H/JpWOCyndjfhpMwI4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926081; c=relaxed/simple;
	bh=c4OSUkW0JE+UkpLZZLk13mliZt99Q8s119NCZFSfqys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPU7toe7kBOUXKII6AIadWa65yySTkeH6LuqF5dxntGzZrAj/jIy5UD6k9JTFvi6uVQczIxyzUHmcxqISHzQvbOCT/V0o8pa6n/mebTGYCU3muGGy02Cr6o076W/GmhLLamLSCCp5C/sY2RgpdNJE5gnFnDLW+rFh9w0zbbeiTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibRqrl21; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7baa8da5692so255393139f.0
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 07:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707926079; x=1708530879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Z6wYLX2nwnjHvyCMI0KcVd1uNI6Oro56H3c5+ZPzhY=;
        b=ibRqrl21kK/5NzrC9foOBE7uXGkCJ+XEekIDaK39EY3hZQdL+pZEiq2g0CLTqKGHSi
         M6KmlD2NJ7ifltyLbsnl4FRCHFtMPjsKU1VmgcSLS2hXP+N4T3JNC0IX1w/f7oBgikAM
         qMUQeNIqaSWI8VLH/cqyAqxggNjTwPnhviza13tFiygXBkPTbPvJNrq+yu/1p6s2lx2D
         KJGZWsArFo0mWFwnpa4hFI0raG9FdQpWskKknzjMtegyZiiBpTm83HgQXSt5c9d0Zbb7
         NfVmd86OJU3FfmnPsxEfAvBS5UwAVpdNpdw+7oCU7jat8F8+/apPySaAiNAMJ1zTdQB7
         0TrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707926079; x=1708530879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Z6wYLX2nwnjHvyCMI0KcVd1uNI6Oro56H3c5+ZPzhY=;
        b=vJCycK0iMQ5APEPxELiAn2T/R0rB1pcy6bjhe4QUynYiK9nvqL7ney/pVknqwThNFm
         pDKyhqImXlsjUvLz+W+owiDFPWU9iqtfK+UH0JCIdGjWv3DOiMxxek9j4TemZ/60rF6N
         pFLTVgO7VnfcAJYAjr0w8PKv2sGVF5p9TBpoOEtmXGaj6MM/SQ+o3blid5qvlCqgtLOk
         bopnyNYJEy/BY6DjnUDSC4OBlWDGh2GeI9MqesW3fmwys6psu2CdDhuG4v75Cl7ZBUhI
         0m0TxBhuEFqiMwFdOuEdbjQTDgfRRdIDjyMxdXVRrfe+J/firggoeZqbNaX/4XknjUTZ
         iBng==
X-Gm-Message-State: AOJu0YzU61u/z0zUtIG+5th2Hs34KCSgQZbHNQW7Ph0uH4814zbtfSBe
	HRqfNRYEGIk4AjcQwH48p1H5805OQXJmnHnbBkua/LdNJwpZSdc3
X-Google-Smtp-Source: AGHT+IH6OazMR8Ylykduy6oU5iZMxx8XwdOZ6w7O0Oz+XwvkFAk0hpxXNq9ZBVU7KPv9q/o7ZxKTuA==
X-Received: by 2002:a5d:81c8:0:b0:7bf:d163:1e96 with SMTP id t8-20020a5d81c8000000b007bfd1631e96mr3883541iol.6.1707926079359;
        Wed, 14 Feb 2024 07:54:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXjUPrkuV4ZDpOVLjWIFTYpUGITJPzZhlydPsKbF2JNme+RzhDDr8rdObR+yfyqDvPOwfSqWXfDrJxAssUyChLtxNMY94YUkDK9Q/+jN0Wz4LHcCg9XtixpCE4osPs7fV3KOXmFwb9MnUJxjT2ObC8L4a8km2SKGrReHxzX0w==
Received: from ?IPV6:2601:282:1e82:2350:309e:ba0d:4ee:72ff? ([2601:282:1e82:2350:309e:ba0d:4ee:72ff])
        by smtp.googlemail.com with ESMTPSA id s26-20020a02c51a000000b00471603fbbafsm2498545jam.68.2024.02.14.07.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 07:54:39 -0800 (PST)
Message-ID: <f808ba38-95f4-4741-8193-43e4f2a07c3e@gmail.com>
Date: Wed, 14 Feb 2024 08:54:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2 v7 1/3] ss: add support for BPF socket-local
 storage
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>,
 Quentin Deslandes <qde@naccy.de>
Cc: netdev@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>,
 kernel-team@meta.com, Matthieu Baerts <matttbe@kernel.org>
References: <20240212154331.19460-1-qde@naccy.de>
 <20240212154331.19460-2-qde@naccy.de> <20240212085913.7b158d41@hermes.local>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240212085913.7b158d41@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/24 9:59 AM, Stephen Hemminger wrote:
> Some checkpatch complaints here.
> 
> WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
> #123: 
> When --bpf-maps is used, ss will send an empty INET_DIAG_REQ_SK_BPF_STORAGES
> 
> WARNING: Non-standard signature: Co-authored-by:
> #134: 
> Co-authored-by: Martin KaFai Lau <martin.lau@kernel.org>

The order should be:

Co-authored-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Quentin Deslandes <qde@naccy.de>

since Quentin is the one sending the set and the Acked-by should be dropped.

> 
> WARNING: line length of 112 exceeds 100 columns
> #189: FILE: misc/ss.c:3417:
> +		fprintf(stderr, "ss: too many (> %u) BPF socket-local storage maps found, skipping map ID %u\n",

to be clear: printf statements should not be split across lines, so at
best this one becomes:
		fprintf(stderr,
			"ss: ..."


