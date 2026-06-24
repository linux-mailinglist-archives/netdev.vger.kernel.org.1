Return-Path: <netdev+bounces-301612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2s4CLzW0O2pebggAu9opvQ
	(envelope-from <netdev+bounces-301612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 12:40:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 583B76BD6FD
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 12:40:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=DS3UbwvU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301612-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301612-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 307BF3028C9E
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 10:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F82129D265;
	Wed, 24 Jun 2026 10:40:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18243248F72
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 10:40:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782297612; cv=none; b=BXoF20T9Yasxq7ctDK0lHf1SPKZ1L7ZxLCxrE70TWqrf3ug9bh1DiF4WIQWGyDTrlioUSSWdq7coyYC+TQLBB/qHEDlN2kufQ7oxTGRG10gMCU1kfeNBx9Y2YD56DY3jTvAtpHiOcgmaWl8oB9V37WSXqxSAj40cx1fZKK7A29A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782297612; c=relaxed/simple;
	bh=SzwY0ArSkepQcN7OqNhWKPW3eLo9VWe8c4Ja3adS3cU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hgzolYfjob2Wm24zAzAxOukszckft4DsjdnUkea6nHjGDwTayulqiBrLwCyc/VZW8QVbfdub4ObL0ZDyWG41d/asrWbkPjCuoNOQgYet73qeskxvO2sZfLzdXJ9rPmDC3sBpWdIVXjV6vCkD4hH4ZXqzEpytHdNwW1Wr9trc1OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DS3UbwvU; arc=none smtp.client-ip=209.85.218.47
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bed19623d6eso111888166b.1
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 03:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782297609; x=1782902409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzwY0ArSkepQcN7OqNhWKPW3eLo9VWe8c4Ja3adS3cU=;
        b=DS3UbwvUuClnt0f0ojHK2TcomlHSFCkVepvSFhJLCQx+7xeFSVcCyv6KHqasAdI5Sz
         9sDxDWWZGHvn9gAGBOcvaGcUiwpWxybjIo5wySO3hWzUUIWgG7m8VOr4vVOKcNEyRi+R
         8RiZ0lX3FmsVZk1ZdZ4AuO0bVWitpK34vvxg5clhJQqn5/7+h4D6pzduBjx6J9SAYsQ7
         o+9nstQVX4ZIqlzce78UYJSpOQ/CnQ+Ogu38kvXQQWMtPPcr8aCRx7uWlJbMx/3jez8b
         Tk8Z8EHPM98kVcfb5WC+jSAAXh0SzToeKePiLeX2mMgMMyHSD7o/BI/T3ULMI6hUyn6z
         pP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782297609; x=1782902409;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzwY0ArSkepQcN7OqNhWKPW3eLo9VWe8c4Ja3adS3cU=;
        b=iJGqjA/yFBnS8CejMS3Kb70WeS4zT9V06It/naQ2lyiwZ2E/Sp1d2l4AJit6ZP1/75
         Im8Ab5MyU4MrCXJU7vRILZ/uC4fHbd0Mj/8BqhRp+UxozXg/y2htJF6q/njJgXPIW4wT
         CqdZf6EuBl0tiuC1IwJ0jir25uDELG4EVmxCwOKqeTaKOAo2PTJwUIGKizN4nbAnEPen
         5tdJzdZQzIU1Dcy6f6iHhS4JO4e9mJchP5hPK+Hdt2E0W3gCF/rl0UuTzhMs+Y68GFVk
         +AZPtKh0xHkJp8/fBn8qaiSMi+XuU68kOSWOunAmigT9WpdNhCbWxdFb3QGXDkuX75Mo
         v8Cw==
X-Forwarded-Encrypted: i=1; AFNElJ9VbuTuiDnSQCobR6pvyW33yxXJaFzuZJESL9eA8v9eQktxns5HQvBW2FGbQj4Pw4+SZm2zTXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw60GbCBSBLQG+6rq9dgoKE2vhtTb5ua6tdYT9V1RrdX3xmS6d/
	ag2hdKJHqFkumC+ww/JksNMG5lAB/wYMqUBnSAGh2SM2o6/lQ6FfCaIumi314iFPns8=
X-Gm-Gg: AfdE7cn0rkj53hEDG9nV3FVXB4NJ6+2BBZybEtvjkroVGxbns+/MUI39CVzVA4TO5+Q
	L/0EvX2eJsXsE3mKN6koOrP+YGQATCDqvpOJnVbfJkhun5X/Q5iTPzDdhQV/SDOiSAdEzVjsgxb
	EohQfUcEEjJ3gylM9I9QelLI2xemyDAu3HmcuMqyapkOiGCsq1roLF5cQzgWFZsiLEKQY8qlCe0
	AT1Nmm4t20gI7I4TEwOeE2flejGC44aEj6ehv4pSnhpnElr4oSsD8O+2q47sX4ZgX1lSK+GgUna
	foqZ6xBFZ66fISmGjZi1n9JVaLEfkT0YOr8noJuz1E/sWs4+M74P1X9N9DcNA6fj8vesqYRHP7L
	1eCYADDFGzJM5zeLbMD6gIZmwmU+8qFzgtuSvQoJZx6nCnRx34ygep7xfZEoDXUoIEJaCfcQuye
	F+G9Lzbry16oT8jEc=
X-Received: by 2002:a17:906:c10b:b0:c05:b9db:68cc with SMTP id a640c23a62f3a-c107a353073mr371151966b.0.1782297609382;
        Wed, 24 Jun 2026 03:40:09 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e498807sm621703466b.1.2026.06.24.03.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 03:40:08 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>,  Kuniyuki Iwashima
 <kuniyu@google.com>,  bpf <bpf@vger.kernel.org>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Jiayuan Chen <jiayuan.chen@linux.dev>,  John Fastabend
 <john.fastabend@gmail.com>,  Network Development <netdev@vger.kernel.org>,
  kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code
 behind CONFIG_NET_SOCK_MSG
In-Reply-To: <CAADnVQKr1XisnigNsBw7CsXxY3Xn5KOGtX_YDdXmNMZyJy4_Cw@mail.gmail.com>
	(Alexei Starovoitov's message of "Tue, 23 Jun 2026 14:26:06 -0700")
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
	<CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
	<87v7b9ysep.fsf@cloudflare.com>
	<CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
	<CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com>
	<87mrwlyqg4.fsf@cloudflare.com>
	<CAMB2axMVhJJpP5HZtDFyQLLbKoRxhW08rj1zGRtWtgDkfYaVNA@mail.gmail.com>
	<878q85yoy5.fsf@cloudflare.com>
	<CAADnVQKr1XisnigNsBw7CsXxY3Xn5KOGtX_YDdXmNMZyJy4_Cw@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Wed, 24 Jun 2026 12:40:08 +0200
Message-ID: <8733ycz0fr.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,cloudflare.com];
	TAGGED_FROM(0.00)[bounces-301612-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexei.starovoitov@gmail.com,m:ameryhung@gmail.com,m:kuniyu@google.com,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:kuba@kernel.org,m:jiayuan.chen@linux.dev,m:john.fastabend@gmail.com,m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:alexeistarovoitov@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,cloudflare.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 583B76BD6FD

On Tue, Jun 23, 2026 at 02:26 PM -07, Alexei Starovoitov wrote:
> On Tue, Jun 23, 2026 at 1:36=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:
>>
>> This is a follow up from discussions at BPF summit with Alexei & John.
>
> Not quite. The discussion was to disable pieces of sockmap
> that are causing trouble.
> Not to move them under config knobs, but disable them.

I really don't see how we can remove a feature that has users.
I guess we will just have to weather out the bug wave.

