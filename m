Return-Path: <netdev+bounces-171410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 628A8A4CE4E
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 23:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E581188C604
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 22:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4314A1F130C;
	Mon,  3 Mar 2025 22:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0pU+UZY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE4B198A2F
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 22:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741041136; cv=none; b=UogayfPIb5mnRQRebT0L/fLBKJQ809ALB0QHFILpnq4GksQnnZx6P3n3w0RmW4nRJ+3ewpRTAXLpuLiXARL2L3BL7HIEt+b794EDDLkLVZsZ6Wt9j5snYro0oDbmd82zAghiOTfScfRYEUHQBKld6kFU6RCHNNe2YA8ha75NXfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741041136; c=relaxed/simple;
	bh=c1cBdBqaDwBD00W4WhD2vFldfrgHvcYL/fC2/VNe7qs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J30RFPVTdB6FW+hAxzHM5oxMCJh3D5XquU7qlb94brZn6AmwsihVu0hP59lng7CL1O0PjNxCt0QDMdbJPiluShD+ivSfredTmEmieuhF/HL6pxWQdsr9mOAhalogGKTRTLJY7UAwpfZ33GdU9aTJzXv8iyTgGly/yFjAfiRC/LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0pU+UZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F583C4CED6;
	Mon,  3 Mar 2025 22:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741041135;
	bh=c1cBdBqaDwBD00W4WhD2vFldfrgHvcYL/fC2/VNe7qs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C0pU+UZYuAIO1ugeESlJUtZy9U6U4KcOEFdI5XzSQi9D7e147trhD9cmHcyQx3gHT
	 xe/0Snf3mF6UoIfOI0vKjmv+/Qb0CvezadukyM/mH7qlM5wlovpbuYfnoMder6+Skc
	 bmECsXVlgdT3yJcny0VQZCQdZByHK+DIkbgYyZaQDFr1Dn14Gb4oofvUxLPTAVJDeb
	 T1wG5l7HRnEjmmeRJYtOXZ6f0jziPI6tDcxayCC32K8sT7J9Z2oHwAxbi3pKOzxpQH
	 dtnXL7ttLFhdnOjYVyB3S2n3nhuVuz5jKqfzPu7VzPTlS/ObnPOqbGgXJxl3ao56dj
	 rvZTBqlAMILMg==
Date: Mon, 3 Mar 2025 14:32:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 pavan.chebbi@broadcom.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net-next v2 7/9] eth: bnxt: maintain rx pkt/byte stats
 in SW
Message-ID: <20250303143214.7d6cd978@kernel.org>
In-Reply-To: <CACKFLikUqFVOkALJXX+_Tx=-hu=82u+ng4rnm7qgSHwiLr=gFw@mail.gmail.com>
References: <20250228012534.3460918-1-kuba@kernel.org>
	<20250228012534.3460918-8-kuba@kernel.org>
	<CACKFLikUqFVOkALJXX+_Tx=-hu=82u+ng4rnm7qgSHwiLr=gFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 2 Mar 2025 23:06:29 -0800 Michael Chan wrote:
> On Thu, Feb 27, 2025 at 5:25=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > Some workloads want to be able to track bandwidth utilization on
> > the scale of 10s of msecs. Updating all HW stats at this rate is
> > both hard and wasteful of PCIe bandwidth.
> >
> > Maintain basic Rx pkt/byte counters in software. ethtool -S will still
> > show the HW stats, but qstats and rtnl stats will show SW statistics.
> >
> > We need to take care of HW-GRO, XDP and VF representors. Per netdev
> > qstat definition Rx stats should reflect packets passed to XDP (if
> > active, otherwise to the stack). XDP and GRO do not interoperate
> > in bnxt, so we need to count the packets in a few places.
> > Add a helper and call it where needed.
> >
> > Do not count VF representor traffic as traffic for the main netdev.
> >
> > The stats are added towards the end of the struct since ethtool
> > code expects existing members to be first.
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org> =20
>=20
> The byte counting looks correct except for VLAN packets with the VLAN
> tag stripped.  Do we want to count the 4 bytes for the VLAN tag?

Not 100% clear to me. I looked at nfp and a couple of Intel drivers
and if I read the code right they don't count VLAN tags if stripped.
I suspect that's what most drivers which count in SW will do, simply
because it's easier rather than intentional choice by their authors.

Happy to change if you have a preference, but to spell it out my
understanding is that not counting stripped tags was more comment=20
and that's what I intended to implement here.

