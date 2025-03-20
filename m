Return-Path: <netdev+bounces-176387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBEAA6A01B
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 08:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C29057A2227
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 07:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8E31E2613;
	Thu, 20 Mar 2025 07:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AoqnhZmV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FBE1E412A
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742454409; cv=none; b=b/cWbZU8QjgUcxe7b+qFmi3cEwceE1haPLmBGGzeLNHc3L6G6iH1HFSiYnMUwoBfYbaL+LHsdL8A2onpDXEQSuheJbTZ0Shsck/B0gaRB5yDexl+/DFtPKHUS0lp+D/bfYL5Ajdi4C39q51JGgr0grxUutjm8SuWaP+8FNTMrVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742454409; c=relaxed/simple;
	bh=H4/Pv1UTg7s1yZ3P+8pUwU1OU/ltsZvkwWx2lGjAL1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4uzFrUG5lJnuUBL5NMkJF8jGA9znC0YQxVSeEsv+snE40FWUyUQJnQualgyoVMl09n2H2PntlFI1svvGeyETJHOVl9u9ecLEua7cQB1Jz1NBGFPNAkr0A8s4CwAFz6a73bTfpyq/vhL38jer93heecHwrWPenz4XQoxHO64fzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AoqnhZmV; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-476a1acf61eso4516121cf.1
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 00:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742454406; x=1743059206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVKUkegjJLYtjBijeSXX1mKbQJGW3l8Kkry41+OPC0E=;
        b=AoqnhZmVj/BY8Ze6KxILpFSLQqfuTgOt6uG185iyP2U4tq0V9wL+90JVogFAfWHesp
         RmpxIAHqQrmje3wumVV0BD+rzcPBckTqb0vhl2Bnvf7bN6jdhZpHVHLikDKwdFSe2pjB
         l7TPt4vZ06m5fIT8fAc7TYfsAdyS1vxgpYNJFhTSZMBn+/s+rk2qTqdqIGvoq/J1G+fZ
         yV1nfzGOe8j9r20TcBxDmUvc4KPw/rydZ1oaqGNzjnw7gfHFNB35IB6HNR5Qr5kysfIO
         zlY7tbrfDxmyphZ2fAsaz3206jPxprgtZvuDAwUWZejKZACauSjh5nth6l8UJ2qXj7fa
         68WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742454406; x=1743059206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVKUkegjJLYtjBijeSXX1mKbQJGW3l8Kkry41+OPC0E=;
        b=eqQpSujgkBW1mYQmgaxxclXYbH1sz8UuDh5slnZw90Cacn9nu4wnfvSq1baOaslF8p
         84hj87YOYcApJVSyqW2z+QPziQtmBNlrJ9bVPytt+PxZq9RSMP56XsDznkUpxktSVvv5
         LvfyOYQxapPTAXhp4j4cM2MuNU80KDpBxpzUmojZZs8oQ1XNaX3P53d5zzt/UelrtHXA
         Rg9zW3qmVbcQQ2O8sS4b3JSJ9ijzwY1Djj58GbEkiu2bQvyHXJla1g2DTrwQ09JP6H5K
         S7IoW9oqaUIRwFlvFfZYB4AM6dbbuYE677pUIMkvnJTb4Gme7vPvYfp64XtcpobUCNAG
         tBqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKZFzzfsd+kIdPhWIef6aCwabyT1Dl1h6q36y7ye1tiDctRFoTDBcuuE0js/CCsSHVpeQRj/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOcmHZHbl5mnFJ/QM4t3VlpZcRiD5UxvAcUOnknvv9kmakMUwZ
	yQikthTMwBQ9D5UTEkalaWMktRpONcnOdYm+ZyjyhLVVybTk7QCcNtUUaEjD7PHp1VgXX4vUTWq
	mciTrnZ3cLr60lmobnyNKf3T3L5J7Zcp44Ypl
X-Gm-Gg: ASbGncs2xhzcb2ulh/wXd6feIgH3nwRA/SvnuPUhub1l9qSc2kKwWXnyg7CA6uR8ubx
	M4q7tPNerEovAVisOqJGibPq4zOfRHESDQteqhvAFhKVrQkSE7FhuI1tNZyxUJL9Sl8MECk7BnH
	VHuNko5/DLtqoI1ZfSHe8ZBhMeerSSVep2Lm0=
X-Google-Smtp-Source: AGHT+IFXnGXrwUHrbCRQrFydnMDarLva0pAJDLQt3cjNLyfiPdMGqfYBrJoYofp0ksDHHyzxkq0msShzvFR4mW1u4Wk=
X-Received: by 2002:a05:622a:510e:b0:476:b02d:2b4a with SMTP id
 d75a77b69052e-4770833aa9dmr105175461cf.27.1742454406417; Thu, 20 Mar 2025
 00:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319230743.65267-1-kuniyu@amazon.com> <20250319230743.65267-4-kuniyu@amazon.com>
In-Reply-To: <20250319230743.65267-4-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Mar 2025 08:06:35 +0100
X-Gm-Features: AQ5f1JqAWfPcSj8eQv9ZgTXpDnHQH0woMiyS-Pk6jHaniqzTjI3TAGk1An5g-6s
Message-ID: <CANn89i+91xN0QCm1QuT857dyjgfD6qVtgYWTMvGZzf-sQK+QnQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 3/7] nexthop: Move NHA_OIF validation to rtm_to_nh_config_rtnl().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 12:09=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> NHA_OIF needs to look up a device by __dev_get_by_index(),
> which requires RTNL.
>
> Let's move NHA_OIF validation to rtm_to_nh_config_rtnl().
>
> Note that the proceeding checks made the original !cfg->nh_fdb
> check redundant.
>
>   NHA_FDB is set           -> NHA_OIF cannot be set
>   NHA_FDB is set but false -> NHA_OIF must be set
>   NHA_FDB is not set       -> NHA_OIF must be set
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

