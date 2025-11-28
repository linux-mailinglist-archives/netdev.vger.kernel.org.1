Return-Path: <netdev+bounces-242528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DFEC91669
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 10:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8C43AB4F2
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 09:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A906305962;
	Fri, 28 Nov 2025 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="XED1E763"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0AA307AEC
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764321369; cv=none; b=iRkv/f+fpeqBFu3AnJvLv0r+uTQaq2xeHm+/f0oCy5bhESMxTQigE487qF8G9RaHQxFdxN2BSPeIOka7OGGephQQUjNuZQd44gXJ6GKhXkfEbNO1Ycfop6xD1n63SS0REHa/lS0Gg+uN+pEuL3N8IwnDPpb54TSEcyP4rNenENA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764321369; c=relaxed/simple;
	bh=bme314r0R4rZn3g7Bo/m6PyuaJzoMliuBMysZpO/g6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gG77AEPiCoYgOwh/1MDPpTk2cXS+4U/UPC1CNgnev+oXJ7MLa9lfBDqGlZ13Pxfiw9sZ+B4iI7gYYS4LGdjJ8nNc8ZMOUOiJHBucdj4ef9oD53WFsUp+JmJO+mhh3590Tx+w2ftZsn97ncFo9xPq1vj7mOHGwWqxxaletXnFikM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=XED1E763; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1764321362; bh=bme314r0R4rZn3g7Bo/m6PyuaJzoMliuBMysZpO/g6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XED1E763B/lj4snXCfMX/DZBsZpstzVlrEkYxyPIf9Wp+WG7MDF83RO66R7fOXga8
	 /RvsgI6ZfQdDY49mCGtnX9P1HhezWj2P8dmCmvZ8jsZTkllfEsfIK6Qpf9qNR9LRPx
	 XLfgh+z6Qv1XVJyjHOi4Y0GrraNfGoD66wO3g7iV3sXQ+hnu/BYCVdbe5uFW3rWlQ6
	 O21N0l9/S5kymjPLuzm6bV0lBzX3sRCILbYwWUMLr7EBGiSnT1/RgRF+yjai8JYAg/
	 3yNnNroXzqTbABRy8rT5dQwWSjrf1TAYydlR/tWedBD8XON9PHeEJl0mijCkTgWw1s
	 tuspce6GZhxkw==
To: Xiang Mei <xmei5@asu.edu>, security@kernel.org
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com,
 cake@lists.bufferbloat.net, bestswngs@gmail.com, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v8 2/2] selftests/tc-testing: Test CAKE scheduler
 when enqueue drops packets
In-Reply-To: <20251128001415.377823-3-xmei5@asu.edu>
References: <20251128001415.377823-1-xmei5@asu.edu>
 <20251128001415.377823-3-xmei5@asu.edu>
Date: Fri, 28 Nov 2025 10:16:02 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87fr9ybjql.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Xiang Mei <xmei5@asu.edu> writes:

> Add tests that trigger packet drops in cake_enqueue(): "CAKE with QFQ
> Parent - CAKE enqueue with packets dropping". It forces CAKE_enqueue to
> return NET_XMIT_CN after dropping the packets when it has a QFQ parent.
>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

