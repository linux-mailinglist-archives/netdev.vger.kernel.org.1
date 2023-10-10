Return-Path: <netdev+bounces-39531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BCF7BF99C
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E842C281E44
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C4618C0E;
	Tue, 10 Oct 2023 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oP8iLKad"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6811F182A7
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 11:24:39 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA590A4
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4f1mrZoH7kSpxZXRX7tn76JIkjc756mS8J/oQCNgN7Q=;
	t=1696937075; x=1698146675; b=oP8iLKadxbVQQhUjflkzCq4tlbWtZEVS6Z/IZnfrKCwKlGs
	FwdR/MVV6KCke8FDHN7h2uCdu+HRP9ol/HIfL3ENmXNPTp+R+ewuro9kfBbMc0GNXHAuvgMiR4KPl
	rpROxDOi1GBvujT+I86ub+ONO7UM/USH917K2sJROZRfFd7aTmQPl9ya0ZYYjb5/UvL5nalLJXfW9
	TblOi1hAxn8VYa0pG4M98dYP/QhtKvmN6en7lfE7/xePjBQ+pqvJz0fsp1Zfbpb2P4M4aCnuMH3FO
	PeMDAI4h/gMLFxO6EAgIpeuvNnUzvNsavWgksLUf7aFkVHUu3xMA2GgtsG+UJfnw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qqAqm-00000000JKW-1j1e;
	Tue, 10 Oct 2023 13:24:32 +0200
Message-ID: <25c23d3482cb2747ee386543dce53cf212c899c3.camel@sipsolutions.net>
Subject: Re: [patch net-next 01/10] genetlink: don't merge dumpit split op
 for different cmds into single iter
From: Johannes Berg <johannes@sipsolutions.net>
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com,  jacob.e.keller@intel.com
Date: Tue, 10 Oct 2023 13:24:31 +0200
In-Reply-To: <20231010110828.200709-2-jiri@resnulli.us>
References: <20231010110828.200709-1-jiri@resnulli.us>
	 <20231010110828.200709-2-jiri@resnulli.us>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-10-10 at 13:08 +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
>=20
> Currently, split ops of doit and dumpit are merged into a single iter
> item when they are subsequent. However, there is no guarantee that the
> dumpit op is for the same cmd as doit op.
>=20
> Fix this by checking if cmd is the same for both.

It's confusing, but I don't think this is needed, I believe
genl_validate_ops() ensures that do comes before dump, and the commands
are sorted, so that you cannot end up in this situation?

And even if you can end up in this situation, I don't think this patch
is the correct way to address it - we should then improve the validation
in genl_validate_ops() instead.

(And maybe add a comment here, but ...)

johannes


