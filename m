Return-Path: <netdev+bounces-278624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCcMNXn93mlINQAAu9opvQ
	(envelope-from <netdev+bounces-278624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 04:52:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A1F3FFDA0
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 04:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9938312B23D
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 02:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ABF32E12E;
	Wed, 15 Apr 2026 02:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUNtMEqU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5117832C94A
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 02:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776220794; cv=none; b=AnnFUXEPDOJIDk6Q6/sV34q71yYVqCiPL17AhZjvZBt4EfCkNczsBDhKx6SwJw+pSAc1V61h126D7DDwQU6MqhAiZEaiQ/2P+sgeN9ngCksy8qQPEJBc/W6heXev0nYYegcV1RlWvJNVqyFu+/V2alN4fN0zezG/yjSLNF36cV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776220794; c=relaxed/simple;
	bh=318sjCWYvNQGpSzDuO5m9LBM2Spar7kIKnblAHp1PYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eZwWIMYtQEUgCidkvEhEMr9dpSUnpWLwSV3UW7xkNXB3siAHyd4OAiJe7g8A/Q2FRGNfdldgALI/cPuB05uJpXVWj25ffN3YwtmaeJAlPbPtDen6uWrV2w5qgtZPUPrW2fNpB4LFiNisFLcbWPC4bUiVeSjqRgwfgjjMEBok4dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUNtMEqU; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7dbd08144deso5750825a34.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 19:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776220792; x=1776825592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/4pZEJvuS7ozDbMvLtLQ4Yf4fNz+jgNzCYp57Or0UAE=;
        b=UUNtMEqUMmD6Ab7d6mD9od9BdNeXUkUCo40wkdQmEYAQeqbBvZXpf/kq0Qlp6/VGrq
         yHEkvDm5dIQTfw7jGIMOfsMhJf48PMJgGTImG5DQzecuZFu2hv7aYIkZ0VgkY3UsjQSu
         w4v3bVe43uL0Q6lwq/zlcf6CcZsVCzkw03GKu2VuYg6n1v2FprM8wpPvcTIsA3FBweBm
         jNfhjAcgRh1NpSiss+riOlbIvdmaZ5yMY0+p6wEd9+qAmFRtZ/o8UNJv0G6py6OEX2kf
         sGrT4wnTrP9gAauNRn1sjP4I1ViFULYlXBz275m/yh3xQtr1TmeP2bh8YOcFf+ffjYUK
         gq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776220792; x=1776825592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4pZEJvuS7ozDbMvLtLQ4Yf4fNz+jgNzCYp57Or0UAE=;
        b=duvkwpUTfg/fy8rQU1MgFcitGX+EiqD1iqi9xqWahEw6K1LwemXByjMZWWRfM9BddZ
         QZt6+4HphYbbqQo6D00OQTOxHpqo00m+HLhoNtk343MbwQY95yySqjzv3xw2LGroUjS/
         QSR/g6eq80d5Lk1DrGCEn0VpiHcBn/OELUPY9a49fkMA21w0esai2OkdIqFfXpJur99j
         ujlHhmYX5Di6v3mPNmSlubMD+vZmrizHP9LeTIeBWEEEXqhO2TR5uqc5VhGKKYJtlciD
         OQeGhAwQYAhMwYTfnQE4OYaiXOWEVN/1OG6DvzbMDYcj1mONzhIlbJSXjBne+hy23AzA
         kIBQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1+a0fVKl7aJjhRyV+CB3A/AND94xA9Wxqc9+GvGiSommDoJo3DvliYvNMNagLFRITDaPE8I4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYbDnJvXn75mqW2w0DUDDqtRImAPmYp60Kwu9fc52rCyrd5mLe
	/x65XhtwE/ETBOEZdk9MvFYhXqXZm+Yz5k1j7Q779DRjTMQZSj8EhxMi
X-Gm-Gg: AeBDieubegyJdfC8FDK7XLMqdykAtexl66xvA5EnghhxohRJM7/5gsUBD2ufg8uiz5w
	cl+Y3zStgUHSJfZTADkOfNPMiqDj6sWfo17dSlT+IwUAn7blXmRumOGKvTF9F+nsxCEIEpD5kDi
	UcKPq9GC9+oIq9/KmN3wWYWfG0CbgLvPVwS1EC1SAvtHBDBfg205nmn1oQESq5XfuU74kAAx438
	eypOtjw6/REIxPo635/C7bWeXXJ+1o4PT7tJsbDahSo/SuNKLCxIbpIHBaoEM2GcNf2oPL3j3N2
	Sdgq7JfISFJMxXlWn9Bfd931N7jo++HvFQKG1dolqHEjDh3nuLndJHUaq9VNB1cPyW3spnCPDgi
	E1JegQbuDlR8i6W5l74D8oyiL+Kf/PzYuufmXWDJnu2D8eZoYEeMhcakSzCKwUjoJoje0OFkpXG
	SxcT7CUl1Rzr2G8zuYN5t0K8COxXW8PSxQs4vU4IlxD82ClT7KIfDXnCoe1xOdegqPC751XQ==
X-Received: by 2002:a05:6830:25c5:b0:7d9:f50f:96cf with SMTP id 46e09a7af769-7dc27c6632amr11719357a34.6.1776220792258;
        Tue, 14 Apr 2026 19:39:52 -0700 (PDT)
Received: from localhost (static-23-234-115-121.cust.tzulo.com. [23.234.115.121])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7dc76a333e8sm406838a34.8.2026.04.14.19.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 19:39:51 -0700 (PDT)
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
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v5] net: stmmac: Prevent NULL deref when RX memory exhausted
Date: Tue, 14 Apr 2026 19:39:47 -0700
Message-ID: <20260415023947.7627-1-CFSworks@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278624-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-0.978];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64A1F3FFDA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The CPU receives frames from the MAC through conventional DMA: the CPU
allocates buffers for the MAC, then the MAC fills them and returns
ownership to the CPU. For each hardware RX queue, the CPU and MAC
coordinate through a shared ring array of DMA descriptors: one
descriptor per DMA buffer. Each descriptor includes the buffer's
physical address and a status flag ("OWN") indicating which side owns
the buffer: OWN=0 for CPU, OWN=1 for MAC. The CPU is only allowed to set
the flag and the MAC is only allowed to clear it, and both must move
through the ring in sequence: thus the ring is used for both
"submissions" and "completions."

In the stmmac driver, stmmac_rx() bookmarks its position in the ring
with the `cur_rx` index. The main receive loop in that function checks
for rx_descs[cur_rx].own=0, gives the corresponding buffer to the
network stack (NULLing the pointer), and increments `cur_rx` modulo the
ring size. After the loop exits, stmmac_rx_refill(), which bookmarks its
position with `dirty_rx`, allocates fresh buffers and rearms the
descriptors (setting OWN=1). If it fails any allocation, it simply stops
early (leaving OWN=0) and will retry where it left off when next called.

This means descriptors have a three-stage lifecycle (terms my own):
- `empty` (OWN=1, buffer valid)
- `full` (OWN=0, buffer valid and populated)
- `dirty` (OWN=0, buffer NULL)

But because stmmac_rx() only checks OWN, it confuses `full`/`dirty`. In
the past (see 'Fixes:'), there was a bug where the loop could cycle
`cur_rx` all the way back to the first descriptor it dirtied, resulting
in a NULL dereference when mistaken for `full`. The aforementioned
commit resolved that *specific* failure by capping the loop's iteration
limit at `dma_rx_size - 1`, but this is only a partial fix: if the
previous stmmac_rx_refill() didn't complete, then there are leftover
`dirty` descriptors that the loop might encounter without needing to
cycle fully around. The current code therefore panics (see 'Closes:')
when stmmac_rx_refill() is memory-starved long enough for `cur_rx` to
catch up to `dirty_rx`.

Fix this by further tightening the clamp from `dma_rx_size - 1` to
`dma_rx_size - stmmac_rx_dirty() - 1`, subtracting any remnant dirty
entries and limiting the loop so that `cur_rx` cannot catch back up to
`dirty_rx`. This carries no risk of arithmetic underflow: since the
maximum possible return value of stmmac_rx_dirty() is `dma_rx_size - 1`,
the worst the clamp can do is prevent the loop from running at all.

Fixes: b6cb4541853c7 ("net: stmmac: avoid rx queue overrun")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221010
Cc: stable@vger.kernel.org
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---

Hi list,

This is a single patch broken out of [1]. The second patch in that series,
which proactively refills the RX ring buffer when memory is low, still has some
unresolved feedback: it should use a timer to avoid nuisance polling while the
system is suffering OOM.

Further discussion makes me wonder whether that second patch should even be
threshold-triggered at all, or if it should be a handler for the RBU
("Receive Buffer Unavailable") interrupt instead.

So, while that patch is back at the drawing board, I am submitting this one
(which is higher-priority as it resolves a *panic*) separately.

Regards,
Sam

[1] https://lore.kernel.org/all/20260401041929.12392-1-CFSworks@gmail.com/

---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 13d3cac056be..fc11f75f7dc0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5609,7 +5609,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 	dma_dir = page_pool_get_dma_dir(rx_q->page_pool);
 	bufsz = DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
-	limit = min(priv->dma_conf.dma_rx_size - 1, (unsigned int)limit);
+	limit = min(priv->dma_conf.dma_rx_size - stmmac_rx_dirty(priv, queue) - 1,
+		    (unsigned int)limit);
 
 	if (netif_msg_rx_status(priv)) {
 		void *rx_head;
-- 
2.52.0


