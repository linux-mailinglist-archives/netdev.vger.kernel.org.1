Return-Path: <netdev+bounces-287991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFdTITXcBWokcgIAu9opvQ
	(envelope-from <netdev+bounces-287991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:29:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C725431A0
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E20D630DD65B
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6782740627D;
	Thu, 14 May 2026 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUZwLJas"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E6E3F23AA
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767999; cv=none; b=eyKSfDa72a6TykBPmALYDoWcwfYD13+g6KWRHk3S1Xb4UzskyDwEG+IM3dIb3X4bGx3j8ULHyosPqSm6gFHHaz/78n+MCGUrG2rd2sRD+lRjzCOtpF4SKnTHuZgBY1ZR0ZphGDLKd/OB5XCX1+uqFANt4n3f6u+aty44oeqVAWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767999; c=relaxed/simple;
	bh=6+Vy77mlexUq69K/GifNbxsYh1MJdCUIjNEhN5F1vsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJDHZlyJ26AgaWboSR7y/I7miv/cBNa6ZfDi+0ySeq7yUle4u+m2BhFxo6AK96STb2SCyYOJ/M4oLBgQUIpCFNBoTeVtumuHk/c5Z35l6lHK8JW94zf5TBXgT19LpmSXdLQH31qQUG1cEZf5VpTDRuDpS2RIMnrG6P+16MEmC5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pUZwLJas; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-41576c5c01cso5019037fac.3
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 07:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778767997; x=1779372797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+Vy77mlexUq69K/GifNbxsYh1MJdCUIjNEhN5F1vsY=;
        b=pUZwLJasNTJ1Tkg/kdJU4j57rcOJHBX4sZkY/MUdYttTZzy+8kaHashhWEnW0eYTHv
         j6RKrxTp2L1SgutrUke2Z+PDn9KmFmNLBBk83SwYbunnjOfvMWEV6Hn5GLYSib6EXEHX
         dTQ5uifKqHxzvKCtyjSt6Qj588UXeyNFJH/rSruoUTlhILFadLnIpGgXX3v4eiMlEAAb
         Gup2+0BeY0GkqNNHh5bzKoDechD7GPQk5Fh6I4FABchwPx1ewOEBQH/WEYuob6eZSfh4
         TjpZiGENiePqs5s/oT92KlLpMPhSG7eyLxpiKCMaD/tGhV6vNDGoVT0xzANk3CiWB/F4
         QD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778767997; x=1779372797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+Vy77mlexUq69K/GifNbxsYh1MJdCUIjNEhN5F1vsY=;
        b=iQ9rIAJBwKtY9REfDwB85PVSLVgrC0lzo9PBiNZfhr0pNdTS2APTPQQh1qwlRaOhre
         eLA/zdrSqSM4uPPBkPSGq+7LNjmnfwSuJR7e9OfTEaKQuHJUx6hlI2cyYKhq1rVZ1uVL
         BhiHL+sS4M7BYTNB9TDkp86f/R9BH1GhWF56zSt8nhhYQO8cxbZkQKjJCkl6C+Hu6TLh
         bL9YbSI8NRt5XfZhyngDiZfsMynMl0dUFVoYegAKixcGVBteYSXP/kccMLEgVqoZ1xKV
         ASKUSrRTqnlu2VSdQxKcWEZ7zLyUuUkQnZbioTJAb2afD1BVWAXW+2PKzhq2sGUUvaQr
         ZeHg==
X-Forwarded-Encrypted: i=1; AFNElJ89qXKVX/X0cZac8kjaNOwNCaJin8xBE/OTLlSH9+rDIwvE8coLQqPZALOPJ2AejBHcHWQ0JSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD956vMbdumw0TaM3zFtN1DSHhNp57pTMiscKCFcCNBtz7+/yK
	W5gDWR37B/FCifY+PGqdUEl44TPRETwQ5WJDSuBH4PNvQwnaSN1bbJSnu5eG3G+j
X-Gm-Gg: Acq92OE9WFKC2VxM7EZ/LSS6mOzRpTwkMBeAvUbIgyERO2Eb1K56YTOJRlLhBhCVuka
	CMvW9eRLeOF9NogMvdl0JpLN/7IdfKxlHzEKaT3tpQikYExb6nsUKv6/frZ3qsBTyWKdYKlVvpA
	oYW+Cvh/VgRWKijhQwK/K5B896HW+UP3f22kWEuYw80ShOtbckYFaL+R5eK9foNNpL5sc1JELCB
	ycaPkujgfm2LzFI4mu6S5kpUqpfQtsev80lCFhp9qL6iEy3nlRqJ8w6injvOXx1h8/GUxPMBtJ+
	nfgVi/MaennWJhGYMUPkR3OqIkl1N5PkhIukd7+w/r2KiasAYrQDiIFou6L1VqGO5/+1xeRp9Bh
	5TyUpG89QErZn7uWEIR5sR8LdsWdpYWK35Tj8g6K9q/8JqawyfNWV/hwfp5788Fqr8zpX78AdCA
	AP3NDK4H55KkU3nBY=
X-Received: by 2002:a05:6871:54d:b0:42f:7bbc:ce82 with SMTP id 586e51a60fabf-439d2ffc601mr4141250fac.26.1778767997001;
        Thu, 14 May 2026 07:13:17 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc4dcb89sm2018191fac.12.2026.05.14.07.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:13:16 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: Aaron Conole <aconole@redhat.com>
Cc: Minxi Hou <houminxi@gmail.com>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	echaudro@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	dev@openvswitch.org,
	i.maximets@redhat.com,
	linux-kselftest@vger.kernel.org,
	Eric Garver <eric@garver.life>
Subject: Re: [PATCH net-next] selftests: openvswitch: add dec_ttl action support and test
Date: Thu, 14 May 2026 22:12:59 +0800
Message-ID: <20260514141259.4042848-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <f7tecjeqezk.fsf@redhat.com>
References: <20260514092747.3653656-1-houminxi@gmail.com> <f7tecjeqezk.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 21C725431A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287991-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,redhat.com,google.com,kernel.org,ovn.org,openvswitch.org,garver.life];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Thanks Aaron. I missed the le_1() wrapper in odp-util.c. I was only
looking at the kernel netlink attributes and derived the format from
there, which doesn't have that layer.

Will update the selftest to use dec_ttl(le_1(...)) in v2.

