Return-Path: <netdev+bounces-62300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C985C8267DF
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 07:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF8E1C217F2
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 06:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AB0522D;
	Mon,  8 Jan 2024 06:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKySPlLm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8B479C2
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 06:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-46705557756so306519137.1
        for <netdev@vger.kernel.org>; Sun, 07 Jan 2024 22:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704693999; x=1705298799; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KW3bfwFCtCm8Wjo8OS2j1XhfOSd6P22kpmVVTequ+uM=;
        b=aKySPlLmcONDhtF8JyLIF7IlBPrj4/nRBSQlQCbt1nDhlo8lCIVTnyAfrwt0C1gdJk
         3knWXQzmDaMZwRMNFyoU+d6MZmXEX9aoSVautIydUBaeVOGgP1lda6O111vIrZh1mm60
         LoCyi8TNPWMwvevYQkUX3eIM1HVXdNuwbw5j2RL65B6RKvfirurA8Rk2/yrFxkepM6OE
         CMvBpou2YSCol1jDOpILFioqlDnTQvvDVU46BdopsXV6S08AMrWbwOR1ScZ+skauShxT
         Ek0L8HlA9kGpuWbA+UdQOeIvBBP6CErZw60B4Q0DnekOrsfjQhpNNJIyjxhTVE5NeFHv
         oVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704693999; x=1705298799;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KW3bfwFCtCm8Wjo8OS2j1XhfOSd6P22kpmVVTequ+uM=;
        b=Gk5OnmcBaSqs27pMqr7JTlwtANEvN7ovRoD4iC3ml2C5s4WIsAIu4b4dPaYxqvwyah
         VEkUdbGrEGzElUsKv29nsdaDiW9xJrLafWItnPKQbT7EJoBU3CWOLJ6LQwxj2wLsPiUv
         oQrVoWSs/zHbbTZXKxyP725HBNoQvPNdMRTaHuq3j8NTHn5byTlVfKr4h4VJRhbHZlSS
         puAjS7+CTfJcI1oKLGIxd1/Ck49ygWD8irrCkHXlVRHMYFTxz4kzUY5OIbVqjOhW5dOP
         h8kK1buNXI09QPhF2Ww3mo9Aoat47XtE+eMVmz8cBk23/PxNBJ6nAXQ8JTVRQIVAmilK
         QNtg==
X-Gm-Message-State: AOJu0YzIeOW81NIoT0+dMk7ejbi2CVOLnSOtXsEj1k1O/Pbeeu25BMH5
	p8jndG1taYfF1G8iku7nvfl2HqhI6jN0WZ/IHhMaGmLjLc8=
X-Google-Smtp-Source: AGHT+IGBDuUVbEc4MOnK0q+qwjTF8xev/hh6t/5nR0WCAO1fRV02DE9gFCBVoyg9+mWSph+8D62CdY4g46YZLzIEg1U=
X-Received: by 2002:a05:6102:3d18:b0:467:d815:bd6c with SMTP id
 i24-20020a0561023d1800b00467d815bd6cmr92854vsv.8.1704693999549; Sun, 07 Jan
 2024 22:06:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vikas Aggarwal <vik.reck@gmail.com>
Date: Mon, 8 Jan 2024 11:36:29 +0530
Message-ID: <CAOid5F-mJn+vnC6x885Ykq8_OckMeVkZjqqvFQv4CxAxUT1kxg@mail.gmail.com>
Subject: tc-mirred : Redirect Broadcast (like ARP) pkts rcvd on eth1 towards eth0
To: netdev@vger.kernel.org, jhs@mojatatu.com
Content-Type: text/plain; charset="UTF-8"

Hello "tc" experts,

I have questions regarding  tc-mirred.

Can tc-mirred tool  match on ethernet destination MAC address as I
want to redirect all broadcast pkts recvd on my ETH1 interface from
external network  to appear on ETH0 ingress interface.

Thanks & Regards
-vik.reck

