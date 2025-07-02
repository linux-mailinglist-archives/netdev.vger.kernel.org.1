Return-Path: <netdev+bounces-203171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F875AF0ABA
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 07:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC181C0201E
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 05:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EB735973;
	Wed,  2 Jul 2025 05:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="nVa3KGbc"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CA010F9
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 05:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751434121; cv=none; b=M4JDSB9RhiRXLiKdcr7yp96m4E6XPeGkCOpl6tZkmaC1+FIdfo+3DcAJu3L8Y/yQgUFV0ZgZFomxkO7QrCeBqQeQsRe6F/rUftIDSf/fm1sumbFq4HqlGXEIMjNChcqb4NFyL16AtZCpAfCr7rstblVc94MejvtgHxg4flReCHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751434121; c=relaxed/simple;
	bh=Ev4viFeE2Xd4gwQJqWrGh3J0b9l9tGnDfVjNl1C7HEs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gD4iLk8ZA3eP2wymUy4N4kVo1utSPoLMxEdEauyxfJjHGNuF46+wRx7lRUC1hchSJaECiDnJSJJKNWs+imarKR2EUNutd8vXiGpnOfzF8PqyODSz7jMMVHPvd//nExLVBQPtuV/8ezvZ2Fu4H6x3Y12Ylioxw2bNo00T99BW9pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=nVa3KGbc; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751434115;
	bh=Ev4viFeE2Xd4gwQJqWrGh3J0b9l9tGnDfVjNl1C7HEs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nVa3KGbcYUidDrTrwW+qS88TzVqHviiMuHj5mkwEdUZWF3kDK5ZhBFIOR5AGH0t8p
	 ++zze2OEQMtcsIQWqbVdoWSQi+6vupaLsjvyM9mhBEfoN3YCxeOpTzJB0I331roRa2
	 ui3asDaZPLKI+2CtLUa94I0kaNJ/UoQg5+glwUQZsxJu5DUS9GprcHHQSpSr7eV7iO
	 68ro/Pm0N1m8IzDATAZ1btoFp0dlA/y9fNFZeZ4ZHKYeFet6P7Jlxcnv9M5wCrdcA4
	 mQtat5jIJdqrlKacJqV2tSS7jatktH6i/ymFE76MW87F55F24+yQchVo58ywndlnyU
	 6lldo0UcYZOyg==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 89CBF6A6BB;
	Wed,  2 Jul 2025 13:28:35 +0800 (AWST)
Message-ID: <d59148bad48ac9296ca67fcbffa4076630ba8f63.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v4 12/14] net: mctp: allow NL parsing directly
 into a struct mctp_route
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Paolo Abeni <pabeni@redhat.com>, Matt Johnston
 <matt@codeconstruct.com.au>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon
 Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Date: Wed, 02 Jul 2025 13:28:35 +0800
In-Reply-To: <f3bc7bb7-acc5-4087-af3c-120b82bd7b51@redhat.com>
References: <20250627-dev-forwarding-v4-0-72bb3cabc97c@codeconstruct.com.au>
	 <20250627-dev-forwarding-v4-12-72bb3cabc97c@codeconstruct.com.au>
	 <f3bc7bb7-acc5-4087-af3c-120b82bd7b51@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgUGFvbG8sCgo+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKGRldi0+ZmxhZ3MgJiBJRkZfTE9PUEJB
Q0spIHsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBOTF9TRVRfRVJSX01TRyhl
eHRhY2ssICJubyByb3V0ZXMgdG8gbG9vcGJhY2siKTsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsKPiA+IC3CoMKgwqDCoMKgwqDCoH0KPiAKPiBJdCBs
b29rcyBsaWtlIHRoZSBhYm92ZSB0ZXN0IGlzIG5vdCBwZXJmb3JtZWQgYW55bW9yZS4gSXMgdGhh
dAo+IGludGVudGlvbmFsPwoKTm8sIG5vdCBpbnRlbnRpb25hbCAtIHRoaXMgd2FzIHJlbW92ZWQg
ZnJvbSB0aGUgcGFyc2luZyBjb2RlLCBidXQgbm90CnJlaW5zdGF0ZWQgaW4gdGhlIHJvdXRlIGhh
bmRsaW5nIHNpZGUuIEkgaGF2ZSBhZGRlZCBpdCBiYWNrLCB2NSBjb21pbmcKc2hvcnRseS4KCkNo
ZWVycywKCgpKZXJlbXkKCg==


