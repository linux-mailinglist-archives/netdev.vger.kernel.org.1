Return-Path: <netdev+bounces-298017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G8UeEmt5Kmo+qQMAu9opvQ
	(envelope-from <netdev+bounces-298017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:01:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5081670228
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:01:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=W3NVRFpp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298017-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298017-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D45C831FCDA2
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B852D3BA236;
	Thu, 11 Jun 2026 08:55:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909A736212D
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:55:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168143; cv=none; b=FInEdA/+Y7Nt75xh9uI+ZXqaq9c6qDNmBYMpLPlpBfk4sGdXQvC3104KA0SyLmuzczh64cXwGT4q6K7sD1Y4MfH73DIzTAVGeweZU2PiWymKgzJrb2p6VYW20yBiJHVeCJFfRVHrdhXVHPUBgQXRAzLqwRsBJm0TKx4YhfdETuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168143; c=relaxed/simple;
	bh=Tg4DS3sWauM/HROr0zbXdV0eQLMGagO8flVocf/2Wks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eyxcq2wXcd+1ZYw3IF0I1Hr8x8vsyE5WcsH6Ar+GhmR03KdVp5AIRaSU0lppbE+oc63UHoRerO6oUSuYqs4diiPba1W1pT57Qs4KbwdS/NfRhwj7llfmndyFzqjNRRAj4ByJ+F4DOlSyo7pBwwAZfzGFusZkNcs2am+0ERJM7hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3NVRFpp; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0c2d8b95bso56164105ad.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 01:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781168142; x=1781772942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tg4DS3sWauM/HROr0zbXdV0eQLMGagO8flVocf/2Wks=;
        b=W3NVRFppEdbmS7V4ct2xhyroYXCV25QD83/Ovft8MuPCJe/itfmG4lVcsZg/yFSF0+
         zUbdZYLQXQtaXxX7JUMsKRDpLwL6KfvWnvijHKqMQchKBhbLKNVUlKqfi9vr02BA7nwG
         kxYauifVmSt6FuLdDF0DzhgJPa9tKPNMMDhW6kPPSMfZjkW8XjJVVzJUhznoEQzID7a7
         3uYwD57v4UC7t7mGwx+ak/oVchNrGT+wvWe+HJw8szeFGu7LFCLWrOGlYhyjrRfg6D58
         ukYHD6xg+3TNOZqGFkD9fvMNOyAGVvp56Tdd7lJBCengLLsjNZViZiK6VNuFdItXBF3A
         rPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781168142; x=1781772942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tg4DS3sWauM/HROr0zbXdV0eQLMGagO8flVocf/2Wks=;
        b=hk6vMpYraLdkzobHcfbxfNttFuvPFOSJBt4Qdsj2mjn1eL6K4BLxT+54IoRaB8Xuv2
         qKXMitA2tFAj7zGvdrCcLfwl9mwUWB8ffIVi1GZKcIEDNPuo8CXGiNpafHIQNtFCZbbH
         Nz8FnJUIhpBBOnKTUdqFWlTy0cexkoQ3oRUVdRpz7mlHeWRXmwqlCJIojMK0718Vsqq/
         OCx0hbqhqwCkluaKNlml+dgnicJtmcfGx6UGlnp9nEvWmRyXpkuCm6JFO7CtgE590WqC
         b6Z9oaR/tFfVqx1c4ca3isojCtTw8gEIShIzbbkR7S++Uj9LKbRG2WE45Qb3m5wQmteQ
         Z6iA==
X-Gm-Message-State: AOJu0Yxd0X95gLpzEQylo4kN1MA+e/PwMfstUFfi5l0Af8MjXhKnx/Dt
	HJLQltz8tRqF9sgEbiGMTqvDCBJ6qDolZSXUGIywk1O6RL3s3a0PNgs=
X-Gm-Gg: Acq92OFe369450LfD9AZY9go4GTVB6FEWawzYVsccORk0jWTFFskyzIMjbGa8Wlrs9x
	y8ZinzhnCeuJjdwsKLulLNp9NFBGuYPmA6e/hqiSicAr2oUEmfN5axwv70bPIETB4wABH98N0Ih
	x76UVo5KSqrv6OWKlIriLB7xZXed4s06X8h+rX2KPq6OeVrJdvufXCbvOyM2Mhr49EGi28p1aiF
	ECeddEqwI/FMPnF/cP3fvPEM0Ds0xeV0S2z11eFngDqUJ5Zj5ljOT+XlS5nBokoL2MxOu3jT+1D
	Of3VfYrocmpQBtPU9GqOhw9ZI/QfLsh1K7dchuSW9SDilZh/fpRu23ryRnROMArX4xnzR7rK7TI
	KCRoJC10qakdm0lU+a33mhPCb39+srKEnzpqJJFJrcRghw1YiKu+qP5HHQAcbxlGTg38GM5eaDC
	kIxbSUuKS9ms/yKOqQ2WHVVy4ozYODO8Z9YoTuIzyO4UfuOYujWlf9xOGowhT93Bdx1U67soarS
	t0WYg==
X-Received: by 2002:a17:903:f8e:b0:2be:fefc:d5b9 with SMTP id d9443c01a7336-2c2f04403b4mr24903925ad.5.1781168141982;
        Thu, 11 Jun 2026 01:55:41 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6dc92sm248412915ad.13.2026.06.11.01.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:55:40 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: sgarzare@redhat.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	pabeni@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v2 1/2] vsock: fold sk_acceptq_added() into vsock_enqueue_accept()
Date: Thu, 11 Jun 2026 08:55:37 +0000
Message-ID: <20260611085537.622665-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <aiptrtQIC5ivKjem@sgarzare-redhat>
References: <aiptrtQIC5ivKjem@sgarzare-redhat>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298017-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,broadcom.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sgarzare@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:bobbyeshleman@gmail.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5081670228

On Thu, Jun 11, 2026 at 10:27:42AM +0200, Stefano Garzarella wrote:
> Maybe adding a new function that moves a socket from the pending queue
> to the accept queue avoiding also sock_put/sock_hold dance and
> sk_acceptq_removed()/sk_acceptq_added().
>
> To be called in vmci_transport_recv_connecting_server().
>
> So can we move sk_acceptq_added() also in vsock_add_pending()?

I like the vsock_pending_to_accept() approach, it makes the vmci
path clean without the double-accounting issue. Will send a v3 series
with that as patch 1, followed by folding sk_acceptq_added() into
vsock_add_pending() and sk_acceptq_removed() into vsock_remove_pending()
as separate patches.

Any preference on the name xd? vsock_pending_to_accept() works for me.

Raf

