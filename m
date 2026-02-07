Return-Path: <netdev+bounces-257782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJNMOlaxh2nwbwQAu9opvQ
	(envelope-from <netdev+bounces-257782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 22:40:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D831072E6
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 22:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A652301225D
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 21:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6966354AC4;
	Sat,  7 Feb 2026 21:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qI7v4F3b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D722D3EEA
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 21:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770500435; cv=pass; b=GLVWhI9VEU+TnVyC283/huzBLPAcjZWtFspdRFcn65AOL83GGKW5FfjSNt4/SySbYzjnQ78+QilGQl2UbPzqPbEnIhwbBMkat8Nrm60QCS4ccFBxGyUTULxvv/mzv7Y7lhAZboJz2auRpou4Kisj5l0gfHU7EtnmXStedAwtwPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770500435; c=relaxed/simple;
	bh=oBdxX+BhCc3YQgSTDNpLf2oju9EUAluaIAsrA53lfQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Irlrkh/gdoj3PZQ2c98fqmbWAVtXKL9z7CSBw943f1j8J5gKvx9ArHVSsdTwwCBpRDcC5aa0DOvi5ctcEDrgIQMIdZUdj1DCjwJKcBALdlVcmNoN2Xs6ePiAJf1uxxBg0yQnQXkjBLWQPsHj1s0Kf5xkZmUybuVYsjaO3YEzcgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qI7v4F3b; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-126ea4b77adso3604098c88.1
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 13:40:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770500435; cv=none;
        d=google.com; s=arc-20240605;
        b=HwO6Iki295XHEKbhfb4+vDPl6SbtyeOvozHEfGYO4RgzUS/gylH/67aCguYuDb76em
         r4x67Pbj4G3DFDrEHN0/k56Dwa1LYLmKiYTxP3yRFgRXpgoA5zqQ7YNuQS65bF3v1J1L
         4uVfxzMjZ1cSwk3itq1mlluLBcum1fGJsKLeZFmW1mhweNXtvieeJe5vaZOqGomff0tz
         uzRrSoScHKLZnyAtVFDnHizzs9ykVp5Kqz+0txlxQ0hauAeZvcNUy+PDfYx1/ogLscxJ
         9uvN4KxAXOUSbN1vz9a4VeZtJMz9NOePKA5Y3xYkDaYZ3hgOhJ3DMwIsyiw1y5KOxhNO
         WTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oBdxX+BhCc3YQgSTDNpLf2oju9EUAluaIAsrA53lfQE=;
        fh=arNfSDa7wvLWrvUaEmTfzUmZ9DRiExfyFmoQ7UTMKrY=;
        b=e//RSuJOoqlsRdUHqdKpU0OBewP7ssI1+UIr59MCXBAPGESyFRQfXD5wBv3gSDQQFK
         mq3c5Clrgk8bX8udQoRW/4O+MTxlSp5yOD7cvmlOrLQP8763NPBEfGy4IAyEndJqBM5L
         sE4EsqZJ82lzk2NYj4/fEEcKB6/w3CMuNHHuxOXQzjMZZQgc2Sv52+nHt6VwzZYcn/hB
         1Ky5WRlDGXlKtVOVgwzWiYjhtjoqyKZEgAUrnEC9Bd2wLliWDQ7iniVQKzJ7jiBbFBz4
         zr+RWI1mU+PP5otgmtgkxGYk5VUym7E2nM7ozzGc1KfA7MrW1gHa2f0kzY6acflQMWAm
         jU6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770500435; x=1771105235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBdxX+BhCc3YQgSTDNpLf2oju9EUAluaIAsrA53lfQE=;
        b=qI7v4F3beC/fLTvw01zQr4NG1jli3qiC92TGfP9Rq+b8oEnf9dDwbWj4UpUK2J8r44
         00xp/kl89uL6E5xPuZ9h0sDZrATneL9KwOKnQ06cq42GUiaxOD28zwF4H4ZmnEVhFvHg
         Osih1UEbxUkskJI62lHHWuzfD1vk1j1yoqTXv/x1lI4t7I0b5IGoG3ajrSfDuICoYoqF
         XXstkG/+J8yhJCdFCAZjYfBhKPB115hkbdnlHnUd1TpIjWKZ7NZrh23EtVsEU3Fblpft
         SudCFBX79dVqYcq64pCZrYoZbIyCmXGR156W10lJXAM2UQMdMY2OoMe+an8KxQW1Dm61
         ZRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770500435; x=1771105235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oBdxX+BhCc3YQgSTDNpLf2oju9EUAluaIAsrA53lfQE=;
        b=BvAOJmMj9JI6Q3eqT+k0pus2XhglN2c8KDxZWfgm6tXiqhdXUOyfA2vnEqEgJDHuvp
         x8uKpXjqKqT9hLU6aDWIUOdMR5EU0qak37+JfVSHF+XxSoLAaCrDTvyDXuqjdoZntdz8
         6aPpMuPlb9mqSw939tNNE9S3EAKLBtNlRvfsOINCZPTZ6BnMKFm3aeET70iJVIF+HZK8
         P/zcFobP+koHiNAPIE2HTVx4ufgP3f5tMhpDkRaWKBJrZ9+o+QfNC+988BniCBHCZ1YV
         J3JPsCJAGMnO2Fs3PfjyxZMGsqEp5OZm3g3QL84PqcgjfR1NAq/jeOftufCsylmqaOaV
         uvuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnbr6+UlrNUMGNzXigz7Y9z8RK+Patsl3n9TU85qg09COTgXBcCC+OmGtT7VLXoh+lgk15YeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDnzaWy5gk+c4WYDwBQlITQr/7l0IXRUfDX92x+iRA0d9ILBj3
	Fg+qLcF4ht/Fj8lxsxKmy0ap8wfrdMessKZvZt3mgV31kVLbA81cq2yMO2almMXg/Sx5nv3LIP8
	ospKv0VoUK6vOjy80Ze2O/5C2t5vpAiJPrfEFuxCz
X-Gm-Gg: AZuq6aIhmWyFb15SisUx+b/PazQkw9rBWSxtgkQ/4oh28KrMFsklX15EiDVmNY2ZISQ
	XSrjJwn3z4b6rQJHNZvzA1f4Z/zqYA9m6O7LiGGwE+Lhojh4KZAj4gAGhuYpx3j/rqnBYsW14iX
	ro0zzamcCd2c064C5/VPG/yd0Ons78SXeGgHwyNNxCi2rs1E1LnGa8MjRkQkAzxaYjqeGcSTDGB
	l4JAPtJ2MwDHcLJx6tbprWHPldizINoCqczUQL8m+eOpmkefpqI7CfWqgjw954daSXk6nh9386+
	cqsquRoh8sAgRTPjr4wdLw44vj7KLbT5dMcwyRjINRfff1/0ih0Coe/1XG0=
X-Received: by 2002:a05:7022:6ba7:b0:11b:82b8:40ae with SMTP id
 a92af1059eb24-12703f861dcmr3867640c88.18.1770500434335; Sat, 07 Feb 2026
 13:40:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206173426.1638518-1-edumazet@google.com> <20260206173426.1638518-5-edumazet@google.com>
In-Reply-To: <20260206173426.1638518-5-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 7 Feb 2026 13:40:23 -0800
X-Gm-Features: AZwV_QjuMOdDw-CjUJ6f1DAwn-ZM558BErDIPHv3x3_ehVAffruyJBHQnR_GVjc
Message-ID: <CAAVpQUCy57GK5=Fkw3dEajg5Fumu2tHS8yhBtPSz_oDpqhg+Gw@mail.gmail.com>
Subject: Re: [PATCH net-next 4/7] ipv6: inet6_csk_xmit() and
 inet6_csk_update_pmtu() use inet->cork.fl.u.ip6
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
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
	TAGGED_FROM(0.00)[bounces-257782-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 51D831072E6
X-Rspamd-Action: no action

On Fri, Feb 6, 2026 at 9:34=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Convert inet6_csk_route_socket() to use np->final instead of an
> automatic variable to get rid of a stack canary.
>
> Convert inet6_csk_xmit() and inet6_csk_update_pmtu() to use
> inet->cork.fl.u.ip6 instead of @fl6 automatic variable.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

