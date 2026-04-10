Return-Path: <netdev+bounces-277257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI03BiKU2GkgfggAu9opvQ
	(envelope-from <netdev+bounces-277257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:09:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFDC3D28A5
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A110F300C018
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 06:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF4633C1B7;
	Fri, 10 Apr 2026 06:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTLN4xCT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FA1257827
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 06:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775801373; cv=pass; b=KeeuYtncm3ebLTz5wngRihwnJN5e8Ur4+4Thd+d67QG7JRPUANeaMrv8qnGZ9Uq1WGVwwFDapf4rs28O8Z9pCvgqVIFbOhK1LjkuwVq0GAdnbHBGlZLQAV9rLJ3Zh553TF/PlCf06MGIIE9tQB7vbxhvpp/VMmexmLvxn2+6qNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775801373; c=relaxed/simple;
	bh=k/9wdMzrz0If7hXNPFdNFIODdaToDO3f+Lk8X4NPo9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/RJCaayhLn56+QmXAuXbW5dapSilG9JqQbNdQCA+dWwKJuRZOwV/nldFcOt0ZRZpCO0jY5NQ33IXPwsA2Q04fgR+W1N7HN0jLuc/lGB1oG9PcvNqlfUAu2ubZxojYjwsQJUETRKNfXzs+I9AbbjmLlXHpEfmyBhxyNxh6E6T7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dTLN4xCT; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c2575ff49so1834163c88.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 23:09:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775801371; cv=none;
        d=google.com; s=arc-20240605;
        b=VjrqrhQfEC6xpYPBI0EVx4OPoVqQEbupZGtQrQpLfX4uXGuJnP9GAaxnTCTdQ8kIUS
         XPFMZqSfvXE/P0KEO6XPL8cpkMqISbUJq4QkvpUdbr685wPMWWHM1T2JOB65YJPULiem
         9sbdN8JssaPGFWwQOOqBdV06N9zPEXCnDW37zjPO2YHM4PUBEqIOwCZKVg7CGilDTiG6
         U2UhYhZ4tmkrOypIPmZzmJD2T31msXkmTRcSW5XHQaurHw0zYC6vYSpuv06ipqc02HI6
         McAkx5OIkDJP1sQAuP3QH8HDgkIJtJPC9i1SlaBmzwAezd5kmD9/7PoYU8ZxoRkq50p0
         FxKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k/9wdMzrz0If7hXNPFdNFIODdaToDO3f+Lk8X4NPo9U=;
        fh=FcOMuu42SL+XPyaOpHdGqTPXaAwWUFgeeigcf0Tq5Pg=;
        b=KjEjPdR36Re+78xvAGGAOC4Yo8fIuLnaOkgt2qbxhF+iO3QOsO2tDJtbTxmzOPcVgz
         VE0e2Lfe0GlY0KsLt86pn97xYiIhq3ExNKzQ8UXwgozdb7DdlMFt35QAOVWCW4+aVqCm
         ykoT/fW/fNsqfNvRgnF9MDokVj56TmMNdCdpL2DjwN5t4Fco0bL2XlApo9yCAg0TN321
         7O5HxskX/cuS6rhJ7YGti5PNNTY1r/7YkyQei9UN1yrWBppx5esoMl2ceACzE5KVG/V7
         FZ+aLuM3s7fWLj534w0InA0Cn/nU/QoG7y9JHPy2aidp5rU0UH5/yU3hqF49/SbyTzkq
         e5bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775801371; x=1776406171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/9wdMzrz0If7hXNPFdNFIODdaToDO3f+Lk8X4NPo9U=;
        b=dTLN4xCTmR7i5xn3nRBJ/JHi85jDab5Fa533fVEyab845DrTaiaqsNOdY8dEAia36l
         dyNVW5tSHl17rSSwK4Tz7EzqFfuIBCdrmSnFhK2J7Xi7mfr7BVE1fLN3c2+vzUBrAamt
         ZgLGcXjYoRFQAbw8hlFD7WzTBK7J4W2bgeVJ0SyMz3808BG2PRD6AGNIdgrCbkZyHnzc
         UY4KmedTRq/LuiQ+PMNHorAI1zbncgKx2JO0/wmtPimtyDe1tHuR7Xo+KJ2uo6cL/AA9
         B6Rzd/DQKU+1zX1mqdgu7q7BT8dVxdkuKy+FT6K7Ed5jcxu1dyGqECly/hb3a4dNcpvQ
         5G2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775801371; x=1776406171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k/9wdMzrz0If7hXNPFdNFIODdaToDO3f+Lk8X4NPo9U=;
        b=kU4+1S0g/WnwVQQ09gMPhgC/tU8qHIq1XYXW41S1c64bRGvMImtR0K9mk9Tni/b/BQ
         oU9IvXHyhM/lLku55KxAT40JLOThE+RxmHFcsb+X4fnRC4jFml/Ci85oN826ex1JjTKG
         I3fYDW8Ks6La15GmLNzDqPp+ffd0fL4kZrzTwRjfbnEDz/EnGM/3yp8JJd99KwKJD7Yp
         uzqI3BfOv6h3pxU1pHUOYbObnci6TsMkKRhpzs55V3GwBNzdq9VSfFdPgGzlBSm/bmc7
         wnCPUyHROPubH+56EXBXv8uZnyw+eTh+Vrt6eVZfFuHzaMxybOJ7RilyxBMTTVijP451
         zpEw==
X-Forwarded-Encrypted: i=1; AJvYcCVFX6Ayhrt9BJxc3N6vpyRoRUqFtkE20PFY8XQbHU2eXw1s8eFu09vD2eMpYDexQiEjWpGgILk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMTVkHPL3eWV61ssXQi46aMdOY/L9hWZ3N/laL+M18ihdymvK3
	AASq7EGuaypXKdcXrk6Itkapy9Jat+++bfTAUBlHcfBBn6AtndbiLHmTuldabrlBK/iwgIjRFKg
	O8hLGvo/qG4Acjmq2dROgyxjG9MijDc+YTxG4dRq2
X-Gm-Gg: AeBDieupq9qxuve3lQ9EjbWLJQFMl0icnCmkgkqNWIyaLTvVPjwF0qI7EI3nQU3bKfZ
	ciI+CuH6FxcZDsFm9jQCLXMZgAELCXvTIH/Sl4Z4GOk11RgCG2j7J90HGN6pQkZYixPyEPO6Lkr
	HT1JzAPYcFtttbSLUg8lUERY3cSf1fyiQWIOJNifXG4Gk/yXSKPtZlqMZ0NFNA3LV9+S+2Y7k/I
	OObFhwW3xd5vtv14q93CzrP2cRaeKEo2HesIdaNOYea523nTTvLlMbiqRZX/C9mGlcejUkUxeTv
	quiCfvejSTyQw88pGcmnTkugCtXooYztzqlKLq+SnHxjTMcHGZHUSuxS0z69Pt4a1LLdnIkOKlG
	jFyYfkHw=
X-Received: by 2002:a05:7022:e986:b0:12a:6fbb:3353 with SMTP id
 a92af1059eb24-12c34e45172mr1135238c88.3.1775801370826; Thu, 09 Apr 2026
 23:09:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409-teaming-driver-internal-v7-0-f47e7589685d@google.com> <20260409-teaming-driver-internal-v7-4-f47e7589685d@google.com>
In-Reply-To: <20260409-teaming-driver-internal-v7-4-f47e7589685d@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 9 Apr 2026 23:09:18 -0700
X-Gm-Features: AQROBzDgXsicMjn8BsOTGzlWWo-ihMHv4mp5OD9b8UmWk8fWiTjPTQ75KqeAXcY
Message-ID: <CAAVpQUC4PfRjs2wwRCGJJhkyoLitHVr_4ca6WNgujZwJwXU3Nw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 04/10] selftests: net: Add tests for failover
 of team-aggregated ports
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277257-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FFDC3D28A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 7:59=E2=80=AFPM Marc Harvey <marcharvey@google.com> =
wrote:
>
> There are currently no kernel tests that verify the effect of setting
> the enabled team driver option. In a followup patch, there will be
> changes to this option, so it will be important to make sure it still
> behaves as it does now.
>
> The test verifies that tcp continues to work across two different team
> devices in separate network namespaces, even when member links are
> manually disabled.
>
> Signed-off-by: Marc Harvey <marcharvey@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

