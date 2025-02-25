Return-Path: <netdev+bounces-169451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEC9A43FC5
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 13:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EABA53B6010
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4556A267F60;
	Tue, 25 Feb 2025 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YyGQf4gJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97799268C4A
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488137; cv=none; b=ntdfNyPlVlYviinz9CuiIouLbFv4R1y7RnBNcB+D7NQqsgC5+WP86HD3tRxs5EehwtcKMqAWBpu5J4Zlw6EnLe1k6CS/a7j4DfRDtqlPHmZA6+eRmNjqV+EA4EXqCpOKVhT7xazPjaPlaXOE054D9/7jwT82qlpnYli31DRy6+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488137; c=relaxed/simple;
	bh=mDFpFfRjITXremHMV1TwP9fGrCPH4nqXeTUj+IaBbxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BsgRhCmmOxoA0sNUwJbl6KZUR3A41NZuz3bDd3G0GQ1A7tS+Nj2Ph1S+BeonzukpKfNttylG+E2QwsRH8hFGMoTcaFM7ohyUiItObjUKT4JaNzpExtKPjv4DaOKWrhSukvbEtF9qIfn3UEbEBIN7gw+HoOwFWBdBxqR86mfjgZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YyGQf4gJ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e05717755bso8445734a12.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 04:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740488134; x=1741092934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDFpFfRjITXremHMV1TwP9fGrCPH4nqXeTUj+IaBbxI=;
        b=YyGQf4gJTqxk6dFkc0V2+J9/E1qARx78mMtd4Mdze2mBCW2sUBa55H5+ZqiFqnUmpR
         /zyrt5o72K/RBhdpRHjRfoMfGKgLowJ0OQXJWqbbHXF9+g5f56LDX6V7qLn49OGtRp2o
         feIW9LSxlwDStMOuguSYljdc8tRvovKxB4+2+dfWbBqSZJznmVSuG5VRYl71xQGmd7Fd
         bt+emFudYD7Aj9SNIR2GTmZOIXmL5qe4eltww1UXf9FhRuoW3la7ZJcs5DP2lbYIXcU7
         7fQmTe2RyAqvL0hT7uBgC9eBMj5zRMA5LH7dbRa2fq75nijYX2MfasnhOlT/Bl8X754H
         MHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740488134; x=1741092934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDFpFfRjITXremHMV1TwP9fGrCPH4nqXeTUj+IaBbxI=;
        b=sFALh1nKvjnzdE89zgly8qcpuyKVlDT9FVM5D/GerDpo4Rcz/WHrPmzUQG5w5kEc97
         sFu+j/FjMWx0S3O8xdNViwRlZGoJI9N/mYvWqjfMG4cxpHo9veKEB0Zwwnke4Yv+4bc+
         qdR5Ulc5LiO3EUWXBVndnLhneyZ3Wf25S20y6xUFHFTwGT5hv/BY7cU+ZlZNyz4XSyA2
         YvNwDqmkaNcNPVPblWBs4cBlgji74ioESSattiW8x9pU48Nkm1K7lgWwHNypUTAO8Ksw
         zo0CEXCOjR0F6Wwmg1/UQ1rUDA85oI8tXT6mSLczq9ALzSmhActKZ+hFTCarLUEyKucy
         OLhA==
X-Forwarded-Encrypted: i=1; AJvYcCXl1bGbQT8qRVAixA+P58dmH6Xag6lOX9NQvJSjnuL9QUiNL0j7oTrPQ6sddwyUfVTCH0zqIGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLKXnwd9o5YINvKGLyo7dcJ3YOqFZxHuzD/dqxplBW1ukXrrxu
	S+fM1yaAL8Zu3vc9qj9PjfVfKplumtbg3ykHaH+1PcKskJJOrrhCZX9GOnE+fu1NeVZ8ywRTrxb
	QBla8NWFEvbP8E9vawIaZSo7jH3a0whQ2RTXh
X-Gm-Gg: ASbGncsbccg1EoEeUjjx1eYmXbzfgCTmsZmReG1/T7L3Sbkn94+6227/1S5RvGuPjvs
	g7LJ8mxVEizJarbTb22hWjNdQgGtxd5cY+szyiMwXf4a62vfoQIJ+vzXPhgm0C5XNiwizs1U3Rw
	cfjzEA0SVl
X-Google-Smtp-Source: AGHT+IEVv6zRzl7vU3cswJ5BXILXYRrcfnmmkEB/sbMWkpvfTmVkmM5Hg9/u+oTR24pBS26bcGpgCytVStaecuzdYyU=
X-Received: by 2002:a05:6402:2546:b0:5d0:aa2d:6eee with SMTP id
 4fb4d7f45d1cf-5e44a254bd1mr2757203a12.26.1740488133548; Tue, 25 Feb 2025
 04:55:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224110654.707639-1-edumazet@google.com> <4f37d18c-6152-42cf-9d25-98abb5cd9584@redhat.com>
 <af310ccd-3b5f-4046-b8d7-ab38b76d4bde@kernel.org> <CANn89iJfXJi7CL2ekBo9Zn9KtVTRxwMCZiSxdC21uNfkdNU1Jg@mail.gmail.com>
 <927c8b04-5944-4577-b6bd-3fc50ef55e7e@kernel.org> <CANn89iJu5dPMF3BFN7bbNZR-zZF_xjxGqstHucmBc3EvcKZXJw@mail.gmail.com>
 <40fcf43d-b9c2-439a-9375-d2ff78be203f@kernel.org> <CANn89iLH_SgpWgAXvDjRbpFtVjWS-yLSiX0FbCweWjAJgzaASg@mail.gmail.com>
 <CANn89i+Zs2bLC7h2N5v15Xh=aTWdoa3v2d_A-EvRirsnFEPgwQ@mail.gmail.com>
 <CANn89iLf5hOnT=T+a9+msJ7=atWMMZQ+3syG75-8Nih8_MwHmw@mail.gmail.com>
 <8beaf62e-6257-452d-904a-fec6b21c891e@kernel.org> <CANn89i+3M1bJf=gXMH1zK3LiR-=XMRPe+qR8HNu94o2Xzm4vQQ@mail.gmail.com>
 <CANn89iL-oCk=FqGzeDi4PN_PX6r8tQZ-zwxObi=R_8=9QzkbQw@mail.gmail.com>
In-Reply-To: <CANn89iL-oCk=FqGzeDi4PN_PX6r8tQZ-zwxObi=R_8=9QzkbQw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Feb 2025 13:55:22 +0100
X-Gm-Features: AQ5f1JrE4_Eo-2V1svGBO3EXx_IWA56vsu3ReLfjLdXjE5OVLl85cHOc44MZUXc
Message-ID: <CANn89iKHzSQ9RnjeYzhP42gubGeHtjSTbK8METXOSA-NuSJTPQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: be less liberal in tsecr received while in
 SYN_RECV state
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Jakub Kicinski <kuba@kernel.org>, 
	Yong-Hao Zou <yonghaoz1994@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 1:50=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
ed to refine the patch and send a V2 later.
>
> In v2 I will no longer read req->num_timeout
>
> First SYNACK is sent with syn_skb being set.
>
> Subsequent RTX SYNACK have a NULL syn_skb :
>
> tcp_rtx_synack()
>
> res =3D af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_NORMAL, =
NULL);

No, because I have to take care of possible alloc_skb() failures in
tcp_make_synack()... this is a bit tricky.

