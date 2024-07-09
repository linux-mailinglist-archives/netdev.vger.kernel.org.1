Return-Path: <netdev+bounces-110207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D1692B503
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 12:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF74B1C22850
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D18A154C04;
	Tue,  9 Jul 2024 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NHR8jP9k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37D213C699
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520397; cv=none; b=VX1flTs/uBzsDHeX1zTDwmJlYEb5pLkxaghoeBNBhABbIwwttaFXhRRtGlsd1AGj5LpQswtV6ArwsIaH59yJZzVf3aO0yojeonyagcNsNz9BUZJ1p5PecT0ypiR39qRoitbl00heYq4b2zxXnoL5eHhTHGOYaZX6Mt1o18o1o0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520397; c=relaxed/simple;
	bh=7l7Gnx36n7yyUlfPBXRvLQSU/1+kcr0OdNm2VCuznG8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=kR5JyILqmtzXkev59fdTu3vU7Zm0L/95SMUKCx/S8zbwpyrECgARdEuXPL8hrimEeTGv2mzKo6Clf9NRSjGoowfkNyAYQC+bKDAY9JADPO+mqdtNLzXhAG62f0zTWERuSKVfb8vLPOJYWXrWQl61d3WZ0JKiOp7DxVmhyReL4IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NHR8jP9k; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70b04cb28acso3320659b3a.0
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 03:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720520395; x=1721125195; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11ioL6MkBuE1i6Mzb5KKuPr/JiRiwhzn3IC3btu4k64=;
        b=NHR8jP9klbFKVbHfTCILManHrRVxQ9VKS6YbARdF743JVNLbGP85UF4njgVQN5QyoT
         +RfAt4YD0G4QlDA1cKaOaEohPAZhCRXF8BAuLfGoU8/tUAAAy9/PTLhgR9NoKu0zsHMZ
         nk1uKh4a21rZHUfatUb0Fjdu6nvfGIBlD4VQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720520395; x=1721125195;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11ioL6MkBuE1i6Mzb5KKuPr/JiRiwhzn3IC3btu4k64=;
        b=Uqg2Lr1+dbQ+/MRpo5radCobN68o+yM/MlnSCFJcccL7qRiq2V1oyealS83ZCA0+/A
         DPI0H/KZNT/UPwj6xyf+YqgWNNE0EWnp404s+ukBYIHh666uPmDBHDv0lgjuYljydkFf
         nS90tRfa+sAx79jO2Vk/7ppkE8QSGJP6RaqVictUccKzduqJBwAQ0+IRANbQkIXV3plc
         Gs1eU/Qz0v/IvBK6fVhpWGstnWTgGByG3UaA9EApcBgfh+6Mle3aQ06aWPrcS9XYXOVW
         F7EK7N21AAdqvD5y0IRoxG3dMwryW6YXCZzVJlIx17fqa21G18Dvz2VCZYOBBmScgUMN
         rRvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrIrwhAr5/vww2+cMP40SefX4OSIYEjDOfqCS91ta7rQQ4g1Zvj4zCdH8lMkA6eatvqY2Qp7W4WnLWMKgamZYWu7mYov54
X-Gm-Message-State: AOJu0YxfWXkda+tne7W9NPqM3XAyQW+REqxgV8AZgLbMHTV7qEi2Mgak
	E36ovwhAfbEIfEjBeIgVAqNacZ3Vkd0O8Tjufel1R5H9jGdtY1ogkrgAG0viiQ==
X-Google-Smtp-Source: AGHT+IGgmqH7UQ62MCOmx/bF5fNPuls7Idvh3gTEMJN+4xl6ri7+bXz1HtPde01qGp0e8dNnIi9M+Q==
X-Received: by 2002:a05:6a00:18a3:b0:70a:f001:d22c with SMTP id d2e1a72fcca58-70b44d4474dmr2944949b3a.4.1720520394971;
        Tue, 09 Jul 2024 03:19:54 -0700 (PDT)
Received: from kashwindayan-virtual-machine.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967345sm1426016b3a.112.2024.07.09.03.19.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2024 03:19:54 -0700 (PDT)
From: Ashwin Kamat <ashwin.kamat@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	davem@davemloft.net,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	florian.fainelli@broadcom.com,
	ajay.kaher@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	tapas.kundu@broadcom.com,
	ashwin.kamat@broadcom.com
Subject: [PATCH v5.15 0/2] Fix for CVE-2024-36901
Date: Tue,  9 Jul 2024 15:49:42 +0530
Message-Id: <1720520384-9690-1-git-send-email-ashwin.kamat@broadcom.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>

net/ipv6: annotate data-races around cnf.disable_ipv6 
       disable_ipv6 is read locklessly, add appropriate READ_ONCE() and WRITE_ONCE() annotations.

net/ipv6: prevent NULL dereference in ip6_output()
       Fix for CVE-2024-36901

Ashwin Dayanand Kamat (2):
       net/ipv6: annotate data-races around cnf.disable_ipv6
       net/ipv6: prevent NULL dereference in ip6_output()

 net/ipv6/addrconf.c   | 9 +++++----
 net/ipv6/ip6_input.c  | 2 +-
 net/ipv6/ip6_output.c | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.7.4


