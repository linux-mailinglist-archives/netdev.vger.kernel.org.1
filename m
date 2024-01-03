Return-Path: <netdev+bounces-61130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475E5822A7D
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 10:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8E81C23241
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 09:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8637A18626;
	Wed,  3 Jan 2024 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="iJKvm4Il"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f100.google.com (mail-wm1-f100.google.com [209.85.128.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042AD18B08
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f100.google.com with SMTP id 5b1f17b1804b1-40d4a222818so1483245e9.0
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 01:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1704275331; x=1704880131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mWYozj8NoaaSVO5dzw8uHWhq3syxqXeQNBskChBBlHY=;
        b=iJKvm4Iln4tKJF4JcnpilBnLIUnkNugTI02T+aJ9bHmWaO1Sq3EBMteoWhehNrfKCX
         xHOrCoVA78vKZoWMvI55F5yjPZKpqGJhBClVZMDvHnDEn1tcL+gRIML4zACctjkOgg0b
         eZT6ZnLpmx432tOvsMzckUEir3tKg3L6R2pMQj6aTlcsTvX11Y+khoW15lVdtwQzAGhJ
         7G0RPMYKTDET55c0tXobkL2lFjnAS0wLAxvCpho76jysWTkomCqmt5W1U0NaXiLrPoWm
         Xk3hixmFkIQzo7mD58L8EItPj3EfWzmupWq3dXMGa+vuat9if3muxDwiYR9r1Ut2wyWM
         7zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704275331; x=1704880131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWYozj8NoaaSVO5dzw8uHWhq3syxqXeQNBskChBBlHY=;
        b=EAjSv40Zhygm+nYdO5ZMaJplZiyTCKQrJB/k+7DkO5WbIb2WM1jVuTE62S97y+2w5m
         CgTfB2RUNQZBQncI+EWOYFAoi0WCO2UFjm4PvDui4tEBRmB3r3pQHjFbJBv84+T5cl26
         o9BhDoupkWjIW5Um/LJZzhgHRT/185oTWUFX/QTFHe/pDB8FNfrXiw8V66ZYyLxkQS+d
         QB6yA63+bJRetjHzJXHsA1/gov1tu9Wf9BPvC/whZJvi+gjwaeWI/J67yyMGRYZdDUSs
         tYquSfLBHRM9feJpB9jZYru8diC1aB9qL2ChbHz552Id20KW2V9vfMsElaKEJl3ZPMBO
         +haQ==
X-Gm-Message-State: AOJu0YzifBwdcxw8W+rwucXR3bzD+ZGnGk6bx06AAe0KY84+G5+zsMvF
	/mZtAOaLGsxoweeWuSeagFgHz1m0QsQo0irxk9Ge1CIlj239XY09wNoAZQ==
X-Google-Smtp-Source: AGHT+IE1U/AjWaTY3O3iefru3+yX8WgG/W3v+vJ6Igb7BY9qELw2MX7QRKCHf8tJh9wT9GPxcQ7nk4tmPyb4
X-Received: by 2002:a05:600c:4444:b0:40d:888e:34bb with SMTP id v4-20020a05600c444400b0040d888e34bbmr380394wmn.10.1704275331201;
        Wed, 03 Jan 2024 01:48:51 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id r7-20020a05600c458700b0040d83df3189sm35360wmo.40.2024.01.03.01.48.51;
        Wed, 03 Jan 2024 01:48:51 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id E8458602FD;
	Wed,  3 Jan 2024 10:48:50 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1rKxrm-00A3cn-LA; Wed, 03 Jan 2024 10:48:50 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Phil Sutter <phil@nwl.cc>,
	David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org
Subject: [PATCH net v2 0/2] rtnetlink: allow to enslave with one msg an up interface
Date: Wed,  3 Jan 2024 10:48:44 +0100
Message-Id: <20240103094846.2397083-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch fixes a regression introduced in linux v6.1. The second
patch adds some tests to verify this API.

v1 -> v2:
 - add the #2 patch

 net/core/rtnetlink.c                     |  8 +++++++
 tools/testing/selftests/net/rtnetlink.sh | 39 ++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

Regards,
Nicolas


