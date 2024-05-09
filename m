Return-Path: <netdev+bounces-94906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0878C0F7E
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40397282B3E
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 12:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511CA14B947;
	Thu,  9 May 2024 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="xrFJ1d1f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7275312FB0A
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 12:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715257138; cv=none; b=hJbwRVuIy5SZWWodyJMGHiMDVYSPFnutttvwFJVoFaxK89RBRzuMoKWa+kr51t6cHRP9EPkGSHhccwS+hyvbKHEiBoBpAhUUmXZJ9lrXsG8airW30f5jbv/3khbPiyr2cKKBPC7EJHGbN4BBLWzYp+QyKenTZmGJ+xXtaxE6Pqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715257138; c=relaxed/simple;
	bh=I4J2AgOYxhBQgAFZ1wo+lSl1T+rt+Z0V1hfBJkl2e/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bgMxki1ML17HrAKrFnmVta/+NxjjKlXeXGAQs4EwzWkwmS8mSx93RVq/CR9TplI87G8AvC+MBxQqUf7mx8rLVTbFEXFxPEmi+1g2Rx1ZPK/nxYa3kscTPVvYy7CBKs2Xr71ct4rwkcnQnTc4JGNw+qv6uEBgk15anuNeR3HGnHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=xrFJ1d1f; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59cf0bda27so99790366b.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 05:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1715257135; x=1715861935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OFeEjeHJx+pU6UTBEcenyMWxNjqm06RNmgZPQXXxQ28=;
        b=xrFJ1d1fRsr0H7R74v1YGLsQaCAau3dLszSD25E5yIHWd4uYcpiYU66XYNiMuPFwLC
         O7wG0P9x0Vx9PCE0OhCA9NZtprHc3FmCYHCc3fPc/Pxo+3Sv5/bOFlSbtXe3bGayM5Kp
         bcuEMsK7iaRgaskq6jEDLOrR63D81QC3HMxlLRcMKqOU/uWEfmDA86UV0Vwx9luEoIlk
         sYUqNH/2qWG+UGV5ozR0AAB4mPlEzoY3a9cL8A0pfQelbjq0D87h9e9vHN+csySeiWUG
         lb1qCNux6g9urg5LJxzRESwXJfU19e3LSUflOVhI4Tx8Im8Dp3WlaXDkiOAU58eYApr9
         gtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715257135; x=1715861935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFeEjeHJx+pU6UTBEcenyMWxNjqm06RNmgZPQXXxQ28=;
        b=fHBOEYePlj9pqcmWDIfJQNql0yBKBP+H1wiBHWAKAcQxTY45AeXwmL7mFMgFYppWRv
         KXt2h8+ZATRV5Pj9qTq9ngg1EilBVdD9WaVezkqU3UIj3HUSiNu4r+5ykOl4rgCGgZuH
         jQg6kTyDQ2VKjlyZbvcfXgx4NplKVlClB+ksBYputA1I57Yd2iINbHKCc/pbg9vtPNEt
         Mwx+wt3PSi2ZCan/uAvuVHkiHdn88SqE5lcc5g08BN2wLbQ/k0CQNqtcYj9z8tPEtbPQ
         hhoDbtRB+1apyKtCOeuek2hk4AqoAlB1bSoQ5zGga1db4atlaDlGJbD9Shtge/OYNsXc
         8fUg==
X-Gm-Message-State: AOJu0Yw9lsXwGCKZ4tpDkSMF9Vcc3IkWFi0e3uUmt16JO6ElROWeekL6
	+/8PmcHEmwd+SfsDc6Qip5A85aovGIImDyAH8AN0o8hdveCdSRbHp8m/QWTEf7k=
X-Google-Smtp-Source: AGHT+IEcKVW8vRKW2Ve8BbYrxzT4IrhDLFJEIQ+tI3fo2JcERX+I4G6dFY1DGQXBC5Da1pvch0fkew==
X-Received: by 2002:a50:9e85:0:b0:572:a089:75cc with SMTP id 4fb4d7f45d1cf-5731d9a2825mr4182852a12.5.1715257134718;
        Thu, 09 May 2024 05:18:54 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c322be7sm657075a12.80.2024.05.09.05.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 05:18:54 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Nicolas Pitre <nico@fluxnic.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] net: smc91x: Fix m68k kernel compilation for ColdFire CPU
Date: Thu,  9 May 2024 14:17:14 +0200
Message-ID: <20240509121713.190076-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Compiling the m68k kernel with support for the ColdFire CPU family fails
with the following error:

In file included from drivers/net/ethernet/smsc/smc91x.c:80:
drivers/net/ethernet/smsc/smc91x.c: In function ‘smc_reset’:
drivers/net/ethernet/smsc/smc91x.h:160:40: error: implicit declaration of function ‘_swapw’; did you mean ‘swap’? [-Werror=implicit-function-declaration]
  160 | #define SMC_outw(lp, v, a, r)   writew(_swapw(v), (a) + (r))
      |                                        ^~~~~~
drivers/net/ethernet/smsc/smc91x.h:904:25: note: in expansion of macro ‘SMC_outw’
  904 |                         SMC_outw(lp, x, ioaddr, BANK_SELECT);           \
      |                         ^~~~~~~~
drivers/net/ethernet/smsc/smc91x.c:250:9: note: in expansion of macro ‘SMC_SELECT_BANK’
  250 |         SMC_SELECT_BANK(lp, 2);
      |         ^~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

The function _swapw() was removed in commit d97cf70af097 ("m68k: use
asm-generic/io.h for non-MMU io access functions"), but is still used in
drivers/net/ethernet/smsc/smc91x.h.

Re-adding the previously deleted _swapw() function resolves the error.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/net/ethernet/smsc/smc91x.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
index 46eee747c699..e5d7f49915c6 100644
--- a/drivers/net/ethernet/smsc/smc91x.h
+++ b/drivers/net/ethernet/smsc/smc91x.h
@@ -156,6 +156,11 @@ static inline void mcf_outsw(void *a, unsigned char *p, int l)
 		writew(*wp++, a);
 }
 
+static inline unsigned short _swapw(volatile unsigned short v)
+{
+	return ((v << 8) | (v >> 8));
+}
+
 #define SMC_inw(a, r)		_swapw(readw((a) + (r)))
 #define SMC_outw(lp, v, a, r)	writew(_swapw(v), (a) + (r))
 #define SMC_insw(a, r, p, l)	mcf_insw(a + r, p, l)
-- 
2.45.0


