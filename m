Return-Path: <netdev+bounces-263390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG8AIzw7p2mofwAAu9opvQ
	(envelope-from <netdev+bounces-263390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:49:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DFB1F659F
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92FD0304DE97
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 19:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5516384254;
	Tue,  3 Mar 2026 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XP5837Ko"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6A737C912
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 19:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567324; cv=pass; b=gXnke2DEg+HbQWeCMu2uUpE21a0BErBXGwyrIoxxZn+HJc5nfdBEGSW8d84pMtJIGPO3qYrx1riJ2LQ4/VqNWvqdHqkZMzHagwSjWhH1xZ0U57iYuKvh2pJXbgdIcYja+MyNaZAjZ/+VC4OasFFnuc7KFGETM4r0CP3tzq8tPAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567324; c=relaxed/simple;
	bh=WOiZSB5D4Pz/2oryi7Vt0VUL8OjDbBTQd1jy6uB4Bfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjkoC2gu0oCE7WlUQBBwvNJen8D6B2BzfZdMxsrMkr915RHKh+Q4kGaFBwY8kJ3sVBBIdamubDJKXUciuBfGbf7ivUBVSpHkA/i0LcNZvKsOHrqUAcTiC0ZDwslcFdiqVKP0XkBBGFLPRXHjXKY9OMh3rDQR8o/ceqMZpf7v3U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XP5837Ko; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1271257ae53so7310068c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 11:48:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772567323; cv=none;
        d=google.com; s=arc-20240605;
        b=WqvTqmxGpmmBgvl5ydfp9igHg9LA1Go1glahK/wwpuCKAYmn0vQEPIMwG+iCnmNYPD
         cj+uzr+bpAi3/IGXrSvE5vdMsMzRjc90lEiu6+ALrHcrQT87xZmJ+M3Qt182ANh2sX7R
         5iX+nb3VUUKXjY+n86l6NQ2yR9kferxyi3PT3xKJvl+dnTx5mJVLBoWei2q/TC2DSsZ9
         F1v7T9G+4or/mQg2xvPi1CI2Z3v92w8VtZCghyMbKCBeyLKgS+lsrUplRZn9PwjAodoW
         224TVj44PaZiM4MAufp4YRv7ccnDuCEBaK1uZ42iTpMZNiX7MZy/7PRul/5PPIGGA1kg
         YR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WOiZSB5D4Pz/2oryi7Vt0VUL8OjDbBTQd1jy6uB4Bfw=;
        fh=5AbLKprkpWuotglQ4M4wBlJbc7fX099MCVvK1ZeZCUA=;
        b=OLuND1NcEYJJh8CmBh+J3DKHGmCvdKY4Z3rl4BdpIMYEJzpzelwg2E3A7kVWFJGe0X
         0l+5vFMnyzqH+sBULUjjOg7IP6afLAVBPTWrrkMY4KsjXoZZulUbSIw5mmRIvYyYf99l
         m4jEO5MysVwac/qxRVIX77iqDlBgZLC3SWukkMrvIbDoWAxK1ajqmzqC7+4PSqBj00Nz
         bz5u/qgvM2W7ZRgKPON55PsZmLey4sJa+4r/5rlSk8jG3CBXQq8yvIq+I5NtzmYEQc1D
         c+Q5PdxfNHwocQx3msH87MPspLGAgBKkTDygnOrISMVPmXocG0cEpelZ6PrFJrlqMLyz
         b3ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772567323; x=1773172123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOiZSB5D4Pz/2oryi7Vt0VUL8OjDbBTQd1jy6uB4Bfw=;
        b=XP5837KoimAzx8sb4m2WXxT8S7obvrvMgMnWW4hHGsjjmif5HJ7mVR9Z1m3cLjtT9E
         +i/TlpqSI8h4AZozfrQg9OwhO+L5bMTNwOv8V3/cW/F6Y8kn4UzHiO3Evf6eY/vMhQTz
         wqzEk1cltCvWDhrj1R9Qphi6ZM6I9Dy2x/7HSY5737F2jUdNSwFEmvvicUC58i9N2xKj
         +x9YhYMFwWZ6KZYmfAddhnIdLh0LpqG4fvakTa9rjPYecIH5uzJacqnb92IpTXtsIUgG
         gUDrDYkHMMB7DdPqvpWN+Pr6Xud2lahz2DnCslA5csv5cjipFBtgteTV7HI2l+eSOXJE
         zUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772567323; x=1773172123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WOiZSB5D4Pz/2oryi7Vt0VUL8OjDbBTQd1jy6uB4Bfw=;
        b=TBtb6rYCZ9vRc3VfnElIX0Yhqn0RlFtMYz3WZ2LvU20GXTXdIVID5YV+qO4/kgQuSx
         0l9asisxdYwJQr2kgFHwrUXVnNCKVRQ4yohHTASxhGtksuxRXiScvrv7+eTHwii1cJoE
         hIKTNBC4cE45baLsxHo5kds6nzVk4tq+FzmPDVHKGbj37JETS55/goO7TUGoij05IKJe
         OkaPM9CtMJBRv4aESEoLP/ND+4qBZPRZXAikpgCQLOFOGQ+9C4AwWi7B73E0qjgJwK6H
         m2HYuvnfMVQ6k4fpAGTRyjycZpEqvjFtoulHuMmn5QIrZcF+qlqzMOUCAdFohHLgshlM
         ddtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEA7edXDGOYnSxLwMCe8ppAMd38tPxnqlitGx47lFprOgCQowrFd4hdcOm7dgWwrUv+bb2bQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YytXYfGIvhn2SywEyHWalhJ69AhJyHI6CMmc9Vp49n/EDkedM56
	vNEKLI7eK7rCnERJ+CwHU8Gb9dydFFLhaLooYM42Gy6lZTbt+d7r95RwhC/UYkW7FZ3emmZETsr
	RDvZ1fMbDdO5WEs1dsA0l7iX3BpT3WzyBzjiythxH
X-Gm-Gg: ATEYQzxuDQGqFPcyEEgHk5G3RDU+up5ELYipDwFiGZ7DNRPTXJXwXBX+evXlsAPpFRo
	fFElHzpWumJwL/jevZGFben0u+CYEJH676xe3INcnb1d9rP6+QNVPmkQZHFcl1DVg/oGAsxgbQL
	pp5jhKDtsrbT/NVH41T26q/vT3KBp3ZJ2rKMi7vPC9kLPHu8Of+8evEb2IZznF+HEyF1F0XTkIa
	wuYwB6n3vjIrdVKEXqoifXOlG17tMYalj0S+IH29bZvHAIjr1jSTcLUr85Y8vrneMvFTw3HvWQE
	Bwgfy1LSEY5kWHowhQmZYOkLDRUjfY8hWiA2PMh+JYvSaRPiV1uPXWmQ3JWIJngwiswwPA==
X-Received: by 2002:a05:7022:6baa:b0:11d:f44c:ad97 with SMTP id
 a92af1059eb24-1278fc1f744mr5984165c88.24.1772567322171; Tue, 03 Mar 2026
 11:48:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302181432.1836150-1-edumazet@google.com> <20260302181432.1836150-6-edumazet@google.com>
In-Reply-To: <20260302181432.1836150-6-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 3 Mar 2026 11:48:30 -0800
X-Gm-Features: AaiRm51A3EFAeXgHMpnKV51LQ-xPPKfTDtC9QchRfwF-D-3oi0Dk1sL7ZpcbG3s
Message-ID: <CAAVpQUDuA+h_YzfGDfefayT1dz3KADjWh6FnEu1V8CQ+MpzaZg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 5/7] net-sysfs: get rid of rps_dev_flow_lock
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 37DFB1F659F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-263390-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 10:14=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Use unrcu_pointer() and xchg() in store_rps_dev_flow_table_cnt()
> instead of a dedicated spinlock.
>
> Make a similar change in rx_queue_release(), so that both
> functions use a similar construct and synchronization.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

