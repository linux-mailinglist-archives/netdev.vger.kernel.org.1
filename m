Return-Path: <netdev+bounces-298018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1iiFO3B5KmpBqQMAu9opvQ
	(envelope-from <netdev+bounces-298018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:01:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CB867022B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:01:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=achG4C+S;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298018-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298018-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A4AC3210C44
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0B139B95E;
	Thu, 11 Jun 2026 08:55:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B9036212D
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:55:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168157; cv=none; b=d5nEYJxs6zlHEmSmLghwNYf2kfUkdW0JpCf/wV2rLbXevSwcn8XW5Tvct/qxHyBxZnDPJBy23ZA+Qz+7+z3jrBLfW5YZx0kcXdlFd/Bupg+wPYHowwN6ktsO0s5MMg7Yw1X4e/HSpc67sbLSHKEO6wX4d05uwvLjLnPXDM4T6lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168157; c=relaxed/simple;
	bh=cdf6zOQ68rkdfy+2UIkAzlZ/8jxopWcx2C9dkL08eXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8IXqR/23h6vJy5Jz7qorqiMGDjZnWRsqrYDilqXpKMFe1b9xx17OquWo2fjBsXDhll6xx1BKu3YHLuxJs/vCst3MWdA+KGPHi4Krse2SkXIFJcN8JjfxNj6hznR6p0aoNSTlw1ORbMw66NKiV/I9/NRX+OwRBpDasidhkMgrTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=achG4C+S; arc=none smtp.client-ip=209.85.214.173
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf18c30bb2so57430895ad.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 01:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781168156; x=1781772956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIc5aGCRuh/WNyXNC0AmWEpzTu7IhjAFmIuMhEhGp7Q=;
        b=achG4C+ScP3ijhroh9tnCJQ5vNFrOlEVRBDNvdqeC1/pL/SiuGGc5i3+F4+5bIae2r
         b+V8r//b5sho9KgPQSoZcZHZZTFvXYs52rwWIWi2O8Bl9tSVdvyjmY+yf51RJSLxvpog
         yoFs1XGLnovtVwowIV5IYW+/gxFj5jupC49Jy5TULZzqLL52FEmgN7kigOWbKLIzA59J
         Ad/Dy9PAxzQFE7tfGSmI9BkQF/smig6djr0Jlp5oCvbGvBOtTL77gmLI8JsOGbwn5T/6
         GyXlZ6oyOOvljm66CthP9kQCfpjwOUBQm47LesC6mqw1ykU8jPiGpKjadeQAluDmaV+f
         vzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781168156; x=1781772956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cIc5aGCRuh/WNyXNC0AmWEpzTu7IhjAFmIuMhEhGp7Q=;
        b=RVq+vUj9scWB++ELUv4Zs2B1xE3NsD5OFWF+J+cP6n9AW6LOl3+zUQ2TM/8FmyKxEy
         8fbNIE9PKZRmU2bpNIbttCaTDLYfeZHaY2VResyC/NKDhDz5ODyj+XhbZH1/3as8fYq8
         1sP+hxRnoKIjjC/ssEoIfwZuYJPOXroM6401UTtr/dhDYZYfKlzfFK/EW3nut1abAKO6
         KecMoFiHQ7u6j2EoQe/eIJnSAFRSum5h2NtbX0L/gouFnCMy6S9/9btd57tRxzQUEDP5
         iGSaTerYkRCg31yPOK2KSwaX//qOV37mCqgMBvOnxLz7Jit8M7VkYwPucbFXf54f4SPZ
         sbQA==
X-Gm-Message-State: AOJu0YyFSYqnHCsccyWzlk8GLYTO+aAK3+LU/n1bVO1pJiK1BGgFylmm
	J9X+iv3GZwOP+0K/97Yw5c3RT+HPiaMNFklb5B5MrONIqPpW41fkwaY=
X-Gm-Gg: Acq92OE4Gsln//zrBMz1UFQmqzI4Ty3AwPzh1FjWESY5JfuZQ/PSD6olb2mxnXDIkG2
	27vgIX+6oR5ESMfVxg0S6cidtXS1c4yBbGjC0EVwTLcH1fh8CchAo9EETrLE0ISMzw5Bd3cqgRq
	OKXgqTqXlbPBIJNtJzRthkJL4gL5r17U9Oi0/NtIj/ijGcNuRwnZJ9u7QPZQfQeTQq70UKZtxAz
	XRLJTQNrvEdhiiTL6U3LXexQEx7N/87wCzTRS4oNRhFrv0YzXfeYZqxDRzdgRq8rOhVd0xZd6zR
	c6Abf6xqPZm3zlGtH+HvtpfNRdhWrWtbF96TgS4/vVR6Y1/eM6swb1wqGVJQJBMj6PMGqtKXETn
	eW1Am4finTl7TTzJ+spEnDQZLKbj55HktVzFI6qMT5M1gPYhuw41qQNtBQEEKcIQOrsfqGGAbV/
	5Jud25MFs0nlLhn1LwQgwxwiCeBNQVoKy3Elc/XtPRkNJ4N1OQHPisfnKx2IBJ4ylGnN+Te6U6o
	HlW7A==
X-Received: by 2002:a17:903:2ece:b0:2c2:7e17:39f6 with SMTP id d9443c01a7336-2c2f2f5dc47mr22090075ad.36.1781168156009;
        Thu, 11 Jun 2026 01:55:56 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c24edbb49bsm140758755ad.38.2026.06.11.01.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:55:55 -0700 (PDT)
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
Subject: Re: [PATCH net-next v2 2/2] vsock: fold sk_acceptq_removed() into vsock_remove_pending()
Date: Thu, 11 Jun 2026 08:56:03 +0000
Message-ID: <20260611085603.626387-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <aipyNh_qseEUxj6Y@sgarzare-redhat>
References: <aipyNh_qseEUxj6Y@sgarzare-redhat>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298018-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84CB867022B

On Thu, Jun 11, 2026 at 10:35:23AM +0200, Stefano Garzarella wrote:
> Maybe we can keep these patches separated (which I like) if we
> introduce the vsock_pending_to_accept() I suggested with an initial
> patch of the series.

Agreed. Will restructure as a v3 series:
  1/3: introduce vsock_pending_to_accept() for vmci
  2/3: fold sk_acceptq_added() into vsock_add_pending()
  3/3: fold sk_acceptq_removed() into vsock_remove_pending()

Raf

