Return-Path: <netdev+bounces-204709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E71AFBDB9
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 23:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625D3188B4D6
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DE52868A5;
	Mon,  7 Jul 2025 21:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WpDvmW46"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C17D1C5D55
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751924344; cv=none; b=mpSFvgiXbsCU6Zjf2hNDJUffQfKlGn42Hpdl3Gc9DUb551dSSZSFgMhf1zE1iiaDZiCcQ+Ym8s6hniYUEWWEPDnOiScSO1eA5daHXXDnnrNcRzniukOtX7n+VHBQh3yZQLhduhRC7IVnvfty8AamXwm3Fe8oPLPbQq7zS3hXT4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751924344; c=relaxed/simple;
	bh=3DImO+Q36g1DXrXYh0GWlEaiJfRxCNmIspN93DmQm9o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=L7peGdc7ftCR0vNzYe5SB3TztVU99oUIOA83Z4b0kA/FyDvWqV23LxUKNs/yHwrlUteRKYPDUj2cyxpfPFqP6L0ejCeI1KxmgU8Q7xZl4z7aTFTaX62QoYdwPGORRl4W59tqPXtRhbHujPi5yvHWmGzVSOAe/dXFuYPvEK0vnl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WpDvmW46; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6fac216872cso76562306d6.2
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 14:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751924342; x=1752529142; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OXFF1iKg1Y5nF8w7zBgTeJFpyQX5K28Jf9a258vOo5U=;
        b=WpDvmW46CH3CxVdFJQXbDhgTUdikmLmDrwlV76+9htOPCPSMiFgG2rEdaODrmfJfFf
         iy10GCBpgXC5C6ESDRYX8wBWl13mcXCfuM3X+dELP1bNbLnKJE4Y+wfaVz8BM3USR17m
         Q8LdrTEKVVzvYtpU5kz2NPWpu/TEP+jaosyeomod+qvg0RMz+R+UNbnPb5e58z/ylNRn
         41guNZH1lIs8NVYj6qMfsfO31E9YWEWlP2eYKsERbgWn4LFcD8SMCKb/YqjsBCTF208J
         MWvxHCZRGDxGJ0bOO4rbk9JMQDxpEGJsykRLq2/bNcK+qhcDvdCTP0rZ2Qfl7P5SS43w
         ZTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751924342; x=1752529142;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OXFF1iKg1Y5nF8w7zBgTeJFpyQX5K28Jf9a258vOo5U=;
        b=NPMxVDsVXFAWv/WhcUAngtAeSDSnQj7FEMufsuyLn7YPipUAtqkriKTGtByGDC04BN
         TLEOhc+ntAgB2v/Vl/UPgbZXMLjXS68DlKa/oZexScoZ3oeJQ4d9mAe5h58nILk6OFVp
         SpzjzxZ2az0R+GPTvuVBrMD6FR6a2NFH7rPktORmf7n6F0s34hWqzGCDtl9EwHIAZeYO
         hpWqsF36EU7vNxuvMIOsgyZRp2ySj2MpM6oTstVnygB4ly093cFGE8JKzb2aedcLrG/m
         DfJYC6r7msQm/mffuAtSQmMA7iuxq8lPRx8iT2IuYFeWpSOSZFEi69F43D6Y/DG6OJxE
         QMQw==
X-Forwarded-Encrypted: i=1; AJvYcCWWjx8n9wWOB303XbFbimASEGCtJHAinUjG8W9W6sslHwqGNozkjFwETkbgfjYWSRq6tJVetJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK2lVF4vM80ifnJWyqe9I6YH/CY44TAUfgJ6r5cW80rLPOUfD4
	DBBHeFTCv6d4+Tt7lvkP7dvbRMAON1IYxM2Y2zPLk1sPZij3Ib4aPyfQXhrHKAO79/zArB3P6gM
	fbNvLYs3OcUl/2A==
X-Google-Smtp-Source: AGHT+IFXX7WjQejMSG9xOf5PBaxq5wn+00cD+43VTvMY43sZN1l4+QTdYmqI0vWXzY3qRc0TpPMEZv0OZUg9nQ==
X-Received: from qvbkr4.prod.google.com ([2002:a05:6214:2b84:b0:6fb:239:9d1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5ce8:0:b0:6fa:c054:1628 with SMTP id 6a1803df08f44-702c6d66235mr244799636d6.23.1751924342227;
 Mon, 07 Jul 2025 14:39:02 -0700 (PDT)
Date: Mon,  7 Jul 2025 21:38:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707213900.1543248-1-edumazet@google.com>
Subject: [PATCH net 0/2] tcp: better memory control for not-yet-accepted sockets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Address a possible OOM condition caused by a recent change.

Add a new packetdrill test checking the expected behavior.

Eric Dumazet (2):
  tcp: refine sk_rcvbuf increase for ooo packets
  selftests/net: packetdrill: add tcp_ooo-before-and-after-accept.pkt

 net/ipv4/tcp_input.c                          |  4 +-
 .../tcp_ooo-before-and-after-accept.pkt       | 53 +++++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_ooo-before-and-after-accept.pkt

-- 
2.50.0.727.gbf7dc18ff4-goog


