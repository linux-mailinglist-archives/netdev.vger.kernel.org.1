Return-Path: <netdev+bounces-257552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLBZGNruhWlvIQQAu9opvQ
	(envelope-from <netdev+bounces-257552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 14:38:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CEEFE41D
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 14:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7AEE3002E2C
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 13:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D3E3783CF;
	Fri,  6 Feb 2026 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tFD1foL4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59403367F56
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770385111; cv=none; b=jMz9BlRbEnWWIhctqScxEv+5YP87mmJg7bbZ/H4uH2j3aJJ6xwTq2rdxllJy2pWkYgkX/8xNV3/c78WPLhiWGfSk8TUMQIfgvU4ozbITxWLbeTxnm+NiDrAYV3s6SH0ihzjSoXIqrC0V4CrnlpRSzn4glqyL0x/1DjrQbgt81xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770385111; c=relaxed/simple;
	bh=hsqFLfrKMouFzTSXNnXx7ePhR2BO9rhhD05fciUjj0g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aj+3FPikvdhLobqP3Za5UDWhQanRq/zfMn2s+IvMj9Agr1WXvHZ5yItEL6Qf+Gxr+mv5Yid3ubkCJWHh8WaIxBnYCWjTkzsEhwQ5KKNKw7d/26QSh+2UwG82ihLefJ3SzBWrLvTGHnztBqvfXenmIl4Dm/Ta1McQyJMr4bFwp3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tFD1foL4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4806f9e61f9so13159005e9.1
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 05:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770385110; x=1770989910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p8pssK1B+mX1mgchY1BRzpKL9soTjhoWyGFGipUXMJU=;
        b=tFD1foL4e4KWXgK3SICjGelSJY74Ls//wOyXswHAy4ONR7jQN52zC3nkbzzdUwxR8Y
         wPyyZV9aYvS8gKkTEpHDIF3KIm/XoyP87jMfs42cCmZdrOgQS5CBdCQJBLTrg4CNtQGg
         KiLgfJKmQAYYb5c7H8nZDPUAQNzW2U8GfJ7c6HR0mkzXWbwhjo5iOlSlRfRDaRUA0qTg
         1+o0jSewVA5e2On++uc+PuAFNATsEbBNAk3tr1fFH8MopHEoC3AhC2SWC9rxV7zFLQ8z
         fRew1+yFLCTRerlXuv9AEMZbveeU21GseFyM08yuy7JCHPS76ogjnTl64p/eTl0jmJXw
         OyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770385110; x=1770989910;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8pssK1B+mX1mgchY1BRzpKL9soTjhoWyGFGipUXMJU=;
        b=A7gSvI0dr4sdAIgVN6k4Cnvb6TcA11YtyQbdvz8vAmiH/TuikLBzOwJrAO/zLrxDK2
         henC9iBFMsbSLYpgvOvcdqAWcJcGvITqxKeZ460sJfsndUBOdrundH3UG6ZbLd4eNMdA
         5oKhUxFbXqTzxbPhd/QAvWWwlBRbfej+Pmqvpn3IBXBczdGFws/PknJHOEeBsEXzeErL
         rh17KOIqtbYG02oMnMWXb93ix4W8wd3IXObiSTRNpKPNm0F6lpi5yMtX9TsWzGorJFAm
         Rg584dnZgl19kdegHDEd29JlFtBRN0xRx/KeEMk5Y51MgHMmsjZzpHkIXbeZIor6v0Xb
         T4tA==
X-Forwarded-Encrypted: i=1; AJvYcCX2ADjDQYcU8MbE7qr9HbwE44TpAX6VD3r885cOKdgPbBMoAZDxlWfxwdPYEejZ/57YFDSu+R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGn2YabMY4JWodxyaEih4xJpbSO6SCpJuC1bHCJH4QpmqaDEyy
	Aer9tNgOUfQHyFwNQA9rEe3Wp7tZ7998JaVv7WPqRhNIvlxklVmAfCW8jn+seUkFtDk=
X-Gm-Gg: AZuq6aLBekMttbzo6ykZPMRt21Vv2CkeD/03XHMF7WnG1zwv4vRqk3Yd/Vq2/o5DvU8
	gIyCADrw5Ys0qDKr97VogKSJBnGIleMW0QPBKpjDI0uD8KyEAV0kZGtBwiR6lua3qsPl+U7GNCO
	gflbkCBnhuk1oxVBoDGlFPHeHlbcRI1UfIbxhT7NzegHt2gW+rkETr1ifPQAccW6mEWmgHAu0dw
	Q1Czo+nvf60siFyaFzs7Hzdih1MwJu22ahP/zLvnwU8dRqbo3M3Tot9HSztv6zTuVPK9TRdbN+z
	0P2eue+f5lxg7HkwwQ9GpfLsO7qaz7Chm9Kh0E6n3MUcsDZSOM1Ko27xR/EsAo9rN77L5/LVc4k
	Ph9zeMMHsmxXVLwUExXJZmTBlOJn6jUE45GeC6FMJWV6rbMdkKLDf9tjgvc5k2nE3E/m4QS3GGd
	pNJNvKgqoxqSnfHmk6
X-Received: by 2002:a05:600c:154b:b0:477:7925:f7fb with SMTP id 5b1f17b1804b1-483201e3e8amr36945165e9.10.1770385109505;
        Fri, 06 Feb 2026 05:38:29 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832096c438sm31229905e9.3.2026.02.06.05.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:38:29 -0800 (PST)
Date: Fri, 6 Feb 2026 16:38:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [bug report] net: ethtool: Introduce per-PHY DUMP operations
Message-ID: <aYXu0esD_wSjGTZm@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257552-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,stanley.mountain:mid,linaro.org:dkim]
X-Rspamd-Queue-Id: C4CEEFE41D
X-Rspamd-Action: no action

[ Smatch checking is paused while we raise funding.  #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Hello Maxime Chevallier,

Commit 172265b44cd3 ("net: ethtool: Introduce per-PHY DUMP
operations") from May 2, 2025 (linux-next), leads to the following
Smatch static checker warning:

	net/ethtool/netlink.c:714 ethnl_perphy_start()
	error: buffer overflow 'ethnl_default_requests' 52 <= 255 user_rl='0-255' uncapped

net/ethtool/netlink.c
    700 static int ethnl_perphy_start(struct netlink_callback *cb)
    701 {
    702         struct ethnl_perphy_dump_ctx *phy_ctx = ethnl_perphy_dump_context(cb);
    703         const struct genl_dumpit_info *info = genl_dumpit_info(cb);
    704         struct ethnl_dump_ctx *ctx = &phy_ctx->ethnl_ctx;
    705         struct ethnl_reply_data *reply_data;
    706         const struct ethnl_request_ops *ops;
    707         struct ethnl_req_info *req_info;
    708         struct genlmsghdr *ghdr;
    709         int ret;
    710 
    711         BUILD_BUG_ON(sizeof(*ctx) > sizeof(cb->ctx));
    712 
    713         ghdr = nlmsg_data(cb->nlh);
--> 714         ops = ethnl_default_requests[ghdr->cmd];

Smatch thinks nlmsg_data() is untrusted data, so it could be out of bounds.
It's a u8, but there are only 52 elements in the ethnl_default_requests[]
array.

    715         if (WARN_ONCE(!ops, "cmd %u has no ethnl_request_ops\n", ghdr->cmd))
    716                 return -EOPNOTSUPP;
    717         req_info = kzalloc(ops->req_info_size, GFP_KERNEL);
    718         if (!req_info)
    719                 return -ENOMEM;
    720         reply_data = kmalloc(ops->reply_data_size, GFP_KERNEL);
    721         if (!reply_data) {
    722                 ret = -ENOMEM;
    723                 goto free_req_info;
    724         }
    725 
    726         /* Unlike per-dev dump, don't ignore dev. The dump handler
    727          * will notice it and dump PHYs from given dev. We only keep track of
    728          * the dev's ifindex, .dumpit() will grab and release the netdev itself.
    729          */
    730         ret = ethnl_default_parse(req_info, &info->info, ops, false);
    731         if (ret < 0)
    732                 goto free_reply_data;
    733         if (req_info->dev) {
    734                 phy_ctx->ifindex = req_info->dev->ifindex;
    735                 netdev_put(req_info->dev, &req_info->dev_tracker);
    736                 req_info->dev = NULL;
    737         }
    738 
    739         ctx->ops = ops;
    740         ctx->req_info = req_info;
    741         ctx->reply_data = reply_data;
    742         ctx->pos_ifindex = 0;
    743 
    744         return 0;
    745 
    746 free_reply_data:
    747         kfree(reply_data);
    748 free_req_info:
    749         kfree(req_info);
    750 
    751         return ret;
    752 }

regards,
dan carpenter

