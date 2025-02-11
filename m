Return-Path: <netdev+bounces-165055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D34A303A4
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 07:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9C318882FA
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 06:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9C21EC00B;
	Tue, 11 Feb 2025 06:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSSqoje9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1CF1EB191;
	Tue, 11 Feb 2025 06:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739255662; cv=none; b=OeHSfHbSFWR4QMaT0qKe+fh6BLjeO2W+L5FW9LfCfN4LVCIjQWujABj7PI56ALUo7Mbj3/J3bYlP88XRqvX/1v6sv4uCguoUAm2cgPAjsPeNhKeaf0GZybcG4bOCfqkToD07gfM0uNQ7iqYXo0H+DB1ljkgn6GFaKt0Y6XESEDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739255662; c=relaxed/simple;
	bh=aGRpizyASsNtyzOjMY+S0nZ8gaZ1dDZJgRIHfkoSPxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfS/o59qnWvLXlpGQdxkuYqBAVNjgQOcNtU6pqhTAij+PLjNfxTLHu2N6mmkIEwcT9ebA0VEJ+5rp5VxlMLoFsq+Kb3mLTAKn0e/TYqX4k317KXzxHbU/twFQ2PKWpHFUK26DL8pUaWfwPaVObKTYSB/0qQYgogmi6tFKlN9Mus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSSqoje9; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dcdb56c9d3so8340546a12.0;
        Mon, 10 Feb 2025 22:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739255658; x=1739860458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQlwrL1wOOlUYQ3HVkX2Tc4R5TyGKexreWomFPK3P/Y=;
        b=OSSqoje9IjTnj0KYcrgVozI+bBBxuN7LD/MUV5TNEPUW4P+wrLCXq/WrYz1uMAyOr2
         lGMk8V8JZS8SzxYTfR/cWK13AwBKD4a9jlajnU+rGh15SxRjYb+uiXFRjv2OCkAvK0+Z
         2g812NvlU27cHASenGQ4R6HdxO8dUFl3IB0kWQjgVl9ZdkHwXgkOJROoy7Qp5TM0o6yu
         6Lu5VVeeZVIsJyazkS3TZ/hioF9v6Ixe7uXEQY8/RFipN0tK9F6heF8RYS6kmNf+/C35
         PewgjPGNGuAMPuuhnpQf/4fkjQvxlSr634MO9+K4ZlI296dDEcyA2h/iKEWZ0y8/iE8O
         JbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739255658; x=1739860458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQlwrL1wOOlUYQ3HVkX2Tc4R5TyGKexreWomFPK3P/Y=;
        b=UR0a4ILa61Q4xXAzPSBMYdtdUgdgE+ga+YoYJTibRluPtXTU70Pr0MYeKB6WQxWb2Q
         5oAmi1ILHsSqcvwcNIROQjz9qzEDc47LlNzUjG/dcldThUev4hdyr/H4n9HMHK/Jck0s
         GPejKQJLIrjab4QwLFKeq6khRXdAjlMu4gPYRAaAMzOOJLkcLm2liIk6RI0lQ2sibrDH
         DMuF2MGU0MCaxe7rKsJzi5Z4OYUy9BtcksprsKbtmg/pTApBMkD4ukW8f0v2hpIUqo9G
         Cml0ZQzOZgTmM3/C6VxehC9MkNDcU2Go7yC13ENH1Pq9vvpL3A2HMQF1LYZA3KvgO04B
         g25g==
X-Forwarded-Encrypted: i=1; AJvYcCWuNWOuRQryAOqqOeRDoNfshiYAWGRyh31lxKFYcEZhtcgTfbhyOv0CRPWIlKyZ551gB389/DY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznsQzqjIXnf04lHXBsTvPzrDMfpN+9prx15cahAx8eK38AMeyX
	QMXvAWtpO5FJMDAxTeW1C+/AAaceTg58yQvIlRPw0n50eaeb3r4zEU0yW0hE1hPRHw==
X-Gm-Gg: ASbGncvzguQStWd+U6i5HDK/EhyM4v51h8yYuEDu7pKBSD2Sexzr6jILeReBwGyWdk7
	qmdOMKe25gIh6MoioaPgVaOa4v4JtOciovFtuTEVWjKdGHaJp+CPeVxYzpGsn4j1iLXn9DQLNQk
	y7eg03L7uJkYkz0XpDg6Z78F3VpplhtFmKRo8rcg7WnnDaN1sWCgWkhe3C2O/uDcHJhQXU6r12i
	w1HpuGd9r5qKmWYoqavURMLTw4VEYQW5wX1vEWz0bKe0JF8prMcFj+kKknQZ+Yr7ug2GZOqV9lZ
	xp6mNk3vY72tgqfgjgCpTtMPEoF+tftskwETwhqpozuBURDTSgjvYnWw9vYHIaeefo/SiWt4EVN
	h/emPqGiJaRU5BG0=
X-Google-Smtp-Source: AGHT+IFSPB5VMDpn4O68C4Tn6MoteErC5LVqv/fR36wtc5VsAKcH0UgEvTej9OJbBiYLW9OPxxMEdw==
X-Received: by 2002:a05:6402:a00e:b0:5de:39fd:b309 with SMTP id 4fb4d7f45d1cf-5de44fe9488mr41766347a12.4.1739255658307;
        Mon, 10 Feb 2025 22:34:18 -0800 (PST)
Received: from legolas.fritz.box (p200300d0af0cd200603313d7beea72d6.dip0.t-ipconnect.de. [2003:d0:af0c:d200:6033:13d7:beea:72d6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7c62c464dsm300440466b.28.2025.02.10.22.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 22:34:17 -0800 (PST)
From: Markus Theil <theil.markus@gmail.com>
To: linux-kernel@vger.kernel.org,
	andi.shyti@linux.intel.com
Cc: intel-gfx@lists.freedesktop.org,
	netdev@vger.kernel.org,
	Jason@zx2c4.com,
	tytso@mit.edu,
	Markus Theil <theil.markus@gmail.com>
Subject: [PATCH v2 3/3] prandom: remove next_pseudo_random32
Date: Tue, 11 Feb 2025 07:33:32 +0100
Message-ID: <20250211063332.16542-4-theil.markus@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211063332.16542-1-theil.markus@gmail.com>
References: <CAHmME9oqvWp_Nd1Gwgyw52qy8wxztMyCpNsjByH=VnRaXqczww@mail.gmail.com>
 <20250211063332.16542-1-theil.markus@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

next_pseudo_random32 implements a LCG with known bad statistical
properties and was only used in two pieces of testing code.

After the users are converted to prandom as part of this series,
remove the LCG here.

This removes another option of using an insecure PRNG.

Signed-off-by: Markus Theil <theil.markus@gmail.com>
---
 include/linux/prandom.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/prandom.h b/include/linux/prandom.h
index f2ed5b72b3d6..ff7dcc3fa105 100644
--- a/include/linux/prandom.h
+++ b/include/linux/prandom.h
@@ -47,10 +47,4 @@ static inline void prandom_seed_state(struct rnd_state *state, u64 seed)
 	state->s4 = __seed(i, 128U);
 }
 
-/* Pseudo random number generator from numerical recipes. */
-static inline u32 next_pseudo_random32(u32 seed)
-{
-	return seed * 1664525 + 1013904223;
-}
-
 #endif
-- 
2.47.2


