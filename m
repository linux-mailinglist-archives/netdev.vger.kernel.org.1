Return-Path: <netdev+bounces-262164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNJwKtkVo2mJ9gQAu9opvQ
	(envelope-from <netdev+bounces-262164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:20:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4B11C4420
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BAEF30459E7
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 16:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134AA26ED25;
	Sat, 28 Feb 2026 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="npy74shU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF5918A6A8
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772295639; cv=pass; b=KG7+b0y/Zjmd7FdC2YWFwEKtBWoOtHodpu+u6xc4KuwJ/LU5Q12Rc11OP/kzjbXh5ICiH6T4PTzmIAzV9tXJmwc2N/dWBhm7cEjyjmncIVAZXd3ctNOgxItg3o1RxMhODwPX+keHbDoQHCcVZIneMFAxTdmxIODm3p0aVcp9W8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772295639; c=relaxed/simple;
	bh=AdYtHriPwmiUwOJj2Tl58C39ni7VQ+vP+kfC1aP3iQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ozu8lOOX52ClJYtk1BVd42VbGd5uK7GDyqEkV1/vz+caRipK8Uax8sE3qPXo5UMedQ3eRDuuUPYujTGNZ8MX3pdsiuucGHeDNvbkLBKYMyMTnaXckVr4kcUfMMtHX6wgflhMK0RW41EqgQFoEgsGONmRzaRaIK7ZX5IiTvSjoyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=npy74shU; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506989e8516so28148741cf.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 08:20:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772295637; cv=none;
        d=google.com; s=arc-20240605;
        b=JdW1Jty8xcqHZmi3G0bzCYEzBCclI+RxNyq/q2R6wtOd5IMiBPMYx5rk0LaALwTMsv
         fvTv/bBHBZA1+gSo1TsWX95lPD+qf1N76wVazTjUaCjmcMgc++PWU9jOC2HNB5SkUfpU
         v7zBT1DVL6txo1Jj0HIwYVUx1fQ+ommorzpD58Uf4UDvBH+QdgT0AZHxwYBiiPH2Q8Nd
         J3zjBeF3IHnogxFX2GKI7gbZoTbdAwjEc8lkK51AhFDOhbKeHLdZ8pDELps5DZ78d1jy
         Il6QmfMCKAKoaCCdTx5ERQISq3OpAuA3kyzkX31kuzS8S61WWgMVVz8X19C+KWpW+50G
         XAbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AdYtHriPwmiUwOJj2Tl58C39ni7VQ+vP+kfC1aP3iQo=;
        fh=UVUEC6hzo/7YgKvMSHiGVhNOwpxjzijIlh9XB01NpFU=;
        b=JuthTBQE6DjY4lx+fizspGQMua0ElAqbo//RJnIjqUi2fafQI/nUGcbuzsLeifZ3LT
         Z7EA3aaj72Zs9o88NwleMsfJK0Tj/xjPph5uPrYFMQKZ1bUZT2o/Doj54qQpfRsHGS+m
         Ogh5/sR7c9F3F0OKsZWGYiRNagUa3Qezp8YsTZ2uOkYL/LvMPUNUK0OpudVa3hNO8HAY
         pUu9jZ771bRnhy7uoRGgZom7IaWm5UpTc4gCvBIItTo3vUtRAUqa2ijmap1Fj7V4LbvU
         T3N3yhnL+X5xN9c8YgJis+0vBsw54xzKW2/sP81rtwbhNqCYAjsq2tspjCpDK3MB2u+q
         +TkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772295637; x=1772900437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdYtHriPwmiUwOJj2Tl58C39ni7VQ+vP+kfC1aP3iQo=;
        b=npy74shU+iYJxy+oj0XBcwh5M0WGicgAcZD+5Ff/5KWdgJKTmg8x+l9v+qnbnO0L3P
         Oi3Jqsnc/Id2ilXwvw7Bwfa8XZ2FOHeNBMzOQGu4GM3tjNaW5EiysI/m/lmlrdgGZaY2
         sFKQlzDMOUnfrZw0JUAdQt0o1S+ZzU9lCtEzkNjGRqF17Uo4kkqM1JkMMbBGASeIEWkV
         UHi77iGFBO7b67p5pBzePI7bxFA+mjCRUy/eQY4Qhlr4WctVJlM71/YMKY9ucgm0uHTf
         6V3jykhbUKgUVSzufw1CJd0APIAGgEeAqAqRzzlj6uQk49bf2iBzsSYvgjkpEuFqBzYJ
         y/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772295637; x=1772900437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AdYtHriPwmiUwOJj2Tl58C39ni7VQ+vP+kfC1aP3iQo=;
        b=ccR7ASaQ0GMayyWmTrnn39+CMwKJJjKmXZU5p0xLu2paADxY4kEvk7spoEyccHWZFq
         vDIUljbvi2Lw1tNH/aVDdbvZb4OOmae1PGSO/ORKjEvvhhs8EYmFI57HDSEaEFGdvWNZ
         fqGn0p6QkjsimFqzkwr2FBNbEUNWyYLd4JdupOY6957RxRVv/AdgjsAawRYf2iE4c4hE
         11Yi6/HPg9rVTyyxGBF1ey6/gFNu8xoavTcpXuBopBlrgzn4JSd1bKSO+pBB1aihDWC2
         NkRqROF4+uuHzSdXyeuWM/Hp0krd8Q9CqmgwCthpbAFLWIb4GG6KUgbCswmxk3B0IZaw
         Rn0A==
X-Forwarded-Encrypted: i=1; AJvYcCU4vCiaMmdd6pv1OzpcOTg1edhcP6ybX/s8tYDMIfxnSYgD3n57iJS7EBWGxaoCYON91ezSdZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuNzZVDhkKpdYotGlmbEoqI0J1fnXPDP8o6WIdqoEQl5sx0uqE
	DAHuh1iIFVELEhB1prKQTNsGgyUjGKTHR6WeGl3Pz7rPCqFZo1N4zsJseysEVV+tYBxgmm/Jc6P
	ae4oeg80heMo9FEZRcz+U+dSd1nH+JgTOyD+4zx0K6zIQLnz4XhS1Xghg
X-Gm-Gg: ATEYQzzgenMDO6KPR3ZH55IbTY+Op3Quhvw/EJ9/2uCkm6f/aPs+CEWb5k8e+KKiIL/
	FmP5uJJRK54EOzw81Agq74DM5MHDd2QbHsnLIFSKTw7LU41E9iSkvBKaAnEx3QdalnZS5/JAn1H
	KV8HO9/TAu5ZN91q94X1OWDadBZt/jTzcxnvKy6gbDgv+6AoArR8YbPAyQn+kxpwxKdSa55qJmP
	dMAXtG+xw70kw6zNYdpcMAnenGrtqUB+wl/3v3byvmAPK1XT1gNN0ICuqAkhGaQ1hZrtIpEsB2t
	WTJrAIDY
X-Received: by 2002:a05:622a:130a:b0:4f1:ca82:f1e8 with SMTP id
 d75a77b69052e-507527cb21dmr76820921cf.7.1772295636357; Sat, 28 Feb 2026
 08:20:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com> <20260227033903.3307272-13-kuniyu@google.com>
In-Reply-To: <20260227033903.3307272-13-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Feb 2026 17:20:25 +0100
X-Gm-Features: AaiRm53v5HJZcF2m7PqO-dhtEevF7fg35iejPvdKR-Yzza4XCYeqG6xUVusTxss
Message-ID: <CANn89iK-PY2=4WYhaZY6EufFSHotuf=vAZKU=s_bjYPzmRC3RA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 12/15] ipmr: Define net->ipv4.{ipmr_notifier_ops,ipmr_seq}
 under CONFIG_IP_MROUTE.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262164-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0E4B11C4420
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 4:39=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> net->ipv4.ipmr_notifier_ops and net->ipv4.ipmr_seq are used
> only in net/ipv4/ipmr.c.
>
> Let's move these definitions under CONFIG_IP_MROUTE.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

