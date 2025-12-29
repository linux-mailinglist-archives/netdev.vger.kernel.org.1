Return-Path: <netdev+bounces-246285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C04D0CE8175
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 20:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B78930124C4
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 19:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6577E23E334;
	Mon, 29 Dec 2025 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="v8EKlzNm"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster4-host9-snip4-10.eps.apple.com [57.103.78.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A955B23ABBF
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767038185; cv=none; b=pj2otNnquewCnoFSsBknjcZm4gsUd/9oB6DmZBtUIp8NLeKI0tLg2PkUlY8ifhKG3chouOS3Rr3iBsy1oV7TcIvfpdY56HNpFWNOLztyjtzL3HUSGvv7E23pU09WORCDxe0CJ1y56ykAMgbJulPSzm53GQgcN+icyu5J5awXDXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767038185; c=relaxed/simple;
	bh=1urNez9iDIld6OAxncsepPTunpYtCzTt7d7WWb2c4HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOHJ4/p7GcnzRHLXhDFoGH28LXOL0jRgWXWNZJO5i+QGbFWMBoUhkewFkvhgPs8U+ae294J0fphyCaIVRJBFkFv54IUPfjytheVmaWHbjzNAQ6TBScteIAOWMJV5qU9n4sINAaX+iqsViT9J53PakPlV5siokNsYmM57siLN9mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=v8EKlzNm reason="key not found in DNS"; arc=none smtp.client-ip=57.103.78.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPS id 75C2E18007C5;
	Mon, 29 Dec 2025 19:56:21 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=1KbO+RoiTJgCNtLW0OzrhM8WEo6RLQNavBQZsLzI+Ok=; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=v8EKlzNmEKFd+689+slNHuA04jyH1G4JbyaaPu4qGK/G7aEXZOH8OuzT6gQ/5+gwPkzo+unwG8jr9VnGGMLlEUrO8IgAYwNXPraV5dQHqLbKHAhH20Op56jcse4OvElQNrezczQn9AGKgOWvDF5Vw2sbIXe/yVbsWbYpAd7p3wQuhHdUQ3olalXH2sMHoEgdtCSFbn8blJ+EdFV2OT+mJU8SZzXthHSNRgd9/bdToZgfatu/t2T+ym7MSAH+u3rJQxF55bOwFxmDhnTKdoVDYBZW/YBeKoPn1U1Hi2/V7/Kru1A0MJX38hNZrrdO419jq15qx4Qwn3VHMLc7fzUAEQ==
mail-alias-created-date: 1719758601013
Received: from y-koj.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPSA id 144AB18002F4;
	Mon, 29 Dec 2025 19:56:18 +0000 (UTC)
Date: Tue, 30 Dec 2025 04:56:16 +0900
From: Yohei Kojima <yk@y-koj.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/5] net: netdevsim: fix inconsistent carrier state
 after link/unlink
Message-ID: <aVLc4J8SQYLPWdZZ@y-koj.net>
References: <cover.1767032397.git.yk@y-koj.net>
 <ff1139d3236ab7fec2b2b3a2e22510dcd7b01a21.1767032397.git.yk@y-koj.net>
 <e8180dc5-fc23-4044-bd67-92fc3eebdaa0@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8180dc5-fc23-4044-bd67-92fc3eebdaa0@lunn.ch>
X-Proofpoint-ORIG-GUID: -Mzj7FTA82WPivV3uBl2NzpCwTPUY4fm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE4MiBTYWx0ZWRfX/y0Xi/+2E4O2
 otl/0zwfS+PDDLzi7OEYgMuV2UdvP6dBOuBebcV57qySoS0lfMQ0iqW7OtXLn0bw03tg0DPIZAj
 DAX+WQRMjABjfBoprQPNQMIXuTJwDs/1opAlenVWn9bnXwgJQq9DaNztFFKFjRqg3DAPh91xLlC
 LNqsLvh8S75T9ohsdWU2Dg88GcswRixeHlplCVeW/geZ8m61W6k6bfR68IngIYMyOQZAA6+Qd7Y
 QuLZVQWBMjj2W27VUzVigUTCsoczJHmByDvz0i2f1LfsdEGdd83ll0xUS50VlMIE1guoXu2Zp02
 sfZNFMqAJrYHPBo4O2s
X-Authority-Info: v=2.4 cv=DJ+CIiNb c=1 sm=1 tr=0 ts=6952dce6 cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jnl5ZKOAAAAA:8 a=7gZhQl7Q0LLefV5nMKsA:9 a=CjuIK1q_8ugA:10
 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-GUID: -Mzj7FTA82WPivV3uBl2NzpCwTPUY4fm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=487 phishscore=0 spamscore=0 suspectscore=0 clxscore=1030
 bulkscore=0 adultscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512290182
X-JNJ: AAAAAAAB48aOiXs0D6hG/j+Fcz1meNmtg8UIqtpwpZoGprHUUzBNav3vyyo3KrJIyCLYpvPQt7odfvDa/kodSzjrL5XzECI5gMM0t5CIukXNCUQNN7dLkKxZhWRwLqesz6WUNfBFLzyQcRN4Vc1yFZKknBlf2NiHQPP7u0ZZQHz5ZRInHBBDtmFk/Dw0fgFvyvmX91Ru5xNV/hxJc0FxWwzMkQRn1dg9AU///IG8hdr7N3qDgXqy69l7VCS/vmvsXLIvwQ2j1p5ssgsZ/Lym3ooDGwib2pKTvfwcTP96C8Hou9awFXt5KbXYCtkDAPSN1evlI6JAvK1uhcSDx/Gt6ftHUoG3sXrukYgvcofaDwr2sRG9SusHDJRQhEq2SKOV4/iYnOMxWxAHzJj2uJBPMRd1QvaztDENTbugZ85bweZaKa+o9TUx6B6T9CsSbvc83qJ6BkBc2Q19UspdvOk4+eu5L+/MvHyaMCx++njqGENYNYieA83YBEPM3DxaXLELw/jcc2bbt/BIQ4KNrp48MLC6rQD6JnnICMfqYNaDJbPl1JTiraAkNS2AfK3P3NDnYrMAbKydwWdGfY4qjIOhj3E45meLKcr+7QwHQT7huOGhx/6J9n13IdY7cUiurPCDAPj+ArsXy2JKNCXZSG61b/L7//H3dt2RB1M191pdOq0wPsRbtmbx02GNtsr3IDzPJi646Lw=

On Mon, Dec 29, 2025 at 07:39:29PM +0100, Andrew Lunn wrote:
> On Tue, Dec 30, 2025 at 03:32:34AM +0900, yk@y-koj.net wrote:
> > From: Yohei Kojima <yk@y-koj.net>
> > 
> > This patch fixes the edge case behavior on ifup/ifdown and
> > linking/unlinking two netdevsim interfaces:
> > 
> > 1. unlink two interfaces netdevsim1 and netdevsim2
> > 2. ifdown netdevsim1
> > 3. ifup netdevsim1
> > 4. link two interfaces netdevsim1 and netdevsim2
> > 5. (Now two interfaces are linked in terms of netdevsim peer, but
> >     carrier state of the two interfaces remains DOWN.)
> > 
> > This inconsistent behavior is caused by the current implementation,
> > which only cares about the "link, then ifup" order, not "ifup, then
> > link" order. This patch fixes the inconsistency by calling
> > netif_carrier_on() when two netdevsim interfaces are linked.
> > 
> > This patch solves buggy behavior on NetworkManager-based systems which
> > causes the netdevsim test to fail with the following error:
> > 
> >   # timeout set to 600
> >   # selftests: drivers/net/netdevsim: peer.sh
> >   # 2025/12/25 00:54:03 socat[9115] W address is opened in read-write mode but only supports read-only
> >   # 2025/12/25 00:56:17 socat[9115] W connect(7, AF=2 192.168.1.1:1234, 16): Connection timed out
> >   # 2025/12/25 00:56:17 socat[9115] E TCP:192.168.1.1:1234: Connection timed out
> >   # expected 3 bytes, got 0
> >   # 2025/12/25 00:56:17 socat[9109] W exiting on signal 15
> >   not ok 13 selftests: drivers/net/netdevsim: peer.sh # exit=1
> > 
> > This patch also fixes timeout on TCP Fast Open (TFO) test because the
> > test also depends on netdevsim.
> > 
> > Fixes: 1a8fed52f7be ("netdevsim: set the carrier when the device goes up")
> 
> Stable rules say:
> 
>    It must either fix a real bug that bothers people or just add a device ID.

Thank you for the quick reply. I don't intend for this patch to be
backported to the stable tree. My understanding was that bugfix patches
to the net tree should have Fixes: tag for historical tracking.

> 
> netdevsim is not a real device. Do its bugs actually bother people?

This patch fixes a real bug that is seen when a developer tries to test
TFO or netdevsim tests on NetworkManager-enabled systems: it causes
false positives in kselftests on such systems.

> Should this patch have a Fixes: tag?

The patch 1a8fed52f7be ("netdevsim: set the carrier when the device goes
up"), which does a similar change, has Fixes: tag. Since this patch fixes
the corner-case behavior which was missed in the previous fix, this
patch should have Fixes: tag for consistency.

> 
>        Andrew

Thank you,
Yohei Kojima

