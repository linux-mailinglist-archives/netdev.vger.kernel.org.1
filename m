Return-Path: <netdev+bounces-290306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F83F/DMDmpoCQYAu9opvQ
	(envelope-from <netdev+bounces-290306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 11:14:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFED05A20B8
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 11:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 638DE315E3F6
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278DE34D90D;
	Thu, 21 May 2026 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="gDr9p2SG"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083BD2F8E99;
	Thu, 21 May 2026 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353859; cv=none; b=iorhYkGtLB3pyXCqkmbzm+bvSh94WwDpgezKQBom2xiRG7ugKFUx0vkKyrgiVg4++6RRVJ0obt+nP8pCu+sTqxQdz/cG4xaNX+6Gzoi44Toc0zAKXNdV1MOkLSajbXZOGYS1gYd5+3pfBwKYL5sZqGuacJoecfnwv5FCCi8xGV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353859; c=relaxed/simple;
	bh=pesH+jtOlrF9vDn7iyBrASt9W6dHBzYtNFCJ36TiLz0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S5bCrUPhqRm+qygzq7peVDL8V3lFupxnhd4WB7eHNlqwHfQ8hdPSDDydRfVBJ1Dzr92o8yQJ1uBmxMzwUTlMQpzifE5jDapZA1sM1eRa3PSGRdDFfv9Lw5FT/888rRCnpmDwi2bMcRb0jlRgrQE2hlVkxacpvOjmLUH/+QYYlyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=gDr9p2SG; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id E47EEA0A82;
	Thu, 21 May 2026 10:47:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:from:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=mail; bh=pesH+jtOl
	rF9vDn7iyBrASt9W6dHBzYtNFCJ36TiLz0=; b=gDr9p2SGPsfNPiBU8hu0eaSvT
	MKdRktfaUYb/7y9G5Za7RssL7Hxemt3wWMBb1w2jFmkLbvrNIUY9sGuhOtwvh7IQ
	5b14WgV1aIsCKUSDZSCnf1tbtuuuKb6MmlCAjfM2al0smQtL+iZDRdtCO40/9eNI
	VhLP877wM1ZnBCDVZmgDxP5vbm/XrqYRl5MKri4qGBQP3y8+23Zroc6igTKMQZmf
	NJdZboyk6jF4qrPwdpspA8ytChoDFdHAMgFxZ5YgTYBZW8nl8MRoyUiqEFygsdUd
	whqV/vZF+gaaBu7JSzuIlcv9nAzQ6EM8rmZeHT9tSfWPpihURyunX98shI0c92Nk
	xMdtNq2y96pxYHDzutY/t93JejzIweSayzZ6Gd7ZYiMc0O12pgz2ArbsxD+Cg8wX
	nr7isYLDFOy3uYH7Z8vP4+TshyLhSf+5qfd7OCEwzCdIrvEzSzbeWvofcl+bV20z
	lo5HPmg8SiWt8MInsZ9WJ/GKLS09DIEeK8Lb1EW1ySsG9r0wZbxB1O/gorMMRhrU
	8Lk8TZ1v99dU3xiV8AnPPLR2+g4KiTVHyiFsPdsMaXbKGe2CuBdxuQ0qYbs8zvPy
	PWSfCOTTNrw3pY9+j2F0gp5wnJIczuw6XnKWHiwnirILwBaPUWC/nirSADAiH7KC
	ZRJDIzE/WqC19TPQdg=
From: Buday Csaba <Buday.Csaba@prolan.hu>
To: =?utf-8?B?TGVvbmFyZG8gTcO2cmxlaW4=?= <leo.moerlein@proton.me>, Andrew Lunn
	<andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Hauke Mehrtens
	<hauke@hauke-m.de>, Russell King <linux@armlinux.org.uk>, Paolo Abeni
	<pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: phy: mdio_device: leave PHY reset deasserted on
 unregister
Thread-Topic: [PATCH net] net: phy: mdio_device: leave PHY reset deasserted on
 unregister
Thread-Index: AQHc6GtSMres8EwZP0yK/8+cmqWjv7YW78mAgAB0rgCAAKYsgA==
Date: Thu, 21 May 2026 08:47:55 +0000
Message-ID: <07bd7806-4bc3-4c61-8cc3-4d534010bf65@prolan.hu>
References: <20260520151355.1371163-1-leo.moerlein@proton.me>
 <57b43ade-2c7b-4eaf-b9fa-406edee0fe44@lunn.ch>
 <hRNIpXMBtfUH-OrabbMVvOWAZ5J4O1XNTvx0lMYIDdSLqFL9hhZKdb3CzPo7VgUrwKi6MD3qlj2li6eHybgzFBB_Wfqu5Lc4dABXt9mpL2s=@proton.me>
In-Reply-To: <hRNIpXMBtfUH-OrabbMVvOWAZ5J4O1XNTvx0lMYIDdSLqFL9hhZKdb3CzPo7VgUrwKi6MD3qlj2li6eHybgzFBB_Wfqu5Lc4dABXt9mpL2s=@proton.me>
Accept-Language: en-US, hu-HU
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2998FD515161736A
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AEB21ED4B6C53458A0FF86211056189@prolan.hu>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[prolan.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[prolan.hu:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290306-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[prolan.hu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Buday.Csaba@prolan.hu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: BFED05A20B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pj4gSSdtIHdvbmRlcmluZyBpZiB3ZSBhcmUgZml4aW5nIHRoZSB3cm9uZyB0aGluZyBoZXJlLg0K
PiANCj4gSW4gZ2VuZXJhbCwgSSBzZWUgdHdvIG9wdGlvbnMgdG8gZml4IHRoaXMuIEVpdGhlciB3
ZSBmaXggdGhlDQo+IHRlYXIgZG93biBvciB3ZSBmaXggdGhlIHNldHVwIG9mIHRoZSBkZXZpY2Uu
DQoNCkkgaGF2ZSBiZWVuIGZpZ2h0aW5nIGEgZGlmZmVyZW50IHByb2JsZW0gd2l0aCBhIHNpbWls
YXIgY2F1c2UuDQoNCi0geW91IHNob3VsZCBub3QgcmVseSBvbiB0aGUgYm9vdGxvYWRlciBzZXR0
aW5nIGFueXRoaW5nIHVwLiBUaGUga2VybmVsDQogICBzaG91bGQgYmUgYWJsZSB0byBwZXJmb3Jt
IHRoZSBpbml0aWFsaXphdGlvbiB3aXRob3V0IGFueSBhc3N1bXB0aW9ucw0KICAgYWJvdXQgYm9v
dGxvYWRlciBPUiBwcmV2aW91cyBzdGF0ZSBiZWhhdmlvci4NCi0gZnJvbSB0aGlzIGZvbGxvd3Ms
IHRoYXQgdGhlIGNvcnJlY3Qgd2F5IHRvIGhhbmRsZSByZXNldHMgaXMgYWx3YXlzDQogICBkdXJp
bmcgdGhlIGluaXRpYWxpemF0aW9uLCBub3QgbGVhdmluZyBpdCBpbiBhIGtub3duIHN0YXRlLg0K
LSBtZGlvX3VucmVnaXN0ZXJfZGV2aWNlKCkgc2hvdWxkIHJldmVyc2UgbWRpb2J1c19yZWdpc3Rl
cl9kZXZpY2UoKS4NCiAgIFRoZSByZXNldCB3YXMgaW4gYW4gdW5rbm93biBzdGF0ZSBiZWZvcmUg
bWRpb2J1c19yZWdpc3Rlcl9kZXZpY2UoKSwNCiAgIHNvIGJvdGggY2FuIGJlIGFyZ3VlZDoNCglh
KSB5b3UgY2FuIGxlYXZlIGl0IGluIGVpdGhlciBzdGF0ZSwgc2luY2UgaXQgd2FzIG5vdCBkZXRl
cm1pbmVkDQoJICAgYmVmb3JlDQoJYikgeW91IHNob3VsZCBsZWF2ZSBpdCBhc3NlcnRlZCwgdG8g
c2F2ZSBwb3dlcg0KDQpJZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5LCB5b3VyIHJlc2V0cyBhcmUg
YXNzZXJ0ZWQgYnkgZGVmYXVsdCAod2hlbiB0aGUgDQpHUElPcyBhcmUgaW5wdXRzKS4NCg0KSSBo
YXZlIHNlbnQgcGF0Y2hlcyB0aGF0IHdvdWxkIGhhdmUgdGFrZW4gY29udHJvbCBvZiByZXNldHMg
YmVmb3JlDQp0aGUgZGV2aWNlIGlzIGVzdGFibGlzaGVkLCBidXQgdGhlcmUgd2VyZSBwcm9ibGVt
cyB3aXRoIHRoYXQuDQpJdCB3b3VsZCBoYXZlIHNlcnZlZCBhIGRpZmZlcmVudCBwdXJwb3NlIChQ
SFkgSUQgYXV0b2RldGVjdGlvbiksIGJ1dCBJIA0KdGhpbmsgaWYgaW1wbGVtZW50ZWQgY29ycmVj
dGx5LCBpdCB3b3VsZCBhbHNvIGhlbHAgeW91ciBzaXR1YXRpb24uDQpSdXNzZWxsIEtpbmcgcmVw
bGllZCB3aXRoIGEgY29uc3RydWN0aXZlIGxldHRlciwgYnV0IEkgbGFja2VkIHRoZSB0aW1lIA0K
c2luY2UgdG8gZG8gYW55dGhpbmcgb24gdGhhdCB0aHJlYWQuDQoNClNlZToNCmh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC81NzAxYTlmYWFmZDE3NjliNjUwYjc5YzJkMGM3MmNjMTBiNWJkYmM4
LjE3NjQzMzc4OTQuZ2l0LmJ1ZGF5LmNzYWJhQHByb2xhbi5odS8jdA0KDQpQbGVhc2UgYWxzbyBj
aGVjayBvdXQgdGhpcyBsZXR0ZXIgYnkgQW5kcmV3IGFib3V0IHRoZSBQSFkgSUQgYXV0b2RldGVj
dGlvbjoNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIzYzFiZWQxLTNmOTUtNDhi
OS04ZmYwLTcxNjk2YmRjZDYyYkBsdW5uLmNoLw0KDQpQZXJoYXBzIHNwZWNpZnlpbmcgdGhlIFBI
WSBJRCB3b3VsZCBoZWxwPyBJdCBkaWQgaGVscCBtZS4NCg0KUmVnYXJkcywNCkNzYWJhDQo=


