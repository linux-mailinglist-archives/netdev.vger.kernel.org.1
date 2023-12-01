Return-Path: <netdev+bounces-52920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F26C5800B59
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 13:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874222813C8
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 12:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A1C25552;
	Fri,  1 Dec 2023 12:59:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E119F10F8
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 04:59:30 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40b4f6006d5so19912535e9.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 04:59:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701435568; x=1702040368;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwUr5/CQCZBSDCOL97/TAIPfoZR5fdP3TK0b2v4Z5oM=;
        b=xSRpYDXQTJWX2tC0JzqU4ZJqe1tx9dY+kU1Sv4SGegQOQKTY9q8ltIVIXmtSGYIK7L
         iqXTAxPsWjYZ32Qm4PuhpXJFDYXQM22VAgLHEOIBSRO2mCyuRvAF9w0me7uroi24+6wB
         A7RvCI+2WydS5OkF40nZ6f7eqgrXQq4pJy9HdDOqHj8qrSgqLUTYqmiGdWeBL2EPorOv
         KIyLnv2SsajpsDIbzMpyw7D2/Bc01nYxww0GMMP77taFEfW3JsSodbb3ScuZtm+1qIMY
         X/HJ1VzM33H4TnyVId4S/NU2nDFoekrlWqFLTvZ0AjNJZzX9qjN4guANzGlCmF4EWJ9R
         A5ig==
X-Gm-Message-State: AOJu0YxlGGSsaxKdku/VQ6YHM7iK5dcSdes4fXn9Vl3+sROpAng+FjGG
	s3u2Pkffy0QTYBVGVDMorKMzZuNmG/V2jA==
X-Google-Smtp-Source: AGHT+IFWccntFfqQXGvyFL06OYxjBc7YsRiWanA6fpgBUyVysy6DPlwawpZw+jYTGU2cbT1qqBlLXQ==
X-Received: by 2002:a5d:4534:0:b0:333:2fd2:68f2 with SMTP id j20-20020a5d4534000000b003332fd268f2mr743314wra.133.1701435567981;
        Fri, 01 Dec 2023 04:59:27 -0800 (PST)
Received: from [10.148.82.213] ([195.228.69.10])
        by smtp.gmail.com with ESMTPSA id y8-20020a056000108800b00332fbc183ebsm4149834wrw.76.2023.12.01.04.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 04:59:27 -0800 (PST)
Message-ID: <c40ebbf9c285b87fc64d6f10d2cdc8e07d29b8c6.camel@inf.elte.hu>
Subject: BUG: igc: Unable to select 100 Mbps speed mode
From: Ferenc Fejes <fejes@inf.elte.hu>
To: netdev <netdev@vger.kernel.org>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, "anthony.l.nguyen"
 <anthony.l.nguyen@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 01 Dec 2023 13:59:26 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

I upgraded from Ubuntu 23.04 to 23.10, the default Linux version
changed from 6.2 to 6.5.

We immediately noticed that we cannot set 100 Mbps mode on i225 with
the new kernel.

E.g.:
sudo ethtool -s enp4s0 speed 100 duplex full
dmesg:
[   60.304330] igc 0000:03:00.0 enp3s0: NIC Link is Down
[   62.582764] igc 0000:03:00.0 enp3s0: NIC Link is Up 2500 Mbps Full
Duplex, Flow Control: RX/TX

I just switched back to 6.2 and with that it works correctly.

Sorry if this has already been addressed, after a quick search in the
lore I cannot find anything related.

Best,
Ferenc

