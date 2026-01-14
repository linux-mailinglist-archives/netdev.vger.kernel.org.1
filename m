Return-Path: <netdev+bounces-249733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F854D1CCB3
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 08:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C46853009746
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 07:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C749C35A945;
	Wed, 14 Jan 2026 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=edu.ge.ch header.i=@edu.ge.ch header.b="BSOkvRFZ"
X-Original-To: netdev@vger.kernel.org
Received: from gwsmtp.ge.ch (smtpsw24.ge.ch [160.53.250.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351DD357A56;
	Wed, 14 Jan 2026 07:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.53.250.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768375165; cv=none; b=WrAcd8hRjVsAQtaRo+K+qpcFQuTCr0MYwqbus53tGV53K4Ib61wnGyphJW6hIBi31Yw5OvRNYBaQGd5TAWKkhpVBEWA0It/mleusgErobfMke9ulLqf8884UAWrofDoZEW4wrMu+LFZRhDC7PFec+OBgPVzL6F+OSHB/KX2zWe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768375165; c=relaxed/simple;
	bh=w2JQbYike37s8pXtIOzlkR0AUFRs7qVn2gHkmKt7qwQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HXjjxToTGxSYXF7Ulic7yMA652o3nkJv+mnyG0NS1+dPO9uS9vJvOAWd+lgo4itM3aT7eMd7HL+TnUCX7/sIDbuwSKrS4gaPl4dzEzjfdez5YW7CjOhqRXZAq3t8QXc24SYZLcDsVi/3Mk8bO5CTY4mg/IMg7jpTklnInvCcO+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=edu.ge.ch; spf=pass smtp.mailfrom=edu.ge.ch; dkim=pass (2048-bit key) header.d=edu.ge.ch header.i=@edu.ge.ch header.b=BSOkvRFZ; arc=none smtp.client-ip=160.53.250.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=edu.ge.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edu.ge.ch
From: "Wenger Jeremie (EDU)" <jeremie.wenger@edu.ge.ch>
To: Jakub Kicinski <kuba@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>
Subject: RE: [REGRESSION] e1000e: RX stops after link down/up on Intel
 8086:550a since v6.12.43 (fixed by suspend/resume)
Thread-Index: AQHcgKY4vqPf4k7m6ECp9OMR6mOttLVJlHgAgAdTJwCAAGBwmA==
Date: Wed, 14 Jan 2026 07:19:12 +0000
Message-ID: <33854287fd02403093ff9f7dfa6412f1@edu.ge.ch>
References: <c8bd43a3053047dba7999102920d37c9@edu.ge.ch>
	<01412a4684684995ac35b4d6dba75853@edu.ge.ch>,<20260113182400.723e34a1@kernel.org>
In-Reply-To: <20260113182400.723e34a1@kernel.org>
Accept-Language: fr-CH, en-US
Content-Language: fr-CH
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLUVaIy48WlpbWFhYWFldSFpcSAINGg0FAQ1GHw0GDw0aKA0MHUYPDUYLAEhZSFpaSAYNHAwNHigeDw0aRgMNGgYNBEYHGg9IWEhaSFlbSFlYRllcXUZQXkZZX1lIUEhYSFhIXEhYSFhIWEhaXkgJBhwABwYRRgRGBg8dEQ0GKAEGHA0ERgsHBUhYSFtaSAEGHA0ERR8BGg0MRQQJBigEARscG0YHGx0HGwRGBxoPSFhIWV1IAx0KCSgDDRoGDQRGBxoPSFhIWlBIBAEGHRBFAw0aBg0EKB4PDRpGAw0aBg0ERgcaD0hY
X-SM-outgoing: yes
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=edu.ge.ch; s=GVA21; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:content-type:mime-version;
 bh=w2JQbYike37s8pXtIOzlkR0AUFRs7qVn2gHkmKt7qwQ=;
 b=BSOkvRFZne7MtqSHfq5YpBfAyUZBw9Qd+E4GqSyhMykUN+IGqE4DDimvX6xz+0MLEo4VPOrPm4CW
	VZbNVeUbyvtmhRJ9KLSYLaACI/iiMfLFyprvpulp//u7PJE5+NCtZCys3T+Kiau5uvjo6pqYEpMS
	IC4Qtw0XXQxeebXmSBHO6uPlwZe2PQ0c3bPGpWgUDYmyirOVIxf+D0xCdJNkA8OhunWvHkHMQJiN
	lId/zbivqy35RWPWepd5PUw6aDMoavlxagvK7Ht1a+w6D4H1VI9Krw3DGRjDkzRvZ4DtjrnJiBbU
	AP3d7HpXEqAwvVYQQfweopTQaApfTPPGVCSUrA==

VGhhbmtzIGZvciB0aGUgcmVwb3J0LCBJJ20gYWRkaW5nIHRoZSByZWxldmFudCBwZW9wbGUgdG8g
Q0Mgbm93Lg0KUGxlYXNlIHRyeSB0byBjb25zdWx0IHRoZSBNQUlOVEFJTkVSUyBmaWxlIG5leHQg
dGltZSAnY2F1c2UgbmV0d29ya2luZw0KaXMgYSBiaXQgdG9vIGJpZyBmb3IgdGhlIHJpZ2h0IHBl
b3BsZSB0byBhbHdheXMgbm90aWNlIHJlcG9ydHMuDQoNCk15IGJlc3QgZ3Vlc3MgYmVsb3cuLg0K
DQpPbiBGcmksIDkgSmFuIDIwMjYgMDk6NDA6MzQgKzAwMDAgV2VuZ2VyIEplcmVtaWUgKEVEVSkg
d3JvdGU6DQo+IEhlbGxvLA0KPg0KPiBJIHdvdWxkIGxpa2UgdG8gcmVwb3J0IGEgcmVncmVzc2lv
biBpbiB0aGUgZTEwMDBlIGRyaXZlciBhZmZlY3RpbmcgYW4gSW50ZWwgaW50ZWdyYXRlZCBFdGhl
cm5ldCBjb250cm9sbGVyLg0KPg0KPiBIYXJkd2FyZToNCj4gSW50ZWwgRXRoZXJuZXQgY29udHJv
bGxlcsKgIFs4MDg2OjU1MGFdDQo+IERyaXZlcjogZTEwMDBlDQo+DQo+IFN1bW1hcnk6DQo+IC0g
Ulggc3RvcHMgd29ya2luZyBhZnRlciBhbiBFdGhlcm5ldCBsaW5rIGRvd24vdXAgKHVucGx1Zy9y
ZXBsdWcgY2FibGUpLg0KPiAtIFRYIHN0aWxsIHdvcmtzLiBBIHN5c3RlbSBzdXNwZW5kL3Jlc3Vt
ZSByZWxpYWJseSByZXN0b3JlcyBSWC4NCj4NCj4gUmVncmVzc2lvbiByYW5nZToNCj4gLSBXb3Jr
aW5nOiB2Ni4xMi4yMg0KPiAtIEJyb2tlbjogdjYuMTIuNDMgLi4gdjYuMTguMyAodGVzdGVkIG9u
IERlYmlhbiAxMiBiYWNrcG9ydHMsIERlYmlhbiAxMywgRGViaWFuIHNpZCkuIHY2LjE4LjMgaXMg
dGhlIG1vc3QgcmVjZW50IGtlcm5lbCB0ZXN0ZWQgc28gZmFyLCBzbyB0aGUgcmVncmVzc2lvbiBp
cyBsaWtlbHkgc3RpbGwgcHJlc2VudCBpbiBuZXdlciBrZXJuZWxzLg0KDQpKdWRnaW5nIGJ5IHRo
ZSByYW5nZSBzZWVtcyBsaWtlIGl0IGhhcyB0byBiZSBlZmFhZjM0NGJjMjkxN2NiDQpXb3VsZCB5
b3UgYmUgYWJsZSB0byB0cnkgYnVpbGRpbmcgYSBrZXJuZWwgd2l0aCB0aGF0IGNvbW1pdCByZXZl
cnRlZD8NCg0KDQoNCkhpLA0KDQpUaGFua3MgZm9yIGxvb2tpbmcgaW50byB0aGlzLg0KDQpKdXN0
IHRvIHByb3ZpZGUgc29tZSBhZGRpdGlvbmFsIGNvbnRleHQgYW5kIGhlbHAgYXZvaWQgZHVwbGlj
YXRlZCB3b3JrOg0KdGhlIGlzc3VlIGhhcyBhbHNvIGJlZW4gZGlzY3Vzc2VkIG9uIG5ldGRldkB2
Z2VyLmtlcm5lbC5vcmcsIGFuZCBJIHdhcyBwb2ludGVkIHRvIGEgZml4IHRoYXQgbGFuZGVkIGlu
IG1haW5saW5lLg0KDQpJIHRlc3RlZCB0aGUgaXNzdWUgd2l0aCBMaW51eCA2LjE5ICg2LjE5fnJj
NC0xfmV4cDEpLCBhbmQgdGhlIHByb2JsZW0gaXMgZnVsbHkgcmVzb2x2ZWQgdGhlcmU6IFJYIGNv
cnJlY3RseSByZWNvdmVycyBhZnRlciBhIGxpbmsgZG93bi91cCB3aXRob3V0IHJlcXVpcmluZyBh
IHN1c3BlbmQvcmVzdW1lIGN5Y2xlLg0KDQpUaGlzIGJlaGF2aW9yIGNoYW5nZSBhcHBlYXJzIHRv
IGJlIGR1ZSB0byBjb21taXQ6DQozYzdiZjVhZjIxOTYwODdmMzk0ZjkwOTliNTNlMzc1Njk2MzZi
MjU5DQoNCkdpdmVuIHRoYXQgY3VycmVudCBtYWlubGluZSB3b3JrcyBhcyBleHBlY3RlZCwgSSBk
aWQgbm90IGF0dGVtcHQgcmV2ZXJ0aW5nIGVmYWFmMzQ0YmMyOTE3Y2IuIEkgYWxzbyBhc2tlZCBv
biBuZXRkZXYgd2hldGhlciBhIGJhY2twb3J0IG9mIHRoZSBhYm92ZSBmaXggdG8gc3RhYmxlIGtl
cm5lbHMgd291bGQgYmUgYXBwcm9wcmlhdGUuDQoNClBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3Ug
c3RpbGwgdGhpbmsgYSB0YXJnZXRlZCByZXZlcnQgdGVzdCB3b3VsZCBiZSB1c2VmdWwuDQoNCkJl
c3QgcmVnYXJkcywNCkrDqXLDqW1pZQ0KDQoNCj4gU3ltcHRvbXM6DQo+IC0gTGluayBpcyBkZXRl
Y3RlZCAoMUdicHMsIGZ1bGwgZHVwbGV4KS4NCj4gLSBESENQIERJU0NPVkVSIGZyYW1lcyBhcmUg
dHJhbnNtaXR0ZWQgKGNvbmZpcm1lZCB2aWEgZXh0ZXJuYWwgcGFja2V0IGNhcHR1cmUpLg0KPiAt
IE5vIHBhY2tldHMgYXJlIHJlY2VpdmVkIChubyBESENQIE9GRkVSLCBSWCBhcHBlYXJzIGRlYWQp
Lg0KPiAtIEJvb3Rpbmcgd2l0aCB0aGUgY2FibGUgcGx1Z2dlZCB3b3Jrcy4NCj4gLSBUaGUgaXNz
dWUgaXMgdHJpZ2dlcmVkIG9ubHkgYWZ0ZXIgdW5wbHVnZ2luZyBhbmQgcmVwbHVnZ2luZyB0aGUg
Y2FibGUuDQo+IC0gQSBzdXNwZW5kL3Jlc3VtZSBjeWNsZSByZXN0b3JlcyBSWCBpbW1lZGlhdGVs
eS4NCj4gLSBVc2luZyBhIFVTQiBFdGhlcm5ldCBhZGFwdGVyIChyODE1Mikgb24gdGhlIHNhbWUg
bmV0d29yayB3b3JrcyBjb3JyZWN0bHkuDQo+DQo+IFJlcHJvZHVjdGlvbiBzdGVwczoNCj4gLSBC
b290IHdpdGggRXRoZXJuZXQgY2FibGUgcGx1Z2dlZC4NCj4gLSBWZXJpZnkgbmV0d29yayBjb25u
ZWN0aXZpdHkgd29ya3MuDQo+IC0gVW5wbHVnIHRoZSBFdGhlcm5ldCBjYWJsZS4NCj4gLSBQbHVn
IHRoZSBFdGhlcm5ldCBjYWJsZSBiYWNrIGluLg0KPiAtIE9ic2VydmUgdGhhdCBSWCBubyBsb25n
ZXIgd29ya3MgKG5vIERIQ1AgT0ZGRVIpLg0KPiAtIFN1c3BlbmQvcmVzdW1lIHRoZSBzeXN0ZW0g
4oaSIFJYIHdvcmtzIGFnYWluLg0KPg0KPiBUaGlzIHN1Z2dlc3RzIHRoYXQgdGhlIFBIWSBvciBS
WCBwYXRoIGlzIG5vdCBjb3JyZWN0bHkgcmVpbml0aWFsaXplZCBvbiBsaW5rIHVwIGFmdGVyIGEg
bGluayBkb3duIGV2ZW50LCB3aGlsZSB0aGUgcmVzdW1lIHBhdGggcGVyZm9ybXMgYSBtb3JlIGNv
bXBsZXRlIHJlc2V0Lg0KPg0KPiBJIGNhbiBwcm92aWRlIGFkZGl0aW9uYWwgbG9ncywgZXRodG9v
bCBzdGF0aXN0aWNzLCBvciB0ZXN0IHBhdGNoZXMgaWYgbmVlZGVkLg0KPg0KPg0KPiBCZXN0IHJl
Z2FyZHMsDQo+DQo+IErDqXLDqW1pZSBXZW5nZXINCiAgICA=

