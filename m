Return-Path: <netdev+bounces-101930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBF2900A08
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 18:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D111C224BF
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 16:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3470D19AA63;
	Fri,  7 Jun 2024 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RoT/S4D0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0A7199235
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776484; cv=none; b=QXnU3DjDJiVfAxHnFRxnlMBbky3mJV2L4JzlkZqrQCGKN5Qq1WeB6+6J9cj5+PKCU23DO3ROg9NV774H9/EoTKQTBxOuIQhD5QQ5tphs/UZ13eKJzB6NzAG9k2tMVHE7be2IO744oA5vZXpQj8BfSyFTkb7za93mSujPyteMehY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776484; c=relaxed/simple;
	bh=YgmzlEZajTJwWqIWiRCWdSe8ddo/mS7cu6s5R2/CTYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eo/uJT9BI+1enyYu7X8n2OmJZEkpL5YRZYIHSAinQGeOsXO+Al0sYqvDuOeWA5UP/WrvLZnj976QvcZhHhRpGxUHMHZbU44YZN5m+tuPTcjSKV5FoCNsFcYKEVTihEIlwWv4+wBza3zQzeHM7H5mxvi8/wRiAWvvYBOlVMBNCVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RoT/S4D0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717776481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5TBI1j6kx25TFs50gZy5PJ7jXuDWillUKGNEfVq7Zbs=;
	b=RoT/S4D0BbjL/TnUG+/+UFPBzHz/jR33UkXB+/gcBRjzKF3NVvgH8jjfzxyoGTpBf63GnN
	w1vtAQ9nPcnaMIe3EX1anUuTGUWVqBd18yhJRcbzVKHdi9v7qoKgB4SrDy3QUmP75wLoxU
	rETdVrrFTFlrgJ5L3BrtKK5NCsazO8k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-BTZIR82WPz-lOjsT1nAnXQ-1; Fri, 07 Jun 2024 12:07:59 -0400
X-MC-Unique: BTZIR82WPz-lOjsT1nAnXQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6def6e9ef2so70695166b.0
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 09:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717776478; x=1718381278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TBI1j6kx25TFs50gZy5PJ7jXuDWillUKGNEfVq7Zbs=;
        b=XfaWB5jiHE7PP6YDk/Q4zzS3FykJOacZEYNLqmw+jyADCQ8UT5dVf/yhhkwO4JXSAc
         lBciXT9ucGHq+/wWo9N1drHBO0og3YAfto0le/vcznUHgQgJAPARksM/bn4Hm6LEcZqS
         bn+AoLQ95O6hoOrW1MRGyM+6k0UixS0J7zR7ZKXPKk10UpFHkRu8gjQ2FH9NSCCG9ctr
         jpAVgShsLuciRZzO9IqE6fHnqRpzo9TkDFuHBHTNLpaPULX6MjPyljSXMaWkvvxK2djI
         8E6QQV9LxS0r2NAoRrWaRWOsm54gVE75wcBkNK8UwfSAaXBKI9xIW5Q6sUA1zZ+djF3K
         6tYQ==
X-Gm-Message-State: AOJu0YzSrTQTM84mtd5WZzu0Omnvk+FYS8N4QEAfFUV5JDE6dJhcEXdq
	oo3XRd5xg8qx8ouTKwoFoIEIdLWxfUHNu4w5BeyewA6vylxtSMJHQ5BSUKnFGmexRRY/Nv/i1r6
	VhsKSaTonu9JUoIol3hdRwzt3qrVSk4K0Hx7l2ZIRGXuu1QuhvtIqeg==
X-Received: by 2002:a17:906:3c6:b0:a68:e834:e9bb with SMTP id a640c23a62f3a-a6c7651abf6mr482856166b.35.1717776477946;
        Fri, 07 Jun 2024 09:07:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1KUiDsNlI7ASi3MzLgO1C/g1AGhrUFu1XlKQH6QLi0peo0XwsPFrtQxIXKCBtcB44XE8hlw==
X-Received: by 2002:a17:906:3c6:b0:a68:e834:e9bb with SMTP id a640c23a62f3a-a6c7651abf6mr482854966b.35.1717776477630;
        Fri, 07 Jun 2024 09:07:57 -0700 (PDT)
Received: from telekom.ip (adsl-dyn127.78-99-32.t-com.sk. [78.99.32.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806ebd59sm264672166b.116.2024.06.07.09.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 09:07:57 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 1/2] cipso: fix total option length computation
Date: Fri,  7 Jun 2024 18:07:52 +0200
Message-ID: <20240607160753.1787105-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240607160753.1787105-1-omosnace@redhat.com>
References: <20240607160753.1787105-1-omosnace@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As evident from the definition of ip_options_get(), the IP option
IPOPT_END is used to pad the IP option data array, not IPOPT_NOP. Yet
the loop that walks the IP options to determine the total IP options
length in cipso_v4_delopt() doesn't take IPOPT_END into account.

Fix it by recognizing the IPOPT_END value as the end of actual options.

Fixes: 014ab19a69c3 ("selinux: Set socket NetLabel based on connection endpoint")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 net/ipv4/cipso_ipv4.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index dd6d460150580..5e9ac68444f89 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -2013,12 +2013,16 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
 		 * from there we can determine the new total option length */
 		iter = 0;
 		optlen_new = 0;
-		while (iter < opt->opt.optlen)
-			if (opt->opt.__data[iter] != IPOPT_NOP) {
+		while (iter < opt->opt.optlen) {
+			if (opt->opt.__data[iter] == IPOPT_END) {
+				break;
+			} else if (opt->opt.__data[iter] == IPOPT_NOP) {
+				iter++;
+			} else {
 				iter += opt->opt.__data[iter + 1];
 				optlen_new = iter;
-			} else
-				iter++;
+			}
+		}
 		hdr_delta = opt->opt.optlen;
 		opt->opt.optlen = (optlen_new + 3) & ~3;
 		hdr_delta -= opt->opt.optlen;
-- 
2.45.1


