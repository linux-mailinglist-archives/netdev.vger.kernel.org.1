Return-Path: <netdev+bounces-32005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3B97920EE
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 10:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12091C204E8
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 08:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDDE20EC;
	Tue,  5 Sep 2023 08:06:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021B11FA4
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 08:06:20 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79703100;
	Tue,  5 Sep 2023 01:06:18 -0700 (PDT)
Date: Tue, 5 Sep 2023 10:06:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1693901176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsH+RtpEg9vwuvIPoOMrUZaAm44ymKYNQDqVuCFwR1E=;
	b=uKTJOBK+OTlCoN+U1ji+35EqoHQ8iKidB5lZ6fHgexkjUhNj9bpybKUJMOBEkk8oIoz6l+
	6w6/2A5rqUXvVJfAlJ+QMfaujUNgS214vSw/gRJxS7pMmJUXUy4tk8bP2mkEgxlxm7p9QI
	g1Hm6pIvWUDsZs73kltrdp+d4XunCZVTbA6EOG87zmOfCL+HsaF5yysX30PApn7zwFlymu
	XHS2zXCfo2k7qbe91jHJqij//h+0RFYXYTaruOGUshPe0coGK9QZLTFSQwczA6Tn1um+7G
	lsQFDI+6CEK6oDZQBQnpjABtnaDQ5yuQpJalakzCZ7SmnNhFpxRgrmGIH+8Wng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1693901176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsH+RtpEg9vwuvIPoOMrUZaAm44ymKYNQDqVuCFwR1E=;
	b=oA1okqf9iAhC+/eLtGjdE0wtJjEtyhD8/x1KbNdZJhNq070aOCj91JOMYfEy2iy1hKmVdn
	U+grph8F1+OgPUDw==
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
Message-ID: <20230905080614.ImjTS6iw@linutronix.de>
References: <20230825153111.228768-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230825153111.228768-1-lukma@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-08-25 17:31:11 [+0200], Lukasz Majewski wrote:
> Provide fix to decode correctly supervisory frames when HSRv1 version of
> the HSR protocol is used.
>=20
> Without this patch console is polluted with:
> ksz-switch spi1.0 lan1: hsr_addr_subst_dest: Unknown node
>=20
> as a result of destination node's A MAC address equals to:
> 00:00:00:00:00:00.
>=20
> cat /sys/kernel/debug/hsr/hsr0/node_table
> Node Table entries for (HSR) device
> MAC-Address-A,    MAC-Address-B,    time_in[A], time_in[B], Address-B
> 00:00:00:00:00:00 00:10:a1:94:77:30      400bf,       399c,	        0
>=20
> It was caused by wrong frames decoding in the hsr_handle_sup_frame().
>=20
> As the supervisor frame is encapsulated in HSRv1 frame:
>=20
> SKB_I100000000: 01 15 4e 00 01 2d 00 10 a1 94 77 30 89 2f 00 34
> SKB_I100000010: 02 59 88 fb 00 01 84 15 17 06 00 10 a1 94 77 30
> SKB_I100000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> SKB_I100000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> SKB_I100000040: 00 00
>=20
> The code had to be adjusted accordingly and the MAC-Address-A now
> has the proper address (the MAC-Address-B now has all 0's).

Was this broken by commit
	eafaa88b3eb7f ("net: hsr: Add support for redbox supervision frames")

? Is this frame somehow special? I don't remember this=E2=80=A6

> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Sebastian

