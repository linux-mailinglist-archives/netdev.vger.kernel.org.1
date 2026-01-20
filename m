Return-Path: <netdev+bounces-251400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11751D3C32D
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA06850153F
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 09:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DA93BFE29;
	Tue, 20 Jan 2026 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIOaHilF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601B23BF300;
	Tue, 20 Jan 2026 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768899964; cv=none; b=aVjO4LNKIcnhQhRtUfF7LPIKp1kcrcFOcB9nfI5rEfIjbjKM8R3v1daX4C3Yw/jB9zNKFY7xsw9ew/D8vH2qMEeMJVa8zM9J9Zq2L1yc/EjiU4x3OT+XNr+6YNGoRy/d95KFXgAUUiOXQUlnVG1ha+7n6oGhQmUobfNYBCbpXyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768899964; c=relaxed/simple;
	bh=MY2TnFbxs3t461o8psn724JxUORnxCWw8SUzYFQbP2E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q/yIyCWAO0tVN2bT40UfURL75q18NXu2ORAX3JiMAf9JeeLICB0rJAhY5AixY0A8YtQtLBnBvzUCsDYaXTt3G1yd9bW/qfOOZmTXiF/dFe/mbAT1ZuPFDwGVN9a2rGepi2PJcVpPSAoa/qFoRTXSr6tTzbu+nzxIh04EZ/TZnRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIOaHilF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43095C19423;
	Tue, 20 Jan 2026 09:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768899964;
	bh=MY2TnFbxs3t461o8psn724JxUORnxCWw8SUzYFQbP2E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gIOaHilFyRX5np+5bR0svILTpn24oZwPkK0XBjxtSdZZn7WOfCFmrksSKddFYMrvg
	 s/NcFZyF1Ji5PHLTVFOCDIXiuiFJRl2N7F7lKPtS8vwsfPa5epufdHm7nzNLVAGxC8
	 F3yVkFCftnmVa6J/jz7w/0WvXskmtnOhdtLpXrjV4BRy76k4ZjgHouhduU7qpn133O
	 U9I1IuFTvHeTVNvmXOPHqFQNFV4Ry6a0+77bVTE+zehf8xqwAgQGCTaGEx9C96RMBn
	 Vt8QySIc2B7DmDoRJ4vEa/CX4t+bI96PkRtF5Jz9mKr/GkEK+xStVrjXU6qRO5T5EC
	 SE/MpgM6+rjVQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>, Eric Dumazet <edumazet@google.com>
Cc: John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel
 <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, Eric Dumazet
 <eric.dumazet@gmail.com>, Kevin Yang <yyd@google.com>, Willem de Bruijn
 <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, Yuchung Cheng
 <ycheng@google.com>
Subject: Re: [PATCH] time/timecounter: inline timecounter_cyc2time()
In-Reply-To: <CAL+tcoAS9u1A9xpsWaAzSojJ7qepWsvF3imC5LtEhu=zD9AjsQ@mail.gmail.com>
References: <20251129095740.3338476-1-edumazet@google.com>
 <CAL+tcoAS9u1A9xpsWaAzSojJ7qepWsvF3imC5LtEhu=zD9AjsQ@mail.gmail.com>
Date: Tue, 20 Jan 2026 10:06:00 +0100
Message-ID: <87jyxc1wnb.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20 2026 at 16:18, Jason Xing wrote:
> On Sat, Nov 29, 2025 at 5:57=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
>
> When I'm browsing the modification related to SWIFT, I noticed this
> patch seems to have not been merged yet?

It's in the tip tree and scheduled for the next merge window.

