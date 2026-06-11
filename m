Return-Path: <netdev+bounces-297876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u0b0FLESKmoaiQMAu9opvQ
	(envelope-from <netdev+bounces-297876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 03:43:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C16D66DAAB
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 03:43:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gSrkfHLx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297876-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297876-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ACA030B1219
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783C72367CF;
	Thu, 11 Jun 2026 01:43:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63011E555
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 01:43:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781142190; cv=none; b=fai5ePqZu2YSPKp1quxVZXLCBTlax+FiBByQvt4bpuxgehE5cqkx5ei9ZaDbzEnKTuGx66VxOOT9yKwTgxjGKO3EDp+0DKlZr7elA3izYD39yNHwwDYenWCZcOp32Udsgx9Z/pf2Iq597rwHy7OU5s30QVB/BXiSH15Xl5ZTIgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781142190; c=relaxed/simple;
	bh=+n513kDZ3TcIR4W2QVHnQqu/cInucM+9o9ze9SW7VLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWzcPD9OaWwnoGuFi4L3Ya4wHtMfMPPffg0vHnzMfIgcYzJx2miYIu/IUADGpQGgsgqtnfg8KlTS8KrzKEVvTexIWozXvNlMxGvgrCkBTXXXD08p4mkIVlQsbz5NmnG97HUmvTphAsELp1cmw12CbcZsCFX4lzlrofN0aLINFyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSrkfHLx; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf1cda2b17so3328965ad.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 18:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781142189; x=1781746989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+n513kDZ3TcIR4W2QVHnQqu/cInucM+9o9ze9SW7VLw=;
        b=gSrkfHLx0/sm5xF0dE9ugXREgvgnUgTHn9r2qRvHxlwqC3DEtOm7x8J07wsffXgUij
         65gj9SBrRbdOQR79pNHdLSGL24QuaA/5HGG8YWXydBInr17TlirAjn6W+EOtSw8bma7u
         aRo7xXqRPdV/lMKSGT1IBt9en0jn8S81u4Q9xe8owCAky9I/OuSXklZMLMmqq8nfLp9A
         agZmjfAGN/pX0Bbj0XMACxE4qcmEBPBltDC3S1BzwMZhzLyGyZYLlA8PKXz/jGpVdq9D
         QOH1uz76J6ugoX46YNdgYBrU1MSqnqmar4TSlObpbPO8aJd849eHchbczM4Mle4KDyV6
         3Uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781142189; x=1781746989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+n513kDZ3TcIR4W2QVHnQqu/cInucM+9o9ze9SW7VLw=;
        b=P/ca61kNm3zC2wx9FR0bJaeRkWBn4g1FJ7pgDVC+7nWfNcjerw94F9X9SwbKvvg5aq
         Kj+l1V2vdgRGm3HFU/qx8BOJuyPaXJg2rWVT0GKFS8xcC50IQWeov0ZwTZ3q1UfvnX2r
         ffF5X2Odbus2sWfMTAweSrto5shrMH4hoSrj3hgnxjH/oOwfQY4eypv6iuvPRcnDBaJB
         hhwDFBwg9MtU9xku6HBO6swwBwbeYWxL47kGq+KUr3uGA/ra0t8zOQqlG4gS1wLcFwD7
         7zXJkqYX2YlRl/YxnOLyqqRDYZAqUTLdMeklkPoosHQi+MC1b2xgSj9YdaeXqVpB83Uu
         gXpw==
X-Gm-Message-State: AOJu0YzugwWOAevsxj/ZfS9tJYyj+XDXhkcCTKtWHmbiDXGgSgKljX1m
	I5zA5DongIDAQp+AS4c2uDgXI4sqrhCJx1wIq6ejT0A0INEcyp8k3Ds=
X-Gm-Gg: Acq92OHJGxGhbkHDpB5fhXwGpNCtgnAw3quYEj42CBy7790zZIJFCL3WEH+VynBpq8m
	iq3NK613DJ28kgRKV8D2Rjgr6Hqt+P0mjbSV3JiDg//ZTKg54EewWDUBa2Xdy1Q3bGfruhWkroH
	Rawzpmj8FZ55UGfOQjLFo1fxOfEdA4jTuo6BGmbCjD5HY1UiN6uuGoJSP9bWQ4xfep2O49eZn6B
	wIKoEIMgoDYwElm5PAztBt4rHPuTSBtybMY/fgV0JXs2NAP4XKm16VzUvwubiZPhPvlPfHCv+DQ
	PeGF3fHdiQYhx2gcPqcnIhs7+FiGyLworZN8PVQ20ilaTMUxplKKfVcysAT1O5ib96UPZNeFjt3
	GOqKzUSI911xypVmIrgmNBGrkoJ94H3hMPy7moJbgQ35PAGIc9sZGNzkoTl+zeZ/dzHTU45C19h
	0s6eWJf2DgY5WoTYZEZcDygvTzPMc744JLRTfV4NYMRaadlPt+djux7b1IchlRL4P4iP2pih+5m
	nTtVg==
X-Received: by 2002:a17:903:320e:b0:2c0:c262:b924 with SMTP id d9443c01a7336-2c2f7203258mr5001395ad.13.1781142188609;
        Wed, 10 Jun 2026 18:43:08 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e636sm260924895ad.51.2026.06.10.18.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 18:43:08 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: bobbyeshleman@gmail.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next 1/2] vsock: fold sk_acceptq_added() into vsock_enqueue_accept()
Date: Thu, 11 Jun 2026 01:43:01 +0000
Message-ID: <20260611014301.22599-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <ainvZQppoc7LfPRs@devvm29614.prn0.facebook.com>
References: <ainvZQppoc7LfPRs@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-297876-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bobbyeshleman@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:sgarzare@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C16D66DAAB

On Wed, Jun 10, 2026 at 16:12:37 -0700, Bobby Eshleman wrote:
> It looks like vmci might be an odd duck here, where sk_acceptq_added
> actually pairs with vsock_add_pending(), instead of
> vsock_enqueue_accept()...
>
> For example, if the pending work timer below fires, vsock_pending_work()
> will see vsock_is_pending() is true, and then hit sk_acceptq_removed()
> and underflow the zero backlog counter?

You're right, thank you for catching that. In vmci sk_acceptq_added()
pairs with vsock_add_pending(), not vsock_enqueue_accept(), so moving
it would cause an underflow when the pending work timer fires without
a successful connection. Patch 2/2 is unaffected.

I'll send a v2 that keeps the vmci call site as-is and only folds
the virtio and hyperv sites into vsock_enqueue_accept().

Raf

