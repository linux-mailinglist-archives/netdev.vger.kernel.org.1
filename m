Return-Path: <netdev+bounces-177512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0817CA706A1
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32BB83A57BB
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5D4191493;
	Tue, 25 Mar 2025 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KFFD/LFE"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEB343169
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919529; cv=none; b=dAeP9hX1ZIEYkhW6stC4sAcBb/N+g1tT9MlCCHX/i9wOluwvxaBGT7XKCBOC703C1MlZBvqZZbOWNi8hHzqspVn3zWHdatIe3Xm2l2PpXhNcRht4qsFRVfdIZZF0rngVpIUCEk/Z9BBvhWaNCJef/udqJb1DD00TJ1549AQeAF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919529; c=relaxed/simple;
	bh=qHNBM1nmKO3B4RoOuEP5pf1V91Y/CFiOHyFl4IFW1Ec=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Lo2ILpN9SFWq+ssbnISME8SG6Hxh8rGe2ZhcsnnkIBiIS5dFk4fivxBi07CSRJ4broM1ZUcXk+hOrpsD+G5PUk1g2PI5bKsiNqQWQ1c7cBYLh4bVjQkiR+zKOpezkRUxDDLdfuDHEye10h87VGDsaSaTVmzQC16RW9sZRbXbHoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KFFD/LFE; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742919524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qHNBM1nmKO3B4RoOuEP5pf1V91Y/CFiOHyFl4IFW1Ec=;
	b=KFFD/LFEOBzFicNYs5Ur+I3jWav3E3zdu4NlJe8GIOo2s32fyg7D/hxUccshCWv3Gan7mz
	rhzi5YcNGd0MVRebXsLwi+rF+U1PU6+0us/jui66BqtFM7TRmpoDbahgQGflMvZ39MejIj
	T0uffxzn8p3Z0ic9FtKiRlaf7CHTU98=
Date: Tue, 25 Mar 2025 16:18:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <a501099d7295712bf681c3a935e0dd1fc19a0810@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next v2] tcp: Support skb PAWS drop reason when
 TIME-WAIT
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Eric Dumazet" <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuniyu@amazon.com, davem@davemloft.net,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 ncardwell@google.com, mrpre@163.com
In-Reply-To: <20250325084351.6e027849@kernel.org>
References: <20250325110325.51958-1-jiayuan.chen@linux.dev>
 <CANn89iKxTHZ1JoQ9g9ekWq9=29LjRmhbxsnwkQ2RgPT-yCYMig@mail.gmail.com>
 <5cdc1bdd9caee92a6ae932638a862fd5c67630e8@linux.dev>
 <20250325084351.6e027849@kernel.org>
X-Migadu-Flow: FLOW_OUT

March 25, 2025 at 23:43, "Jakub Kicinski" <kuba@kernel.org> wrote:

>=20
>=20On Tue, 25 Mar 2025 12:20:18 +0000 Jiayuan Chen wrote:
>=20
>=20>=20
>=20> pw-bot: cr
> >=20
>=20
> Interesting, so you know about pw-bot commands but neither about=20
>=20the 24h reposting cool down time, nor about the fact that net-next=20
>=20is closed..
>=20
>=20Please read:
>=20
>=20https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
>

My apologies, I learned the pw-bot commands from other maintainers' email
responses and then discovered that I could set the patchwork status.
I'll learn the documentation more thoroughly next.

Please ingore my patch; I'll resubmit it after the merge window closes.

