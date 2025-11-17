Return-Path: <netdev+bounces-239010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A7FC62241
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 03:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC7854E64CC
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 02:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9D125487C;
	Mon, 17 Nov 2025 02:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxQAUfej"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF92494F0
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 02:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763347516; cv=none; b=pDUYklSkMzhr6KSogaeGwR9erzh46UmGjDELKno4MimHx50wEWphks1BFjjpmfoKC4uUiJ27nFTM7UuqqhjVvp8MPt+WA1lePu/aAy7cqybfx+3yj6olyHGCR5D6Z++xyedt1sRZQH4KttmOm+11UZ2RPhJagog0oEtG260lkmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763347516; c=relaxed/simple;
	bh=a3mQP2Xuhuc9vMqDmv8RDKu8+IrewBRRJksEnm7FEXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyVBHZN0SuDby6NurwoxtbbEAPJAQVU7oT9WOyzyXqcNGIjJ3MTvDUc5PlzIg109fbkutjkd81XAeMVf4MJAoCjokodPd1BO6aex8i3YNMfSzKMiaCFQ0Rni+qFZuZYBOxPEld6pW82cQ0QCczBuhwCSLlZXZdKSnIHyd9XNcd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxQAUfej; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29586626fbeso39047725ad.0
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 18:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763347514; x=1763952314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zK8i+NSied8oqhXfoDi5WTsM8+Fd6zB86UHgYvVK7N0=;
        b=JxQAUfejwJvoj2bpwKGGYu/14g4gvwXwFo7nZo433irWuXgbvk53ZOoDIFziX/yfkV
         pMXJdE9bbMr3QvD2xsQPSQ/K9FSTX6Gmc4V0cEPeV8rEmTYxUH38zeZ2ODZ+k2i157Sl
         P75dMMwJ0Kzsv9FnOlQ+MM2oCB+bCXe5KrjBA8DvTXIisAH2U253wtbLMOJuXxEC20Si
         NqESywSUkFWp8jA20m3rUCwPrBct1EOFvueZmURDKMJB3dC7aDEO137c5RpjYxF7Wp88
         VO57VL/A4r9SGJXZNQUgZ3dqtppwZpsjwLQnJCac7Pih1vF4tjcfSaZRWCsngKn5rftn
         HV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763347514; x=1763952314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zK8i+NSied8oqhXfoDi5WTsM8+Fd6zB86UHgYvVK7N0=;
        b=beVoA84HcLTvD4C7J31/PgwCKi0XN8qYQ7hiEr3pIhw6l9tI6cnpGRqGinoVEA6EVa
         Q2N1rFfMfXqh0WmfVGvsvyqHl2ae1uU+B+X3syb8Do9tAedLXxTdy9pgUOQPGbANqEBh
         PLTtGA1hnAql2HWVW/nPpmRdv+Rr/V8SjPP9tiDh2h+jMyHS8K0cMJ93QnWFXI+hlUp9
         IKvjsHvyKI/sgSZZsjRvPUAJdckyNJzD0Pq1Ohji1fZFagd2vLxxPz/c2D1fJB/D8DsU
         Xdgels53WEjQSULu6nhgAi+6Hi4a4vbLGWcnhLBObtfRBy8T4iw7EELyOUZxY3r8lNK2
         Q2gQ==
X-Gm-Message-State: AOJu0YzXhAdM8KBg3AO0SJlKhHb7f9+ublTTGSjAzWgbSR9+OwuSIAx0
	i49EN1pWlqQCdaJicZrOVpMciG1CD1moVWLfu3s+tsGvDmZ/h5qb+BQLP9FEAn8/
X-Gm-Gg: ASbGncuLmpaEWqciKYAXUoKvE9zGugoW4U8jfEMYN+Uiuw7jACJda/GaKrlwCmsMGUw
	5giYoPQrp+r4tI4GoM4rVnXw6CCZFV6CTbYkwBBpAk+hQFKkDXStnt7LDyUKhP2rHC1h/B6sTqO
	bTQLxPfN5n5GX+KU/HnMQf+NSiKNhYO6gk1meLj5+ALlzpZJc5y1U3TBDMCgAAkrktW/Ud1JSuk
	3NHR6G5WQKMDmK0mUSFsZXuu5Z737PZLynZlN6+oDRWW9yiL80fiwTV3ONz97m2m15862Rw/VYO
	zonWafuu7Odawrw7pH/SYG3DKewft8Ze/QC4Rtl+/ehUJuTFsLrVGAzhMmYbmz44i8snrdXtw1B
	pdL/PJPttX79euEh7wnCgqbTsJD4Ij97FFRvmrfNuovMDJuzy1+Iqh05McIVw2+UPzdWhPEbvuR
	bFLeVN
X-Google-Smtp-Source: AGHT+IH92FRdKe39Z5u5bKivysc3J0JL3jhslXMMUw45eLdG5hD8Ndyj3T9YnfIbyHPt+bL/LeYFtA==
X-Received: by 2002:a17:903:19c3:b0:295:551b:4654 with SMTP id d9443c01a7336-2986a6ec988mr123207205ad.23.1763347514062;
        Sun, 16 Nov 2025 18:45:14 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2986e5ef32asm85041885ad.39.2025.11.16.18.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 18:45:13 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv5 net-next 1/3] tools: ynl: Add MAC address parsing support
Date: Mon, 17 Nov 2025 02:44:55 +0000
Message-ID: <20251117024457.3034-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251117024457.3034-1-liuhangbin@gmail.com>
References: <20251117024457.3034-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing support for parsing MAC addresses when display_hint is 'mac'
in the YNL library. This enables YNL CLI to accept MAC address strings
for attributes like lladdr in rt-neigh operations.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/net/ynl/pyynl/lib/ynl.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 225baad3c8f8..36d36eb7e3b8 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -985,6 +985,15 @@ class YnlFamily(SpecFamily):
                 raw = bytes.fromhex(string)
             else:
                 raw = int(string, 16)
+        elif attr_spec.display_hint == 'mac':
+            # Parse MAC address in format "00:11:22:33:44:55" or "001122334455"
+            if ':' in string:
+                mac_bytes = [int(x, 16) for x in string.split(':')]
+            else:
+                if len(string) % 2 != 0:
+                    raise Exception(f"Invalid MAC address format: {string}")
+                mac_bytes = [int(string[i:i+2], 16) for i in range(0, len(string), 2)]
+            raw = bytes(mac_bytes)
         else:
             raise Exception(f"Display hint '{attr_spec.display_hint}' not implemented"
                             f" when parsing '{attr_spec['name']}'")
-- 
2.50.1


