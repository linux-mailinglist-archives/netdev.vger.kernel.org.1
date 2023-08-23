Return-Path: <netdev+bounces-29890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4681E7850F6
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 08:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E48B281245
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 06:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680E579E6;
	Wed, 23 Aug 2023 06:57:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF4620EE3
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 06:57:31 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8171CDD;
	Tue, 22 Aug 2023 23:57:29 -0700 (PDT)
Date: Wed, 23 Aug 2023 08:57:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1692773847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rwENDnUXusXaGXwfjjp9jYNee0+I/s+o/pwpgVQnDFc=;
	b=OJAMPZR6BqAi/T+N2Lc0k4RlOALHfOAbheDBp6DUFx1LOxs1lxAcPNNlT+W4+NsAXlOhz9
	Kz+ypRFKDHo2SkW5tN+v3TtKrYZt8cYRCkvHvgOgBK7rLBjKwm7S2VYnwDR+VapoVxet6m
	WXfo9K2ksVFym2R1Xb5R/F7kDBN+D/5UG3ww3GU6YNZN6KWz36O28sXkfmRShrZHy75Hc1
	ukbx9Cq+6zEbp+F9QGAb7CY/xztU+HpUKt3pOAlnjt5n1VXB2bps5J3MKMGx6uNsafzNEN
	tAEuZT/Ilkv6K54KXGcghVut4sqjv2r82TkbExhEkL/Zr1e7fFyqomtVPL5k8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1692773847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rwENDnUXusXaGXwfjjp9jYNee0+I/s+o/pwpgVQnDFc=;
	b=TV8+HqieS09mM7rvwiz3Kr2oZ3ZrGuVO+nmucIz7SQyxdwXEbqWOsHQpodDBUwR6Py3Y3Z
	wjU3csylDi5l4fBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yan Zhai <yan@cloudflare.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [RFC PATCH net-next 0/2] net: Use SMP threads for backlog NAPI.
Message-ID: <20230823065723.AsI2jjKp@linutronix.de>
References: <20230814093528.117342-1-bigeasy@linutronix.de>
 <20230814112421.5a2fa4f6@kernel.org>
 <20230817131612.M_wwTr7m@linutronix.de>
 <CAO3-Pbo7q6Y-xzP=3f58Y3MyWT2Vruy6UhKiam2=mAKArxgMag@mail.gmail.com>
 <20230818145734.OgLYhPh1@linutronix.de>
 <20230818092111.5d86e351@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230818092111.5d86e351@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-08-18 09:21:11 [-0700], Jakub Kicinski wrote:
> As tempting as code removal would be, we can still try to explore the
> option of letting backlog processing run in threads - as an opt-in on
> normal kernels and force it on RT?
> 
> But it would be good to wait ~2 weeks before moving forward, if you
> don't mind, various core folks keep taking vacations..

No problem.  Let me repost it then in two weeks as optional and not
mandatory.

Sebastian

