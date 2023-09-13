Return-Path: <netdev+bounces-33661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A892479F121
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 20:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566E8281B16
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 18:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7D61F189;
	Wed, 13 Sep 2023 18:30:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC3322EE9
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 18:30:58 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DCA19BF;
	Wed, 13 Sep 2023 11:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=IJ+IPG3d6qkD3+9GaJ4MRfL8Bjm3vd1KfLMNYh2K40w=;
	t=1694629857; x=1695839457; b=Eg4LUvrLWCj4qI9WDW9NO5ei2e2JWF0QcT2HD1IzqqoUycv
	Z6x21MlZuj4qGXZHng0VgNrvZDiMlpmG8+/M0fmateRsZWE8mu9/LghwILkySP9FQ5ANQQlq870lZ
	8ispznbqZeFKiaVewOdVIgaAP552AkAO21MHNRvwlulzx/4pwFJTuRpRQnt7f4GaPTaVmqivd3EY+
	qZm/a90cVxXVeAXNxdcVkJdHVINlwOAYQzqGgemGZM7RSJ8HUMp2tbiHMrVfpIveBmFk/yKjHcWNz
	guFrjuNV5e5lbt5siZCRqx+iWgWQwBvFYdTQV9FiXs0hm8oy/FWaBZRUF/mVtR2g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qgUdK-00FGcl-2j;
	Wed, 13 Sep 2023 20:30:39 +0200
Message-ID: <30f87339d12e258f2d8ad44b1e59fc8acff1a5f5.camel@sipsolutions.net>
Subject: Re: [PATCH v3] workqueue: don't skip lockdep work dependency in
 cancel_work_sync()
From: Johannes Berg <johannes@sipsolutions.net>
To: Florian Fainelli <f.fainelli@gmail.com>, Guenter Roeck
 <linux@roeck-us.net>,  Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Heyi Guo <guoheyi@linux.alibaba.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Tejun Heo <tj@kernel.org>, Hillf
 Danton <hdanton@sina.com>, LKML <linux-kernel@vger.kernel.org>,
 netdev@vger.kernel.org
Date: Wed, 13 Sep 2023 20:30:37 +0200
In-Reply-To: <ebf7bce8-0856-2a07-0d29-edbcd1b76942@gmail.com>
References: <21b9c1ac-64b7-7f4b-1e62-bf2f021fffcd@I-love.SAKURA.ne.jp>
	 <YuK78Jiy12BJG/Tp@slm.duckdns.org>
	 <0ad532b2-df5f-331a-ae7f-21460fc62fe2@I-love.SAKURA.ne.jp>
	 <97cbf8a9-d5e1-376f-6a49-3474871ea6b4@I-love.SAKURA.ne.jp>
	 <afa1ac2c-a023-a91e-e596-60931b38247e@I-love.SAKURA.ne.jp>
	 <7d034f7b-af42-4dbc-0887-60f4bdb3dcca@I-love.SAKURA.ne.jp>
	 <0a85696a-b0b9-0f4a-7c00-cd89edc9304c@I-love.SAKURA.ne.jp>
	 <77d47eed-6a22-7e81-59de-4d45852ca4de@I-love.SAKURA.ne.jp>
	 <e0717628-e436-4091-8b2e-2f4dcb646ec8@roeck-us.net>
	 <6b1c6996da5d215371e164b54e8854541dee0ded.camel@sipsolutions.net>
	 <a50218b6-fc42-7f12-155a-5e01fc8dd1a0@roeck-us.net>
	 <ebf7bce8-0856-2a07-0d29-edbcd1b76942@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2023-09-13 at 10:25 -0700, Florian Fainelli wrote:
>=20
> I would refrain from reverting without giving a fighting chance to the=
=20
> author to address it. It seems a bit strange that we do this locking=20
> dance while it might have been simpler to introduce a=20
> ftgmac100_reset_unlocked() and ftgmac100_reset() and call both at the=20
> intended places, something like the completely untested patch attached=
=20
> maybe?

Not sure that's right - it probably wants RTNL for some reason, but with
this patch you don't hold it when coming from ftgmac100_adjust_link()?
(If it did, it'd have deadlocked getting here after all, since it
acquires it)

Not sure why it needs RTNL though, that doesn't seem so bad, and holds
some internal locks. Or maybe it doesn't really, only if there's a
phydev and/or mii_bus, so maybe it needs a driver lock? Well, there's a
note about the reset task, that might be it?

static int ftgmac100_stop(struct net_device *netdev)
{
        struct ftgmac100 *priv =3D netdev_priv(netdev);

        /* Note about the reset task: We are called with the rtnl lock
         * held, so we are synchronized against the core of the reset
         * task. We must not try to synchronously cancel it otherwise
         * we can deadlock. But since it will test for netif_running()
         * which has already been cleared by the net core, we don't
         * anything special to do.
         */



But it really kind of feels the locking model in this driver is a bit
off.

johannes

