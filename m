Return-Path: <netdev+bounces-245734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 500F3CD66D0
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 15:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CF5C30090BC
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 14:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194C32E54BB;
	Mon, 22 Dec 2025 14:52:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C2E221721
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766415150; cv=none; b=i0z0SHruQDwqrY0z/WINsLOXpOLNorlk6EGtcUT+Wn12qXoOlcv6m/YBzivX/K6gUpZBGi7gYt++LDqAyUBGIp0Ho4ZYVfpz3vKdOHh53v8OYi+CtMF7RFT3dRA01wqHSKCCXRTHacCrwjL9qOXrZg9TUbw9gkINtO/40C6Ach4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766415150; c=relaxed/simple;
	bh=Lpyn9tsJg0zwSeavaT29XnRv2mvoX0IosORFt8lYkTA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lmIQhAV1UEX65MchXigEDhXvttRSDWD793J0/y29FfCJLF8IGNPA1BLfAVlBd43+irX0vYnqvsXW52gcJML6S11qVrX5N66D618zp9RaXT9Zhi+ShrvqkL8yiG8EzDuaJd/w2qPgyAvePfL8KeVosEeZGIKd1xSSEbozRNbkUAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c6dbdaced8so3179935a34.1
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 06:52:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766415147; x=1767019947;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSmO9rSpf1HE0AkJMJvsQtYeDJHt5UKP07FlrQBAlfE=;
        b=oqEynJV0+XCIOF5kC8vIn4IfOgah6SoTYRJqYt+Nd6LVxGBljpnAbQiBsD6J4fPnu8
         fVmupiLZga3vm5DeXQAwcamoJmjn4EgrRsOW2RmGnnSGFLs6nbBkEvEf0vY9DqSJx/L2
         Qq3C/9Waqk8HNeZpS2Ds8jiA4RUCt7mVogc9mwaYsgtBBMgyBEivqwhjaZl3Jnlvi7c2
         VvvZZgkVCrchsYk/aj2ZMAzXrAI8/DR0bOfzREOybEZzPGgJbgkryyGuuwlUBTY31QKk
         ejrmdLXwLmX4a6bPqNPAm538NNrc3YQHpunu+6lEzgzwilMMW504FpTlXPOpAg6RYPR/
         EEyg==
X-Gm-Message-State: AOJu0YyoZJgZPOMBOJRXIA83nerIuCku++hxN+ecoFem2e1UpR1Qh3th
	YXU/9Vm8b5TeZQVhY984yHj3/xXzfERgeMbcWWNAvpOU+r1FPQnkEh3ECWH+lw==
X-Gm-Gg: AY/fxX6aqOFTEbe5chA4x5yJ8c9BstVKS5bvgucn65mtfR0aksxggsZJTcq6qscv3Za
	VG7BCLqmrnyAv7qQ6M/GJVwBbHKqae5CHYiIoDtdY5DDRg4JjC/0fQZWGIJnavYJ8/Gne+86sri
	ePEt2cLmLsnAq+D7uWAW5TJnLVtMxFgDYPxHfUgWXEphcekgdktUfstKRclI/QvAm6IvRAMrrQ+
	57sboCBqc8BdMA7AQB7ITHgdfD5kYy407kftAJ3j43EZZvFgEgcmWILKG1eezZMknPB9kEQCSWQ
	Nl/7l1CdxMYSvSi1xpddbn/iom/CnIYfBD1LKDx6D70QmX0v7vz2rh19bpFNShUFENYnNgmp8u7
	5qPX6pN8xf7EMGXV5BbLQMbYPRpkfwOYee8whIFcvtMrIWrqn9aTMddYO9ZXJANffyjTc7z2DxR
	/CltOib77xBs91
X-Google-Smtp-Source: AGHT+IGAwhuUsx7Fd/+/3NrcQAUltcFLRbhiXbvn1mIlfuHyEFiPeZMxXjTgjycIu24XHR+wcgJmRA==
X-Received: by 2002:a05:6830:82ca:b0:7cc:4d72:586f with SMTP id 46e09a7af769-7cc66a9564dmr6576897a34.31.1766415147262;
        Mon, 22 Dec 2025 06:52:27 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:2::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667281fesm7465677a34.6.2025.12.22.06.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 06:52:26 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/2] net: netconsole: convert to NBCON console
 infrastructure
Date: Mon, 22 Dec 2025 06:52:09 -0800
Message-Id: <20251222-nbcon-v1-0-65b43c098708@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABpbSWkC/x3MQQqAIBAF0KsMf52QVkheJVqUjTWbKTQiiO4e9
 A7wHhTOwgWBHmS+pMiuCGQrQtwmXdnIgkBwteustd7oHHc1ybWt93HqU8OoCEfmJPf/DFA+jfJ
 9YnzfDzkHwJJhAAAA
X-Change-ID: 20251117-nbcon-f24477ca9f3e
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asantostc@gmail.com, efault@gmx.de, gustavold@gmail.com, calvin@wbinvd.org, 
 jv@jvosburgh.net, kernel-team@meta.com, Petr Mladek <pmladek@suse.com>, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1994; i=leitao@debian.org;
 h=from:subject:message-id; bh=Lpyn9tsJg0zwSeavaT29XnRv2mvoX0IosORFt8lYkTA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpSVspfbVqnsPu5Bv/eEfAvgPigf9yjHuN+XdBW
 KFG0jk6BISJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaUlbKQAKCRA1o5Of/Hh3
 bdKcEACKJ6DK6qsLWkMiEWLXkcxGcNJb20WewGochuocoGF9IsFwzjENEDck74TDOnTRc42Cyhh
 qpfCL6xAB8HgzotaHmzfX990TOq3pDl1Fq0hxvWCREKti5OfepCr9QoY+bW3MGvmlusT+Iifcyq
 L/8pOtX1fWmmLMG64k0n8HK7GER37HzLfxKLJwsRChOAAPSn6D/mbQYkFr3WvSK0XhSSRWM0Vji
 P2rCTw/wy6XBoKGaQBGuF2IQ7R54xbtg7Je6hkE5BFPGHhvxzTWq4PfTDVeNFeafn3Fa08kc1xZ
 HQCoxDprem7OcLfxJ/GvNayn667HnFOyyMEX2EMBLXE6uPDotVUdIfppjMyAm7GuE0DcMPpmMhQ
 cEf/mQh64GiW4j5O4kjGqFSpyRgP+wCOaIxcHcJDJd4YtHCLBL7aVqgLvoIN/BpgxCkugvTMa+O
 rYnSg28bEqcXC//bKJgdfs1I+/npjsXlnPnDirogI+50euYEpmk6e9l3Y3uywGxhgJfon4D6MDp
 z4pz3g4MZ3mR5TIhSz6Q5unbbLvautKhblISe7PyPIYIU5X4lxpYgr+B3IbSiOVPqOy/D41QPA2
 oC65NPCxHYauRsXi0V/EdlhX9Ea4dumPtsdTlIsyJrrMJDAPRWkZDGv5vPey/SgLgziqpddgyWm
 X3BX5mu1KvusANQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This series adds support for the nbcon (new buffer console) infrastructure
to netconsole, enabling lock-free, priority-based console operations that
are safer in crash scenarios.

The implementation is introduced in three steps:

1) Refactor the message fragmentation logic into a reusable helper function
2) Extend nbcon support to non-extended (basic) consoles using the same
infrastructure.

The initial discussion about it appeared a while ago in [1], in order to
solve Mike's HARDIRQ-safe -> HARDIRQ-unsafe lock order warning, and the root
cause is that some hosts were calling IRQ unsafe locks from inside console
lock.

At that time, we didn't have the CON_NBCON_ATOMIC_UNSAFE yet. John
kindly implemented CON_NBCON_ATOMIC_UNSAFE in 187de7c212e5 ("printk:
nbcon: Allow unsafe write_atomic() for panic"), and now we can
implement netconsole on top of nbcon.

Important to note that netconsole continues to call netpoll and the
network TX helpers with interrupt disable, given the TX are called with
target_list_lock.

Link:
https://lore.kernel.org/all/b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt/
[1]

Signed-off-by: Breno Leitao <leitao@debian.org>

Changes from RFC:
  * Removed the extra CONFIG for NBCON, given we don't want to support
    both console. Move to nbcon as the only console framework supported
  * Incorporated the changes from Petr.
  * Some renames to make the code more consistent.
  * Link: https://lore.kernel.org/all/20251121-nbcon-v1-0-503d17b2b4af@debian.org/

---
Breno Leitao (2):
      netconsole: extract message fragmentation into send_msg_udp()
      netconsole: convert to NBCON console infrastructure

 drivers/net/netconsole.c | 109 +++++++++++++++++++++++++++++------------------
 1 file changed, 68 insertions(+), 41 deletions(-)
---
base-commit: 7b8e9264f55a9c320f398e337d215e68cca50131
change-id: 20251117-nbcon-f24477ca9f3e

Best regards,
--  
Breno Leitao <leitao@debian.org>


