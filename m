Return-Path: <netdev+bounces-162377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA87DA26AF4
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 05:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0013A247E
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 04:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F4186352;
	Tue,  4 Feb 2025 04:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jdcRyO/q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7D25CDF1
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 04:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738642600; cv=none; b=bhd11GGN5C2KOt9EKLq+6WaTBdqM7sBoyCX54pnliXa2I3q486pHBIXT+m6Z4LOAoDupdsKWEu+ZLHLgtMlID2cFS8arYQ6VlspKcVJXW42yoVQZ/28NouchFXtNXeMzqQ5KnBL7akzfWvd2CrIpDrN1mMxU0AFdc94+lgMZsYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738642600; c=relaxed/simple;
	bh=KaJ8uTo6+lgb59NvNszbL0EisxAmPfMyNjVZ3g5z96c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PoGXf2bsZtuK7T+Iv9AlXDT8jdiC+O7SLTcpn6pc8XHm+kCuI0+XOWjlGskULv0JfpBMCmya3gspEzJEwgXdvA9L6MLreYCzwXIMsc2F+PH3S1ai8LaZ55kCSzgARFkea0LaCFsAhD1yYkOY3kxwDhVqIQYBE8OjrnAx+llJEmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jdcRyO/q; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dcb060ca2dso2913981a12.2
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 20:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738642597; x=1739247397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StIK9njlaJ6GJKu7EIsXqgOvPMlSHx5j3okYgj02u7k=;
        b=jdcRyO/qY5BlHFCsNbtBOzU59gCMKoWwtT+MA8IzdsdmB19YvqO7WOWuR3AnFow27f
         F+ILiJoSaIbEz3JaHPa/5aq2wnyrMRUq/XqKIQ+Cuq5bAslx561iDgQrTNoa9UYN8Epg
         2LEhi5v+wdSfNHo4V6iWv0dMVvqKoAvJPB//lmJVjwpgtotjEus7wPSVtFU5M8m9frtw
         qe3iWyIBHCtoBEURZsqwOxdDTO/dDtUrAMrIyTRLgCtgOhj1mH8S5bVXAciyzDpQPAUc
         sb+mbSluF6T990/7CWG56AsOeg4BLg3u0TfX0j/KrbgpzR/DB+gYmHEnxl0jJdML7qqj
         0tDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738642597; x=1739247397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StIK9njlaJ6GJKu7EIsXqgOvPMlSHx5j3okYgj02u7k=;
        b=vQC7F4GjQRh7lqVr7LMa9fbfgFYvCNzjtb5mKGX0c/1uNkaDNjIFnVzZfAbF3KxVWJ
         NIHI21bG338btmMLsYVp+R13qizYfBcfVYdw+8Vl4DRHP0fqmblT8QYpujeJapmvstyY
         wFo53tOeB8ylSxO5O/bQFyhONn8463IA+WVa8vLgmKrZwaBWHvhzk6PlijxsrV1mC/wy
         bwhSptjPilugTvDNO8cLJb+h0GAn2CzkPjX7ydB01XyrcC5grpr/5/nTpEWRBqFSpU3c
         bSp8Qt/Qe3CPz5jI14PDOlu0QGAkshAZOQKRNbfu5G3PsPdg3GprGaMu0kaSUX7W8ThB
         eCFw==
X-Forwarded-Encrypted: i=1; AJvYcCVcBYOMlI8sC14X2Qc2tS+dirOmhAshEhOmYMQ5Lqdvvd/nHN8iHX6CWTZWD7a9uliggdv21EA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY7PAtANnJ7Yb4+yZiMuMLsgxzLqYTKPup2j3SqBRzGRABya5f
	9d/vqpc934SskCuqrtgzAeBevZhcdNyZkFJJmfZBGj68k7980jjosVbIYM44BVxC/XskTotvqig
	TnTwiq7fVOsMUqq89P1bJ5aoK7UGsaeSsGVZm
X-Gm-Gg: ASbGncvbMdxJDIAZrY1SPAgPoPe6oY/MMABtAVJmQ2Pq43xRuZqUmicKUzn7u7Pil/a
	4DnVLJOiyHhCbhrpoy7qShX+/2bsrr3nLVbK/pfBYt6J5ndi4O3nrTWgB5WjS/NOhmDAiyg==
X-Google-Smtp-Source: AGHT+IHsY4umV9TXKC8LD1Az7AdW0SMmcqPL9bkmTUC+G09p1g9ZlFu/KH6aB3UOAnVkemh3T/4tCMxMG4D0ShjU47Y=
X-Received: by 2002:a05:6402:5023:b0:5dc:7b59:445b with SMTP id
 4fb4d7f45d1cf-5dc7b594606mr21967937a12.28.1738642596809; Mon, 03 Feb 2025
 20:16:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203143046.3029343-1-edumazet@google.com> <20250203143046.3029343-16-edumazet@google.com>
 <20250203153810.4e68a6e2@kernel.org>
In-Reply-To: <20250203153810.4e68a6e2@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 4 Feb 2025 05:16:25 +0100
X-Gm-Features: AWEUYZmo8vEYny-v8YM-TrXJaTaETIJqzLhi136ado0_PuSokrtFVsJxVGNN4E4
Message-ID: <CANn89i+=MnEcSa+BwXtXZqbjBU5sM3pgkoxnfsUQac04aVhiaQ@mail.gmail.com>
Subject: Re: [PATCH v2 net 15/16] flow_dissector: use rcu protection to fetch dev_net()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 12:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon,  3 Feb 2025 14:30:45 +0000 Eric Dumazet wrote:
> > Fixes: 9b52e3f267a6 ("flow_dissector: handle no-skb use case")flow_diss=
ect")
>
> This Fixes tag looks corrupted, in case you need to post v3

ACK, thanks.

