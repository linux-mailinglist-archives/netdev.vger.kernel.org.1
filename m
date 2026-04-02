Return-Path: <netdev+bounces-274670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAq2BMLAzmmqpwYAu9opvQ
	(envelope-from <netdev+bounces-274670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 21:17:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 196E038D97B
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 21:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C91EA300BE9C
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 19:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A1B31F991;
	Thu,  2 Apr 2026 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iq4ntF6H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5164F328616
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775157396; cv=pass; b=UjfbcB5X2fO+J3NWRUFfqsfEdq6yywPJrhNKS/qqiD7GWJFHh37sbbWFERzCitlekLR56hEeOCD8w7T0jNwF1GRzovNkZAtNhmPqONQd8kgzDAUgS4+zYXCZXryNw6V13QI8Xk6uZvl/ml31F/cyFObCSmmngEtSa26EtZvj+MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775157396; c=relaxed/simple;
	bh=tur2mv3Eh6thrz4z1Nb/H3iuiz5myAzHtYCYdQ6gUeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdB8nYW++hFHuws4lu17yAVhYnsbyxqWydSu+Qe7RQFc5ABZKndoA2RZHFltIdEO8J5E+3Eh+BmaP4qu1M3jQVKU4sT7FvN18nQiBfenRMt6jhxJvnMKCaeDmQBlm5f7wOrt2rnS8xRjIhpMxd485ZJtFvXscX4wlGgwAi97gDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iq4ntF6H; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-126ea4b77adso1778137c88.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 12:16:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775157394; cv=none;
        d=google.com; s=arc-20240605;
        b=h7VjaKBdsNHCwLakfspzhKZ7kakX3QtGrfKNt7DBuTtpBcO5LQ6/7LQTM0RJq/cBPW
         twRBCqw8gGmGYBvFz8q+JUrw7+VMHaAwJI7xWQg3NrA6CY73ORYtiFNoboH0HOlymiuj
         FJi1HzixgBolER3gMbWfeAfps9zFXXrBQwKusO8znC7gJefslxAv7IbHUpO2TKaxqzL2
         aype9gba5pfVfcMZ6PYCfB3hKnZHd40zwk6ZwIGW2knEc0p2mDM8xymQrS5lCS9BC2Vp
         LuUkSRv65qSEaSvXrwGRt0KCQcF47RvOJfPYhGNyf1UTPCnKMP5fAUH1sAsB00ynUwpN
         GBjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tur2mv3Eh6thrz4z1Nb/H3iuiz5myAzHtYCYdQ6gUeo=;
        fh=sLcLFHH8jvYha3R8WrhKldB31Yp6edTt89E3Sdmhdto=;
        b=CX72WlhrN8rMuwjxugYpECQUdEXl39pxBOH1OYJmDc7ADABkKAjkdUo73uGRiGmPb/
         JTwso6Y1ktew7VDmulPUVNIuhACO/vd+aqmik2JPWOwscpCC77E6afTwQMZpka9u7yjI
         kJLEZr/lUBnB4QRJeoP74YWcTPoLXJYkRdXYvJiqk5WX8NvLcp0SGB/R0ojRWs0AiUOv
         Tf/RF8F37JWBMwsTqe6UzUAe96i+f9+VDkbdZyqzTZK26zcsjol1qX+DxDd+UtMUcYFz
         qOBybOollO54Ev3FZFIjBqhfgVQMURcZ4CZE4WcLQQQh4goi4GdfyOFIZety/Tj+syTM
         k9hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775157394; x=1775762194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tur2mv3Eh6thrz4z1Nb/H3iuiz5myAzHtYCYdQ6gUeo=;
        b=iq4ntF6HS6T8+qeAkAL+d36R16ynvTwVPfea47zKIAU2E6MM1zJTeUKQ5h1q/fPY42
         u3N7wr4NuGYpD12f27kDEsNKtYKh13THi+v33GRGQFiJKJg8Mijr/vYE8RdUyIBDz8I1
         bIyUfLUTQJLsWJPV/3NTkoBaXAvV3AHIHdtkl0gwx2c97nKHteDGOYhmZa9sXcn+88vz
         cL4EmMAgSLjgmh8sLxJuI2gKJFHeyPp8KRHyDUOHOZMcDETSU9E+mMg8vcqSMgULJOGo
         faixKc/+dMo29hCib91EU+6L6fcYikSdUFfhLSGU61GK/8zCyi0+Mc7JFdRmijxs4KQG
         qgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775157394; x=1775762194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tur2mv3Eh6thrz4z1Nb/H3iuiz5myAzHtYCYdQ6gUeo=;
        b=eEf0PLOpxH2olBKsbjmWFqh+RkmVMF7CXFC49V09FHdu1OjyGDEW0Liq81n+tRN9In
         BdXH29+VGnRiovksU8fOnUuukak4IVrHIyGnfUiZIYwId5P9zFpkWhEjzMUCaeEiLLiJ
         a5SX73ZiGZP3Az4ic4kIvAUpuJBt1TEzRoeZ6MBWTKgP5Tp4v75ZTchwNBIXz0fL47Dd
         hruPbz3OKkQmgi6wOQ2Zib7MXbe8K28EEZuE0AgtUln9O+TJojjWffgmMIOTPCwMZARN
         uhLYc4EvJUXbNix/0LBEgRtZV6POZweWMjH8y6lIYX8quLq+ufMIEEBP10I3VrXcnG2S
         YiVA==
X-Gm-Message-State: AOJu0YzyXxAHCW6jLVF+mLGx0zquUhVziJZYl0ya+8dcytJ8tXIN3dwz
	kGmNCSd6uOdW0cqqAeK7U6kYzCrjT9z2/p6Dvp5r4hemIl46H8p8TM8wAc6g4eK/4p10ii8o9B6
	8A1ldpb/bntc0J9Zz+BwEo6tiYBZS2RKqd4uSC8N95gGfWLwwyggzMjb1
X-Gm-Gg: ATEYQzyliUUIc30ynWQg/0eGfvs9xZDBLivWr2ySu+rsh9XnO/ifg6UakjET3OUlu6y
	9Pr3gjbXI2icDzlHCYgyyOLgMD3mxPBbdEWM6L2o7Cn8+pUp+EwlBD04pgQEjnS08fByAIug0Sj
	hDSAd2XWGGmThx024e+t78+GIYb7dSuK3MsNG2PKldrLz55tvnbLH/ccvf7Vh+Cl/Oow5hD1qd0
	A7D32E8IQFAyvl7IbOQ0pJbogr+GT96tbVqnZNL+wGgmICVDKfXzQaid3ez9WJtG0Vt1f0pZEjt
	c8/004yvBK37X+G10rAk+mWc1H9vmwV2xbSsvP93U5YXC9dXVGchIiFvNfKeZ78lf/qivWzkaQ2
	U/rvb
X-Received: by 2002:a05:7022:6613:b0:12a:7181:2f1a with SMTP id
 a92af1059eb24-12bfb6ec537mr139031c88.5.1775157393737; Thu, 02 Apr 2026
 12:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402181432.4126920-1-nickgarlis@gmail.com>
In-Reply-To: <20260402181432.4126920-1-nickgarlis@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 2 Apr 2026 12:16:22 -0700
X-Gm-Features: AQROBzBxXgEGrHkVa2JIF85ugNuP07x53ZP25zusZX8PJBT4M7ZJipmK_w9EQog
Message-ID: <CAAVpQUCAuNbOAxmVwu_Hk4kdeCvimqwJ2Ak9cMc2GOj_7m7NzQ@mail.gmail.com>
Subject: Re: [PATCH v5] rtnetlink: add missing netlink_ns_capable() check for
 peer netns
To: Nikolaos Gkarlis <nickgarlis@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274670-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 196E038D97B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 11:15=E2=80=AFAM Nikolaos Gkarlis <nickgarlis@gmail.=
com> wrote:
>
> rtnl_newlink() lacks a CAP_NET_ADMIN capability check on the peer
> network namespace when creating paired devices (veth, vxcan,
> netkit). This allows an unprivileged user with a user namespace
> to create interfaces in arbitrary network namespaces, including
> init_net.
>
> Add a netlink_ns_capable() check for CAP_NET_ADMIN in the peer
> namespace before allowing device creation to proceed.
>
> Fixes: 81adee47dfb6 ("net: Support specifying the network namespace upon =
device creation.")
> Signed-off-by: Nikolaos Gkarlis <nickgarlis@gmail.com>

Looks good, thanks !

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

