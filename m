Return-Path: <netdev+bounces-301316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yx46DC5UOmr46AcAu9opvQ
	(envelope-from <netdev+bounces-301316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:38:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6D66B5DE0
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:38:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mkmmkukr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301316-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301316-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BD953018285
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 09:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CA63BCD01;
	Tue, 23 Jun 2026 09:38:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81733364038
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 09:38:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207530; cv=none; b=D0nSsMKqe9ZY91TyC3/HX5eiWk7UHr+NVaiicB996/rlKBUlKfNDuotl4BA4FLn3DLKlQoOFTubbGKn0QTY3yHiZ/GFQEDGh8L3eW46IniIftqWK1XUed3NOwQUpNe8BnK5mMD9A69EsL2st6O/yRnJWOyAnITknzFwPe6Wpa5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207530; c=relaxed/simple;
	bh=p8cjTem4PmIpasalvrgbmLdyR93xEH7ZkDH1DzQI1i4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hJIybVS6tCNffyB3w7kjEJ8wFMRJZS2sq6t6wWNxU9U8RD1ovQ1Sr+orSXzrBTOZ2WqIJtwBskARu5uwN++eH2epAOLkvoydIUFYwC7Euq7QR4xX5PvJP8ypz+mmkfHMQsfpGmsm061pVp0pg0JwfC6iubRZa5zXt1OeEopAKbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkmmkukr; arc=none smtp.client-ip=209.85.208.42
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-696bf0e7c9cso1834261a12.1
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 02:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782207528; x=1782812328; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SGC4x0qSqXZMMrxbR1onNL1/9AO9MYtn1caz5Hfjgvs=;
        b=mkmmkukrIiJ6v4i/hWzA5pwCu2Qi3epeKI4ZI/y2TsR5KNSv61YsiRFvw4OCoggbXI
         h6mP8dJP18FoG78OB8fnmZSpHiuiFk4prTCm6VCAUIec+OdttTJ+wkkGCVoyanUmLD3M
         6WrSQh7F2FGS/S4R3eXpHKd4o3RlJa2/g2E3wU0f029m93GgD8VNcmFAQW9VG6wZH8oS
         Qh9KHsdv75vIST12GCQdKZVdb2A1U0ST5w3zGBnvA6sK7HTCBYuE4iWYnHNVEikKTmwR
         52L8jv5qoTIfW/f0NZK7G5x+1BmLQnmKIpR5sBsSChFAPyr/2WzjwHH+WQjgBft0dd6A
         cMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782207528; x=1782812328;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGC4x0qSqXZMMrxbR1onNL1/9AO9MYtn1caz5Hfjgvs=;
        b=BdJbFyn7t6zsNGvFMguUuDoCsWlsTOcGkdY30QW6c1FeiQsN6kWXqab+hp0H5bcBsV
         ROm+Yeedfm4athGb/iSxfoAkTHgvqZTcNbx3+G6ZCH46xC+05HqZz6HhpZQqSQieqbs7
         Eri9LvXu08YEigM9sU41qKzTBlN7vmmmhUIegHNRPsgFSgcczjMdJktrruRt8u68ikkI
         6D01iA5NT09k1E4aKl1jJL7fzP/rirIa1RMK/1QU9DeYWsLCaz2zUgoemLtDyWRY6LiA
         QZmVWp7uJ1b7WKjE3g9X7RpsVlqDh7Af1y+iXDqjiE2sRl8nM7nZtNwLiPvRrloimyl2
         Vn9w==
X-Gm-Message-State: AOJu0YyGoj+8iNPGxF6QTJM0O6cAynxzbOW/3J0tqOvjGmu4GZxROlf9
	69I2fr/yXpl6TRweSmEmQSeq/Kffp8OPQN6LI92mqHRXedTRzzQZTP98VbQO2A==
X-Gm-Gg: AfdE7ckCMrPJOhsc8oYxv5wK1tHjUNjY+c9QCigbl9Yh1Sg/G9la1p2zvYpM2pKFnb1
	5KYaVvTJtuPZAEU+/RK5qUVa0SoK7KQvXhaflHrHXJFQh+Hdj7/hiSjIkvbXSDlTlski31XL1uP
	2I3c8yLsXqj2Rs1JvkhAb0knBBa+/w+k0TIghYsncfa9tf4EqRFFlx6S/rDaYhY5WVw58sLm+G7
	Z/1+allX8HHy/fyeF1veqF3RD3g1wh2U0GFMNEaIShI6wVUx3fLZhpM+AoHIQVI9i2oHZF0ehC0
	xEOjbj8a8ZtDCwuaee04/OhnLJzXVehlvLiaqgess3fHASyRoPMrg4kc8p/Os3lwTtYsl3cAdjb
	XYk2vVBfiIiHFuERNN5/3T0lcoOCOjNK4Ju2yyghv9Zj6CWUW3yTQ9MLSYhVlxHIpPJop1gGtkX
	gIVMNLc3VsMVTMCVmFMSk=
X-Received: by 2002:aa7:d70f:0:b0:68f:9fd9:435a with SMTP id 4fb4d7f45d1cf-697d46111f2mr1053795a12.17.1782207527831;
        Tue, 23 Jun 2026 02:38:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977be4b9f6sm4215334a12.22.2026.06.23.02.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 02:38:45 -0700 (PDT)
Date: Tue, 23 Jun 2026 12:38:42 +0300
From: Dan Carpenter <error27@gmail.com>
To: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: [bug report] net: stmmac: fix dma physical address of descriptor
 when display ring
Message-ID: <ajpUIqyVSsWMY30x@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301316-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:qiangqing.zhang@nxp.com,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[error27@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stanley.mountain:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D6D66B5DE0

Hello Joakim Zhang,

Commit bfaf91ca848e ("net: stmmac: fix dma physical address of
descriptor when display ring") from Feb 25, 2021 (linux-next), leads
to the following Smatch static checker warning:

	drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c:431 dwmac4_display_ring()
	warn: duplicate check 'desc_size == 32' (previous on line 418)

drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
    399 static void dwmac4_display_ring(void *head, unsigned int size, bool rx,
    400                                 dma_addr_t dma_rx_phy, unsigned int desc_size)
    401 {
    402         dma_addr_t dma_addr;
    403         int i;
    404 
    405         pr_info("%s descriptor ring:\n", rx ? "RX" : "TX");
    406 
    407         if (desc_size == sizeof(struct dma_desc)) {
    408                 struct dma_desc *p = (struct dma_desc *)head;
    409 
    410                 for (i = 0; i < size; i++) {
    411                         dma_addr = dma_rx_phy + i * sizeof(*p);
    412                         pr_info("%03d [%pad]: 0x%x 0x%x 0x%x 0x%x\n",
    413                                 i, &dma_addr,
    414                                 le32_to_cpu(p->des0), le32_to_cpu(p->des1),
    415                                 le32_to_cpu(p->des2), le32_to_cpu(p->des3));
    416                         p++;
    417                 }
    418         } else if (desc_size == sizeof(struct dma_extended_desc)) {
    419                 struct dma_extended_desc *extp = (struct dma_extended_desc *)head;
    420 
    421                 for (i = 0; i < size; i++) {
    422                         dma_addr = dma_rx_phy + i * sizeof(*extp);
    423                         pr_info("%03d [%pad]: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
    424                                 i, &dma_addr,
    425                                 le32_to_cpu(extp->basic.des0), le32_to_cpu(extp->basic.des1),
    426                                 le32_to_cpu(extp->basic.des2), le32_to_cpu(extp->basic.des3),
    427                                 le32_to_cpu(extp->des4), le32_to_cpu(extp->des5),
    428                                 le32_to_cpu(extp->des6), le32_to_cpu(extp->des7));
    429                         extp++;
    430                 }
--> 431         } else if (desc_size == sizeof(struct dma_edesc)) {

The dma_extended_desc and dma_edesc structs are the same size but
just the basic info is at the start vs at the end.  This code is
quite old, but I think maybe we changed the Kconfig so now it's showing
up as a static checker warning?

/* Extended descriptor structure (e.g. >= databook 3.50a) */
struct dma_extended_desc {
	struct dma_desc basic;	/* Basic descriptors */
	__le32 des4;	/* Extended Status */
	__le32 des5;	/* Reserved */
	__le32 des6;	/* Tx/Rx Timestamp Low */
	__le32 des7;	/* Tx/Rx Timestamp High */
};

/* Enhanced descriptor for TBS */
struct dma_edesc {
	__le32 des4;
	__le32 des5;
	__le32 des6;
	__le32 des7;
	struct dma_desc basic;
};

    432                 struct dma_edesc *ep = dma_desc_to_edesc(head);
    433 
    434                 for (i = 0; i < size; i++) {
    435                         dma_addr = dma_rx_phy + i * sizeof(*ep);
    436                         pr_info("%03d [%pad]: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
    437                                 i, &dma_addr,
    438                                 le32_to_cpu(ep->des4), le32_to_cpu(ep->des5),
    439                                 le32_to_cpu(ep->des6), le32_to_cpu(ep->des7),
    440                                 le32_to_cpu(ep->basic.des0), le32_to_cpu(ep->basic.des1),
    441                                 le32_to_cpu(ep->basic.des2), le32_to_cpu(ep->basic.des3));
    442                         ep++;
    443                 }
    444         } else {
    445                 pr_err("unsupported descriptor!");
    446         }
    447 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter

