Return-Path: <netdev+bounces-81567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 500CD88A474
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 15:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F7D1C36A85
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0461BB747;
	Mon, 25 Mar 2024 11:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkiwzsdQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9683D145FEF
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363039; cv=none; b=u+stUJ7xLTXWEzGvinjyAJq7WRsQcN/JH8vO7TJRtMraGjMNfYu1wWdVJ6f7+vMihhqYsZG3+e6xu3ssonLICJYJnTsOvoWUvymLq5IKtbKfVvx7L7PMm8VaorCXyOKc3vdjI0JcgR2stH0xmKTSCI3rtd5JdrdGUpb/tzFKHq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363039; c=relaxed/simple;
	bh=kOTYUUtbSsb9mqElazS5J1HdFhUzC6oHQB3rQXPkEN4=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=QHFtbqvzu5izuuf/vdL/IYeSBGJdQ4ljfeGVYYYH1huYEUFAYX/A07Qw18Ou3B9U1uMlppfzQTHLnrk3s9JrtZvquyacKuEm6AtXT+u6sZwl5+w6DlZBcYLJsuvf/rtwlPYNJfYStSQCp49nqTfNdrn6yzSLURf3j9eGp+myRXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkiwzsdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F21C433C7;
	Mon, 25 Mar 2024 10:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711363039;
	bh=kOTYUUtbSsb9mqElazS5J1HdFhUzC6oHQB3rQXPkEN4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=TkiwzsdQ8Stc3xEIJlyVpvU7afzF1MQwnCtA3OTNudUfOP+kYN0zYsi3aEvjF3ESZ
	 7vvLcbrrMI0L13+S0MX22ZmC255qeT5f8gvJgi/qzINNxqYpHArwpo+2uRCJkzP/SP
	 w+ig1bF4CYs6WPYV/sDZ1FTYudCgfU1rFFAYdJ3qJAEy+dN/DCNgZxyQUTQwxuUnHT
	 9AX9S1URUeuB2nhIQyP+dMNvHnM9WoSoEhkYsCJbqtYzqoivms+R9fx7cQXfFKPJB4
	 tYLZCwVzPggwPw4vqRZPMCg/XHwOvcSbwkmqa0gX25HgzMqET5xi6uqZwBJPAsK1QY
	 H0XV+yALrsIEQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <65fdc00454e16_2bd0fb2948c@willemb.c.googlers.com.notmuch>
References: <20240322114624.160306-1-atenart@kernel.org> <20240322114624.160306-4-atenart@kernel.org> <65fdc00454e16_2bd0fb2948c@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net v3 3/4] udp: do not transition UDP GRO fraglist partial checksums to unnecessary
From: Antoine Tenart <atenart@kernel.org>
Cc: steffen.klassert@secunet.com, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Date: Mon, 25 Mar 2024 11:37:15 +0100
Message-ID: <171136303579.5526.5377651702776757800@kwain>

Quoting Willem de Bruijn (2024-03-22 18:29:40)
> Antoine Tenart wrote:
> > UDP GRO validates checksums and in udp4/6_gro_complete fraglist packets
> > are converted to CHECKSUM_UNNECESSARY to avoid later checks. However
> > this is an issue for CHECKSUM_PARTIAL packets as they can be looped in
> > an egress path and then their partial checksums are not fixed.
> >=20
> > Different issues can be observed, from invalid checksum on packets to
> > traces like:
> >=20
> >   gen01: hw csum failure
> >   skb len=3D3008 headroom=3D160 headlen=3D1376 tailroom=3D0
> >   mac=3D(106,14) net=3D(120,40) trans=3D160
> >   shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=3D0))
> >   csum(0xffff232e ip_summed=3D2 complete_sw=3D0 valid=3D0 level=3D0)
> >   hash(0x77e3d716 sw=3D1 l4=3D1) proto=3D0x86dd pkttype=3D0 iif=3D12
> >   ...
> >=20
> > Fix this by only converting CHECKSUM_NONE packets to
> > CHECKSUM_UNNECESSARY by reusing __skb_incr_checksum_unnecessary.
> >=20
> > Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
> > Signed-off-by: Antoine Tenart <atenart@kernel.org>
>=20
> Should fraglist UDP GRO and non-fraglist (udp_gro_complete_segment)
> have the same checksumming behavior?

They can't as non-fraglist GRO packets can be aggregated, csum can't
just be converted there. It seems non-fraglist handles csum as it should
already, except for tunneled packets but that's why patch 4 prevents
those packets from being GROed.

> Second, this leaves CHECKSUM_COMPLETE as is. Is that intentional? I
> don't immediately see where GSO skb->csum would be updated.

That is intentional, fraglist GSO packets aren't modified and csums
don't need to be updated. The issues are with converting the checksum
type: partial checksum information can be lost.

Thanks,
Antoine

