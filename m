Return-Path: <netdev+bounces-272806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKfnIj8oyGnEhQUAu9opvQ
	(envelope-from <netdev+bounces-272806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 20:13:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C3234FBB6
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 20:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 974383007AEB
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE3F33F8DA;
	Sat, 28 Mar 2026 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzRrl9sN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D413D335063
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 19:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774725177; cv=none; b=ACpaPIJ7ZTt667iy5bS4AxMVwfuYGkFZlz35BdhpmBwguk5mcB3QeRZvtAY6XW/817iuLE2Hwv6HU93qjUjGjkfMJe/0yACDWmagX2Ho3yA/CGX0LGG2fACmah6zG//yEIBjiYe4X4b9ThqXEk/aawYWevBCpYWNKyYNz0xNHc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774725177; c=relaxed/simple;
	bh=CVTnW0nIttUV6lSjVW3awxyHLij8LlWPrhXqltEDF1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CFvOc+YM8Qr5hQwN6iK/99bRieJR11UcCMO1XTdfZpr7Wyt+/p3zIOo1mTqySKVvJWmMg7V4bmH+KpT8x8b8Y6HutHvdFJM3yGm8kfu8GM0zHy4ttFUyHe/RC0eZ4dkPydBO5faEe45+DeMtIAHkiepE8UUtfAiWGEW91VHTQwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzRrl9sN; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1273349c56bso3927663c88.0
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 12:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774725175; x=1775329975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kRYmUmQ7Mq/jFHkE7dAWv8ExhZDNQBLjzCpbwIU4iH8=;
        b=AzRrl9sNLHzIUCtxpEBKr6SoYE4PGBc+nJoK3jgcpLhgHjnstgAiuRCGE/wS8aEjqe
         bpDb+gVWdW/V6aFXptGA4SszmOpgeji94rXUwHbjR/09Zo+EezVdTEPHnA88X1RAy+Mr
         Mh4rxtggnwwKAPwtbHsqlfedjkE2OVuZRNMLIyXToi4SCRlXM4XYknvim4krRsu+PYva
         xX89If6ytReXa63VrR8DLgvJ03JDoiZAs81d7/vDUpBBu9gA7BaEN/juPSF6OjddyiOf
         8RhtH8ebkPA1v2Fu1KWWZY+nNCt2lEN3TAV07WejWqjW6Ww5H8qN7sLakiQBIQksW4oy
         b6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774725175; x=1775329975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRYmUmQ7Mq/jFHkE7dAWv8ExhZDNQBLjzCpbwIU4iH8=;
        b=TNxBWYj+jS6Pzt0TmyV96PaHzRSMyn4fSU6USTdPX89XZRRp1Ly4iZSVqe2D5g/bnQ
         AJJKiQNl1V0K+N2KKV8DjYvDLpnlMqcR4mGkL46Qb9x1FAgoeuBUzO6sMHg9Qoxoi7jt
         y8bonBbLS+39oaE500fiBFe8fUyxrHhAKqNNXNuWHdOqpIbwnEeGxFyXxJJdDw5S1ILm
         yvtH49BS+GiZ86SksiNnzVusOMKlW6i7FRqCPKBAdpQRznQHZPGn+fdkIM6xqqZsv6RR
         x8bMp5y/ZdzbBxOVWATKS95GyfdUe0LIPH4A5t3q7k+qAbIVeX50OrhvTQqkcWEHpcQE
         icqA==
X-Forwarded-Encrypted: i=1; AJvYcCUjILbvn2sbv4ofkSAgZBdKGPAoN+pJlkwcfxAQTf6tdp1XuvTL81jIlco86PcAJ3DE0mgJrqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYfNN4NdBEnVVvloXxi+lFT5tYHw49xklGyLDH1pguqV0YbB1g
	TaFu0MpqFGDKM2bN0vpmAqvTYZCtXwur+xsYzD6iy6jrNab6+fP6z6w0
X-Gm-Gg: ATEYQzwEP7fRtWYbZDu08SF6BIyrNUkR9K+74ehVOoXnCvmShDSa6O52wk7yiljSsmk
	PJrVLDQfft4+JOpRNTSHkTGR448FhWXIArilTLdtBM7ix9GpLyvtJCorsOQyFGAhnf2bhFFNNoN
	H6sQlc/4qQlg5k7uOwfmYYs2IQIJpjxJreJceEiXvba3KwWxnQCb17qObCQ5P5FK0g3Quzmfhjd
	nWnwpcrhtrKMOTK0utNK1br77EOVjXhDoB8WWXxr4RzWjERw5OgXRPSVHs3itY23moMSDo9LZAU
	YXizJBBXy1cN0OXtj3NBQQ1aLWO95SuNLBalCiO52l0VZ2nVl2f2puRuxEm0foHj9v6kxFPginx
	+Lmb2eVA/DzjdBHeCHg04lwTW9HVH8rR+vGu2dJm13lElucY93X1foBEBGO+eNVMlEoAPXXf4wW
	d3zx2zBkK13EsYIZWojcUEty6h4BO/ggZ3bLUyS4oYvIyaVxnaCz6DrpHV
X-Received: by 2002:a05:7022:4582:b0:128:cea1:7e3b with SMTP id a92af1059eb24-12ab28e9980mr3867709c88.23.1774725174855;
        Sat, 28 Mar 2026 12:12:54 -0700 (PDT)
Received: from localhost (static-23-234-93-211.cust.tzulo.com. [23.234.93.211])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-12ab97cb08csm4086782c88.3.2026.03.28.12.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 12:12:54 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Serge Semin <fancer.lancer@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v3 0/2] stmmac crash/stall fixes when under memory pressure
Date: Sat, 28 Mar 2026 12:12:31 -0700
Message-ID: <20260328191233.519950-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272806-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76C3234FBB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi netdev,

This is v3 of my series containing a pair of bugfixes for the stmmac driver's
receive pipeline. These issues occur when stmmac_rx_refill() does not (fully)
succeed, which happens more frequently when free memory is low.

The first patch closes Bugzilla bug #221010 [1], where stmmac_rx() can circle
around to a still-dirty descriptor (with a NULL buffer pointer), mistake it for
a filled descriptor (due to OWN=0), and attempt to dereference the buffer.

In testing that patch, I discovered a second issue: starvation of available RX
buffers causes the NIC to stop sending interrupts; if the driver stops polling,
it will wait indefinitely for an interrupt that will never come. (Note: the
first patch makes this issue more prominent -- mostly because it lets the
system survive long enough to exhibit it -- but doesn't *cause* it.) The second
patch addresses that problem as well.

Both patches are minimal, appropriate for stable, and designated to `net`. My
focus is on small, obviously-correct, easy-to-explain changes: I'll follow up
with another patch/series (something like [2]) for `net-next` that fixes the
ring in a more robust way.

The tx and zc paths seem to have similar low-memory bugs, to be addressed in
separate series.

Regards,
Sam

[1] https://bugzilla.kernel.org/show_bug.cgi?id=221010
[2] https://lore.kernel.org/netdev/20260316021009.262358-4-CFSworks@gmail.com/

v3:
- Rebased on latest net/main
- Changed patch 2 to require that stmmac_rx_refill() *fully* succeeds before
  exiting polling, to reduce the chance of rx drops.
- DID NOT use the CIRC_SPACE() macro as suggested by Russell: I fear that the
  perspective shift (first think of the dirty descriptors as the "work" that
  refill "consumes" -- therefore the "space" is how much stmmac_rx() may loop)
  is too counterintuitive for a stable fix, but I'll do it in v4 if reviewers
  insist.
- Updated the recipients for the series, which was invalidated in v2 due to the
  `Fixes:`
v2: https://lore.kernel.org/netdev/20260319184031.8596-1-CFSworks@gmail.com/T/
- Completely rewrote the commit message of patch 1, now assuming the reader is
  generally familiar with DMA but wholly unfamiliar with the stmmac device
  (thanks Jakub!)
- Added missing `Fixes:` to patch 2
- Moved patch 2's `int budget = limit;` decl per the reverse-xmas-tree rule
- Dropped patch 3: this was a code improvement not appropriate for stable
- Generated the series with --subject-prefix='PATCH net'
v1: https://lore.kernel.org/netdev/20260316021009.262358-1-CFSworks@gmail.com/

Sam Edwards (2):
  net: stmmac: Prevent NULL deref when RX memory exhausted
  net: stmmac: Prevent indefinite RX stall on buffer exhaustion

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.52.0


