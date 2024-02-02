Return-Path: <netdev+bounces-68444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2FA846F20
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944421C21A1D
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 11:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E4883CC7;
	Fri,  2 Feb 2024 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5WMhWgL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EE118624
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873953; cv=none; b=h4PrZFUjwtFX9vP9dgpsB3NRwsWBoyQhSU/gErvmZH16mBsoeOpXS9rLnPQOon9QM+4iPTLr9KkVBhkd3XVARziT3G6sRaG1qlsoLUxOM1aaBaIMvvWNfCFO0MsS+ZOyQXvnuXRT45X5ShEUIfgoYClucr4Eq66RuzZlhG3zhn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873953; c=relaxed/simple;
	bh=IkgQSijY2ANu73w7Ozghr6L5TToFQmEFWh8gDo29+xI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YUiVOekQTwwMCa52zAaLdzt9lhy6uueGB7fzEb9YGgL13zjbnJOZG6AfYazXZOW2x8mOUCYisoXbPzieqsebiJyrxzhmOf86umZcKGfoZYcxyiffDnwArkpsG/3BxAZHNv2C9XcUBV20FvMYAFlJCgLb69MRmqm0KxsCqLAib8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L5WMhWgL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706873950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IkgQSijY2ANu73w7Ozghr6L5TToFQmEFWh8gDo29+xI=;
	b=L5WMhWgLHRd8K1oZbwp7COwGfd10HXJWOugmTSdvQ1lchXidjV7OU10TBkZd02eWAgwibQ
	JQh09z4UexiDsccbccuKksqOSroAlbjxxIVGSqeJRf6qw35xQh8/1KxdjerNEMWu27+iIO
	N+tD/BFChumNO61R0PfjMSNbSoLfzls=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-7juMlJ5ePOCuUPHgkPe0kg-1; Fri, 02 Feb 2024 06:39:09 -0500
X-MC-Unique: 7juMlJ5ePOCuUPHgkPe0kg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a2c653c7b35so130467466b.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 03:39:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706873948; x=1707478748;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkgQSijY2ANu73w7Ozghr6L5TToFQmEFWh8gDo29+xI=;
        b=KZM1NxOS+JRuWGa+3l3OYXGt8THYerMIrqSov2GDuLPWkwUk+YT2FTqjc7NOmDhbqA
         DDfTP3FdN421nVr9ELhwNsg6AeyJGotQp/wMymdXwgwft6jMde0ve3XhqxMnmuoivYSA
         BsANJMJQFFaYeZtK8pPL2DYjWIp96V/OZ7jJgVAuwYf/bPrF1Tl8TC4qXQ8oKNLpZ3A1
         DAtgVjri+FTa/mnnjEAuT9elBPnh8OmYUG38P5RcrIxQiTBbhXeZPwI8oRQqw+rasTUi
         JZnjNk97xxgvvgVTbbqOWeU3CXud1p1CRwhh0ukZ5Xr7Kvot93qDV1kLAFcYNKKLyCVN
         OE9g==
X-Gm-Message-State: AOJu0YyHuimvNnSE96FKz9xPu6DnzIfLvbcBw8QPaFLmpeoDYDs+KCc8
	19RTfnZoCphj2xuRj2R5ZZ7HYhyd15fK2FbVY3B6DXQwHL3+JeAKgwgMfUW2xqFGVmusJwGzXDB
	bU1mqRfM6TceP3ykihnXwWeb6LkambbSgXmsj0kFVkmGJJ7Ge8GBcBg==
X-Received: by 2002:a17:906:2318:b0:a31:2c12:9884 with SMTP id l24-20020a170906231800b00a312c129884mr6649754eja.27.1706873948245;
        Fri, 02 Feb 2024 03:39:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyCdyuE9wYHbSSl/wdNNhCE+esIm+aNUWZNN7/JpF14c+Vm5taJknoAhFlfPB/jmP1y7B53A==
X-Received: by 2002:a17:906:2318:b0:a31:2c12:9884 with SMTP id l24-20020a170906231800b00a312c129884mr6649724eja.27.1706873947911;
        Fri, 02 Feb 2024 03:39:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWaPtTS9iAiDOduyDmmaTzWLzQ8OaZIvm6nXYM69vUJ0WzIawA6mFDZq3+u1SM8cXyU6lx4Efqxyni286qb14/pjUd21sMevZDxganWt+RineXgPyKCIFyzkDcT2tpGd7RZnAN9TmvVBYl+73+poUOwYmZzeEnNprQQMj7wECKlcCgE7A0C33H7/wFvNvgCQzHyC9uuGT2UtE2EubUMNuqEMPdaKMR5nD+9FbTqYpaI4HI2BnVl8kIohJ9x3ra0JejzLDYO6z2C2BchwRZ704aCC5k94rB8bZaEnrRn/hBrJ3Ox6dMzOY4lp+D7bhmUpcwWBLC8Lnzc/tW72O2t+zjrk5pG+9t8ZFZAhm97om+N5kGmaH+yq/sr2Oxgw4WKhC9u8aJaVSua3WKj9v3QJ4QKIvxl4s0=
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id vh11-20020a170907d38b00b00a36fdfd5f52sm659116ejc.204.2024.02.02.03.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 03:39:07 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 44010108A837; Fri,  2 Feb 2024 12:39:07 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, bpf@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, jasowang@redhat.com, sdf@google.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org, linyunsheng@huawei.com
Subject: Re: [PATCH v7 net-next 2/4] xdp: rely on skb pointer reference in
 do_xdp_generic and netif_receive_generic_xdp
In-Reply-To: <77fa43b08294e21a8e030c04a368b93007e4f7bb.1706861261.git.lorenzo@kernel.org>
References: <cover.1706861261.git.lorenzo@kernel.org>
 <77fa43b08294e21a8e030c04a368b93007e4f7bb.1706861261.git.lorenzo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 02 Feb 2024 12:39:07 +0100
Message-ID: <87sf2bxfhg.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Rely on skb pointer reference instead of the skb pointer in do_xdp_generic
> and netif_receive_generic_xdp routine signatures.
> This is a preliminary patch to add multi-buff support for xdp running in
> generic mode where we will need to reallocate the skb to avoid
> linearization and we will need to make it visible to do_xdp_generic()
> caller.
>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


