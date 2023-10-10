Return-Path: <netdev+bounces-39537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB297BFAD1
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 14:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E611C20B08
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 12:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC1F1945E;
	Tue, 10 Oct 2023 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ktRiMsBy"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ED4524F
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 12:09:32 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ECAAF
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 05:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5XQTdJjlD+a1vCHi9nLi8eAT2myYJSn9F7XOgWNU1r0=;
	t=1696939770; x=1698149370; b=ktRiMsByHBO8HSDx2LC8zv8ZZnTQYuzEsj6e8m6IrxmhslA
	EikY9eDoskypXX/u30T3kUUAsgzujb9+WyZZSHAuaUz9gxexaQ6GQBeQtV9XJ+3Sf/LDX/A9dnNen
	wJR6UbTVxshHlokrgKVmmKo4+ltRhRsGjyp9uj1fygE1mnFy+f4oE8B4flMvrgHgEcyH80TTMS8JP
	gzytW672DikhR8eFAB+iuzjOydOLwhTCaPRvTtl2eADZPZYhC06nJOzEqD6waqSMyT/1Eeqtp+SmI
	0Uuq8Zuo2H2dHn4xy0NovsvIOGh3xHsom0sS05VwOjnBbpJQoVT8e4UQzyePwUqw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qqBYF-00000000MBX-2bh0;
	Tue, 10 Oct 2023 14:09:28 +0200
Message-ID: <a2709c29a30e7f80ed37e29dc40d51a067963e39.camel@sipsolutions.net>
Subject: Re: [patch net-next 01/10] genetlink: don't merge dumpit split op
 for different cmds into single iter
From: Johannes Berg <johannes@sipsolutions.net>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com
Date: Tue, 10 Oct 2023 14:09:26 +0200
In-Reply-To: <ZSU4DExDGm3M9dLY@nanopsycho>
References: <20231010110828.200709-1-jiri@resnulli.us>
	 <20231010110828.200709-2-jiri@resnulli.us>
	 <25c23d3482cb2747ee386543dce53cf212c899c3.camel@sipsolutions.net>
	 <ZSU4DExDGm3M9dLY@nanopsycho>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-10-10 at 13:39 +0200, Jiri Pirko wrote:
> Apply this patchset w/o this patch and you'll hit it :) Otherwise I
> would not care...

:)

> The problem is dumpit op of cmd Y with previous doit op of cmd X. They
> should not be merged, they are not same cmd, yet existing code does
> that.

Yeah, on second thought, you're right, if you have CMDs X < Y and then

 X/do
 Y/dump

(and no X/dump, nor Y/do) then indeed this can happen.

Sorry for the noise.

johannes


