Return-Path: <netdev+bounces-240725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D00C78C78
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 0E77A290BC
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 11:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05803451AE;
	Fri, 21 Nov 2025 11:26:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388653328E8
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763724396; cv=none; b=LQ2tRPMckFI5TXBR/luDfjqrJdnXbiahk+4wSv0/fUZaLmZZ4CXTdGfLOI90LU2rfyBmxkxkMZFYDFtLKNleQ0TeBllYxcYy0z5LkM/JmfWckQvH1wfa/L+h1gnDpp7uyKs8AbkcoGs9EtBvLdbQuDP+5dxMVA6iq5Xj5dsyWSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763724396; c=relaxed/simple;
	bh=NRQasZSSHvC6BhsjGFyupbY2P/RnXg86zkqxxYMtw0I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CDBeDYmaet3f7Q314D61frtm79gpU7KeL9NYzf01jOgvM5o5YM0fFZqqf8ZVddq4eqN0LGmmsK4RJAN6OrpPsf5D6SHTo9BOyypGNSbKFTR7IR8zj9Rg7GgjnbSooxUriwYYOIzKpXaQbZ9c1YfK9zFI9/F1rBvC+aHBCVCPcSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c6cc366884so601531a34.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 03:26:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763724394; x=1764329194;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLBDYU0zUG/vZzpHBopkCaLTLgDprsDaw/LCnToBFOU=;
        b=qori7eDGH43yM/9jxhlBBUW3oEKohMj1NUFkYIO6sTU/Bw47tNC1UzHCMvfvoEiVbB
         T0uN/YkhysbP2keNM5ymqEx4bdqovoE8MyULOruyaGUNv3SBE0v18lAFh2kY/AdkZVOz
         tWPt2hj+SR6bVFf1D5rZCcTZrWfQBU9npa5dqRVWhomyQGyBZRYOhkKvYKYHQrlqb2bU
         4SiyWl3TpA1h2ucM/gCSXfrS2YoQIJ6H8RsZnVN29/YlfitPM6tX1OMjmPTTUngVqMpm
         si8JlwDo42N+NPWOShIK9msS0Rd5oxpQWaHhwLj1KKgKeYRb+vrSG3ltQN2NJzbBfaQM
         0NrA==
X-Forwarded-Encrypted: i=1; AJvYcCXXBrGfQwErYMaBmmYdpAgpMYn2usQ1QmhSC8T6rB2qjuglMcuxF/pmOoHGvvMCM7MxcodSc3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEYx6rKpViXoAXSa2RmX7ekC4NnKck7M/XBi5TdB8XMzYdJ7pn
	RzBtupgyYVs8wB6hIvzuG9IxfV1glqKvUksXMq0NgB2aao1QEM/w39eD
X-Gm-Gg: ASbGncutSPkm6etGqDCbtwy9Hp+BF7KR4w2qWt2XfHUMIC6mrxO7dF/IwI7HaJwP0yg
	5E77m4s4obqVgCJ7l/yhF8eIXF/YaOMIeeuL57XpPRZL4fgUcir8elfG1taVE0ileedU9TiLSiC
	q4JSVldu2Iel16iC7avgjVTqexAEAMNnlYLneECDHp420R7X6cFvgpRLv+yonu32RMTLV8MzBEz
	DbUr5NF51rfdpM26ItniEKxJd20sDCpILpKG4Fb7xmEdimHBPXVJCTc4Z3Mo179As2ayYXitYXp
	TLy+aTQEXFXAO9ifXd1V+HQF424j+tjKkbxYt/pikexZA3bkSYp2nLk61zHbPGPykbL7Yv/wUdZ
	FEajpseyJ8CeOOsh7nXmi9YSXJhZdNveq7MKPYpoq1/qZXPc8+MrN4xKTHFVsNXplwjdPAuoML5
	A3edOXjQDVtG5PzA==
X-Google-Smtp-Source: AGHT+IEz3QBbYuzLXyDWk0TbXNSW1rBLKlSkfnOd5OBRRxhiNlFDi216bqtvKtXZPTfk/ffhlAMUNA==
X-Received: by 2002:a05:6830:4408:b0:7c7:5458:75f8 with SMTP id 46e09a7af769-7c79908f31emr766970a34.29.1763724394239;
        Fri, 21 Nov 2025 03:26:34 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:56::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c78d346d84sm2077792a34.13.2025.11.21.03.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:26:33 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH RFC net-next 0/2] netconsole: NBCON Infrastructure Support
Date: Fri, 21 Nov 2025 03:26:06 -0800
Message-Id: <20251121-nbcon-v1-0-503d17b2b4af@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAE5MIGkC/x3MQQqDMBAF0KsMf23ApEow20IP4La40DixsxlLI
 iKIdxd8B3gnCmfhgkAnMu9SZFUEshUh/kZd2MiMQHC1a6213ugUVzXJNY33cezSi1ER/pmTHM/
 zRf95k/JmlI8Nw3XdyB+ynGUAAAA=
X-Change-ID: 20251117-nbcon-f24477ca9f3e
To: Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>, 
 horms@kernel.org, efault@gmx.de, john.ogness@linutronix.de, 
 pmladek@suse.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, calvin@wbinvd.org, asml.silence@gmail.com, 
 kernel-team@meta.com, gustavold@gmail.com, asantostc@gmail.com
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3409; i=leitao@debian.org;
 h=from:subject:message-id; bh=NRQasZSSHvC6BhsjGFyupbY2P/RnXg86zkqxxYMtw0I=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpIExoBdp09wJPfWyDB0EcH1XoQGSvni/MUF59v
 B0jW7RXrYGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSBMaAAKCRA1o5Of/Hh3
 bWspD/4gQtW7m8QiOHsOrnUXHKe4RVlTaAdnUlknENKmAY6iw5CfiuKfuTNLWFyDoga2Dqe0TaP
 Ul43uAOIZuIAb1xsbOo+kuXGyfayiiBQsuXTez1luvhhN+Yf24kdwLD7jzKO44T93LdwNmSrjuz
 VcPT4IhxHOWnZ2641Mx5CMZ7wFpeZc/KbeRr+pnoUzIZsBiDxMfE+dKSVnne0NYdlZnIkEBoskr
 KfiQRtKQUUjBE384vWPLth12p+Jayph2O2R7WPfCcygFTUKMMe76hZtNaSi+rOfh7jinhiHB4Z1
 nfnmeXRj16LRGZ69fn1AYhqCVN/nLzv6GztrQ/PQo4/sO2L6myu1RcLPdStx4tHeKDQxrSy8XTX
 KISyBBKZv6nz0BZp3c8oJEwfAmIPnoG4LlUp8Ng1pSR/fAmkK4QQ9J36K3OLaxwYGI9b6ggbLyv
 rkZJOZOEfFKgcHA0tkhy0MYVODnzwcr7Wr85m3G1u+eC6yFDVampnEBzmuIh//FTuW4bYSZIRTr
 7vLXHmKgjAgfxo0EY851Z4p4Ugg3UKp3OHu6XiqUZw2oW1JqvKwFSLiD7WE2JQJWfcNcWIPT2+J
 HNzZD9oFC8DD6+4I8ZkI3SczCOJ4Daeo4h9TJAwvxgnafy6WfbxDQo/OYv9HU2/blWQA9BXPyNa
 Do+7Bk/EQUiJ48A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This RFC proposes enabling netconsole on the NBCON infrastructure.

Context:
=======

Mike[1] reported a netconsole HARDIRQ-safe → HARDIRQ-unsafe lock
warning a while ago. The root cause involved IRQ-unsafe locks
being called within the console lock context. These IRQ-unsafe locks are
on some very specific network drivers TX path (ieee80211 as in Mike's
report).

A possible solution is to mark these devices as NOT supported by
netpoll (aka IFF_DISABLE_NETPOLL). Another solution is to send "most" of
the netconsole messages from non-atomic contexts (aka thread in nbcon
parlance), and only rely on atomic context when the host is crashing.

On top of that, nbcon is a much modern console implementation, which
brings others benefits to netconsole, so, this patches move netconsole
to NBCON.

Until recently, NBCON lacked support for non-atomic consoles
(CON_NBCON_ATOMIC_UNSAFE), thus, this port was not possible so far.

John recently implemented CON_NBCON_ATOMIC_UNSAFE in commit 187de7c212e5
("printk: nbcon: Allow unsafe write_atomic() for panic"), enabling
netconsole to use nbcon framework.

The patchset implements NBCON support in 2 phases:

1. Refactoring: Extract message fragmentation logic into a reusable helper
function.

2. Extended console support: Introduce CONFIG_NETCONSOLE_NBCON for consoles
implementing device lock/unlock callbacks

Backward Compatibility
======================

When CONFIG_NETCONSOLE_NBCON is disabled (the default), both extended
and basic consoles continue using the legacy console infrastructure,
ensuring full backward compatibility.

Current Limitations
===================

Netconsole continues to call netpoll and network TX helpers with interrupts
disabled. The network xmit callbacks are called with IRQ disabled
(target_list_lock is an IRQ safe spinlock)

spin_lock_irqsave(&target_list_lock, *flags)
	list_for_each_entry(nt, &target_list, list)
		netpoll_send_udp();
			__netpoll_send_skb()
				lockdep_assert_irqs_disabled()

While this patchset doesn't fully resolve the issue in [1], it removes
one layer of the problem and, moves the problem into the network domain,
which is a huge win.

Also, the commit 187de7c212e5 ("printk: nbcon: Allow unsafe
write_atomic() for panic") is still not on net-next, thus, NIPA will
fail for this RFC. Also, this patch is based on linux-next as of
20251121 instead of net-next.

Next steps
==========

1) Move the target_list_lock to RCU
2) Assess if __netpoll_send_skb() can be called with IRQ enabled
3) Mark devices that rely on IRQ unsafe  contexts with IFF_DISABLE_NETPOLL
4) Use CON_NBCON_ATOMIC_UNSAFE only if the netpoll device has
   IFF_DISABLE_NETPOLL, otherwise, unset CON_NBCON_ATOMIC_UNSAFE and be
   a more normal NBCON user.

[1] https://lore.kernel.org/all/b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt/

---
Breno Leitao (2):
      netconsole: extract message fragmentation into write_msg_target()
      netconsole: add CONFIG_NETCONSOLE_NBCON for nbcon support

 drivers/net/Kconfig      | 14 ++++++++
 drivers/net/netconsole.c | 94 ++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 98 insertions(+), 10 deletions(-)
---
base-commit: d724c6f85e80a23ed46b7ebc6e38b527c09d64f5
change-id: 20251117-nbcon-f24477ca9f3e

Best regards,
--  
Breno Leitao <leitao@debian.org>


