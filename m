Return-Path: <netdev+bounces-114813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3166C9444B5
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 08:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62EF61C21172
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 06:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4FB142625;
	Thu,  1 Aug 2024 06:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CA8CQIZ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816E1BDC3
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 06:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722494884; cv=none; b=saO9Y+eQdOehtM9JfqxebUEzM7YLLyrRSm5A7qPWMOKl0y2xNA7CtbeHj1elKJTBXJ+H0d25IQV+DLF7JewNWGAdUPhncwuRsOXCucetKUfN6KFz7IwJHIi9FWazkvn1b9kWhKXhh6hkzxytcJRFnJAvoEnviSEQtf6PvGFruao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722494884; c=relaxed/simple;
	bh=SCbjmYWE026lyqsUC649Q0NoRKfYlnkJrUIwZvj9DZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dR0aZrJrRJoBM3m+bpN93SPSpsAeylNCNQ7vKY9cjdR8WAjmgWY/svp6wND0dT5dD4HBn7SI/9Dw217SaNZbEaoG2BS2PtPzAIb2neTcYjStxl97J9pYc5xeLOn/nBw0WZw7jq8sr0hAPuLksiJHWKWqYMu7stUsR/JKtQFJSiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CA8CQIZ9; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so29313a12.1
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 23:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722494881; x=1723099681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCbjmYWE026lyqsUC649Q0NoRKfYlnkJrUIwZvj9DZc=;
        b=CA8CQIZ94m3pj0+qVu0QbTNC5uizJF9L1oFsY1zxi5fRBsSUbPnitP6Jp90+kDKEGh
         LpQLjh/eaiOcZ6Elbd/8cCjucfK7ORtfFjMR6jdejyWaAmNt7etvdk2r8+eDtM/L3IHN
         s4tBKcIvyW6YmXr/clE+aD8VtEaozVjehWXu6Rc+VVMTYwCoa4rQPvw1zFrMktf+uYjg
         3U9RvPt+HP1eoMr2dCJAkog9URUhsooZdzqfxTsWVQZIfkDsVPISNafielxP7ze1W/H7
         3S3BSLrlpMmBT0kss7Y3wB8GCZ24LQvq9hBzZyQpey0w0n8PYR1Tg5XKEZZe8CGqkm6S
         Q4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722494881; x=1723099681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCbjmYWE026lyqsUC649Q0NoRKfYlnkJrUIwZvj9DZc=;
        b=XsTIVm6vV2ykUGfMmbhU+9nLU7RJwM/n4AbO4RaZLiHiA/hbVZhUZqEwrrBj48zFeW
         afrOJyFCiwMZFg0sMQEmsXNIYLZ7jOHfxMvnzSijbz7IwZ64FonaTQj09ovnRbZcZ71G
         5tdDCvpWQcedOU2Y18jkImSwyggtns633Jgm14Ljy+NLwpK+BQPJ3JopiKOjZJ29u9/M
         CtsmvN3aux2L21TG6ZMahHGiVCYgnmGb91q8g2+h0KdFYy3WjbwVK8sQFuRyQtlawfrE
         zO9QjrKxpl7anY22U6gpCO6majZv46R4tVf46MyqnJkDs7X5zxi+v3hSsTnmQvMijsPH
         +jYw==
X-Forwarded-Encrypted: i=1; AJvYcCV9mIlFl1Ji9wAmU+K0S3Hyz0zFjekP/xQ8iF2fxdefgy6x5msW1j8fxnpOi90BNg4CFiF3jeXRcoA9VaVcmaeW8sJDIJ44
X-Gm-Message-State: AOJu0YynAUJV/lfVpXMkelQvi3AHnZ+vBhgfCYkLbQfMcv9fsZl7PgM1
	FeqL5+yB52FHcLUuOr0KlxgAKUJm9HNZ37DZxEvhooXINYI9YzKnulGqi77wLMxajMHh4LKauLw
	lQf3ZGEWNBViXj9GkQL87vd024qBTRgPgXnH7
X-Google-Smtp-Source: AGHT+IGtRRPtFOftj57jsRl3wKBXupdR+EFXaJVN8mBkaxqUT0Z28qAyROIrE0p5YXDuPYouJL2xksZDg8W5nEU8kgs=
X-Received: by 2002:a05:6402:350e:b0:57c:c3a7:dab6 with SMTP id
 4fb4d7f45d1cf-5b740495c3cmr51701a12.3.1722494880248; Wed, 31 Jul 2024
 23:48:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731120955.23542-1-kerneljasonxing@gmail.com> <20240731120955.23542-2-kerneljasonxing@gmail.com>
In-Reply-To: <20240731120955.23542-2-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 1 Aug 2024 08:47:49 +0200
Message-ID: <CANn89iKbUSVeW2zWLk=njDGagBxzVS-zX18EPPn+FbS3TGfyiA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/6] tcp: rstreason: introduce
 SK_RST_REASON_TCP_ABORT_ON_CLOSE for active reset
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 2:10=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Introducing a new type TCP_ABORT_ON_CLOSE for tcp reset reason to handle
> the case where more data is unread in closing phase.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

