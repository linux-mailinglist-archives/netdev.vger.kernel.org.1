Return-Path: <netdev+bounces-256497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YM09CM+TgmnYWQMAu9opvQ
	(envelope-from <netdev+bounces-256497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 01:33:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E48AE007B
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 01:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71A9E30D00A0
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 00:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF06E1C84D0;
	Wed,  4 Feb 2026 00:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XDGvKoAQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ADA10E3
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770165186; cv=pass; b=jw/JzQ7Y3r1UvtaSyeiswpcRthPV+2heDFpKerK4ge/5i7ZF127g3EIT/gSazhuBMkEEbFighS7GIU3x90cHFJiueADpXWIzFoDxXu6FMnt7cS9QL8Ns1rmQbm03afjG+Hy23FDOhY3YZ+4x7n+RU6sztqWFurOWhBJ9JoJLnW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770165186; c=relaxed/simple;
	bh=6TyngAe3fosYTufDFdV5mU8dU2RoAXN6E5mjLfe80WY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DN2Mi8c4GfSLww6LCrrAz+xTWU0yxj3DnXqywX9IVv4JLppvRUs9UpHxv7psEkA5LjXCX7OPO1RT3ZKz0Dab0X0DdddfAwW3IroK3e/ci0JyXuJbCXRldpLWmInNj/KRPISLrcz1oYBeQmE+3hjuJH6oU19MSNUjthC7+On/5E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XDGvKoAQ; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-124b117776fso3965399c88.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 16:33:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770165184; cv=none;
        d=google.com; s=arc-20240605;
        b=EA5ad10zt68QQVc1hArAzTk4K2tzFiDKGw6WULagXrbWYk9UXe3P/Eala8ey3qoAgL
         kYqfnCc55ouYmx+PdjnUFycMZqMpPzePBb1rC8h5M17UaksiGD/n/jOO7OcHO+othum6
         4y6KwvJECouPpHzb4/+gfwgn8/RPrIIP87yiGWW19NZ8AVSWVAMZrqC3VTBUTwEQvjAy
         K/T4rtIK/T3UfnN/3NkB5fppCJFo6B+gJT/RtHQObBIKYX8YCH/tPde8qUX/RPM53fQZ
         +nI0uolQNvK1P2VZgLUBLqCreHR+cqpHPwvUaIdQI9eIBfREejcNy6y2GMq+lYtBmqHf
         3Knw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6TyngAe3fosYTufDFdV5mU8dU2RoAXN6E5mjLfe80WY=;
        fh=c4/SWlFPBjMqsW4bJuWQ77sklA/l0m3Fd8/Oh0SpmAA=;
        b=XRFQ9AyxUjDNc3vE6c+IaOOZDvz/TOdVk56CsSQxjXUKY1g0m9BmYwIViINHuQH/G4
         TLx6kHA5Q2OKPGPTLHYILAhx1UGNwgAsoQV3288s0kGnG9ycDhpfQpB0FbvhNM7bscJa
         KuaGIwV9K0e+H1Pyp2STzdHDpkBFOfEF5aBV13RgIFvNPyJHGpyillcmpLRBEZ34v/I/
         OESb9NGjzLU00/z4q6ox54OIYP7+Vklh9aqJKRx7Zc7wXk2kdq1jxyuc5Zreieaee25f
         hmAQ2cJJ59JvvxI/GWE24gzObOz2u+RbcymeySXbDnZ/9DuJKoBT7B6tcKe4NGG/SlHV
         m8Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770165184; x=1770769984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TyngAe3fosYTufDFdV5mU8dU2RoAXN6E5mjLfe80WY=;
        b=XDGvKoAQoKX082ccNwmbN+yHD4x/KnCflGWBDiMVhgunYSIXOy1c9cUMDgpReawtie
         4AZ3Tv/r0nmcnGKbKfTVRpiq7lK0n3FubxtWexY5t6sANNgx422rZy+aWdsCFTU3IEB9
         e7tytpoNq83wRk3OL/2rjdsm5RK9Nyq1NnNroyTAS0lw9Q5m3YXSzXE4kZkEu+CosnWn
         cmNEtswOxckG4wBXzq5XaaYuTuFCYN8HHoPJksblZKCdIrik2nRFhNg9rxFYHD9VDZs1
         d+wGSU8WwAVRGQwxVdEr/XnXlWya5QxhPPrwXlobQZ6UQbxu0GXRlMEcBnmsYounr1SQ
         VbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770165184; x=1770769984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6TyngAe3fosYTufDFdV5mU8dU2RoAXN6E5mjLfe80WY=;
        b=wvolv4P5kWT6dQkAD4rkO9s8+nuJC+b5a8Jw6qpSb6H9jaOOqq/fjpquHu3h2YTYek
         qXy+M5q4tm7tR0TN42PmGCGXflOW5B1vtUx06wXdwUe9pm8KAEi+H3muACM6aEcH3G9z
         7VZmYhcIhJoWx2FJEOaw3hjcUNy9vqKGpvWra68WCjVhuMNQzxzd+l9zvdzH1P869adu
         go9rdBjRHZZk13IU49vOAKucbneBaS1FXtNMMoJq3Ba4kzXdsu/eLO2MM1MgGb3wKIhK
         VAnN3TK9WiZ9UJm2vtTdy1b+k5VG+wdVuIGgpVOBTKBQc4Ijgk46ojv4Wj60QJKdRc1X
         5aZA==
X-Forwarded-Encrypted: i=1; AJvYcCV8Tzb3AQfFGCu2PUNr51/di9Cm51LZ/juA+Z6ipcm1wqhqJUOtjgdVohezrRISMg21IYrfFCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWE73XwPmOCa0gJvmWS71vE2wSli0sFlCwqhinfV2vM27eH4W6
	XK5OLdXOwWeIdUd6386m4PPlAcMjH2qG+sUBNQom7hQhB2RjsOh6QL1I/37u3xZDh5ktMGFs2B6
	KwNKcQ1xpAEDVn/J5lySMCZTncFfSVRR1JutNKGBg
X-Gm-Gg: AZuq6aJGc+F0V6UDacDyabuokOMyHuxuYTCEgtAK0oH2ABkRaOTwNCPtfruu/A+4Sa+
	C+tW2ttzeSfyTuwB/wQOsZsJ9ra8N/uhWB9piUjjq4/Z3DjnQD92wsWxW8ag1t2iKjnrpJAlG9X
	ACZ3AbS0hfwnNJeAoi3ruge8IRbUYUKCNuf/EofmiwlOWzQ3o4VTVRBqouTzhm664ouyri8lUm/
	WKirp4OAEALZ0jQXpjGZ+X1OfQEMjqtvsNEd4XCOGHXDF0AgI0nWA2pkt3KVyjZe9DdHbSkfdEd
	rgLgDpGHY93IkOB1tgDchoRDJ67UA9Xh/7aI+zRN1TLA0G5W03deOVREYg==
X-Received: by 2002:a05:7022:248d:b0:119:fb9c:4ebb with SMTP id
 a92af1059eb24-126f47ccaa8mr450887c88.30.1770165184256; Tue, 03 Feb 2026
 16:33:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203052210.3684125-1-edumazet@google.com> <20260203052210.3684125-4-edumazet@google.com>
In-Reply-To: <20260203052210.3684125-4-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 3 Feb 2026 16:32:53 -0800
X-Gm-Features: AZwV_QgWAJF4Ri9XOkj3b5FiWtDJmxKmUuggxuKL6gGC97fRe6r1FKxXfRk8MSc
Message-ID: <CAAVpQUDRmt6MpKk33uBd+TsED4Y32t4jyDNFCvh1d9s53C1kiA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 3/4] net: get rid of net/core/request_sock.c
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-256497-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7E48AE007B
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 9:22=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> After DCCP removal, this file was not needed any more.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

