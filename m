Return-Path: <netdev+bounces-246112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 833E9CDF505
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 08:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3788F300353D
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 07:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBA61F4C8C;
	Sat, 27 Dec 2025 07:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqfq+0NL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEC27DA66
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 07:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766821111; cv=none; b=ITJk0iDFDw9ZIu+oLRbI9fWXUSI0bQjZyhkafqbmat22durgx1Wq16XrLvsP3xvFz/erTPcU3D2MgO2WCfYxe6d6YodE81kTiF/soqurgZILQHktF3Zr6SnoBAvk8V0qZSN/NP6c6GFq2bQl8HnywVvb5OwjdFjW32M/hrVhNhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766821111; c=relaxed/simple;
	bh=Po2Gok9eI39EyZ36Z3s2MTSaEXgDZ3I2++0gZ8L6Jig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lchFmESmCk2D6e+vngn6lh/58PPRVfeo9pkWZX9wDTuX1TXMi5MG8JotuPIS1tGf2S8K4upPqnIRiXUXDjfEzqivVyQgsE8/tG0TIjzX2SE6x0w3kT8UQMWLMT1RRqdO+c+dFLQoxLkk2IPKgRw+gE91HJxmWM/ndwaAzsLazjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqfq+0NL; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5957c929a5eso11179502e87.1
        for <netdev@vger.kernel.org>; Fri, 26 Dec 2025 23:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766821108; x=1767425908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1OnWDMu+q1WSYGBsX2lqqCjUP5tRl4Im0zQRuOx1Ins=;
        b=mqfq+0NL4epq7Kt6V2Ym5Vfv4EBs9VyNMUxv1KDZzfBFpomW/SwfkTgeOTcq5qCklP
         EDemf8ltwklPrM6cTAkgtwsQsmYF8zQscAC+vJ0Q/FMpQLn2fxbkiHrzFZJsgo7AnQf/
         twOsczwvRaA3wOTbjK1BY9rLDtdxyoOHEL4EIvxpF7R1xulzV9sq1QdWOPoZO7kt6wOn
         6IKLPDLRK5/g/3wpmfZUK6ecmz8+mTiuRqrX5dmCmXbrhpsbHNEqd62E5X9ARa/eYmqJ
         MwEhLeGmiotySpOLONuAtgpt+Ha2MiNbm/WMzMw6kUK+hPhjcWd68czAZp9NxNf94aLX
         3pZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766821108; x=1767425908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OnWDMu+q1WSYGBsX2lqqCjUP5tRl4Im0zQRuOx1Ins=;
        b=RxV6SQuXq4HXTZh61mTbvxiN/e5wLOtZymORJiri4NR/eu8s5Rpk/U8/7o3r48TTLg
         /1Vo2Lfun2qBc2JiaG/Bl6B/b+DAKPDJMwqI5j/FBBp6W+HcOfFNgJcDOQnZfP9z6WWE
         bZPH9U2ZkxcpiYpi5CgENtlaLvFdGc8sfGG38z/L2TmRYdJ1DOt9WjiULWOHy1geJGWH
         z1Dt0OIAHleXMBItno4I0opZfNzUPMBrhwtJFnRr/YOZxQFUQMXoZRFXAdocKWT9Q97D
         JQ+s0v7PbCQZUTJtwpLgcMUjzMe+9IBWsB9L7isFt4qalb7INggQ57HWcWQ2fo9T9gHh
         MAOA==
X-Forwarded-Encrypted: i=1; AJvYcCVSJkQ7Ccg0gb1Jtm66vug9GUZSknhNtKts2bSAY0hjkccZLui6M11d9X4rnVTwddRSWJgEpF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsfeV2Mzs2pNqcQMl3OZVMMdmneRrVo6uhrqLJ2plyV8GIjaf1
	GVvmL+tznANfuog1DExsPr7QSngFlAjQoDJRn4q6NJKCzhrXjTeDe1Ka
X-Gm-Gg: AY/fxX6zZaqDlg+IQkgxnmd12wozU6gGS67fU0xH50mO3UIIAdRCEDaovIqhmQE1iJ1
	No0b4QLJQHiWJ7tlxULhXHReUWJxCBQJhpLI6xyx0/ivD+UrmhBQ6yunQu75UyVqjYOL3iBZ+Zs
	sdJwWSnUGIqm65YmcF5ydcg0k+Iqa4kBnLkdov7BBBp6O+3OFmr6Y1lcCGp+FtTtMgzSkuLNvIY
	0siPjmoj02Jt0AHZxy5MwLU2SdYPQiVhd7JebmOF4gHJV0zSGnm1tjcS1VKC+sPucfYN5AOkAKw
	h5A4qwGrpSc/cltLI5K6pCFk3f1pa/ifYBrJf000OlD4mo+B8azYemsmhsqCzTZW+zL+8RTHgyE
	JB8i7LC5RaywnUBwDluxZKut3A3aHy9bfG5o9mYa+h866FT7DlA80LkBFI2dfR/Eyb6l1q5qXZG
	DbpGCx2YnBvaGsFvANoGPJiyblvSA=
X-Google-Smtp-Source: AGHT+IGkv/1g7SIEMAlMeplAMPTx8z8ZNBEoGr/hm+qZ2r1jeY+I+97394mPN5fP2r9FVLAEbjGe6w==
X-Received: by 2002:a05:6512:b8a:b0:597:dd9b:d444 with SMTP id 2adb3069b0e04-59a17d1cc84mr9246196e87.19.1766821107348;
        Fri, 26 Dec 2025 23:38:27 -0800 (PST)
Received: from localhost.localdomain ([176.33.65.121])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185dd90esm7345408e87.31.2025.12.26.23.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 23:38:26 -0800 (PST)
From: Alper Ak <alperyasinak1@gmail.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org
Cc: Alper Ak <alperyasinak1@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Breno Leitao <leitao@debian.org>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: ipv4: ipmr: Prevent information leak in ipmr_sk_ioctl()
Date: Sat, 27 Dec 2025 10:37:42 +0300
Message-ID: <20251227073743.17272-1-alperyasinak1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct sioc_vif_req has a padding hole after the vifi field due to
alignment requirements. These padding bytes were uninitialized,
potentially leaking kernel stack memory to userspace when the
struct is copied via sock_ioctl_inout().

Reported by Smatch:
    net/ipv4/ipmr.c:1575 ipmr_sk_ioctl() warn: check that 'buffer'
    doesn't leak information (struct has a hole after 'vifi')

Fixes: e1d001fa5b47 ("net: ioctl: Use kernel memory on protocol ioctl callbacks")
Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
---
 net/ipv4/ipmr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index ca9eaee4c2ef..18441fbe7ed7 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1571,6 +1571,7 @@ int ipmr_sk_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 	/* These userspace buffers will be consumed by ipmr_ioctl() */
 	case SIOCGETVIFCNT: {
 		struct sioc_vif_req buffer;
+		memset(&buffer, 0, sizeof(buffer));
 
 		return sock_ioctl_inout(sk, cmd, arg, &buffer,
 				      sizeof(buffer));
-- 
2.43.0


