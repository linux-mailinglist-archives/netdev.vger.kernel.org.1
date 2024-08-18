Return-Path: <netdev+bounces-119447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F87955AAE
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 05:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6756282053
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 03:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099B38462;
	Sun, 18 Aug 2024 03:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTtYhPJt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EA8322E;
	Sun, 18 Aug 2024 03:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723952149; cv=none; b=H9TJ7sFSqwHyabktmQMw2xoJxPZ9mPvE4ix7yeI94FSBfuzlWLm/dppiy9ItvOTNMMtMQ53UiWseWKj5ncZelzaOSS2jIj6Ua6sGqsTZx8BxVsFDG8iPEyL9kRFq0ikqF0wYtaZ6/AU89JXOq5qXP391Vemv+l7Ozv4jX8YbzEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723952149; c=relaxed/simple;
	bh=bBAGt0RUzo/PkL1G4jdaE78ls/hW63PIrkGNidzEbxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLMt5DCRgKyNUNTl3rBb1y4Lmj0LmpmKI8poipCpUX6kOK/9l4986gPv2TocKSNe76Botu8tjatJeDAOTIpu5sz4tu7Ca59x7xHRNWnewDKpn7fHx/QPJo9Ws6iqADmNs7DIc19o/vR9fiVPnveKi7A2lW+WnITQcVHKxyrFSQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTtYhPJt; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e1205de17aaso2132110276.2;
        Sat, 17 Aug 2024 20:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723952146; x=1724556946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1P5R/DPlI6df5ow5Ixux9R4PC3Id81qsHZc/bwihkoc=;
        b=CTtYhPJtK0vuudTnF8AQiMSJ/I3zcY115mmiljrpZGXTkHh3M0a3q859IJLMGy087G
         Wa6Cq1iWfRmNMMgRHJwWLk473t7TEdt2FmIFkeGdCFFRsCLyPOE7PV4QJB3nDQLzKSYq
         HCtetUj1Tgrn8lNALiZdAQAAbCDTxIUn2EeOlwv9XowFCEr9I8VfDnw/SUc2peKjpZYl
         e+/XVYM6JjqpLuL0ek/APRYuKkiArxpSJ3cpk1uP1Q/+A1w2ozNkba++KwHX32HFF4/E
         /coU9I38VRHKvMw4h+Zu7YHJAw9rnFxdKZ3xFsHTtLT029+8qpQZLAcaqFjUill5NLu8
         KkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723952146; x=1724556946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1P5R/DPlI6df5ow5Ixux9R4PC3Id81qsHZc/bwihkoc=;
        b=p/00rHWn9taih5DdklNYDMeyCdp0EHIuJuw47i/vXq/z8k1KnO11+GYPj1Spf69tMd
         39ncuxUkp21MKoGMuiZ/hC0MkVhWrqaqP0n8rwqDhiKPtHfRCS2QIoTrCiBOpM4QFwLd
         BpPtmu9PL3h6+7wjhHRODA0hPl5oElcrn2I9d6mruHQgO1yZilvgUkdK3Z17BKaywzbn
         mjQ7etSgyIQY1RsX9a54E7WgTlmHtQRlxHwl0TBK8jM+2nO3XB2YguA6xyLIw6PhLGKW
         3So1ewEjovgCV+ZDGUU7cYN5ohUMnLKmUJtCLU/r9yfUeEkm3RNOPnxSAVeYfO1/SK1k
         Q3iA==
X-Forwarded-Encrypted: i=1; AJvYcCVuJ8KeM0Kzc+ZDLi7ugoJtXJvNkpqjkOrKACeN5X4EyGRNd6SypTR3iMUimcxiDvq9JY/f/5jne9tAVSY3+hWDBe1/4Uc9W/wU83w74jF1ts0RkzSP3VeVhgqPOR8KlJrLQS0+
X-Gm-Message-State: AOJu0YzAlXgqFRUNsVHuND0bhbKLZ68+VaQz2plbNMxECJBQzUTsSLGp
	EiLxKX3qpOttNq/FV+uKQXBYzZy4wwTtYr/AZMKpK2iz+nED+DzjLq4jtU5r9Y2/AWo6dT9NseV
	pLuN1L0AgoCgMIZnBR7M/xQNgos8=
X-Google-Smtp-Source: AGHT+IGwGdX1UKFGqKQg1COx7+qTvBnVAz9oEoqUHRfyfFDbacv/V8ahDNlZY3NclqXko8QztiMEDS5DexbgaLyiehI=
X-Received: by 2002:a05:6902:1b0e:b0:e11:6a21:2270 with SMTP id
 3f1490d57ef6-e13d0c38ec4mr3975831276.6.1723952146351; Sat, 17 Aug 2024
 20:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815122245.975440-1-dongml2@chinatelecom.cn> <20240816180104.3b843e93@kernel.org>
In-Reply-To: <20240816180104.3b843e93@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sun, 18 Aug 2024 11:35:48 +0800
Message-ID: <CADxym3aUZ5ng0K+kT3CBsKVG8-jSWe3fjVrSWQJLSXrm8oMHrQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ovs: fix ovs_drop_reasons error
To: Jakub Kicinski <kuba@kernel.org>
Cc: pshelar@ovn.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, amorenoz@redhat.com, netdev@vger.kernel.org, 
	dev@openvswitch.org, linux-kernel@vger.kernel.org, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 9:01=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 15 Aug 2024 20:22:45 +0800 Menglong Dong wrote:
> > I'm sure if I understand it correctly, but it seems that there is
> > something wrong with ovs_drop_reasons.
> >
> > ovs_drop_reasons[0] is "OVS_DROP_LAST_ACTION", but
> > OVS_DROP_LAST_ACTION =3D=3D __OVS_DROP_REASON + 1, which means that
> > ovs_drop_reasons[1] should be "OVS_DROP_LAST_ACTION".
> >
> > Fix this by initializing ovs_drop_reasons with index.
> >
> > Fixes: 9d802da40b7c ("net: openvswitch: add last-action drop reason")
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
>
> Could you include output? Presumably from drop monitor?

I think I'm right. I'm not familiar with ovs, and it's hard to
create a drop case for me. So, I did some modification to
ovs_vport_receive link this:

@@ -510,6 +511,9 @@ int ovs_vport_receive(struct vport *vport, struct
sk_buff *skb,
                tun_info =3D NULL;
        }

+       ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
+       return -ENOMEM;
+
        /* Extract flow from 'skb' into 'key'. */
        error =3D ovs_flow_key_extract(tun_info, skb, &key);
        if (unlikely(error)) {

In the drop watch, I can have the output like this:

drop at: ovs_vport_receive+0x78/0xc0 [openvswitc (0xffffffffc068fa78)
origin: software
input port ifindex: 18
timestamp: Sun Aug 18 03:28:00 2024 142999108 nsec
protocol: 0x86dd
length: 70
original length: 70
drop reason: OVS_DROP_ACTION_ERROR

Obviously, the output is wrong, just like what I suspect.

> I think it should go to net rather than net-next.

Should I resend this patch to the net branch?

Thanks!
Menglong Dong

> --
> pw-bot: cr

