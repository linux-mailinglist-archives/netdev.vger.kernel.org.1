Return-Path: <netdev+bounces-275316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QK/DGpFq0Gnf7QYAu9opvQ
	(envelope-from <netdev+bounces-275316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 03:34:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B05239979A
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 03:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 945BD303D2C5
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 01:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B13277026;
	Sat,  4 Apr 2026 01:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KMMPhGss"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F2923EABA
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 01:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775266442; cv=pass; b=ovWSLQud8a3inYvognsPE2LMLIvAr5eO8rAlqeJgy1DTKDUxxOgl54P6kHvQjcAdi1C3XiHdJp+WLmxOR2Csch+GPmpxzMT8H3Q2i8oBk1+Sf6ZfWrN63IztiAvW3nB8LVhJ6A6me2g7Y/vX9q65o+PJPq54kUcxCo5cI0P5jNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775266442; c=relaxed/simple;
	bh=tACdfuNvuecVdLWS0HJWivNtfxvEwyjMHCX4AbXRuBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdLTb6RTaUm/jFKb0BarbsH7cm/2/EhlZc6p1jar4pROISrQVshrTW1IlJ0KxqCeeOEX+ksgOgXLnuJVMgthcGWp0o2FJExMtUGKxQSPeI1I1tWv0zUYNEg9WEtHIShsOWfK9SIwwia1ITst+iK0rF12mjcgFeSB5oNS7GrFEyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KMMPhGss; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so15915a12.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 18:34:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775266440; cv=none;
        d=google.com; s=arc-20240605;
        b=XiUmuaPDVhR52hQhgHnQaM3SHXnkhjeTwPiztlBC58Du/VFfisNCGZc/CniV6/7GhT
         a4vcxmJEXfl08YR7EqruEOrTo4Ur7+Jk6uMlsbeCWlXxhL8lJpF5Jpo7AEGsy6rzupJl
         6/eSCpC247PIm8n0DpTb5cPgNLbqQaP27BKb2/pqeUnVVkwzHDRAwZ1DjznDpUQhTHOm
         56LQPB3U/qCz6VHqjJle7Got7N0IMpVu2nysDBclq5VflkZmd4koXFdnFHDn53dTTY1e
         CAkf4rbdrBtHQyQgP4PXUkMeYylCqSj+R0Xz+fvGQX1Ob5gzW975DXdLCgrXMtJ+nTC2
         ZrTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tACdfuNvuecVdLWS0HJWivNtfxvEwyjMHCX4AbXRuBo=;
        fh=hvImEU6WfPgLeFt1bONZx1Kwtd1ZmGGcW9BPggeomE4=;
        b=atdwrSZZavcJ3hzpeYxk6+qdtCwjpbCdjrFk0J8Zsmw6aP6AaGmxZHA9+f6r386TM9
         WgO2CdDHMv0oEzPRoYO3AIRUucOd2PNw5AaWsoB0L80gsyWCy97tvRpI8aarzn+f0B4X
         Yc2paHWkSnk7rDZtsWSnO/aUe33CIVczReLK4J3cXsGvCBTXYfiU496uc8ynpj9uoTux
         oOC4Vp7xAT3DmVExL5NUmVFVurk+k40bO0YSxpJy9M4SQo0qWUY8jsxtUu9HmoOs6cTO
         2V4O5RJEx+Zvax2ITYxdFkWWxROP03LYe5yM0cK4vy82qfRQSQ7YUY71dCHCgI0NSLjb
         9IFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775266440; x=1775871240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tACdfuNvuecVdLWS0HJWivNtfxvEwyjMHCX4AbXRuBo=;
        b=KMMPhGss9evwWTfp0uVDdTvVCAW8QA2DVFc0U65NWgxCMwNinxzMqu9UTa7DHpNpiz
         zd8WtzodUw4A8ppaS+1w+dcVgFxFswO6Vqftp2uobSgDGrlp3W/vT/aFPp/r2RmjE1pc
         s8RE0bT79R5TXcfxZw6JNPbHk3fRfnT0hOwDbqwGTVJ0zJnEgGQYRl9T+vOWXNKnDrDr
         +5YD9sxJsIO6KATqkk7XsE+7uWbmwDAZbZlfmL6le9Styyww2XraYuDaVdL93DvHxW9Q
         HLgZhtP9VOVBHK8qlP/DT+yrQyLji9PA1UcXXss7K6c+flZuV4HZ4+VkZslIVN1T/wg1
         hzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775266440; x=1775871240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tACdfuNvuecVdLWS0HJWivNtfxvEwyjMHCX4AbXRuBo=;
        b=g8rLZSeqPGXkfa5+MBenWjWo/wB/xU/sq/NYVFhU/XCjJbU6Hn/MaaxiTRTZAAbvz0
         UR1v4SO4BN2d0U0mm3RvjZKM30AgRL1Cw1X3+ymz7SezGyzdRidiuTCKnx4qVcd4Vp2r
         ZCQ2shLoWvCG/h+M+Js/obLRatFVl8BB1o0fB5JQRDklifTx2Y+62JxHGUSQJGR3d847
         /fUv+q9e7f3ehEqtxHBPZB03PJCHHzZwAvgJUHj11r9ROx00Waiz9ZpeBeJICAVtL38g
         aTF7khu2P+3Ky6tuBiX5QBGq0Qa3Pgu2K5lMk8bNqGy7ZRsXabt1k5eogv7MfYcMnGbB
         wpOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyZuM/ACqETwUt2t6md4dTiYo8vlg/YWBqHs+HXSZb4MiXinhcbq3+Oy368N4B6NIR2M3YsRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygomEJ3lF35QGSJrut6luFFOqM7RvdT0wkYL8YEX4ZSb+0T5wN
	eGTnE+MKfYb6XwwFHOCtVYjyKLMRujjqkPuid8daKX5WKkTst4EaPEhP7OmnWY7Ou07IymVFxRW
	mQLeMuP2KVAUeHRm6EkuIR9VAx+YY5D3xjDmr5or/
X-Gm-Gg: AeBDieskoaLoiL2WUXAnEBxE4T5Pd3LTXjfQfVTCS3+aHsXsvDgWGe1YDCZjl8Tw5aG
	Z0W7pXsKIpCs3Ev9CX1bqLG3xRk+ERRzW1DuTVsSeGPGAMshtw3Gi/92YG4BeztpzQypK/sUC/S
	wgiPHUSE+F6x513M3q8T0VXp9p5YsvLKzm5JfXmjpxegT1DR/F9+d05H3nUDtswFw+/hCHWnpjb
	QpGX3Prmg1TKL15tDPqneb0zsGSzX5hIP+CV2RUYiDUO4O15+kP6+1IF4V4ejvvioh1hbAhzHCX
	bECnJRTCy2BWZDjNDo5eUpFXTBhY20p2A6Xbow0=
X-Received: by 2002:a05:6402:5345:10b0:66b:eb28:2779 with SMTP id
 4fb4d7f45d1cf-66e415a0e54mr43493a12.12.1775266439410; Fri, 03 Apr 2026
 18:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403-teaming-driver-internal-v4-0-d3032f33ca25@google.com> <20260403123039.77c80266@kernel.org>
In-Reply-To: <20260403123039.77c80266@kernel.org>
From: Marc Harvey <marcharvey@google.com>
Date: Fri, 3 Apr 2026 18:33:48 -0700
X-Gm-Features: AQROBzCcDmh9vMwsBnfFw6XOXuPHROjL8aDLdAW0gvpf0c5E0VDu0J3cAY2ph0Y
Message-ID: <CANkEMgmh4_QtDum0brYNZOxJxzjeZpsxr8PMMKoKVBDawA6GXw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 00/10] Decouple receive and transmit
 enablement in team driver
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275316-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0B05239979A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 12:30=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> The test seems flaky, we hit this twice in the last 24h:

Hmm it waits for the active port to change before checking the packet
counts, but that appears insufficient. I will make it wait for the
newly inactive link to stop receiving traffic, using a generous
polling timeout, which should fix this race condition.

> What's even worse the retry of the test then fails like this:

When starting up teamd, it seems to check for a pid file, which
persists after using sigkill on the previous test run. So if we don't
kill teamd gracefully, then this file must be deleted manually. It's
strange that it didn't cause any problems on my end, but I can fix it
in the next iteration.

