Return-Path: <netdev+bounces-297639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gvRVMzxPKWp8UgMAu9opvQ
	(envelope-from <netdev+bounces-297639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:49:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4285B668F3D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:49:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=snu.ac.kr header.s=google header.b=FFMjedKS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297639-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297639-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=snu.ac.kr;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A4623017BE2
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28783F888F;
	Wed, 10 Jun 2026 11:49:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E28B3E7151
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 11:49:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092154; cv=none; b=MP39ZgsUFPgi4c++NkkroNI3Pzo2yodqb7QJppI7Pq/yF/lKzqpdjhnJvDjAN/zIwL4vAOVB9fDaW/eJ/gktBienl6ZGNdwMT3QyGeRh7sBNPNuOYK707QiqSe2k9zlLu6H23eUOOlwcGe2+zHk9xggK2u/n+X1SG5ZzSI7q5oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092154; c=relaxed/simple;
	bh=IWn8pctyTR5sU7GcqdZYcFKeKcwDNXw++827iPXw99o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mxxIZCtNcUTeqH4ObkXdmfS0ANwJeT7sHo4wLYDX7C3jLY5EkMSme3Nf9IgaVTyM+hoqZFu6tVr4Tt8yNCecaa+nDjISjs6zR405hRCGHFh0rFvvxDu50mq1LopGCwbbnK3PPU6Zf4CcBbcaTFzp2WGfMQ7HUxHI4ij+zV3uP/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=FFMjedKS; arc=none smtp.client-ip=209.85.210.181
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84231305a80so3633221b3a.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 04:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1781092153; x=1781696953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yRPI0M46HrPukAt5kdLXHwvSRyzh9IdzizNsK+J9z7w=;
        b=FFMjedKShY7sMIAtMHN/34i5c1BXllDqb/H5n+h5fDQoIm0aiHTGjK1g8YGhGKHv5v
         AnA+tg1p/YQVJ0UwWchJerNh/5qvHYMAD1+nGgHcwvoCUDNWok9Ot133BD3tpI8twrmK
         sngUdWOaZDLS6rPxcwMa3C2aFmErGHUE8m50I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781092153; x=1781696953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRPI0M46HrPukAt5kdLXHwvSRyzh9IdzizNsK+J9z7w=;
        b=n9vNqOYnrZ25jOXUsiQkd6M49J1nIyAIayNWJbUGIJBgaujSUXI1iIiOZlCz5cslPD
         QUPV17hKj9C1+4n+vNxB1nIamC4kEVFkoFNqbqU8dsHNmr16lb9RzMt8lTU8cUC6iO3j
         NfImny/FrxymGMM7QXv+GhwK+BEGYKUXX8O8W3SsKsgW1RfnDkp4VYf+/URcAtBLy1/6
         rJuROWAbCLF+y3lcmFt12FfCBWFvcYmHV56lFpyiiP0isbKur+wYS+Iav+VUfMd4Okkh
         QpibacTT5RqyA12CFQRkfLEms5Vm1lX+PRgOso2OpLR4kvxzFzK8kBa9l+O3ylLksPLg
         f/6w==
X-Forwarded-Encrypted: i=1; AFNElJ9S57/7TDg+G0a2fDjiVvA7xv47mTxEDhpFfA0nxqoGZK7vxU+6wzDCMVJZdYWB7WN5tzlfsRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzarPwhygTH8m5PDzbPxq73Wm94P+Vs2qai++hd3m/PUu9gCkGY
	EtTC8R3hs+KXiVsiVrDm2uPEKoouyXj0g2LhC6Ih7gVBzeXkgzZLZDMBS/qjk+jqsLI=
X-Gm-Gg: Acq92OFmO51K1oqa1ExAcm0AS5/pk4ZZubW1bXjPEOeU8/WgpVB+Rv2hXiSjI+X1HgT
	SioQsrYPmgEU/7veaRKrXunIl4HDOcztoIEb0hNb0EX6yJZdXjkgw6rDBns0nWiEnf2PYrGLK5i
	2Ap/+ulFaeiLA70/iWofRFQghC0z0ZoWf548WMbTyxOmxs2isPJEJvZCIF/r/WmxbeBkgYSokJL
	C+DnT/INZZYvM9qYatkjWrrfT99ddRRhAdUbb2sMgwlN6jd8LcXfzvuH2O1K7TGB7vtA+DKzAw5
	6fbk7/2dxfJpI3YNQ+SOF0vb9PseZzzNvGX55lfnEsxzcf4qFKmkMKZnXPBjkejgKFtfi/nxo3R
	fjs/2ooel/08ZRlDmOqF4xTn6elVSWsvxyvzPHVwU/1Pgl9kh0sAYainGi2+TlOjqYjijxQEb5+
	3l42pJQ3R8bnfIZZ9EiR/vdSJlkn5Cu4VdiswwF/rqM4bsq5ANHMZU+pOXsOI0onk+yRI=
X-Received: by 2002:a05:6a00:4304:b0:842:2bcf:1d76 with SMTP id d2e1a72fcca58-842b0fef2a8mr25178656b3a.45.1781092152602;
        Wed, 10 Jun 2026 04:49:12 -0700 (PDT)
Received: from nunu.. (nunu.snu.ac.kr. [147.46.112.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428221c3e4sm25307632b3a.5.2026.06.10.04.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:49:12 -0700 (PDT)
From: Jaeyoung Chung <jjy600901@snu.ac.kr>
To: Jian Shen <shenjian15@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jaeyoung Chung <jjy600901@snu.ac.kr>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sangyun Kim <sangyun.kim@snu.ac.kr>,
	Kyungwook Boo <bookyungwook@gmail.com>
Subject: net: hisilicon: KASAN null-ptr-deref from uninitialized NAPI on early IRQ
Date: Wed, 10 Jun 2026 20:49:06 +0900
Message-Id: <20260610114906.741893-1-jjy600901@snu.ac.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[snu.ac.kr,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[snu.ac.kr:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[snu.ac.kr,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297639-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[jjy600901@snu.ac.kr,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:shenjian15@huawei.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jjy600901@snu.ac.kr,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sangyun.kim@snu.ac.kr,m:bookyungwook@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[snu.ac.kr:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jjy600901@snu.ac.kr,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[snu.ac.kr:dkim,snu.ac.kr:email,snu.ac.kr:mid,snu.ac.kr:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4285B668F3D

Hi,

hip04_mac_probe() in drivers/net/ethernet/hisilicon/hip04_eth.c and
hix5hd2_dev_probe() in drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
register the interrupt handler with devm_request_irq() before they
initialize priv->napi with netif_napi_add(). If an interrupt arrives
before netif_napi_add(), the handler schedules an uninitialized NAPI,
causing a kernel panic.

The probe path, in hip04_mac_probe():

    ndev = alloc_etherdev(sizeof(struct hip04_priv)); /* priv->napi zeroed */
    ...
    ret = devm_request_irq(d, irq, hip04_mac_interrupt,
                           0, pdev->name, ndev);       /* register handler */
    ...
    netif_napi_add(ndev, &priv->napi, hip04_rx_poll);  /* init priv->napi */

hix5hd2_dev_probe() has the same ordering: devm_request_irq() registers
hix5hd2_interrupt() before netif_napi_add() initializes priv->napi.

The interrupt handlers, hip04_mac_interrupt() and hix5hd2_interrupt(),
schedule priv->napi via __napi_schedule().

Because priv->napi is still zeroed, it is marked scheduled and queued
on the poll list; when NET_RX_SOFTIRQ runs, __napi_poll() calls
->poll(), which netif_napi_add() has not assigned yet.

If the device raises an interrupt after devm_request_irq() and before
netif_napi_add(), the handler schedules priv->napi while its ->poll() is
still NULL. As a result, net_rx_action() dereferences the NULL ->poll()
in softirq context, triggering a KASAN null-ptr-deref.

Suggested fix: move devm_request_irq() below netif_napi_add(), so
priv->napi is initialized before the handler can run.

Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
Reported-by: Kyungwook Boo <bookyungwook@gmail.com>

Thanks,
Jaeyoung Chung

