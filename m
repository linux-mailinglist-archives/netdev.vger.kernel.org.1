Return-Path: <netdev+bounces-204904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E121AFC729
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5395A3B4C98
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2850254AE4;
	Tue,  8 Jul 2025 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hAEN9uOe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308871FBEBE
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751967350; cv=none; b=XsaQak8KOAtJwZ1rgKmRZX9Lw6NfhMFDcZ+b8zu1yjw6RYjT3EWH8ri5ou7V5l5xY5Y02M50CpUIrufwN4d7bRUf9e78stQk4phrvGJ9+seRN5zYDdSgoMIA5SADcfTsrEkdGXBfDTUdfPW1WaCekj2Aua30wV4d/yt4KNp9Wzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751967350; c=relaxed/simple;
	bh=g8O8enFj2YHN7WD0rPzhd2SURhpb/a8KljaIwHj2zDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KRvobHkNZntKFfTEDpjPRRpvN6ZclI96bvAviAlhTe+YF3QicVs1fC3xxER7VbP1lviD6jWv8BIYLihd9eNH2k3AOTrg11QX4abZK/AAHwhBb2MhKEqY3I0gqWA1+4nzIszOEPXUEb66TtReNPcI2TEj8KnJUF7VuL7k1Q+B8Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hAEN9uOe; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a76ea97cefso41897161cf.2
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 02:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751967348; x=1752572148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8O8enFj2YHN7WD0rPzhd2SURhpb/a8KljaIwHj2zDY=;
        b=hAEN9uOeC1TPBUyEJ4H+KlSBs69XzC1JgJIh04Zv46P9xX46YKzk36dRhKpg9JAdUr
         tV3NATzicN0l+Aah1MBzxnq8W7bIPGzYAMTxiG5Q7G1k4m9F7oWleAulwI0NdUVxCVW+
         Adyxdag7rPcHZz4T0S3ypkR/L688MQvuR88CrDekjtwfuvRQlpReBJVvDD/M0bGvteL/
         rCWLc5/nbkDsj+18irKVsXalY1hWSWg9YlZytFB7hjYQDbh313P7HjxMpvI483Jg+t3O
         tyayst2qZUbcJESebTZV89RLG0VwP4vjj4FchoFZ3NzohC/To5eV3z8bFEZUOHPOD0+u
         TOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751967348; x=1752572148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8O8enFj2YHN7WD0rPzhd2SURhpb/a8KljaIwHj2zDY=;
        b=cvtBGIz3ik41tJAIPIcx7z1BF9/EPaASQCDFAtw6BWwRETk5boCjAsueZqnq837gvF
         DL6hbMfbH8kEvRAex+S98X9tJjkA4BQNIFoTN/U/yYp4EDiQ88rHKWBW2URFnpCgNsrf
         oQw5+hgk/OeEx2h+O51VMM0Y3f0MTLY0O7+yckJ9XpVe61/hgVoO59k+ssMNilHSD54Q
         kLjIOvT337vBO0br68FCmyhGszbqrv/BcHFv2RiPAap6Amix8vHdf4rMN76YqhBGZjlR
         xdtsoNO1n89VZwY1t2IQUCJsWcP4cDtKm/mDkKFVtl3snCqNjCY9LesXCrF8dANkTcXD
         NSDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKBOiWJ+kjtfqTs46fkGzycZO4uAZ/8tJkZWEYOrAwxQoOPc164GCeKVVkxEULDEOlDcTYcL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM5Ld4gMjwEoq5PMSG6VHzRJ9ikeWy6yQ4Yj5f+fqgSs7xBomT
	p49YsNAxSxl180XmQYrTDmtbvlOo4btGoq3cNC7m7U0gv111M+K20Ps2DxYSihQYpGP2zCNJmtN
	SJHUOP9dfmhq9If/BbVYoNFla2em4a+3VraWC3nOI
X-Gm-Gg: ASbGncspb+evBGztrIEz5ChZs6DYNTVWmkzwS4LsNFSJ+y7Ro8eaL/Tst8HeKTjzB24
	Ac5Cd7A0wxPwWUaMU7ZCfb0kp717JRVfRNTVsunKEGT6qm5NlNOaHDpz0nafUfPDPaNplVRJrCr
	/GS8Bh86EfecW2OSp65dsAVqxU1+p4ViJt2vN1OQv6sQQ=
X-Google-Smtp-Source: AGHT+IF2qGEug/vPcWawvmy/L9jgq1PYeLuqtRzNGP3hkxI/8mhKtYnNZd4C8p8K00wn2k5n/D/pkFPf8Jt9j3VZBaI=
X-Received: by 2002:a05:622a:4b:b0:4a7:f47b:2b56 with SMTP id
 d75a77b69052e-4a99879f77dmr261492901cf.29.1751967347813; Tue, 08 Jul 2025
 02:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703-connect-port-search-harder-v2-1-d51bce6bd0a6@cloudflare.com>
 <878qkzgi4i.fsf@cloudflare.com>
In-Reply-To: <878qkzgi4i.fsf@cloudflare.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Jul 2025 02:35:35 -0700
X-Gm-Features: Ac12FXyQUpim8xNMX7IGpwfl2yGonIOBst6dhQKAOUao1Roqc0jal1lLlwXZYY0
Message-ID: <CANn89iJUM86t-hYC_W5KS1gn+NOFP4zoaS+99Cpvx+tOO=mxoQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] tcp: Consider every port when connecting
 with IP_LOCAL_PORT_RANGE
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, kernel-team@cloudflare.com, 
	Lee Valentine <lvalentine@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 2:13=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.com=
> wrote:

> I was wondering what the maintainers' outlook on this change is:
>
> Does this sound acceptable?
> Or should we start looking in a different direction?
>


Long weekend, and a big number of submissions while we were away.

Let me take a look.

