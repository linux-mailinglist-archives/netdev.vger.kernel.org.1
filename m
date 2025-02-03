Return-Path: <netdev+bounces-162148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5C8A25DF7
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 16:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335E21887815
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EA4208969;
	Mon,  3 Feb 2025 15:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMcjuN5j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B943D2080FD
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595183; cv=none; b=Conm8BTWQevjcutwfc1eT4skmoQIhIVks6H8qRj1ZzeLR/salVcCsWR7ba+Zv87KswCXrjdsS9QT4+9hn0cmIMnELSISajCz/VIiuoAwE3YoytV5oQ1A3TLgJXfw7OpGhdNQmw7XvN6ZcGyHv+RIY5UCYHDxGV9j+eQRbWBVzGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595183; c=relaxed/simple;
	bh=0a2AHoQOukFCbHKED3fNzPTocRkbkYTRuQJO4IIG7QU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h55oXx1GTQ3/isj5FxfPZCjUhrrEtPk8XEfzx2aeF0C3rWGzwP9thfDsYfOdEnUK41Pjkp3yWC9kxXXQeeIwfTJqILcw28ycf2072bcA1qGwYqxo7yE1XD5crrV28o3d449cBbgxp9tYbQvjg94PJbmner429mHO0DPqixFtxrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMcjuN5j; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6dd1b895541so86817796d6.0
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 07:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738595180; x=1739199980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wTpHk8Ni2lMG6FcTD4RJ5fuZHTv+0UWIqFVHTy/2yao=;
        b=IMcjuN5jJ0HTvSBtJbr9K9Kv9lRgX2ZYTRuZbli2bpJdH7Gku1632MpzTbB1OtfT+k
         623T/YPloxpKQE4x7oeT5NS6OwnYxlWqw5v3saUA5y045IbOtiWI5nvmE6LbsT1SYnjl
         Uk9qosqxJYeH9KQmSe97cr5fENEEw56sIMD9XVTXhmeigHvtWbBky15ZhakFg1xrpTN7
         ijgBkMMb9PweAlBi3y8cteR1Q841CBbSjDpn5rTduU7EJq9GjIBqZyjWuQZjKnSSctEy
         c52Jy5VA9TJE5b2ivltUwdC3bjWsDgZg9yIQhOirTfWccVvd3dljG/eKFdCrgjdVdmB7
         fzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738595180; x=1739199980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTpHk8Ni2lMG6FcTD4RJ5fuZHTv+0UWIqFVHTy/2yao=;
        b=IJREke7rPaV6sdnuA+s3ca+ddrNGNJYp7N0p4R7wM7tLMzZVjHsEOZS9gvQrUU/PHW
         oH5vhAHde5bAgQ7PQGBXgVbVKm4kWy6sDbszuOO3GNsxPq6C53If776MYEl19ERp08pS
         ofrwq7LWM8Z/iR/Pk8DcBZ0SPsHlFA6Gucx2GJ45ytqgtF38nqgHowj20aTF1LTCITvB
         IBS94tMcWZVQ8oOnwymw0myhx+6dBRcwCxnSu3WBELwWtrbmGBth5y8zw0iZt8XNUEHr
         11Fppl3OOx9ahePPIAibQ6lnYSNilkA+7Rb1lniykNl08VYb5oYptP3DABPtS+Kwf090
         TvsQ==
X-Gm-Message-State: AOJu0YwjrfcHzSa9qYvwE6uzsU+C9NvI24ySmWWEXszdu/66FL1izZ2A
	leqC6fJ95UQUnMl5tixc+cxDNiJYaeDzvpGdm9+Ao2dDoeb8xtypQH/dYA==
X-Gm-Gg: ASbGncsYK6HE/RtDud90wsBICEnTbSccB4ife4Ded4alIwWidQZUpE9lejHRzu/0YP0
	kfNptsAJnjOJkQHUqzWPv3dSlatRbrJPLMc/UWA4jPUuWxUCmPdZcIWyuy+Kv9gtykbtlSc+cni
	pv9jsmSDORWoym7fh+InjKjwNK0ZD6Rg3rrWRvWtX5pBxC4vkp8RPyF1k+6paLAA3e8FWOKOsZo
	5vh9qdpmjZYOK248mODqU+eXNvWgrQBMDt6ip5p7zvUj7w1uEROTUjWWUqBmXR3JO0r7GUvcHPZ
	F+nnt+SXDfGdY0YCmcpHzM6cGaPGq2KvEZJ4546l+qDH2EypLmX8Bu6LK2kRyqZTtyNJg+4DZ2J
	LRBkbUyuIyw==
X-Google-Smtp-Source: AGHT+IGKpkqjreLM23rVxSYQlPQ84JR0bYOGjcq9aHYGJLG92kV4zffJ6D/440q2/NtJ2LKVOIUNEA==
X-Received: by 2002:ad4:5dc8:0:b0:6d4:c6d:17fe with SMTP id 6a1803df08f44-6e243bfd711mr342326016d6.25.1738595179940;
        Mon, 03 Feb 2025 07:06:19 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e254922e00sm50995756d6.72.2025.02.03.07.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 07:06:19 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jasowang@redhat.com,
	Willem de Bruijn <willemb@google.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Stas Sergeev <stsp2@yandex.ru>
Subject: [PATCH net] tun: revert fix group permission check
Date: Mon,  3 Feb 2025 10:05:23 -0500
Message-ID: <20250203150615.96810-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

This reverts commit 3ca459eaba1bf96a8c7878de84fa8872259a01e3.

The blamed commit caused a regression when neither tun->owner nor
tun->group is set. This is intended to be allowed, but now requires
CAP_NET_ADMIN.

Discussion in the referenced thread pointed out that the original
issue that prompted this patch can be resolved in userspace.

The relaxed access control may now make a device accessible when it
previously wasn't, while existing users may depend on it to not be.

Since the fix is not critical and introduces security risk, revert,
rather than only addressing the narrow regression.

This is a clean pure git revert, except for fixing the indentation on
the gid_valid line that checkpatch correctly flagged.

Fixes: 3ca459eaba1b ("tun: fix group permission check")
Link: https://lore.kernel.org/netdev/CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com/
Signed-off-by: Willem de Bruijn <willemb@google.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stas Sergeev <stsp2@yandex.ru>
---
 drivers/net/tun.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 28624cca91f8..acf96f262488 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -574,18 +574,14 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
 	return ret;
 }
 
-static inline bool tun_capable(struct tun_struct *tun)
+static inline bool tun_not_capable(struct tun_struct *tun)
 {
 	const struct cred *cred = current_cred();
 	struct net *net = dev_net(tun->dev);
 
-	if (ns_capable(net->user_ns, CAP_NET_ADMIN))
-		return 1;
-	if (uid_valid(tun->owner) && uid_eq(cred->euid, tun->owner))
-		return 1;
-	if (gid_valid(tun->group) && in_egroup_p(tun->group))
-		return 1;
-	return 0;
+	return ((uid_valid(tun->owner) && !uid_eq(cred->euid, tun->owner)) ||
+		(gid_valid(tun->group) && !in_egroup_p(tun->group))) &&
+		!ns_capable(net->user_ns, CAP_NET_ADMIN);
 }
 
 static void tun_set_real_num_queues(struct tun_struct *tun)
@@ -2782,7 +2778,7 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 		    !!(tun->flags & IFF_MULTI_QUEUE))
 			return -EINVAL;
 
-		if (!tun_capable(tun))
+		if (tun_not_capable(tun))
 			return -EPERM;
 		err = security_tun_dev_open(tun->security);
 		if (err < 0)
-- 
2.48.1.362.g079036d154-goog


