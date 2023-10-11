Return-Path: <netdev+bounces-40164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4457C6058
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 00:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C121C209C4
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 22:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F82239C;
	Wed, 11 Oct 2023 22:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUf6SfDR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB15224A06
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 22:30:16 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C89D91
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:30:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4054f790190so4561375e9.2
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697063413; x=1697668213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAWLKbAErsoU3gtbFuREyPqPwphKHmZpTkIYqWwGlBI=;
        b=EUf6SfDRTzwf+D/lyLFk8xSjkySen9oqlsxEcLKgNiBjlQ7Pa9Nvbq5llfi7noYkpJ
         fbHk4YH/JdSwoBdpVeoeEjeBWgFIUO1ocmJ/CT2hL0b+WPHE3oErphBhnjQ3UxZKCgzm
         MSrgsLDnyH2kmLjNnlYac3f3PA+P380DBpNLZh5538RCkxMKovhe9Wqa+fJDnUsG86vT
         ihZgeUSo1Y30AVm8zr6g40GCFo7ttx0CvULYTGY1qDAxwkampwQa5G6xtvjcHRuXlPpV
         e800J19SC48I+OvQ/Rkx0I8sZP7aq58ww5eDrT8p3E78Ra4O3+DASGC/Bj+m5xk4beE8
         nVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697063413; x=1697668213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAWLKbAErsoU3gtbFuREyPqPwphKHmZpTkIYqWwGlBI=;
        b=Bk7BdX5HKxKb10bE/Pwz0CLxRL+uIrGLRSUfJRaAAzEWvABCJ7tkLOCbRoycR9AMt7
         QhYhOOfJsVy+TtaQWCAwI6tBO1r2kqP4cK0QA1gCl5FSV0gfDyZZP7ake/5q5dEY52d+
         JoP0XzA1Jsr7MXP7UroehuU38OG8QeKru/TeWcoByFvoaiDKSR68VP77f5ZoBxC4OOce
         kPVrgw0bZ2u6MUBruBstPdIJi0b9jalr6wn6iz87IRYVJyjdGi7tukgSGmP1Xnk61xcB
         stieVCV66FYC8ewfBnDHMjYB+y6TYkoOjvviFrXAY0qMJp5zu8AOTdA4RGMnxn4czR+F
         4WaA==
X-Gm-Message-State: AOJu0YwEYX6kvsdm/2dbwxGghya74bQfdxMs0fQepNrK2Os3KEZS4ODG
	I54cCvwnc+pmcVa3NgCFsQk=
X-Google-Smtp-Source: AGHT+IHoVVwqjl0g05zc9XXr8FBnsB8eKMz4P0uNc/YmQdTVrxHteURLKpgfmepgKPfW7ghS0oDB5g==
X-Received: by 2002:a5d:66c7:0:b0:316:fc63:dfed with SMTP id k7-20020a5d66c7000000b00316fc63dfedmr19341591wrw.39.1697063413313;
        Wed, 11 Oct 2023 15:30:13 -0700 (PDT)
Received: from reibax-minipc.lan ([2a0c:5a80:3e06:7600::978])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d43cf000000b003233b554e6esm16685335wrr.85.2023.10.11.15.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 15:30:12 -0700 (PDT)
From: Xabier Marquiegui <reibax@gmail.com>
To: richardcochran@gmail.com
Cc: chrony-dev@chrony.tuxfamily.org,
	davem@davemloft.net,
	horms@kernel.org,
	jstultz@google.com,
	mlichvar@redhat.com,
	netdev@vger.kernel.org,
	ntp-lists@mattcorallo.com,
	reibax@gmail.com,
	rrameshbabu@nvidia.com,
	shuah@kernel.org,
	tglx@linutronix.de,
	vinicius.gomes@intel.com
Subject: Re: [PATCH net-next v5 1/6] posix-clock: introduce posix_clock_context concept
Date: Thu, 12 Oct 2023 00:30:11 +0200
Message-Id: <20231011223011.4149-1-reibax@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ZSNfkkibqP2Q3Psh@hoboy.vegasvil.org>
References: <ZSNfkkibqP2Q3Psh@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Richard Cochran said:
> You are changing the functional interface, as needed, but I wonder
> whether drivers/ptp/ptp_chardev.c is the only driver that implements
> open/read/ioctl.
> 
> Did you audit the callers of posix_clock_register(), or maybe do a
> `make allyesconfig` ?

Yes, I have been searching for other drivers using that call, but I haven't
found any. I have also run compilations with allyesconfig in a couple of
build machines, and have seen no errors thrown by the compiler.

