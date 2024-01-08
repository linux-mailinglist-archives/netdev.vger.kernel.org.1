Return-Path: <netdev+bounces-62329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE09826AD1
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 10:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41A11F21A70
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 09:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AAF1170D;
	Mon,  8 Jan 2024 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BQQgQSib"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D53A11C87
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-557bbcaa4c0so3495a12.1
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 01:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704706597; x=1705311397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lg9hufbVidfHAmI5ZgttAm0DeGef8j22F2L1BuwztS0=;
        b=BQQgQSibcywtDUA3kOTWAcnuuAZWa4es1Ur9R4XCp60wcEs4Mno6CZtTwFEcRP4BX3
         4DaV21NO+5dh7j6XOdDJZTQvfxZbdXYBAdrGyzZCZvV7NScMqjoWAaMHcEnYEOGl8to6
         ItQGfEYXAG0tdiMu/JNwTPQisI4KmsAQnjJLgPlGIYHyh9pZ07lFPfqtNvUUQ8/WGc+G
         y14Cau8QX5ZSn9sOvVzyz0QBp3/ZMhjlphGKGyr0ggxQaD+emjXl4lcbq2PHm3NTLD4l
         N7z8lpxV01rkgZLSDivQyppeG0FrrABXrDBJWZX81OkVrVoKHfKv1Mu7nHiuG+fXTEBX
         DCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704706597; x=1705311397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lg9hufbVidfHAmI5ZgttAm0DeGef8j22F2L1BuwztS0=;
        b=bX8K7G7PHEyWKfaiRHgTf94V0fG7MR6U4JCBR3PEzPtPtn0RBArq6GnwX7Q6s71udM
         6l9pxAfaLV3Xq8HOVY3J8h/3H83jfCi5Ow/1ymm0R+1VfXoIdC+OZyeBaOF50Sa2u3ZK
         48I+FUN6bv2KrPQS8cfE2XZI54fVfG9onIZ8chGOS5YPTxDokNXBC4JuvXwJKJfjrQ8H
         aZlt/w58xaMfLiO8P8j7hCOgB0mFf1GMO1XDuhCZ2GETLQ8T1/iASXBih66zlKtu5+8g
         JeE3oQzXopr4IwuLPhG9YvD6ZVQq+SjBdaBhCqwn5rJaMNvMho0HNSBHTC2EOCdNLHZu
         VERQ==
X-Gm-Message-State: AOJu0YyyECp6X0/foFtejNS1++ogy3zhNNsZMXFl0SQaW+ewPhvDXuZF
	y8PYwzQK3NyvWmXb3vmztHKG6OS0xSecA4bgWG1IZwluPCat
X-Google-Smtp-Source: AGHT+IGfDX7JtOJLy6KHjhhk89HG3XMG7mjN2L+LrG5sjsjQNz9K1E8kKp2RSSbrIOPpoP0ts7EhI4bCjZMyzANugsY=
X-Received: by 2002:a50:c350:0:b0:554:53d0:23f1 with SMTP id
 q16-20020a50c350000000b0055453d023f1mr264431edb.0.1704706596664; Mon, 08 Jan
 2024 01:36:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105170313.2946078-1-edumazet@google.com> <adb52b11-0a7e-4c62-9516-d29aa88d75df@kernel.org>
In-Reply-To: <adb52b11-0a7e-4c62-9516-d29aa88d75df@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jan 2024 10:36:23 +0100
Message-ID: <CANn89iJ6LERiNz_Uj0NTVLiDCWdHqFjmeMGk=XopF=LgnFj7ig@mail.gmail.com>
Subject: Re: [PATCH net] ip6_tunnel: fix NEXTHDR_FRAGMENT handling in ip6_tnl_parse_tlv_enc_lim()
To: David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 6, 2024 at 5:10=E2=80=AFPM David Ahern <dsahern@kernel.org> wro=
te:

> you dropped the comment above the may_pull which is helpful for reviewers=
.
>

Yes, this is because I reload "hdr =3D (struct ipv6_opt_hdr *)(skb->data
+ off);" right after the pskb_may_pull(),
so there is no more stale pointer.

Thanks.

