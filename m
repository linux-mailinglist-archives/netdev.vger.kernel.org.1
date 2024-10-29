Return-Path: <netdev+bounces-140178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C005E9B56EF
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F2628118F
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CA620C470;
	Tue, 29 Oct 2024 23:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VawJEmc3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BE420C033;
	Tue, 29 Oct 2024 23:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244527; cv=none; b=JYDnnS8HKSu0noIyQcJ3JRTm5okrFFRyPr/dF9zmN6EDUPAXbehz81uxJFAlGQtToofaLuIe7vROItdHPiZS0ibnOopD/s0PzQMOvCKdyP4br4/89/iZTtAMRadOgRfGdnStF5fJSIs92syI98JxgsYPR0OPwyqM8lnGffnB2O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244527; c=relaxed/simple;
	bh=x1A0MuzRBLFkY9yx6etsSuoRRwyr/Apv3rHPG6eihpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QylwcB7AYBhD4WFBbTQFKX9quxdf8prZ4YuZ7D+vkQaDn7ktb7IDdMath0C0qRDHiGVsZuLuU7/nkg/gj1uCNLJa4T/ylzVRLUgiycS9Lpo7cu7/BtQ+sXbXX78oXEAxcePHBIAFeu8gkyi414gZJLPmqIgVxTHknds9pq7Om8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VawJEmc3; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e390d9ad1dso50259297b3.3;
        Tue, 29 Oct 2024 16:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730244523; x=1730849323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssX6VRfuzRAJJQn6zP8pzX55LiD8vmSBzLf25XH3KYE=;
        b=VawJEmc3bs6exiEANIma66x68xGbJmIq3NhAJyrGM8xZC8feYOPeT8IxHLL1C7xv0D
         1U2VwWQiU4/VH8olrxa9sdVaVMdtFIfc+nVsWo0XGuZBGOECiixvl4PYdvReT/uRGEPw
         odiwszRdK4iJKbmiXcyXMv+Zd1YAmm9VVhSU9MtIVyaQZvYbHsqPe5ibyf/SwIkDdSv/
         6y5cjH4j8kZJbuHZ++yjkz0X7N/FkLnxhwv08wI0vAOa7ACH9GuBbBwZYFBnRXXJDNPC
         AzyS1cFamtAcD89h+8uRL+iV6+y6B03Q4CvNvUBmWQ7sI3D9FT+qL2HSax2gS2htpRIn
         uGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730244523; x=1730849323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssX6VRfuzRAJJQn6zP8pzX55LiD8vmSBzLf25XH3KYE=;
        b=eTbL0HGiY0qkkF6g/ilTW/12tzK7Op/+ujTaKO3ngqSwIwNHb28ww7HckIJZBVsBLI
         aXLpgyJgfz05NFKSA+h9XUIyII/V7ZRS8u4u0YpYfKkVJDdsobPFVu6CXZ6N6hMZMaYD
         BR6UmMoERF24+UQ0MsJ+qxZhV9IbmwxWxwnN0En693tjeOKbdlyuVogzarQbWnO2a3eL
         mvf9ee882KTlwCTP4zGJYQqUZLP/zsTOnYr0EEdJt0XAtos4PSv+WkmrO7p+rgD70R8H
         Iepwdx3aUxlq7DwvOQvI3uaw0PuY+HiaE5kpY72NK6fCz7p3svnFte4d9swCA1ai6PVx
         oCzA==
X-Forwarded-Encrypted: i=1; AJvYcCXGUbKpk+EdbgzfmdiwyAg5O1v5zozuYIdLEsjaqWd461kCK+ySDzi1BdFvySol7O5KeH4V3wBx/nmG084=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFOSwczqBvxq5MIOINhFMLFLIM28XMVPV7lZtYo9EAMvJndQMM
	/w638ffb0BrwnlQc/HPSqCeqegFbbV+vmy3Xpit0A7waNOfxm83yesCQBlwer9HKlv+FhooOgn/
	ryM27cNBoYlwp0u+3RZVLfdNmRMGAzQ==
X-Google-Smtp-Source: AGHT+IFPVmycCJb8FCsCJlZrg3PT+/Ew6Qgj3SYxDOP0nwcLYBBKE3yjCRFbY98zAQZNglFAoLpP+GyheiAxw9QeFvw=
X-Received: by 2002:a05:690c:6410:b0:6e5:bf26:578 with SMTP id
 00721157ae682-6e9d89620a9mr147408327b3.17.1730244522983; Tue, 29 Oct 2024
 16:28:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029232721.8442-1-rosenp@gmail.com>
In-Reply-To: <20241029232721.8442-1-rosenp@gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 29 Oct 2024 16:28:31 -0700
Message-ID: <CAKxU2N_-mck2uwh32Dsy7jKPJ2W5hWJCdNqF1CfFX86kT87KGw@mail.gmail.com>
Subject: Re: [PATCH] net: fjes: use ethtool string helpers
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 4:27=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> The latter is the preferred way to copy ethtool strings.
>
> Avoids manually incrementing the pointer.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  v2: remove p variable and reduce indentation
agh, forgot to put net-next and v2.
>  drivers/net/fjes/fjes_ethtool.c | 64 ++++++++++++---------------------
>  1 file changed, 23 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/net/fjes/fjes_ethtool.c b/drivers/net/fjes/fjes_etht=
ool.c
> index 19c99529566b..70c53f33d857 100644
> --- a/drivers/net/fjes/fjes_ethtool.c
> +++ b/drivers/net/fjes/fjes_ethtool.c
> @@ -87,49 +87,31 @@ static void fjes_get_strings(struct net_device *netde=
v,
>  {
>         struct fjes_adapter *adapter =3D netdev_priv(netdev);
>         struct fjes_hw *hw =3D &adapter->hw;
> -       u8 *p =3D data;
>         int i;
>
> -       switch (stringset) {
> -       case ETH_SS_STATS:
> -               for (i =3D 0; i < ARRAY_SIZE(fjes_gstrings_stats); i++) {
> -                       memcpy(p, fjes_gstrings_stats[i].stat_string,
> -                              ETH_GSTRING_LEN);
> -                       p +=3D ETH_GSTRING_LEN;
> -               }
> -               for (i =3D 0; i < hw->max_epid; i++) {
> -                       if (i =3D=3D hw->my_epid)
> -                               continue;
> -                       sprintf(p, "ep%u_com_regist_buf_exec", i);
> -                       p +=3D ETH_GSTRING_LEN;
> -                       sprintf(p, "ep%u_com_unregist_buf_exec", i);
> -                       p +=3D ETH_GSTRING_LEN;
> -                       sprintf(p, "ep%u_send_intr_rx", i);
> -                       p +=3D ETH_GSTRING_LEN;
> -                       sprintf(p, "ep%u_send_intr_unshare", i);
> -                       p +=3D ETH_GSTRING_LEN;
> -                       sprintf(p, "ep%u_send_intr_zoneupdate", i);
> -                       p +=3D ETH_GSTRING_LEN;
> -                       sprintf(p, "ep%u_recv_intr_rx", i);
> -                       p +=3D ETH_GSTRING_LEN;
> -                       sprintf(p, "ep%u_recv_intr_unshare", i);
> -                       p +=3D ETH_GSTRING_LEN;
> -                       sprintf(p, "ep%u_recv_intr_stop", i);
> -                       p +=3D ETH_GSTRING_LEN;
> -                       sprintf(p, "ep%u_recv_intr_zoneupdate", i);
> -                       p +=3D ETH_GSTRING_LEN;
> -                       sprintf(p, "ep%u_tx_buffer_full", i);
> -                       p +=3D ETH_GSTRING_LEN;
> -                       sprintf(p, "ep%u_tx_dropped_not_shared", i);
> -                       p +=3D ETH_GSTRING_LEN;
> -                       sprintf(p, "ep%u_tx_dropped_ver_mismatch", i);
> -                       p +=3D ETH_GSTRING_LEN;
> -                       sprintf(p, "ep%u_tx_dropped_buf_size_mismatch", i=
);
> -                       p +=3D ETH_GSTRING_LEN;
> -                       sprintf(p, "ep%u_tx_dropped_vlanid_mismatch", i);
> -                       p +=3D ETH_GSTRING_LEN;
> -               }
> -               break;
> +       if (stringset !=3D ETH_SS_STATS)
> +               return;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(fjes_gstrings_stats); i++)
> +               ethtool_puts(&data, fjes_gstrings_stats[i].stat_string);
> +
> +       for (i =3D 0; i < hw->max_epid; i++) {
> +               if (i =3D=3D hw->my_epid)
> +                       continue;
> +               ethtool_sprintf(&data, "ep%u_com_regist_buf_exec", i);
> +               ethtool_sprintf(&data, "ep%u_com_unregist_buf_exec", i);
> +               ethtool_sprintf(&data, "ep%u_send_intr_rx", i);
> +               ethtool_sprintf(&data, "ep%u_send_intr_unshare", i);
> +               ethtool_sprintf(&data, "ep%u_send_intr_zoneupdate", i);
> +               ethtool_sprintf(&data, "ep%u_recv_intr_rx", i);
> +               ethtool_sprintf(&data, "ep%u_recv_intr_unshare", i);
> +               ethtool_sprintf(&data, "ep%u_recv_intr_stop", i);
> +               ethtool_sprintf(&data, "ep%u_recv_intr_zoneupdate", i);
> +               ethtool_sprintf(&data, "ep%u_tx_buffer_full", i);
> +               ethtool_sprintf(&data, "ep%u_tx_dropped_not_shared", i);
> +               ethtool_sprintf(&data, "ep%u_tx_dropped_ver_mismatch", i)=
;
> +               ethtool_sprintf(&data, "ep%u_tx_dropped_buf_size_mismatch=
", i);
> +               ethtool_sprintf(&data, "ep%u_tx_dropped_vlanid_mismatch",=
 i);
>         }
>  }
>
> --
> 2.47.0
>

