Return-Path: <netdev+bounces-138680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7439AE85C
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7CD1F21F8A
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8271FAEE3;
	Thu, 24 Oct 2024 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1xtXZrg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C89A1EABAB
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779286; cv=none; b=itf/gEe1xQGHkN1cz6cZjoJbd80LvRAVZgZhCoKvY1H4B+Uz5ru6ZXc6+GqM4KwXi4a+1ioS5NCHdfWI3ocrqhxwJpQqkelTQI1WKr3rL+qfzBOgGsyOx654kqctEoFbOD3JhvCgKP+QVCvYJdr/ze09UdzVvtbg7J4JleIXS8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779286; c=relaxed/simple;
	bh=4E96ONiFu6oPVrd9FVp4DMR3A5juKrgtl5Xg/EU1kU0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Gu70n0zlqyF4YlctWRVp95LeNtpBUZVX8GtZ/0IzjyPQqzLWV05QzzuZZp0qB9G0SYDWEhuDO4Q/gsch4akAnrOnfWVd8N4D/q3EMk7KNFp2GTFcV/8Y6UfsZIfrRq1H3iamYBJMi5ZucrDA00HnbCfVKCs8zF84cCF/yYypVvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1xtXZrg; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e38fc62b9fso9422437b3.2
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 07:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729779280; x=1730384080; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8MQUgZ/BbPDPdqyq38gojGKFlT7p4FSzsLrZhyCwmLc=;
        b=f1xtXZrg8ZJ39HYRncDc7u/N6l7vn2FwTn0cFb95X0GFCG3Hd+HM/U/b1zYPD8Z5rx
         c+i5673/OZ+fD7AgRynDI56JGHFnzXSE05usY/Ah5B/WjxcFeme+uTWI3vuMUX4ndbFd
         amnaZWJD7NdezMKds7fVEmsp3uLiIpjwpDU14z7vzVJufQzFeXAsUjasTBDsRpDlDt5M
         0ebtQLtws+oiE83aQTpz0ZbBcn/rC2Qo2bnU3zVLn0ghfLFTsQEXdohBaLnywt0mUqRy
         42PVDIIBt9ZtSHebbWt71PbqfvctzTORYIW1wzszlx0mnCPf1EyZPiPP7JlbhRday4w+
         8K5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729779280; x=1730384080;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8MQUgZ/BbPDPdqyq38gojGKFlT7p4FSzsLrZhyCwmLc=;
        b=uvsUbCGMvzhl+5/FIMDSNccbQZSzbDecYFADul5FtnekVlrpZn4KxBnhB1Lph/+p8i
         VIDEldyrpPPuz1oSJjBjU0vGB8YhjURn8prZHjIzRMOMviBM/v5EZAIidLB1tk4Xa99w
         9WIPArXCRI8/mVJPt0kTVRjmNedGl66U2aFun9YqRWjSeR2F3PGgsWDOqBrVkph/8Pv1
         Q77e0PTAVkBiRyYI/SmKvpobK/KiISISAD5mCcSOAyfix/cz2KH93zEyhPCG4nzrUBdG
         a96smOFID3MwNRf+bXsenV9WhxT031moD9x3pGkZJrlpQHdof5VllvAuPZ/me/CWUkVx
         rHdQ==
X-Gm-Message-State: AOJu0Yy5QMU8rec1K1hz0m2ncRKk2CWQ1WNhJ+jGgWj+LaOo7inGh2ot
	xkmleA07653CpV/QrQ9PJ3EsNAjHj6FlTYnAoE6SY9IVPVDcQ5qq7TeBbrd62pQKPlAPIbD8Wdb
	WOm3zjzxNQHWc4P85LmdrhrZa1o3xPiu/
X-Google-Smtp-Source: AGHT+IEpZlVp3vgT5W5NtnOSSmMp+e5aC/0QE/en0gajdrf/d/3CmbNZYzOR/hQVlGiall8R1jqW8a7T80mm7I9ce0o=
X-Received: by 2002:a05:690c:681:b0:6dd:d709:6f18 with SMTP id
 00721157ae682-6e7f0fc17bcmr79241047b3.39.1729779280632; Thu, 24 Oct 2024
 07:14:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: SIMON BABY <simonkbaby@gmail.com>
Date: Thu, 24 Oct 2024 07:14:28 -0700
Message-ID: <CAEFUPH2npsz4XKna0KYjOeU_MfYN-bVTw25jn6m2dS+f32RuxQ@mail.gmail.com>
Subject: query on VLAN with linux DSA ports
To: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"

Hello Team,

Can I know what is the best way of  implementing VLAN on linux DSA user ports ?

I would like to know if I can go with VLAN interface or VLAN filtering
on bridge interface. I am using Marvel DSA  (88E6390) running on Linux
6.1 kernel.

Below is my requirement.

eth0 (conduit interface)

lan1 ----VLAN 10    192.168.1.1/24
lan2 ----VLAN 10

lan3 -----VLAN 20   192.168.2.1/24

lan4------VLAN 30    192.168.3.1/24

Do I need to create a separate bridge interface for each port which
belongs to different subnets?

Is it better to use a VLAN aware bridge (with vlan_filitering = 1) or
create multiple vlan interfaces ?


Thanks, Simon

