Return-Path: <netdev+bounces-64929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF358837E7B
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 02:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CA51C28F4C
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 01:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9745EE67;
	Tue, 23 Jan 2024 00:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ELFwoPQJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AC754BD2
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 00:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970620; cv=none; b=G8YeIcaNP2qff6YezO9dYI46fOVQ5+8D4/ppY8N3efl/Q0p9DinFTVCqwBLAThqsO02rYfflt32r6OhBjb0Y5xfQyjxFPwaj2etPRpsxF0lyIbRaSXf2fPGm63Vi9VmkJAlkjkruwnJ9cIzQCLz6y+qJWjhCeF5RV7bVqGccy/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970620; c=relaxed/simple;
	bh=MUqmS4qhJg2vbTbZv6gK5aLD9zNZIlzbDg0H92mWw6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXh47uVEt0eK3kR2wCLfQvlr05PZAmVyUYIbAkYqgAJcUVw7wOnCL1gYnlONlzDZzllbUoD9HlM3OFDxzG5h6E7W/dKIQBGuVEZ0WIUXl7ajm4fVZhHsa+sib8Zv3fjljVKajWJJQFuihRCd4VskalAi+ePLErdD/QZUqjacWxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=ELFwoPQJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6dbd07916d0so2226613b3a.0
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 16:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1705970618; x=1706575418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1M/IGdbPj8T8OQPGukSpGo/Li+GJjkhXjFZxGan4dSs=;
        b=ELFwoPQJUuWzZi3HzwHhv7ChY3p0KHwpSxWyi3pUPezbuPbAkoFmqOd+n3OG/BYIV4
         vXrTrv/PblMW6K9KFyS3rMgCBbHoYciiNxvFUHnjpe81zL7DHdBrGci7VstEDo4ksUlY
         TZ/SlCdp/340hBgXSG1PhOyrCM/E283GfSShd/Vk6MR6n8f5XGvmGbY/5XeljlZfTNGi
         8o6CAZfuSf7HAPHxbrhcP1q0eahMz9YiEKh01gkBEU8oAYWEDSblWRqrmj0ai+ytmQXc
         RBxgGgW9lHkVWfN7QfTLm3ruP2C64odwrHX5O/0Q0DsFScrKVHgY6xgCWZQ/XOkcFnzc
         eOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970618; x=1706575418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1M/IGdbPj8T8OQPGukSpGo/Li+GJjkhXjFZxGan4dSs=;
        b=hfR9/wTiv2IGOKmvWY5Z8uNLOFNLn5pG8+ZkjVephBV6siybEhQTibL09WS5Qgt65P
         kkRQfdJWiuoe1jMJNyUJ1jdACW2dQYVbYhd4YUILmM27wAtq+lw3qiBw2aO0kVfcqMs7
         R/uW1pr7fXreDPCrPbraOc6ol3aWhLNxAfG5uy/JhmJlHz/VB/8kuUuXbtLGsXqlY44S
         gi7RKlDU4qjYotVtDsvMgW4fOIW0RNzC3r/ACYsLGTOwWFW0esiCpZD9BkK9sGG68sde
         hiHAwct+St1ZqTQePD7B1F09bUJ97gVjJBXUc1nnpC4HprrLQhu5GUG9J194qhjIt+jG
         98EQ==
X-Gm-Message-State: AOJu0YyA8P46dboGgvbn0q1GDJ1o9++ri8PaiwLFPIbCmSGHsgK0CNlK
	366qWdQOqHpGoz+1waKxU2g4TGouPFl2cEAa108fEDN+dlhM9F2BWX1rdFv9WZ24MDebhMw0ZR5
	nxik=
X-Google-Smtp-Source: AGHT+IE6ysBb50a5Rt/xCmNgeb+8tJicrjDS4XaIs86aYGYUJ9SeyQlYxDfkmk6T4+t24VJc6fF3KA==
X-Received: by 2002:a05:6a00:9389:b0:6db:eccd:c756 with SMTP id ka9-20020a056a00938900b006dbeccdc756mr1280257pfb.57.1705970618106;
        Mon, 22 Jan 2024 16:43:38 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id ks21-20020a056a004b9500b006dac91d55f7sm10314445pfb.136.2024.01.22.16.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:43:37 -0800 (PST)
Date: Mon, 22 Jan 2024 16:43:36 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 1/2] color: use empty format string instead of
 NULL in vfprintf
Message-ID: <20240122164336.12119994@hermes.local>
In-Reply-To: <20240122210546.3423784-2-pctammela@mojatatu.com>
References: <20240122210546.3423784-1-pctammela@mojatatu.com>
	<20240122210546.3423784-2-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 18:05:45 -0300
Pedro Tammela <pctammela@mojatatu.com> wrote:

> NULL is passed in the format string when nothing is to be printed.
> This is commonly done in the print_bool function when a flag is false.
> Glibc seems to handle this case nicely but for musl it will cause a
> segmentation fault.
> 
> The following is an example of one crash in musl based systems/containers:
>    tc qdisc add dev dummy0 handle 1: root choke limit 1000 bandwidth 10000
>    tc qdisc replace dev dummy0 handle 1: root choke limit 1000 bandwidth 10000 min 100
>    tc qdisc show dev dummy0
> 
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> ---
>  lib/color.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Wouldn't it be simpler to just add a short circuit check.
This would fix the color case as well.

diff --git a/lib/color.c b/lib/color.c
index 59976847295c..cd0f9f7509b5 100644
--- a/lib/color.c
+++ b/lib/color.c
@@ -140,6 +140,9 @@ int color_fprintf(FILE *fp, enum color_attr attr, const char *fmt, ...)
 	int ret = 0;
 	va_list args;
 
+	if (fmt == NULL)
+		return 0;
+
 	va_start(args, fmt);
 
 	if (!color_is_enabled || attr == COLOR_NONE) {

