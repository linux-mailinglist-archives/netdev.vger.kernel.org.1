Return-Path: <netdev+bounces-141379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 361119BA9A9
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 01:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6825F1C20964
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 00:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EEC382;
	Mon,  4 Nov 2024 00:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="affwlOq3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7175233CA;
	Mon,  4 Nov 2024 00:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730678613; cv=none; b=TKVBM+pCYvVaq0FG7/oB7kRINlZd7j0G76q/UjjrzoQC4pecgMnMv99jh6PU02hz3Ccljpc7D8/AhSDOYcYcIV4LKmbFxOke9K9tJYI+OQRbdqU2wa3C/JrG70iYitk64X/2+v5UORqgiZYv2pit0jTJVVEXFRlwi0Y2+xVNSbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730678613; c=relaxed/simple;
	bh=1NXrPw0SODl7sePR2wE4CNJacUIethlR4dgFoeZemZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IuCLGcYbvQiY96YKxl6culxN+Keazdi6ZktffdytJ43FCuMU68UQb+U7LwA8syma+Q5a3rWARWlPvWn4GxDgbHrXYfOIc4KRPoQMc0IMoALKecG6HqzmwkWUA4RVL2ijositYolw4hCyCqVbPZR27qSLkJAJ8ydOYEw50vYB9dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=affwlOq3; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ea0b25695dso28420617b3.2;
        Sun, 03 Nov 2024 16:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730678611; x=1731283411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHGHWTJaayo/7yRPk7cjYrZJChjKzFwfpoezlR3pISI=;
        b=affwlOq39KmhTFowndMIi9llKxS9zN8y3aQ8gufNVvAqaBm5eEVVz+YkMFX1JGYEA5
         Po5z/hLr2o+m7m4KGW7nAm/NB5nfaptTad2eCrBTFhVRRuD3fCcFsRhVed6aaY84/abd
         qZAITBstEzEukJ6RYbtdok0NttBoThSgZmk5VudPywSv8tzKY1L1uJx4X6JimqW6ofp9
         CGvii84HtGC4qipqKv/al6Si4tSSvwnRjvwMceTnmnGCV3Jws8swd9sUoFTPxbvB1lqV
         lrh7a/26pD8sp+wCsHAVEfBYiCQuHs62Yf9Vtca6v1wlXNwOTnoHm4RpnX6clEUWJ8Gj
         Zq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730678611; x=1731283411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHGHWTJaayo/7yRPk7cjYrZJChjKzFwfpoezlR3pISI=;
        b=eUKj/7kZ2DS4RKjmhOKcPTXfblhqphVAWubhnhlKX3gaCjSIy2nXinTi2QmCyi3FQE
         5rzd3AD/ykUR8HJ8qFhPDdNmx8Uufj+t1vlg0/xaO/n7U9mud2ItM1ys1ebDgPNNrBJf
         eYzqK0CXvNaM5btJOB6BlwxDOTL95L5lrWK0B5lsWJumbjsyVtLKCxHiHboZDi5EX5Qt
         8kFwy8Jmv6eIFyQg6Jbr5oujx6TfGziaY6Tnn1E2tFrtBN7eQntZMNOJi8TOw7rtGcRB
         yOuFga37CLU482aTzG38MNjCn4NucqvYPUsKaTqWvH8Gexz9gewB1pOxRdjR8Hlse5YS
         IWGg==
X-Forwarded-Encrypted: i=1; AJvYcCWXxp8W0Y9HNman/x6daOeZZThF8faTS5fxRb+qWuYaAV4Ig/u5FzyvHd8Q+sAiNO5ufCe+kIpwiCB/EYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0i4MeTpJeI+QxgJUJ+hbZFQj71Rjbams/G7bgCkYctnLx4trH
	fHXH/H85I+WcUzVkFn13pzbKW2BRuMdO6A8wB6KkMl1/UxRcoJ1EsDMV0Z/3is0AzW/eGtL7vAi
	cy+4RwL7BpzXtalK7SHrM+vx7vnE=
X-Google-Smtp-Source: AGHT+IHI/uC2SIajtfVDHDEuyGn4Pu6tKYDWiqLpCzyPJwKN5AXO8qH4pk4DwZiZzCeHBF7vx/dARxgdcI2RteomWRo=
X-Received: by 2002:a05:690c:23c2:b0:6e3:420f:a2d1 with SMTP id
 00721157ae682-6e9d899d91dmr342478277b3.23.1730678611357; Sun, 03 Nov 2024
 16:03:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030205147.7442-1-rosenp@gmail.com> <20241103135958.28eba405@kernel.org>
In-Reply-To: <20241103135958.28eba405@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 3 Nov 2024 16:03:20 -0800
Message-ID: <CAKxU2N8bO4j-2++NH-4Ju4aXgSWXcdSJ9EDfUo=U-hxVF+AXvQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: bnx2x: use ethtool string helpers
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Sudarsana Kalluru <skalluru@marvell.com>, 
	Manish Chopra <manishc@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 3, 2024 at 2:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 30 Oct 2024 13:51:47 -0700 Rosen Penev wrote:
> > @@ -3220,13 +3212,13 @@ static void bnx2x_get_strings(struct net_device=
 *dev, u32 stringset, u8 *buf)
> >                       start =3D 0;
> >               else
> >                       start =3D 4;
> > -             memcpy(buf, bnx2x_tests_str_arr + start,
> > -                    ETH_GSTRING_LEN * BNX2X_NUM_TESTS(bp));
> > +             for (i =3D start; i < BNX2X_NUM_TESTS_SF; i++)
> > +                     ethtool_puts(&buf, bnx2x_tests_str_arr[i]);
>
> There are three cases - MF, SF and VF.
> You seem to have covered SF and MF, but not VF.
#define BNX2X_NUM_TESTS_SF              7
#define BNX2X_NUM_TESTS_MF              3
#define BNX2X_NUM_TESTS(bp)             (IS_MF(bp) ? BNX2X_NUM_TESTS_MF : \
                                             IS_VF(bp) ? 0 : BNX2X_NUM_TEST=
S_SF)

VF is SF.
> --
> pw-bot: cr

