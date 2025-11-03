Return-Path: <netdev+bounces-235226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D1AC2DE2A
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 20:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9ED422EC8
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 19:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3301D296BD3;
	Mon,  3 Nov 2025 19:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqvN1Jp8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD0F2116F4
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197544; cv=none; b=UJGMo7HE3B3VyVVOyjCsxv+Jm2lpgmcrz8w3zf1sGlP/8SRJRgPF8Il+HwzZ4s/oCwowrAzqzk6N25LqJ98+hAfpLnLtJq4upzncLcHyVhOdGDMa/09HQPXLwmMo+SA2ncmMBndWZ3xBtHcg3Lij5ENVyF6gI73bcF2JPVE4YpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197544; c=relaxed/simple;
	bh=TiPAPKa/5E7lZ3VkDFPFN/ouI2YUhm4970Gu5hWK3LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HAJSBWutBnBPG3r3AFpexFiVekcy23QNDNsQJYpc6DX+1JEkma2lydBDI6qlSe/9HmtbwMF27f8Jvv5baV252qex+MQjnUtsY2/kd8RiFSd7sVXGqKVw3OzJFLkdvg79Dt7wNEcwhXRWgcHIUaf6cFJfI2sBA8pTW6iTaG6zqEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqvN1Jp8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29570bcf220so25528135ad.3
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 11:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762197541; x=1762802341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiPAPKa/5E7lZ3VkDFPFN/ouI2YUhm4970Gu5hWK3LI=;
        b=nqvN1Jp8S0D87zX1aiFPPz5J6yMMN6G3n97knd3SuRXhtI/NTH0NmhSQHJ7LztSZZn
         P2LnmryfdZ4Ap5h2ouZDudjIBJhIEOe7Ac7akOVh4wkucKjMowZVeS9wVLpb1wNOBuJj
         3pIbu39p6KYyTIeuWt6bHtTHZprEaeipSUDAVR1d0PKTlccqlqyn2v0sLT6HrOMAtYm1
         IMQX1E/7uuttmG2nnySdFphb1cusZXibepX/KiPq1wf+9nXa+ORZ6Q5zYlelV8aCTWco
         KKlH9ovHRtDHkBqljxCPlZgQGZK7WswkYO8zGL8lJ8SmXPFNo3xTORDXObLMBmOdsbXx
         fq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762197541; x=1762802341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiPAPKa/5E7lZ3VkDFPFN/ouI2YUhm4970Gu5hWK3LI=;
        b=nAlBATAHD93c6HqSg/dfED3mIEkw9R0YxXOJ+Kkl3ypeXjjXx0geV/tlVTZk5+acGl
         fgV97FqldP9txkuikQxmu6YT17tEafeGeyOamhE/WhMi5FMBlf3hexYDokmm6apKpaHd
         Gz/VSLQsGs1MsWSjx6xKx33bzCA8X2rjoqF/hHo12zAM/an3/dH8NMHZ0k2IYR7ggoj9
         YtZR3dkju3+92VBMnS/K8b895w+50DnBIwb9YMx6XlAkcVx46DNo037UTkq10dB6Ab9i
         9R0KW9oFI5aVQszxc1jF6ui2rL59zmwCbPuMkF5v1lRlE5RmER6dp4J9wHycatZ951nL
         9z+w==
X-Forwarded-Encrypted: i=1; AJvYcCUkY9GOTFZxXqsOeSc5UoJxoJpKrcv6+3j5NVC45SydprLszEw1S340lpWemhc8DHj7K5TxpGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDhVZK+Y577tuk2YzkpnjDqPM6ZG6wxYHVshOkT9iZgJYI9Dan
	Wrzp5S8I5PByzLc8+ZH33JY5IsdMCrBCvbMzwLvB20yOLiDeEmw+mmj6rC9sIuaWzGxxWG7m45t
	WvNad8wNutmqprg4RxR9V0k9T34wXSanD6seU
X-Gm-Gg: ASbGnct8j9jqL0esVNTA95HHhVDda+hsvU6lfj1x1B/+YHF06NZFNUQFCZQXHMVpPk7
	HnnIl6EP9Ayv4RwS2FHv4V+sAQTGtOQsgRahqzeEgOQs2Z153jW43yjoDYZFoNgBkLhZR0XSyGM
	HcrthoQajdPdDudv5ZuI2o605NR5jKAo7yQlr0XpgQB6m7Pbx1FVPQJa+qAZzQeONYsaiFip6Xh
	eTuP1rAqQLxWqMSS6rSOCnHRjoA0CLu+IyWdb2Y5qWvA576VFKlKXz8Xn4i
X-Google-Smtp-Source: AGHT+IF0BSYD4ggbwG3GKDSXC0JY95fMZFQFVb8K4FHOBBwvNGu2REmpMK4jfQUnBSt+Oq262i2Kl3UblwRepxobDSg=
X-Received: by 2002:a17:902:ea0e:b0:295:c1:95f7 with SMTP id
 d9443c01a7336-2951a5271bbmr188667085ad.61.1762197540672; Mon, 03 Nov 2025
 11:19:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103023619.1025622-1-hehuiwen@kylinos.cn>
In-Reply-To: <20251103023619.1025622-1-hehuiwen@kylinos.cn>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 3 Nov 2025 14:18:48 -0500
X-Gm-Features: AWmQ_bmwicNW82tRVRkXxPbIo5gT61jNLe8lZ8bOYZiBYnm3rw60BaynqJTOX-U
Message-ID: <CADvbK_cp=heq2sg0J2hEa3p4soBFmjdqvY2otSLtCkF0aF2FKQ@mail.gmail.com>
Subject: Re: [PATCH v2] sctp: make sctp_transport_init() void
To: Huiwen He <hehuiwen@kylinos.cn>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 9:38=E2=80=AFPM Huiwen He <hehuiwen@kylinos.cn> wrot=
e:
>
> sctp_transport_init() is static and never returns NULL. It is only
> called by sctp_transport_new(), so change it to void and remove the
> redundant return value check.
>
> Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
> ---
> Changes in v2:
> - Remove the 'fail' label and its path as suggested by Xin Long.
> - Link to v1: https://lore.kernel.org/all/20251101163656.585550-1-hehuiwe=
n@kylinos.cn
>
Acked-by: Xin Long <lucien.xin@gmail.com>

