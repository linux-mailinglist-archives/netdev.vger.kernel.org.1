Return-Path: <netdev+bounces-171851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5336A4F1C3
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 00:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E52416E0EF
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 23:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE80425F989;
	Tue,  4 Mar 2025 23:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTgb9PC3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39069BA2D
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 23:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741132143; cv=none; b=hbNhzH1hq4Qav4OMReBmT+DHkhaIXEntecWTmz8sUvN2wW67eALb5NDHdEC27xnQepoUvRVN5ewz/NUJJUDF2g7d9mdG8PecOXddp1SeUnta6KJ3B7I8ZFaQf9iN06DG1v62eVtqgPKrFDKCKaFePek6EYVQY2vhlnwLZtOIk+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741132143; c=relaxed/simple;
	bh=YXBMkszQ7C83c5TFoLX8+jcjKCyATW78hihkaIPTueY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=caKs8CHIIqJ6VxzKxPKz2pWfk4BCZ4pGNxZ9QxzaojX5ywt7k2TT0KI+xBXbuZNiMs96zF9X960DN1bEK7kJ8/FbVY0ohKqHAIBsYrZLy70hlbKBPM1Bp2MFzz4IDDscLOa6xGS+gbjRTstClP1iiRBRRxoDs29bWQx8FJCLVmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTgb9PC3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2238e884f72so61100795ad.3
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 15:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741132141; x=1741736941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZelafsoo73W1qWibYPDu/+VMAlSbg3CdrtFX3D1U58=;
        b=QTgb9PC3XvkdxxFuN/2NAf3iSMkGauaCHy7xFREA7G4WokzU++OL7moKxTVOptdTDv
         yNuM9Wyx9RY/SBZ99ja5LTzzGjdWggVf3Dlz7gJzIlQ8lussmmVA5QfnZHr/kiFLTB+X
         1S7Tty7wagQyFMYB2hQPxu1SKJm95w1pJNlQ40vB56bVJZ2ZTRGNt53PJIhkKMDs7ri3
         y8+bGfgWCLvL7fNU0MEIrtPIVIppA34JQOGEmuDz63KsIhz4AMaBHq7OmfvvW5QuIFyR
         N89/2jR1oUnD3hGmSAUFOPZZ2meLfdZHMMa4QiT4XHCWKK3Rw40FQQLhTKQLWIHsxp9h
         /syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741132141; x=1741736941;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xZelafsoo73W1qWibYPDu/+VMAlSbg3CdrtFX3D1U58=;
        b=iLd5hGHerHjk8oX+HdeRFSAMMHz9ATwbRCYPYdp3UMxKZPOv9swLVDYPpjJLksrAA2
         4h41/2LQN0ZxaGAEnzfMDOOvsmyiJPnsccM88NCt028tSVQEIrDljG3bF5hyacstcOiN
         UpRhXQCJttg60UTeg5xmSrvtqNx6kz03zGE0AZYwh/oZ8ByB6OP8/kXCah+b8+qPtgG1
         mLGabjrtSiFuQPZRt8jp7aoYEHvBi1ZwysgzMjyq4zTH26Pfka4KIHJy5LMb9Bn+PO4f
         w/Pf8tQWlHMFZw7v1nw54pCy0XQbZvVvHGQs0awnVWKUAjDi41sjcMFWdXTPCL67ZSWv
         LChA==
X-Forwarded-Encrypted: i=1; AJvYcCUYBfKaPYL6XO8uaN1J4Nliy6jEWdsXZXwMC1DfosJ0h98ILtBu5Ifs6FG5VMG44+t92xxGDi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiJ4RYciYxbQ3+VhP6bCpUVhzUEY8w8sKtWUCQ4bC+A63lEbhg
	5inKt4xxVe0ilcjr/CaF2S/XXqcms1rYeHwLouB+5qaCE0EDU3GyCAdhwQ==
X-Gm-Gg: ASbGnctqFQ+SwlApLy1YtIFZoKQmb3AnVx2yzr8vS8n52+4zVSXmhlnR0cixiApDO1D
	raiE+gZdDDj8Ck3JqN5JZwuOK38sYJmZz/1PR4/TzEXyxjSNCTvK7jv4lOion1vTdcz9UORWHzI
	x/DSeeISGFHxC8Xg4U4AyCskGBhWidHNEBx8DV1WoC4mDetyMQJno11ihmhLWy4vtEntNawBuAJ
	7ldKJHR6XgGVE+GVYz34OiH0mnj0bNb+BI/7SuU7grwagI/78BpuZd+fCO++BGrMyi209ixjtuf
	y6O8CvyehlagxpbbJEN0X6aCxIPp2S2qfAfzH6WWH0xu/uq4DDGrHxkFn+DWdrH409nZRrmX/UY
	HcBBDZWAKOKPWUVdp+tyFybPVVT0=
X-Google-Smtp-Source: AGHT+IF2P/MDRwRKN4QLP0GfNR2l3HYguj+E/lyVuvXgSRZiJN1wUuo1EMH9hM+sWQ3GzyZkrSk/1A==
X-Received: by 2002:a05:6a00:92a7:b0:730:8386:6078 with SMTP id d2e1a72fcca58-736829cf1aemr1385804b3a.0.1741132141405;
        Tue, 04 Mar 2025 15:49:01 -0800 (PST)
Received: from localhost (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7364c9541a2sm5428488b3a.21.2025.03.04.15.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 15:49:01 -0800 (PST)
Date: Wed, 05 Mar 2025 08:48:58 +0900 (JST)
Message-Id: <20250305.084858.1138848711250818607.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: max.schulze@online.de, fujita.tomonori@gmail.com, hfdevel@gmx.net,
 netdev@vger.kernel.org
Subject: Re: tn40xx / qt2025: cannot load firmware, error -2
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <9aede328-4050-4505-83a5-c0eeb67d1fc5@lunn.ch>
References: <89515e61-6aeb-4063-bc47-52a9ea982a26@lunn.ch>
	<b2296450-74bb-4812-ac1a-6939ef869741@online.de>
	<9aede328-4050-4505-83a5-c0eeb67d1fc5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 4 Mar 2025 18:55:02 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

>> Does it really only support 10GBe, and not 1GBe or 100BaseSX ?
>> > $ sudo ethtool enp3s0
>> > Settings for enp3s0:
>> > 	Supported ports: [  ]
>> > 	Supported link modes:   10000baseSR/Full
>> > 	Supported pause frame use: No
>> > 	Supports auto-negotiation: No
>> > 	Supported FEC modes: Not reported
>> > 	Advertised link modes:  10000baseSR/Full
>> > 	Advertised pause frame use: No
>> > 	Advertised auto-negotiation: No
>> > 	Advertised FEC modes: Not reported
>> > 	Speed: 10000Mb/s
>> > 	Duplex: Full
>> > 	Auto-negotiation: off
>> > 	Port: Twisted Pair
>> > 	PHYAD: 1
>> > 	Transceiver: external
>> > 	MDI-X: Unknown
>> > 	Link detected: yes
> 
> From my reading of the PHY datasheet, it can do 1000Base-KX, but there
> is no mention of 100BaseSX. There is also limited access to the i2c
> eeprom in the SFP, so ethtool -m could be implemented.

Yeah, I have not yet found a way to implement the ethtool operation
that accesses the SFP and returns the appropriate information.

