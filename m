Return-Path: <netdev+bounces-150717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9BB9EB3D8
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96DD81881347
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349561A01D4;
	Tue, 10 Dec 2024 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b="VFTPkYYW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6947878F38
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842050; cv=none; b=sQIwax6rkG9Wyxn1eK5Z9rRWkg5+xgfeDJ1HmSClKWeyWJIixHxlDqR+BfEqjPoHoLzbcUQOXY3QA2tC4RXAXYZxjwGw7izbmOSL/6n/qpJRLMSlhk/AHtBgF4q7Jy29vvtuvRZRFlc9eHpuwoIqt1cqM1tafm4+jdLbw4uEbpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842050; c=relaxed/simple;
	bh=fnM7XdZPmq4dQ8q57DyE5z4e346R3Iv66K4+vOj/nSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VahlkUPjpttRbxXtgd1l+SOkfTi9kJAQkxQj6A5DtggDUEDcIuKceHSNOhNCXGV4XxqbbRLvtFw3p3ZdovIfA16O4D6VaakFUK2OPnoj4YFgA/6EhkvjESicjsEfvwtgzIr3Mp+mIfVFgWeZevp48WPtj8x5ObfWsv/1eE14Ny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de; spf=none smtp.mailfrom=bisdn.de; dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b=VFTPkYYW; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bisdn.de
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46769caf994so1121911cf.0
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 06:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn-de.20230601.gappssmtp.com; s=20230601; t=1733842047; x=1734446847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rzs1DO8cqSom2w5LB1plSfwZm2SKsh6MLmfHHtdFuyU=;
        b=VFTPkYYWezuuze83ttZ5iiTb4aXwTZCJ+7Gm8AZ/UcEDkqu3udqenCAhgJHdWy084Q
         3cllSCvujBtiCqPtQXKKxdp1aQ1vnsWW+0ozQlDewywSJ+wK0NIrqropyuBB/F9ykCE9
         oMunlkOl9NA8kTNvp8jWBguBdXYdxIDl78Kl5526VdJrnfF+C80J/rISX2uzud8WVrfL
         vqKDu4EmxXD7t9Q8rmuXwgf9+4639e+YZOizwdx7hT0kO37uOtC7mrtRyIEytGxlP4Vw
         RD4STEdN7ACZoQP/7AQrEXfwZsfjtWueGYgqWXlTbEF9qL8yFYo6OgdkGCMcCx2Iwmqv
         qWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733842047; x=1734446847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rzs1DO8cqSom2w5LB1plSfwZm2SKsh6MLmfHHtdFuyU=;
        b=JKI7fx1qkS9+nIRRtkcT6Zr9gtJDtGkLyH2tVy8gSc1PZaVimwMhOIvtHd+AVY7jfk
         +TDBqMhAcok7simBcQdAznLHdtiHd9yh4B62xsUJpbh5ANG7tLkuwQzHI32Fwpu08izn
         C16QwvJDYWynrv5W8HOQBk9Y8/pYyIC/T2B8d9aHE3PaVBDDpDcUJFpjumExGJAeI0PE
         QeVAZ0PjE+3PfUey7b7flia+SMTpMBW6RBMQD98qMX2A7GaQ4OO39HzQ1su+l6joV1MG
         7CxAvRhQ3rRuHerpAk4cBdYE05i4peETQfLTwEDsnMF3BFKBsGwcxc+x/uyrqjB1jlQt
         VuSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWhX3vimfrJCgXqqY3r6OT46iNTkz/slWzPKVs1P2JNE0kEyF8GKxDjuJOwduPlvL09wOwdiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5tLnfmKmIvznUNGvml423MgFPqJRSLOPjB+FAEMrfTsmXPN3g
	gxq/wmEfu9WZIIF5C62UqSeKt1M+w6ajYQcD6rd1q+VzCIfIRybW8zNv2RaIcguAV4woZTAe+MA
	hShEKkSxeq6Y+4r2JyeUfGOUmiRwpu2J05TzTHwc2xZVFAWVsQ7QbUkKFoBHj1z4w0K4+R0u9x4
	28pmwCMbMZdNV/B8HJHw3MPw==
X-Gm-Gg: ASbGncsfiaMKdprVPscC6Ou1gvGCUMtJjyaB+EDh+2F6dlBl14VDqcy2xLfE3oRfz15
	sCynaCptbqIfMJePhZY777qd7HH7pi7YGIg==
X-Google-Smtp-Source: AGHT+IGsh2nFo1NsXdN/9EcCCJOyiewT7PU4OIYHkIeQY6kKt2wkQpzsETMHpFlZJixwWx1bhe0I8N/7iUts9Fm2jEI=
X-Received: by 2002:a05:622a:110e:b0:461:6599:b9a with SMTP id
 d75a77b69052e-467746ad834mr24853361cf.11.1733842047128; Tue, 10 Dec 2024
 06:47:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210140654.108998-1-jonas.gorski@bisdn.de> <20241210143438.sw4bytcsk46cwqlf@skbuf>
In-Reply-To: <20241210143438.sw4bytcsk46cwqlf@skbuf>
From: Jonas Gorski <jonas.gorski@bisdn.de>
Date: Tue, 10 Dec 2024 15:47:11 +0100
Message-ID: <CAJpXRYTGbrM1rK8WVkLERf5B_zdt20Zf+MB67O5M0BT0iJ+piw@mail.gmail.com>
Subject: Re: [PATCH RFC] net: bridge: handle ports in locked mode for ll learning
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Hans Schultz <schultz.hans@gmail.com>, 
	"Hans J. Schultz" <netdev@kapio-technology.com>, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Di., 10. Dez. 2024 um 15:34 Uhr schrieb Vladimir Oltean
<vladimir.oltean@nxp.com>:
>
> On Tue, Dec 10, 2024 at 03:06:53PM +0100, Jonas Gorski wrote:
> >
> > When support for locked ports was added with commit a21d9a670d81 ("net:
> > bridge: Add support for bridge port in locked mode"), learning is
> > inhibited when the port is locked in br_handle_frame_finish().
> >
> > It was later extended in commit a35ec8e38cdd ("bridge: Add MAC
> > Authentication Bypass (MAB) support") where optionally learning is done
> > with locked entries.
> >
> > Unfortunately both missed that learning may also happen on frames to
> > link local addresses (01:80:c2:00:00:0X) in br_handle_frame(), which
> > will call __br_handle_local_finish(), which may update the fdb unless
> > (ll) learning is disabled as well.
> >
> > This can be easily observed by e.g. EAPOL frames to 01:80:c2:00:00:03 o=
n
> > a port causing the source mac to be learned, which is then forwarded
> > normally, essentially bypassing any authentication.
> >
> > Fix this by moving the BR_PORT_LOCKED handling into its own function,
> > and call it from both places.
> >
> > Fixes: a21d9a670d81 ("net: bridge: Add support for bridge port in locke=
d mode")
> > Fixes: a35ec8e38cdd ("bridge: Add MAC Authentication Bypass (MAB) suppo=
rt")
> > Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
> > ---
> > Sent as RFC since I'm not 100% sure this is the right way to fix.
>
> It was decided that this is expected behavior.
> https://man7.org/linux/man-pages/man8/bridge.8.html
>        locked on or locked off
>               Controls whether a port is locked or not. When locked,
>               non-link-local frames received through the port are
>               dropped unless an FDB entry with the MAC source address
>               points to the port. The common use case is IEEE 802.1X
>               where hosts can authenticate themselves by exchanging
>               EAPOL frames with an authenticator. After authentication
>               is complete, the user space control plane can install a
>               matching FDB entry to allow traffic from the host to be
>               forwarded by the bridge. When learning is enabled on a
>                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>               locked port, the no_linklocal_learn bridge option needs to
>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>               be on to prevent the bridge from learning from received
>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>               EAPOL frames. By default this flag is off.
>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Huh, indeed. Unexpected decision, didn't think that this was
intentional. I wonder what the use case for that is.

Ah well, then disregard my patch.

Best Regards,
Jonas

--=20
BISDN GmbH
K=C3=B6rnerstra=C3=9Fe 7-10
10785 Berlin
Germany


Phone:=20
+49-30-6108-1-6100


Managing Directors:=C2=A0
Dr.-Ing. Hagen Woesner, Andreas=20
K=C3=B6psel


Commercial register:=C2=A0
Amtsgericht Berlin-Charlottenburg HRB 141569=20
B
VAT ID No:=C2=A0DE283257294


