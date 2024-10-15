Return-Path: <netdev+bounces-135467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C1699E091
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD122B20F9B
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5BB1AE006;
	Tue, 15 Oct 2024 08:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kKdhYobI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF671AB512
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 08:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979994; cv=none; b=nyELbKJVdIoZCdqBT2+PxIFWtjmOFCmGJy4oUK2s9+8Cdq38Jrvn61XqWMKkylOiKiE1At9HkXLN8CekJb3a1Otc1Tay8kopq2ReFP3qlUxBAnBgzEoMqteVM43gCf5nXPyzLf3PnljVZtoh8Ng4p+j3K3KlWCSl9J4E4fH5Fa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979994; c=relaxed/simple;
	bh=P3FMywqnNGquuZZGSkU2EwOtO2dk/J3t68nOwd0zwUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCC2VSWG/eLAyap14pXIi0UeFREWRVO4XKrpo9sy7vYbiLcoClHGs3yl7LM2d4rmqtHkaBs/hzmuo85YLywMhb8BueGecd6RDitl8t9YyIlyo7nBy/WsLocVwiNFGJxkNO9kFswQXklaIvC/tUJeTpQZRCUJiJJ6ENm8lgkrp2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kKdhYobI; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c97cc83832so2257415a12.0
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 01:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979991; x=1729584791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3FMywqnNGquuZZGSkU2EwOtO2dk/J3t68nOwd0zwUQ=;
        b=kKdhYobIqN7TeORazdY1NEJ7mCtuX4wtmbZejuMKOXmpZahafKEwCO8lpE5xO8LlWQ
         DPRzvjyaAS8vcCaxh7XZFNCwJX5xuaOfMO+BlnPrvXnkYUn9LoHF7aPL32Z1AqJ5bHAR
         pZSLPqEuNPBr28QQlcQLs17UghaVvjDU0+Ox+FWemDZS1aTupNd5nJ2aKAljyj127I1C
         FtFval6plvIjI6rJ/yzJHxsqzZ4t3IrXU/PsFRdxdPMVsDjvU+/rQPb0/56khhWprUm8
         beJwLUopTIKn1RjPTkkiVi02w5fi5mBXUFZxMgCaD7fnHNX5hR03wzHGksu6OYlKvo7O
         l2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979991; x=1729584791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3FMywqnNGquuZZGSkU2EwOtO2dk/J3t68nOwd0zwUQ=;
        b=DpQU4WOyDHSmdE8v42FYTSb2egEUGB3YrZo8ZTU3GN8X60T34ln19JB+Ovx9b/TxNj
         pKuu3trg9igflyadJF7vGvHPoZ3s3c1ZpkddspYDQ0q4wZVeYD5ujOptjoPUsobAsVD2
         hHBsE57RKdpOv/s45zWs+ojpH+4br4IYSjUKc8j7Ir1ALzF3V6NKhf/nzZWlJKBwsWdy
         Gzipi29K6VdNn3a2gEwpQoiJr4WfLSAIzVcxXHGkGQLVwWiCzxw+oCd0vGEH3aMHktHs
         F2g9JG2YMZdo9YPndQ1iI6K/ZFln3CmeoMf75roGYbY589zlM2lay/8zSn8Gwxvd3nwu
         OhhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhhpc8eleRqVeQkqVLvFMmm2gIiUL7kXB45JuCNuSojttLnf6g2PrM6MZA1Dl4oWXxUL8qXEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7mvFq09Sd/LVg8biWbh4FGzG0cLhNhBDGpQ2y2UVCCKnNjN4x
	YrXFDAO+A5N3SqlZyJYEvVrA7iGGEH725/jyDWCPOekhZq0OEJ9xUONOrdNukuHrj+xkbxfzDHc
	2qBlJQ45EwKhN+Y5lAI4JW95egFLGCga8CweY
X-Google-Smtp-Source: AGHT+IEU4wEvDgzgXZNh/xC/9FCAcOdcylUmrJFNg6ULu5XEBGX57uqe3aYI52GT1hhWqfsmPrT3qfjpUb+j0P5YtnE=
X-Received: by 2002:a05:6402:2805:b0:5c9:4885:85aa with SMTP id
 4fb4d7f45d1cf-5c948d808dcmr7353311a12.31.1728979991294; Tue, 15 Oct 2024
 01:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014201828.91221-1-kuniyu@amazon.com> <20241014201828.91221-2-kuniyu@amazon.com>
In-Reply-To: <20241014201828.91221-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:13:00 +0200
Message-ID: <CANn89iLZVL4VGUh-=O+PJ8n+3agwOswu0QVDua4mp8RD5q4mQg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 01/11] rtnetlink: Panic when
 __rtnl_register_many() fails for builtin callers.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:18=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> We will replace all rtnl_register() and rtnl_register_module() with
> rtnl_register_many().
>
> Currently, rtnl_register() returns nothing and prints an error message
> when it fails to register a rtnetlink message type and handlers.
>
> The failure happens only when rtnl_register_internal() fails to allocate
> rtnl_msg_handlers[protocol][msgtype], but it's unlikely for built-in
> callers on boot time.
>
> rtnl_register_many() unwinds the previous successful registrations on
> failure and returns an error, but it will be useless for built-in callers=
,
> especially some subsystems that do not have the legacy ioctl() interface
> and do not work without rtnetlink.
>
> Instead of booting up without rtnetlink functionality, let's panic on
> failure for built-in rtnl_register_many() callers.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

