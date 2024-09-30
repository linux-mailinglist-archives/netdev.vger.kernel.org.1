Return-Path: <netdev+bounces-130593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2293F98AE35
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C751F215A2
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951D71A0B0E;
	Mon, 30 Sep 2024 20:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3QL93wm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3516B19882F;
	Mon, 30 Sep 2024 20:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727878; cv=none; b=mhfgxXQSwWMQY0B83fhift5VEpcCPKUB0K6y41EHMJwcH1gktadtmRgjS3Ettk5Y2n50+ih/oKvN6Qf2/TdBZX9j83vxJko4YbH939Ax/cvynXbS/emGiTHbiGS9atrF/A3rFxWtV9Nnzv7ScxppMenOUKQPChJZGpT3EVyJsLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727878; c=relaxed/simple;
	bh=G49HtIxCX9aHjXqMV+/wquUcSJiH2WECE52LKgio+Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hPgZFOHleMP3NgNmmeaqzpy+RuP9i3mBp+KpxCyBJ2JfgDQmzFDTRU45PVxFWtkDwyJQfUB8Wp/5JQ8PSwmo5jrSHDiK9l0gpGcNg93SAWF4KAAAlzghUpVsGz2yqkLKEFNWdl5y4VHQczKC86CgN8NtiXzBaAIA1ictPTHinfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3QL93wm; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7179069d029so3411212b3a.2;
        Mon, 30 Sep 2024 13:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727727876; x=1728332676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mxHcweaSEUn+DyYk2YnMsrv+yXezkHxwRMjb3WsQbrU=;
        b=P3QL93wmKNwvu+OSxD9hKAOZntLt1dZFEqanEqTs+nQliklgNNebAEbiY53R4oEd9+
         iE2UzlPQ3VJr0DIFdVShbT3MhGr9Phf0Zqmo/U/jrU+Gh/wKKY6zGYwHP4xbEdtMVE6/
         R8eus5mv0KWHaS8QHdLDbVVxmROpnjp/DjLMWrzr1yNOG3HLhDvSeYGPv+ZcJpIwwK9D
         bCXE7zlEbirDGk3Wc0L34GCuiHDSEr6wtMpQvOD5nk3acvQDVMjq0wqab/zkqMdTjeJt
         00E6gWUqqxVGDLDcLq72CQ2UvKmjlpgwO+9MEV2H4/WoDDSnX50zhmun8td5y+cX+fAp
         FlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727727876; x=1728332676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxHcweaSEUn+DyYk2YnMsrv+yXezkHxwRMjb3WsQbrU=;
        b=dNJomBHGDeW9MwdlymQxOEGrn+NG7TLyPqMmXw7RQzpEsNlCDm/u5WxepOdRDfWc04
         KK38UBmxl7iDm09B6E5LH6QytVvjwX/fSuekDo/rbRw2fLNyMAI9Wd9/9heTdEilvSsZ
         KHTzEy53uVUIKqPs1Eqm5z2YnO7Obeu8/jVHdNapK8M8hjfu4dc4sa5Ul/s1YxLABmvs
         IZSGhDKxY9rJh3zab9zRPSWKyBBurVDyujxA4fUwyNaOVdk2DAhBSWnZL8rVHbXr3DSh
         MtAw+TTIw8MgC/7c74L+vfODJoQWFZ2VpNZR3QRo6Mf0wxjlyKU93zgx8W7pVXypiDxa
         qwow==
X-Forwarded-Encrypted: i=1; AJvYcCVHgSZ8yi+QjRKBb6Bg8lnP05GOOl4lmbWMJ0G82scjt8E4zmjhEA35iQ3BbPZs/Qqg7ESC4Jtan5deGw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeDCmWgf1v3/OgpldvSY1ouSr/0f4B6u8mzHduZTM2Dgl7RKWX
	2jTqE6hT1GWza57cGOdSC6dl8Ye/+OXRL9/MbfQeDVbqK8G9/CsG/0DVCxtx
X-Google-Smtp-Source: AGHT+IHFaVKfeI7TUvsy2jqIOJhwTDtksbsdFH7aJNSFK3AOE5poOOFCxLQfRCmxS7tcIAjTv7nAug==
X-Received: by 2002:a05:6a00:4b0b:b0:718:dd1e:de1a with SMTP id d2e1a72fcca58-71b260a3a74mr19763854b3a.28.1727727876163;
        Mon, 30 Sep 2024 13:24:36 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b265160a5sm6670623b3a.103.2024.09.30.13.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:24:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	olek2@wp.pl,
	shannon.nelson@amd.com
Subject: [PATCH net-next 0/9] net: lantiq_etop: some cleanups
Date: Mon, 30 Sep 2024 13:24:25 -0700
Message-ID: <20240930202434.296960-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some basic cleanups to increase devm usage.

Rosen Penev (9):
  net: lantiq_etop: use netif_receive_skb_list
  net: lantiq_etop: use devm_alloc_etherdev_mqs
  net: lantiq_etop: use devm for register_netdev
  net: lantiq_etop: use devm for mdiobus
  net: lantiq_etop: move phy_disconnect to stop
  net: lantiq_etop: use devm_err_probe
  net: lantiq_etop: remove struct resource
  net: lantiq_etop: use module_platform_driver_probe
  net: lantiq_etop: no queue stop in remove

 drivers/net/ethernet/lantiq_etop.c | 141 +++++++----------------------
 1 file changed, 35 insertions(+), 106 deletions(-)

-- 
2.46.2


