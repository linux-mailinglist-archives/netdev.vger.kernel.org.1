Return-Path: <netdev+bounces-215563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE55B2F3BC
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 11:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF504A033ED
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 09:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28652EF664;
	Thu, 21 Aug 2025 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="NoE+lS2p"
X-Original-To: netdev@vger.kernel.org
Received: from forward204d.mail.yandex.net (forward204d.mail.yandex.net [178.154.239.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9672EE604;
	Thu, 21 Aug 2025 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768026; cv=none; b=R8fVIBaq52tUAyjhGOl6k2siyk+pbamfsBGMzFL9b+Gpp0vk0v8/8ehuVwHphCQxH9uDPN3NEEF/o9fVg4MoHit9ysfsPM93ZV/yt95Su0+qDJMMud4Cxfu9VYwuCn9ijiXMEgJ568gwQP53O6Nmu/8oUhLcKiELnmJRZt6HKCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768026; c=relaxed/simple;
	bh=3tVdFuHj4uHnjdjqWf3PNJx6ecexjwUyT+qOONlFsek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L6jL1KjVGuogu950kPpsdMCKyzbyeN78zgTvHfh0h7XKKXLuSrTqlQngUWR6O1T8sXVflJUB/0yLBtLW1PgVNQkRDU5QyAnIZtwBpbzp9mgaAoR4qtCumPKs/aExovo9yeStS+n8FzE1Yq2fcd6AgGLDK23XknvYY96VxaGyDPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=NoE+lS2p; arc=none smtp.client-ip=178.154.239.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d102])
	by forward204d.mail.yandex.net (Yandex) with ESMTPS id F054C832B2;
	Thu, 21 Aug 2025 12:12:53 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:160e:0:640:2589:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id 74116C00C6;
	Thu, 21 Aug 2025 12:12:44 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id aCPrMXHMhOs0-xS4o7xgm;
	Thu, 21 Aug 2025 12:12:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1755767563;
	bh=Eerujrdfh/b9a+GIG0kU2uvLlnxYMyTOGbw/ntnEXBY=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=NoE+lS2puUcbUChbid6y6ZJ1jsjCQTfo0XPelej12dnYiLgO+F9HzQDiKUsbLitFr
	 ULOKk6hOJCNm6EJomEU1euLxD3+Bsd+L/yCDA6LZFrtWisl3ZC0z9932tBuWWCWbTH
	 UpFEBJ3G7YIsiACSfnl1sG3PgHcDLizDo6M6wGh8=
Authentication-Results: mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: fujita.tomonori@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	dakr@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH] rust: phy: use to_result for error handling
Date: Thu, 21 Aug 2025 12:12:35 +0300
Message-ID: <20250821091235.800-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Simplifies error handling by replacing the manual check
of the return value with the `to_result` helper.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/net/phy.rs | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 7de5cc7a0eee..c895582cd624 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -196,11 +196,8 @@ pub fn read_paged(&mut self, page: u16, regnum: u16) -> Result<u16> {
         // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
         // So it's just an FFI call.
         let ret = unsafe { bindings::phy_read_paged(phydev, page.into(), regnum.into()) };
-        if ret < 0 {
-            Err(Error::from_errno(ret))
-        } else {
-            Ok(ret as u16)
-        }
+
+        to_result(ret).map(|()| ret as u16)
     }

     /// Resolves the advertisements into PHY settings.
--
2.50.0


