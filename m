Return-Path: <netdev+bounces-248413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE8ED08485
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 10:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 785B13044C0B
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 09:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5573596F0;
	Fri,  9 Jan 2026 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=edu.ge.ch header.i=@edu.ge.ch header.b="ls/EYnRh"
X-Original-To: netdev@vger.kernel.org
Received: from gwsmtp.ge.ch (smtpsw24.ge.ch [160.53.250.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F0231AF3D;
	Fri,  9 Jan 2026 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.53.250.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951640; cv=none; b=Xv2a3gcAGDWpJ3dw7jtNGeMpVRAI01e2aR08IhFhSRdLcuGbV6/1+3f3i5OaQow1+55gZkNoH+EMDnlugz7d0mn9b0p6RCorWvyDlAaXb3Ceg6IAJfL9O0zHAkeI9I6h4jVDFSZpz945jw8/V8237gYRUMcF2wg9YoH9i1NAlpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951640; c=relaxed/simple;
	bh=EWuYNWe4GOLgwLpgEnnIeTJJsfi5tWmonUWpzETrOo4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IW/e4GBlyd0m6UMkFnp4TfOKsIOX9N9pka6ykvT4WqECBamTgDMwfz9oEya2B1EGRLC8RDWsQlA0bcXAEv4Ah88MlHE9Ht/ZaZ1d9qeUPH0sXpPW4SRqZi00XGY7X2eoJBlIfzoSILrWA8T4T/sy3+duxLcw9gEKI08Gpx5jbTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=edu.ge.ch; spf=pass smtp.mailfrom=edu.ge.ch; dkim=pass (2048-bit key) header.d=edu.ge.ch header.i=@edu.ge.ch header.b=ls/EYnRh; arc=none smtp.client-ip=160.53.250.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=edu.ge.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edu.ge.ch
From: "Wenger Jeremie (EDU)" <jeremie.wenger@edu.ge.ch>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [REGRESSION] e1000e: RX stops after link down/up on Intel 8086:550a
 since v6.12.43 (fixed by suspend/resume)
Thread-Index: AQHcgKY4vqPf4k7m6ECp9OMR6mOttLVJlHgA
Date: Fri, 9 Jan 2026 09:40:34 +0000
Message-ID: <01412a4684684995ac35b4d6dba75853@edu.ge.ch>
References: <c8bd43a3053047dba7999102920d37c9@edu.ge.ch>
In-Reply-To: <c8bd43a3053047dba7999102920d37c9@edu.ge.ch>
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
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLUVaIy48WlpbWFhYWFldSFpcSAINGg0FAQ1GHw0GDw0aKA0MHUYPDUYLAEhZSFpQSAQBBh0QRQMNGgYNBCgeDw0aRgMNGgYNBEYHGg9IWEhaSFlbSFlYRllcXUZQXkZZX1lIUEhYSFhIWUhYSFhIWEhaUEgEAQYdEEUDDRoGDQQoHg8NGkYDDRoGDQRGBxoPSFg=
X-SM-outgoing: yes
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=edu.ge.ch; s=GVA21; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:content-type:mime-version;
 bh=EWuYNWe4GOLgwLpgEnnIeTJJsfi5tWmonUWpzETrOo4=;
 b=ls/EYnRhbwg1lODx8tTV9PL/NiCDE+iLI9QMYSOKR+rxP9TkvhNbKwv9eT+R1GGz/QVdy7mDU8BY
	cNGs/cS14OkFBpHi8l+FWHC7rn7oR0YVEoT84sZRBxMGA5SnJ569gUhWZR19bmBnEXfdoEIv9KM0
	As0bpI3dO3Fh4wbcihk9V3qSIXIMRgC5jE0yQ8eHKTGKODgTKvSaZ0E57j1hYrweeqgmQKNd2+cm
	QsV+BXVARoaAmdlGPq7+KEEKf6x3uJoXwCoaLy1XVQo1SCgfXgXkqJLMPP3vA52lPh7IC/EeQNMB
	WwRmsbAJGrWnOZlZwt+lVn+1OSfT7IJ7scih+g==

SGVsbG8sDQoNCkkgd291bGQgbGlrZSB0byByZXBvcnQgYSByZWdyZXNzaW9uIGluIHRoZSBlMTAw
MGUgZHJpdmVyIGFmZmVjdGluZyBhbiBJbnRlbMKgaW50ZWdyYXRlZCBFdGhlcm5ldCBjb250cm9s
bGVyLg0KDQpIYXJkd2FyZToNCkludGVsIEV0aGVybmV0IGNvbnRyb2xsZXIgIFs4MDg2OjU1MGFd
DQpEcml2ZXI6IGUxMDAwZQ0KDQpTdW1tYXJ5Og0KLSBSWCBzdG9wcyB3b3JraW5nIGFmdGVyIGFu
IEV0aGVybmV0IGxpbmsgZG93bi91cCAodW5wbHVnL3JlcGx1ZyBjYWJsZSkuDQotIFRYIHN0aWxs
IHdvcmtzLiBBIHN5c3RlbSBzdXNwZW5kL3Jlc3VtZSByZWxpYWJseSByZXN0b3JlcyBSWC4NCg0K
UmVncmVzc2lvbiByYW5nZToNCi0gV29ya2luZzogdjYuMTIuMjINCi0gQnJva2VuOiB2Ni4xMi40
MyAuLiB2Ni4xOC4zICh0ZXN0ZWQgb24gRGViaWFuIDEyIGJhY2twb3J0cywgRGViaWFuIDEzLMKg
RGViaWFuIHNpZCkuIHY2LjE4LjMgaXMgdGhlIG1vc3QgcmVjZW50IGtlcm5lbCB0ZXN0ZWQgc28g
ZmFyLCBzbyB0aGXCoHJlZ3Jlc3Npb24gaXMgbGlrZWx5IHN0aWxsIHByZXNlbnQgaW4gbmV3ZXIg
a2VybmVscy4NCiANClN5bXB0b21zOg0KLSBMaW5rIGlzIGRldGVjdGVkICgxR2JwcywgZnVsbCBk
dXBsZXgpLg0KLSBESENQIERJU0NPVkVSIGZyYW1lcyBhcmUgdHJhbnNtaXR0ZWQgKGNvbmZpcm1l
ZCB2aWEgZXh0ZXJuYWwgcGFja2V0IGNhcHR1cmUpLg0KLSBObyBwYWNrZXRzIGFyZSByZWNlaXZl
ZCAobm8gREhDUCBPRkZFUiwgUlggYXBwZWFycyBkZWFkKS4NCi0gQm9vdGluZyB3aXRoIHRoZSBj
YWJsZSBwbHVnZ2VkIHdvcmtzLg0KLSBUaGUgaXNzdWUgaXMgdHJpZ2dlcmVkIG9ubHkgYWZ0ZXIg
dW5wbHVnZ2luZyBhbmQgcmVwbHVnZ2luZyB0aGUgY2FibGUuDQotIEEgc3VzcGVuZC9yZXN1bWUg
Y3ljbGUgcmVzdG9yZXMgUlggaW1tZWRpYXRlbHkuDQotIFVzaW5nIGEgVVNCIEV0aGVybmV0IGFk
YXB0ZXIgKHI4MTUyKSBvbiB0aGUgc2FtZSBuZXR3b3JrIHdvcmtzIGNvcnJlY3RseS4NCiANClJl
cHJvZHVjdGlvbiBzdGVwczoNCi0gQm9vdCB3aXRoIEV0aGVybmV0IGNhYmxlIHBsdWdnZWQuDQot
IFZlcmlmeSBuZXR3b3JrIGNvbm5lY3Rpdml0eSB3b3Jrcy4NCi0gVW5wbHVnIHRoZSBFdGhlcm5l
dCBjYWJsZS4NCi0gUGx1ZyB0aGUgRXRoZXJuZXQgY2FibGUgYmFjayBpbi4NCi0gT2JzZXJ2ZSB0
aGF0IFJYIG5vIGxvbmdlciB3b3JrcyAobm8gREhDUCBPRkZFUikuDQotIFN1c3BlbmQvcmVzdW1l
IHRoZSBzeXN0ZW0g4oaSIFJYIHdvcmtzIGFnYWluLg0KIA0KVGhpcyBzdWdnZXN0cyB0aGF0IHRo
ZSBQSFkgb3IgUlggcGF0aCBpcyBub3QgY29ycmVjdGx5IHJlaW5pdGlhbGl6ZWQgb27CoGxpbmsg
dXAgYWZ0ZXIgYSBsaW5rIGRvd24gZXZlbnQsIHdoaWxlIHRoZSByZXN1bWUgcGF0aCBwZXJmb3Jt
cyBhIG1vcmXCoGNvbXBsZXRlIHJlc2V0Lg0KDQpJIGNhbiBwcm92aWRlIGFkZGl0aW9uYWwgbG9n
cywgZXRodG9vbCBzdGF0aXN0aWNzLCBvciB0ZXN0IHBhdGNoZXMgaWYgbmVlZGVkLg0KDQoNCkJl
c3QgcmVnYXJkcywNCg0KSsOpcsOpbWllIFdlbmdlcg==

