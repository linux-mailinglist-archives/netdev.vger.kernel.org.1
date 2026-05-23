Return-Path: <netdev+bounces-291100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kB+NIt6aEWpSoAYAu9opvQ
	(envelope-from <netdev+bounces-291100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 14:17:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E96175BEDA3
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 14:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9AEB30156F8
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 12:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8653955E7;
	Sat, 23 May 2026 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMs0vA5N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5CE38A70C
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779538652; cv=none; b=LCg2C8Fl2NqUAJYzdy40oRPYAgzAN/RfO3pSjSV0maxJRQWd/nU73Aam/5PW7cci7NugYFZ81TX4/ks76ddTc8NlNSBbYMhW0NK06TEXRYOhZ6h9hrNh42fqsZzSvlftDjIcBO3OGl5V5gFywvRCkEzIMPWVcf607AencG6gYls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779538652; c=relaxed/simple;
	bh=nO94LD+FE0/p8uzwYNeKvCkqzlN3Qr+QvbFTGW7Sm8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMWh5syEcgLk1/cG5AXnSzkEmf3/M2/tFJFljUTs2m++Tf3TmhOUfcvzAwaiBdUcI4MHJEHqeV1f8ic0Vcbejp8YkqznAIZ9RTXmFnJv2pK47BAUHbjqv0ANYh/uQL3TFaNdWsp5FJD/kht9BLem66ZxShJhIZi3GCk7KWFaBsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMs0vA5N; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so4340632f8f.2
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 05:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779538649; x=1780143449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZctR30iAkvAMcIVBQcObBnywvkvNoGfhA6wr2BzNYfg=;
        b=FMs0vA5N7bKqlAgt7jpAdClfH5peW5M6YptjcL8cK///JTyatqJPxGIQB6ZuAaeC2X
         pfVeaABIlzHubIsz0PebXAnGSziPAOagSWWMJrwgOSKl0Z2YfXlFbao0UWbZjbIj+E2H
         XrAYEM1F68f0H1uUN7PwcbLG+rnpRh600Gt1Rtnvq3PvH+NQGe/kTaEBepUOnQ7bJgBw
         d7HB4r+KeTD8JcOqNTdoCFWhfKZy1bmyuNCH/H+mLWn83oQUNuGiE1XJfQQ/ts3okf1f
         j1unCPtg3iVhmxfayW2Ezam6o4b/hxW9H/uduZXFEkBXrAVTAbMJPTV1n6m92D+hAlbT
         1cFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779538649; x=1780143449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZctR30iAkvAMcIVBQcObBnywvkvNoGfhA6wr2BzNYfg=;
        b=jSRnVtM2lkvuldoCFIITN+Bd9fGkAZg5GqpheXuy5nqxrcD6mWDwT5RoIGNRQizrEc
         RQbOUk+hJdRZ2P77M0RuK+6xOmex6YOm9y8AmpS0PrAjoasuVmgHTBQjHvYznJlzh3Sn
         GqMgK9vQKFHYkQffo5tTGv6IscnK5p6SzAT0hfjBxq3ULPARAkyOpUfuCzotZnAxcUDm
         yxxiWi2wHTIiyQMYuV2yy3QcYTh1cMwcbcT/+LfE7UlVSDGsLDllVBN5iT182XD3uu7c
         0pwpG3QC/QzVDBRSqWhfpda2pJ+Qqk6womZOMcHwdmU/lnlvJPLV0AGvDveYqDlsDLPc
         MVbw==
X-Forwarded-Encrypted: i=1; AFNElJ8YD8HVR5G6KKRRAXIvWMZ49zoE7g41Tpdp3JaKODO98mDYJ5QRr/0YsDN4sJ4fckt2tPT2SE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTfjX4K7XNi0I1xADtlYmpXnSol/EwYjNDVjJNwr7mM909vtjV
	unSZ0KE8i3L9k4oI44xPLLhRNy5541i8Utnt7vC/dXR7OFmPUqpYjFLI
X-Gm-Gg: Acq92OHvQJ+/f66/FLH9llLeCGDgwOPe6k7ijOznMUXmTGoL4Yr+7ehqnHRPh1u0is9
	RPFFAQWpQym3I8bIWi7Xi6bCb1e/W+gse57aJkGlp/3qpQrG3iNi/TURqinTeHrdG8RrvJuGTfR
	pfTA+x9Xhh/PODYnooftjudKF+ZtF/3KzEZmpWc1RTwBkkPpHa0CV8EeH9eiAKe7l3FpckYfIeW
	SFxPuWuDFqZhCThgIsRvPh2uKsZzsyOIOacMsxAY2w4Kih4dEmITptjc263vgSVv4pXTgNuBUB+
	vOpDVElshB2wnGan4vT6lKEfG68DGlCVUMw7HZoqzFy7gVp7sSP1C/dZAaD0B0b+LG/DsUnH9N0
	+gUI83LU+uayEWOu5nNgSqvsQ0oZF2R7wjUjnVbLOUAs/IDU1v3JUs6k1emiCm1nH3CMdXhgEFh
	y+68QaVi9i5a61XpYlvLX/RKa0gCDN1u6/Dz364x7wdpjI1SZJhsnof4wFjg==
X-Received: by 2002:a05:6000:401e:b0:44a:247e:67b1 with SMTP id ffacd0b85a97d-45eb36920e5mr12402024f8f.5.1779538648925;
        Sat, 23 May 2026 05:17:28 -0700 (PDT)
Received: from INBSWN167928.ad.harman.com ([31.215.251.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5c32esm11326497f8f.26.2026.05.23.05.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 05:17:28 -0700 (PDT)
From: Abid Ali <dev.taqnialabs@gmail.com>
To: devnull+dev.taqnialabs.gmail.com@kernel.org
Cc: alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	dev.taqnialabs@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH v2] net: stmmac: fix RX DMA leak on TX alloc failure
Date: Sat, 23 May 2026 12:17:08 +0000
Message-ID: <20260523121708.564-1-dev.taqnialabs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522-stmmac-rx-desc-cleanup-v2-1-76e78eb471e1@gmail.com>
References: <20260522-stmmac-rx-desc-cleanup-v2-1-76e78eb471e1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291100-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,lists.infradead.org,vger.kernel.org,st-md-mailman.stormreply.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[devtaqnialabs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev,dev.taqnialabs.gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: E96175BEDA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> 	ret = alloc_dma_tx_desc_resources(priv, dma_conf);
>+	if (ret)
>+		free_dma_rx_desc_resources(priv, dma_conf);
>
> 	return ret;
> }

The sashiko-gemini analysis [1] flagged two issues.

1) Double-free via XDP path:

stmmac_xdp_set_prog() ignores the return of stmmac_xdp_open(), so
if alloc_dma_tx_desc_resources() fails inside that path,
rx_q->buf_pool and rx_q->dma_rx are freed for Rx queues.

The interface stays UP, so a later stmmac_release() calls
free_dma_desc_resources() on the same freed pointers.

Without this patch, the same failure path leaks RX resources
instead. Either way the root cause seems to be stmmac_xdp_set_prog() not
handling errors from stmmac_xdp_open().

The reported issue seems to be valid, but I'm not sure why XDP doesn't handle
a possible error in reinit in the first place.

2) NULL deref on partial queue alloc:

If alloc_dma_rx_desc_resources() fails for queue N,
e.g. rx_q->page_pool = page_pool_create() fails, buf_pool is NULL.
The cleanup free_dma_rx_desc_resources() iterates through all
queues and will hit a NULL pointer deref in:

static void stmmac_free_rx_buffer(struct stmmac_priv *priv,
				  struct stmmac_rx_queue *rx_q,
				  int i)
{
	struct stmmac_rx_buffer *buf = &rx_q->buf_pool[i];

The same could happen without the patch, and similar risk exists for
rx_q->buf_pool, rx_q->dma_rx, and rx_q->dma_erx which are all freed
without guards in __free_dma_rx_desc_resources().

I can add the necessary NULL guards in __free_dma_rx_desc_resources()
for V3 if necessary.

[1] https://sashiko.dev/#/patchset/20260522-stmmac-rx-desc-cleanup-v2-1-76e78eb471e1@gmail.com

- Abid

