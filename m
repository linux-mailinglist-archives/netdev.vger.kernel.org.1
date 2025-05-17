Return-Path: <netdev+bounces-191227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BDFABA6EA
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 02:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D424C0A51
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77986136A;
	Sat, 17 May 2025 00:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRfdNwRV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0143510E0;
	Sat, 17 May 2025 00:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440275; cv=none; b=pl0D05MeuPaqxDWksip5A2muja1jTqaxltZVnMz3BKQ9Vcza7o4D8koXVHyF/xbfiEdKewbOJoPQ1duK/w21938WqPZNdZ6nQXVGDy1CmvrzviyUcsbgMelIgzGEOcSQMZrsGB1tvHADY4AJL1BcAk6kzo5labWjQTXDPwhlQtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440275; c=relaxed/simple;
	bh=j4smKnIucW5h8+JRIWzZTEG3Ww8QnHKjs/97NGL+Jmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RgKfPepZJvBDTCBmV2vRrmQJy1gATeRGGrn53nE3/2SiydXdmRuNq0EwZtM0OsKJiDY7QqE5UVybgPxm43FlRZReeqUB1INdPQDOF2uNPedWldhYFxsqfIFHKsNRuBnW+eQE3IygSX5EpIBQRlwRYFyYRs2rviOAdDpOoAoyUYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRfdNwRV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-231e21d3b63so15355305ad.3;
        Fri, 16 May 2025 17:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747440273; x=1748045073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mIJnfKGtkXlF2Encrce81RM8lOxuzqBOgBxi1H8e+9E=;
        b=KRfdNwRVB9pULA1EMdGD7Ht6WfFHVpCA1Ix8mYw8mLtiH1YshMNT4KNd9EppIXoNPn
         R/bpliST7FzBVHtHBzNyozjB/mOktwLT047BaWcRxLnGPD8Masvs8N9khWWGRKTsLXjn
         zDI7MsP4Nr4TROnn9deSwixErFR+Cj4fFij/nV37jiio3MrDx1CpTFsv0PLWtrZK81yD
         RcLi79yhSY7OxaqF0wCf9migFd4VhKlgoTl3v9Ag5NA2dKHUWRJkMMSOOXeXlL3fa3Xn
         fgeN1NPvr6aQi2tFqJFp8jwW97oqz6iw2EBOJxRj5B9lP6mQnmCowcJzM4yQX1ly5G9O
         sdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747440273; x=1748045073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mIJnfKGtkXlF2Encrce81RM8lOxuzqBOgBxi1H8e+9E=;
        b=b/vlTGurSdka8aOifk8EyYPZLccVD6tuT/JXUUjHQeg4s1oy2sv+vZI/KehSvnzG05
         IgSHJagn6ILIWH1gXImttNoV79UAxuTP/wwpghgSPza4qw7yHJNviFVnray1eDTsLVUl
         zNnro26HRmhoDf9VtpqxVCEyJ+vcI6Im4hxgU9yxP54xWRR3MpZjxOiYVnYLn+nN8/iQ
         koOYmzwe9KDnHQJ/jilufmvWsgWXmSjZZqH6H2Pq6BWEfHseGQvfEXWyT97OLYZIoI0G
         LCPXdp9hbdK2vRfHY8FqhZ/Xe7uMvxOkX+ZJjoC2P1jrDTNuYsNuyFzSB2vqK2rqjOTF
         sfQg==
X-Forwarded-Encrypted: i=1; AJvYcCXAzoNiKCSBRxN185pPx6+n7jqCJztN7qof6lSvX7SDUC6jOnQV51STTRwz8umcdzWuheKxEb2kGddoxUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz934zNwl0Jfoj/ZpPxjA+iT6tjsJrWsfNw1GEAeJsZlh/BIljm
	GLmAS3JpUDx6DqwYMVSNoJSoajKvy4UcoulnbmLySb8U0a/gdNNxJTCLDKPsXKU=
X-Gm-Gg: ASbGnctmCFnsIt0v56urq7G7rFjraV8cqxEnIvoZv3Z3o2bSTHc5Qu3hRD7gQITR10w
	khSiPWg8moeUgtrXjmx5FgeEEgp0GUHChbtGrQIqCElApMplnCbe3fE+35w/nZzql6t2kR6+fSj
	+ehqVh1M3yTsfjPkUNyAgfcfYd38ahuhnrt5VhVfAjbB44YuUWYdZTilHBj0dqgLq7OW/WzU6YZ
	97h2s80nWYRhXI0NL5Qi7xb4/Q0j2AYDkeIT8x0byySR5aig7B24kuDOOSkhwGvWvuAlodvUSeT
	/IWSWKqxW556ft0JgdrbkNVanlNStashgJ1K6mns0GGJF/QoQn8fdKvZ0By96VVWKhlBh/+pbBf
	i/UHmEy31Q/OZ
X-Google-Smtp-Source: AGHT+IHp5NQdTmn+sV13Wl1weanLiWprdfWQJUqWDn7lpqWZHcoy3u0k7JNp8noj20eh6Kz4NPCsmA==
X-Received: by 2002:a17:902:d543:b0:231:b7e1:c977 with SMTP id d9443c01a7336-231de3763abmr66649725ad.29.1747440272773;
        Fri, 16 May 2025 17:04:32 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4e97f9bsm19761285ad.156.2025.05.16.17.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 17:04:32 -0700 (PDT)
From: Stanislav Fomichev <stfomichev@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	sagi@grimberg.me,
	stfomichev@gmail.com,
	asml.silence@gmail.com,
	almasrymina@google.com,
	kaiyuanz@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: devmem: remove min_t(iter_iov_len) in sendmsg
Date: Fri, 16 May 2025 17:04:31 -0700
Message-ID: <20250517000431.558180-1-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iter_iov_len looks broken for UBUF. When iov_iter_advance is called
for UBUF, it increments iov_offset and also decrements the count.
This makes the iterator only go over half of the range (unless I'm
missing something). Remove iter_iov_len clamping. net_devmem_get_niov_at
already does PAGE_SIZE alignment and min_t(length) makes sure that
the last chunk (potentially smaller than PAGE_SIZE) is accounted
correctly.

Fixes: bd61848900bf ("net: devmem: Implement TX path")
Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
 net/core/datagram.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index e04908276a32..48fcfc1dcf47 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -712,7 +712,6 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
 			return -EFAULT;
 
 		size = min_t(size_t, size, length);
-		size = min_t(size_t, size, iter_iov_len(from));
 
 		get_netmem(net_iov_to_netmem(niov));
 		skb_add_rx_frag_netmem(skb, i, net_iov_to_netmem(niov), off,
-- 
2.49.0


