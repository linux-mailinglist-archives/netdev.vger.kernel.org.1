Return-Path: <netdev+bounces-182432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3884A88B84
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2EEC7A49D7
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE92288CB1;
	Mon, 14 Apr 2025 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uOMHbypO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD824192D6B
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656130; cv=none; b=owoPOuDF9VJkSul+JL6fokqN4vPw1CvC0XfpTira0qqQXD5j/iaLd5qCnpoTAyUpQNQ20zy0gxSL2FufUfKU3IQRyhW1RAftqIJz5AIJNjzX9/cKCuN1ego/rfbLVRntw4g51/Esl9kDmizfMHKHR6TjWUTLupz0B+1iVbCWkoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656130; c=relaxed/simple;
	bh=jsFptswUmeSJtX6rTryRDrID87DOTelrBduenEncJL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYgJsOznLRd8UviFb930HP3ZhToJq5cyCI0750PjUE9CnjmBXi+aD8vGYI9Kn7aNrsN8hVeD7ZHbJ+oL/1qPEWCJpprZggFgfym3IcnUKdCl10YirKNKEheyUtF7s0TYFJAN+9sJpCfXZwKBLDAHDp2JYN4iU9RIy1/L065fwv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uOMHbypO; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47677b77725so49135111cf.3
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 11:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744656127; x=1745260927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVj63pLHPDOADttU5mk9xoBgxj6+KEfzLF7NO/zyIHU=;
        b=uOMHbypOAzjtg5SrSTosxoZXY8+EGqyI1UKtgfpbLsg5RlckaH5C6jY23Z44cG+0dN
         bCuJaB4xARojZ/h77WOmEWxSTYhFHVBXW4TuwE6QV7VoneTCJCvrTpLmrAc8z/0dLo/w
         lFNHqMh9bprTNVjwTJWm/IDHfeyeygPuKupSghbZ9lQKnu7wkVA46vJ9uo6cMWk2qVlf
         3cLTBgncMDBMtLBYG2wWdK5Oj9Bre5puSMEkf/27DWVEiFMAPznDcomd5j2EH803/V0z
         6apNiTygZtKsD55rNci8KcFU1ceOzsH4vhVk+VUk9toQ5k5EXrhY4XzsFapv4pG1RMj2
         m1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744656127; x=1745260927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVj63pLHPDOADttU5mk9xoBgxj6+KEfzLF7NO/zyIHU=;
        b=RsRY1t+VlnvN1Af6taSxne1JeH65OWdGj9+MgHFGcPOUHzIrqJ+9e6pOj2Dfz1t04C
         kuTCRb3kE3HNwmfsvxIBwx3i+d5mWavxwM5UuxhSNn8UF/q2krUv/HOspCZIyt/pofJI
         tEaZXpPnxsJezqYaPORw5ac57E2V1/tap753ca0JQIqyUrX87i3uFNroGz9CmkTdJtsh
         J2stRMeceq+iDWWbAwalXp+4EjZ1ZB+dNLyV800WDIr/77sPyUu/28RpAIEIaelDwZsU
         tumr+BFgOH7dxNsPEvrtQToaS7ia/tixORnx33A7Tsq5F6QQWrOx9Jliyw29sBfLyxuw
         4DZA==
X-Forwarded-Encrypted: i=1; AJvYcCWrqQFXbT/HO/5OzipLTjm292IEHL5CEaE1rJFjxkK6GEM4M3lOgTvMMiWwW857X43BvSbwKoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPloeRRv/dz9EQdksjh5gRFVozk0oKSgNiTtL9VhDt+fYEygNE
	4RFnU1U96svcHgGxbY2yEW2nSVJu7ch9oEtwjPjapBanOwuIgTc6Uibsb10rVpKqOlk5uv5W9yf
	8xPKSTC4aLHayeVZkjaHzpaIpIPNh+FdxNx3K
X-Gm-Gg: ASbGncsk0z7usew2fd83yZlg84xnP0hPao0gwj+0sev7rzq06t2HdEC6q7akI9zN7NU
	65rKilfxOUMxDtKbuQ9EhsqFA84GqqaqX05X7KWMZxDb20sDOJYtad9/P/20yI+6991+uJqTYRW
	Vq7nAAuOTW6zLBDudFW3zqQjigyyV/ynmsb4Np7QwqsZZM5zXAL73f
X-Google-Smtp-Source: AGHT+IEM2908mcWzVKMjpolQ0hIG1B9gw1c/6MnW5biuy6F3HJ9GSftRvzmu/S4TKHnQCd3lqvgWhDveMpG2O2LCLJQ=
X-Received: by 2002:a05:622a:250:b0:476:77ba:f7 with SMTP id
 d75a77b69052e-479775d5ac4mr205613591cf.34.1744656127177; Mon, 14 Apr 2025
 11:42:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414-double_hold_fix-v5-1-10e056324cde@narfation.org>
In-Reply-To: <20250414-double_hold_fix-v5-1-10e056324cde@narfation.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 14 Apr 2025 11:41:56 -0700
X-Gm-Features: ATxdqUF7AI_OOcycjc1SsjBq1YuDR9GVzjAZt9KIbXpqOALRRD2LjaN3l9RR8PI
Message-ID: <CANn89iJEFq4QeFDSq=-7NdPnqPgwMJDd5xvQ70YUEqHjNjdchw@mail.gmail.com>
Subject: Re: [PATCH net v5] batman-adv: Fix double-hold of meshif when getting enabled
To: Sven Eckelmann <sven@narfation.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+ff3aa851d46ab82953a3@syzkaller.appspotmail.com, 
	syzbot+4036165fc595a74b09b2@syzkaller.appspotmail.com, 
	syzbot+c35d73ce910d86c0026e@syzkaller.appspotmail.com, 
	syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com, 
	syzbot+f37372d86207b3bb2941@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 11:05=E2=80=AFAM Sven Eckelmann <sven@narfation.org=
> wrote:
>
> It was originally meant to replace the dev_hold with netdev_hold. But thi=
s
> was missed in batadv_hardif_enable_interface(). As result, there was an
> imbalance and a hang when trying to remove the mesh-interface with
> (previously) active hard-interfaces:
>
>   unregister_netdevice: waiting for batadv0 to become free. Usage count =
=3D 3
>
> Fixes: 00b35530811f ("batman-adv: adopt netdev_hold() / netdev_put()")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot+ff3aa851d46ab82953a3@syzkaller.appspotmail.com
> Reported-by: syzbot+4036165fc595a74b09b2@syzkaller.appspotmail.com
> Reported-by: syzbot+c35d73ce910d86c0026e@syzkaller.appspotmail.com
> Reported-by: syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com
> Reported-by: syzbot+f37372d86207b3bb2941@syzkaller.appspotmail.com
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

