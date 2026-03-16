Return-Path: <netdev+bounces-268163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKe7F9YGuGkWYQEAu9opvQ
	(envelope-from <netdev+bounces-268163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 14:34:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F3929A7DC
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 14:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1802E301AAB8
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 13:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4019396D0D;
	Mon, 16 Mar 2026 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P86PdGcB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69199202963
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667713; cv=pass; b=jGFPOQdzPWakWHH61hLY15ohQaMfod0MvUaoM4G6KppnNixaMCUcpEkFh6XeYXwkcsmAvrQlcmw2FFF8yFSwK6zqAs5sJDAyyflwBdwsbrEsEVgarovEVgBnGGWKhwijvcV4pSSv1Dh4n1EkkRLJnzuWl5qSjgy26ALqeMjU6pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667713; c=relaxed/simple;
	bh=GFiHuIdSXAiDtoJsXQ7t6jfIIaXbge0QMXUUMdj/6JY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KeH4B9z7Xlak8qyS2WLy1fkNmt5sUWfJitJr4AOAYo8Rd9zdPTHe8v0/DOc191GjTYLziW4Yf3epc76QKQ13ojkn2bMZbWpHRdRVOZmxxiQvmliESp4RFmP0Xtc1Znoq8sNLyZjLdvf8Ro5+djsN0D2RV3TRlatIql0/+AymFEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P86PdGcB; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1271195d2a7so133246c88.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 06:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773667711; cv=none;
        d=google.com; s=arc-20240605;
        b=fPAjIzpP3EhsEukaSr3U4h0Q/u08+7p+McF0mHDqj+BEdOo5QumH1kU4J6u4vcMD+T
         yRnNz/EVkpjYKVjX3RijCuFcGFAhPD1MuUHrkoSYTojBMMCwoHnTTnzZKbZpr49TdNcP
         7s5i2ardl063/OJLPBxvNkQTPrEG5YaU0vAXMu2WRcQNwY6Nnpx6X705F+E7WSNmYcfj
         6Qsdwen6HXGckYKtRv6itJxDCQoY+3kJ/FNaUtjbSNuLSXJK5EdPNSLzKkZrioy/fdGW
         JgGPcyFlcJyss85tQwvBrTXCzcCFHDh0I1BYZyPE272FFzb0ODy3+zydn9EWnRCEm88x
         EeZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GFiHuIdSXAiDtoJsXQ7t6jfIIaXbge0QMXUUMdj/6JY=;
        fh=AexY29w8O3rglwTTqodKs10B8MF/8cGhoieQt912/Fg=;
        b=d4AeDOO6Ehl0WYz1Hu4rG3tLAGUDQPiWuZOpZQZ/wiroJKemSaQvqjdnW5ilsOFhyn
         SqNLR/CQm+tg+q8xdFdiIon0T5UeaoFlVyc/VkR+x9yWky/nG/W046DLo1CAXxeLsREq
         LkwVkbNSNtI52lkG6mrCnNzkVDQf+scWm0rOrYHWVhd/fHNuIXrPejgpOQJrhBXu2Sky
         CWyaau0gMXtXuKqZJsvkSo4bWG2c/XTZ2rVCBzqKA2wpEmJgJ/ILqHoYIJstf20yEQrD
         9Qm0UCdxhZ5HFQ3NPPDRFK+GW1mLa2OuKN4c0GHcicPlEpSvyI4UhebGGcHOxID3VabM
         a8zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773667711; x=1774272511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFiHuIdSXAiDtoJsXQ7t6jfIIaXbge0QMXUUMdj/6JY=;
        b=P86PdGcBomn751WPJNmT137DiencjCKpi+76G8XEHaaE7Ok7wsnAQxv1sze4lYUN3c
         9vsY6Er5B4V8JmVF0zGBsxJsQ3NwupDjrRkknkc1KKfcbVOIERD98udNOh6NLEM8F4Fc
         5gBQjWeduPayIsRsVzXhLyQxuAuLt/jNaHjRZwNVSnYrnEOzMtI4h9E0j1ecPVdTDtqz
         fGGlGzD5UvSQjmhPe8qoB/BZ6KUNBTrxny3nPMujASqQvbq+3ohZ019DwsSvgP1JIcG5
         KN5A65z7RSxMZV0mfQyqcxPyXsdmzbNzVlzPkMDKFzHxSjcDx8Q0XwzuP4D6ilUN/GuR
         XhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773667711; x=1774272511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GFiHuIdSXAiDtoJsXQ7t6jfIIaXbge0QMXUUMdj/6JY=;
        b=ORckjGAcuO8YW/rM20WOFySDHTK+9E7Lxo1KwFe/o0PLV08nloQISegerbZHz3XwBG
         4CphlrNw6S7LAfAMQRGjjuWNXQQnl2XNfRRkDpxONbb9cynSthESJ+AC1a3/FkyN1yke
         A7aLcX3Dm95mces953RMy1e93g+YQRjjw7CrMZENSpOK8m5YDpCV1XC97vmGa41K6pS6
         qbwOl+/19VWAl1ZitSP5ZuDkG5xeltfDShpvwmHx+TEA5mMtODt9+rb+xR4ZA0k10OvR
         evcTI0A6cpnrjW2lW6ZAeafIiyOsL2FOeanJoZ+NJ/7KDsc0eccahpNXGnuD5pZ08KO+
         M45Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2intS7P0U5zpoZmpN4Pth0p3nLLH68gVmrC2GGWmGBj/PpSRuvq6apXTZK09WOgApELElycQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlnyELsRkwQmZm8LueTdnk3xvUi7wW+JIicj0oYVK7eUMQFsQl
	Q730G9PKJQ/12G/QUBZFKgrwGcx8/TVkmhK7FwcxaCoQ6xq3Cr0iyJtfAe/PnUIFIgF7H63hzSL
	1wGJcZrLYOQtkHde25CtF/1ry2iQEBXMMii0wqFRH
X-Gm-Gg: ATEYQzy1CIIIao/o8YSeEckK2rglGQ7m5eJ6StNnCrwwjkVJui59L7h25tY7bGG+TJe
	H2aYuTe//IzpXurxuqYs1zgYAnoQjWCGqd8pb7PmdV4RJ6GGpiqx1e4x5ow5FaMIOD5uob71ei7
	5iMQTrdSIQBuZrxJH/SQ3mxzaK8I44TpXOaXXTQFfE0C8Ku+Y+DuUdSZHf/fhi2kRtfBruPVGxq
	4Xo/tS9s08i9cGzNuc+FiiojsaPXeSK3cY7l3fL5He0Qomd8GT87Qct8DXcnFmweFAJAARM7pRa
	8CtH7WTV1+a2i0vURzKb6cdanTpqOIvRfupgTIY=
X-Received: by 2002:a05:7022:222:b0:127:9d23:ad43 with SMTP id
 a92af1059eb24-128f3d18f78mr5757422c88.1.1773667710815; Mon, 16 Mar 2026
 06:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311052954.1224278-1-kuniyu@google.com> <20f079ac-3046-4b12-a9c4-381a077cf36a@kernel.org>
In-Reply-To: <20f079ac-3046-4b12-a9c4-381a077cf36a@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 16 Mar 2026 06:28:19 -0700
X-Gm-Features: AaiRm53CJf2mxl9NxsEtJgymDfJqmhZP5GVOaX4YL9E3SbREGSeJVeASJ-elRKo
Message-ID: <CAAVpQUAxyQESuJ_-H9vW3szTL_76LjksyswOmQYti1yj_jbeKQ@mail.gmail.com>
Subject: Re: [PATCH v4 net 0/2] ipv6: Fix two GC issues with permanent routes.
To: David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kui-Feng Lee <thinker.li@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
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
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-268163-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D0F3929A7DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 8:03=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 3/10/26 11:29 PM, Kuniyuki Iwashima wrote:
> > Patch 1 fixes the unbounded growth of tb6_gc_hlist due to
> > permanent routes whose exception routes have all expired.
> >
> > Patch 2 fixes an issue where exception routes tied to
> > permanent routes are not properly aged.
> >
> >
>
> There are several tests covering gc and changing routes from permanent
> to temp and back. Can you expand those tests to cover this problem?

I'll expand pmtu.sh or icmp_redirect.sh, but do you have something
in mind ?

