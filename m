Return-Path: <netdev+bounces-27282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC1277B588
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 11:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C82D1C20A20
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 09:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FDEAD25;
	Mon, 14 Aug 2023 09:35:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A7FA958
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 09:35:39 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC105E6D;
	Mon, 14 Aug 2023 02:35:38 -0700 (PDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1692005737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wDVW2X/kzPPFWaFpw2MsMXWR8jxN0En7pupo5Sq/sCs=;
	b=v4oi/bJNr777l1WZGazzKyS4YU/tLHmCNHUUWG5GKUP7a0y5oYCN8BZTdmJnAC/+MoVXk8
	W2RM1sr2+nK5i9mMuwn4b4RElQXm3Nkt78oBS40KozHsRA+w13gb8oVDc7/j+fjTWJUP7i
	XoRzXxuLMFIAqankKl5NBN+ThAT8nojl/8F90mg1vF5pPLjtFQBhaGZE8GgpDZXUqksjHx
	RHBlcEwyv+AE71uEPmquDjcb2YhdvMMkVhiRuS9yOa0NkyLU9zMqadthwat9FLJhRkkVSk
	9MKbjJ74Wf4/0mGUD8Jps0a0XXkBg6ojNeSEfIM6YCpw7M6M0GpI5rYynMXz7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1692005737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wDVW2X/kzPPFWaFpw2MsMXWR8jxN0En7pupo5Sq/sCs=;
	b=FM6XuTaHslfIdVrKbJ9OGlS3tvk3rWm8nv03Z6U3MYcwvUG/oBoQ3R7Zy+tmfeo5eF2I2T
	gSSVsw3nFfHFFiBA==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>
Subject: [RFC PATCH net-next 0/2] net: Use SMP threads for backlog NAPI.
Date: Mon, 14 Aug 2023 11:35:26 +0200
Message-Id: <20230814093528.117342-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The RPS code and "deferred skb free" both send IPI/ function call
to a remote CPU in which a softirq is raised. This leads to a warning on
PREEMPT_RT because raising softiqrs from function call led to undesired
behaviour in the past. I had duct tape in RT for the "deferred skb free"
and Wander Lairson Costa reported the RPS case.

Patch #1 creates per-CPU threads for the backlog NAPI. It follows the
	 threaded NAPI model and solves the issue and simplifies the
         code.
Patch #2 gets rid of the warning. Since the ksoftirqd changes the
         situtation isn't as bad as it was. Still, it would be better to
	 keep it in the context where it originated.

Sebastian



