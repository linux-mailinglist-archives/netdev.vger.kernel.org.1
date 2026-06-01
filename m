Return-Path: <netdev+bounces-293669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOkSIx9fHWojZwkAu9opvQ
	(envelope-from <netdev+bounces-293669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:29:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F7B61D68E
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E40B30E2446
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 10:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DF43090D5;
	Mon,  1 Jun 2026 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSiUw/7F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE163A5E9F
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307812; cv=none; b=ALlBhV/9iVGXKYfLX1DHklHmYusznLgPEHzHuAufgReRn9ht+cb+fGsSihHIxSe2XzZ6DwlEYQUZoEnG9xwwy7VrNQWTCTVSDdTQoJiFBERVj+u+5zA56yScKrdsE83NJQibWrclBU8yCFM7olTGKFcQYh8Y7koLu//j/Pb3+38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307812; c=relaxed/simple;
	bh=oTyuv/4q8lfTEk2MTKANVi4deoOAEf8o5emx4pw77kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alrsQBTFWjKAK19qbTkmYBGJy0uQze+hFiOSUb38IHcf8k+4Xo8IF+2eevmLtzaUtvA74Yk/H7IBLdvgjpzjagW6alkn1BijFax0Qv4nuk2UaKkeYKkOzcbVlBKhB7Gyuhc5nirWxjSjXD4IGeYyRcTOl+FcU7Aqxk6/jjUOz+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSiUw/7F; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c0c20f0c0aso7564795ad.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 02:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780307803; x=1780912603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTyuv/4q8lfTEk2MTKANVi4deoOAEf8o5emx4pw77kM=;
        b=BSiUw/7Fk3WHa0LGaHe9B8pASuTyDGRPQt51lsLMgL9A3IyNQc+L1Y2U25nhQ+fNMf
         gAWJMCkxK63AElqZ8EUZYqC9arhMMGTGNPu1RkYgYj0RxWw+SjtfWoXKDlgCOC33a8JF
         pUCBHTaEUOE/5j+laAI+myPJ4EDfzMDvoj5RnPVA47Z9S8dqROsOthSrGnJQQqYlsG/y
         IlIH/MKPXOZ9SXg34arUEIdqgTHTBtIgRQn9fmm/8YUB5hB6RWXh8Xf6z6jjBWmCVbKT
         kBu8m7WD/CPec+UM9Z2Fui4W90zqXqlLo9PhjUWRwVAHEl4lUUZrVIcVVY4fnxffp/oz
         pY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307803; x=1780912603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oTyuv/4q8lfTEk2MTKANVi4deoOAEf8o5emx4pw77kM=;
        b=TV1/8tU33M+oFtd39bw7Byr99T+KiO94hlUCe55iz8VfeinMtHUX9mKs26Lvl/7kuy
         RiuxWPpdPeG3fY2cnfB9hk3VRWjgI94fEsWonERzO6VwWHOgg+nXQuYtpn5C8w/lctv/
         2wurolfVMDueL5YZihU0hhSIHf47ClF/YlWU7C+8OybPwrQrQo7wUr6wOlAJsykjdtsc
         ZGD55s9bdOtwMsNENyiyEpcHk4JlOihLUYn1rXBV3UZ80OuUQ/pzsP1SkFTKGXtQ1Ezt
         7InEuTb9f6WbxMCjqh0eGDEFs75vX9LzhaBQMKJhjEtfA8osItnQ1RKJL1L3MbElYPef
         T1bg==
X-Forwarded-Encrypted: i=1; AFNElJ8R6X8A9qQ2qCl12Ok3Iav75Ut4QcYT7kYA8xE7NARdt5KMG7K3dSNj2jo9NE4f4hPVRh8GTl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHpFJzIQWSUUxU0l2ozinYtjyP+iiErLATBV3nq2ZWFECbsw3N
	zehacFNXjwm6XwOVBTQ6juUtLC82sx28jXIyHsFz75swO8SDpfTsrHRhs5B+zlFvhg==
X-Gm-Gg: Acq92OEpLFwS0+KJZGPOAsbPvyZScZTP4tNCx6P5qBwIoj4tskgHfaaUpiToh6lRTIG
	DOaBbNQUdJsNH/XtcMZJnop85pyyWnqZ/B6MXvy+n/xtQZbOPKOtE9J4yUKq93g+3CHR9rANL8L
	si0w5OrjE6zsxYKuEgkyOuG9AOc+BkbtTg9LLxx35o8O6l8/TY9xPo2moTM14PZGKYls3nULMvY
	4UYAfsalgfe3KzTqZFZdrBygB/4ismQtKo/dDiZDaZwoaWysXW1QK6mBLcJTuUKIVb3V4UTNysJ
	JdfRRAS9W5CeKvv/U9M1mX1hcERAiVL6/2bzsek3z1lx6R2hrrh5a9MiZVm3RLg8cgGJKmVlN0V
	H/I/eEBGzbgoexLR5c+gsJZu0+zaRidgJNfunQ3uj9teTRPVW85x3qQvOBGA3ju/E0AVS/YW+RB
	GWfqDyuHxC40l3N4NMe8EGIksxDVMtkAhV2eQ9rIHB+xxtcLfp1U5bY7XFNDCOupHvXSzSIR8jN
	R2fqA==
X-Received: by 2002:a17:903:4b4c:b0:2bf:2243:d4ee with SMTP id d9443c01a7336-2bf368021a9mr119460275ad.18.1780307802630;
        Mon, 01 Jun 2026 02:56:42 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c4dd4csm102143265ad.78.2026.06.01.02.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:56:42 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: pabeni@redhat.com
Cc: sgarzare@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] vsock/vmci: fix sk_ack_backlog leak on failed handshake
Date: Mon,  1 Jun 2026 09:56:46 +0000
Message-ID: <20260601095646.180085-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <97069506-352b-4152-a57b-5a974320529d@redhat.com>
References: <97069506-352b-4152-a57b-5a974320529d@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293669-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 29F7B61D68E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 9:26 AM Paolo Abeni wrote:
> I'm wondering if sk_acceptq_removed() should be bounded in
> vsock_remove_pending() ? (even if that change would probably be
> net-next material).

Agreed, that would prevent this class of bug entirely. Happy to prepare
a follow-up patch for net-next once this fix lands, if that would be
useful.

Raf

