Return-Path: <netdev+bounces-136997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A579A9A3E5A
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B46285530
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653EE1CABA;
	Fri, 18 Oct 2024 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdomi.pl header.i=@sdomi.pl header.b="W2uTPuKF"
X-Original-To: netdev@vger.kernel.org
Received: from mail.sakamoto.pl (mail.sakamoto.pl [185.236.240.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C8F8F6B
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 12:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.236.240.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254516; cv=none; b=AgC1QgReae+QgDy6MzjJzCbmwm48FvRgAlh9Xo2hy8sAxsOWeCKmi9Y5LZtjAogWiX1jfJxehYjpSZo9NhwWl38RHh35TnC93kx4xEQCzBNW8BLP4Iyfh3sZ1Wzodv9TzYHemHzbL+HEWMK8y6V2OddDTqBkVdIkM6wLlS1gxnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254516; c=relaxed/simple;
	bh=P6IsbH+nZkv6eZ26hDpz1oRZ+3Cmmi3ObKHQv6Ej3CU=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=j3Kks0D5/KcciCSLdpt9A9GdE4xOiVAreBtTqDZD7N9CP+TF4rAF6+qVhudoWj0IIY+ZhSkXAyZUAVmneVbD7J/EAG2/uZoB+U6jUtPiaeCtcpB2ZQSYHYkCWFmu6HFt8y0N4aaRC5wf35HTPuiyuyZ9VjTsYUssugcwDr54/f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sdomi.pl; spf=pass smtp.mailfrom=sdomi.pl; dkim=pass (2048-bit key) header.d=sdomi.pl header.i=@sdomi.pl header.b=W2uTPuKF; arc=none smtp.client-ip=185.236.240.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sdomi.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdomi.pl
Authentication-Results: mail.sakamoto.pl;
	auth=pass (login)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Oct 2024 13:27:26 +0100
From: sdomi <ja@sdomi.pl>
To: netdev@vger.kernel.org
Subject: iproute2: unexpected expansion of IPv4 addresses
Message-ID: <8c354331845a3ac599e84c3759da5944@sdomi.pl>
X-Sender: ja@sdomi.pl
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Received: from localhost (Unknown [127.0.0.1])
	by mail.sakamoto.pl (Haraka/3.0.3) with ESMTPSA id 90D2A1BB-332C-4916-9A38-C47D9C39EE8F.1
	envelope-from <ja@sdomi.pl>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Fri, 18 Oct 2024 14:27:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=sdomi.pl; s=s20200821613;
	h=from:subject:date:message-id:to:mime-version;
	bh=P6IsbH+nZkv6eZ26hDpz1oRZ+3Cmmi3ObKHQv6Ej3CU=;
	b=W2uTPuKF1QRBroAkWxzAWUYeuuPwAx+8NZmr+b0sfjxyipgOac/Usk1Vb2gvKXVl8TFjUuDhXJ
	5vJcIxRykYZJQdAEbqT9lNLJkJcXI/8QhLztt0odyHCormbeib5lQRzoMn+sS9Amc6n9OYUryfX8
	JzlfOVFrlINShmWDc3udGyBi/wpC40RRnDytUxhynPdOnIn5NtHLAv/QHzByyok77OAJq1da+QeB
	VJ9SkKCtnMlJ4/+x+s7N+6jRb6N/C1RjZKGkG4Hch9INtsXMteDbqULac3uFf+BqM0lbSye919GS
	8qhj6I6dnfFlbSLuTvQhkBOOZaPNbboMW0SNDAjg==

Hi,

I'm running iproute2-6.10.0 (from Alpine edge repositories), and I 
noticed that when manipulating the routes using short-hand addresses, 
the expansion is conducted in an unusual manner:

`ip r a 1.1 via 127.1` will result in `1.1.0.0 via 127.1.0.0 dev lo`, 
while I'd expect it to be equivalent to `ip r a 1.0.0.1 via 127.0.0.1`.

The same issue is present when manipulating addresses (e.g. `ip a a 
127.1.1 dev lo` results in `127.1.1.0` instead of `127.1.0.1`)

FWIW, I wasn't able to find an RFC which specified how this should be 
implemented, and the deeper I look into it, the more it feels like a 
40-year old BSD4.2 quirk that somehow lives on. Nonetheless, I think it 
would be nice to either validate against using shorthands (as it can 
cause confusion), or mimic what `ping` and other such utilities do.

~sdomi

