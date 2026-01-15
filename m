Return-Path: <netdev+bounces-250280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38621D2696C
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 18:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B172330D2DAC
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16AD3B8BB3;
	Thu, 15 Jan 2026 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SiFO8Oqk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A1B3C1960
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498322; cv=none; b=nYCXYVYpNoStYde9vHuM98x2vngfYGQtX3vkpWub3j4rSriGU0A51fkXuYy6GHlB5Hu6BlKw0bjIdE033m/nQK7Wjw0xFzlFo7njemwuJwBLYgG/U00TzP7uDIfPaWAOMz+IoGyEZbnMa4yD5Uejevn502kuXuE6zwYma9rlcWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498322; c=relaxed/simple;
	bh=qCMPW6pULK4f84DzikOlUeGRCm63LsLWJeg9OJIDLk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TjwKOMC63q+yYnAjC+uTDv2Ln9Adbq1Jdah6lvxnIIOmjPekr/vrrrYZXa1Dfscp8yKNEVuAcUTYPX4g7cdmXfXJMX/S/QdxgWwABqp03J4UDuBmEqJofbvdkSBGU+O2TXEWuRPjqNjNvrEqOD74tJSbdb7xCr7EWPQPRgYFpvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SiFO8Oqk; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ee14ba3d9cso12968311cf.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768498320; x=1769103120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkU90S/s6g3/rG1Z6+KKHH/+8SxvEgYiHc5OOm8OZqE=;
        b=SiFO8OqkeKWQZBa5oYBnkgNLlVWc0yH6APfIER4dEhWWk5y++o7RQAAxtfB/nmXo+F
         974ZeQxkgttJB/F6uMVPR3V6G83aHubi7BMV1M2NflPNIkrXADU8laOUSHdyAZYZ61g/
         8JFNO7Unv7keETDleYlG4klJ6zJYD5lILfzLj0Ano6Kyb6EUa8s/wSyvf0UmVHhD84dn
         1mnSHfpIKlBneIuaWNlzFqvF/qv2kBLvag1aTHZiRgn2uIVjgr1SKwZi8mIBddPHE0Ze
         VHiW4GnODmtv6uVJ3Cy9QurbVXT/OwHsCXC3cmbg0ItivwgIyGartTFJoWJgOm7hu8kK
         b/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768498320; x=1769103120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XkU90S/s6g3/rG1Z6+KKHH/+8SxvEgYiHc5OOm8OZqE=;
        b=WlnHNemtp7y6Ys7wXi2JfluDxpzyfZxpfGsCga8ZlEEEN+j6e+memW2qjWgaz86bEh
         Z9ZlSiBo3oRvNtxSYXrVpE0coWuJ4haB+USBapGbvtCXou2/mYAqedUeHJFsjN6Q8tSB
         i3tSPA7nV1UE784fgvy19rKyOH6rJgiKdZ06lP93ZIGCTNluKjrrVSk4pPcrRT0DSLxW
         nYrI88JcG/2W9kIYOv/8KnBmo4KkWvN49B5oE+a19+bh60fSV9stqj6zZwvm4iOt0Zww
         sbKksBdFb9DBUFl//TDEgSgWWGyW+vmJ7GQvVBK4Mr/z9GJqnz7K7h5ovkS4i/qn1Mkl
         8F8w==
X-Forwarded-Encrypted: i=1; AJvYcCVQavuc1/QqymIkUywCNeY9tJtQ/9u39urw8kEuUqH68RZ81DbZgOPeECopzw5LF2h840ihQ+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjKzjpTJ0/4XbdCfwydA4Szd2OchODzw2J5QNU4EVLthmsCWBg
	/PQude/FJD8es/I7rBJhI4W+j+9gdpEArZj3GUmSNEDYwoFY3RmKcKJ17oVoKSo+Ildzm6AZgyD
	ACPnUxcCYu7on2qTVCQyn+m8lfXDoAsNumBo2yLb0
X-Gm-Gg: AY/fxX78Ahpm63Y1SimYhBgiNAZmlSvFpGuZhsL4NBcdv1Mnrwzh7gs0q93iz+lDPBN
	vz+6fMcdEupEZAuXf229O/j8ad/3r0RfAUqIa/Pahg8owzt7G1reHgApV4UOHI9oOkqrtajlrAK
	6JLdpP7oYOJOf1Gi4GkUUXQNxIt8MH8yfc7ADcFYFjVso3L09VyhahGa4ubq7fCYP0TaJc2wx5d
	bM8zrVPLhAMV0VTJ3c5OAO09wc1oOqNCFXqUrbfGu01uTlL6ILYSh+IknDFRnL3mOfFfDc=
X-Received: by 2002:ac8:7f54:0:b0:4e2:ea31:1a with SMTP id d75a77b69052e-502a179b851mr3328331cf.68.1768498319999;
 Thu, 15 Jan 2026 09:31:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115172533.693652-1-kuniyu@google.com> <20260115172533.693652-3-kuniyu@google.com>
In-Reply-To: <20260115172533.693652-3-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 15 Jan 2026 18:31:48 +0100
X-Gm-Features: AZwV_Qgx8HtZQ9JqEu88DaP5IDSZY1WZRDJ6pFW0y8Bust9yhEvNBbkFKezLXpU
Message-ID: <CANn89iJd1CjvLVP+1i07B7ygOgOFicQpH3AB6C3arsyHF9sNBQ@mail.gmail.com>
Subject: Re: [PATCH v2 net 2/3] tools: ynl: Specify --no-line-number in ynl-regen.sh.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 6:25=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> If grep.lineNumber is enabled in .gitconfig,
>
>   [grep]
>   lineNumber =3D true
>
> ynl-regen.sh fails with the following error:
>
>   $ ./tools/net/ynl/ynl-regen.sh -f
>   ...
>   ynl_gen_c.py: error: argument --mode: invalid choice: '4:' (choose from=
 user, kernel, uapi)
>         GEN 4:  net/ipv4/fou_nl.c
>
> Let's specify --no-line-number explicitly.

Reviewed-by: Eric Dumazet <edumazet@google.com>

