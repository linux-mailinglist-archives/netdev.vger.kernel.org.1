Return-Path: <netdev+bounces-86264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C89A89E487
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 22:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586151C20AF1
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 20:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882E4158843;
	Tue,  9 Apr 2024 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="fyVqPujZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94A9158208
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695059; cv=none; b=siY/jpVCdGIBsN6H73tlTdJgumuBqkrljPbsyBkMcITk17K8Coc0QE4kHE3laVRHPpE24Ca3YxNEiv93U8IO6KlGoyGXATc+Cinpa9IOMvXbgZoB5Y/AujzGS5r7Q2owhR3faSHtLpffkYsofzB92pWKtuxg2wcJ9Z53CVUPgFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695059; c=relaxed/simple;
	bh=VH/rkRGbjKCb8bI/QG9WFAfAoZWAp1waBrqAINf/N0E=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=mO2cenYcJjypsO/r+4Z+htYf+8p0nVVQjIzjXfwV5YQ99qjBJlRlaqkSt/pMClll7T+vFejmtHMFGMauBlny1gv0dJrHMMdp/1gaVL73Y/8G9njkqh8kzGfBTa2d4M4h4/qZ5hfPUQXyirsXkqYpUvhokUZH6PwQ8HD6+5yGLz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=fyVqPujZ; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AC3563F19A
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 20:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712695049;
	bh=FJ+LLx8CSnlBFJsbwcLgX16D3qBsKNB3qgSrREluDYQ=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=fyVqPujZYdRCLARF7TPvEqq2XGqmtwBnDHgtvmYrppOcAmXhlhzIMifZq/ZZL1+Uo
	 7LcfzTBSFyxyQsyKljNaGgiZ4FAB+R50yM5d1DBu1/9cnnpAanYH3TssZiBXOYYFcA
	 rO3YTktmK/D7GOmWljGJKoXtiEwdGbn2WuhjUKkNDFR/YBTPDGI9gPOAAiFNM114ba
	 D8VdEkeHjVsJEI12HSYzfuYTtWQzlNIsOwI9UaveiqEkrUVkewrEoFYWk3tXBRlYnU
	 IyBdKL0w6D9+nHcA27cBAKn7XWw+OXODVf5Mgr7m3I8WC56g9Q9iRe2Cc/NFSaKcFb
	 mJOlqBnYojVug==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5f034b4db5bso3231073a12.0
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 13:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712695046; x=1713299846;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJ+LLx8CSnlBFJsbwcLgX16D3qBsKNB3qgSrREluDYQ=;
        b=wXw7oltmkii5KSD3c6f/MFZgmz1SE2J8Vki7SAPfuJk0o3N5dSXvOGo0CiwOEcqDn1
         pWfacj5uu2XudVG9xhnHXS/qdLO88RfJ2oLuNV93OVGyvFIcBHha+M2wSzvEGJD8q4Jp
         Z7Fd4pRkG0GWhUGuxkVekmP0uKjhKTKw7SJSJV+ah0ghkyF0wSiHummYiWqaSNAzcZy0
         vPAQFkqmXv9D0SHZ5brY1EIKE+Ha6cdVcXmvi3mqT0+0UE4UXWWm8Z4sHJcEGJgR3FMA
         yJWr5bS+QFbME5chC2Zwwe8k+NjClHmmsPirLQPZbFY0e3WsCUCCYvnltxre0Lt/O+Rd
         lrog==
X-Forwarded-Encrypted: i=1; AJvYcCW7WKlZvPX08ydOYKXRVEkCtUpXUKYm1b1/iCtgWGVSgOuJyFLBw6OtDQlaiGZ2iBzgfMQE/RTdl6qa5sCGGJhm9hYnopT7
X-Gm-Message-State: AOJu0YzdWEI2SRf6pLL8CPUeGFWINYwQyreeDXpxvB4mL7Elh+WgK3SB
	w/hPazb7fxrNczxA8alxBaOD6z+NzXCcu2F8rnuZKtU4K+xqsQAwHShzNNjysS+hXDoj7osZHgN
	5Ze3I60e/Fm2hUZUWCN7YvtrDRrXmGdlO7Qy4ChfOI4n63NdjM9Pnhq5ZALJGhZkFx0aQFQ==
X-Received: by 2002:a05:6a20:9146:b0:1a7:75ee:6062 with SMTP id x6-20020a056a20914600b001a775ee6062mr938780pzc.54.1712695045958;
        Tue, 09 Apr 2024 13:37:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNoCz9hfz4na6MhuZVsFVRDMYkLJ0k1V3k5y4Fd7tRFhFd5v+S3NlfOesjmcht8RxQS7EV/g==
X-Received: by 2002:a05:6a20:9146:b0:1a7:75ee:6062 with SMTP id x6-20020a056a20914600b001a775ee6062mr938755pzc.54.1712695045376;
        Tue, 09 Apr 2024 13:37:25 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902780600b001e4a1f40221sm1767391pll.84.2024.04.09.13.37.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:37:25 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id A1977604B6; Tue,  9 Apr 2024 13:37:24 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 9C2A99FA74;
	Tue,  9 Apr 2024 13:37:24 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Eric Dumazet <edumazet@google.com>
cc: "David S . Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org,
    eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 2/3] bonding: no longer use RTNL in bonding_show_slaves()
In-reply-to: <20240408190437.2214473-3-edumazet@google.com>
References: <20240408190437.2214473-1-edumazet@google.com> <20240408190437.2214473-3-edumazet@google.com>
Comments: In-reply-to Eric Dumazet <edumazet@google.com>
   message dated "Mon, 08 Apr 2024 19:04:36 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17354.1712695044.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Apr 2024 13:37:24 -0700
Message-ID: <17355.1712695044@famine>

Eric Dumazet <edumazet@google.com> wrote:

>Slave devices are already RCU protected, simply
>switch to bond_for_each_slave_rcu(),
>
>Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>


>---
> drivers/net/bonding/bond_sysfs.c | 7 +++----
> 1 file changed, 3 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_=
sysfs.c
>index 9132033f85fb0e33093e97c55f885a997c95cb4a..75ee7ca369034ef6fa58fc939=
9b566dd7044fedc 100644
>--- a/drivers/net/bonding/bond_sysfs.c
>+++ b/drivers/net/bonding/bond_sysfs.c
>@@ -170,10 +170,9 @@ static ssize_t bonding_show_slaves(struct device *d,
> 	struct slave *slave;
> 	int res =3D 0;
> =

>-	if (!rtnl_trylock())
>-		return restart_syscall();
>+	rcu_read_lock();
> =

>-	bond_for_each_slave(bond, slave, iter) {
>+	bond_for_each_slave_rcu(bond, slave, iter) {
> 		if (res > (PAGE_SIZE - IFNAMSIZ)) {
> 			/* not enough space for another interface name */
> 			if ((PAGE_SIZE - res) > 10)
>@@ -184,7 +183,7 @@ static ssize_t bonding_show_slaves(struct device *d,
> 		res +=3D sysfs_emit_at(buf, res, "%s ", slave->dev->name);
> 	}
> =

>-	rtnl_unlock();
>+	rcu_read_unlock();
> =

> 	if (res)
> 		buf[res-1] =3D '\n'; /* eat the leftover space */
>-- =

>2.44.0.478.gd926399ef9-goog
>
>

