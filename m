Return-Path: <netdev+bounces-163843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1ECA2BC47
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D7F77A3055
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 07:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B9618A92D;
	Fri,  7 Feb 2025 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDPelGKT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A46D187332
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913432; cv=none; b=s2gCyGRuU2Vm9XVgBZ7/BNxogc0bP3v6v4FssEJCc220eBpkoHpB5iJEfUU6aD+JTkCmFjJbJft0cDaoAkhmjyTY1asrGi1NOskU8uAuDQ4U6u1CABOi5WMKYckv55tQnnHeNa5gljvd2QhOFWx355bh57LU3qW2qYdbKbfQDFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913432; c=relaxed/simple;
	bh=Hp/uKGYdunUuyzZd2rTVPfT3eZ7w8hlA0Qa77VEIkQg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=VGTBOHfDGnxiri7ao39fJ5t/8j4aQ7PxnEY7zj+fqVE34yNe/9yZZc9vfNvmW3eTQbVG0u7egGQu+7aMljSVHigTTwa66nfWWDOW83rLazAc3nueRG03FXunR2LntRwHTBbHSygTyipTaQxIqHZIBcOLQeyg3qrOaZGazD/Fhf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDPelGKT; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38dc5764fc0so824110f8f.3
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 23:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738913429; x=1739518229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hp/uKGYdunUuyzZd2rTVPfT3eZ7w8hlA0Qa77VEIkQg=;
        b=JDPelGKTcv6f+Wx3MfKALoCqnee4vLhF9B05nx5gkt4lVF2onaQBu349Qbo6yu2Ter
         Kswl7IspgaXg4piI6UTplg5rXdYEg34JLTQAS7ecXfkRwsgXtPgtXLxn5U8vqzHbfX2o
         ag0uhdRTa2sYv0vySWjkA29h3ijmUoN4A8vH5JqCZVqnhr2nzTHB3j91AbLf4NROKZLn
         GGsnMzPMDp2LK5pF5msSiVpyPsdmYs1iRSH/o8Wpnxe1tq3MEFFCubBgSpyjKpl8V61l
         b+uy7Qs+ZBlvsxhgmvT53TFianxO0s79xnw8vcqlgPjUMDWNadaqo+wWzweewo2U+YD/
         4BpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738913429; x=1739518229;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hp/uKGYdunUuyzZd2rTVPfT3eZ7w8hlA0Qa77VEIkQg=;
        b=hheA0SBnDCLT71NHFknswkB0IHeH48e69DLKk958lbBqWOuJt0+ChCNzO3T9JXIEPq
         vxVTSokjudf5iazbjdsw7ZB6e++Yk3lSqkjXQE+64QqNRt+y/XFBt8BEJR1ePdjKRIyp
         +FUbkiML4aI0KSs7/U281uwj+ws3iCKN7R2abnKeCGHEjFzvJ5qCEQiHbbinqy4trbgx
         Y0MkGps+d6gSOL7iOzMbGmfOmROH86zYF6LOoem3ln+g41dwESjncMzIbnSfH9PArOuJ
         CxaEALANqd+AHt5n5pnax1b/YbwkVvJpDedkE3JHM1N7zEjungObBhDh8aUV4V5Lx77+
         xsqw==
X-Gm-Message-State: AOJu0Yypk5wun88UfjeZKemAyzF28LnxSNJWtqj4AdYOKwuZzfl+ffE+
	Z2TPDL12UjmuVqyw6uUsvhnU3a88hGflAMJAghtPXgm4jYdvgxCpv+v0Yg==
X-Gm-Gg: ASbGncsU+Q1SqCyORQdDT5CRmkzQXAXpqLGJvvxXJyVx8UHsEGWUj9gBCcbTq0bzX+t
	YzpdJSDK9OEAZzOEFNgIAIW9XoW5GIf7ggcauBVs5B3hjyJl2z7XmkiGswEGUaoUicdRk8tpGAf
	g38hF1xKB0XScP7lACQoueZKLaQrFmhDNS50YMLyq4GmZGFIXPJ2Y5JGcYlaRbIUvrZdMIU2GfL
	f3GDaYQfjKB+1hN5SJ/zi9bUgrSGVy1mzWW1nHxNfNEOdn+DcOHtT3iPHPyjRzCXHrvwMaaqLv9
	Qig8+p0jMXupLaaEQA1fS7oE3Kd0NtioTd9OXTbI6RNZWqiPF574FtWKtADmxFszT8dvGMZ79I4
	tGLHlva53FC0q6lmRXEvq3p+q7f2deQTHbAZ7aIV9eKmfHEBdZpmG+qHYXFOllPlMgvRnO9xo+M
	I5fX4VonQ=
X-Google-Smtp-Source: AGHT+IGag5KBjHpw7Q4W76eQZUo2fwBTKMrJLxQR2x3UwNAldn8kua5kiBvOePq0gCJ3LmYNVpokGw==
X-Received: by 2002:a5d:5986:0:b0:385:df5d:622c with SMTP id ffacd0b85a97d-38dc90faf32mr1069289f8f.30.1738913429167;
        Thu, 06 Feb 2025 23:30:29 -0800 (PST)
Received: from ?IPV6:2a02:3100:b0a2:1c00:3c21:b7c1:879d:8656? (dynamic-2a02-3100-b0a2-1c00-3c21-b7c1-879d-8656.310.pool.telefonica.de. [2a02:3100:b0a2:1c00:3c21:b7c1:879d:8656])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38dcd0fac67sm522604f8f.54.2025.02.06.23.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 23:30:28 -0800 (PST)
Message-ID: <b0be6bbd-c0f1-42ab-9e28-ee9a55f5283c@gmail.com>
Date: Fri, 7 Feb 2025 08:30:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: MAC/PHY-support speeds on xgene-v2
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
To: Iyappan Subramanian <iyappan@os.amperecomputing.com>,
 Keyur Chudgar <keyur@os.amperecomputing.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Upcoming cleanups in phylib raise a question wrt xgene-v2:
xge_mac_set_speed() indicates that speeds of 10Mbps and 100Mbps are
supported by the MAC. xge_mdio_config() however removes these speeds
from the PHY-supported modes.
What is the background of removing these speeds from the PHY
advertisement? Are they supported by the MAC or not?


