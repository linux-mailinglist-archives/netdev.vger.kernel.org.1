Return-Path: <netdev+bounces-188514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1E6AAD279
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 02:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD9D4E7F96
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 00:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5116172615;
	Wed,  7 May 2025 00:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioKObIxz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294744501A;
	Wed,  7 May 2025 00:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746579283; cv=none; b=jD4vZ1O9Xa47yUhB/ZrFIoD6hLj5aP3yhJTZw4EwodXSov0V0zG/725NNp0bDnVkwS0jBa6+c/FIlh8SdL9H1jjqTUl6rzaEJj4QS0rPP9lAkeJY4LY6iBZFleMOebFc1WFmC79ghc5951JJJ2DSsn437gmCO8g680qp9qoEG6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746579283; c=relaxed/simple;
	bh=VUhGjOltew2POzKBL8WZt7UPab6AmczgUypH9W39CAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ujs9ujuMW3Ud3o8t/IA4zd1cZKlQLrUVGU87M15AslrEPUYjE+i7/iipmlxLB0bEf2UC1m5HHUB/FUvmtGaWSH53wphl8yokhbe46ggucLmMUToRkW8BQK7YUu7PftJ3+W8b9sK8m7oN8LSegt5gC0CrGtW/aNpFgaMquh3CXyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioKObIxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA96C4CEE4;
	Wed,  7 May 2025 00:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746579282;
	bh=VUhGjOltew2POzKBL8WZt7UPab6AmczgUypH9W39CAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ioKObIxzIJokvgdIM7glswPbV9b/Ejx7iDAJVa+q+RvyxHUdp6HL8U3aoiRLLFpRc
	 2VNPmb/suQ8l30me/+HsdTDOUGsWcFmnI3B6IG4On4sM6kionc5OhfLPdzWRNSTxqS
	 SfQcdVdumAzhxW7quaSWJ/9CwUHgKARmMjOnimG01vXxqyaU912TNocTfplSgok8g6
	 jgB2JzxnBorEk0O6z6qbclBQ0O+BGfUXSEatFKb2CW/8rnpd2Od0T2FbzIN/AGTpAv
	 L10NbpJwpFquD7MfUNE+ITUlA6x5dH4nYU07R/AN/fRzpZL2O8avvLi/+QpufCkeyW
	 lFPAdR/m6J+sg==
Date: Tue, 6 May 2025 17:54:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thangaraj.S@microchip.com
Cc: Andrew Lunn <andrew@lunn.ch>, Bryan.Whitehead@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, linux-kernel@vger.kernel.org,
 pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v1 net-next] net: lan743x: configure interrupt
 moderation timers based on speed
Message-ID: <20250506175441.695f97fd@kernel.org>
In-Reply-To: <e489b483-26bb-4e63-aa6d-39315818b455@lunn.ch>
References: <20250505072943.123943-1-thangaraj.s@microchip.com>
	<e2d7079b-f2d3-443d-a0e5-cb4f7a85b1e6@lunn.ch>
	<42768d74fc73cd3409f9cdd5c5c872747c2d7216.camel@microchip.com>
	<e489b483-26bb-4e63-aa6d-39315818b455@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 6 May 2025 14:10:09 +0200 Andrew Lunn wrote:
> > We've tuned the interrupt moderation values based on testing to improve
> > performance. For now, we=E2=80=99ll keep these fixed values optimized f=
or
> > performance across all speeds. That said, we agree that adding ethtool
> > -c/-C support would provide valuable flexibility for users to balance
> > power and performance, and we=E2=80=99ll consider implementing that in =
a future
> > update. =20
>=20
> As you said, you have optimised for performance. That might cause
> regressions for some users. We try to avoid regressions, and if
> somebody does report a regression, we will have to revert this change.
> If you were to implement this ethtool option, we are a lot less likely
> to make a revert, we can instruct the user how to set the coalesce for
> there use case.

I completely agree. Please let the users decide how they want to balance
throughput vs latency.
--=20
pw-bot: cr

