Return-Path: <netdev+bounces-226182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C36BB9D82D
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 08:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64FC91BC100A
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 06:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FA6287258;
	Thu, 25 Sep 2025 06:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyK1vMzp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B3B2367A8
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 06:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780131; cv=none; b=RvepxhdF2v7nBLHaGqcWQ+LzIHfcfc9W6gmW5Wwmu59hMsw4nVJxBiIdfNW000PLpN6WZQdLFBh9NppQ4lMR1ZEAAw1DDjP7mZgECyzI0fJF3k5AXhn0PXWGUVjigcKkdpWD1C2FgbI/W4yqWNCg2HwiUDKVReHAwKjiut8D2i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780131; c=relaxed/simple;
	bh=XlDTU9cabYuuxQxafZIKIPtRVQZSY1fOoKVSyjkTGGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teJsEoCK0vG9Da0NT+mblFJC9SyNsoBZeWgsTkeGLCy1PllRI4gPOIi2ZMe/nmSSTfwYdvEzrD7OQFuzVdPh3AoC/gbbingPH/ButV5hc6ZkUNrDuj4xfPWY4eWQbtmA8JtlOl5rSjMBzC1TuACxMZ1TEhtMbOrd9Uwv76aamTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyK1vMzp; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77e6495c999so727505b3a.3
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 23:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758780129; x=1759384929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fw6r/w0TQoLUu4aRi3OyGDu4XdJg1UR/ogba8tN6Kc0=;
        b=kyK1vMzpR5+F4U74ZF03o705JskvwfuFqa2y0x8rqXMzmmd1tThI2eSxll/dQCoYSV
         ud54eHb978mu6sobRXFYgmRhvWkP0UnVB7zwSvI59LMvgl4Ai7FRL8UwGnSED3rbnkiq
         pzjIJV8MilwgKfbEfcbWJPYwbIs1W2qSP9vRqeS1IT+PBNgVPYauN/FtLMcGNPVtUzEm
         Wdo8PcxgeI9YBT2+uEYU9Qo7nozGHXtSIPpM1L+x5531dbnmPVsXcHMr5l75aVWmVUfK
         tx0k96+9esTm1aseA96l9IVeynJnPrGI8stIlJMT+V8jWijD4x85nZtSR2l7thxTgSQU
         bktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758780129; x=1759384929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fw6r/w0TQoLUu4aRi3OyGDu4XdJg1UR/ogba8tN6Kc0=;
        b=Zsw+8LCYG/8HjIKsGxK2tzBrQ9f7CpTYddFLrcIb5rz7xlT35YI7krkmrtfO+O0kYR
         bNbEIlF8DXgdCwyqqXLWa0vraAPc0tlTy7XAOjd6966Ded2WWY2VXqTx9J8YZuHBZlyH
         H7pBtJVL+EJq131T6cW938CNdXJt/ByC8xKtrKsA5YpUYodpU6QgCpuU8KbQCGvzFMA0
         IyMre2LtaXqSoneayGM534U1+ZwkuE9hdrotzbKuAHuAP2PAYj/uM2j38NUgFplKE/nh
         2aYjJ61P3KlW1n0+R46RLVQE2l3PDdypPffiRKfDMomncnA7ttBGu7/EUgh2S8jZDPDY
         Wpvg==
X-Forwarded-Encrypted: i=1; AJvYcCWRypVBPD3qWVelqgDMzqFEOlSdzAtWLDYp54xsLDXN3vBf87laOSLi9mj/O+emnIV9FvJalvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzuIiGxwlAFVrvw20FbcThH37UggV0WeEP5OOfk7Yfy8yoEzVV
	HjNdIKSbg3zuIOM8SjsXbhuT984cSa6vtQnyrQBG8jZM8lM9caRqlLvJ
X-Gm-Gg: ASbGncsKI/o/XeKXedyWTgbQppmJ1U/shwYbgui+siFQdf6jLHJO0Sglf1Laeui9U7t
	il1V1LF6hWhzE+0eht4q7WtZ5d08xzfKJoWKaFNFr1iW7MdtdDxLnqo1gGrjuIdYaoXJ6ps3vcR
	EEL0/WoNuxkb+gJeefd47v2iLDaA4Mr0MjMI9c4wdJDPanVvceJVju4IdjtsO3kcz0uApJ+eee8
	GOa5RZdx+ea6vLcEu4bWZEWWV9BtM5PuCTBqu38X1Kkehdsg9KAHSd8LLPRh02GZ7nSQJct+3vk
	scm16ff5TMoCxA35DBkQcsKe2wDufN2IKvxbE/CVMUGUcpm152tLn8sC78Z57z8ISzTLDoQdn+/
	nWwm/b2UAfU08qcc+2mt3gdN4gLSmWBtdOxfTaxc=
X-Google-Smtp-Source: AGHT+IGxtpO8fYqBJ4Up101RNQSuSSRj8mAjj4mT1f+xp6lmruNG+NZqgd7e02/Tdm7NWnRO27FsQg==
X-Received: by 2002:a05:6a20:7349:b0:262:1ae0:1994 with SMTP id adf61e73a8af0-2e7d83ba73amr3173114637.42.1758780129245;
        Wed, 24 Sep 2025 23:02:09 -0700 (PDT)
Received: from cortexauth ([2401:4900:889b:7045:558:5033:2b7a:fd84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238b19dsm916334b3a.10.2025.09.24.23.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:02:08 -0700 (PDT)
From: Deepak Sharma <deepak.sharma.472935@gmail.com>
To: kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	david.hunter.linux@gmail.com,
	edumazet@google.com,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	michal.pecio@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	petkan@nucleusys.com,
	skhan@linuxfoundation.org,
	syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com,
	viswanathiyyappan@gmail.com
Subject: Re: [PATCH net v2] net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast
Date: Thu, 25 Sep 2025 11:29:46 +0530
Message-ID: <20250925055946.189027-1-deepak.sharma.472935@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923163727.5e97abdb@kernel.org>
References: <20250923163727.5e97abdb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jakub,

I found the topic very interesting. So I looked into the existing drivers and almost all of them seem to be using `usb_submit_urb`s except `lan78xx` and `smsc75xx`, which have a work item to do the configuration. But I see no synchronization between their work and the data that is used to do the configuration (which can involve multiple requests to the device). Is there any synchronization that I am missing here? 

Thanks,
Deepak Sharma

