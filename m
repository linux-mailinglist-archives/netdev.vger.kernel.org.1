Return-Path: <netdev+bounces-177029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 343D6A6D61F
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 09:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF338188D52F
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 08:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6258625D1F4;
	Mon, 24 Mar 2025 08:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jf9PVOci"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FB6200CB
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742804822; cv=none; b=UgoyzA8dOoB4Ero0uGbjWK63avyo/cek8hztALWLCCzf4XYvPq4gOQ81WJSq+9kbiVtwVe1Jj4/bp8XE5WnV+6IN/aB8PnwF30IGCpEWN/oZ6qLcyYMUqDkqqECkvnVvX4szdeSfEzgL3zxsSJG8bEoDP7UkptmriQCtLX2PSi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742804822; c=relaxed/simple;
	bh=3PJjPMd27q1Qakd9nc/ER0N23ZYTB9SWTYQq41IIb6A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=o+pGY1FF1JIIINtPMyy2PpJYuNc0YHOEK5Ub9vfASfa5vPviHl5ekk8RDQviBXZUW9ca9UeA4p99gL2nG0aJtlZnqFtsKpqIFByJS3C7Pc6ebqmt8jIGf2MKMy7NW3cIkA4oimftBM4geAms4GkW+pYZo4JGylSoYxDTv0JQFYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jf9PVOci; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e455bf1f4d3so3117260276.2
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 01:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742804819; x=1743409619; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1LWG84KcPvLuAA6LMMk08JlAboQerK07O7xU9OK3Xjc=;
        b=Jf9PVOciIoXhU4S5aV7PwZoqexDY/hzbRsARaMWrbQP+rnLlDjGwm2hrvHlXQGd+Zv
         DW9BWSJLToPgeROptCiSVQNnf5ZjpNRkUQG0I3BvY6qX8T3r6q8ykLTdtD5E/iZ01qbM
         /TU3WNQAWM/VTjrIb5Uc6WIT2UYMGiIZW0/arX+wyRHzrT55fF1IymzLPGGWWjdK3T5O
         pcDzj1llPbyQo74nS5FgxJz5GXRxdNqmoOnQjz/FBJ1b+NqDcdadQ1o1id2MTTTzX3Iy
         5LgqmEbu+KNoww4fv8JzqtLbj7PsUme3ovriDind/hAaVLwJlws2IuI2NulKCYmA0yyj
         tc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742804819; x=1743409619;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1LWG84KcPvLuAA6LMMk08JlAboQerK07O7xU9OK3Xjc=;
        b=dSkiIutrHTtG+IAy1XKKEN7zbbamPU6/EzladnQSUearJNo5n0bp9kNJz0JTzyTC37
         MSyepiFFxpcvhTrnORVA5EKViWt9wLxiqLQkRHuQOAGiJM37xtr69ZFT4SCigvnwCVrY
         6Mk1bs0MAhky0qFW/pEIlK1168cnYw+IQBsWlZBnLYDXNekwk17lq/9ghDM9/XmhcPGX
         DVXkfwUFAg2zlP1CpVtmAWi3fIaS8YRN+94CRU0i9SINxRttTBD1Yv4WDdcdox6MyF1Q
         cHPtzBjAUhWCrCuFIzFPLGxDpPKirL7jZQfcqdbKQqjfCiUjSfKxmsovTSJccFnEk35L
         LWjQ==
X-Gm-Message-State: AOJu0YzH4K8Dq4ugL3aGwG9THlctKDBGd2gqhOSCsEefGiEQ6mbfzLUF
	DgKtRVAFb8uszbOD994X9rCm4ARyasc8jSUceFjGta8gF5xW9R0gDW+wc7udrx7O8rFPWpYFxVC
	7TlJBis2b1VHI/RkvrPDD362kBRTO1bwBFts=
X-Gm-Gg: ASbGnctcMzU04VERkjzQPLcTwDhNi7WofqFJxIOIjDwmLLJIyxTy31EZK1IUEG8TXXc
	zq09q/XWXoe3w4FxAS/4k/0jki6pUXCI9crTJaIa4+Q2SgBMUXa9x8KzLb/b+JRu+o8XhYtyQBA
	658RplSTkIxwgMcA2mCiofADh8Fw==
X-Google-Smtp-Source: AGHT+IHEFXqbR5RcLBrroVaYh3qhR9bhXkHH3h1eoZvo6aMhZBs6/gVAIRzyQ863xEQi8WHIn6kKbrh2e52QT2rQOmE=
X-Received: by 2002:a05:6902:10cf:b0:e61:18f0:8505 with SMTP id
 3f1490d57ef6-e66a4d42ce6mr15070589276.7.1742804819439; Mon, 24 Mar 2025
 01:26:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ziao Li <leeziao0331@gmail.com>
Date: Mon, 24 Mar 2025 16:26:48 +0800
X-Gm-Features: AQ5f1JpHAx-QRi_8pMTZz1NIKlhAT_yIbZaHQnC0rN1s5VQSJPN1XxiOoQTR-8E
Message-ID: <CA+uiC5ax7p3sn+F6cFYUvLnUHH2_4LauOCNtyGCZZZr7NNY2Kw@mail.gmail.com>
Subject: [PATCH iproute2] nstat: Fix NULL Pointer Dereference
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The vulnerability happens in load_ugly_table(), misc/nstat.c, in the
latest version of iproute2.
The vulnerability can be triggered by:
1. db is set to NULL at struct nstat_ent *db =3D NULL;
2. n is set to NULL at n =3D db;
3. NULL dereference of variable n happens at sscanf(p+1, "%llu", &n->val) !=
=3D 1

Subject: [PATCH] Fix Null Dereference when no entries are specified
Signed-off-by: Ziao Li <leeziao0331@gmail.com>
---
 misc/nstat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/misc/nstat.c b/misc/nstat.c
index fce3e9c1..b2e19bde 100644
--- a/misc/nstat.c
+++ b/misc/nstat.c
@@ -218,6 +218,10 @@ static void load_ugly_table(FILE *fp)
            p =3D next;
        }
        n =3D db;
+       if (n =3D=3D NULL) {
+           fprintf(stderr, "Error: Invalid input =E2=80=93 line has ':' bu=
t
no entries. Add values after ':'.\n");
+           exit(-2);
+       }
        nread =3D getline(&buf, &buflen, fp);
        if (nread =3D=3D -1) {
            fprintf(stderr, "%s:%d: error parsing history file\n",
--=20
2.34.1

