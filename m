Return-Path: <netdev+bounces-144836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BDA9C8839
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA6E281E92
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA91C1F6669;
	Thu, 14 Nov 2024 11:00:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B5B189BA0;
	Thu, 14 Nov 2024 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582034; cv=none; b=WgA/8bpucaVO00C08lEbgGl+jK3uxDnT/CKiPvYWuTnBLeZqxUGZq6alnKalzDs/5ysbRgyAcyWKNYb2bYKDHf0sC1ZBNaQRN4iNqN+DJk+ZHP7tpNUYXS9IYaIFcF1Rb4GSzjmBY3xHPgpXZmIloxUBhgty09Tq4ZGinS2hPy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582034; c=relaxed/simple;
	bh=nhiEH++9YqtgRQGDWwbbnJSwW1n5xgeDTAhsL0C/bMs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ksavdR1bSjytu/12q0ohn6c9UBQgQwXVapwIceKyE1OUkRW84krrJ1mrQp8uc7Nn8RKqMhRUvfXmkm3AYga1uQjItk34z1j3Ue1P+g7OUjyeicSrtsU7thdaCEt2MoEeBbBReV2/I1cSE5PMB2eIpNcF6Th+UTHb4inZ4MwDKEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cb15b84544so622915a12.2;
        Thu, 14 Nov 2024 03:00:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731582031; x=1732186831;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9lhlFkVJlpvLytZrOW7m+ag+BFJM4ajh/LknOPhz2c=;
        b=tFn+HHKUwoPavhfyj2hNGwN1YXzCMMpYeOsZKbRBAN95YzM8ssWFGnurSoCvQDaI8a
         sKdNTlz7F1V8n6O5Mf8VTuFPCVnvJzQZ9Wu/UGOKB6OJI9m2mAjjuLMmMPPyD293m7pK
         LPoa3erKDWDU1Vy8sk8190SQqO0TSERz+hT614SbbGHJJuBLrrrxYg8om5wI3pV7GK++
         XjXX9BZAgzEMw5g1o0joPpve14zFtaIt549+i9aJqGbZUVVOU5uYrf7NPKWntfccX1Pg
         7LkF+iewTcQ7iViEz48h64A4dyIvZr51xfLbIxNsTWBzZ9a4jfFd4CsyDp/1swRIB9N0
         g0HA==
X-Forwarded-Encrypted: i=1; AJvYcCX9meQQthvoP5VCBheucEnsFNvgjfg/8E01g4gz/263ZqjJTOBum586CWlD1k6W1mvbfa9n0lgH0NM/0BU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWIxPcpUVwhyO43MiL2MduoWr6859MolF8XNTEjbV9wvm01EoQ
	KF60mpAfoLoStMrvIWyWlVpG3XVm/2t5b2oJlIQN2fLWKtUh7zNp
X-Google-Smtp-Source: AGHT+IGxxioJRu5lTD/quXPq+r+SeaSbFRLHFufRwUkpIovn/dQuHFmqyYOGS9RBiQjI+uuKr41uFA==
X-Received: by 2002:a05:6402:3485:b0:5cb:6729:feaf with SMTP id 4fb4d7f45d1cf-5cf77eab525mr1633966a12.16.1731582030761;
        Thu, 14 Nov 2024 03:00:30 -0800 (PST)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79bb5644sm449131a12.47.2024.11.14.03.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 03:00:30 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v3 0/2] net: netpoll: Improve SKB pool management
Date: Thu, 14 Nov 2024 03:00:10 -0800
Message-Id: <20241114-skb_buffers_v2-v3-0-9be9f52a8b69@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADrYNWcC/3XNQQqDMBBA0auEWZsSR0nFVe9RRBIz0aEQS5IGi
 +TuBfddf3j/hESRKcEoTohUOPEeYBRdI2DZTFhJsoNRACrs21bdZXrZ2X68p5jmgtJ3pFG3SpE
 z0Ah4R/J8XOATAmUZ6MgwNQI2TnmP3+tU8Or/0IJSSRyGRaPuren9w5FlE257XGGqtf4AX1f2a
 bcAAAA=
X-Change-ID: 20241107-skb_buffers_v2-f3e626100eda
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, max@kutsevol.com, davej@codemonkey.org.uk, 
 vlad.wing@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2150; i=leitao@debian.org;
 h=from:subject:message-id; bh=nhiEH++9YqtgRQGDWwbbnJSwW1n5xgeDTAhsL0C/bMs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnNdhMggWCyADm+VSjiAf5DFTJwOhwhx5QXryuR
 fRiKH2NcXmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZzXYTAAKCRA1o5Of/Hh3
 bTEqD/9s+Yh4KSsW0RmAAZZvoLvLVQ5d9giebn2A7xN7/4B+FYxnySAodA1jmswkwS1cl6NXqWp
 7ZyX/1EPY0+jUBwun8YqYg9VVfzbvjhn7sKDumGufusr00LJSHTod3Ks+jtAMLn2QnoM7m7g2EB
 sLAFnDSjriZ7Okz6c2/14PRys63cXD3X3aoFNTkhg4harUKP2H8KgYYH4pX3Dg6Ee8ioSKdk3df
 vxcFWNZ7J/vkc2IcJbGYKdseV3ZazDVqFZ+simN4XyY72aw/5Lk5oKGTzkiLnl7sQy5A58AyFvu
 /BRlFjt4R3OkN/5oQps5YiAm9gvqnktOI8beVUzo7mkUNbjXAW8xnNpfu7CrxyNdtHjx8la3mw5
 vvUUhWNPw7yhwilgtWV2ZRyV9bOpwj8IBX9GIy0jXVnAoBb14DpVOZlbKtH9EuDOW04yiPteIOm
 FEj/IkYfq+JdxMjIeMOYYxvpO7ni+MRLG1Yd/NhUNjKyEVfn6keU8mA3S+9apEcaT464kdRYSVT
 PfRrxXgvYs5KxWos2wLuUpCjQRvwlkx6mSOpa5gxvkX99YqLCll7MWc3P5rdhp5fAKIywFHCyZn
 /Y+zLrCbplKH1hyVxLjqnX8YPfGioZt9ZpxEETrlgOtIVhO4UC6ExuaISRYOIlHP72DWlIZ6vzf
 IPEkek8m7UInw+Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The netpoll subsystem pre-allocates 32 SKBs in a pool for emergency use
during out-of-memory conditions. However, the current implementation has
several inefficiencies:

 * The SKB pool, once allocated, is never freed:
	 * Resources remain allocated even after netpoll users are removed
	 * Failed initialization can leave pool populated forever
 * The global pool design makes resource tracking difficult

This series addresses these issues through three patches:

Patch 1 ("net: netpoll: Individualize the skb pool"):
 - Replace global pool with per-user pools in netpoll struct

Patch 2 ("net: netpoll: flush skb pool during cleanup"):
- Properly free pool resources during netconsole cleanup

These changes improve resource management and make the code more
maintainable.  As a side benefit, the improved structure would allow
netpoll to be modularized if desired in the future.

What is coming next?

Once this patch is integrated, I am planning to have the SKBs being
refilled outside of hot (send) path, in a work thread.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changelog:
v3:
 * Use the skb_queue_purge_reason() helper instead of dropping the skb
   pool manually. (Jakub)

v2:
 * Drop the very first patch from v1 ("net: netpoll: Defer skb_pool
   population until setup success") (Jakub)
 * Move skb_queue_head_init() to the first patch, where it belongs to
   (Jakub)
 * https://lore.kernel.org/all/20241107-skb_buffers_v2-v2-0-288c6264ba4f@debian.org/

v1:
 * https://lore.kernel.org/all/20241025142025.3558051-1-leitao@debian.org/

- Link to v2: https://lore.kernel.org/r/20241107-skb_buffers_v2-v2-0-288c6264ba4f@debian.org

---
Breno Leitao (2):
      net: netpoll: Individualize the skb pool
      net: netpoll: flush skb pool during cleanup

 include/linux/netpoll.h |  1 +
 net/core/netpoll.c      | 45 ++++++++++++++++++++++++++-------------------
 2 files changed, 27 insertions(+), 19 deletions(-)
---
base-commit: a71c69f51d1119db5f7812b35f16e8ef7786b3f2
change-id: 20241107-skb_buffers_v2-f3e626100eda

Best regards,
-- 
Breno Leitao <leitao@debian.org>


