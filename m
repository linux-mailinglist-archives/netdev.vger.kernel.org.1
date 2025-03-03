Return-Path: <netdev+bounces-171255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26554A4C2DB
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 15:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5047D7A5F15
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 14:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C263C21322F;
	Mon,  3 Mar 2025 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cIZsQbqb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E407E1EDA32
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010912; cv=none; b=QoBXWiKDY+KD6lWWtbsMMjOYdRCppb9IANl19Q1M2k+Nzc9Gx+HXi10I3CM2mOghKEIxAmWMxPyLOyjhUxMNapVjKv1jT6HIzg30O243A6gKEdHGbiCO4N8Ya2q6Ga4Q7XaoqqXflC2vzw87FtBmTA24Ma9vmOrUWvMKPv9X+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010912; c=relaxed/simple;
	bh=ytI7C1/3ZEID73/zWyUm81QF+dDrxTFq69/STGHo3ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5/IptB/S9a8uTfJvHMYoluyWftI9qvjSAEswmU08AjLJXiqELw0KtZHOZ61ho6S1tuO7/OXPWJLQUJmwoVUnPEXW2azNHnlGg980xE6b9Gm3QBAbDhDLC8hIgZgtVE6rzITcseJ2y7SROOlf8++ck/5lluBJ64h2m3RtDuzsos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cIZsQbqb; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso7300798a12.3
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 06:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741010909; x=1741615709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lgzkQxaW5CHf86x7AWE8k6IimMEmNVMADmlp1s0496M=;
        b=cIZsQbqbHwOqHTpVNlVJmp/qUA0P6bzXkzoQ5+WQ0LSsOGBIBGnbm6iBZr7A5rOu+g
         MUjwqAz7yTm9FcVjaCrgIjWfvrNj2EWLSJwv/aGmUdb3Cxugm8dzKBYwxqrO58cOnepE
         zVnk0CwaWUm+E0JxsAgwBR6cRSny4okwyNQ0bZ1SoXEE0KhVV/EQkDd4s/EMKBSoO8vb
         TMMLGIVkD/yHQ0TGZcI5GPeG5jQc7da3FYy79FzRKTElHdqRhfiV4d1dDX1EHMVDgr2S
         cYzM72tLEEf53zbdXG2I8RfFdA3QyHMgA0KSBQeBuLL+/SogXmNOify1uAgNo9L9NwQt
         GUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741010909; x=1741615709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgzkQxaW5CHf86x7AWE8k6IimMEmNVMADmlp1s0496M=;
        b=b5gFBwiz+U5OBY6xCc2ohG3arB413apJqCGpBqjIxzeyHAl9G5IL4uJv3h3l3GT792
         WEKY0oLgeFfpeuyUBCj0r4Cdf3D/Mehw62inkhYclw+N+JlXPdeKTEaBqHK8K7P3c1ue
         PdVkNaDJycZDcqEZMeNLn79H4xVNkIDWgn68Bxi58y79a68uSi3+Bt/VDT8DGqgTxDkZ
         2Yc4RCnTx7R8uUlm2A7JFBeTghsRpFrvMmCb6Rvh13GntqkmXTGjX4qux8d+0RHmLqUB
         P/fixPf9x8mz72s57PyDQ1blLIXLEO7wNdwyNrEA3I2Aw8C9nOWb/z31eydIIhUkXNDO
         B0Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWArhyIxAXHR9Ys8O1rIi38dsS17vtauduoUvqfMGZN24ywSYV/qY2AFQ6Zj7VgLQDNjfMuPXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBrR7nV6Pnj1+YcCLC9uJNh8Hdej5dvjyIL7rylmKQhuf590Hy
	QAZdrKGag1c285CUfsE1iLW7ay7u5GS8SENUZaBNN7a0Gqe9E4w704/2FD4ZLwQsVTwjK3RbQsc
	m
X-Gm-Gg: ASbGncuEMWRqJaMXD+gi5rpZYaktppLfFWH0fNghuwW09A6+HDXFi8Cg43prQEYrNnF
	IJg454OlOR8LTp5GxJaw55ELPYZ/kMs8IC9f33KbN9c88HelS3Nf616jv6Yw+ftCjgEgke4fw/n
	Ni/YM32D2Pu3EhkPnIPlJbWUNARvLohlV4+nQ53cIWdkAk6S+Hv0RH5oWUGK73EAcOOLE+LRTqZ
	SJ2Kz0QOlvOwj1u30PX4vjzXnBgOtx9gSCIrpX+KxxRvfGCqNb4sKiDYMzdwroUR8SoUDEuYp/z
	DtBn/RkXJtSZzpRZIscLpei8jzwiVLq5e/q7hDiAY3vK7qlZKQ==
X-Google-Smtp-Source: AGHT+IHJ5i4TB4355RRCPxNtJcPV4cOTfWRTwaLU4Fbde0vdGgTcEizoadd+Cioo6PFzj9W+C1LyBQ==
X-Received: by 2002:a17:906:1199:b0:abf:287d:ccdb with SMTP id a640c23a62f3a-abf287dce9emr1376223066b.27.1741010909214;
        Mon, 03 Mar 2025 06:08:29 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac1db69942bsm112475066b.76.2025.03.03.06.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 06:08:28 -0800 (PST)
Date: Mon, 3 Mar 2025 17:08:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Malladi, Meghana" <m-malladi@ti.com>
Cc: rogerq@kernel.org, danishanwar@ti.com, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, u.kleine-koenig@baylibre.com,
	matthias.schiffer@ew.tq-group.com, schnelle@linux.ibm.com,
	diogo.ivo@siemens.com, glaroque@baylibre.com, macro@orcam.me.uk,
	john.fastabend@gmail.com, hawk@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [EXTERNAL] Re: [PATCH net-next v3 3/3] net: ti: icssg-prueth:
 Add XDP support
Message-ID: <61117a07-35b5-48c0-93d9-f97db8e15503@stanley.mountain>
References: <20250224110102.1528552-1-m-malladi@ti.com>
 <20250224110102.1528552-4-m-malladi@ti.com>
 <d362a527-88cf-4cd5-a22f-7eeb938d4469@stanley.mountain>
 <21f21dfb-264b-4e01-9cb3-8d0133b5b31b@ti.com>
 <2c0c1a4f-95d4-40c9-9ede-6f92b173f05d@stanley.mountain>
 <40ce8ed3-b36c-4d5f-b75a-7e0409beb713@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ce8ed3-b36c-4d5f-b75a-7e0409beb713@ti.com>

What I mean is just compile the .o file with and without the unlikely().

$ md5sum drivers/net/ethernet/ti/icssg/icssg_common.o*
2de875935222b9ecd8483e61848c4fc9  drivers/net/ethernet/ti/icssg/icssg_common.o.annotation
2de875935222b9ecd8483e61848c4fc9  drivers/net/ethernet/ti/icssg/icssg_common.o.no_anotation

Generally the rule is that you should leave likely/unlikely() annotations
out unless it's going to make a difference on a benchmark.  I'm not going
to jump down people's throat about this, and if you want to leave it,
it's fine.  But it just struct me as weird so that's why I commented on
it.

regards,
dan carpenter

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 34d16e00c2ec..3db5bae44e61 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -672,7 +672,7 @@ static int emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp,
 	case XDP_TX:
 		/* Send packet to TX ring for immediate transmission */
 		xdpf = xdp_convert_buff_to_frame(xdp);
-		if (unlikely(!xdpf))
+		if (!xdpf)
 			goto drop;
 
 		q_idx = smp_processor_id() % emac->tx_ch_num;

