Return-Path: <netdev+bounces-273529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPG6J5+Ly2kuIwYAu9opvQ
	(envelope-from <netdev+bounces-273529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:53:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F083667DD
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7082E303C652
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 08:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AA93EB810;
	Tue, 31 Mar 2026 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNLvLIXw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEC93EC2C7
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774946982; cv=none; b=CrEBarWYeuIlm5G45UKgh1vl4Sz/fkJLm7b+i3NgDaRq7qrPzywKgAgLAcqP+tDMcXCPPSQXAPgNUQL8HStbsdZtxQJjMO6TIl83mDeKAW6P7OYPPv4hfMJ0nYMdl6OcThIHBUgdjYVfe5jL1USYmz2+EGVoL+PbFoFxNKYN8hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774946982; c=relaxed/simple;
	bh=RS1Ck0BGfQhaAUv2uBlmWhFdskT6vREcAGwkW0luATc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmTs6TPJZX8SZj4vME2FTV/WYLiFp28oWyISuYDUbFq8qzvd3AIVJh9ipM0FyNqa8FNAlWDFHEX5tE6tCzN+0P43shdB7sDF23LnRZ1rInyXsyb8wMgBrniGu7/Biy4thlJqsIjj4x83iFZxZ/xIRAHkA7zbsdm6nCiXjEt0Zhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNLvLIXw; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b97ed4ad579so856096466b.3
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 01:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774946978; x=1775551778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYw2GjIKOsjp/mmCKVfO+JWSxrQEDXep6q58GlKZmXM=;
        b=PNLvLIXwNMP4tBjkIMGQhnu/OKDoz9ajO4vRZuI2LgJiDI7qrCPS0H+SeAueQ8gMv5
         XXFeYcgqvovqqG/8tIRbVkwrb/bzGyf8m9lZLUVLonjI1aM+tiZFXFEgtE7wTiAAvXaV
         M3sbixzeXOHPuSqI/9Up9QQd3TonM1sIMkcch6K+obj1bUJn2PRKtq0ZbLF4Y6piEtmx
         WP6xuroc4RpyOLM1yKwDGJ3KslnTuf+nXQhU9wzzLpmOaKlVV0VdiG5foe7w1Gs5XFmu
         b/B+6BOiG5JA+NyaThLjEM1Psq5nIbpyouw5yMXA6vGGak1a9C28Pw4GRsjKLoOn8Z0e
         wKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774946978; x=1775551778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CYw2GjIKOsjp/mmCKVfO+JWSxrQEDXep6q58GlKZmXM=;
        b=JDO31+oKBoTEc0FuzVpSUdM5RWQjCSUXfZeiTKYcHskgk8bf6zYfGJV6hcb35qKMwk
         NPzakrMpJvED8UI5mnB03f3GyBFquKQ1tvXjX32FDnj57hODUwh2ScQMKa4IorM9O+YO
         3Xlte0bRRWKX81nI+LGLirsauADPh+WStIlUv3O0/VlOJxHlmcW5KjxN6vnKazhgzbui
         8hBGyVAelI0FLJak9HpYBS+jA7n3VKqa3ru95+UFl/O2wbjkafRYnA6rs8mSgzw5ljhG
         HtZFDf4yUYJJi7QKhqGLfKFL/FhFpzT9b20txMdW5ZZZxJvtp1ULQmNcvhTSDk3g4hAI
         jRMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRS6Cfolbukb4OmP6Hzmch09i+WlKSNOI+7HQMapdrCmq8483f+lewDNa5+CFgVG0iKGRKUBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YybPi/4pW/6ffy00ATqTzvXZRElxT5ypMEVTeTq240yYhkdwaDl
	ud95NcFjClQPptc6wzxnLpihF/VNOelOL/4jPEkqzI8BzE6PFw6CPFH6
X-Gm-Gg: ATEYQzwLGyha/5+/hUeksrxX9g663kmXb5VFnhrjAquQajavayHR14VdCWQ1rqJJE01
	E+IhznacdsKKwIdDyqu30VGjuhsUYb4876nZW4n2hvpvGz/jcJyZTNykVl2hS00gCnzBb33392C
	hqy2y4CIYcmXFyy2RQjkZ2yxt03OEgIsGx1KzKDnr4LfanfaiSns5Ubq6anVGNK89+qisHkVtXA
	eXiN4aauWlYg1adYdAUf14/EXcQqwMdSyqIkXgxQ0xCX43kvWh2yzirL5e1JNjgS3cTRb4xW6sQ
	KRxy06iTXkAeVqK6ROD+yFT5lI1pDMtMz6eAmUxrly7yDNxPMS7hoyd0j9AVJBg/uE7CsJP53OK
	hoj/C0gEOJSdVWYN/KDvRA9X0V8EzWujg2rdiaPbuKAmcQQ1iepVvBLIpocQz6HPzM2iofev6cZ
	uZWKSpKbBKs5qr8egMXQ==
X-Received: by 2002:a17:907:ca84:b0:b97:cc05:61a7 with SMTP id a640c23a62f3a-b9b5098de17mr954021166b.51.1774946978317;
        Tue, 31 Mar 2026 01:49:38 -0700 (PDT)
Received: from gmail.com ([2408:820c:2708:af80:8182:8384:8586:8788])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7ae7416dsm384119966b.28.2026.03.31.01.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 01:49:37 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Jaco Kroon <jaco@uls.co.za>
Cc: linux-ppp@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@ozlabs.org>,
	Dianne Skoll <dianne@skoll.ca>,
	James Carlson <carlsonj@workingcode.com>
Subject: Re: [PATCH net-next] pppoe: update Kconfig URLs
Date: Tue, 31 Mar 2026 16:49:20 +0800
Message-ID: <20260331084920.300558-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f37fca7f-710c-4f7a-a7c5-9d8cc129bf21@uls.co.za>
References: <20260331033303.5664-1-dqfext@gmail.com> <0aa6aa20-0e2a-48e9-8273-53b2fecd287b@uls.co.za> <20260331075438.290119-1-dqfext@gmail.com> <f37fca7f-710c-4f7a-a7c5-9d8cc129bf21@uls.co.za>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273529-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85F083667DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Tue, 31 Mar 2026 10:08:46 +0200, Jaco Kroon wrote:
> 
> I like this.  You have however dropped the ppp.samba.org link, just 
> re-add that I reckon.

I think this link belongs in the PPP section:

diff --git a/drivers/net/ppp/Kconfig b/drivers/net/ppp/Kconfig
index f57fba84fe55..cf927bdc288f 100644
--- a/drivers/net/ppp/Kconfig
+++ b/drivers/net/ppp/Kconfig
@@ -13,10 +13,9 @@ config PPP
 	  otherwise you can't use it; most Internet access providers these
 	  days support PPP rather than SLIP.
 
-	  To use PPP, you need an additional program called pppd as described
-	  in the PPP-HOWTO, available at
-	  <http://www.tldp.org/docs.html#howto>.  Make sure that you have
-	  the version of pppd recommended in <file:Documentation/Changes>.
+	  To use PPP, you need an additional program called pppd, available at
+	  <https://ppp.samba.org>.  Make sure that you have the version of pppd
+	  recommended in <file:Documentation/Changes>.
 	  The PPP option enlarges your kernel by about 16 KB.
 
 	  There are actually two versions of PPP: the traditional PPP for


Your thoughts?

