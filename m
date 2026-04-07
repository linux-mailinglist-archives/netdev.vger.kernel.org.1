Return-Path: <netdev+bounces-276039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAB4B14g1Wnr0wcAu9opvQ
	(envelope-from <netdev+bounces-276039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:18:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 987CA3B0CF5
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCEB9302EEA8
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F84635F8C9;
	Tue,  7 Apr 2026 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bRmp+NzE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B4735DA67
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574889; cv=pass; b=NMWefnKdkGxeFuNv26OyWxsKAt8pxPzjSiys0/ewppjxbbu/HouRXHknl9YMSoJc+D+7m+IiPmI72lrf6JVYGRIFm4L+w2TRZFX2ykrtbNVbUrVKKJ9NZXri+SiSBpPHhLPuBx5UzIEI0+CjlIUdQZyyvXydFPMblHePBhKwVyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574889; c=relaxed/simple;
	bh=SVuB5w4S9g3i2LJVwtkxp4MFM2EaZ8x7Kf0aj1pairU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZVkS6punH46FUfKcYkfiQQKTJPB3Fv4VaaWyfsrmWVVcB1VcAbc2NPAbixUewB8GSguQy4s8GlxqPhzuXH2Y/36Ja2dJ/O9/84AVWkq9QfrHEaOg8nJ2qEf5qBpFgec5FCCGoR32U1V9WCdClGMzqd7hUGWu+3PW+mzkXZO0lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bRmp+NzE; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-604f327bafcso1869349137.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 08:14:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775574887; cv=none;
        d=google.com; s=arc-20240605;
        b=V5eIwBTQN5qM8yG9JzR3sBe/Fer+XeXX/9WonYodlTNck1SEE8dB8v2/6icnEXuVWG
         oO2eeilm1Q4A3vzen96YeqeVMZ7r3axA2J+9UQLSWShio9im8d7cD4Myp8wNeumxxL1g
         23L+mGTUOiFb/VoledzhdXaKd7OjuAXJ/PUcdH5CR8NPC8/0Grb+wcj4uJIzqoGp5I61
         nsc5U47QwWphafI2vaQOUAx1j4IyqgeLHIZfxx7XyU6KpQamrzDp0D+XaLVTfqkdvZEH
         a9XljGghswIh7CpV0L49w4QNz5KA7Gjdq9ZBAuCp+dY6iAoxXPu0mQMBGSe0d1E7rjiI
         Pqgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SVuB5w4S9g3i2LJVwtkxp4MFM2EaZ8x7Kf0aj1pairU=;
        fh=n3C+kedGPRVBqH/oNaNHiKZcWrODE0xalyaFkdYYlBY=;
        b=DecIw9sMZFsn7mE5qW6fa2VUi4kqxPSyRHD5ykC5wyENmIkFHVE8bVt5lK9krHCZZo
         uPvQAO2MaZaG9snSmjiQ9SdmrZvWLmwxbf9XB4MiARd2lIkb6KKLkDtBRt9ybMMvSXcU
         PqinOFyh6Q26g4Ru3ZOpBJ+npAqM7TVPalTgf2sIBqix5K3dbYOw+j5ffJfbVNnJ4pn5
         S69dZ3fjTkvFUem928n4+MwzToMW3ATdOaetLYdpggblIlizp0lIRS5/bgoYvZRdjpdA
         jRDlIh+489FIPGvjqkw22KVnbymNSvm9HGv1MzQmguwCKd+afRw7njWhENonSAzbzH3v
         7HnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775574887; x=1776179687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVuB5w4S9g3i2LJVwtkxp4MFM2EaZ8x7Kf0aj1pairU=;
        b=bRmp+NzEmiSpEU3/+BkVW49B+fOD00XhLtwdmd5ailgWxEW5PGQ2rW08zarHXY0y+Y
         Zplec1TcjY1Rhy37CPctH0D5FGvPX1N8P6tXvFr8TdpxKegiKiynq3mEpgb8WdwRug3T
         UeyLAnn/I0N2gUfWQJQ7j6WAfIh6QJSLcQtwRmxgGDmuxd3rolh+yebjZuH95SIReZ6j
         +pOKWqLbESKoUWfVnxZf6ypLf+RyKMvD6iAPH4lJXkojDb3tk1gyZ9alVYsfbZZpJ0Lj
         7wZXHS8wDlCYzuJk3EcQD9tV/mAZuOLmGvrvII0XgQqnMmup5/cYSh8luM+6dIaK8smL
         34XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775574887; x=1776179687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SVuB5w4S9g3i2LJVwtkxp4MFM2EaZ8x7Kf0aj1pairU=;
        b=CAPwhulL8CdlsSZJeILWr2rh/dSxfKQcqnz4CDBBg7tFoV237N2RGvL85Ra2cydkfz
         xAl2vyfij1mPZLgwtWh+FjwMD4ECpkKSjZGLgrTqDJq8RYr3a5thJnnW61Xa7SrxPurh
         7HTu2bjBnhEV21oqpHl2Yki4wzQ91MALT0dqM+D7eCrQssIg52wAa9trVSeVZZxgQiQX
         pMtmmAWjpXzYn71j8OgS8QTaeNIAL6zgGi1k9dhjSZat1TpGqKaLBFXXZ+6JleVTnIwn
         u5vQT8/v/mbSSDwcS60UaoRSzyE3cfoDDZkDW0m1zC3XSrs2xvrARAWRpHnIAAiVWTKL
         nxYg==
X-Forwarded-Encrypted: i=1; AJvYcCVYyastG/GZtydyWAG5V3NEyoQRqKuEP9l11mw3gyCnB0cjbRJtmhhf53OZA5EWseqrpRmA4NY=@vger.kernel.org
X-Gm-Message-State: AOJu0YysITYdzrGr8iUTJX6JHPd4FumfBHeVArLo11BLnN0TJocFheY6
	jWU5WJBSjUPWd/vJE1Cs/iFvY9hIY8J3exib40xivjA1/+hletTTgFpaKtJAoPTw9tDWerVqweJ
	oDfkm+cM3KMYJnW3P9+f4z498lRc4rhqmoLBho3uj
X-Gm-Gg: AeBDievkpHtbyMwFf5trzrERHOVSApQ4aaumIUMPwpXGKh2a3g4B+bt2OxEs70J/srN
	+W1wqmKvMjl/xY6hQHc62C8QWtH9tqpG3BfuebvdG5Ayu+ciotCfHVGtB+D3Br+OGkrhq16CxQn
	3q6OwnIb6uKemVjEDuDK29FLIy5IdDNgBXyve+EwI7ttVxlBhD5eJI01Do8krzICc/zyM3cPv+w
	UE/ltZMyI4E9QJqkRCw463z5OXeCFxGTEo+YEzHLcN8pUr8XQ29k/rYP6l7fOVM5MgYizK0+tlb
	ke6fUydQhX/o/FwR5g==
X-Received: by 2002:a05:6102:8555:20b0:607:97a9:e3e9 with SMTP id
 ada2fe7eead31-60797a9e882mr169043137.23.1775574886413; Tue, 07 Apr 2026
 08:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407150758.5889-1-devnexen@gmail.com>
In-Reply-To: <20260407150758.5889-1-devnexen@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 Apr 2026 08:14:35 -0700
X-Gm-Features: AQROBzDVHNhmKDoXWfA937vlS7i5gl0nT_gzqkVTXTlHZU7d9eadHvamrDIvMqU
Message-ID: <CANn89iLweeu08XgFL345k1NVx56=u6RV_GqnfG2ArvLjUwktrA@mail.gmail.com>
Subject: Re: [PATCH v4 net-next] net: use get_random_u{16,32,64}() where appropriate
To: David Carlier <devnexen@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Aaron Conole <aconole@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Jon Maloy <jmaloy@redhat.com>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	mptcp@lists.linux.dev, dev@openvswitch.org, linux-sctp@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276039-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,lunn.ch,gmail.com,sipsolutions.net,ovn.org,vger.kernel.org,lists.linux.dev,openvswitch.org,lists.sourceforge.net];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 987CA3B0CF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 8:08=E2=80=AFAM David Carlier <devnexen@gmail.com> w=
rote:
>
> Use the typed random integer helpers instead of
> get_random_bytes() when filling a single integer variable.
> The helpers return the value directly, require no pointer
> or size argument, and better express intent.
>
> Skipped sites writing into __be16 (netdevsim) and __le64
> (ceph) fields where a direct assignment would trigger
> sparse endianness warnings.
>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

