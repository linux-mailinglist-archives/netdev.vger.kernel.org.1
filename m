Return-Path: <netdev+bounces-269205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN7XEukmu2kcfwIAu9opvQ
	(envelope-from <netdev+bounces-269205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:27:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 798E52C35C3
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C2E4302CD36
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29317372ED7;
	Wed, 18 Mar 2026 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvUaj8HJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044BC2E413;
	Wed, 18 Mar 2026 22:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773872868; cv=none; b=cCskFUuPK11xAP4S1tAAxCCmwIL+wBi316Lyt4nFoaWQYaHlP1AEIcKjeQzXji5H4KN/pAiIdodSWiD/aQsM4LxYSWT3eJNHp2jpIIklq6ensQwXBQg4Ptf1y6P18Zm1YFkaQr0jtWZZTV1JTOEied1ockZCmBZZ6zzch4RkMU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773872868; c=relaxed/simple;
	bh=KxrdvkBEqPTxkENFRBvHJYQ0DN7AdThMqkjUn0/oz/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7GeoaBEnHvjuBqLPR3qAVd7d8aXw4L4lk7svGXCvApHuwys1iqRM5g35sGc/uLIajDZy+sUWlyPrSYOq9X5sJ0DdMkiom8ZlswgVa+MF0hrFy1kcOVWDoi5aYSi8EF0a+fvHfsbXjo88EosKWCVADEYPWMXSz8xBUA+3X5ip5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvUaj8HJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC9CC19421;
	Wed, 18 Mar 2026 22:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773872867;
	bh=KxrdvkBEqPTxkENFRBvHJYQ0DN7AdThMqkjUn0/oz/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OvUaj8HJSghzpVfTfAlaumWOQxxwGJPCxElo/pXaTlK/0mmvKSbDWXXInM6PMyYLx
	 b5Pbr1C6I1xVPviudFsca/cTegXoBWy0xS6OV432/bHVxjGeuJ8uYCHQBqSojB4Ff1
	 DqtOXnvYHK1mVqmiLIxLIrvgPFt0sTfVFHArgyTurv2qs/zFW5c/1QwUVq7lxlCD8L
	 pkGae9b64ROefB7rKu/2rPVQfVX3tmNvwTp6L4bZte5KDlQE1R/SSxMiOkCg/esQA9
	 hMwXY9Ezw/xK2yUmrFdv2cTXQt+USP453ZO5GaGOLgC9r+kx+dVfbUopPSkCP3m3sV
	 0QE4A0a+bE3Qg==
Date: Wed, 18 Mar 2026 15:27:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christoph =?UTF-8?B?QsO2aG13YWxkZXI=?=
 <christoph.boehmwalder@linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alok Tiwari
 <alok.a.tiwari@oracle.com>, Kees Cook <kees@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] genetlink: add multi-version family support for
 protocol negotiation
Message-ID: <20260318152744.4f6d8c83@kernel.org>
In-Reply-To: <b17134a2-c95e-4019-800e-ab6ec6982ea3@linbit.com>
References: <20260316151507.3958299-2-christoph.boehmwalder@linbit.com>
	<20260316113736.1085a124@kernel.org>
	<085c9532-5440-4879-bcde-4d70c980c839@linbit.com>
	<20260317151745.4562eefc@kernel.org>
	<b17134a2-c95e-4019-800e-ab6ec6982ea3@linbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-269205-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 798E52C35C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 18 Mar 2026 15:54:04 +0100 Christoph B=C3=B6hmwalder wrote:
> > I still feel a little bit in the dark as to what you're doing but the
> > normal path for Netlink is to add new attributes and commands in a
> > backward-compat manner. In case of DRBD given how "special" the
> > existing code is we could probably start a new family using modern
> > constructs. =20
>=20
> The new family indeed sounds like a way out. So we would register two
> families: the old "drbd" for the compat case, and a new "drbd2" with the
> new command set. Would that be more in line with the "standard approach"?

If we really can't keep backward compatibility then new family sounds
like the next best thing.

