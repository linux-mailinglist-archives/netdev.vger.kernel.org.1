Return-Path: <netdev+bounces-34142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B777A2561
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 20:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98DD11C20A38
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 18:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7350F171B0;
	Fri, 15 Sep 2023 18:12:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F78A10786
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 18:12:49 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EAE1FCC
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 11:12:48 -0700 (PDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694801567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mli4CP9ZMN3P+hMBOQ7FuZMRGAWrBQOxg1SzmRO2Y8s=;
	b=Dz0l3vw8TPJq4MgYMwvjJUyRXYpz5tqXh8OFyCycpq8Cy8+LtsWiwUXK8rVPlALHmdJ0db
	bbJnOftwPfLlJq5b7Hj1KVwrUzMUqwTsnHWCmtuSlr+KnhbEoH2M6YOVvuurkSmtS9DmA3
	pHbZX+ZQCMxV0PD1WT6wzhHH0fSUi9KN6zgR2mlion6IM+UjnCthP9tey2S6+woG8UZy5X
	X9Nej9P0RkWxligyLJhc5iYk1QUIj5iXJcESiUUTci/ArjLTD6q2p6o+C7JMSzV6XrOtJr
	0KKAH8DWoUExNWJP0AlBpkbUhHsQ/wul78y8iW2feTs+mlajf5LRxipssq2KmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694801567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mli4CP9ZMN3P+hMBOQ7FuZMRGAWrBQOxg1SzmRO2Y8s=;
	b=+dERH4yq+iTG7YxPIAch1dlz+V+X5Ezqqakk+e/I+QLIvNJEWNIM/BB65nHgzgAJHp3WGA
	BkvI2KxPkcOYgSDw==
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Oetken <ennoerlangen@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Lukasz Majewski <lukma@denx.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH net 0/5] net: hsr: Properly parse HSRv1 supervisor frames.
Date: Fri, 15 Sep 2023 20:10:01 +0200
Message-Id: <20230915181006.2086061-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

this is a follow-up to
	https://lore.kernel.org/all/20230825153111.228768-1-lukma@denx.de/
replacing
	https://lore.kernel.org/all/20230914124731.1654059-1-lukma@denx.de/

by grabing/ adding tags and reposting with a commit message plus a
missing __packed to a struct (#2) plus extending the testsuite to sover
HSRv1 which is what broke here (#3-#5).

HSRv0 is (was) not affected.

Sebastian



