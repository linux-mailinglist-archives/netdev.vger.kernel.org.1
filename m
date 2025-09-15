Return-Path: <netdev+bounces-223229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765B4B58742
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4914C4487
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 22:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABFE2C0285;
	Mon, 15 Sep 2025 22:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="sUpTjn5O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA62523957D
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 22:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757974494; cv=none; b=cOZKjCImyiLHdYqQckDxvuqfZTUm31H9lXrN+K8nV1ddJLPWjSX5nLySQHK1od451HzIPJjO0Oy3ma28r8fyDNfz/T2iNHHBDgopbjBb6GMApBKvHEvH4fI9hNp02ZtfSPIDFkO295Ojs9eYZn3b3hF8og1aprHKgovfYI3x2sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757974494; c=relaxed/simple;
	bh=WMfVJAH35ejDvzEqyox5w+jzPDgfrRaXulsQeZMNTek=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=ez9Rk4lTrnIh9BuqXDShvaP0F+A9/erLw84BsLALnNopF7863mD616wwjv01X9ySDdTpSFRMpeqmm4XkoWsged6NLn037XYLeQfw4XtGxZqc08gDQ8WEN2fxL/i6a3f3xARaLW1Zf7RhVgUk70HHuvjfU3P6ScS1jwkO6Q10WYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=sUpTjn5O; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from famine.localdomain (unknown [50.35.97.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 364953F7C0;
	Mon, 15 Sep 2025 22:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1757974483;
	bh=5lYp7gcNzUtZKs1Ue4wh5p1hwSW4oe5/RnQqQo5Ok4g=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=sUpTjn5OFMdz2Sq2r7z9duYIsbRtEYvVyDggUHUrZQ/7I/zUwlXKoVaqT8Kfza6H8
	 QcxHPTPFdfgWd2nZ1x1aKOoatJhSikXAR4FTDMKzDyCigrxR7EVpZ2mLr4eWsOlxSr
	 SqlKetAa8QKV5xlCkpEbGsb1WWFSeXYSQ4MjlmnCRG472sDbIkyzgMhpsssvviKtOT
	 6uYvykBuTKBjCQPQiYntsnXIHN9ALkB1AtGif16fFOqfit0eqoQ85EKrhQs7chR/qr
	 ef1andKcVkQBoCxR9l68IvrqXt34O3I/jisQ5X/a4ZXbALibtk67emdeEJSs/tEyLv
	 N/3sjJrxgqxwg==
Received: by famine.localdomain (Postfix, from userid 1000)
	id EC9739FC97; Mon, 15 Sep 2025 15:14:41 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id E9B019FC6F;
	Mon, 15 Sep 2025 15:14:41 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Victor Nogueira <victor@mojatatu.com>
cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
    kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] selftests/tc-testing: Adapt tc police action
 tests for Gb rounding changes
In-reply-to: <20250912154616.67489-1-victor@mojatatu.com>
References: <20250912154616.67489-1-victor@mojatatu.com>
Comments: In-reply-to Victor Nogueira <victor@mojatatu.com>
   message dated "Fri, 12 Sep 2025 12:46:16 -0300."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3365173.1757974481.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Sep 2025 15:14:41 -0700
Message-ID: <3365174.1757974481@famine>

Victor Nogueira <victor@mojatatu.com> wrote:

>For the tc police action, iproute2 rounds up mtu and burst sizes to a
>higher order representation. For example, if the user specifies the defau=
lt
>mtu for a police action instance (4294967295 bytes), iproute2 will output
>it as 4096Mb when this action instance is dumped. After Jay's changes [1]=
,
>iproute2 will round up to Gb, so 4096Mb becomes 4Gb. With that in mind,
>fix police's tc test output so that it works both with the current
>iproute2 version and Jay's.
>
>[1] https://lore.kernel.org/netdev/20250907014216.2691844-1-jay.vosburgh@=
canonical.com/
>
>Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Reviewed-by: Jay Vosburgh <jay.vosburgh@canonical.com>


>---
> tools/testing/selftests/tc-testing/tc-tests/actions/police.json | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/police.j=
son b/tools/testing/selftests/tc-testing/tc-tests/actions/police.json
>index 5596f4df0e9f..b2cc6ea74450 100644
>--- a/tools/testing/selftests/tc-testing/tc-tests/actions/police.json
>+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/police.json
>@@ -879,7 +879,7 @@
>         "cmdUnderTest": "$TC actions add action police pkts_rate 1000 pk=
ts_burst 200 index 1",
>         "expExitCode": "0",
>         "verifyCmd": "$TC actions ls action police",
>-        "matchPattern": "action order [0-9]*:  police 0x1 rate 0bit burs=
t 0b mtu 4096Mb pkts_rate 1000 pkts_burst 200",
>+        "matchPattern": "action order [0-9]*:  police 0x1 rate 0bit burs=
t 0b mtu (4Gb|4096Mb) pkts_rate 1000 pkts_burst 200",
>         "matchCount": "1",
>         "teardown": [
>             "$TC actions flush action police"
>-- =

>2.51.0
>

