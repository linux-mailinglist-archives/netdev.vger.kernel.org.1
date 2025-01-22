Return-Path: <netdev+bounces-160223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE15A18E1B
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 10:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A0C16BB10
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 09:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D0A20FABC;
	Wed, 22 Jan 2025 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZ7BUFyJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52F72046A2
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737536997; cv=none; b=Ep4AYelN/M1i7pJNR4fo2kgzCS76uXe0qrqv39lpgBLzYHX+WZTUDBjWU1TJGEoDNawPvVXyHFw7xVTqy6l09CNg4CKyr1I7k5I5wRT7mV+YSo76h4wMvAHnLFYeUk3iUOOEA3yGkonIDjtPRs+Tkl0ktDu873yJEH1XQ73PRuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737536997; c=relaxed/simple;
	bh=VtXv6DLbXfaDyqUNqHj2wss1bquCwsI/gBTXMJPeteg=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=qOVD7xjkkd9Krw8cVxsEYETONFH/efjUpWNTYGu8Q11MGjupnPZtBcqHd7f/goFmgSvXqghtRzJDMAXkEvVknYtz6Y76+QzROl+FeQprMR8+uQctkoPqrG5h5uR4vqqAdrHmKvSuZKWUVCFu40xoogOxT6HPwfbszFQzeReqms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZ7BUFyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6378C4CED6;
	Wed, 22 Jan 2025 09:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737536997;
	bh=VtXv6DLbXfaDyqUNqHj2wss1bquCwsI/gBTXMJPeteg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=aZ7BUFyJ4bD/DsP68dlsM7++Lh0dpclm0+mapCZOkdREAgFp3nyWY/87lVuCYikWk
	 d054XMqpYYSfaRKsM0aSZiruilcSzLir73/Trkkrs1uNDyWWVPHMLWX2RKWg2uhZXH
	 IlsBOSo14WSUZIgaoeWGI1zhp9S2GEvcXnyfN+gRlH2z9vO7TzuOAc9xUXk4UQZeHY
	 i4zMzCa04StFq3KeVNF1406CFOJk+ytjlr3XcNtFsrW8q6ia8k2AUWvxXUkhPXi026
	 dDrcwbnmnQeqGUo63lNpxdM3k5pnBO/kqHlQu2sx10vl+z29CRgXIiGdjbzVCh8Mnk
	 XBTKms9oKC5Mw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250122095024.35c78381@device-291.home>
References: <20250117102612.132644-1-atenart@kernel.org> <20250122095024.35c78381@device-291.home>
Subject: Re: [PATCH net-next 0/4] net-sysfs: remove the rtnl_trylock/restart_syscall construction
From: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, stephen@networkplumber.org, gregkh@linuxfoundation.org, netdev@vger.kernel.org, Christophe Leroy <christophe.leroy@csgroup.eu>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Wed, 22 Jan 2025 10:09:54 +0100
Message-ID: <173753699410.42919.17052319601873170277@kwain>

Quoting Maxime Chevallier (2025-01-22 09:50:24)
> On Fri, 17 Jan 2025 11:26:07 +0100
> Antoine Tenart <atenart@kernel.org> wrote:
>=20
> > The series initially aimed at improving spins (and thus delays) while
> > accessing net sysfs under rtnl lock contention[1]. The culprit was the
> > trylock/restart_syscall constructions. There wasn't much interest at the
> > time but it got traction recently for other reasons (lowering the rtnl
> > lock pressure).
> >=20
> > Since the RFC[1]:
> >=20
> > - Limit the breaking of the sysfs protection to sysfs_rtnl_lock() only
> >   as this is not needed in the whole rtnl locking section thanks to the
> >   additional check on dev_isalive(). This simplifies error handling as
> >   well as the unlocking path.
> > - Used an interruptible version of rtnl_lock, as done by Jakub in
> >   his experiments.
> > - Removed a WARN_ONCE_ONCE call [Greg].
> > - Removed explicit inline markers [Stephen].
> >=20
> > Most of the reasoning is explained in comments added in patch 1. This
> > was tested by stress-testing net sysfs attributes (read/write ops) while
> > adding/removing queues and adding/removing veths, all in parallel. I
> > also used an OCP single node cluster, spawning lots of pods.
> >=20
> > Thanks,
> > Antoine
> >=20
> > [1] https://lore.kernel.org/all/20231018154804.420823-1-atenart@kernel.=
org/T/
>=20
> Thanks for that work, it looks like this would address this problem
> faced recently by Christophe (in CC) :
>=20
> https://lore.kernel.org/netdev/d416a14ec38c7ba463341b83a7a9ec6ccc435246.1=
734419614.git.christophe.leroy@csgroup.eu/

That's likely given the diff, I actually wanted to Cc him here but looks
like I forgot... Thanks for doing so.

