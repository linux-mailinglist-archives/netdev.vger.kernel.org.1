Return-Path: <netdev+bounces-73030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 802EC85AA79
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BAF5280EF0
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574BA446A1;
	Mon, 19 Feb 2024 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="s8sWEyuJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0E347F50
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708365566; cv=none; b=ImJeLbGhrv3uaxLtgp051ak/ESsFK7GK96vkgtzTCo1IsZZ4NqAnDrbs4EVuxxxjoM1JnkIJ500VLHHwVkqItkrN9QrhS0oMw85SYJD6B+woM61I/4ccr/Mhdxj9W9SkeUALynsc510ADpUTB7h1Oxw5uBUQKZeGNtJBADZLGk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708365566; c=relaxed/simple;
	bh=dl5W+bJIH7PeMciWPsjUiONOMbJ5NOmYB5ClgaVwVr8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJptuq95O671n0Sl9MeHj3uDuua7dVFyP/gIoCCwBE6lQMR6kVwhlVHeLISAFpAo4zDSNna6aBSV9wYNU7DTU8MTYDLGdng8lYGehkzQIR618Ie3BPZYJxX0UlJf88C9oPqsr3GOEe2hDtOkyvsw+8F4NJlfwj9fJzfhcZVAJwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=s8sWEyuJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d7393de183so36354515ad.3
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1708365563; x=1708970363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLm94qerMkG8dgo67jTSXF0/lsFfXFJuvfcCnXaNMS4=;
        b=s8sWEyuJ5ny9Nl9ZJnCPj6NgrtI0m+ITR8wggaF3hjO3ZUyqEQzN511kSOE8vyNia+
         scTeIJFgOVhvZsdYMlH5vo0/YTCeAgm2bJ6OWbH7Vb2O3NqUV4hWipDAHQmiL8qNXuRy
         1lRXnKnN/H0Yt7pJgFmy8yqYo+7WExqsR5VehXhdEeJW5MbNApfcitZOU0yB09R+IYtu
         6Zm6bAseorBi/9n/QvuXYc/PoQjG45caPFkDtZ0dfKRexa+OzOjYUOfcjq5WTsvwP75s
         teV4OmIjuLJjoICmquby0pVYs3SYZ/G0rZxlkmbxtcMIGwhlCLhu9EOnIrz9Ql25wFG+
         GEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708365563; x=1708970363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLm94qerMkG8dgo67jTSXF0/lsFfXFJuvfcCnXaNMS4=;
        b=UYSJvVE3ooB06hKZqJJoqWI05uYA6O2gdaOuX/nwTv+LoEV7xFMbMvnDu6sGole4bA
         GRn/8hoOIXW0GNPe/FBbx7GhVX8QJMvbDOpCRWomvAQEfa72cLS/BWIOmBBkI2df5oei
         ak6+0HQVcHuPdrI/9SShsqx5OG5XC5FBSMPzkw2+dHBKaDHNZgjJjSOmZoCDG/zVRlXo
         nr+1YbHHG0ZQlNEn7Tu+zDLKcFo1BVLSlKSOiPN29ThqZyO8pqDZzXYuxY4P3wwkv+5e
         9BkMJE1bxbN35/ISt8inSNy68RweTPdfW0rTBH+kAgfuVT8txJLGisu+gR7FTFij5R+Y
         3cwA==
X-Gm-Message-State: AOJu0YxO7ZDtWY8IK+AztpZE0CHQSxlvVnhE5HNfZ5IDyU+SZxPSZcJf
	dGbhnZHY0LSCP2NyknkD4CY/0Ayu6h9rfjojRfA8Kn19WWCyigi/09FnMfEsmWEIuLWFyddk1bB
	o
X-Google-Smtp-Source: AGHT+IEbe/GKJxw6nbvyPJp9PllPw/HXc1IGUXTVYo6/iQPYOTThlVs6vQVOhwq9BuQJzDJxGDTXNg==
X-Received: by 2002:a17:903:22c6:b0:1db:d42f:fde9 with SMTP id y6-20020a17090322c600b001dbd42ffde9mr6453368plg.41.1708365563099;
        Mon, 19 Feb 2024 09:59:23 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id bd5-20020a170902830500b001dc0cb0413fsm633064plb.155.2024.02.19.09.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 09:59:22 -0800 (PST)
Date: Mon, 19 Feb 2024 09:59:21 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <hadi@mojatatu.com>
Subject: Re: [PATCH] m_ife: Remove unused value
Message-ID: <20240219095921.64594de5@hermes.local>
In-Reply-To: <20240218194413.31742-1-maks.mishinFZ@gmail.com>
References: <20240218194413.31742-1-maks.mishinFZ@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Feb 2024 22:44:13 +0300
Maks Mishin <maks.mishinfz@gmail.com> wrote:

> The variable `has_optional` do not used after set the value.
> Found by RASU JSC.
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>

Yes, it is set after used.
The flag should be removed all together and fold the newline into
previous clause?

And since the if clauses are now single statement, the code style
from checkpatch wants braces to be removed.


Something like this:

diff --git a/tc/m_ife.c b/tc/m_ife.c
index 162607ce7415..fce5af784e39 100644
--- a/tc/m_ife.c
+++ b/tc/m_ife.c
@@ -219,7 +219,6 @@ static int print_ife(struct action_util *au, FILE *f, struct rtattr *arg)
 	__u32 mmark = 0;
 	__u16 mtcindex = 0;
 	__u32 mprio = 0;
-	int has_optional = 0;
 	SPRINT_BUF(b2);
 
 	print_string(PRINT_ANY, "kind", "%s ", "ife");
@@ -240,12 +239,9 @@ static int print_ife(struct action_util *au, FILE *f, struct rtattr *arg)
 
 	if (tb[TCA_IFE_TYPE]) {
 		ife_type = rta_getattr_u16(tb[TCA_IFE_TYPE]);
-		has_optional = 1;
 		print_0xhex(PRINT_ANY, "type", "type %#llX ", ife_type);
-	}
-
-	if (has_optional)
 		print_string(PRINT_FP, NULL, "%s\t", _SL_);
+	}
 
 	if (tb[TCA_IFE_METALST]) {
 		struct rtattr *metalist[IFE_META_MAX + 1];
@@ -290,21 +286,17 @@ static int print_ife(struct action_util *au, FILE *f, struct rtattr *arg)
 
 	}
 
-	if (tb[TCA_IFE_DMAC]) {
-		has_optional = 1;
+	if (tb[TCA_IFE_DMAC])
 		print_string(PRINT_ANY, "dst", "dst %s ",
 			     ll_addr_n2a(RTA_DATA(tb[TCA_IFE_DMAC]),
 					 RTA_PAYLOAD(tb[TCA_IFE_DMAC]), 0, b2,
 					 sizeof(b2)));
-	}
 
-	if (tb[TCA_IFE_SMAC]) {
-		has_optional = 1;
+	if (tb[TCA_IFE_SMAC])
 		print_string(PRINT_ANY, "src", "src %s ",
 			     ll_addr_n2a(RTA_DATA(tb[TCA_IFE_SMAC]),
 					 RTA_PAYLOAD(tb[TCA_IFE_SMAC]), 0, b2,
 					 sizeof(b2)));
-	}
 
 	print_nl();
 	print_uint(PRINT_ANY, "index", "\t index %u", p->index);

