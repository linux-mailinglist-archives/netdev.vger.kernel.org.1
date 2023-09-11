Return-Path: <netdev+bounces-32841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD3A79A950
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 17:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7891C209C4
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 15:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B6511725;
	Mon, 11 Sep 2023 15:01:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9B71171B
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 15:01:50 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8A9125;
	Mon, 11 Sep 2023 08:01:49 -0700 (PDT)
Date: Mon, 11 Sep 2023 17:01:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694444507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmtb7inBfN9yXnfv6q7DROjKL4bqbMgCux9ZhSeiIQs=;
	b=DRVy5+d1O/qYZ/B9tsOCtlyHj9HMbQFTR0+QYAYk8xLu+TM98PycdU2p2De7DupP4HjoGc
	hqWLZHnWDatKHG77b/Ald3gip4AR5lTiMgA17mbPXe0NSVZWsQYkt8/n/GeLmJo8uHLXcI
	IQkxDcwn4AYO/OlU8ya/cq9BQZ5y3deQefiIVRnnw+eW+e8SXugVQVNPatYs0mCGdAspqA
	F7j1qUT3RucjjRBlumVudUtjTwXYnUnfx9SpkwKHyds/DhS88dhbyOLTI5Iln7Hf3TMnwp
	8y0jrJOGpm2jXzShu0elZYtUX4JR065tMSVUWJsyO8Sp1AExlf6mia7WW6Ra+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694444507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmtb7inBfN9yXnfv6q7DROjKL4bqbMgCux9ZhSeiIQs=;
	b=Z50ZZcZC0GsPfc1bExnGheRaWqEM9Hj5agGmTmwuv8gxhOuOkmYpSo5q2nOzpRFBDgMOkG
	tLptfM7GimhI0zCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
	davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kristian Overskeid <koverskeid@gmail.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Oetken <ennoerlangen@gmail.com>
Subject: Re: [PATCH] net: hsr : Provide fix for HSRv1 supervisor frames
 decoding
Message-ID: <20230911150144.cG1ZHTCC@linutronix.de>
References: <20230825153111.228768-1-lukma@denx.de>
 <20230905080614.ImjTS6iw@linutronix.de>
 <20230905115512.3ac6649c@wsk>
 <20230911165708.0bc32e3c@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230911165708.0bc32e3c@wsk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-09-11 16:57:08 [+0200], Lukasz Majewski wrote:
> Hi Sebastian,
Hi,

>=20
> Have you had time to review this patch?

got distracted a few times. I need a quiet moment=E2=80=A6 Will do this wee=
k=E2=80=A6

> Your comments are more than welcome.

Sebastian

