Return-Path: <netdev+bounces-178222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A9DA759B5
	for <lists+netdev@lfdr.de>; Sun, 30 Mar 2025 13:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A5B1886B1D
	for <lists+netdev@lfdr.de>; Sun, 30 Mar 2025 11:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D95C18784A;
	Sun, 30 Mar 2025 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HnKcGhCF"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F8D149C55;
	Sun, 30 Mar 2025 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743332977; cv=none; b=XY+vOiHL9U7nicQigDq56Z61Bfd3YMvSymBWMCbAFtscN/PP9bLynwD3uD0xL/p3tYb4MjLiHb1yvjHi9DU+BxgWqeSkFl3oy/yFp4Rif3aGGbqqA1rhiNUxujNPjpM/D+v8+c42dyxyE/N5VTrxeVXE5lSECPTDSkzQfHELmfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743332977; c=relaxed/simple;
	bh=6L25GE0MjKdrLEZF3H7DMdT7li1y4IAdnXKXHnFok6Q=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=rx3mYk0wuHX5fublGGsbPj8cPudhXJjRbi+UDc5bJOgfLwY2QlSfBxrDIJ6ppz2iOBUztwPCS43mxEv7Th+msMqa3jHSljnZ7eu+uKGLdspYYtfWJotpNR9e1O3LZIZIjOXFl27cENFtSB09T7BfqAvqDn8OhznsfFyc5bzXpd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HnKcGhCF; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Mime-Version:Message-ID:
	Content-Type; bh=6L25GE0MjKdrLEZF3H7DMdT7li1y4IAdnXKXHnFok6Q=;
	b=HnKcGhCFJtTDkm2L0lQ/GbV47VtQscqkRGp5TYmX852gj/jrQyi9PTqbXEqs8f
	0VnkKoB98G5EvUYgGpJVufH5aOiwk9fHGj2K/W/fsIe767asp/Y/y1r6WSxYwhaw
	iPLPhUgdYbSgiAvs1gM2qGisv7myM8UmmGHOBGAIlbPB8=
Received: from WIN-S4QB3VCT165 (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAn8v9UJulnZlqlBQ--.26173S2;
	Sun, 30 Mar 2025 19:09:10 +0800 (CST)
Date: Sun, 30 Mar 2025 19:09:10 +0800
From: "mowenroot@163.com" <mowenroot@163.com>
To: "Paul Moore" <paul@paul-moore.com>, 
	kuba <kuba@kernel.org>
Cc: 1985755126 <1985755126@qq.com>, 
	netdev <netdev@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] netlabel: Fix NULL pointer exception caused by CALIPSO on IPv4 sockets
References: <20250326074355.24016-1-mowenroot@163.com>, 
	<CAHC9VhRUq0yjGLhGf=GstDb8h5uC_Hh8W9zXkJRMXAgbNXQTZA@mail.gmail.com>, 
	<20250328050242.7bec73be@kernel.org>, 
	<CAHC9VhRvrOCqBT-2xRF5zrkeDN3EvShUggOF=Uh47TXFc5Uu1w@mail.gmail.com>
X-Priority: 3
X-GUID: FD9EE270-3FB3-4D7E-A082-8AE943683651
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.331[cn]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <202503301909090753553@163.com>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
X-CM-TRANSID:PigvCgAn8v9UJulnZlqlBQ--.26173S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUF6pPUUUUU
X-CM-SenderInfo: pprzv0hurr3qqrwthudrp/1tbiEwgglGfpJeIJ+wAAsU

SGkgUGF1bCwgSmFrdWIsIGFuZCBhbGwgbWFpbnRhaW5lcnMsCgpUaGFua3MgZm9yIHlvdXIgcmV2
aWV3IGFuZCBzdWdnZXN0aW9ucy4KCkkgaGF2ZSBzdWJtaXR0ZWQgdGhlIHYyIHBhdGNoIGFuZCBt
YWRlIHRoZSBmb2xsb3dpbmcgaW1wcm92ZW1lbnRzOgoKLSBBZGRlZCBhIGJsYW5rIGxpbmUgYmV0
d2VlbiBsb2NhbCB2YXJpYWJsZSBkZWNsYXJhdGlvbnMgYW5kIHRoZSBtYWluIGxvZ2ljIGZvciBi
ZXR0ZXIgcmVhZGFiaWxpdHkuCi0gUmVtb3ZlZCB1bm5lY2Vzc2FyeSBjb21tZW50cyBhcyB0aGUg
Y29kZSBpcyBzZWxmLWV4cGxhbmF0b3J5LgotIEltcHJvdmVkIHRoZSBjb21taXQgbWVzc2FnZSBh
bmQgaW5jbHVkZWQgbW9yZSBkZXRhaWxlZCBpbmZvcm1hdGlvbiwgaW5jbHVkaW5nIHRoZSByZXBy
b2R1Y2VyIHN0ZXBzLgoKTWFueSB0aGFua3MgdG8gUGF1bCBmb3IgeW91ciBjYXJlZnVsIGd1aWRh
bmNl4oCUeW91IGFyZSBhIGdyZWF0IHRlYWNoZXIuCgpUaGFua3MgYWdhaW4gZm9yIHlvdXIgZmVl
ZGJhY2shCgpUaGFua3MgYWdhaW4uCiBEZWJpbiBaaHUgJiBCaXRhbyBPdXlhbmcKCi0tCm1vd2Vu
cm9vdEAxNjMuY29tCg==


