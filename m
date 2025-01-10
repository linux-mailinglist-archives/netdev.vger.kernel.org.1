Return-Path: <netdev+bounces-156937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9569AA08541
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 03:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33663A6ABA
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 02:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4314033987;
	Fri, 10 Jan 2025 02:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klAjdpEw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3B4EACE
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 02:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736475507; cv=none; b=LiaB70oZO2iYtN9BX7i7ARjxuzLDXKIoW2NpSg29SbilUo8tOo2iTwQPiEZTKhkqlep7EEljOQxbWduMrO3AKsdRSx91jS+VnDfkHEkEOpu0dCRxspz+yUgaYrrT/zyNH3Tva17BK+bkZGIQUorz4zioT63fPhRFmIdlMXIpb14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736475507; c=relaxed/simple;
	bh=PbhyKJarV30DR7ahOtd3ebqI0eJlcTiomhN+1wkcqMU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jx5f63foVeBKErjG+vr0bx4Ii6wUJ+mq1kxDigwnucdYTg6vfKKMj+RffxNda1WJoB50thkkUetRvrx+q6z6t99WevIw+RfiAxVzaDxEtMEvHIo5aH1fKFtLprswzgnfX64KIde96XpcS9pvqbP9Udw4TlrBbnLq7qflG5Eqko8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klAjdpEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A3AC4CED2;
	Fri, 10 Jan 2025 02:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736475505;
	bh=PbhyKJarV30DR7ahOtd3ebqI0eJlcTiomhN+1wkcqMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=klAjdpEwslnlQzsvCPKYjUI2Gze3QdNhxo4h+3a5vxW5GSJY5gS27JXVbM1EeHaw0
	 +ODSdQDTy5ksw79tBgQj16Eo1AnRIJWtBtQDTY1LQ/a9FVYtzFmoc51l1pcHXG0wI0
	 Tjtg2DcvqLPCboSx1kGMegI04vP7OW78k27po3UTJMXnp56K7UNdFkXIpBGdvgWbbC
	 pnbHJ5X/vsm6LV+f9Lsaov9/j+VAW+7mxVhpahMtjGlar7vhzRVHIrVtB/2ynQHO0A
	 XBOwLu551KMAGDZeg8npU0/aHgvXC7gjFKyP9B1SEfMS/SRiABtOTT/GfRR+Zjxfp+
	 kZBWgnslWRP0Q==
Date: Thu, 9 Jan 2025 18:18:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, anton.nadezhdin@intel.com,
 przemyslaw.kitszel@intel.com, milena.olech@intel.com,
 arkadiusz.kubalewski@intel.com, richardcochran@gmail.com, Karol Kolacinski
 <karol.kolacinski@intel.com>, Rinitha S <sx.rinitha@intel.com>
Subject: Re: [PATCH net-next 12/13] ice: implement low latency PHY timer
 updates
Message-ID: <20250109181823.77f44c69@kernel.org>
In-Reply-To: <20250108221753.2055987-13-anthony.l.nguyen@intel.com>
References: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
	<20250108221753.2055987-13-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  8 Jan 2025 14:17:49 -0800 Tony Nguyen wrote:
> +	spin_lock_irqsave(&params->atqbal_wq.lock, flags);
> +
> +	/* Wait for any pending in-progress low latency interrupt */
> +	err =3D wait_event_interruptible_locked_irq(params->atqbal_wq,

Don't you need an irqsave() flavor of
wait_event_interruptible_locked_irq() for this to work correctly? =F0=9F=A4=
=94=EF=B8=8F
--=20
pw-bot: cr

