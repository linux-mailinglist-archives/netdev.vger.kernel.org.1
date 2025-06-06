Return-Path: <netdev+bounces-195499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71351AD08CF
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 21:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8D9189AFCF
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 19:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B781A262D;
	Fri,  6 Jun 2025 19:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1kh6CKn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694EC36D;
	Fri,  6 Jun 2025 19:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749239181; cv=none; b=aMCK+i7wukPEiA5U1c3DjvRfnjdRzRRZt0TG87tbXetWwYun6hqoSjKJa3jwvspoVADEFbUu3N+h9lfEW38gYLkGVDNvpyTShizJwZaind33J2GM+6iXg3NC0s4FM8zcbuSzEsv/DplnJhVuvyRwSSfsMavWSN9WyObNbImbWFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749239181; c=relaxed/simple;
	bh=01zrtN3LHWp3T9SlDc6J4OdMI4FP63NecS3WUI0ue1w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=fknN+YwrXPrelds+TMRtFmCCrqZRGB4Mcnn3a8X6xplRM+RwxSBHTYWFyZhs+GubDUlYujdb3wa2FUxe3pUjTLVtEOIs+cDqnxTibJUA1wyXeTYhMrmkPW5fwmQtKYN3v11YTCpheLZJwwaF8OwU9WR5R32GTb3uTk8pKk5WaFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1kh6CKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668B1C4CEEB;
	Fri,  6 Jun 2025 19:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749239180;
	bh=01zrtN3LHWp3T9SlDc6J4OdMI4FP63NecS3WUI0ue1w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=S1kh6CKnovjc32GVIf+1sxu269Qc4igI05LZNceRGVi7fI7Rii96g51x7D1iy3StZ
	 /FbmDP9LAdRBUEbmuUxFPibEpJBF4F/SeWfBIvWMavG8UNU5u7qWi235r7THakknNv
	 aYu5lZQdXwe5UfSnG0cUHyCVvrvDB9Ea6KOdtZlaW3ezdXF/i/HilWxp55k8CDR7Jc
	 9e2l0XzmfdhP+EERWfjSGLdLFYEPLx+GIcBVCXGeDHGFc0sY3Ad7vNSoDHbn6d13KM
	 B3AnAo14177XSxbPVXqH0vcfqSeqDb4JMg+RR79aa8dqs1dfhLdGSaCmAFbi5hrICb
	 AodQPi+RO59jQ==
Date: Fri, 06 Jun 2025 12:46:10 -0700
From: Kees Cook <kees@kernel.org>
To: Eric Dumazet <edumazet@google.com>, Pranav Tyagi <pranav.tyagi03@gmail.com>
CC: Andrew Lunn <andrew@lunn.ch>, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] net: randomize layout of struct net_device
User-Agent: K-9 Mail for Android
In-Reply-To: <CANn89iJR1i3hhXrkDNtXyPCNUj1KmrTAff2=pcuYNsXBxogNpw@mail.gmail.com>
References: <20250602135932.464194-1-pranav.tyagi03@gmail.com> <053507e4-14dc-48db-9464-f73f98c16b46@lunn.ch> <202506021057.3AB03F705@keescook> <25d96fc0-c54b-4f24-a62b-cf68bf6da1a9@lunn.ch> <CAH4c4jJRkeiCaRji9s1dXxWL538X=vXRyKgwcuAOLPNd-jv4VQ@mail.gmail.com> <CANn89iJR1i3hhXrkDNtXyPCNUj1KmrTAff2=pcuYNsXBxogNpw@mail.gmail.com>
Message-ID: <123565BC-9619-40F1-9F38-0F2BAAE09716@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On June 6, 2025 8:42:45 AM PDT, Eric Dumazet <edumazet@google=2Ecom> wrote=
:
>Most distros use CONFIG_RANDSTRUCT_NONE=3Dy

That is true=2E But distros don't strictly define our code base=2E :)

> I do not think __randomize_layout has a future=2E

It will remain an actively supported feature -- many high security systems=
 (that build their own kernels) use it, along with other features where the=
y have no problem trading performance for security=2E

-Kees

--=20
Kees Cook

