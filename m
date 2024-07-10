Return-Path: <netdev+bounces-110594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779A592D524
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 17:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3374D284D2A
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 15:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B891946D2;
	Wed, 10 Jul 2024 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UWu5iIF0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF3F1946B6
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720625829; cv=none; b=GSn4NB0Q8OkgEjyKnAV6jGTJTx7fDLo6EkrFC2Oa7VAEAOJ06UQTKpT5xxQNcxWvzYJpbCsxENy9eh4vkRMyothFultaxlUslh6Q25Xej+2KjhIrGyXNjuM4xsTtca45pkCOcc4+K/t82Xj/EAZr6WldoqWpYNbYrn4u7+F4ByY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720625829; c=relaxed/simple;
	bh=x+o4kPbiFSGaMLLk+/3IeoS/mUq9fZMtsf7DYiEwpco=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=poLftCUi+Ktpy4rAjgWIz6jSRsIfz4JuG1SEJTHGJpoixw8FrDRc9GAgY24ESsZ3W0O/VypS5scUR9dL2AFSD3yZuxGezCwGnEm7U94LRyUYHU15fWR5skid4UpLRO9/a4eX296VW19bBK1Q722qz/Cv2f/6liD5TtN4Lw49Lgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UWu5iIF0; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e03a0faee1eso6595811276.1
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 08:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720625827; x=1721230627; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Zc8nMT3AAU8QDxt/phKAKKjkSLDSDuDLlhBSXcN3vI=;
        b=UWu5iIF0efUgDniKDzNw8OZHm81UsFfCp9sbuh7WGDFIu9+ZmNiUzKJYgqxV7DrKTS
         4lb40W4HcEQUISWpO8YixcvTTg13UZ26EWnbwaMDktJgcE99kIZbGYyLm8FlKYHfxef1
         pCRQkD05YJKiUgPLaRg3IppKVkNN1zzVSlAcadh+8p9EIito4kIhTt4L4fNtlczipLBP
         b8hYoUtW9WOZthY7cK7tI9SBeYIlrlu0aafjyEA5eWEcd/mtCDaKUXJizlyO03W23s/H
         OaMHRjlW+UxfPye/liHmA4yFSdQISv0MthZryme6kGolsQpKuW3b0ojvl6yfSYaa0IQp
         OtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720625827; x=1721230627;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Zc8nMT3AAU8QDxt/phKAKKjkSLDSDuDLlhBSXcN3vI=;
        b=TLVRcWsqgvXG/GKyjtwy+LURE84oipc5t2HSYfC+3RzXHs2TG4TAgy/yg9q3QXpwb9
         QaeB0YSvcu5jm9Oz+5Z3cnPe4kadqrWbF7wvHJcs1D43xBDsZ5LHHDq0vu1G1ZO9vs7L
         zcEdRbK9vIo5zlcCu9yF46UTAXUTSCx5djLwEHX4xUFnQo8maCzEIiIaKKmss9BD8qo4
         8gOExK1y/ZyNMbU8mIY4bNTzlNY/mSSOARPadN0A576NAcbphAZMQjwoUHUU9J1EVAoT
         qGvVVm2ekeGfH60RRFR9tCo7YSkLs3Beo2btQWUb55zdEJonI/gzUCuehAysNu+DRe8Q
         kiPg==
X-Forwarded-Encrypted: i=1; AJvYcCXs3Qo9mLhr+aEYhcU4QOPxGPiVfBUtbMGKj4mZzezwj1eukIoU+D7M5PaCFm3RB/bB0jfcj99FLjn+j+RRVjqcIVtsnzfm
X-Gm-Message-State: AOJu0YzmRHfmplCEAUsRykPVuUZjByklbikSxlHvXRjZjZ3dUITERiAU
	QmiIq5UiqqaoCWUDYhKz7xv5uKqW6ERMDaQEFEf4uXqPJKJKgLL/3pda8yGbsg==
X-Google-Smtp-Source: AGHT+IFHIo6fU+7NNSLyfzTcFAbf/t4vdnUEaBIfh5qv8+9oqH3J3Xkmyxjko8dPd+A7uoIPPYKtPA==
X-Received: by 2002:a25:7408:0:b0:e03:34ec:16b2 with SMTP id 3f1490d57ef6-e041b11d31amr6735103276.42.1720625826988;
        Wed, 10 Jul 2024 08:37:06 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e041a9a156fsm637366276.65.2024.07.10.08.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 08:37:06 -0700 (PDT)
Date: Wed, 10 Jul 2024 08:36:54 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Hugh Dickins <hughd@google.com>, Sagi Grimberg <sagi@grimberg.me>, 
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
    Eric Dumazet <edumazet@google.com>, 
    Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] net: fix rc7's __skb_datagram_iter()
In-Reply-To: <51b9cb9c-cf7d-47b3-ab08-c9efbdb1b883@grimberg.me>
Message-ID: <66e53f14-bfca-6b1a-d9db-9b1c0786d07a@google.com>
References: <58ad4867-6178-54bd-7e49-e35875d012f9@google.com> <ae4e55df-6fe6-4cab-ac44-3ed10a63bfbe@grimberg.me> <fef352e8-b89a-da51-f8ce-04bc39ee6481@google.com> <51b9cb9c-cf7d-47b3-ab08-c9efbdb1b883@grimberg.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

X would not start in my old 32-bit partition (and the "n"-handling looks
just as wrong on 64-bit, but for whatever reason did not show up there):
"n" must be accumulated over all pages before it's added to "offset" and
compared with "copy", immediately after the skb_frag_foreach_page() loop.

Fixes: d2d30a376d9c ("net: allow skb_datagram_iter to be called from any context")
Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
v3: added reviewed-by Sagi, try sending direct to Linus
v2: moved the "n = 0" down, per Sagi: no functional change.

 net/core/datagram.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index e9ba4c7b449d..e72dd78471a6 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -423,11 +423,12 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 			if (copy > len)
 				copy = len;
 
+			n = 0;
 			skb_frag_foreach_page(frag,
 					      skb_frag_off(frag) + offset - start,
 					      copy, p, p_off, p_len, copied) {
 				vaddr = kmap_local_page(p);
-				n = INDIRECT_CALL_1(cb, simple_copy_to_iter,
+				n += INDIRECT_CALL_1(cb, simple_copy_to_iter,
 					vaddr + p_off, p_len, data, to);
 				kunmap_local(vaddr);
 			}
-- 
2.35.3

