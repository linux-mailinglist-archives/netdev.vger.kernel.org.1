Return-Path: <netdev+bounces-171187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32389A4BCCF
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 11:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7A91894062
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DA41F463D;
	Mon,  3 Mar 2025 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNwocjY0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1FE1F4627
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998800; cv=none; b=gjAW797jzLRlfIYpy8zBTCLd4Tyon58k/7QiQ4DshsKGrnRcjUn7Tge73dXutq1uEUngDGLs/4GBZYU5FykykpRFaToHvPkalRrSI4/u90+Kd9eC+tV/Y6Zk/sv5y05qu3HfEmWRyaLltne2TnAET7abFHSWIvYC/R0wu7+oojQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998800; c=relaxed/simple;
	bh=bu2JmxhNeXfjCJ4TZ9t6ISsrfS5n+OYjGHAfr+AhE/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtoaYPMfwUXhaGWHr2lLCNHgtJ6T4rBQQxpkVohoHo/E66hGpWN/zLvu82+atIciScDGKAP0qqJm9XGlcYMrnYumBDLOF4tAYrBQopEyaMG9+XfJV+92OQ7OJi21UqWScnPaLzuaEy+nqFcPUmSy9eL2ic2HuaA2ZMuvaeN2MMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNwocjY0; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d04932a36cso45438775ab.1
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 02:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740998797; x=1741603597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bu2JmxhNeXfjCJ4TZ9t6ISsrfS5n+OYjGHAfr+AhE/o=;
        b=jNwocjY07IMyl38xG6eUxUYlwxSYuMcxvFdgqc+ylqI6nnK68I3ogX3pTKVsoG6ftK
         +2pxuVGRR4CMPgKUkS9cwCuPDzFqsyqis3NzFsE1ZfeOXY0HCK8O1EpcKw/ZbxnTRwvJ
         YVRr77b0hfod/9A6QYgKbmrz7YRcvba5spkMkEFs7iADyiFVOE86PklHlfGqdTBNoPzn
         wX2+ywsctRm87df52QSMkF8VSDazBW5xAYIOj5xV004Q4RbRGFoomuvG9T22PnpRbtyk
         s98geC4M6VtXnfBlhfkQkAQgsAr5Bw4b5E9yjB+47+OluVvQD0EhxNQobj+NmqkJpLoM
         31WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740998797; x=1741603597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bu2JmxhNeXfjCJ4TZ9t6ISsrfS5n+OYjGHAfr+AhE/o=;
        b=ejVw2lYZ8gGtY5H3ev1YMSGbWmg3HOrIumYGVTVwjwvT5bO1vxyLIXHKfJXVo1+aNY
         YX0a8EQT6GA9vyW3Fkcb1YezgFH2+MYnIs/xfaRqKQHRgF+f+BCmX7eyztZUIun4ZR7r
         TJiEmGGE5SWiXN9eSf6SnUa3a9d7PfTI3UyPPoA5w/otfQXOh6QfSOrI/NcDCYHDPCkc
         BNcJxEjrbV/9LW/9cSrSMaXnA0EKx49Z9rK3H5nNLFyEt8JSKvheSWt77z4hQbWfzL2b
         0grGZ0saZmRmTx6lJoeTm3Kuky6GdM9XXTNw4QWS5NFa7ermdO7gLWo4iz2XNWND2Uyg
         9TGw==
X-Forwarded-Encrypted: i=1; AJvYcCUcIaWqukAR193u8u/IJLfYb/WZMLB8lj5X+Q6sHm4oItioiwq3a6PTOAQBWtGG1PiqB8y8Kgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfblu3PqYuMEMgL38aLzLJhBwxlkEOFoQ4Pu5rpL8r3EO+Dg6i
	VJ3uGMHSlql2gBZeWeY5028tKsQPSwgG2bCZMl2RUqNJ1WrrVri2ROrS0dmskzb7ax6GKIZJjNw
	T5uJWxoRCnWYP+XxeqnJgTuK8JooFfwNvo2k=
X-Gm-Gg: ASbGnctYuk5y1uUs4igf3LZJCMHbdZ7EqoLBG3SVFEsoxsYeEwJow1NthTf5oq8elWk
	ER+PCP0VdmxUhGzRBQOyelIOIswKYhvEDFQ3jyCex9VwDUf+GPAmt8uvYc/ElZN6gEtO74q1EqK
	BF17CgdyHlHNHGXUkAsidmrGnh+g==
X-Google-Smtp-Source: AGHT+IFoIurq//fXyPHdM2INlVq7N1+bpzFBWMOZrAretIXbMmDFcGhmF9uch9KKk/h7T78wBq9cPaQsg+e7+wlS0QQ=
X-Received: by 2002:a92:ca4e:0:b0:3d3:d47a:3040 with SMTP id
 e9e14a558f8ab-3d3e6f9a329mr122838145ab.16.1740998797703; Mon, 03 Mar 2025
 02:46:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301201424.2046477-1-edumazet@google.com> <20250301201424.2046477-7-edumazet@google.com>
In-Reply-To: <20250301201424.2046477-7-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 3 Mar 2025 18:46:01 +0800
X-Gm-Features: AQ5f1JouvTY4Nz3pj78DQcIxp_yOzCSEGlTHj6-S0irHC37iYYaOxLQRXW5KGVk
Message-ID: <CAL+tcoD5RAOBkoy-B1bdShK+PZNdqF45yDXVFUhqvTzqHbFSmQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 6/6] tcp: tcp_set_window_clamp() cleanup
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 4:15=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Remove one indentation level.
>
> Use max_t() and clamp() macros.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

