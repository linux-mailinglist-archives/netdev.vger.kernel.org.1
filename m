Return-Path: <netdev+bounces-126737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579DF9725C7
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 01:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BB80B2382E
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 23:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037BF18E026;
	Mon,  9 Sep 2024 23:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KdRgHC7s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF8318DF84
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 23:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725925173; cv=none; b=Bm6qFoDRs4ATCqHIUmV7pqpJ/MmU5vTu+4cVpYyNoV1vhTmt0JFUKlGiGDvXRHg9LYRCf3QSe8yA4xrdEEnbr3UECbN8PKxdm/X2h4vSGsXjNe2ZMJ0C4GQyOOJ1J+nQESIr6phWxV+q4pWHgq/4lzqndQcqtEMxy0UMWl3NQPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725925173; c=relaxed/simple;
	bh=PQLBfaJ6VfhqQVfivocwR49ZIcXL6vLfqHzKJFDT6Qs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Tqo/ZC22bMujAkWnbUc6kW+YHaHQXW7zaQ8piJsKtU5TZ6aNsuCCWnkGfUdUUlR1zx8dqzV6wxwQ0Y97QQ1AGaypiErERGK9E1K7Q0/X04TaN2L67rKRv3qne1cxBZdh1bCGaNlY6IABEt6WZlOXB4FT+FMGe7TMCwvPxl51Mh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KdRgHC7s; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e163641feb9so17311173276.0
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 16:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725925171; x=1726529971; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ms7NkphysWb1XqAgP2bRvWMv1On1IfYc/URB5THYi9Q=;
        b=KdRgHC7sRzsSHHXYc0uOw1zm+6jIW71xFZva5PX+7RETONn69LfmXRlTclTVMLyRBJ
         jmh2HGVJi1efhS5ElwyihX2NmiXBe9dqoxAaw6J9ZrzBuWTKqZ4+QecCiL/72jCLcL4P
         /2+DhKCV0fT3LtUHP4+7/cy2KhAibaTu+tTQoQ9s3qPW11EsYeIxetWwW5p1eiYiCi2P
         A7fuFvQRLn5EbzsXeM73r4/52ZRwoxoF25kkD1PGoCRWrDmz9d7BbWceuYXmMjXKcZ/N
         sr6Q55cWvFTZZNm0vXMen4tKAEUggYo/iheM7XQUvKfw2mM8b8DYeGGuHyyIOJa8vqca
         5eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725925171; x=1726529971;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ms7NkphysWb1XqAgP2bRvWMv1On1IfYc/URB5THYi9Q=;
        b=KPhoM2sNy7ffsFCJsGvDgDpmW0VVwtX0KKaUz7KjTw6Hv4QABVzJUfMLIurjZpbR3b
         T2sHc28YccV3Nfqodl4edK8L+p80hdz8FMCqgwQKoq2uDhztK61dEDt4g9ZjC75pBc1Y
         2K7lSTwSui5J4/OtlElKpC1/np8JfhEJDK+hzAi2las1R3u+3nD7VQ+ZSHSVqgALQlD0
         FgwShmmmQ5OctzjlVNnS0FYq2s8skR0YdbPMbI8avOhHDg6pK0jZP/SMZDTaC4o4Oy4s
         BpWNL0OXawrZfE4B2WcrrQhCArqqi/SHDqZiQWrl2u/8TcxRPlvFYRU6M5afycQh0npC
         uTWw==
X-Gm-Message-State: AOJu0YzBVJkv69thWokDD/vSu+i/NEtdZqD86qp4N5ISo/W1GPlm0AFJ
	kqsh/C5QuMgAQIBeSmhnvhNSnGLPbrKpnD44GA7VMEvVMb7XW+UkkP2XJmqDVHMXt7XwZKLsh+W
	kddOfKI17cq7qTTUND7xcjg==
X-Google-Smtp-Source: AGHT+IFeJvFfGmEm3L6gG+UXB55ikrMM9paT8mMXAGtca+E8au4Qr3p8AYpiR9HeYmJmxEHX4AfoaN9wfDAzTDbEOQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:d894:0:b0:e1a:a114:d35 with SMTP
 id 3f1490d57ef6-e1d7a2b7c4dmr14578276.5.1725925170783; Mon, 09 Sep 2024
 16:39:30 -0700 (PDT)
Date: Mon, 09 Sep 2024 16:39:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC+H32YC/x3M0QpAMBQA0F/RfXZrZDS/ImnNHbd0aZNo+XfL4
 3k5CSIFpgh9kSDQxZF3yajKAtxqZSHkORtqVTfKKIPxDOKOB4VOdJY9ulW26RdarTQZrak1HeT hCOT5/vdhfN8PrrRT3G0AAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725925169; l=1408;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=PQLBfaJ6VfhqQVfivocwR49ZIcXL6vLfqHzKJFDT6Qs=; b=vqJ9gCWlVHewr8Uf9LyHuMycjoC6BQjS2mmtSMhyxfPBVlpzc7s9GTyMPchFiosbexFwL4igw
 PQ9nXS/jyRSC4gREH5fZ8Mu8AISzJ4FvsVRvP4AnY2vcxo4/KmSX4qH
X-Mailer: b4 0.12.3
Message-ID: <20240909-strncpy-net-caif-chnl_net-c-v1-1-438eb870c155@google.com>
Subject: [PATCH] caif: replace deprecated strncpy with strscpy_pad
From: Justin Stitt <justinstitt@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings [1] and
as such we should prefer more robust and less ambiguous string interfaces.

Towards the goal of [2], replace strncpy() with an alternative that
guarantees NUL-termination and NUL-padding for the destination buffer.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90 [2]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 net/caif/chnl_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/caif/chnl_net.c b/net/caif/chnl_net.c
index 47901bd4def1..ff37dceefa26 100644
--- a/net/caif/chnl_net.c
+++ b/net/caif/chnl_net.c
@@ -347,7 +347,7 @@ static int chnl_net_init(struct net_device *dev)
 	struct chnl_net *priv;
 	ASSERT_RTNL();
 	priv = netdev_priv(dev);
-	strncpy(priv->name, dev->name, sizeof(priv->name));
+	strscpy_pad(priv->name, dev->name);
 	INIT_LIST_HEAD(&priv->list_field);
 	return 0;
 }

---
base-commit: bc83b4d1f08695e85e85d36f7b803da58010161d
change-id: 20240909-strncpy-net-caif-chnl_net-c-a505e955e697

Best regards,
--
Justin Stitt <justinstitt@google.com>


