Return-Path: <netdev+bounces-148775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E953D9E31CB
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 04:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44D11662F7
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7149027715;
	Wed,  4 Dec 2024 03:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HpTSqFVk"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A188C2CA9
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 03:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281546; cv=none; b=m/vukkH5gy5Id5nlimbiqhL1PWA02ztroSnBYjdIR7zTMjmj4Fz8uFq2UivmJVjx3K4R8B3ba355UzHp+n97xeyLYmgLXGqaTKyEsv0Su6PDyuRPf68PMxueoIu/YBxKRShSBMrlBp/KGVwP6owKjW4+1GydQ/Od1/6kKHoQqlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281546; c=relaxed/simple;
	bh=MqagSgRxv3UoZACW/7sTRfcPEOv3NwF4YuqODsvDWxk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=ugQ+y6SuIZxCNfRSgl8sowq1Oa5WQ/LZNRGh1k/bpwpQBK7lp57Iriz+ibsZdM/R0sfNG6+vOLfjUSauBvVht2PvfRvPwg7BoOoxnJ5LPkYydjsg1JdThyeQrHAdIyxlofg3jZ6GgKnoGpKT2vosCUCyAaLltEu/hNYZEYdhwSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HpTSqFVk; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241204030539epoutp0470a44ad8fd09d796e90d46731a4661fa~N2mBum2Ak0305803058epoutp04p
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 03:05:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241204030539epoutp0470a44ad8fd09d796e90d46731a4661fa~N2mBum2Ak0305803058epoutp04p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733281539;
	bh=9ggKOqFkr3ptsB/ZFlihZvvijwcHyt4a23hwXFS7Zk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HpTSqFVkoqiRWRo7TAfatSk4crPzob25qN3RYj9OZvPpRibHJymnqzztKQEOYuOUr
	 OW6o2fBYHZp1Rw/JwAyeW24xcgQEIxCd7lBic1V5MF2kGdpier2h7bfsWLmw236skm
	 KrAWGnNK4CdCG1uO0UXnzZgHQL2wYzSxXVAi2Gj0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20241204030538epcas2p3242455af5beec52e5eea5c49a02dab8b~N2mBLI87q3250432504epcas2p31;
	Wed,  4 Dec 2024 03:05:38 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.88]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Y32TG10Yfz4x9Pw; Wed,  4 Dec
	2024 03:05:38 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	8E.19.22938.107CF476; Wed,  4 Dec 2024 12:05:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20241204030537epcas2p2af60fd63616a2d4cab0e8523834547b9~N2mALWKYI2754627546epcas2p20;
	Wed,  4 Dec 2024 03:05:37 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241204030537epsmtrp27757578ac3a348ab807476a6ec525277~N2mAKcKuc0528005280epsmtrp2c;
	Wed,  4 Dec 2024 03:05:37 +0000 (GMT)
X-AuditID: b6c32a43-0d1e67000000599a-b9-674fc701c56c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	93.7E.33707.107CF476; Wed,  4 Dec 2024 12:05:37 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241204030537epsmtip183d09644c1c7b276f90171eecf68c4c8~N2l-6y5Yk1637616376epsmtip1J;
	Wed,  4 Dec 2024 03:05:37 +0000 (GMT)
Date: Wed, 4 Dec 2024 12:08:59 +0900
From: Youngmin Nam <youngmin.nam@samsung.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, Youngmin Nam
	<youngmin.nam@samsung.com>, davem@davemloft.net, dsahern@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	dujeong.lee@samsung.com, guo88.liu@samsung.com, yiwang.cai@samsung.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	joonki.min@samsung.com, hajun.sung@samsung.com, d7271.choe@samsung.com,
	sw.ju@samsung.com
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
Message-ID: <Z0/HyztKs8UFBOa0@perf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUxbVRTPfa+89yDr9oCN3SAyfPuIwwBtpfRh6JwytZvIWLYY/Ep9lpeW
	0S/72gmaJQ0OLJXANllECtqBfKwSNgiS2YVNi2mByYcDxqzAAutgohluODKHoO3eXPjvd373
	9zvn3HPuJdCoPiyWyNebWZOe0VJYhKCrZ6c0CfHtV4vaixH6avcJnK4dOiag29wlCD3rrBbQ
	N70zOP1ZFaCLL11B6ZnKXoweu3AbpYe7KsLoEXctRtsmugW01xlDL13+A9AlNxZx+o6vGKcb
	vr+L745UdJ75BVE4OyyKDlcZpli4OIYpKjpdQLHYEZ+DvVmQoWGZPNaUwOpVhrx8vVpOvXpQ
	mamUponESeJ0WkYl6BkdK6f2ZOUkvZyvDbZOJRxhtJYglcNwHJWyK8NksJjZBI2BM8sp1pin
	NcqMyRyj4yx6dbKeNT8nFokk0qDw3QLNTN0wbhxQFdpvUVZgP2QHBAHJVPjToMkOIogo8jyA
	3vI7Aj64C6C9tT3scdAzOhYMwh86/mwdQvmD7wD8fboY4YNpAOvdtXhIJSC3QU/5JBrCGJkE
	u3pXQajeRnIHvGfNDulR8hQKr7U8EIT4aDITrkzIQ3IhuRXOBRxhPI6EfV8EBCEcTh6A/V0B
	EPJCspeAK01ulO9oDxz5sgzhcTSc93XiPI6Fi7e7MR5z0Hrdj/LmYwD2j996ZH4W1sx+AkIY
	JTXQN1mF8IPZCn/0C3h6PbT1rOA8LYS20ijeuQM+qDoHeBwHLzS0PMqogH5fL87PxA/gtUZv
	2HEQX7PmPjVrqtUE06LkTnjWncLTW+DH3zpQnn4CNq8SaxROgLlADGvkdGpWJTGKH69aZdB1
	gIdvOjHzPBj9ajXZAxACeAAkUGqj8MDX+9VRwjym6EPWZFCaLFqW8wBpcE0n0NhNKkPwU+jN
	SnFquig1LU0sk0hFMmqzcKqkLi+KVDNmtoBljazpfx9ChMdakUmvI2vDS7Xt34Cm/r+bF7Yv
	N5daDtr0FuWRtJn6jOrsWef1tGUtEVhaNgyMu9QTbUODTw0z466uw9xsay/+zm/Mz3K7M3rg
	nPL+eEKiDJubePIt47p4qzD29bnc7fGXTkdib586Myh5IetsTEp2RdFHJ+OuKt/w7Mo8/Erp
	6cRF0YZ7P7wXoKFN9qJt89RCy8klyaZtn78f+GfiaAO6t3qfOOMvwyRemDk0+NrTjY5KxFPa
	9Ck+9a+vrjDd1Oi40dQXc1OX4Rm9f7nMNv/BNCyv9zgkSMmVdbnPDFyc8ou987Jfc0cP5Vvp
	9UL2+biIo7srt4ikOaNF+mrFSHN2W7ibEnAaRpyImjjmPzSKY1pcBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnC7jcf90g1lv5Syu7Z3IbjHnfAuL
	xbpdrUwWzxbMYLF4euwRu8XkKYwWTfsvMVs86j/BZnF19ztmiwvb+lgtLu+aw2bRcWcvi8Wx
	BWIW306/YbRoffyZ3eLj8SZ2i8UHPrE7CHpsWXmTyWPBplKPTas62Tze77vK5tG3ZRWjx+dN
	cgFsUVw2Kak5mWWpRfp2CVwZ/+6+Yy54n1Dx4co6tgbGE4FdjJwcEgImEh/WnGcGsYUEtjNK
	9K5OgYjLSNxeeZkVwhaWuN9yBMjmAqq5zyix7Mo1dpAEi4CKxKGeu2DNbAK6EttO/GPsYuTg
	EBFQk/ja4AdSzywwlVlifsMydpC4sICzxN87tiDlvALKEs+fzIaaeYtRYua2yywQCUGJkzOf
	gNnMAuoSf+ZdYgbpZRaQllj+jwMiLC/RvHU22FpOgUCJU9ueME5gFJyFpHsWku5ZCN2zkHQv
	YGRZxSiaWlCcm56bXGCoV5yYW1yal66XnJ+7iREceVpBOxiXrf+rd4iRiYPxEKMEB7OSCG/g
	Ev90Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzKOZ0pQgLpiSWp2ampBalFMFkmDk6pBqZNAknh
	mldz/qzbXb2AqX6VafTxZ3YNi7eVCy9lYTTfFfY+znolt2foiwkNtvPeyaROZzlsznblqvZX
	Lkt33+kxqQsCl37YOlEsxWlW3g9ngSOlGk+Ki76HBt1mlYza4m1SxzyvdofYjodnE8N/cYVP
	/vu5v7VgskvhlIf+Ep3ue/5Xl2z1LeRW+mi0pmzl3/Zo2V/GHxltp7OdW5w9L5N5w96yTW4r
	DF+9s64wP7nZ4vbG629+PHhuMeO/yPMyr7sWcbs5piq3pvc+5DLSmr06d+aRffVKB5zStqQ7
	7siYft/TNZen/aCH8vdbr+e80F10T1in+2XJ20l3Xm/t8XZOeB65PPuB4y1RkyP/1LmVWIoz
	Eg21mIuKEwGAbvHdKwMAAA==
X-CMS-MailID: 20241204030537epcas2p2af60fd63616a2d4cab0e8523834547b9
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----_tVqzgGyW6tMiW3Z4snM0QQCkibZmALk2DMBUp8NwEyQzDMD=_cd8d1_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295
References: <CGME20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295@epcas2p2.samsung.com>
	<20241203081247.1533534-1-youngmin.nam@samsung.com>
	<CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>

------_tVqzgGyW6tMiW3Z4snM0QQCkibZmALk2DMBUp8NwEyQzDMD=_cd8d1_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Hi Eric.
Thanks for looking at this issue.

On Tue, Dec 03, 2024 at 12:07:05PM +0100, Eric Dumazet wrote:
> On Tue, Dec 3, 2024 at 9:10 AM Youngmin Nam <youngmin.nam@samsung.com> wrote:
> >
> > We encountered the following WARNINGs
> > in tcp_sacktag_write_queue()/tcp_fastretrans_alert()
> > which triggered a kernel panic due to panic_on_warn.
> >
> > case 1.
> > ------------[ cut here ]------------
> > WARNING: CPU: 4 PID: 453 at net/ipv4/tcp_input.c:2026
> > Call trace:
> >  tcp_sacktag_write_queue+0xae8/0xb60
> >  tcp_ack+0x4ec/0x12b8
> >  tcp_rcv_state_process+0x22c/0xd38
> >  tcp_v4_do_rcv+0x220/0x300
> >  tcp_v4_rcv+0xa5c/0xbb4
> >  ip_protocol_deliver_rcu+0x198/0x34c
> >  ip_local_deliver_finish+0x94/0xc4
> >  ip_local_deliver+0x74/0x10c
> >  ip_rcv+0xa0/0x13c
> > Kernel panic - not syncing: kernel: panic_on_warn set ...
> >
> > case 2.
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 648 at net/ipv4/tcp_input.c:3004
> > Call trace:
> >  tcp_fastretrans_alert+0x8ac/0xa74
> >  tcp_ack+0x904/0x12b8
> >  tcp_rcv_state_process+0x22c/0xd38
> >  tcp_v4_do_rcv+0x220/0x300
> >  tcp_v4_rcv+0xa5c/0xbb4
> >  ip_protocol_deliver_rcu+0x198/0x34c
> >  ip_local_deliver_finish+0x94/0xc4
> >  ip_local_deliver+0x74/0x10c
> >  ip_rcv+0xa0/0x13c
> > Kernel panic - not syncing: kernel: panic_on_warn set ...
> >
> 
> I have not seen these warnings firing. Neal, have you seen this in the past ?
> 
> Please provide the kernel version (this must be a pristine LTS one).
We are running Android kernel for Android mobile device which is based on LTS kernel 6.6-30.
But we've seen this issue since kernel 5.15 LTS.

> and symbolized stack traces using scripts/decode_stacktrace.sh
Unfortunately, we don't have the matched vmlinux right now. So we need to rebuild and reproduce.
> 
> If this warning was easy to trigger, please provide a packetdrill test ?
I'm not sure if we can run packetdrill test on Android device. Anyway let me check.

FYI, Here are more detailed logs.

Case 1.
[26496.422651]I[4:  napi/wlan0-33:  467] ------------[ cut here ]------------
[26496.422665]I[4:  napi/wlan0-33:  467] WARNING: CPU: 4 PID: 467 at net/ipv4/tcp_input.c:2026 tcp_sacktag_write_queue+0xae8/0xb60
[26496.423420]I[4:  napi/wlan0-33:  467] CPU: 4 PID: 467 Comm: napi/wlan0-33 Tainted: G S         OE      6.6.30-android15-8-geeceb2c9cdf1-ab20240930.125201-4k #1 a1c80b36942fa6e9575b2544032a7536ed502804
[26496.423427]I[4:  napi/wlan0-33:  467] Hardware name: Samsung ERD9955 board based on S5E9955 (DT)
[26496.423432]I[4:  napi/wlan0-33:  467] pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[26496.423438]I[4:  napi/wlan0-33:  467] pc : tcp_sacktag_write_queue+0xae8/0xb60
[26496.423446]I[4:  napi/wlan0-33:  467] lr : tcp_ack+0x4ec/0x12b8
[26496.423455]I[4:  napi/wlan0-33:  467] sp : ffffffc096b8b690
[26496.423458]I[4:  napi/wlan0-33:  467] x29: ffffffc096b8b710 x28: 0000000000008001 x27: 000000005526d635
[26496.423469]I[4:  napi/wlan0-33:  467] x26: ffffff8a19079684 x25: 000000005526dbfd x24: 0000000000000001
[26496.423480]I[4:  napi/wlan0-33:  467] x23: 000000000000000a x22: ffffff88e5f5b680 x21: 000000005526dbc9
[26496.423489]I[4:  napi/wlan0-33:  467] x20: ffffff8a19078d80 x19: ffffff88e9f4193e x18: ffffffd083114c80
[26496.423499]I[4:  napi/wlan0-33:  467] x17: 00000000529c6ef0 x16: 000000000000ff8b x15: 0000000000000000
[26496.423508]I[4:  napi/wlan0-33:  467] x14: 0000000000000001 x13: 0000000000000001 x12: 0000000000000000
[26496.423517]I[4:  napi/wlan0-33:  467] x11: 0000000000000000 x10: 0000000000000001 x9 : 00000000fffffffd
[26496.423526]I[4:  napi/wlan0-33:  467] x8 : 0000000000000001 x7 : 0000000000000000 x6 : ffffffd081ec0bc4
[26496.423536]I[4:  napi/wlan0-33:  467] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffffffc096b8b818
[26496.423545]I[4:  napi/wlan0-33:  467] x2 : 000000005526d635 x1 : ffffff88e5f5b680 x0 : ffffff8a19078d80
[26496.423555]I[4:  napi/wlan0-33:  467] Call trace:
[26496.423558]I[4:  napi/wlan0-33:  467]  tcp_sacktag_write_queue+0xae8/0xb60
[26496.423566]I[4:  napi/wlan0-33:  467]  tcp_ack+0x4ec/0x12b8
[26496.423573]I[4:  napi/wlan0-33:  467]  tcp_rcv_state_process+0x22c/0xd38
[26496.423580]I[4:  napi/wlan0-33:  467]  tcp_v4_do_rcv+0x220/0x300
[26496.423590]I[4:  napi/wlan0-33:  467]  tcp_v4_rcv+0xa5c/0xbb4
[26496.423596]I[4:  napi/wlan0-33:  467]  ip_protocol_deliver_rcu+0x198/0x34c
[26496.423607]I[4:  napi/wlan0-33:  467]  ip_local_deliver_finish+0x94/0xc4
[26496.423614]I[4:  napi/wlan0-33:  467]  ip_local_deliver+0x74/0x10c
[26496.423620]I[4:  napi/wlan0-33:  467]  ip_rcv+0xa0/0x13c
[26496.423625]I[4:  napi/wlan0-33:  467]  __netif_receive_skb_core+0xe14/0x1104
[26496.423642]I[4:  napi/wlan0-33:  467]  __netif_receive_skb_list_core+0xb8/0x2dc
[26496.423649]I[4:  napi/wlan0-33:  467]  netif_receive_skb_list_internal+0x234/0x320
[26496.423655]I[4:  napi/wlan0-33:  467]  napi_complete_done+0xb4/0x1a0
[26496.423660]I[4:  napi/wlan0-33:  467]  slsi_rx_netif_napi_poll+0x22c/0x258 [scsc_wlan 16ac2100e65b7c78ce863cecc238b39b162dbe82]
[26496.423822]I[4:  napi/wlan0-33:  467]  __napi_poll+0x5c/0x238
[26496.423829]I[4:  napi/wlan0-33:  467]  napi_threaded_poll+0x110/0x204
[26496.423836]I[4:  napi/wlan0-33:  467]  kthread+0x114/0x138
[26496.423845]I[4:  napi/wlan0-33:  467]  ret_from_fork+0x10/0x20
[26496.423856]I[4:  napi/wlan0-33:  467] Kernel panic - not syncing: kernel: panic_on_warn set ..

Case 2.
[ 1843.463330]I[0: surfaceflinger:  648] ------------[ cut here ]------------
[ 1843.463355]I[0: surfaceflinger:  648] WARNING: CPU: 0 PID: 648 at net/ipv4/tcp_input.c:3004 tcp_fastretrans_alert+0x8ac/0xa74
[ 1843.464508]I[0: surfaceflinger:  648] CPU: 0 PID: 648 Comm: surfaceflinger Tainted: G S         OE      6.6.30-android15-8-geeceb2c9cdf1-ab20241017.075836-4k #1 de751202c2c5ab3ec352a00ae470fc5e907bdcfe
[ 1843.464520]I[0: surfaceflinger:  648] Hardware name: Samsung ERD8855 board based on S5E8855 (DT)
[ 1843.464527]I[0: surfaceflinger:  648] pstate: 23400005 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[ 1843.464535]I[0: surfaceflinger:  648] pc : tcp_fastretrans_alert+0x8ac/0xa74
[ 1843.464548]I[0: surfaceflinger:  648] lr : tcp_ack+0x904/0x12b8
[ 1843.464556]I[0: surfaceflinger:  648] sp : ffffffc0800036e0
[ 1843.464561]I[0: surfaceflinger:  648] x29: ffffffc0800036e0 x28: 0000000000008005 x27: 000000001bc05562
[ 1843.464579]I[0: surfaceflinger:  648] x26: ffffff890418a3c4 x25: 0000000000000000 x24: 000000000000cd02
[ 1843.464595]I[0: surfaceflinger:  648] x23: 000000001bc05562 x22: 0000000000000000 x21: ffffffc080003800
[ 1843.464611]I[0: surfaceflinger:  648] x20: ffffffc08000378c x19: ffffff8904189ac0 x18: 0000000000000000
[ 1843.464627]I[0: surfaceflinger:  648] x17: 00000000529c6ef0 x16: 000000000000ff8b x15: 0000000000000001
[ 1843.464642]I[0: surfaceflinger:  648] x14: 0000000000000001 x13: 0000000000000001 x12: 0000000000000000
[ 1843.464658]I[0: surfaceflinger:  648] x11: ffffff883e9c9540 x10: 0000000000000001 x9 : 0000000000000001
[ 1843.464673]I[0: surfaceflinger:  648] x8 : 0000000000000000 x7 : 0000000000000000 x6 : ffffffd081ec0bc4
[ 1843.464689]I[0: surfaceflinger:  648] x5 : 0000000000000000 x4 : ffffffc08000378c x3 : ffffffc080003800
[ 1843.464704]I[0: surfaceflinger:  648] x2 : 0000000000000000 x1 : 000000001bc05562 x0 : ffffff8904189ac0
[ 1843.464720]I[0: surfaceflinger:  648] Call trace:
[ 1843.464725]I[0: surfaceflinger:  648]  tcp_fastretrans_alert+0x8ac/0xa74
[ 1843.464735]I[0: surfaceflinger:  648]  tcp_ack+0x904/0x12b8
[ 1843.464743]I[0: surfaceflinger:  648]  tcp_rcv_state_process+0x22c/0xd38
[ 1843.464751]I[0: surfaceflinger:  648]  tcp_v4_do_rcv+0x220/0x300
[ 1843.464760]I[0: surfaceflinger:  648]  tcp_v4_rcv+0xa5c/0xbb4
[ 1843.464767]I[0: surfaceflinger:  648]  ip_protocol_deliver_rcu+0x198/0x34c
[ 1843.464776]I[0: surfaceflinger:  648]  ip_local_deliver_finish+0x94/0xc4
[ 1843.464784]I[0: surfaceflinger:  648]  ip_local_deliver+0x74/0x10c
[ 1843.464791]I[0: surfaceflinger:  648]  ip_rcv+0xa0/0x13c
[ 1843.464799]I[0: surfaceflinger:  648]  __netif_receive_skb_core+0xe14/0x1104
[ 1843.464810]I[0: surfaceflinger:  648]  __netif_receive_skb+0x40/0x124
[ 1843.464818]I[0: surfaceflinger:  648]  netif_receive_skb+0x7c/0x234
[ 1843.464825]I[0: surfaceflinger:  648]  slsi_rx_data_deliver_skb+0x1e0/0xdbc [scsc_wlan 12b378a8d5cf5e6cd833136fc49079d43751bd28]
[ 1843.465025]I[0: surfaceflinger:  648]  slsi_ba_process_complete+0x70/0xa4 [scsc_wlan 12b378a8d5cf5e6cd833136fc49079d43751bd28]
[ 1843.465219]I[0: surfaceflinger:  648]  slsi_ba_aging_timeout_handler+0x324/0x354 [scsc_wlan 12b378a8d5cf5e6cd833136fc49079d43751bd28]
[ 1843.465410]I[0: surfaceflinger:  648]  call_timer_fn+0xd0/0x360
[ 1843.465423]I[0: surfaceflinger:  648]  __run_timers+0x1b4/0x268
[ 1843.465432]I[0: surfaceflinger:  648]  run_timer_softirq+0x24/0x4c
[ 1843.465440]I[0: surfaceflinger:  648]  __do_softirq+0x158/0x45c
[ 1843.465448]I[0: surfaceflinger:  648]  ____do_softirq+0x10/0x20
[ 1843.465455]I[0: surfaceflinger:  648]  call_on_irq_stack+0x3c/0x74
[ 1843.465463]I[0: surfaceflinger:  648]  do_softirq_own_stack+0x1c/0x2c
[ 1843.465470]I[0: surfaceflinger:  648]  __irq_exit_rcu+0x54/0xb4
[ 1843.465480]I[0: surfaceflinger:  648]  irq_exit_rcu+0x10/0x1c
[ 1843.465489]I[0: surfaceflinger:  648]  el0_interrupt+0x54/0xe0
[ 1843.465499]I[0: surfaceflinger:  648]  __el0_irq_handler_common+0x18/0x28
[ 1843.465508]I[0: surfaceflinger:  648]  el0t_64_irq_handler+0x10/0x1c
[ 1843.465516]I[0: surfaceflinger:  648]  el0t_64_irq+0x1a8/0x1ac
[ 1843.465525]I[0: surfaceflinger:  648] Kernel panic - not syncing: kernel: panic_on_warn set ...

> > When we check the socket state value at the time of the issue,
> > it was 0x4.
> >
> > skc_state = 0x4,
> >
> > This is "TCP_FIN_WAIT1" and which means the device closed its socket.
> >
> > enum {
> >         TCP_ESTABLISHED = 1,
> >         TCP_SYN_SENT,
> >         TCP_SYN_RECV,
> >         TCP_FIN_WAIT1,
> >
> > And also this means tp->packets_out was initialized as 0
> > by tcp_write_queue_purge().
> 
> What stack trace leads to this tcp_write_queue_purge() exactly ?
I couldn't find the exact call stack to this.
But I just thought that the function would be called based on ramdump snapshot.

(*(struct tcp_sock *)(0xFFFFFF800467AB00)).packets_out = 0
(*(struct inet_connection_sock *)0xFFFFFF800467AB00).icsk_backoff = 0

> >
> > In a congested network situation, a TCP ACK for
> > an already closed session may be received with a delay from the peer.
> > This can trigger the WARN_ON macro to help debug the situation.
> >
> > To make this situation more meaningful, we would like to call
> > WARN_ON only when the state of the socket is "TCP_ESTABLISHED".
> > This will prevent the kernel from triggering a panic
> > due to panic_on_warn.
> >
> > Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
> > ---
> >  net/ipv4/tcp_input.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 5bdf13ac26ef..62f4c285ab80 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -2037,7 +2037,8 @@ tcp_sacktag_write_queue(struct sock *sk, const struct sk_buff *ack_skb,
> >         WARN_ON((int)tp->sacked_out < 0);
> >         WARN_ON((int)tp->lost_out < 0);
> >         WARN_ON((int)tp->retrans_out < 0);
> > -       WARN_ON((int)tcp_packets_in_flight(tp) < 0);
> > +       if (sk->sk_state == TCP_ESTABLISHED)
> 
> In any case this test on sk_state is too specific.
Yes. I agree as wll. Do you have any idea to avoid a kernel panic that we are going through ?

> > +               WARN_ON((int)tcp_packets_in_flight(tp) < 0);
> >  #endif
> >         return state->flag;
> >  }
> > @@ -3080,7 +3081,8 @@ static void tcp_fastretrans_alert(struct sock *sk, const u32 prior_snd_una,
> >                 return;
> >
> >         /* C. Check consistency of the current state. */
> > -       tcp_verify_left_out(tp);
> > +       if (sk->sk_state == TCP_ESTABLISHED)
> > +               tcp_verify_left_out(tp);
> >
> >         /* D. Check state exit conditions. State can be terminated
> >          *    when high_seq is ACKed. */
> > --
> > 2.39.2
> >
> 

------_tVqzgGyW6tMiW3Z4snM0QQCkibZmALk2DMBUp8NwEyQzDMD=_cd8d1_
Content-Type: text/plain; charset="utf-8"


------_tVqzgGyW6tMiW3Z4snM0QQCkibZmALk2DMBUp8NwEyQzDMD=_cd8d1_--

