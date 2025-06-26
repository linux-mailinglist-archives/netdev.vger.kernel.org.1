Return-Path: <netdev+bounces-201633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3AAAEA283
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 17:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F324A176D49
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D812EAD1A;
	Thu, 26 Jun 2025 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkuIVDDm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD0018DB1F
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951821; cv=none; b=OoRRT8VARVStP2ptuZfPCp57AjEUtQZqggjh+wJGy07+/IJcR4HlCzCef4g0k4iWPH0GZZcJy5sfy6G9KgQA9cLgpLfwUEUxIf2V4k6NB+/ZDYhIoO0tQC6+SwUuEYK8Q6pDscp5E7eqLx1O6+266YaZzjhVZXHWMwRh+k4OIiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951821; c=relaxed/simple;
	bh=OKfocqw76txjVHBOQafQpZqlGmIfcR4scUVE3mjGGGU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dKloY0qWiJoBZ5aXrnlgGdrfU4OhxEyD91mVoXlOcM1HzjJ0PCP+qn0d6RF/xCW6lCrusv9ZyGqzYMiVU5eQREHc8x8uZ9/1l1Lr4LSXlGUf8GPmT0xlsi7hfu2GbEF72FrIqM7FSWLE0aofnG4o7Izu3ySKOl9dIc2+rP4goTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rkuIVDDm; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6fac45de153so17884146d6.2
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 08:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750951819; x=1751556619; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pOX56LmrjKCX6P1rybU4RMhWbPBhuVUGHtn1zX6H0+I=;
        b=rkuIVDDmaDptysIKkAK5M9ViLbRDYDaYmw7TE8nIPyGJLm/jtapQXCfKQHrDHKENaN
         CyAkW2DwXN9moVaTmlUjWa4nG0o1HoCBQpb/EP8YiFVRSdoHU4YjrsaYax2/020FHjMT
         9Vy7Vvkus7bWlrzx/duEeLfP7lSY/trlClcHJSbNgWbhsj1s6OH7NiyStuLV6rx7IMs2
         RZtZ15Qt+HzrilGqRTGJ+XmFh1KoR4hAJa/MYzAY0ILc3g+Xu0V0AIftEyr/uGCjkG5R
         3Btsbi81/Jg+mMvNgx9UoDADB9AF0SX7dZgyqSFYmA2p888/wXlg6E6vIQ9yrVDrFKoR
         GQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951819; x=1751556619;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pOX56LmrjKCX6P1rybU4RMhWbPBhuVUGHtn1zX6H0+I=;
        b=JvZ8A6nkagii3hLx+fXrAx6mvJDd3yQEfw0HRd2GiiA7qXGwPPxllyLD6cIhajT8Cr
         ZFVWDKdwhOGhOEt7bdVMEjO+ekSgKlJ/Hy/y70/Sxzgxmssfw+4u24X9G+bOm0e1zjcO
         d0tnNuvYkMkDfHHLlwHM8vFo5E6ZFIjEaAVzUyxe1glvsIM8QDR7lz7igD9gmmCvIRIr
         n7GGq6/gNb7aulL6D0NHyjBs4ZepCCrj1oLb8m7n90hbs8aNwlP9QGUDqaXGVgXcbgbp
         Ut+coT8A2/2+ylp9iU+iXCWPimJYAnTF2TN5kSal667u+Q2eTgv+ZXShlZ6rT2WJqNVg
         J2DA==
X-Forwarded-Encrypted: i=1; AJvYcCVaCjTqPI+Z76bJ2iRZj2XaCTPv5koA9vyjK0JArAC3x5QZ8RsuR0dOUxxZVei/1Wvk+fJ/fi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw51aJa1PxwSCd2WKLzNYB6xD0h8jUsbBZ17wxBjvFabxMI9K+Q
	fQxl1yJxPCgpGu9RU2Yj2JC3thpjUQWLnYSe67p3iAPNI40sqGmi7lV4JOJIBAsBKm4kU1l+Amg
	EAeOnsYMd0TWukg==
X-Google-Smtp-Source: AGHT+IH0qowhoWk4BWKCw150BMnBewfj+t1cP83PWgUBGRV0RFjX+fxewbMZprUvg7h6NLV61S/ShvqzBEcW6g==
X-Received: from qva5.prod.google.com ([2002:a05:6214:8005:b0:6fb:5153:8a17])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:230b:b0:6e8:fbb7:6764 with SMTP id 6a1803df08f44-6ffb417512bmr3792956d6.45.1750951819071;
 Thu, 26 Jun 2025 08:30:19 -0700 (PDT)
Date: Thu, 26 Jun 2025 15:30:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626153017.2156274-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] tcp: remove rtx_syn_ack and inet_rtx_syn_ack()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

After DCCP removal, we can cleanup SYNACK retransmits a bit.

Eric Dumazet (2):
  tcp: remove rtx_syn_ack field
  tcp: remove inet_rtx_syn_ack()

 include/net/request_sock.h      |  4 ----
 net/ipv4/inet_connection_sock.c | 11 +----------
 net/ipv4/tcp_ipv4.c             |  1 -
 net/ipv4/tcp_minisocks.c        |  2 +-
 net/ipv4/tcp_output.c           |  1 +
 net/ipv4/tcp_timer.c            |  2 +-
 net/ipv6/tcp_ipv6.c             |  1 -
 7 files changed, 4 insertions(+), 18 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


