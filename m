Return-Path: <netdev+bounces-66437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4E183F060
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 23:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF4EFB22D26
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 22:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F54417BA3;
	Sat, 27 Jan 2024 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="fAlpRsG9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B11A1B5B2
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 22:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706392845; cv=none; b=qe1vb3dquO5oP42Iu/ELO90iCVosoof8iO6FGNIhQEA3lWV6aq0OjwTMud7Mb+dZC4iAObohHrMZpfNAwQur23OJz6IwCv40oiy4FmL06033R8jJ0bm+AIhgyLrKOvaUgG8mNJ4WahTs/XOiEoMpzUcE3BW931u3XpJRAQiJjdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706392845; c=relaxed/simple;
	bh=JXTVBbTpG7x6c23I9DG7ogFp0evjgxw0Tb+0NyE3UzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dBLuL2X1VmiEqx5Xu090ilidLbEJzmWgQ1qUab8zxP0QPJ9pULBDhba9Y9iWtpyWguMsO76yuvlcEEDXbciQcoJWkAlMvZ/I1uNCrjddvHBAhtI2FN0pAsAa6T2OeyrQrc+/JVMzXCCnZKouGq4pFebCeN8eq6SziSgdJ1OQFMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=fAlpRsG9; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-290b1e19101so2094850a91.0
        for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 14:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1706392842; x=1706997642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tJIBkulCfrODe4p0bfVjWAj0VgBK7yFAiMuhrhx77cI=;
        b=fAlpRsG9VNqgM5fNhThNTO+mgEE2sg0s5Mq50L1xwcak7FPLGSHJf1c584y3WOizo3
         i8OQfGidYc1Zm1sSVuA9W7ocC1zFxaGkyloqdtjSlfiXSLIUBIvvzTepG0xWjErxH7FM
         gzJZREAjpkk9y6HvDj3pvcOk37WMxz45+ohjhnKt+zUsOkDQoK+/GSBB5hGR63Y6FbAH
         3hY7bBxql5prDLLVhgKfaUHF3NbFpA3P8KHfOYdpZu9ZYBf6ppP1zE43HNP8jc7nklOy
         WmMZSPqGwT+Ex/Jz6A+cJT/n832Mk4XeKExYXYnLNR67dakappuYbT0XiFOcUZmbhI1U
         jykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706392842; x=1706997642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJIBkulCfrODe4p0bfVjWAj0VgBK7yFAiMuhrhx77cI=;
        b=WP/vs9fIlLf3GzHT5Qe5nwylpteJzNUftUo47EilYPlMsSnNQA7NRZvQWLuGkXW/5W
         pWnNC30UtqaDLjNWfVdjVBoWgvMPAO19qFwo/wbFQyUOCCsxemPaJLIsOo3wmiCHWc6g
         mU58zW3LrpiuOkVz2/VrYEOoWGGvLqSMFGE7fM6ksMStqiZUaqk6KeKkc27NJ4dWnd/e
         Dekio+nYSB2v8GkWqGOvbvUdQis6wnIBJxo1cauwJrEkThVSyVXz5m/NeCqw7KXiuBun
         Hmzc4TQHp0GhTbyOOUB8jMZyzz7wrJ19xCWxwsNaWyMt/uTDPxozry3caOlExRjr/lst
         mtHg==
X-Gm-Message-State: AOJu0YwbyPmC/+OUDEbkRNioEfox3FBKO70uC+yWRT6PWc9IzQ7QA+kY
	E2VIkESonKiwxnosfD2clMsf7wiphNlkClU3u6b0kWRosubOZ/0wR6NAjXU1rOwXZ3qUm45Lm2F
	jAcs=
X-Google-Smtp-Source: AGHT+IHHPI640id9eU2uuT7mBZdxzzdUp33fZxw7t1AEgZSd4x3emb7fYV5FbUUvN3EVUm7kdecUCg==
X-Received: by 2002:a17:90a:e296:b0:28f:f73a:b48b with SMTP id d22-20020a17090ae29600b0028ff73ab48bmr3811316pjz.23.1706392842051;
        Sat, 27 Jan 2024 14:00:42 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id 80-20020a630253000000b005d6bdb93070sm2905019pgc.84.2024.01.27.14.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 14:00:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] bpf: fix warning from basename()
Date: Sat, 27 Jan 2024 14:00:32 -0800
Message-ID: <20240127220032.5347-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The function basename() expects a mutable character string,
which now causes a warning:

bpf_legacy.c: In function ‘bpf_load_common’:
bpf_legacy.c:975:38: warning: passing argument 1 of ‘__xpg_basename’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
  975 |                          basename(cfg->object), cfg->mode == EBPF_PINNED ?
      |                                   ~~~^~~~~~~~
In file included from bpf_legacy.c:21:
/usr/include/libgen.h:34:36: note: expected ‘char *’ but argument is of type ‘const char *’
   34 | extern char *__xpg_basename (char *__path) __THROW;

Fixes: f20ff2f19552 ("bpf: keep parsed program mode in struct bpf_cfg_in")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf_legacy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bpf_legacy.c b/lib/bpf_legacy.c
index 741eec8d4d63..c8da4a3e6b65 100644
--- a/lib/bpf_legacy.c
+++ b/lib/bpf_legacy.c
@@ -972,8 +972,8 @@ int bpf_load_common(struct bpf_cfg_in *cfg, const struct bpf_cfg_ops *ops,
 		ops->cbpf_cb(nl, cfg->opcodes, cfg->n_opcodes);
 	if (cfg->mode == EBPF_OBJECT || cfg->mode == EBPF_PINNED) {
 		snprintf(annotation, sizeof(annotation), "%s:[%s]",
-			 basename(cfg->object), cfg->mode == EBPF_PINNED ?
-			 "*fsobj" : cfg->section);
+			 basename(strdupa(cfg->object)),
+			 cfg->mode == EBPF_PINNED ? "*fsobj" : cfg->section);
 		ops->ebpf_cb(nl, cfg->prog_fd, annotation);
 	}
 
-- 
2.43.0


