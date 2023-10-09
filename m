Return-Path: <netdev+bounces-39146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8DE7BE379
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 16:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9C21C2093D
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA0E18C34;
	Mon,  9 Oct 2023 14:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hJ6zUXy9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1wVwgSze"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532E81FD8
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 14:49:01 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4F7AC;
	Mon,  9 Oct 2023 07:48:58 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1696862937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XGxzYbViuLT+KjbnCIr8b+GOy6d8U/BxcG6sWQXRcpQ=;
	b=hJ6zUXy9y3Uy8vXAPRTUbYIcxL4U8ppbEpeNWPjl/+fBMBbSyUldQoPVHkYlwznvj2f7aL
	Ci6aVT88LzPEsKicU3iZgPrjFBaW7+7yoEFF6eeNVWb6/CZD9230Z1EzMZ+zryQB+Z4DgO
	EeVZZ4x4D6clgFM3KSE53eV3DDe6huKwaz+rTQLb0Uvz+CriLRDtGeF/SV+jaE3jU4NXS/
	KHJBZXHPh8wleE7+dVDnx5MZZ2uJoU9yXU+oAW7wP/xAbTPed+c1QIs9Ht8uhGK9B/TYjG
	iSkxpWJoTcJbHrYJIi0f09Jkby0RWby80jYgM81QKjs1amBaUGYBSnKlEVtbbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1696862937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XGxzYbViuLT+KjbnCIr8b+GOy6d8U/BxcG6sWQXRcpQ=;
	b=1wVwgSzenBvoDOxvUMkRgbpNWU3QEC6JIfSpqjbdJQtHEeR1FobUXAvZnWAXFHgNzOVdcA
	1TNcijX6xKzK4AAw==
To: Richard Cochran <richardcochran@gmail.com>, John Stultz
 <jstultz@google.com>
Cc: =?utf-8?B?TWFoZXNoIEJhbmRld2FyICAgICAgICAgKOCkruCkueClh+CktiDgpKzgpII=?=
 =?utf-8?B?4KSh4KWH4KS14KS+?= <maheshb@google.com>, Netdev
 <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, David
 Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, Don Hatchett <hatch@google.com>, Yuliang Li
 <yuliangli@google.com>, Mahesh Bandewar <mahesh@bandewar.net>, Stephen
 Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/4] time: add ktime_get_cycles64() api
In-Reply-To: <ZRiP9mgFjLpKHj8N@hoboy.vegasvil.org>
References: <20230929023737.1610865-1-maheshb@google.com>
 <CANDhNCqb5JzEDOdAnocanR2KFbokrpMOL=iNwY3fTxcn_ftuZQ@mail.gmail.com>
 <CAF2d9jgeGLCzbFZhptGzpUnmMgLaRysyzBmpZ+dK4sxWdmR5ZQ@mail.gmail.com>
 <CANDhNCro+AQum3eSmKK5OTNik2E0cFxV_reCQg0+_uTubHaDsA@mail.gmail.com>
 <CANDhNCryn8TjJZRdCvVUj88pakHSUvtyN53byjmAcyowKj5mcA@mail.gmail.com>
 <ZRiP9mgFjLpKHj8N@hoboy.vegasvil.org>
Date: Mon, 09 Oct 2023 16:48:56 +0200
Message-ID: <87o7h7q2av.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 30 2023 at 14:15, Richard Cochran wrote:
> On Fri, Sep 29, 2023 at 12:06:46AM -0700, John Stultz wrote:
>> But I still think we should avoid exporting the raw cycle values
>> unless there is some extremely strong argument for it
>
> Looks like the argument was based on a misunderstanding of what
> CLOCK_MONOTONIC_RAW actually is.  So, please, let's not expose the raw
> cycle counter value.

Correct. Exposing the raw counter value is broken if the counter wraps
around on a regular base.

Thanks,

        tglx


