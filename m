Return-Path: <netdev+bounces-262206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDzIIltMo2nW/AQAu9opvQ
	(envelope-from <netdev+bounces-262206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:13:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5531C808E
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A11D336A79D3
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 20:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6C9175A6E;
	Sat, 28 Feb 2026 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXlzEgD/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3CA175A65
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772307991; cv=none; b=eXK1ki9PgXAffDiwQzoTkSCHNtPcgkABzz/oQw4j9sPfjCecp9UqfLRvnRT5KPyJ7UVRs3t3jVoPyx9wvFCij5olXE7XvuJRaOCGa3+6VZFc2TqQ62ykyJr7LtjIo0x7wOQQdPz4sfmr/Us/fQQm7ZdbY9GrP/Vd7GUMO9amPkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772307991; c=relaxed/simple;
	bh=s7ndiwbggfXGwArebI/3uekEoFY4lPZ1GxgWNfjoKjE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MNws0JH0DmBRiO4JNz/HDBxyi3Q1eR70YW2TQBIsxv0FnsCC0GkSYrlHyUrOIM9gU9LuENBmDnyIikATjiPYacDdReJcu3mRffeawGHKr6g/2tr1u3s0A2tpicpyfSOxtg9DDBxLUha6VqD6X23P3wMMrjw3R2nsGxkeBARFigI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXlzEgD/; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7986d231b3cso49926107b3.1
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 11:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772307990; x=1772912790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afXO0Q25yG22NUDyiXMSNWqDgXsbVEFPUKFeke05sJ4=;
        b=LXlzEgD/uWlKxS08CDFwhs0VaKcz1ZN43Soa3HGkOI2ioi5IKyQeOHkswW9XQNv1/X
         joM8vtUOPVKbqB1fb3XjvzXaEvRAn520U+m3k2vSNuxzG/AcrNylI8K64A9IR3o0FbG9
         HI48GViHhvPCtN2hlXisM9ynXiFXrbJ9DfMZ5GGnQ3GSkxSNkpB95X6hpoeZ1w8gQ9rF
         LOs5/FTwbKtC9yGO3J4JBqaH2hZ8KrfiLgsck9gXlRvV117vD5t8ZmC2wG9geXFSfkSm
         PtByHhHVZypq2u+1UGhZgAUPtjmJM9jC+slUBtNv9T6QVHXcbuZwJpx8QBkb23peAvdG
         DG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772307990; x=1772912790;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=afXO0Q25yG22NUDyiXMSNWqDgXsbVEFPUKFeke05sJ4=;
        b=vRzCRkFlHdEPSy7FrUitTSBnsBbqQwM21FEjW76X6befIbh3IMkBnenv2p/KjCzvi1
         e1e9PjsxIBXUjM9w4bSUh7/mt4kXYcy9nTWOxd/M4snCTUPK6TYm6cIr1YEx4z+mEq95
         9Fdllih7MN9Z/kjXqjluAZXqTexRiZRNzO988yMJOh94TlCS64VvadmT8ZS+ZvK1mCH2
         wb+tvn0a0Ehz7pliSmChOcrz2YSPsV2WKkn+P5fVBwJ1hbh39koj5XifBriX7qVY5c9v
         wzVM8PdenYCGYTUVSdxKZQviECR9Nf8QGMVTmwDGX10iwfSuXGkdgdEIndrGXDCxp4oE
         1Uhw==
X-Forwarded-Encrypted: i=1; AJvYcCVdKWHbtrkkOKeLjvaBs1bxn86H0GvDxSzX7x3v4EW78uYA2VPj42GdGQgNCqgijSxuE6lPszI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCtihDDiRuW3Kb7hi2DML//VxzR69Zted9PSDHdTR0KcGmbMiQ
	pFcEJ5eMtiDmmQNharV7ixxezaCz8LN3NnviucsYGHmW5F1NWbgwCrzG
X-Gm-Gg: ATEYQzyJ1V8k7hdxD6O51YIiosM199dIEFhkaU16C9gbzIzRS2kr7V66AKymXKtBVIm
	FvjUcAfBlm2C7Jib5MMuClKdapAC8bJZkVuXCtpHThA7BUF2f2pB15J6njDFjBGD9vwzW3ho84s
	Unxza2wAvMv6SQ2n3FjFrGMtyUMA1jR35yi0Whz30rhk0Ympe8LIfjhu1YDfZRvbKABZ9t7BApM
	Sw82wsAX1dcovsbfS+XkFVl/E6Oel5sZ0n/M2EF8Ut+2N6Ui4mrVtntYDYI9f8VfS9b6YPyfNY4
	meQ7c0lO2fmDU0oN4n18J69u91bE1WoMUuqljl4QvJD4TgAfZg8okzurisuerHz6a2XRdh+TUii
	/XJgzrbwg14+Z9ZTtJJYtxqBPpicHwA//ac5/dXWLL1UA82RG0ny4yORc4ggWqAZBOc1zzU6Xf2
	KCBJgy5olHOCwVTcuHArFlCqTsB643V+E0Tu9guXTkySRLRvWGTNRl7uZM4RNux5Lwex/KoJ8=
X-Received: by 2002:a05:690c:600a:b0:794:8a60:77da with SMTP id 00721157ae682-79874ba383cmr95437367b3.11.1772307989823;
        Sat, 28 Feb 2026 11:46:29 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79876ac7505sm34024487b3.14.2026.02.28.11.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 11:46:28 -0800 (PST)
Date: Sat, 28 Feb 2026 14:46:28 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Kiran Kella <kiran.kella@broadcom.com>, 
 willemb@google.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 daniel.zahka@gmail.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 jayakrishnan.udayavarma@broadcom.com, 
 ajit.khaparde@broadcom.com, 
 akhilesh.samineni@broadcom.com
Message-ID: <willemdebruijn.kernel.1c3d7105f1c48@gmail.com>
In-Reply-To: <20260228100449.19f6ef13@kernel.org>
References: <20260226184654.3180648-1-kiran.kella@broadcom.com>
 <20260226184654.3180648-2-kiran.kella@broadcom.com>
 <20260228100449.19f6ef13@kernel.org>
Subject: Re: [net-next, v3 1/2] psp: Support for transmit on logical device
 when the underlying transport device supports PSP.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262206-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,gmail.com,redhat.com,lunn.ch,kernel.org,vger.kernel.org,broadcom.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD5531C808E
X-Rspamd-Action: no action

Jakub Kicinski wrote:
> On Thu, 26 Feb 2026 10:46:53 -0800 Kiran Kella wrote:
> > This is achieved by propagating the psp_dev from the lower device
> > to the upper devices in the device stack via a netdevice notifier.
> > The lowest device owns the psp_dev pointer while the upper devices
> > just borrow the pointer. When the lower device is unlinked, the
> > borrowed pointer is cleared in the upper device.
> > Assumption being that psp_dev is set on the lowest device before
> > any upper devices are stacked on that lowest device.
> 
> As I mentioned in the other thread I'd like to establish some clear
> expectation on where psd propagates automatically and where it doesn't.
> I don't want to see a stream of patches that say "fix propagating PSP
> onto X upper". And conversely report saying "PSP got propagated but
> it doesn't actually work" (macvlan in bridge mode etc).
> 
> Hence my preference was to require the user who created the device
> to propagate PSP. Willem, WDYT?

Can you give a bit more detail what you have in mind?

An explicit user (netlink) API to associate a psp_dev with a
net_device?

