Return-Path: <netdev+bounces-224242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B17B82C8F
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 05:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B5B3B0A92
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 03:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931BD23C4E0;
	Thu, 18 Sep 2025 03:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XCsZ9OnU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091541F5413
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 03:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758167072; cv=none; b=HVry9h/REnqLcAJiY4j/hexdiAoLuEZyJr7OFVyMAdqMTJkb4MVwfNe/Yi4dNhy8kvjeEHTXYQDAyPrmzz/GCnDqmmH1LQQDaYSTOnFpdulHq59NUGu456r9YhGQjL9qHIp5L90GErhQiBSB6LK6a9sx0CU4l8su2N//Y1r8hJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758167072; c=relaxed/simple;
	bh=ges+j09xHTdGS64AaS3eeSLKz7uspaFUmS+9GVdFSro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsP7e1iQ20DRUkkcgcT4ob5NHaKODr8KdWlm5dQ7VeJwGz72dTOGNRih7GuvShefrN9xCgqQVmSrHEnNse8jIbyiIlcg2nBfruUZaFeYKLif1dQi6RjzIFA8w93SInVnnFKTSyans1rxHL2i5z5S96+X6CWzbzoMNPi0kZhdJC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XCsZ9OnU; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b7b3202dceso5824201cf.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 20:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758167069; x=1758771869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ges+j09xHTdGS64AaS3eeSLKz7uspaFUmS+9GVdFSro=;
        b=XCsZ9OnUty7aNrYb39rBoZqul6G3MNLoecP0Zq7UMM64cimNrV1ANMyFerG/tGsD3e
         rAbIcw5LF2htWfDwNgDSDTPswOg1CCj9DJIb/NbAYoDPhqhjXf7/rJy/K7LIKzuFUPUN
         eNYd7DICjOfrOv//Q85kF9JtkPu0B+ZG71T3nehlH8mwj9JrE9VY/uiwmTsZ6eAa4XnN
         TsnJwe4Otgbx+/D53r6WeY7QZpGV21nVacwMcpaHUo2EdfsRXDrk7llfwvMdyxFU7J+8
         5FsQKFJWdv4xRE8IBWaWW7x85NxiA5cwSfnbAEHHRbeZ3lY0nd1EVl7829osXjGQMQdW
         U3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758167069; x=1758771869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ges+j09xHTdGS64AaS3eeSLKz7uspaFUmS+9GVdFSro=;
        b=I1eMOq82MJw9iQkzUjuO1pdlBnE5RJ1CQNYh/Go2xKuG019IYMib6rmOimeGNNg6iS
         js+OEi2JFShOjqWWqZSQmczaz3DTlikPtkZgv5JkB+COlUPeHQ118VbA32vkt4Vc0RlX
         ZC80tF4W0qbKMxi/KyRMruy801FFVpcq0iNNiXd/Y/9/QpjotUNVrTyaXY7rMPvdDZxD
         zOoyv/0yU6NGWzhkgPoNvodDWU6zvz/guEX3mwIV9GMOMzfaXL8SgaVpgVdW9ELc2q9P
         5RRM31tRurKmCo/IrXFBdrS6gzDIchcwdQsyinHAc4s+6rAjerF6TDgU3uRuUoDBxTg3
         o5sg==
X-Forwarded-Encrypted: i=1; AJvYcCXg8PyhR9aRDsz+HkBTwioBxqP1xHUBCXM5qF8ELKrs5wB72dT7a+4PFsZyNBb9C7Qs/cjleIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIgk/0bV/VJm8KoFLZuPzM2gc2FL4cbFM5XpISkWJ+L7pLo1TQ
	stuUs/xOLdCE2sw3e3lcHBCgXz+M7/pZhvr8OAqrGA1BpkE6HP0KQT9MeK0IqFWwbZ3J+EQfp4h
	e2Hl0NAZTGklOlGVHqBi0ve4RhatEonO9zTLv86xw
X-Gm-Gg: ASbGncszWDk6DGdEQkRJRNTmybD8vGUpvHhvrz+BmKodPZ/UL/w8uyQ2yUwkBJP5U4d
	ZMLE4oNqKtV51Cr63iPGV2TxoFzFINdEtw08e4YRbwfopAXVs9Btf/4aueWhDLDdQy3ThMm9rv8
	VCi2olpwJDthI74v96gDSM0rU3fysIY0H/3W5sqH8667AkmrBpWit5HZvxYU0tYyR65d/qJ2ki1
	QGXeJ3HhUHPkY909hefEhxe4BpzqbEx
X-Google-Smtp-Source: AGHT+IHFdGwfOABnrHbceapru6yWDBtB1g8kBsmuEumXSo3QmpCp36ovgPr8qo5sQ7FDkDLuF8EnQnFXJOe9fFRlO94=
X-Received: by 2002:a05:622a:124f:b0:4b7:adf0:eeb8 with SMTP id
 d75a77b69052e-4ba66f01bcamr53625431cf.19.1758167069286; Wed, 17 Sep 2025
 20:44:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917000954.859376-1-daniel.zahka@gmail.com> <20250917000954.859376-6-daniel.zahka@gmail.com>
In-Reply-To: <20250917000954.859376-6-daniel.zahka@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 20:44:17 -0700
X-Gm-Features: AS18NWDRijz5Mbu5bsyTvedt39Oe-IQ2fFCBUDpDqb1M86rbnMGtQX_pvK64Luo
Message-ID: <CANn89iJkH0AOOtFeGV2fKycakqm4gNUsGKWiC3FP6tkB=+o_Vg@mail.gmail.com>
Subject: Re: [PATCH net-next v13 05/19] psp: add op for rotation of device key
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
> Rotating the device key is a key part of the PSP protocol design.
> Some external daemon needs to do it once a day, or so.
> Add a netlink op to perform this operation.
> Add a notification group for informing users that key has been
> rotated and they should rekey (next rotation will cut them off).
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

