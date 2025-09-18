Return-Path: <netdev+bounces-224246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 341E9B82E07
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 06:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7BA1C20EE4
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 04:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D7B257427;
	Thu, 18 Sep 2025 04:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hs4NtbtC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5960D2571BE
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 04:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758169262; cv=none; b=ZkXVIVtx/7773YD0QPN+QUPKxDhE8Sh0TlJ2+BwXJ3DJXZdFPIBNbx2QKGUaY+gIFN7WZTLhEaQ3kwZ+2HQRUKkfMymWSWpZP9wG4PLv6I8Fna9jtpE18MCgYgVYkOaOQI5m3bCCvCk7CAPSL89CVahg5ECtMYHtAQgFOhWLgQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758169262; c=relaxed/simple;
	bh=PPwVRPljwjpoQZNzluQemeJMw7LSPZtLDU9Tg2B9mC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQn7WNjmgmmE8/TcPMZ/xy+8eC16qULJkujOT4nqhb02lw1VY8AIvG3J0mJPR5EyHIcmJfsVTSJpMPeLjfPBBi708GPHwsIEfuS6bzoKGwrgYcCP1uVtFw4gvUrx4tzHbgvUQRLN4Y852tn43luEJS3b0Lubw4taoqxAsz0rVAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hs4NtbtC; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-807e414bf03so73601285a.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 21:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758169260; x=1758774060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPwVRPljwjpoQZNzluQemeJMw7LSPZtLDU9Tg2B9mC0=;
        b=Hs4NtbtCwrW/ljKOiIb5UI7905hXzUPBzA+v2CWfU0a0tTdZvhHjaRK2H/rHxiEiTr
         Z+bhaCr1x8Ub7I/GX+b3nq2tmFfja3znqHaYwZrzCUAFcdQIInhz2vJRbHhtHUVaNax8
         TBAN46mxGGNKFdauf/TiRYMOYjrlGPS/JdfygtbKm9vQx4pmiWkDRsyCm5mmB60UO61u
         MxvDuET3UVzEIBoqT1ShuwpfPZGl6LfQPhhqnMeNuSpUvKIYT64/WBAH8Sx9vIfuvCj5
         VLDfjgBpKzZ+0NgtmCJWGclLvso3dcseqcXTZdiJ3xYHH6/ABEhLcfCz/TlyFd7c4fD9
         nQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758169260; x=1758774060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPwVRPljwjpoQZNzluQemeJMw7LSPZtLDU9Tg2B9mC0=;
        b=vSzPzOG8h/vR/a/+WirkRGHszNghhFRP/i2bFIblB8DoohXMBO0G/t6s1Q9+pw9hXz
         ee/U/MG7DFbDrgYf6kOlb5PaxQ7DPNeshaL3KePyhjUA4bXTmmLzRciktjIHsLZ5gaa0
         FAdv4i0yzOvGU3H0ylF1D+wZaWCNs26Mk2g3n7iCRt3/4356C9NrI7EyM26Y26FZBW1C
         8+hKhmI0MwRMS4RFYhK8E4XrfzEgh9eNbTMdoCLaUhnhPRpclgpo+1cHho1dJnrQlcnn
         hz8h2zel8axh6wJ9ZrGmdAzYXpEOr7ozI4wTk67LB8LML4wqJCalNFb+Eq1ZIcwVQKZu
         ytqA==
X-Forwarded-Encrypted: i=1; AJvYcCU55v49fvHInO1v+K9FgpcwSNfOkGknWpVlQuEsJBQpsQfWKbwTufK+Tdf4w2oGaZanRb5lasA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNSGdZot3QtHuCcmgtOfKGyg1VgJEewiU9HG0ii80i/ZMMzz4a
	esK5FUTE8BkVZ2DUKdP4SuYXTH6ZDH2jkZJhthmXPzd48NudZnxNCZrJZ7ISybpwV6fsXZ6uOfw
	XUnpnM9Pzk4I9OLGkhM6lDzQY5CxaMdJCZXWPuB36
X-Gm-Gg: ASbGncsdtJkfwA5HwJg00PFEBok71lpHJOIxFyPfIcgg4k8+sauCTP3boCw/75/RJS1
	1mD+qZyzSnZ/s3iPETcFsEDL7lK5mPVba8GU2fcAuqVs+USbgnWY2zGgB2thUX/B/FMBapiwvnM
	zKLhJw8u8vgEGNKzU85O/reWqfqB1OtR/KBVWpocAbPGCV3vsXQPZ7kJse3xlHvMtNOqnVZ7bNa
	9evkbz1s6LwDTpmBwYA9q4kETYW1dX0
X-Google-Smtp-Source: AGHT+IHQzGuFAleQkmLtndbNzxlRsWx53+vWtX0gEU2D/izmxjt1FNuhB9RtQHyx4R/9LIXL5zJQo9cMQ0AcnJNpJ8s=
X-Received: by 2002:a05:620a:7108:b0:80e:455:9419 with SMTP id
 af79cd13be357-83106eb3de2mr543360685a.17.1758169259848; Wed, 17 Sep 2025
 21:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917000954.859376-1-daniel.zahka@gmail.com> <20250917000954.859376-10-daniel.zahka@gmail.com>
In-Reply-To: <20250917000954.859376-10-daniel.zahka@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 21:20:48 -0700
X-Gm-Features: AS18NWAZ2rxhLYuDhvFDKRWGTYo-__Ma9EOT2DhbqsVE7wHg1_1hXe-lSXK8970
Message-ID: <CANn89iLr0pk68y+tTgrxNCTY0HfiAAt+gtRd7K04wHsqqPoQ_w@mail.gmail.com>
Subject: Re: [PATCH net-next v13 09/19] net: psp: update the TCP MSS to
 reflect PSP packet overhead
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Boris Pismenny <borisp@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Patrisious Haddad <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>, 
	Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Kiran Kella <kiran.kella@broadcom.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 5:10=E2=80=AFPM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> PSP eats 40B of header space. Adjust MSS appropriately.
>
> We can either modify tcp_mtu_to_mss() / tcp_mss_to_mtu()
> or reuse icsk_ext_hdr_len. The former option is more TCP
> specific and has runtime overhead. The latter is a bit
> of a hack as PSP is not an ext_hdr. If one squints hard
> enough, UDP encap is just a more practical version of
> IPv6 exthdr, so go with the latter. Happy to change.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

