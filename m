Return-Path: <netdev+bounces-257783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB/NKrCxh2nwbwQAu9opvQ
	(envelope-from <netdev+bounces-257783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 22:42:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0569F10730B
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 22:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9051A300B9E8
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 21:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C2E33C526;
	Sat,  7 Feb 2026 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RwKAKGrQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057DB2D3EEA
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 21:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770500525; cv=pass; b=nPZnuFxffzILOILPNO27yWwhQgWvVLEBW6vNDzIrNnqR+1AXBfMD4wmWVCcH1S1Zfd0LAmxaU7TKGO0JMocLi+ZK10UGBBrUBVQ7mBZvbDWbdOnuEpFv3WE9RnR6DlFA3KjiNnPXfwjCJMWcnMu1bxNVbguJ4ZWOaPh2vlXySdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770500525; c=relaxed/simple;
	bh=QigBVl+3KPBzmo7hrZ4VeveyGxBi7cwVXhi4gEmNfe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CEUIlKr9iArWbOnBbYtUETmDmv029WMDJOAXgkfYvusAcI4xgfRJOI7LOv4HJmX3SBSHUXMHIP/XEYgg+Jk/vwSr/LM0RiYFQOeUoQe7UarDrYyZGY9Kom9txzM746EqTAxeVfdaBkn71vW2wgEsDCIQs8qARkKOiZSnWbOuofQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RwKAKGrQ; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-124899ee9d3so2214317c88.0
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 13:42:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770500524; cv=none;
        d=google.com; s=arc-20240605;
        b=HAyoLBQXuGKIn0jkbpS8BlUcFISBPowkNu97W+HXeoCk+9G0c12KZBT+WBXOOYIW9Y
         cZuPWI1NFTuF0o/Onzjt8133JcWKBPrXgaAxy88FRQLbWFNzGvN8ZQkmls48Nlmmx5mE
         JLKYHlD613e1xYVNWKi5yVqL+jYVRr7TLlOtgUEOyzDT46w1hweyJnTa4Y/l/tCravfF
         1AKPq0AWgLUfjrcK5pNoc6KmRyzk/SfeIDeLDpVFn8/pmQdeGb6JyJAC5zlJsnBIm9Oc
         VWSSkqkzzXaCm5jPPlMyYVieIzd2mF8b0BBx1kKVvR/hm7NHauB+6UK48Eno3BHlTvsx
         cuXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QigBVl+3KPBzmo7hrZ4VeveyGxBi7cwVXhi4gEmNfe0=;
        fh=qqNu6OvDGG9b3osu/ZJ3yTYgwqx4SideqF8uD4DtdQE=;
        b=Dc2wjeeVgdIrg6euw2mApgaquFqzMdT2DLJF6rqzbAril6i0PI240n02nb7k083l39
         dH7vqX5tzVs6Tma2wLDGvxN56Ce+pEy1c+NV/uHy1oKr+sfNLqbOlJE34QRF/cNsW9Zl
         kbCusB7IjW0PlAyJD6idGmyZQnmI19kRe1s49rtq0kiJPtzPcPJvJU+OVNvRsQrUjxVA
         3jgCykZjVOq+L744hiemBELcKXLOPTGRiHhYyNx/Z8h8LljJB18XvgBaF4ZNfuAIYjAo
         BKETmE28/lgjSAkA1qmPGWMyq1euya06dHusw94GU++xwh77b3q3xYvsPzsEbL+ufM2I
         5z/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770500524; x=1771105324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QigBVl+3KPBzmo7hrZ4VeveyGxBi7cwVXhi4gEmNfe0=;
        b=RwKAKGrQA+AlJvAtv92BaJxl7xFw+M/+CNY+KpkZxZaoghzbMkH7CradivPhVKmX5l
         dJQjf/6zs1BV4xh0D9R8HWY3lxTP41zA+JMEJofyC2n9GO8M/S1dehcBeidg2d1hfITy
         rwUCST7tyNZ+EiJhQK29SjzMRi5eucwfz8CHLWt4pCLZCkdHstVDYy3hkH+MxPHpdXCO
         M/H2/V2IhUb18WUMZrSSPZdLVoFgdqsL9AsAjNVAjSRy36ckGBiIcbFUqCMWyQhLU+eP
         JSCHaxSnIIALjvcqHatQuC0D0Xptd4ntEUKQz7Uc17M89dMbz4xUkXCbA8znHiDtymTm
         0ugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770500524; x=1771105324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QigBVl+3KPBzmo7hrZ4VeveyGxBi7cwVXhi4gEmNfe0=;
        b=fvbZ1VkcLIrMgT/W1D/GyiKtzpGV5DKvgCgYJZCK9pI6z1Qr8EhRA3AMr+uV1u8aV0
         TYZi07K+ZlYVCdGpStqcvcKXqVLR0uUna6qYIMeMVLc+gUAoh4cvaF4q3+GLSg2ce9Xj
         7BNx+/B/nGxwwhi43vFIZniHKBE4lCwsg++QE2lORfsFiR9xrkTwPu1An7MqIQp1YTqi
         pgyRvxqXE0UAt2gmv2q9fA93Mu1PtlSQXuxz9C0YvYKk8ySbpVHdPUqwZsFY/wjXUCXv
         XG3booHywwOdya+S3gI9SJRVHW4+ASsyN0gu/Z49ycAJhrxYgkRFCZsBrSDnDvDGMqDl
         c0+g==
X-Forwarded-Encrypted: i=1; AJvYcCXJ7GDNuRUrR+X/2CaT8qIwlh07c4F9aKNcgKyGIWoy5XHOJMCNUqTAaxyW0s/R4tQeCusQCvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTH5Rcw8azmNax4VCxGWPAvZlJ2XExCguyKxvaltGxbeko6tQs
	9L4OUH1VI1ej/xQkIYNG1GEBy+NKz/O+uWeuyZ7t8bupVUPcftwsEgKou2YvYhIeLZvctEJ8Lkq
	EVfh4pJSCeNrhWt4c8xcLWSNG5bSblVR4p6a7BZ2X
X-Gm-Gg: AZuq6aI709NKPxuh7jQvKKL675kpWsppQu5m9vkXz5+tZPw61aCH81xncI76Jx3r4q9
	YRGEKw7Xghfnv09G0/RchoqA3y5d32KVvTMwSM68s6N7iSY+cmIjVjGRxdEeskLbQk2MgzYyHNc
	QyfUUSVG8dw95AVVBAlFnCl0H1P6azPRZt10fttN+Z4Sj1K6L+JeWwOFvgXOHLK2Onl9HHpuIjD
	pXqoR0eXgBsgcWmTRrhAYhIHAYtU4M7u97TVPQi73T8smb7/D0sTx05Hlus8kJGUymaD/ThoWEP
	M4UzaKHrVHOHcS3wPQMTDvLxv6MYrKcFEBFXpOENQ4/7IQpNoD50QdfDU80=
X-Received: by 2002:a05:7022:40f:b0:119:e569:f872 with SMTP id
 a92af1059eb24-12703fa2aefmr3532792c88.15.1770500523814; Sat, 07 Feb 2026
 13:42:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206173426.1638518-1-edumazet@google.com> <20260206173426.1638518-6-edumazet@google.com>
In-Reply-To: <20260206173426.1638518-6-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 7 Feb 2026 13:41:52 -0800
X-Gm-Features: AZwV_QiJ4p32GH65jM9QNycecD1Ac0mI7WhuHIpI_Cd8GwM1jP3Kvn5gTFYaTE0
Message-ID: <CAAVpQUD3SA8i+N09AgHiobm5V3xkwPVOfUBJfrA8r_Ci+OsLfQ@mail.gmail.com>
Subject: Re: [PATCH net-next 5/7] tcp: populate inet->cork.fl.u.ip6 in tcp_v6_connect()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-257783-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0569F10730B
X-Rspamd-Action: no action

On Fri, Feb 6, 2026 at 9:34=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Instead of using private @fl6 and @final variables
> use respectively inet->cork.fl.u.ip6 and np->final.
>
> As explained in commit 85d05e281712 ("ipv6: change inet6_sk_rebuild_heade=
r()
> to use inet->cork.fl.u.ip6"):
>
> TCP v6 spends a good amount of time rebuilding a fresh fl6 at each
> transmit in inet6_csk_xmit()/inet6_csk_route_socket().
>
> TCP v4 caches the information in inet->cork.fl.u.ip4 instead.
>
> After this patch, active TCP ipv6 flows have correctly initialized
> inet->cork.fl.u.ip6 structure.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

