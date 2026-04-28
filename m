Return-Path: <netdev+bounces-281744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NXGIZ+G8GnuUQEAu9opvQ
	(envelope-from <netdev+bounces-281744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:06:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1905482362
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D35AB315B15A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7749374E67;
	Tue, 28 Apr 2026 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JgZASNic"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f100.google.com (mail-dl1-f100.google.com [74.125.82.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FA0317158
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368264; cv=none; b=Z3xyIQ0HdsrCmMxAIvpHe0NIW2lPUtmmg+h1OydC08pq6yP6a9m6LX/hcv2y30myDGaKkTHHHnJnJFuCspaB61Pj7nnubWPWsR/3NP7lvgP9W3iSofuo2eqaJwvisrdRkf3WtW9f0Pg/R0l5Hr+5a6eefEa2vAqu2RydsFMu3cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368264; c=relaxed/simple;
	bh=IzPOnX+4u79/JYJ7Z4oEDndQq0Exv1P8b4YAmspEcU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJSZmg+i0QixkG/qqiwT2LXDy4Qu28jbNrznrTBNPPBnatqD7/PZX99IGmfg8P16P+c9RpxQoDER58JimmofHZHEn3Gt3fT4D1fs8Y+u5g6Yr28bw5dqotGCJY7u9fRtgpYWgZkkATfVuHEDZalSPhIYws8MvIRv2f2SLneZFHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JgZASNic; arc=none smtp.client-ip=74.125.82.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f100.google.com with SMTP id a92af1059eb24-12db205ca0bso771814c88.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 02:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368262; x=1777973062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzPOnX+4u79/JYJ7Z4oEDndQq0Exv1P8b4YAmspEcU4=;
        b=myT0xsDdKBiR4IihcooIdGsmoC0KxJ+VRWrUFus9pl/MYMHP6/pYZEDJOBpd554jV5
         c2YxhQ7UnZ0BPYXzWSeemHiqdPyrRcrRRY4D95Xp+tFGXCSTVZar//TPF+NMFUJinPDs
         99O5sciqSQmzI88w+EKlvSRjT+XH9RsT0g1tITurNLrV/MVm4dN14pCXZ2ombEB02qPC
         darZVj+OEK41SmsMtMzk4a5yHoNZBSKeTmcTJjUfXqr4RLtG2k9kKC+xxlYpM90qMLqz
         YtOYycc22OUsiURKcigFw/LwrPD6Ip79lspgH/y3jti9LgPLWnduVyhZXNIvAopGHsaQ
         FTBg==
X-Gm-Message-State: AOJu0Yz8/9Ln/e6ty7JPdtUBQ7V35qExpyWsFD0H7FthGIsYXveOVjpE
	7tON0Kqz63qZGEWPsl4lGmXcwaMWbeGQxbKlfEoFqmHC7k0YqQznsd0aYNC6c9+HK/4Y/OFGEfe
	BKZn2AWBQ+iwhgxZ37idfPUQgMm/xbXle3w1R38IpualmJ+bBRNLOO4cjfuoiLv+JkBE+d0IlzX
	ED8D/WTOcEd6S6/XowrELw3hPFKp0dnN6M36ESzokn3gQ7I/t7bSaEIJ2Ja/6wioFq+hNRt3+LB
	u+tg3QcYkIkPy8=
X-Gm-Gg: AeBDietkE2+eOcFkRuui+JLnNwq1amexK7OCxdJAfwV3g3+AhxXXMkhOt3W6hVOoLy1
	vNWdDrMinDUoKGBvMPxJ6vwG4GHIADsXmXYZbNrhfSQ5ZBeYw8CcZqiPgNUIgGwt13fbLbkhlwx
	2liceTSYrGwdc5zAn15crltYHJsOO+E/zaMrF0AX0KcUgLH6hh+lBZVcaP4GBmy2Bg8CY5uNeiA
	vfjsdwsE2bn6pevjpmGPOVQlTTJILcOiPBD5XTD98Kt34wQT9076wA90XKgku7YRldqGUuuiQ13
	BYxr2wo/YlV1V99PAmuGRPwAd1hzC6QavFcGn8REgx3MQPC0g0F1Sq4L0cr6fW7OZ8uIIirtIl5
	s5mO2rR2iY92wDD0gjEv2IUMOh+xbt3Q5qbAOjpiSqHBxB0xzEo+f35+OWii3dj9ewQK1+kbU3B
	baPxqItg2MO9kQCBEITqcmmKNZgZWBfN2NBH4ATaFGE8EmUkfG37k6jFrlCgef4bf9DVlV
X-Received: by 2002:a05:7022:2383:b0:12c:20b9:80fc with SMTP id a92af1059eb24-12ddd55ce38mr578166c88.7.1777368262128;
        Tue, 28 Apr 2026 02:24:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2ed0a18637bsm132600eec.17.2026.04.28.02.24.21
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:24:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2dd329abc22so1003876eec.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 02:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777368260; x=1777973060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzPOnX+4u79/JYJ7Z4oEDndQq0Exv1P8b4YAmspEcU4=;
        b=JgZASNicZYhFDPOEua8M8St8hIx6jLDc2TFrJdHtt9yfi7n8ZhbO8kB1v5HIgpZIzy
         C0qyUnqgwJHc2dm3DrRZKqIpcboCZ/EO8Ud//hMykpL0tJoAoV2QsHOE1p5xyjgcM8Ll
         D2Y0Vz8fZWjVCsdm3m3tP8N75U+d+9hYdYM0Y=
X-Received: by 2002:a05:7300:d70d:b0:2c4:ec89:bdb with SMTP id 5a478bee46e88-2ed09a38a2bmr455066eec.2.1777368259664;
        Tue, 28 Apr 2026 02:24:19 -0700 (PDT)
X-Received: by 2002:a05:7300:d70d:b0:2c4:ec89:bdb with SMTP id 5a478bee46e88-2ed09a38a2bmr455057eec.2.1777368258999;
        Tue, 28 Apr 2026 02:24:18 -0700 (PDT)
Received: from photon-d7fac424c0d3 ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed09fd6e19sm1666250eec.13.2026.04.28.02.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 02:24:18 -0700 (PDT)
From: Ankit Jain <ankit-aj.jain@broadcom.com>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	quic_stranche@quicinc.com,
	quic_subashab@quicinc.com,
	linux-kernel@vger.kernel.org,
	karen.badiryan@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com
Subject: Re: [PATCH net] tcp: do not shrink window clamp when SO_RCVBUF is locked
Date: Tue, 28 Apr 2026 09:21:10 +0000
Message-ID: <20260428092110.2280-1-ankit-aj.jain@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427131111.168ed0dc@kernel.org>
References: <20260427131111.168ed0dc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: E1905482362
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-281744-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ankit-aj.jain@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rcvq_space.space:url,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]

Hi Jakub,

Thank you for pointing this out.

I checked the logic again, I placed the SOCK_RCVBUF_LOCK check on
the outer if-statement. This successfully prevented
tcp_set_window_clamp() from crushing the window (fixing the
Java SWS bug), but it accidentally bypassed the tp->rcvq_space.space
bounds check as well. Because of this, the receive queue tracking got
out of sync when the test hit a negative window.

For v2, I will move the lock check inside the block so it only bypasses
tcp_set_window_clamp(), ensuring the rcvq_space.space limits still
execute as expected.

I will test the refined logic against my reproducer and the
tcp_rcv_neg_window.pkt script locally, and I will post the v2 series
in a new thread after the 24-hour cooldown.

Thanks,
Ankit

