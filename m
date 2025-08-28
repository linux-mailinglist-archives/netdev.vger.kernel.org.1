Return-Path: <netdev+bounces-217555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D174B39097
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 03:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74993625EF
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 01:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638461F8AD3;
	Thu, 28 Aug 2025 01:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRkqxB18"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF0C1F3D56
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 01:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756343165; cv=none; b=VLsR1AsO/tJM4bQtv+QTH1P30K0cQPaUQWgP6uCwgDLunP2iFzWgL4GYMLLPJEW3P7B1UTLoz7G1Wj39YLf89ARkDQZTPkV7y0cq7nt9029s2iykZpFMq1QU2A/AHqFya+ICaZ0IRoUlsxDooaGEm8gMF/VmAtXwYnFEyRClHlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756343165; c=relaxed/simple;
	bh=FXJxeP3atbud+aYAyyX+fCyVV2YH3yJDmuzCxJTwG9k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C6ssc7L4d+l0Ycu78q/ycc2TrchK5AeHKBLL9c02uzeXJ5Oh1EbOCJmMVkCTU8K2lFcMARxPhZwTpFwwVtLrLmqyWMH/+H05yPWit4cTDoICddMIbGxp0hj/tqKCXZPkZ0MqsebAGu7Ya65scxXPiUqJ/ZkIYnmBJWrY3nKO+1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRkqxB18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736F8C4CEF7;
	Thu, 28 Aug 2025 01:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756343164;
	bh=FXJxeP3atbud+aYAyyX+fCyVV2YH3yJDmuzCxJTwG9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CRkqxB18DzA/mHBaNFHAL054oeNrGVRsFaByOEIKcP3I9fG9Wd10PCMxmbc1JbgtP
	 hOaPazJiYJgTgo4vW5cId7CWt21N1KssXyh7R21Lxk6sHO7FIo1zbQtMpyish+YBSH
	 WPVuanSxoarUQzUNcGV7ZX4xkej1LaoC8bLIeFkabfBtXuOdtaOeCaEZplocb23YL4
	 ke7N52rkoFSeuNqFsSBMT2uHrpwHVzVRCdZu9ZoNjvsUL3ZiUtdvbcBAmMQvcT2Eqs
	 o5zYY0EUOZh1SOPERBMb8OcDCyehV87Kv0uRSPBJjYebDnYE9T4SD+Pi4m+++d3BWF
	 ynL1bU6p0LEmw==
Date: Wed, 27 Aug 2025 18:06:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jakub Acs <acsjakub@amazon.de>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Fernando Fernandez Mancera
 <ffmancera@riseup.net>, Taehee Yoo <ap420073@gmail.com>
Subject: Re: [PATCH net] hsr: use netdev_master_upper_dev_link() when
 linking lower ports
Message-ID: <20250827180603.001b85b3@kernel.org>
In-Reply-To: <20250826013352.425997-1-liuhangbin@gmail.com>
References: <20250826013352.425997-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Aug 2025 01:33:52 +0000 Hangbin Liu wrote:
> Unlike VLAN devices, HSR changes the lower device=E2=80=99s rx_handler, w=
hich
> prevents the lower device from being attached to another master.
> Switch to using netdev_master_upper_dev_link() when setting up the lower
> device.
>=20
> This also improves user experience, since ip link will now display the
       ^^^^

Why this "also" here? You haven't mentioned any benefit of this change
up to this point. AFAIK having the master link is the only one?

> HSR device as the master for its ports.
>=20
> Fixes: e0a4b99773d3 ("hsr: use upper/lower device infrastructure")

The current behavior is 5 years old, AFAICT. We need a reason to treat
this as a fix, right now this looks like net-next material..
--=20
pw-bot: cr

