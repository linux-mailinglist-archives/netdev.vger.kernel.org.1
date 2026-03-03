Return-Path: <netdev+bounces-262998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBIZEmJLpmm1NgAAu9opvQ
	(envelope-from <netdev+bounces-262998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 03:45:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A09601E8288
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 03:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1732B3081BC8
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 02:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922D8267714;
	Tue,  3 Mar 2026 02:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ffauuUDS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F00918E025
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 02:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772505946; cv=none; b=i4Q4js/2g3VwIIjTkUOqcRVXn5XURpNeKci5OWDzKG2yp4dhRvjH1ZrBJXSurofVCiEn7pZwOL9A6yIHvY6yjqbccbd2b46bSnVLPsI5N2OUgzRBmRHXNLEUYWqHK6qX6D7He6CbEZmj5AHoU3W6iCdun5seu4nN7ifecwGTqTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772505946; c=relaxed/simple;
	bh=b+0Ff/pUDhFe+rGVzYVSp1+4DBYWUSZiCFvSNbPgMUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcmvkCZKCKu9/kJn+U21gRwc4FYhlSjHWVz+FHdG3jVuRUBM8RC6GC+5P9QGSL2jUaMtFkTYehz+GIj4YdPxTg/9pa3Xd5uxigkh2NQRdgRaCNWvINBla+CLmTgMvAUh0sf7W+EuncJg5m/img7l3ZKODrU2YvAbPD+8DhsYtug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ffauuUDS; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-662f9aeb782so4206106eaf.3
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 18:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772505943; x=1773110743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zopse3Rf+kKizvyvuRBVQ7DWejIScda9vW//LITHTBk=;
        b=ffauuUDSI18B5wnMPdSGdU34iEGOz3MV9NTaBrYmFZQytzq9TwRiYF3qyJy01YcGEO
         hj8xnqHi0yn44h9z0SIR38OkwrjqSWc+lzkdNVJevrxhiFCrRRqq7xKMpMc9JM6x+tiN
         J1sXlXbbBWcSejDNxFwpNVcUeTO3TpP4/pAXGgC9+33p/w5mayIYgE6QRlavGE95TcK/
         thzEIZAoiB5tASvqVyq3tz6tjGd8k4FBzcLkOK4MU8/ryhdTuuGHH2EPGMTH0UKY5HWL
         qc+R5Fily8rvV4GpMyZwOZViUViuIgmYxITCY8xZVBq56QWYx9mM0CpLgO2IgGdlB9wc
         AHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772505943; x=1773110743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zopse3Rf+kKizvyvuRBVQ7DWejIScda9vW//LITHTBk=;
        b=bsmnap9eJgKxO+rOd1FhquOwuu6xHaF0tk5Bib+tHSDRGv7KH3mI1DqHf02E0DQzBm
         MZ3YaT3Psbs+s4mN9j0/dQmOfmc0imeEx6H6w9OYwHp86SOILX4AJK1fnZsYWpIZxSUh
         du4cfVJgqA2EH2PAnEoWLOiMnOsy4KlDwwt86XpBk6ftjk+5lihllLc/KsMIAS0KLWP+
         UiAjDexe8jslcMjKdik394tXZCuImcItZkm6guspXNVrvhdL2Z3HQMIwoUFIAUlreyDx
         xcMwB0+Agay3h0B4ZUbXotJQ/Ym9NzmPq+invNyGJwDCmDz6KyBfkTUd/f9K3ZwMg8Ga
         WlNw==
X-Forwarded-Encrypted: i=1; AJvYcCUoPRIZ7S741adEF69ld/Oy1IaBKFI5EKBZbQE+fw9qPS7l5gDPMn10opUPE4q2Jxz0f9nFadU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/LpizvrsVm3of0njAazjQl++S4ZdfKzbWh2poDbi3Ym5DLj06
	Ton7ROF52Vjv3W5tl2i6jEOgP5jbM28D8bLs4vfsNughu2meMvoMekIR5j/BGm++NUk=
X-Gm-Gg: ATEYQzx09w7wQAx9+PJCH2bTmZQMftOBmR8zARXuagiZJ8XbNY5U30n/j/1I0XjI9v0
	WZ0xW8ftqRY8O5+70DG8uZEwt6OfvN2BKISmD13OD7kkwhf6mFpKV7ExeUqPgW2wY+Qvt2w4dIA
	6WmEWwvlqi2T5TvWO3Sj3SSzYpqtzhfNoKI92R8Zb39aw5I1oBx2I+36VCcXb+/+fWbByDkxKh3
	iDMaDmweE7+23DAQw0Nt9Q+smMMJEu/KlF+nviqf4YsFSN9atUTb60o64j/EqyDa+dVcBblu2mm
	y7Pqv4CEC4E27QfsIA0qgAWTuToiepgE9CTxRNmfKaStMvbIEafcC9+h7rLzG+NE76qSYyVF9p/
	NP7leUnzQhaO50Qo9ip+u2ZTmplyidR/pU60B5gLsZP2HmHkDu0ZzXZIFLEln2eHKv7hlqS2hNN
	CtCz7jbjA=
X-Received: by 2002:a05:6820:1747:b0:677:e78d:223b with SMTP id 006d021491bc7-679faefa6dfmr9051694eaf.36.1772505943148;
        Mon, 02 Mar 2026 18:45:43 -0800 (PST)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::a2:70])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d84dacsm10205642eaf.9.2026.03.02.18.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 18:45:42 -0800 (PST)
From: Chris J Arges <carges@cloudflare.com>
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	joe@dama.to,
	kuba@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v2 0/4] bnxt_en: add XDP RSS hash metadata support
Date: Mon,  2 Mar 2026 20:43:48 -0600
Message-ID: <20260303024510.644962-1-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213192449.1294830-1-carges@cloudflare.com>
References: <20260213192449.1294830-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A09601E8288
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262998-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[broadcom.com,dama.to,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:dkim,cloudflare.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,xdp.py:url]
X-Rspamd-Action: no action

This series adds XDP RSS hash metadata extraction support for the bnxt_en
driver and includes selftests to validate the functionality. I was able
to test this on a BCM57414 NIC.

The driver changes introduce a bnxt_xdp_buff wrapper that carries
hardware RX completion descriptors alongside the xdp_buff, then use it
to implement bpf_xdp_metadata_rx_hash().

The selftest changes refactor common XDP/BPF helpers into a shared
library and add a new xdp_metadata test that verifies RSS hash
extraction for TCP and UDP traffic via device-bound XDP programs.

Changes from v1:
- selftests: moved tests into net/hw
- selftests: fix pylinter errors
- selftests: add check for no error count
- bnxt_xdp: followed RCT for variable declaration
- rebased on net-next 

Chris J Arges (4):
  bnxt_en: use bnxt_xdp_buff for xdp context
  bnxt_en: Implement XDP RSS hash metadata extraction
  selftests: net: move common xdp.py functions into lib
  selftests: drv-net: xdp: Add rss_hash metadata tests

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  30 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  47 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  10 ++
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/lib/py/__init__.py         |   2 +
 .../selftests/drivers/net/hw/xdp_metadata.py  | 146 ++++++++++++++++
 .../selftests/drivers/net/lib/py/__init__.py  |   2 +
 tools/testing/selftests/drivers/net/xdp.py    |  95 +++-------
 .../testing/selftests/net/lib/py/__init__.py  |   2 +
 tools/testing/selftests/net/lib/py/bpf.py     |  68 ++++++++
 .../selftests/net/lib/xdp_metadata.bpf.c      | 163 ++++++++++++++++++
 12 files changed, 486 insertions(+), 82 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/xdp_metadata.py
 create mode 100644 tools/testing/selftests/net/lib/py/bpf.py
 create mode 100644 tools/testing/selftests/net/lib/xdp_metadata.bpf.c

-- 
2.43.0


