Return-Path: <netdev+bounces-225192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B95AB8FE16
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8428E18A2548
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 09:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB952FFFA6;
	Mon, 22 Sep 2025 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG6vfFvI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F972FE589
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 09:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535045; cv=none; b=fMyD7vok76eWHEn9439QwV+kOuZVEsyeH+AdliZXp5dLEHgjVRp0HVrbEIJBHKNXk117nWkxiLsWakrCFd7h155m5/gSGRxegxUowg9Ulb9fyR1h5xQglg1lxkiGLhQDhrWStjVwq+9Lo1UYRRMyUq73DSyuCyiM8SILB71+UN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535045; c=relaxed/simple;
	bh=kmQ+U8Enw1LU4PehAdujiEV2CtRVJfOvPpSqaxAbVhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTsp1bFG0456naL7bUG5ltzrq/iDT6UbZMH1GROSkf2/N8tU8r0IWfzwhLNiIk6EcdwXCBQ71GenwNOkeGy6iPmv4TXUJqjJ7zV48Dlq5GD9hWrCwRs22aRi6FYKCb10rYPfWtZ9b+DBah1wMK9v0beQlEtZB9gzp16fWalN68w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG6vfFvI; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4c1fc383eeso2835612a12.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 02:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758535042; x=1759139842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeB3FT7O6G7iODwiTHw497b3MyFZuWsXQP1LvFOC/Bk=;
        b=dG6vfFvIE1MRHIvxLMW0PTtStGICfLiXpkzT/CjoaD8ZLOAJ6AHleyaQ0u828lW9+g
         Jf1ulaz7C8QUM0+VE7b+j2S+wYlsfro5/sp0cZlwczfBMN0T1bTpDM804XkvpUdZ8g2M
         X50S0R1v+TUOxmjQYxTuQpbLRMDd+PnU21VTGu0AKUc9Z3p57TaIXiBGp8sn4126UzFk
         HUqBzXJPSlBHjQUMrn8PDw7ZmwQwK/+k1hd4MFIoUHqSFatQFbGtiZhfZN/exi1/piTg
         w0eoXX260LF3tQHWZl+jFPhwwpD891yVvbW2PEWYvIMw4GEE8P36Qpw0MOXCj5C/Ekv8
         rWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758535042; x=1759139842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeB3FT7O6G7iODwiTHw497b3MyFZuWsXQP1LvFOC/Bk=;
        b=iyY0SXjvGKTMxB9rslBoN9KSmBwtLPDNBnIiIlwomovUqetbwT8LoRhUHg6vg82TJW
         d0IalVBBmtzdevoMhHwax4p0papbrHvCjfngCOWQ2VyRiuVmvhOP+FIpLjTFsQDO8pkQ
         OTq/SeL5cCg4oo+ApGnl1DFl8iA3uyqsUHO+T0enHJYGYQ6ZvBwSWacOnP54R+fRQ45S
         noeizERNIElLlRpIaLwX5IvhZ4wFjOhnJkX+J1C6Vd/tOiNHzTmQS+sbEuUeEVnyGi+u
         dR+jXjVTf6+BHDxXZrVqmi/f53gbvn4+bOJ2XBIHbo6pwEJL+/G9w+kE9fv2Z6i076FN
         d0SQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9SuMrMox+hjgIU0qgH79MXweGXkCAfl0baUfm3LV5MMGYjDeqEGe/tGkKKR3EslQ9ou4uh5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgFr+InVqbiIubUpAM8zjD51ztxu2XcXDN4nbbokONUNv4A8jy
	x8ZH7nxIwlGnxXwoLDjg9EG19ck7qZoHY0uAlLKasHWmrVZGeKnwskhq
X-Gm-Gg: ASbGncvfflO/1sqiXCXfo7qIbK6JkiyCp0+LAcZPxyLAnDUzBaAbEUnuk3lm9hucnuy
	XpAcYIRqx78Ujddz11+4qLRLJKlSxr+tQXZzJ1LgMk1309NtBQwjyqoWcazz3KLyhsEMv6KzF8E
	CW5CWAzbhyKQmKgNgSuOx2mlcjkOXFq6YsEzIpGDzBfPZF0hsqa62pFGPd5aYvNxHNCh/Yiwszh
	+cjZ2sCortPOssBq0qU+6+6mZnr/KJv3oCZQ8F/Z5G0jZcZUwJPayFOEVTEy5INhh3bOSdgt/pw
	P5aIRQC04C/fwYpZ16zLAUUt4nken8g6mfenoW6/F+wCCbgdAnZA6jFqi9giM0oelqzvT1zZWrH
	rGLxSnXO1ZxV1ulA+k717OA==
X-Google-Smtp-Source: AGHT+IEoygJmzEYO44daSPyeFaTBpaCMbE2ZfuMa7RzKKwvhLfvLaCA1dISw2KFcv2rO+bW3GUDBuw==
X-Received: by 2002:a17:90b:3888:b0:32b:c9fc:8aa2 with SMTP id 98e67ed59e1d1-3309834c048mr15642705a91.20.1758535042341;
        Mon, 22 Sep 2025 02:57:22 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306db47817sm6030258a91.4.2025.09.22.02.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:57:19 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C0AAF41A2EDE; Mon, 22 Sep 2025 16:57:15 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next 1/3] net: dns_resolver: Use reST bullet list for features list
Date: Mon, 22 Sep 2025 16:56:46 +0700
Message-ID: <20250922095647.38390-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922095647.38390-2-bagasdotme@gmail.com>
References: <20250922095647.38390-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1221; i=bagasdotme@gmail.com; h=from:subject; bh=kmQ+U8Enw1LU4PehAdujiEV2CtRVJfOvPpSqaxAbVhE=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkXZbb+nzixgEMs8fhJifu7PA9GTpZYkve3Sq1e+PPhp LifCgyPOkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRJeqMDP+ro2fO17gVnPi0 cOlZm9xHHPOWui84fJ5Tfs9BKbZ2BxuG/yXLjHJv5bzO1o5f92za1Wlfb296waOufrCSt2Fe2xK 242wA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Features overview list uses an asterisk in parentheses (``(*)``)
as bullet list marker, which isn't supported by Sphinx as proper
bullet. Replace it with just asterisk.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/dns_resolver.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/dns_resolver.rst b/Documentation/networking/dns_resolver.rst
index c0364f7070af84..5cec37bedf9950 100644
--- a/Documentation/networking/dns_resolver.rst
+++ b/Documentation/networking/dns_resolver.rst
@@ -25,11 +25,11 @@ These routines must be supported by userspace tools dns.upcall, cifs.upcall and
 request-key.  It is under development and does not yet provide the full feature
 set.  The features it does support include:
 
- (*) Implements the dns_resolver key_type to contact userspace.
+ * Implements the dns_resolver key_type to contact userspace.
 
 It does not yet support the following AFS features:
 
- (*) Dns query support for AFSDB resource record.
+ * DNS query support for AFSDB resource record.
 
 This code is extracted from the CIFS filesystem.
 
-- 
An old man doll... just what I always wanted! - Clara


