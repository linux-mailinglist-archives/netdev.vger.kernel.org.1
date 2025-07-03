Return-Path: <netdev+bounces-203688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B0DAF6C29
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1190C3A3124
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 07:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5912BF3F3;
	Thu,  3 Jul 2025 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gF9ILZ8D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6844429B8DD
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751529329; cv=none; b=kMCYdMxVgLc0QP5RRjKVTkphOkeA5f/qCK0BeamC6mWK8rxF7XNmNDZea3nL+Enq9eDuUjGLsrtCkf5OJUc5C4fDPkQU6JwZUhyOO13mZ9k3Ic4qTI2oFUlIifVuzzxZ1jrK3XR2s8pkZGVHXWQlYcy4xJEZkh4+uZ88+uQ2Xe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751529329; c=relaxed/simple;
	bh=4eQMR5Cxv3vb5mcNACtf57k9qc9ksHsIKZzfmokX3jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xv48X3OoT6rEr6OloNjLK85jDomtGaP4yjVeBjC57wE6CU3kOx6Z0ilody79o+pUWQTMFzLSmiYzApNsE79bOOUlKnAquGVMwjA36W/fenLX/ZiRPnfGJLVV0HfvdfaGuzEWwXRHW0AkEiei5Z8gQJBjMQphV0dYTtSgK46znlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gF9ILZ8D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751529326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHZg+urUsTPRagTEEFZ2q0TPLV/wheKvXpnortkonGg=;
	b=gF9ILZ8DK/EUpzvOSA3afD5uAWFNELL5Eq3ik5ey8u/EZubGhDccaSQOqIReJL/dI2JJ8K
	0upBDewg+TO5W7I9supjTHYZ3kVFLhyjYiWpfWV55GS2h6BCyex0OkmR2VJaVgcpyM+qhO
	aPe/IPQJMhHWD45O1QTk3X5NId0x1xw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-VOkTdyJJOV2L40f1P-XP1w-1; Thu, 03 Jul 2025 03:55:25 -0400
X-MC-Unique: VOkTdyJJOV2L40f1P-XP1w-1
X-Mimecast-MFC-AGG-ID: VOkTdyJJOV2L40f1P-XP1w_1751529324
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450df53d461so42920955e9.1
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 00:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751529324; x=1752134124;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHZg+urUsTPRagTEEFZ2q0TPLV/wheKvXpnortkonGg=;
        b=Q9fYyWgB7+93Xfckrvjc+wVQrEN1bBS10jenaR1QkI+w2tU8acC1f7crpnpTAV3Mo3
         JgzWNGmtjkC1LpOUT8DM05gTpBeQXcKjUU0uGZwF7W3LyxSEi7dXnCW65ibnkcQ9LQmN
         2JO2Lb9ZuxVLF3t3+PJSW6jm/fV4Dbb7mAVU+6tHRZ9v87WtTxhRg0HXgKOC+eLjHcTB
         HiTaMRSk77TMASurv6hmHFOqw1F7oYxM16Ozx/6SviCUYg3XqH0mRigtNcdhrhu7BPOE
         k9n1xnYkB2oU4NS3efMmD9LnR+x/JRGOheY+LthtAdjLwHsYyMkJLbFNJJQr7eQsdXBp
         HYQA==
X-Forwarded-Encrypted: i=1; AJvYcCXpd/FV1ptk2EZKtdf+jnCxGtEkz3jzhesMZ9pB2vtcBp/U+UPad2XTixm2Xc8w0ciXivGPucE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDhnf0t3s76dIPEpIGqropg9AtoX2ZUhUpF/zcYsCwLJUWqkyZ
	yk7jNHMmxGZnBc+bZ2waSTtbrQCxYYtnXjt0wGcCKmAGkP2aTgP4GZVNgqC+GGyiAG6nSDB+Mm2
	5JtiGfRSze9TkmiRKre5Zlwmdua2Dkxy6eQKM9TxKwPrCW1IWle1+2jY35g==
X-Gm-Gg: ASbGncvCb9/dc2MAqLinlBjUQHGctUMx7sNmFVeCe+i+Kulk2csa6SJna8ixHrkBZFi
	9PINHphLWbEoI92aQxLN3ipezf2AUfu6wpr2+nkQ9I2T7pGeeT/X86okgY370GUPmvbSGVmrJhk
	elXNd858SCyaLO7mhC/zNhvk0e5ehJB+JzUpOkbLUPM7n/C3ZQoRWw1ZDl51eozxRbEvUECgQ7N
	zkU2ZyI01Hss+S05A11mXMc5GiAW/CjfZ2mKxpjrjSeafxzA04mqO5JNEh/AtvypmlWtpmkTBal
	jD8nD5nNJxSKprTvfsQ/9liVlcb5E396DgBLSwGzRFM5olhayiKEBcKPge5WEy+YY2k=
X-Received: by 2002:a05:600c:8208:b0:453:b44:eb69 with SMTP id 5b1f17b1804b1-454a9c7bb55mr26672315e9.13.1751529323700;
        Thu, 03 Jul 2025 00:55:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiHFj1UwVxSDWdgovCLzh2YT1kL2uHoVeghrzdOqaM06vcAM7xPfEjdU057FfSSf2GyYXOsA==
X-Received: by 2002:a05:600c:8208:b0:453:b44:eb69 with SMTP id 5b1f17b1804b1-454a9c7bb55mr26671865e9.13.1751529323186;
        Thu, 03 Jul 2025 00:55:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314? ([2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fa54dsm17665107f8f.23.2025.07.03.00.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 00:55:22 -0700 (PDT)
Message-ID: <9bffa021-2f33-4246-a8d4-cce0affe9efe@redhat.com>
Date: Thu, 3 Jul 2025 09:55:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ppp: Replace per-CPU recursion counter with
 lock-owner field
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Clark Williams <clrkwllms@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Gao Feng <gfree.wind@vip.163.com>, Guillaume Nault <g.nault@alphalink.fr>
References: <20250627105013.Qtv54bEk@linutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250627105013.Qtv54bEk@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 12:50 PM, Sebastian Andrzej Siewior wrote:
> The per-CPU variable ppp::xmit_recursion is protecting against recursion
> due to wrong configuration of the ppp channels. The per-CPU variable
> relies on disabled BH for its locking. Without per-CPU locking in
> local_bh_disable() on PREEMPT_RT this data structure requires explicit
> locking.
> 
> The ppp::xmit_recursion is used as a per-CPU boolean. The counter is
> checked early in the send routing and the transmit path is only entered
> if the counter is zero. Then the counter is incremented to avoid
> recursion. It used to detect recursion on channel::downl and
> ppp::wlock.
> 
> Replace the per-CPU ppp:xmit_recursion counter with an explicit owner
> field for both structs.
> pch_downl_lock() is helper to check for recursion on channel::downl and
> either assign the owner field if there is no recursion.
> __ppp_channel_push() is moved into ppp_channel_push() and gets the
> recursion check unconditionally because it is based on the lock now.
> The recursion check in ppp_xmit_process() is based on ppp::wlock which
> is acquired by ppp_xmit_lock(). The locking is moved from
> __ppp_xmit_process() into ppp_xmit_lock() to check the owner, lock and
> then assign the owner in one spot.
> The local_bh_disable() in ppp_xmit_lock() can be removed because
> ppp_xmit_lock() disables BH as part of the locking.
> 
> Cc: Gao Feng <gfree.wind@vip.163.com>
> Cc: Guillaume Nault <g.nault@alphalink.fr>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Is there any special reason to not use local_lock here? I find this
patch quite hard to read and follow, as opposed to the local_lock usage
pattern. Also the fact that the code change does not affect RT enabled
build only is IMHO a negative thing.

/P


