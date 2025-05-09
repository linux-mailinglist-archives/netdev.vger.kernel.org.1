Return-Path: <netdev+bounces-189414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E32AB2063
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 01:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FEEA3A3EF4
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 23:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9449226561C;
	Fri,  9 May 2025 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VjjqPrn6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231982206BA
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 23:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746834937; cv=none; b=dLspmlgsuQyy6x2XWGMAA8o2b0GGheTmIfkUolEmzwR/Rn3DHV/wenr7xQSd5ClLlz/WwJRXQj2JwSxgWnMPp4B7IWboIHpsncEQhKNyrSmC8XU6AKBGDIMiTlMUDzdIq0UgIr8Ss8iXf5CCDa/sEvJVg0iaHV7NXKQk6qszHLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746834937; c=relaxed/simple;
	bh=b9EC9y4Ydtk74XkAF9WmW4clVYTGxt509RKq0ihmH+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdMPEDBmcTciLTj752j3wwElnbBa5r/xTrpEUdc1oN+lLv7Yam3+Tqh1mAUsL1+nvIMx6LFpD8UVXlyKT77FdncIQDIRy1pBLC6aj0WFPu+Y88Lys2dip7brGMQx4EToBf5jg1Ln0cjK8+ZK0l4ys4g+CA6wOI07/06suaDWqBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VjjqPrn6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22e42641d7cso81025ad.0
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 16:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746834935; x=1747439735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HO3nuisWZQHBy7YiqP2KuG7ltFXccis89MiERMuD2Uo=;
        b=VjjqPrn6ouuaaJRpk2qHT2oijw62PHem2TOGNmlugh/mKUFtuOeluMY5L9slEIwpIx
         UEOSWs6H7sywg9VyNrWw+82TJPfc3lquOZ03MSDqphwUdKXlhXDzLCcTAoVHnp6LvwnK
         YYa35m9aFe839kQIicMALWiouLVj2NmUlDSeYjJ9sGrC1OmfFk5g8j91gxENqecBW8dg
         S/NH7XKP3YZ8GjnUcJ/C0TNLl8/Swo21UwMZcWwA/+g6YT+9iIhuyqEdVqG/m6j3msnV
         Kxy3lU02j4p5XyeZ/mpiNeuh6qIMbKZU4dff36XUFjLvypIDuhK0yS3gWFUaLYcanuTM
         E5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746834935; x=1747439735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HO3nuisWZQHBy7YiqP2KuG7ltFXccis89MiERMuD2Uo=;
        b=LHpxOnIBbhJoCml0v6O5RWkrt8RYiOhVx1QzuNgzFCD2Q/o4/hKl07sGtQFNFzY/Ir
         xHP0cZ9XRuDv9PFQylFQoEufUwzJC+GQTVUBGw1lqyLbyQMR1GaTtLatMGkLVPpBT3Oq
         6ITcVs0a3GhIGu/OkKJUOnGSjLko2sMNIGIZcERq2zAYR2wK1WOz1mSB8+MqmLpBEuJ3
         1OWzavAudLNYJY/Z41s6NRQJ1SEQPrvJWUshCCVxTtH+Ip4dJqfBMrFehE+xqgswbUR5
         Tu75BtKMTlDZRnGEqZLCorlmCOdXW42K5GSrgz2lowc8FJLmauI9ycbcXZ8pinPosrmV
         R1Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXqL4r7moJWq8nsw2WtTiywObaRLRHnmAO6omXnqKggrjiMr7J+ABw6+ha/kV8BQol+fT18Orw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsvufHO0CpaI0wK2S1mas6GlOhspCBvR5KgsWb8pcbJNvqkYz0
	Oi5ioTPG+cZukvct8oMe6/4DyUuEqEQbMz5+w8UlJHS5lue3F2xWlBnCUMO7LxvH8y3rwdZ6fjk
	7ztTvyC2w2BS8kxvHCSIbdu6UGjgJ50xVqrAD
X-Gm-Gg: ASbGncuFkaNCGAw51kDUEcwsKRMG+XoKNS9ZZWFZD2y1I0ixL/PxbeMx8RfTX0Dq7VG
	D0JeIafASSbFC3kL8Aa7cC4CTgPXbgjvuWM3j60W2220RrcOgW0Nt8hALEhxnlY1/5FsE6Q/hh+
	Z6eNJcwMmiJTSP5jI0RBAYQ5u/reL8ZnJ4sZO/0lwEJEmgFSpiS784e7YuBx92V5I=
X-Google-Smtp-Source: AGHT+IFA9cC8M5NUEzFILPp+DCxD7m83b25KWct1sl9HAc5/ms3eI12hTafZBdAB4KDJqYZoZ/ZgENYyEp1uT0HweYU=
X-Received: by 2002:a17:902:fc4d:b0:22c:33b4:c2ed with SMTP id
 d9443c01a7336-22fefe48ad4mr1088755ad.26.1746834935054; Fri, 09 May 2025
 16:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509160055.261803-1-ap420073@gmail.com> <CAHS8izNgKzusVLynOpWLF_KqmjgGsE8ey_SFMF4zVU66F5gt5w@mail.gmail.com>
 <20250509153252.76f08c14@kernel.org>
In-Reply-To: <20250509153252.76f08c14@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 9 May 2025 16:55:21 -0700
X-Gm-Features: ATxdqUF_73NDlRvrrRYvrnt4Pusv3GIYFPxYwbE-nOTZ8dBkAO5kJjgTo9AMrxg
Message-ID: <CAHS8izM9xtKMqaeMsm1LyadVuTL2REQ=ZvWaxEoJYCPuMApd4w@mail.gmail.com>
Subject: Re: [PATCH net v3] net: devmem: fix kernel panic when netlink socket
 close after module unload
To: Jakub Kicinski <kuba@kernel.org>
Cc: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, horms@kernel.org, sdf@fomichev.me, 
	netdev@vger.kernel.org, asml.silence@gmail.com, dw@davidwei.uk, 
	skhawaja@google.com, kaiyuanz@google.com, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 3:32=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
> > Other than that, I could not find issues. I checked lock ordering. The
> > lock hierarchy is:
> >
> > priv->lock
> >   binding->lock
> >     netdev_lock(dev)
>
> Did you mean:
>
>   priv->lock
>     netdev_lock(dev)
>       binding->lock

Yep, that's it, sorry. I mixed up what netdev_hold and netdev_lock do
on the first read :(

--=20
Thanks,
Mina

