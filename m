Return-Path: <netdev+bounces-206390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23836B02D6C
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 00:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 151617AF0B4
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 22:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B09E22DFB5;
	Sat, 12 Jul 2025 22:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0MxG1lzu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC03A222596
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752358386; cv=none; b=bhUx7J8M5taTmtxsGojmG6IoUM1lEkjdn6pDdYaWXV98PY9D2dbCRh3YUJs9VhMu5UlA8kjHF2dbkF/ilU0fQkq2yItRR4lTkSZPP0HZT8uC6U0oseCCn5CnToeOjA+8tZ3Zyh3NGxsBKU8zNImnfXLjsNDmmEUePdSRsmsmTUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752358386; c=relaxed/simple;
	bh=5XXI0zqO9HMq7gS6Sutik+M16ZOwrBzNAUpGoe9/fK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F34rXSbQkLVc393dElWogstbxYRoBRxTmEs8cM8fYDRQFci6rQSflMHaw0BRuaCZS0nBoXBs7+XdTrPJzga1scrd45oI1xeP71BABZDhqsvKeWi2Y6vJoqG8MgjMq7KKgwIMsgvHudA3Tm5oZ2yjbEAbWhqy2x//VXnSOnc3Mic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0MxG1lzu; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3121aed2435so2924270a91.2
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 15:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752358384; x=1752963184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3IR8E8NXgqdr3xTjXmNxa9Xtvc35MpTBYH+CEWW4Zs=;
        b=0MxG1lzukfNP/3qBbomj2SouCx9pw8McxtVXRsyjWqNFiMqhktlUwZMy3YZ79w7HqF
         VVPIWPKs8WPWXSGcofRKkUBGS131gXOhmfKBtduV3TIQLO3WkPmIAm+FNguLSk4zUU0c
         w44KB+HyyT7mAloxwjUTFVsl3oTAXRChe0F3yKAIqgUXgKUDwqxBamPPSn6D0sowb2r7
         QzdgHV2iOhJCXnFroml0KxpwAtMmq0dIyo01UPTUdbooXzo/s4lYzW11wqUnY0AjwFKb
         p9ASViWskui/tvb0Zjmm9hGknCMYKKsOo78mP+11XyDLyjoY709MVaLaJlVuCsGZRGp9
         Rr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752358384; x=1752963184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3IR8E8NXgqdr3xTjXmNxa9Xtvc35MpTBYH+CEWW4Zs=;
        b=SNMD/fzMT69Rnrfj32k0FY+st/g3kTtNB5SZaVvwNLwmh+8U7iUjCLKmFEe0qyPPZJ
         nE3HPGYb4YY/osaIMYRrQvxG2o8k+PhxGos4NFVNeSY9SrbVvp8P2jJLIfvArCrzTx4G
         HZvW74GR0M4J9eKTnSBr4MSJtqYXEl0AuSj/GrE16xEiEfQLm0ioK0lCaNqotbkByc0Q
         XUhzvE0RNBNIo8UyPj+j+YVuW20gyf9rY038Z1xFhxBFwybF92hcoEcPnjMS7T7jNihv
         QVVCK6a/LbbSojiVrSRi/VGw+MT1pwum3Ex8lED4PF8jxHBaFYEpiRV7MU+uJ8yg4gHO
         BIGg==
X-Forwarded-Encrypted: i=1; AJvYcCVlx8xiWGkW00WGled/XVVg8MknDc2femu1/M5kKAWy5WvLLRxpVUqKfV9DQw11OU8YjCZaaZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyneTaVJ1WQZ8C5ipx0OLKQt0x5JcDkcGM/CRX/OLxY5Eov0D53
	NM2iUdLi9FQ03YGiXDmtU5tctU7e5D1iIkv3l0FOi5n3LW+HUsHVvxTkCk9kuIn/NYZnF346cXI
	dcIkURsl3hdyI0QRED6UTtbkObNfMibXkd+YmZn5H
X-Gm-Gg: ASbGncuBf/sxPIdsz49HPBBrB11J7fsXLNt4sHAVhwei+SXbyItVf+GZ456rVKck8qE
	tLGoglbrfw2Exxdk8vUVxme2Bnixobbgz5AIeDT5YjUTbwJ4mQbuR7xadqgO6sNWoGNxJqfyIv0
	+IdImbTlCYPE513CTws7BensdmxhfHphuf98K17/oDQUriLip6fdAQzWSxA3zg+JWvqoQah1yHx
	viL9F4BfKjOqWj0O6Pk3TrxWo9j9tjS/0OQVhLS9+7COn3/Zks=
X-Google-Smtp-Source: AGHT+IFALuoDtWo+OC/rzMxiROtsngZC+Ie3sK8eJASz1Je4/SFJtyP+rSk+kQfuqv5DmUOlVxMITIXRbZY281qGXfM=
X-Received: by 2002:a17:90b:278c:b0:315:7ddc:4c2a with SMTP id
 98e67ed59e1d1-31c4ca84b16mr13015237a91.12.1752358383922; Sat, 12 Jul 2025
 15:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712092811.2992283-1-yuehaibing@huawei.com>
In-Reply-To: <20250712092811.2992283-1-yuehaibing@huawei.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 12 Jul 2025 15:12:51 -0700
X-Gm-Features: Ac12FXy611-09B3FFXu8FBr8o8MzwuFwjv5t8T30MiI--EPnB-Ej0E20BluI0Zw
Message-ID: <CAAVpQUC-mV=SuNNhKbpy_1Mbh_sOs856+oNqDVJ4KcLjhDh2kw@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: mcast: Remove unnecessary null check in mld_del_delrec()
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 12, 2025 at 2:06=E2=80=AFAM Yue Haibing <yuehaibing@huawei.com>=
 wrote:
>
> These is no need to check null for pmc twice.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/ipv6/mcast.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> index 6c875721d423..f3dae72aa9d3 100644
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c
> @@ -794,9 +794,7 @@ static void mld_del_delrec(struct inet6_dev *idev, st=
ruct ifmcaddr6 *im)

Rather early return after the first loop if (!pmc) and
remove 1 nest level below.


>                         rcu_assign_pointer(pmc_prev->next, pmc->next);
>                 else
>                         rcu_assign_pointer(idev->mc_tomb, pmc->next);
> -       }
>
> -       if (pmc) {
>                 im->idev =3D pmc->idev;
>                 if (im->mca_sfmode =3D=3D MCAST_INCLUDE) {
>                         tomb =3D rcu_replace_pointer(im->mca_tomb,
> --
> 2.34.1
>

