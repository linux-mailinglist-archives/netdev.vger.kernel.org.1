Return-Path: <netdev+bounces-78700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDD587633C
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 12:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D77D1C213F2
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 11:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514C25576D;
	Fri,  8 Mar 2024 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0xa5NfF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E759A55E41
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709897113; cv=none; b=TA8cz0qy5jNdCRBA7hH3F7YD7+QF+qZAaaJWhK2Nf8igNu0QY7QWKsQACLJC9Qc65Xq3BlrOXlFljqT2DNkS4LOcZErPCU7pfg7Y90r+/ckXgW+UKE4iMHiMpaSHqODGQT0g+/x4Z8WxiStbsDXH17GSncVPlLAFwt7pEcGWKOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709897113; c=relaxed/simple;
	bh=GchYU3sRLCHl43EyLRrMwa916/Hymv0L6LEevBMhOfE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nED82FFXTyDmHRzJeNyWjsG8Z6BpoCvZJXsoN9BZxGin3mz/66MDSArqirJyLzqkP5yOeLxncLLzi00lWyJRzIA7qnehjXENcE4g63mRAMJoidPcDB4vGreWtB7NePq3wNqYZQvqLjbdvrWuprJfpZfWsEXoW1tfDK0b8BlnCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0xa5NfF; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e6277f72d8so1514201b3a.1
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 03:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709897111; x=1710501911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/5JAH19+ljGA+cfTwCom50gS25UogX7DRM80TIVzLZI=;
        b=Z0xa5NfF8h0uHS8wMZOG7mCt7ua4poVFO446Y5n0zX5Tx2F9NF85AhSF0u3c+3msWC
         o+l0tK+zLg3XKnuaJicxrc6GPK9oQ9r8HOrQNc6iLovbAC3/Vm6X/t79WVIeVAEviWQq
         S1DSk9sZkO26pBG3pxZUKfAeic1gfMSjPpUKjEkW60ZAFIsPDzm8BUW54DOhA67Hne0O
         CvTkmsjzs0a9cKUi5L7Yh51ryzJez0mccE0v+Ze47BJpMrcR8vF5q/KmVf6y0yh74Fdb
         cd7PALnxjfKaZHiveIqHgc3AtSC6E/aif4XKA3MbPIa9Eb7rSUIVAYDzf8BngEK+ywzP
         v0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709897111; x=1710501911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/5JAH19+ljGA+cfTwCom50gS25UogX7DRM80TIVzLZI=;
        b=asGvSNQorCEGJ2iRBZgMKOfZrbwHc8vuhUf8D2yiIO7Ye0NCr73pNbM+N6b7pRODUE
         z4MHUjsNxMv9WoQmSxWP2TVmvGoI6z31BMHkXSOCjsQdadm2E4OgSohMOhhOuv4tXd4h
         YzvbllhOhZaBvxliekuHnJ+X8iaJSYmCM+J6ILYV6s3tsz2e6DFXx02Rb/I+tW2OwltK
         4evA+T3jhWp7vrCipzUQEpj0x8YgCCv0af9SSTBz3tRl2nOm4Pk+KJA6xkvbg7c99H7H
         LBGGy6Nbr73+SZKRSN+wtcn2MccDcO2p4BczmaPbfIEO08toM/XY+7daz+pPceeYkZYz
         GL4A==
X-Forwarded-Encrypted: i=1; AJvYcCUUGNYxDT/gGfpnjMlKg6oPvVCiS8nPQAMKz2oi3rfdjFgyhl8zlQYd4ap8UDrDxE7hq1KPSC+ijC3G78yfnT+dQraHzBpx
X-Gm-Message-State: AOJu0YyBv768ztfMPumYFBmOAK3fLsvJR2bJpXsWvyNxlDR3quGQU3wK
	tEqb4fBrhQHXgOCLRNlCXtxK9ES/LzQGgGOo3fKs9XYRty9Uv+Ki
X-Google-Smtp-Source: AGHT+IHyZKgizh2iozs39rZZNpRM0lghUJVjbwikv1GZSkD0PwOuY/LYlvZhhnIDbP20QhcVqyvRfQ==
X-Received: by 2002:a05:6a21:3a83:b0:1a1:8014:930 with SMTP id zv3-20020a056a213a8300b001a180140930mr2430861pzb.57.1709897110943;
        Fri, 08 Mar 2024 03:25:10 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090311c700b001db608b54a9sm16049806plh.23.2024.03.08.03.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:25:10 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/2] annotate data-races around sysctl_tcp_wmem[0]
Date: Fri,  8 Mar 2024 19:25:02 +0800
Message-Id: <20240308112504.29099-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Adding simple READ_ONCE() can avoid reading the sysctl knob meanwhile
someone is trying to change it.

Jason Xing (2):
  mptcp: annotate a data-race around sysctl_tcp_wmem[0]
  tcp: annotate a data-race around sysctl_tcp_wmem[0]

 net/ipv4/tcp.c       | 2 +-
 net/mptcp/protocol.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.37.3


