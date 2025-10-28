Return-Path: <netdev+bounces-233658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60547C170A3
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 22:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39C804EC1B3
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 21:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E19F350D62;
	Tue, 28 Oct 2025 21:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8hOjRPf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64FC23BD17
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686936; cv=none; b=hQtQDw700ujGRp+u+QRe4eIyYnzg2NtwT7/CMEFxkzGYLjdhfYGWPz/7YK18IHnSluUHaiubOqmN2GvwYgHfKWJqONC73uwgVaioLJJTRBtJvd9f5RdQTJ4aLMMNgguouQa6whCkFPZiQumX+fYnt0a4DOvnphXIbBup+pRKLdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686936; c=relaxed/simple;
	bh=FlrVwPPGan2VkiUTXCDaJl5ILUZUpZ7Y34dMi08dHpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTeElPARxRaJQGHUAOgwq0ynaKDmNG5LJTg7WQCDRe3OBNmdtcV2nNQXSE1cOMugdEeoDqmHG8Ed4Grx+/C5MnLlv6bM79mG9pz9HAAczHR1gdN4yLIqlY0E2y+X+h3B6atHZP1JZNd2z2QCncyyYP8fhKgehYAUOqNQ3mW/WZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8hOjRPf; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63f2f1ac9feso1247455d50.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 14:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761686934; x=1762291734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tyjSkBqAxzkn+CQavzu3otPqr5+9CTB8orLK+D0h8o=;
        b=m8hOjRPfbzt6KKW3tf/WkH8FzbwPczCQtdFAYQP07ZlURtOKanZWWQUFeOh2Ai2kWO
         LDwqk/UO2Q+zi99fpHAevBcx+z+UU5nP3yIV7W7Is1ts5FyEIZHfjK+RPUSGGMpEkqSu
         lPA1ZmBR0grNbkcfNATohu5prDCZEerhSKNryDlYf8LfJ9u4WxwZCT3Rnh/w98ocW9Np
         ZC1Yf7JH7AcpRSg3taP/QE/Sp1b7c/+WV8o6hVXEappnRDX9URDMdS5WWW642wjb3Y0Y
         7vathqaQw3Cyg7C3HzVNI6+7eTjgGZPMIB8TbuQ41dhggursi08h3NYSmHn1P6ljmgFm
         jtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686934; x=1762291734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tyjSkBqAxzkn+CQavzu3otPqr5+9CTB8orLK+D0h8o=;
        b=M8Qn/vqLlmHUM2c4q1BbFTwwrZSK/x0rn4LoJZH3vVQAcERTAid3wGiPJ8KQ3zuyIZ
         3OAnSoEHljEBH7KtRpEgfbNbNhiHp44yGYPoPR5pfa1EiJzrBWSa0tSxsnUFEOWtyDJy
         T8U/U5mVXg8PIql7P+IcZ+kPci+ze0Zru5WSyILTRj+FrgmYRyJ7WYrnVFU5r0Cuhwcn
         9jzg/isMDND9V0SWfcrTh3niyqk5B5EEFCwFY8L5jcywO2BsF3cavQezc/GPp08osnzp
         qAo8G9sdJmr53y3yKrAUjXCRMhAY529g74JgCV/t0Ec/I2vfLEpkK2cnJbs0j7Q0Xbai
         uRNw==
X-Gm-Message-State: AOJu0Yzrk0wyLWHIsRBnrMudInn+KEKOVIqFoE56K+IFAvqIGabY2lfI
	nJJ22hT8TleZWv71fQARRnaoD7HeaZC2i7OpOcwBEu+GawD50VEUXcxevr04fSdBUUA1I3lmbVZ
	GZ63jT851krry130vMbAknzQUv/WoHvY=
X-Gm-Gg: ASbGncuE3N1iHGobM6PH2+bCt9NABIq1Q+B1BbLhqcdXnzGzGq+hJG+bwglP3G+NKkH
	HJ4OrUNoi1F1RSK4v+irFa3Y8yU5bhFbh0wZbXCJL6hTYHqcWJbGCm2FR3PMNJVcjs+tSpJcwce
	Q4gwaJH9a/vB2oX3Co+DxiNSVBXWK9VgqlR70N9zTZybMmj9IcUKUj2sa5lzcqnlp9Jbj4XbaF3
	hNUMvdh0xVlXZfSnZ6VwbsC0MAvHLXoosErCs4ppvlWr2KXxd2RWQqMPT4mgtfTrehvcc4MVPLK
	XDQOj9DCtnXjJEHgvdtOBPOrx7aLV7pUvzLg+Y4u
X-Google-Smtp-Source: AGHT+IFy4KqRcJWjHdRCWlntoiPUdZw5jr0pom/+sLkP8yYz2Qzueg3Io+wNxP2TxEMxhJnkyPiCxyS44WeU82u+o3E=
X-Received: by 2002:a05:690e:4185:b0:63e:3994:4ae9 with SMTP id
 956f58d0204a3-63f76d93ac5mr491340d50.4.1761686933644; Tue, 28 Oct 2025
 14:28:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-netconsole-fix-race-v3-1-8d40a67e02d2@meta.com>
In-Reply-To: <20251027-netconsole-fix-race-v3-1-8d40a67e02d2@meta.com>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Tue, 28 Oct 2025 21:28:42 +0000
X-Gm-Features: AWmQ_bmUEQ35ks_l7mvvwHrQYjN5oy2VCaV6asFQr8rvXZMWDCaHNByLiQR7WjU
Message-ID: <CAGSyskVvHvK3R0SQ+yg3050E_btovVY8L2iQ1gUvJ2GigKa5iw@mail.gmail.com>
Subject: Re: [PATCH net v3] netconsole: Fix race condition in between reader
 and writer of userdata
To: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthew Wood <thepacketgeek@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 4:08=E2=80=AFPM Gustavo Luiz Duarte <gustavold@gmai=
l.com> wrote:
> @@ -888,6 +888,9 @@ static void update_userdata(struct netconsole_target =
*nt)
>  {
>         int complete_idx =3D 0, child_count =3D 0;
>         struct list_head *entry;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&target_list_lock, flags);

I realize that we might call WARN_ON_ONCE() while holding this
spinlock, which could deadlock trying to write to netconsole.
Let me send v4 addressing that.

