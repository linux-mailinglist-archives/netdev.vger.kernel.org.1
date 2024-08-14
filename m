Return-Path: <netdev+bounces-118380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 278B49516E8
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A51A1C20BA5
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510341428EA;
	Wed, 14 Aug 2024 08:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuroa.me header.i=@kuroa.me header.b="c3uJOsh/"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10021201.me.com (pv50p00im-ztdg10021201.me.com [17.58.6.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720281411E9
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 08:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625192; cv=none; b=pmzOSFJBN+hA5CBJuNMF1wepblrCWNVSiqWLcMtDGq6/FgH6Jt5BwSzQFYMiWZAHhCCEw69HzYPjp1GsXoyNkIdavFEbjGnUpE+p/XvEXF57aQaDFefsje3f07TP4vrdCYWjDGzHyDCerU+WRn0XwlBq/rPJNo4EUEG10qOqqkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625192; c=relaxed/simple;
	bh=/hpzqpKqwgFZ6tNT5IHE8aXb2qaoDVbi2mxpNjL8NGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=luvd7R5T4tpSy7QRrIJDYxfHFPc0MGpEZioJgJtzOPClV37nY609fsMu8WUbgglM6lk5k12LHGcUG4q9QfDl2MSjGCr2MOWT1qQEpfQrZc7+3UJrwAhYDnG4dvE48b2zQ8M7l44HqnsSFyaHp22Rnd2K3LAc0jaS3/o08ofpHag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuroa.me; spf=pass smtp.mailfrom=kuroa.me; dkim=pass (2048-bit key) header.d=kuroa.me header.i=@kuroa.me header.b=c3uJOsh/; arc=none smtp.client-ip=17.58.6.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuroa.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuroa.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuroa.me; s=sig1;
	t=1723625190; bh=39zkGYyVnIKAzoCRWGuhrYmjBOmesy3MMUslrQoA4xg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	b=c3uJOsh/IoJUki4AlHCKCYKcgB0Vq1nlEOhcSus7BVAiRfZSqzpZOnfC18J54VYy6
	 8icQoDS57nLVJd6x8FSPv6gUq+z7FUVlNGVZkHA4H1+RY0FnhxTE3tiJ/urbk/iuug
	 4DFa3NuNJCZEWUHpdK0JwDnVmJVRIwIw/iZzPGYyD++bIILsTvdUDHvkRyDCBEbvWk
	 YnEVWvuq5QBSqFIqo7xlmUNIx60yqDQKwMqcMTcRtB4qdCJYBbY/9MQPRfLI/+cEa7
	 74OxWt2nj9v9v9VEOQ2g0Mv/jxIUlKm7q0EpQhCaliQHOXnYx8jBNpLSvGBCPQWPob
	 zrZdxy7zvx0CQ==
Received: from tora.kuroa.me (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPSA id 48B2A680249;
	Wed, 14 Aug 2024 08:46:25 +0000 (UTC)
From: Xueming Feng <kuro@kuroa.me>
To: Lorenzo Colitti <lorenzo@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	David Ahern <dsahern@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net,v2] tcp: fix forever orphan socket caused by tcp_abort
Date: Wed, 14 Aug 2024 16:46:22 +0800
Message-Id: <20240814084622.555672-1-kuro@kuroa.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAKD1Yr3i+858zNvSwbuFLiBHS52xhTw5oh6P-sPgRNcMbWEbhw@mail.gmail.com>
References: <CAKD1Yr3i+858zNvSwbuFLiBHS52xhTw5oh6P-sPgRNcMbWEbhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6DSkcaNRO_fXaO2-XM1-Ua1mTKugqRoD
X-Proofpoint-ORIG-GUID: 6DSkcaNRO_fXaO2-XM1-Ua1mTKugqRoD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_06,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1030 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=607 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408140061

On Mon, Aug 14, 2024 at 7:34 AM Lorenzo Colitti <lorenzo@google.com> wrote:
> On Mon, Aug 12, 2024 at 7:53 PM Xueming Feng <kuro@kuroa.me> wrote:
> > The -ENOENT code comes from the associate patch Lorenzo made for
> > iproute2-ss; link attached below.
> 
> ENOENT does seem reasonable. It's the same thing that would happen if
> userspace passed in a nonexistent cookie (we have a test for that).

In the latest TCP RFC 9293, section 3.10.5 on the ABORT CALL, it mentions
that an "error: connection does not exist" to be returned for a CLOSED 
STATE. I noticed this while verifying whether a reset in the FIN-WAIT 
STATE is legal, which it is.

> I'd guess this could happen if userspace was trying to destroy a
> socket but it lost the race against the process owning a socket
> closing it?

Yes, that’s exactly the scenario I'm addressing. I tested this locally
by calling tcp_diag twice with the same socket pointer.

> 
> >        bh_unlock_sock(sk);
> >        local_bh_enable();
> > -       tcp_write_queue_purge(sk);
> 
> Is this not necessary in any other cases? What if there is
> retransmitted data, shouldn't that be cleared?

The tcp_write_queue_purge() function is indeed invoked within 
tcp_done_with_error(). In this patch, the tcp_done_with_error is elevated
to the same logical level where tcp_write_queue_purge would typically be 
called. The difference is that the purge happens just before tcp_done.
So the queue should still be cleared in other scenarios as well.

