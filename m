Return-Path: <netdev+bounces-133965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CF899791B
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C10DB21201
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4EF1E3766;
	Wed,  9 Oct 2024 23:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EhSm/xbk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E775B169397
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 23:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516452; cv=none; b=PnZJ9svoUFNE8I+ErJrqjzXBO2W3BQifcilFeGdGfeYO9SVjd1p4YPvvYjVIqOCIeHt9KGnsuBW0O+Wdn3SZabZWrwZBkeGGKVIqL+rcSe/IIvQx6/AW2ZtJbK7e/aiz2sBo+OOdsR+AGbq7BISh1IBpjWm3mszvF/IbATRf9bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516452; c=relaxed/simple;
	bh=pgTGJGjRJjVgj18a+ornXfeF+vuc7WCVSZnklAHrNYg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aVJ+CGDYOYDEt45ABQ+RnT5hLG8CLvmLHstQN+8RPiYACePlX23Hlt7Os1a9Djfe2x1nI87EI4XsaqY0L6R9vVlWWhWDPsH4eQiosvH/09qckWiS1R7XXhcwPSP+md/vAd0QFl1OnBsAMuX7BXsra2pjK2vAAb2qyAGm+MgH7No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EhSm/xbk; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2904d0cad0so561291276.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 16:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728516450; x=1729121250; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oTsU2hCtTlTXdoYJitW/zCeWdAzq4YJVdz9vIFnp/vc=;
        b=EhSm/xbkOfPzAHXTfwrKiEUf0uORIx38kCxKjWLCe5PpV2qp/j4jgK2NYd9jH4H2qe
         Jqht29I9mXmwFjrbssdQ7n+jcoJCsc5YXku5w44QDqDaPcCespCfVXtCOZad1/joFdlT
         uZiw89c+EqhjP2mE49SjDCaAcKUjKjvJkSJRwsMe+7fKq81mvUpF5sS+pBYChonTogG5
         iclyCfYkH5BGt5BpILwn2ZjU8aa4LxsyUp0V52faocPl4m+Pgd/OgnLcElc/SmoUiy86
         U0b21kXHKPImYkJVJ8tP4Tt09xbzsAEqcRIPBoPkwecJx5ODTY1T2UqMEcTZfX1YRdR6
         XQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728516450; x=1729121250;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oTsU2hCtTlTXdoYJitW/zCeWdAzq4YJVdz9vIFnp/vc=;
        b=ABD4157Jm37jTLF66FfWWhgUWJWy6O5wnbjrJziO3ZxgSQO0Y5nmHLRi1jrRFc9yO3
         vI8+SmoeAzHMCQLmWUzALNiLmEEfpyj9v6Pdho3Dcy5aQHOcSOdp7TbEIzEtBMi6iRHE
         2Mya/pyYQq9Kpukm+ywJv/QIIMxIbWyNkli+ELrf9SVT21kM8X/zmRMDFQxIvX7NCWd5
         gFK3hFI64vRdR3GPw8MNfr6Mx1/wuO/oZAa6C7C14o0xkT6XZZr2H+Kd130VZZMxrAUH
         LY5LHpNtPqRqa88FHsNdMuDYFTW3XHDOt4UAsBC6YRLgQOEmW4gCBWJBp0MsGPD5O9bM
         7jfg==
X-Forwarded-Encrypted: i=1; AJvYcCV5dtRKb7sX6J5PbgjrHOgljILa//PJkjs8NCJBQdNTErbeC3etN0L8G23MKmBcZyZyj3vU7Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOJkBk8ZjHz50Jao02IK9m/Zayn7M9xWDJcs5Lio/4ZvgHtglO
	RYKXaLzyD/bHY0KrNDBqG3g82jhPgh+bG3lMiyBQIF9SxNbUlGoFOBLYnHDXGpGLZGOlOkF8FQA
	FDFvZFh2Nrw==
X-Google-Smtp-Source: AGHT+IFCO7U4xPA66xu2mO5OtAahMoBfvI1edv3/Zibf9R1wj+Ug34RZ4Si2ZZI8Mq0L7aOvF2tYs5J74NCztw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:6890:0:b0:e11:5f87:1e3c with SMTP id
 3f1490d57ef6-e28fe43c028mr21260276.11.1728516449581; Wed, 09 Oct 2024
 16:27:29 -0700 (PDT)
Date: Wed,  9 Oct 2024 23:27:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009232728.107604-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] net: do not rely on rtnl in netdev_nl_napi_get_xxx()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

With upcoming per netns RTNL, rtnl use in netdev_nl_napi_get_doit()
and netdev_nl_napi_get_dumpit() is a bit problematic.

They can be changed to only rely on RCU.

Eric Dumazet (2):
  netdev-genl: do not use rtnl in netdev_nl_napi_get_doit()
  netdev-genl: do not use rtnl in netdev_nl_napi_get_dumpit()

 include/linux/netdevice.h |  3 ++-
 net/core/dev.c            | 21 ++++++++++++---------
 net/core/netdev-genl.c    | 31 ++++++++++++++++---------------
 3 files changed, 30 insertions(+), 25 deletions(-)

-- 
2.47.0.rc0.187.ge670bccf7e-goog


