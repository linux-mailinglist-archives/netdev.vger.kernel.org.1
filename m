Return-Path: <netdev+bounces-37075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E327B37D1
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 18:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 866A5B20B3A
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 16:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BF16588F;
	Fri, 29 Sep 2023 16:21:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AB1747B
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 16:21:32 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9421A4;
	Fri, 29 Sep 2023 09:21:30 -0700 (PDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1696004487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Pfy40HfW0rOpJbLp9/b9G4Tw0KUOebfRdechmC+0mdA=;
	b=wLXAzFm9DNE3IK001s6BGy7aX+uVYsoCxDrs2NGf9JxmjkU3JAP1YPr2HQNcV3oE0anECk
	LEJfB4+lBmB9VokpzPfSCqyiB9bJ76FKghCNOhWTzyqdFaX6FwwCRPmHFMJaiHoATUsmIa
	P/9tEcHa8m/ZVcQxcaLhrFkBTKDgc2r4iD2fBrVO/v2JYdMGqQTgP2zASBMK81mXuIAFTL
	8R0cMdOc6w4iAOGYS/gwm5OdzkfrNzCq8SQew54zkH6MHCorPBQcDjyqUiTwAE0REUD4xQ
	ExZPnP2VL9co2HGLiyEqtA3xe5eNsxVsbUnB6D57b8hvJSfTSaqml6/auWydfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1696004487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Pfy40HfW0rOpJbLp9/b9G4Tw0KUOebfRdechmC+0mdA=;
	b=PdNwR8qu/XS8Uos9j6mMejZBVzlKL4KAyye/CdS/ycC4jMGWhmF2WEMLYR9KjpqckLpHdq
	ve7nHhcR8TxoaWCw==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <hawk@kernel.org>
Subject: [PATCH net-next 0/2] net: Use SMP threads for backlog NAPI (or optional).
Date: Fri, 29 Sep 2023 18:20:18 +0200
Message-ID: <20230929162121.1822900-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The RPS code and "deferred skb free" both send IPI/ function call
to a remote CPU in which a softirq is raised. This leads to a warning on
PREEMPT_RT because raising softiqrs from function call led to undesired
behaviour in the past. I had duct tape in RT for the "deferred skb free"
and Wander Lairson Costa reported the RPS case.

Changes:
- RFC=E2=80=A6v1 https://lore.kernel.org/all/20230818092111.5d86e351@kernel=
.org

   - Patch #2 has been removed. Removing the warning is still an option.

   - There are two patches in the series:
     - Patch #1 always creates backlog threads
     - Patch #2 creates the backlog threads if requested at boot time,
       mandatory on PREEMPT_RT.
     So it is either or and I wanted to show how both look like.

   - The kernel test robot reported a performance regression with
     loopback (stress-ng --udp X --udp-ops Y) against the RFC version.
     The regression is now avoided by using local-NAPI if backlog
     processing is requested on the local CPU.

Sebastian


