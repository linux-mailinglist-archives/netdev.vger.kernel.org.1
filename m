Return-Path: <netdev+bounces-242207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C24AC8D766
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA96334AC4C
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 09:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9321532694B;
	Thu, 27 Nov 2025 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="IfgwrT81"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A2B326923
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 09:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764234883; cv=none; b=ofPTPd9mrfD1qF8bP1rTrhdIkTw3yKy57Iv+mMcVdVSTPl5myWU6xYYnW9FU13DdPQSNJeUVI9v1Zwff+fP6xmucuocUWp9QADLsXbKGp1nbtFUcpg8CbIBuJm4g08YkxVs0BJXDpMhBCLaFQEB3SWE/XUMb0MQgKE43Tkv2zII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764234883; c=relaxed/simple;
	bh=bme314r0R4rZn3g7Bo/m6PyuaJzoMliuBMysZpO/g6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lOUeJxe645rkTrzvJbmkO0t7tajcmb5yLRqCs5429AZA3CVQ5R1ZqV6Pn7DAKMmHTnMqmeTPPjxMRx5Vj6VBU6kzHZV1SzDClMJbNdzibW9Zz7W/VjKCGnCzfRN967heo4kSsuEsOrDblUhHqqtGrnphJWz7HBWi/lyzcMm8Utw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=IfgwrT81; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1764234879; bh=bme314r0R4rZn3g7Bo/m6PyuaJzoMliuBMysZpO/g6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IfgwrT817R/ZULL6EwtEhIypNNMWBpEQ6TQ6OukOL2fB+I2CqVGA0dstrRGyMMUXI
	 /Iq5AXcYYgSYVVwHj44je3WIFFX61LcRkB37IqnFSgW8OijjF0lTGh4XL2PwA5EfH6
	 3tWWv1whP0OE5s3K50QjdGGM8HsF+eppRa0UeIq22EImjNsPVSKL1fSr4lkV8VeyYP
	 T7uelm8si9Kq8u98a/brh2K81z6VsMSdw6+k39WqaVVIt6kvBQ/6nVW4kSdc0vBsyd
	 5FOCatXNdbExQC83deo0HLu75DLpuPb+OOKKPRk0Mz3JUIeRHGFBLLn9iblWKa3nOl
	 sg8GobJUty4bg==
To: Xiang Mei <xmei5@asu.edu>, security@kernel.org
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com,
 cake@lists.bufferbloat.net, bestswngs@gmail.com, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v7 2/2] selftests/tc-testing: Test CAKE scheduler
 when enqueue drops packets
In-Reply-To: <20251126194513.3984722-2-xmei5@asu.edu>
References: <20251126194513.3984722-1-xmei5@asu.edu>
 <20251126194513.3984722-2-xmei5@asu.edu>
Date: Thu, 27 Nov 2025 10:14:39 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87tsyfbzwg.fsf@toke.dk>
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

