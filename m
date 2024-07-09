Return-Path: <netdev+bounces-110211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 554CB92B51F
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 12:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A2A284C8F
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EC5155C93;
	Tue,  9 Jul 2024 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fiCVGxzJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175FE155CB3
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520580; cv=none; b=imTjUsNFeWhvMoviXnsIrPZsj5rHQT3lucoE4zbdwyCbmmBLUKr9+hSPmTacRzMuWp40jyrSRG0CwxTSd1eVotSQ9WPAUiOC8rS5xC4GwbU/qqDJoJAfYOskYII8gSWV2EI3qk4ynTxRxoh5E1+sZ+ybYbFNiFblkHFze7Ziw2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520580; c=relaxed/simple;
	bh=/Popa0pu2ve+BT+70iPGnXxHfASirswI1GoEfm2LmEI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MHzIvbP7IGQB1poxuolEhsNAF1SKi2BVQ6KXm+71XfZ0FfuHDx3jtqxtiLjCQOMaLySKFAyHWK3ar4m7f9wWgHuLTC8UghxylV5kqrDK61II1r5UQwIRBvuOrqzhGAcHaTMt/1usOG5rRp2M4V/I0+rZS5eIvwBe7vFfNa/8FiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fiCVGxzJ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-765590154b4so2352591a12.0
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 03:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720520578; x=1721125378; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11ioL6MkBuE1i6Mzb5KKuPr/JiRiwhzn3IC3btu4k64=;
        b=fiCVGxzJHc+khc8ysRoN/L1zd+q0CWhIlnsTQHRBhfqgmt8Q/S8C4D+m9edIQQljX+
         PjO8hjiOhcudRhBLRTUlLzdXiWAp9MaIJjNCojOABe0xS6JQTKXwt9SvnMTcivBqyxOk
         jVm++HadCeavB5xgU0cqyiiSz5Q69MXhqjSJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720520578; x=1721125378;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11ioL6MkBuE1i6Mzb5KKuPr/JiRiwhzn3IC3btu4k64=;
        b=m1v+OVCxHTSuuuLePa6d9HXo+B8uf/Ow7mok4WvPzAvtaLtJ8dFAxp/jXjD4OyKJGN
         RKTugZ/HgXV++hOGJUNSq9PO8wFN2flJWRImhhNOuqF/Al5WKFxdDqp27fcFyuOWAwKU
         KDBP7gMUucgBHwR83Wq0K6HXzkt4Zeg2QIEYG1+up7hevtdPyD97yKSMGB9/3i9DbMji
         SnWjA+bUIT7iiC8uU3BMyaDgsqTMMIwpUxcLAqDDA1NMK5Jsehi4glAeUi6fnGFAjB/7
         2Z6AVy1AlfOWiNZU5djVsOnp9EoXypgTObsGDFo9l9B9+9K/GxL9L4YWtPgz/r9U9O0x
         IqtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVdDSFQg4AANfBviwyBBgLDLrmOf4WcGa1wiuAHUAqA44C5acg87L4FRaI75LCSSsiIg4HnUcBYXjz9o/fH523TANdLE80
X-Gm-Message-State: AOJu0Yxi/5SeSpaOq4MsZICWg8C67AuNLpduqupyTuyBKDhjINl8OVjU
	pZeqDM6oxqKoVhBBsuZ/VVBBebiUbzDMeNU9Wn+LriKu0xhCMUTsCJGxXQx/ZQ==
X-Google-Smtp-Source: AGHT+IEImvkD6z0gexkfENnSZaUDX8nym2t3SgyFN4Ccwymmm1btyXlvMii3wyggYiErqQf98g/ruw==
X-Received: by 2002:a05:6a21:a342:b0:1c2:8a69:3391 with SMTP id adf61e73a8af0-1c298242021mr2265566637.30.1720520578368;
        Tue, 09 Jul 2024 03:22:58 -0700 (PDT)
Received: from kashwindayan-virtual-machine.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a11757sm12832525ad.35.2024.07.09.03.22.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2024 03:22:58 -0700 (PDT)
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
Subject: [PATCH v5.10 0/2] Fix for CVE-2024-36901
Date: Tue,  9 Jul 2024 15:52:48 +0530
Message-Id: <1720520570-9904-1-git-send-email-ashwin.kamat@broadcom.com>
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


