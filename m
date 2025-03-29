Return-Path: <netdev+bounces-178177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4CFA75384
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 01:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B601887517
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 00:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2907B156861;
	Sat, 29 Mar 2025 00:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="PS/f4eRy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A350223C9
	for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 00:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743206437; cv=none; b=q6NprPmHlltu4EkFEElzTGNlYtmb82IZ1Lgg/Q8mTwrdiZS1QczdrotipBhoMv8J1aoYh7eFwVNTLJMCG2rElYGU0t2IwT1xLRSgl3j4TrRKV0itF8CplPteGYEeYo3kxFOrmen+ek2gZF58VDlWCbli2sVW5lZBCMni+RWLm34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743206437; c=relaxed/simple;
	bh=0a1DTC6uahwJCGg8+TCx/4i6vOJVdSP3T6MKAIya57o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PPZdC7I16q06EWb6CK7MSzc0rQWX9WNE7jCZXKxpTpzGm5PUKfheOC3y31eWcQH6iqo9no0c0k/HqIhr4dYJ2m22NPf96hbADbznMO29aSX12Zksmvs6mikaQovXbei4VgaUT9UMmQIpRtJR8f+Bo1mg0BMV+uxfeGUjLP13fys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=PS/f4eRy; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-301493f461eso3450337a91.3
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 17:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1743206434; x=1743811234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ifLYiUPET7SDV/Gtqe1wiBHrTm8AmBIWj9O+ElgmM5I=;
        b=PS/f4eRy4Wm2vcwnrgCFD2Xw8py6IDKcQpIgeSWz2kJkFX5nub9h3DSuwOKq4ix5l/
         o8fphbabCae2jpx7EknpNIq6Om9vs28B1wenw3FiyUTutSmdJqWckxyo52CAX5r7R6dy
         PdYlNBZgPA86gjEYrG6R8qI0n2IRTV15GUsaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743206434; x=1743811234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifLYiUPET7SDV/Gtqe1wiBHrTm8AmBIWj9O+ElgmM5I=;
        b=iIQRst8IinGafacXgoTrDrs7tLTB5cKUXVo2WVJINbXohs0T/tN2IRvKXaAHq4gsSA
         ezSYiB3PMQcnUKKLrYY5tYVE1X7S2LZOg8RTAMT9tCT1GI0AkSJoIEceWHt7susJqcma
         W1h1nelMhdaBIT13yNeEOpi0PNtZhXQFv2MMbRUzX7Ow5hK7xajhub4Dw7n3NjiPD3vx
         pfi8jKhN4WshwgDY1Y36CtEXESaJThBuGeGSbd9FmmGImBhqiSwYZjPaADyg/ihx579w
         y/j4UqEXB+V/MK3cqXyugQsoWriOAxotM3DPw7DjUENdVhVuVXSOD11pR8Ql+95Op25w
         KkLQ==
X-Gm-Message-State: AOJu0Yz5aY7d8angz12gVItPsv57hiehXGbEfuvJEqc3vfXA7a3ltC/m
	FLFRTBSCDaJLzugPdwORwfFiPKKcDYnSvv33kQCrCdC/W8FH+OplzYQApkUyGGTUF8XCyoxrumO
	WU1e4oanOoNLA8EUT4c/c1TSTdJA8ZQ7lBUU2F+87i+ednTUJoJ40vhzxiOgdSgmf1yw61clZWj
	eYJTb058r105qazrJghKMTXVrCaL8kEzcuNT4=
X-Gm-Gg: ASbGnct2z2zTBn6E27ECPAwwZ+R/XOAC2bJLvWxl8A8/qRGCQn0ZAlv7dtXBbhmjKua
	DusKVeH2JvjvwHsPMZUhZbJw5WHjwxls7tzYsSqzHe8pSEfwda52c+3ja0Sthlk89N4Hh3FxFlg
	g7/gM8tnBLlXWtr+fzm+Y2Yqbi1aRhz8lc7fCDDBUKzLlLjlVapn9KVmuL4J4xbvAV0xqjhDmXc
	wM5vqmP1nOufMscRALf/x9/N6RNj4d5DdsfInVCtUjrxthDCXaHBwShHKJ93w22dCTEi03FYGhA
	DbyXRh5GSeuI5yXYksbyKH0EtGEp48XQKDX3hXuf1r+ssNYbS257
X-Google-Smtp-Source: AGHT+IH0UyODGDUJJwEA59rR1uONHgeWOPfaxVsYR/noCUP0cQDlaEF4hkN0Caq16V/gbGo9G27hyw==
X-Received: by 2002:a17:90b:5446:b0:2fa:f8d:65de with SMTP id 98e67ed59e1d1-30532147035mr1612441a91.22.1743206434054;
        Fri, 28 Mar 2025 17:00:34 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039f1d4ba4sm4857139a91.31.2025.03.28.17.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 17:00:33 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	David Wei <dw@davidwei.uk>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	Paolo Abeni <pabeni@redhat.com>
Subject: [RFC net 0/1] Fix netdevim to correctly mark NAPI IDs
Date: Sat, 29 Mar 2025 00:00:28 +0000
Message-ID: <20250329000030.39543-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Sending this as an RFC because I'm not sure if this is net or net-next
material?

If users are using netdevsim out in the wild to test userland apps, this
might be an net material, but LMK.

If this is net material: I can resend without the cover letter and when
net-next re-opens I'll update the busy_poller.c test to check the NAPI
ID isn't zero.

If this net-next material: I'll wait until it reopens and send this
patch + an update to busy_poller.c as described above.

Thanks,
Joe

Joe Damato (1):
  netdevsim: Mark NAPI ID on skb in nsim_rcv

 drivers/net/netdevsim/netdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


base-commit: 2ea396448f26d0d7d66224cb56500a6789c7ed07
-- 
2.43.0


