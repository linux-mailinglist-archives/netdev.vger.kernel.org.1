Return-Path: <netdev+bounces-294042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Cp7OC13HmpsjQkAu9opvQ
	(envelope-from <netdev+bounces-294042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 08:24:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA98628EEB
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 08:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3BD43044700
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 06:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870D93A6B9D;
	Tue,  2 Jun 2026 06:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezGaOfsj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6563A1688
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 06:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381442; cv=none; b=ludTyYRbiPbP59RoZFFhcSX06q0NbJsqpUo1Q6AnlYjqywWpAVEUNfJxgkFJtZpSqzc2CGMA7JgcpkfU5wxEx5pSZlYgahwqOhglECcvVQRPSO/SbTEqLQTxvKg24BlSJs1ny7gVTzfg6M3jcAY7bykVe0DRI0msci7Nknkxhr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381442; c=relaxed/simple;
	bh=+yL4q3mvCOIkoU9eWpUC3/7X6hFeWmh+WekwoFARR54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQ6pDoasCrQst5ZcGKO0Vr4R0imweMd95XXKAYFMaUSBUm+q6sTE5nc/VuFyEEBuaY6+WoidQhJHJg6fn7q+rikzKmh2qiOMsKuTw1sXhy6RkO+uiK7sJOJj5JnvEcLwGVG4JWmz2IEzvQC+GFj0vJixA4Foo/K5e1esImI3JBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezGaOfsj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c0c1e0d00bso21035545ad.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 23:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780381441; x=1780986241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yL4q3mvCOIkoU9eWpUC3/7X6hFeWmh+WekwoFARR54=;
        b=ezGaOfsj7Nii9wsA1c6NUHMQHms3t3AQ4cN4Ezp/6rmr2YmmXEDIsE+jB7zmqUrhG4
         FydzIzzXEO+bqdUxKoMx0XDTmDR78MmlX5aheJcCbEAUoAeiQyqUx2jrqw3YhRWkupdg
         c0ASdf6g044as9TcShIgnM0SisZ1TEKDfDX6PMvg88RC+8NMwj5yJd/Ubsu0eAyLBPV3
         7chrZfLEsKbWWUimSxgNi9i992CBk3bgruOdjwmYbRGbw2EG9lhGdACC3AGes+ftFkrk
         UjctEi0GyymIdJk3e50HryTjnL5QDuvQk61VnjvssiEKBcKDfI9PXXy9WMjAv5ydxnLY
         KqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381441; x=1780986241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+yL4q3mvCOIkoU9eWpUC3/7X6hFeWmh+WekwoFARR54=;
        b=RB68FUMp6sPG4Hhy0vJtiKOFqTZMaTj0KGZIbz5/44X9lZcabzt98wt6A2cRLG3on3
         yME4MRLl3NvfZfCdbqkB1bohvf74loJSuYiTkHKg1rGVPxLxIM32lyNVFqVinNkAz4KU
         j8eHOhZFkfBa3+iE8KKsYRGuFbz0v7EBgxiTRXj7In8/HQsCqXzF1F0Ub7cYDBKEv2PE
         xWEVjXr6qIuNva7GzqrafR/n/gEa2Rw6DtnnP8IVuPPXDjPh6Aa9F4krotIEP31nHpGM
         meNsZ1ZimcN31C/fLgzj8nPbQM3k72Jv5WQYtW0jgjyKk+ytX8dAPCGG7fLfHn7cOLUG
         ePbA==
X-Forwarded-Encrypted: i=1; AFNElJ9lO95fPnJS2cKv/LJFCPwcpJ9uHfJE8iB9bdtpbGSCV9kmT8wOikC1C3d8RN6tSBRs01cgey4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS4AKcX6lhvV8fRYpTBJ5szQkxT0779oFGBC6DVahPbbLK0IfY
	DFKHhEcDvydbSVqgaxWKPD45300CG7h8i76iM8vogjnu0lU2FgsnLnB9
X-Gm-Gg: Acq92OG3HXK8J2+Taw5y6c3Iqlk7VphyIMdfDsJne6WOFm8dNGm2E1qLDwQ1MfhP0o1
	T1lkfNdVjZVCtnJMEThA2P5p0rmHz7BShttPLylOhzVGwlGoZ4fpXqew7m5f9o0csnO9y0dTNkc
	7gFr5mggUQuU08EaXFFnAzm8PhTZ2QJUmS1qHjPawKV3gkK6lvUaPHB5NtLBzaHwDMIGwZG9qrX
	WztZN2iUrTmhDPmj+Tp19ig5+gdqEPg/+qYhDvHBRJlDUR0qed/HwwBD3BiM7u1GbvLXRSiVDhx
	Ee8nm6CXqS5lOjF+RQD1Ar/Ayr2Y5jEhPsKdbaiHLgDXxmQd0vS1RbDNmD3VRTP3JlSRMRt5r4z
	BqslWxvRiXpzuvvMuM6OqO7okL+tZj0YydB2JOgvedwtZRl32CIeGAS3Ux6eL6YpeER0EAD46je
	ZQJn2Us8VLnJvWTAqQJgo9JNUQTsuSzCke483IH8iYzBaPTwPfHh3Ghnm3xjd7K5CCr+yaJTaS4
	NvcnWXtOd3YL/R2srTdMuTuRQ==
X-Received: by 2002:a17:903:b0f:b0:2c0:e158:1dfa with SMTP id d9443c01a7336-2c0e1581e3amr83091605ad.21.1780381440653;
        Mon, 01 Jun 2026 23:24:00 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239fdf0asm121313555ad.26.2026.06.01.23.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 23:23:59 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: fw@strlen.de
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfrm: policy: Fix use-after-free on inexact bin in xfrm_policy_bysel_ctx()
Date: Tue,  2 Jun 2026 15:23:46 +0900
Message-ID: <20260602062348.1995083-1-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <ahmGAgwpJx0OFKe7@strlen.de>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-294042-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanghyunparkcnu@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4EA98628EEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for the review. I apologize for the several mistakes I've made.

> There is no such commit, neither ID nor subject.

You are right, I apologize. The correct one is:
Fixes: 6be3b0db6db8 ("xfrm: policy: add inexact policy search tree infrastructure")

> Looks like this patch is whitespace-damaged.

Will use git send-email for v2.

> Could you also say in changelog why you added the 3rd criterion?
> Became (bin && ret && delete).

The extra ret check was only meant to avoid pruning the inexact bin when
the lookup did not actually find and unlink a policy. Pruning in that
case is harmless but unnecessary. It is sort of an optimization fix
rather than security-related one.

After looking at it again, I will drop the extra ret check in v2 and keep
the original condition as bin && delete to make the patch minimal.

I will send a v2 with these fixes in a concise version.

Thank you,
Sanghyun

