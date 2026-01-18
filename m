Return-Path: <netdev+bounces-250918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84123D39960
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 20:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74D723004D1A
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 19:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A34E275B05;
	Sun, 18 Jan 2026 19:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZ5WgrQh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77A52222B7
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768764322; cv=pass; b=s8N4VUA12WxuZh6e4QiFsphuIQY+kmpTxCcCT5CnvCeDBiD3iK1vRF1zKWCFy1HSgxPum5b/PchTPPZhVCv+rhwN9mQ3pMvdSoOfFIOhCpNUhDYHxDgLmyMIib+XyGob6st0ScaOipWLiZ+98Kjj1tqyTjZpx7ZKBDW0B78i/hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768764322; c=relaxed/simple;
	bh=WhD/UumB13TxrhUCW41ZL1h+RYsVEF75G29LEngcAxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtquxSRkS8xBAV7y/UFHH5QykZwyK3i4A8g93xmSBxAuTAKPH/ZBKSZ8Z9PkIg8OOUlmOzfeqg8S7WBc4MPN5nEgt97ZGRm9UjcOatCRe7btVQsyrIkj0BtpUEcm754+x7t3Y+yXQ30qGtugDpkuyvY83AblcXh0PxiW5R8I054=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZ5WgrQh; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-65d096dd0ceso824385eaf.3
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 11:25:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768764320; cv=none;
        d=google.com; s=arc-20240605;
        b=IWNh6htF4JXLkE/cph1VKq+I38XuWmR936sclRivVlIv3uMosCNSS2kdgHX///4l4l
         QGs9m1Ue7CGJWg7XUGWsrmcXoAVjy35ECi7wVwG3HSnwOpCrH5YC3J36RUUxQ76Bhu7A
         Fk584rz27Rx4PuuZY4u9qUPUHEatz/me5TOECw/MY9yAZDtU02Tjw1Z9sBQiFqE6PHTM
         y9LseSrLE9DTEiFLmwW2d+hr93yFVEwGnfEaMYojuZWMFmf6Iju4i580r521UrHJLWNB
         pALnN30erELI6NKH9pO+LopgKt4PDnJ8JpS+sD7bQC71FE/iN+DEjEgL9nqfTJaPdZ4E
         WRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QODdiHLpLICiLOPXx9zlScC1nqZ34S9VHP1dAsw4ohA=;
        fh=1ffhz1LCn+XjckKwJV4d58j3PNJFvGXtZYChy/J7jCo=;
        b=DdAtCNZo19GLhf4L1EPizER1A+fabGNipDRnnPcb3PjNYmBzemEjyYCcxJwakgSXil
         MOiNPwY/pRvO2qMYa3wbOl/4JpCOB8MIeVODNVT6gC8VSnfi/bS9tGJvjDp6kKnX3uR6
         4+vJ4aP6GOFjhuatRXfz+X033gO/XbYq5tfz0+xm5xpiO8S5J6YiFhFDt/NQ/BcBUBWA
         pBfmVDduBmFMpc7ioifHN1Zl0kUMHzV7FpLdCCr3aoBt4wKjPHl4Lqm+FWhB7kOuHXmG
         zA6G2w2eRQIYVHYSdJh8z4WXM0IEnU7Ul0ZcY1RTZbJQcs3NFP1Qcr3FK94yY1XJZYDj
         D1pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768764320; x=1769369120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QODdiHLpLICiLOPXx9zlScC1nqZ34S9VHP1dAsw4ohA=;
        b=mZ5WgrQhplhabYRAgtd6bsOdimY8OJi1Y+h43dZjPS/tkL0FJiYOi65sk+dlJ83BkM
         rOHfxnPVPdlG+yQgpfyw+QAESJ9nWYqjyAYKZxUv/pCZfeDwJM7xlHwD3TS9m8LzXfFi
         P6ECA66sOYKJQNJZUPckPtUA26WVBaVT0kO0QHKdQSwrZ+e6XHm7gLwbps3zKB5f7MhB
         WxfC3KtN1tqu4STWv+hW9GTZj9pCWck24DSETQyTY0uO99AiJr+MAkncTC30FC357VUe
         mEDu/ra64LE+VkfYZYHtHcxB31nuBAapxY5ICCyMRvIdGnml2pgj/oVnDd7pPq4j4ltq
         1p6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768764320; x=1769369120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QODdiHLpLICiLOPXx9zlScC1nqZ34S9VHP1dAsw4ohA=;
        b=H/sWQr4fftvUkmS5yjssdB+NxXiKGEfrxvsN+sXbr62C48KdWMOVdJCgB2Rp60QU7w
         Xpu4rzkX6QpZT0BLzjpjMaMZ5w2t+Y8Yc21nNH5L3Wp0JJikpVHqAOii/RnU7SfqwtoB
         k7WLX1daQTAo8nD9uns98JWNWBiKpHWdpeAEWbzctHFMHBCRVzcPkql7QEXy5xZ4DPyr
         jhjo9SRDu0RVwmznAlOVVZeM0JN/7vUV+20eXyZZu+frNzgddbHf9q1ShBJqJFHqysrY
         PvsSGvdfEbwi/Hm+VuYLZsBLUbc6pfQgybthHI2Y93Z9loBBeIcotWmI3u44XCbMjB2y
         sUtQ==
X-Gm-Message-State: AOJu0YzhmiVC/hmlY9dsAOmeX5W38wHoQmvpmqSp/QDC/DuEzHDulyEF
	nByRUy5zA4iylWbfwJ0k9Jb3qXSWM207YtxZCZP9wWm2P5LiTwI8a3LTCrAvBhaGVzPTu0gFxpL
	6XwKarc3j+0OX5pjQ0hsi7WyxDLuwBBg=
X-Gm-Gg: AY/fxX6P98Abu8pvlIHKsYVZvcbpcOKzJqPWrQVeBSXtMJxrzy1//xxbF1Ke/JQ78GO
	d4C2HUiXYSVanVc8tNFYniAHeXlNlYuxXFs0JdZu3JMf4zTPbp/76Pu16klPFqNTZlm54Smz2qe
	3rhEuToP5Qfzea0E8bhsORQM88BK2RApQKLtzvOoC8fnFgodn3xj3wzCo97HhmRmQMEC77nq6l4
	a99IsMWj3ArC2Mi25PXHtHLlkV1s6YeiDnlXx/BrsCUsLFsfYiDSdJz53q8w2IQL2pKnsHnmfh6
	Atu5XMxBvKHjMzMA/vlMz/rLPMyDdKtSodyw6mLKjY+Kxu6fyLgZgiWigd7J
X-Received: by 2002:a05:6820:210e:b0:659:890b:3f9 with SMTP id
 006d021491bc7-661188d5ca0mr3708668eaf.4.1768764319929; Sun, 18 Jan 2026
 11:25:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118013019.1078847-1-mmyangfl@gmail.com> <20260118013019.1078847-3-mmyangfl@gmail.com>
 <5afaff9c-7be2-4464-b675-4bf70aaa17af@lunn.ch>
In-Reply-To: <5afaff9c-7be2-4464-b675-4bf70aaa17af@lunn.ch>
From: Yangfl <mmyangfl@gmail.com>
Date: Mon, 19 Jan 2026 03:24:44 +0800
X-Gm-Features: AZwV_QhoqgBmX5NTPwohLzXhrsUytNlbMgVaPz08WmDZqV1yMSPtGz_cJzAPlJw
Message-ID: <CAAXyoMPFDRyKqZiFsH7cCQzBg6z5KO5mUpLf8jjpCcQhD09-zw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 2/3] net: dsa: yt921x: Return early for failed
 MIB read
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 12:06=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Sun, Jan 18, 2026 at 09:30:15AM +0800, David Yang wrote:
> > This patch does not change anything effectively, but serves as a
> > prerequisite for another patch.
> >
> > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > ---
> >  drivers/net/dsa/yt921x.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
> > index 5e4e8093ba16..fe08385445d2 100644
> > --- a/drivers/net/dsa/yt921x.c
> > +++ b/drivers/net/dsa/yt921x.c
> > @@ -707,6 +707,12 @@ static int yt921x_read_mib(struct yt921x_priv *pri=
v, int port)
> >               WRITE_ONCE(*valp, val);
> >       }
> >
> > +     if (res) {
> > +             dev_err(dev, "Failed to %s port %d: %i\n", "read stats fo=
r",
> > +                     port, res);
> > +             return res;
> > +     }
>
> I know you are just moving code around, so i can understand a straight
> cut/paste.
>
> However, when i look at the code, what is the point of %s and the
> constant "read stats for"?
>
>         Andrew

The error format is used many times across the file, so using the same
string helps reduce the data size a bit.

