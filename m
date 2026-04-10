Return-Path: <netdev+bounces-277256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIUuNCuR2GmNfQgAu9opvQ
	(envelope-from <netdev+bounces-277256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:56:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F473D27DD
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C27F53015A74
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1AD339B3D;
	Fri, 10 Apr 2026 05:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kRois+do"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7A430FC23
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 05:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775800614; cv=pass; b=qrW0OdwV/mjFKohpROnl5V6xJDVPMEMXqGa0wGaEg/oc5FjTuepqfkVomDuJIQtlJ5F9iT3q3aaGvzJH3+iUz7QIS27V7KU48q9tHGvFgniApWBum5V6wsxPLHQvOFmD41/8xYgOYaW1gtcbNhMNWH8iv9v65OzXLYsmEPFWEdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775800614; c=relaxed/simple;
	bh=N8ZQGQSvGQrjEPMf9J0UpDwts2ljGIdnanhBZ8Vl0UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8xA/kmEmupSqdIHyrFDDT0ywhj2Igi6onqpLIxbxrQ1nTZpn04KFMKVn5vFJd8lZpHrNh0ph8BvC9+lp5C1nlPSoSvEeYa+xAYJpuByWxme7HOuA1qFVmmxXKxlT8zpzDOuZeLCSWF5VjXmIhiGdc7rejXzkXC5IHykUEx6qgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kRois+do; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1273349c56bso2296087c88.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 22:56:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775800612; cv=none;
        d=google.com; s=arc-20240605;
        b=JQtk9RKCOZkeJ8Casb8exERgxGf21SKMirrEfeB2z4jvURuFvGbQQJMuJoyVLJ+kCk
         KWnNyKkot3LRCH2WtpmLye2gvUePYLYl+TzvqqnqFnaBxdM39LWWxoDouL6EyxTDo+Aq
         DKd/hDtNR8zAxoacItTb2s+CmfIPtuAYBXmqvCLHgpoxHf4afGSJdBpaDaLDPx/Lv4f7
         VaH8OH0a7gtHXvNE24Ji+tA/78lnCVQclEh8/PKhsIFLR/mZ9ezn+x+EUv3wX24Ttj9w
         iiwEVyyO4aZBTOCdl2vVtI7MJg0kCyqoSUyNk57sIheml46VkvDd5Ll9T9z0O7EOaPYW
         FXrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N8ZQGQSvGQrjEPMf9J0UpDwts2ljGIdnanhBZ8Vl0UY=;
        fh=S1iXVh4mXDCLKli4eH7hxH2x9X/qqBTbSpcQcWXkQtQ=;
        b=Ql12XY9jCr5DUMo7ny7Orb5fQgVY/PteRkwQwMXWdLvJ1LbB9o1Pw3Z1FPF9hJNLnJ
         9Q4Mg1gajS6/HQn9ajgIRIDpL66HEGwPt31WVqXC95o6W1DZtnqOt0vI3aAdhLD+VsL2
         POWFH8S0TdXOGLyVZQ2gMe6hr65zwtaq0EJAz1W8o+Z1hoX4U89q8Lyb9KlAJWmb5Z67
         lEXnxIk30n9DyiVk2H7bfd9FdbCurbSPId4gz8+3sgtvE/z8Hki+FahbPVMUA1ip1vfK
         0z7qXzHsT5RTWf288AttHEqUK+zDANQ1ktZ70TmiMkK019yxhJaCIJckY+9HHNK8fVuP
         hkyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775800612; x=1776405412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8ZQGQSvGQrjEPMf9J0UpDwts2ljGIdnanhBZ8Vl0UY=;
        b=kRois+dow13h6grNzjkNw0OkGtnJdKvLWppqu9FUpJvQlvnQG0lvl4Da2wf1lH+SyW
         8FFOrEjaXmpBJECNW2MbnEmGjL3fJHAr6RZ1BRTLD6l5MJ9E7JLDMpyKxpq0puVwhFGD
         Typ9AEgsc4kLkTWyEJJr4mqVil8hyaVU9nRnoQh5reiUFASpCzehRB2UhWtG7DkqrM98
         G0l4skZ6edxchbkmm/m9qVi5ir/hBd2uYeHnyF+ed/VZ90qWKWQCUHxnMiFh30s23TFd
         ibceQnNwerTDU6waDZV3Jly25BpMP3yKg8JJklyxctuwDKqzEWvIB3udWy8mFzWc0/4Y
         gUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775800612; x=1776405412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N8ZQGQSvGQrjEPMf9J0UpDwts2ljGIdnanhBZ8Vl0UY=;
        b=VeerILi6u/nqRbcbIAc/kAAI/Pvf5UJmYqtUWoLZB9rzgIA5Dx3ZWwrdsW5A2aaNuW
         gu8EGiO88tWgHWr3ILEmJgak7rgwvmzrwZ1fEt1M2dAH3ASEjpIYXciON/W6S4neH+E3
         8FHccNxEw0szJW7TT2wotBNgfkzsYs8yq9EzXcJwk7FSmA9uIEB3DAr1K6Xkbqx63hL/
         p6e2EDg8fOm+GIB3u/keB2NB+WKFwLh4ve0DmWNRJccvGP49Yg8Js2PP9BLwi3ijbFqC
         LqHkXDN1iJd5cr0duymrzRkqFOLngMnQaQufsA/4N1NtXTqPYBP17wAdvDux2TlnZRvV
         hKfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAm7KWWCI5AaU+5OGKXViG/pX/5cVX6EmQNKvoVt8M+ezVh+5c+MtbflGWYEh4VYp5ETvxZmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRAdHmKTsb1WsqKciUuPKtCqgcvJ4vIUSSQoWkc4vMAuZ8NmHr
	2uxhU22NFZl6TkAYJrom/nhm74DbBhKHWDLr3iBHhwwc9pspYAb4w3q6RtyWliNZbvr6EEKoHWH
	+ZYXDTSh6if0usXahOHqJxAZpxflvBN4hxDZU4usd
X-Gm-Gg: AeBDieudpucKacwgqfV8BzHieeCTBkc0jXxQ9DJD40BbYbjRzro3unfdnQ2yLRwqIr3
	F8I7IaTzrEgHTRWXXUMo6HUASI8OkE5L6Dgr33iiBWMzsTTQ3sg/bQmsYgMhUh9zqJ7RQbnYdvJ
	wsUSAFHaxEFP/ir1kNzoaXLrGfDYJNHPI+4kU3p+nxqcgeRiIGjOKNxdAygiSjzpKcCKdfCg/Yo
	RNhefjd23qUXFzp3w4yf+uYuTp/WyyNfV2m6YFG3YTjtEyR8C4ORnVYevlZjsi9ky93drMwdjP9
	YRGkoX/IggJosA/DYv3m5AI7r+T994PssVyvY7UV/Zb0OCgpsqrKyffmIJyikay2qk3GKB9kYWw
	QvgfuUE8=
X-Received: by 2002:a05:7022:6ba0:b0:128:e693:b61c with SMTP id
 a92af1059eb24-12c34f06604mr901559c88.27.1775800611850; Thu, 09 Apr 2026
 22:56:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409-teaming-driver-internal-v7-0-f47e7589685d@google.com> <20260409-teaming-driver-internal-v7-3-f47e7589685d@google.com>
In-Reply-To: <20260409-teaming-driver-internal-v7-3-f47e7589685d@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 9 Apr 2026 22:56:40 -0700
X-Gm-Features: AQROBzADgclTMrnP8UXh9s8Qc1opwDYT_nhwmQ7HDtQpG_4hSS_Z9EkpQPy7DBI
Message-ID: <CAAVpQUAUtPGNLHpGG9f4sOq9BsgYr4j4xMYBA3FRaCR6BPGz=A@mail.gmail.com>
Subject: Re: [PATCH net-next v7 03/10] net: team: Rename port_disabled team
 mode op to port_tx_disabled
To: Marc Harvey <marcharvey@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277256-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 45F473D27DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 7:59=E2=80=AFPM Marc Harvey <marcharvey@google.com> =
wrote:
>
> This team mode op is only used by the load balance mode, and it only
> uses it in the tx path.
>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Marc Harvey <marcharvey@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

