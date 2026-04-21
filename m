Return-Path: <netdev+bounces-279972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M6rGY3g5mmX1gEAu9opvQ
	(envelope-from <netdev+bounces-279972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 04:27:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF974357A7
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 04:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 818F830151C5
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 02:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D34F26E708;
	Tue, 21 Apr 2026 02:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTEjoy0L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7616265CA8
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 02:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776738437; cv=none; b=uEHWYXom5l7trekbzmjsXUEopAxER67YBdX2ZJigIEhpMXJJUma8J4u+x9saxrzYtfe5KudiUfmuuVwZkhsS4lX0chl9pl12zAGcxPr2KxZ37Jt8PMvmosoUq/ttKdzvvMemmPrytPsAHj3ybjOf6WSOCtCb5gmA+f0I3qaXddA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776738437; c=relaxed/simple;
	bh=GzVHWf0l5vucDJpwZdVDM4/favjvJ44bEkb5ldw1OrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pQfE+b6SrRTPsy1J1NEvalE9/95HyhIinskzw52j/mmM1fMjHSDFbQ23uTgzZ77CvhZMRaqUDKD1C0aR6gv5uK9tJOuHTIbhyx0Xzu//rDTZ9CSdPE5RttkrxSyUzCZB2ypXbhHMFeY4Po4XK1s+nfTb14WGrqhAH3lMKavUgvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rTEjoy0L; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50fae4d1f85so11865211cf.3
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 19:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776738435; x=1777343235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzVHWf0l5vucDJpwZdVDM4/favjvJ44bEkb5ldw1OrM=;
        b=rTEjoy0L1ZjCEGTGFfFF2UXyxyf1QYYe6bpjp6iguWuXw0XBvc8wBFoO+Dwllvj7mY
         3GhLZPrP2uVMd+vwK6i3S1q1fLMiuWuHfoIEqwtJlbbMHdOleGwQrECBvZt/lw4z/Hr5
         x9M3Roa2Wxc3uXUJVEIrGgMU5ZnJITSwpF0C4aEenj1qRWb93V3a1cUhCVcyYy7s20F4
         NbT4j98hWrapEhYogcGz4pIp9JLk7AnzbBKJqIL4GSlv9xbYCQKVbSaSp/15tPcvY5SH
         iGuuaiVNeKt/tw3BCgz5/xp53b078YCOejiU/H0ewhgQYk4Vfd69fcmIFSENsbKNuXc5
         Bxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776738435; x=1777343235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GzVHWf0l5vucDJpwZdVDM4/favjvJ44bEkb5ldw1OrM=;
        b=m0zMTrKOMtDhEaanxoivzaCW3tZCbYCZugag9UvRMRf+DKk4X7+409JHuEexMB4n2F
         FHvJpLHKB5r0ddijDyX4oVODCQrtIROMwPX46Za2+a8hvOMPXW8YERVtQi9TZRXYhIRC
         fr0ix/jVDhQ/I1hkhM3Ut4mzNvF6EK5A7vOtQDdq+9MBH+UCk4RTdh4JMT5J0uBkrpcK
         FRgegjC/Ik3fME5rYxJDqqxj9NtLweqz6U7NM0IWQNXaatndPfUsrACTQAuoDNUjaedp
         NJOrpU6jVGrt8eVMXQTp+lv1ktvSbEW/dpe5o+esguHUOg4KiBVUsD2hXJ5nKfArXwqh
         77Zg==
X-Gm-Message-State: AOJu0YwAT0KF/EwCKmWzbeYcbMg8w7M+XkbA1dr4GXlkIfKYdjLe7hCX
	PHLhEQ1weiO1tq4vqGIZXDftTvr0JyIUbpN79aU6w6KE9ftGHbXvpucD
X-Gm-Gg: AeBDietDQZYATez4w7PdWX8ZhoxdbK844YRWdUUpKCsswvGv0W/IB3B7AJjW9U6Fjgi
	oJ0sFjCJ111le1RbQTn26tlaYlfqRGo19y2kTvRQ86yExTwqIhr/L9b7ezuc4TjacO/+8534aCd
	1Hu4jRuqZvwlOOxCZOYs+5wmziBD38/VAVJBd3dKpC3ITnc17L2e1+1nb+73rs78/NVMMxOVU4n
	X8wZ3G9AeHMaeBTFGjqXZstwFycLF2Gk0q+MZ2nmJ26ht5+CGGOJVRYSD4GrA8hvahugiW72EOz
	sv3PyR2SQCH8DohZLCXJnI8mFBuuAL57lGeQDETHUAvYqbvECOlE5dwKkAZkibNd550SaOJDq52
	RKxUAkS0oLO3cx/xwnYO6QiECKGRQfUpKbpkoF3wDNx89YbgndO0TzJRZadXPcGh4bB4tELSvqM
	4UhJQRTJZD0DGcbmsAyUHID4t6yAAP8QJMM/59ivFxUX/Yi7MS6ZpIHB/HMG3Dyo3RYhTGpEmap
	w6BUumm0Y2LG23qcTSCj7Vjy6PG/lJJ2YxLV5Y=
X-Received: by 2002:ac8:5890:0:b0:50b:48e3:47a7 with SMTP id d75a77b69052e-50e36b44bf4mr247259321cf.18.1776738434842;
        Mon, 20 Apr 2026 19:27:14 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e39495192sm99144271cf.27.2026.04.20.19.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 19:27:14 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-hams@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: Re: [PATCH] net: rose: use pskb_may_pull() in CLEAR_REQUEST length check
Date: Tue, 21 Apr 2026 02:27:12 +0000
Message-Id: <20260421022712.690822-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <48f45bdb-6edf-4676-a96e-4530634cd7c0@lunn.ch>
References: <20260420015723.462479-1-ashutoshdesai993@gmail.com> <48f45bdb-6edf-4676-a96e-4530634cd7c0@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-279972-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BAF974357A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 15:04:30 +0200, Andrew Lunn wrote:
> Did you review all the other comparisons on skb->len in rose?
> Do these need the same fix? Are there other places non linear buffers
> should be considered?

Reviewed all rose files. Thanks for pointing those out - yes, the two
spots in rose_route.c and rose_loopback.c have the same issue and need
the same fix.

While reviewing I also noticed rose_link.c: rose_link_rx_restart()
accesses skb->data[3] in the ROSE_RESTART_REQUEST case and
skb->data[3]/skb->data+4 in the ROSE_DIAGNOSTIC case, with only a
ROSE_MIN_LEN (3 bytes) guard upstream in the caller. Same linearity
concern.

Is it recommended to send a v2 covering all three files?

