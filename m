Return-Path: <netdev+bounces-247919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C453D008B0
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 02:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 099F930021C0
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 01:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605631FF7B3;
	Thu,  8 Jan 2026 01:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxbXZZjQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D848C1DFFD
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767835287; cv=none; b=c4QM9DRDRU097QDpM8N1Vs1FGhCc21h7U7EFxv5YDe9j7YaikWPGp8tCu/jsYEfWEANyFfYiKPIOaAwnY1EtSzeikjwlBiHGs8baTXit9OwMVCgTRemkswrDLuRYRmLNJvL9XAo+GBhzeNyH2hIGno0El1lDa1YxL0h2pnZsgko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767835287; c=relaxed/simple;
	bh=Hc5lxAWdraytXL6xhbKAzae6tH0ZualtTxle2ZKCVbI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=guY2BN+EovGF9FiAQX4CTGuphQhLQA1K6nckZdADGpKSf+jnoh/Fqt964clZZM67up4oNvXNfYDNoq+w8SSoYsNOzPjamF1bl3DjsI3HDv8ETGrPWkmp5JY65QohwmzoQ12B9g2ihqPvZRUwnFpvA7nxMB1mnm/USZsdT7UY1Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxbXZZjQ; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3ed151e8fc3so1640673fac.2
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 17:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767835284; x=1768440084; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DRD3+O2+qgiefAI0+fkvKygw9ejhA6gJ6Rci/qOqPM0=;
        b=cxbXZZjQCDlF1U2qxj8pVA4eqZHaBPheGKEoJV7qhXpdEqW5H5D+OLmeTrBhE2eR4n
         qPwVmtPl5xFRf8NO4r6JNBIH24z08wCF7SvV+LoYgZegk0yvys5iB71Gnk8nBdka+yTl
         FoGFtftUNwObNWqzoDuefcVVBx2ebUBtM47z01B7nvz6KpMw89/JKiUFDfnme2+AEl/a
         BnsCPR+wISGr8u7nQvyaztaxJRYBVtG1aKqiyHWSQ3syHczUjI9d+OhpbFh/tu3d/0E1
         buN92ELdipCt7cWMW20BAtem42dsrl1eDaIh2yG3EEJrOjq4Fi3KC29kRJy/zdGlkS2W
         SNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767835284; x=1768440084;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRD3+O2+qgiefAI0+fkvKygw9ejhA6gJ6Rci/qOqPM0=;
        b=vwg5N/urbn9ZKptamBJ7SC8cxGl5PUtvEfPdFJdLmB+jm36tkh6eoGqVAMHp4wBnvq
         iF58xtej4YFg8RE7bqEQDlU/jpk7hPp4pYv+5ioxAOGP/rApVFqlgW3HjTbVVebEkayq
         BtCdCj/F1GXaq0tDvjw3HrSt+Gj0BHkEu8Ik8BwXW4umT49hhuj2whuFGPQRpi30cKlH
         Ucz4wWRZqXOknopeCsESgNDdr65tKLNICDJ3qIre0nW5P9qkJwwGVnLy2FDYAv/i3yJh
         U/5myQ9+CY6Hq6ijG3HXEg77CCdGoD1ZtxrY2Vm5WhSpA2bigFwwXOGHUi3xM9367rte
         Qq1Q==
X-Gm-Message-State: AOJu0YxifS63pvIW0qxOSUbN5WopoiWPpp6E5rVrNzMrvOi1SXctbDN0
	WnZZlNFqZgnvBH5sJAZeSeq2kgZtfjjq12Hn9B7oRV+HhcKGdXqjX/BnoU7ChCiX8vq6PEWlr7r
	jKhBoJxc/tzUc2ISfbqgE1ROcZk8NY1X09HI4TvU=
X-Gm-Gg: AY/fxX5TWOQQPtMvdvjrPEMj/yssVdpLnraMKFePAZ0nDt3CpY8JQETUzDmOQswHopk
	rlD+TLV4TNpzV3AHKwihJbqEEfDQJX0ww116ZbqvrZhep2Jo0Kdk3SlzIrjOR3aUmIrD+NUe1up
	eQkoOIRGWFR5cKJPk//+KWevCidZ4g6/Y7iU8MnbFktaMJvyIaSQ5SlzuTFw2i98olpuALyhfAs
	rz5GQPRSKNMiUYMiv9x5ju9sJwoS45U46jHxmNyESf/M8KvI1W9CFwjRK1V3UaU4vYuNifdqhlo
	t8r674UtyKG7B7qCgDjqVZaVXxtB/4nWNwjlGpKqLOkicfoH7YXTQ8DTVOOmE1iL5NLO5o0=
X-Google-Smtp-Source: AGHT+IFBWgl5rH41WA+KMYPSp8WHmxY63Qg5nleOROwXZX69yWvRyotLYbgtgmmldqTKrIyqQrPr7DzeFuh987aIgGg=
X-Received: by 2002:a05:6820:4ecf:b0:659:9a49:8f13 with SMTP id
 006d021491bc7-65f54f4cbefmr1430102eaf.36.1767835284475; Wed, 07 Jan 2026
 17:21:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yangfl <mmyangfl@gmail.com>
Date: Thu, 8 Jan 2026 09:20:48 +0800
X-Gm-Features: AQt7F2oK4cjFYk6HKh7D4QbCltp0C9p9j637E-yo36783Cb5-Q-qxGMn0iyI8e8
Message-ID: <CAAXyoMNUYaNpd0oabi2gSDZY7VGBAup041mewLBfzp4qJBHHoA@mail.gmail.com>
Subject: [bug report] possible u64_stats_sync abuse
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I've noticed many drivers use u64_stats_sync in a (possibly)
undesirable way, where the writers/readers use plain u64 operations
instead of opaque u64_stats_t. For example (not a complete list for
simplicity):

- drivers/net/ifb.c:164 : direct u64 read

do {
        start = u64_stats_fetch_begin(&txp->rx_stats.sync);
        packets = txp->rx_stats.packets;
        bytes = txp->rx_stats.bytes;
} while (u64_stats_fetch_retry(&txp->rx_stats.sync, start));

- drivers/net/macsec.c:2888 : memcpy (alignment boundary violation)

do {
        start = u64_stats_fetch_begin(&stats->syncp);
        memcpy(&tmp, &stats->stats, sizeof(tmp));
} while (u64_stats_fetch_retry(&stats->syncp, start));

- drivers/net/veth.c:234 : operations not revoked?

do {
        start = u64_stats_fetch_begin(&rq_stats->syncp);
        for (j = 0; j < VETH_TQ_STATS_LEN; j++) {
                offset = veth_tq_stats_desc[j].offset;
                data[tx_idx + j] += *(u64 *)(base + offset);
        }
} while (u64_stats_fetch_retry(&rq_stats->syncp, start));

While they may accidentally work on 32-bit architectures since
u64_stats_sync falls back to seqlock, it becomes no-op on 64-bit
architectures and compilers may send non atomic operations, although
the case is rare and one can hardly tell whether there are
inconsistencies in the statistics snapshot.

Should they be treated as bugs and fixed?

Regards

