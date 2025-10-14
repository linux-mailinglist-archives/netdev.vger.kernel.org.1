Return-Path: <netdev+bounces-229035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A576BD7478
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 06:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09373E819A
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 04:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0570E30BB86;
	Tue, 14 Oct 2025 04:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fjg5Ts3r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F0A30B532
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 04:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760416914; cv=none; b=D4YyGtTdo+IcofwTP2f4oRjEKjQnnviO66lguPcVkCXIQvyL9OCW4Pc+kddsAKiGWh/sC/7+NG5DgydMrVv/qUKUxUFB2OubyQvaBvOD8KPXG58KgdwsmdbwyTyvFScVyjexEFuvmUuc/xKrfKbsEbqwyzv4mqm1I0XgxE8exSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760416914; c=relaxed/simple;
	bh=HkIZGagwqQSK/Ux73E//1WE05pc2dBkZn1z8WlsOsmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBkKa9oL0t8LTw669PnC8frkYVgHvEa4tvqcdAO7j1fu0J6dmGbj2ScfpsHuXafqt4ADPN6sxcIICGiMy9PPrgWoKHWGvO7iGGsVBRAiaIcYGibByPvgrWwb76wirwgWuVoReiVWaH7pfrB93BrpVa4cjyrc/qYZWctXKEaDDOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fjg5Ts3r; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-58877f30cd4so15615e87.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 21:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760416911; x=1761021711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/H993Yv05c5jEdeR6de+2fECvHc6eeWZhFT1JvbrSFk=;
        b=Fjg5Ts3rb495TT6Yz5OTQCOUFV2w1Lr4ec0+zT8Kv1m3K1n6tmGIo8yuSwaOq/B8GT
         R2sR3qTRX4dJFKiccoz75DpUlfX3eltiZUp7qYsUHKHazetX2H1i0UwpgSbM1y+Ra1pi
         dGnO4MDyMVzEkByd/f6iuZFdxWgMJ/f4AwRTeEIASbYLOEz5WYSaGxrh6KxENeV6YRtF
         mymSUb1GnjRntLiaO9L2/8JyQr6T5VU8sW9VHLagryK5TO41AQ8sQWlFsaQLKs6gXWdI
         m7XMicRMLoeYjwiwNcbIzrCH0JDmEnB6l14qItiOukeZpTUwKoTlBTNlxOP/btbAtT7P
         aDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760416911; x=1761021711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/H993Yv05c5jEdeR6de+2fECvHc6eeWZhFT1JvbrSFk=;
        b=u4RS+FHIEunTBZ0eVeFzQad5eJwUXiir11+3CAgejq2pJ/qlf5to5xMau1bOUty3I3
         FkkS7/esTlcFieYH6srIXAGy9gEfz9sPsT2O65X/J6CqADpMwJLCP+yrSJjiMfjcYZ+z
         D1ZOSFK8xieH/woz+uGOiy1q25XCvS08CU0xTuxoWryqfeeEx5HkQL1ctsoxfCM8KzsQ
         oNLoZrEz+6wdaNtDxmjvO2pDZF80wzxIKQkJLqTPqPYTBXwXDcpQh7Z7d9cBljGa1CFQ
         g++EqYYwIRUhY1Zv92F0CeCY7UcmfY3pX6ybMp0eBoimYGUyOvZFWfWaqpsLO6W3MCzQ
         +1YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZZsC+9aGvTAHtFZmzdApGUIOhDukBVPF3lpqKPYX6qZB/55eyfELfbzBbni7DmaieGX27amc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkIv9S/x6yRo7JOPGwXd+eAlwnL6Rbqo+CrcdfSWxL6e7+fObg
	GFQvXRQ2SYX/vJm5FZbJA+d0IF1deMeS9AQFtLzfKtAB+Y3WR3N/a+7K0UrLh15Enmkm5Gj1q/e
	NpE/ch9tfJcrgTxq9q1oYM8Up3B4XZ0zXIncj0WQQ
X-Gm-Gg: ASbGncsdnO5CWNa7IzyXdMQchj9qJxANyr8b4/CANxXW6TjU5LjqB0d6EcERVzNktzR
	ob1iVbN+LJuS+lXO50Tw4r55xmj/jn0Eo1cH6Hk/2WqcmvfkXLC278deEMd6eoxznwHQh46Y5u/
	SjF4s/IZeN6VlM0KamOrJxmw94x73fe5Nv/DPMlPCAWbcpfp8Q/2aRrCl5fdIe0w0eDZMmnbzU3
	bvlWe//R5otEHVaaQao9O6pomCcjWLeBJBM8AtSO8QC
X-Google-Smtp-Source: AGHT+IGO2N6eEZzAYyKaq78kUeEFq20BCf9kSNKrULoXVn92wigmiiTTyiqOtJSWbFILRsrzS2mx9pVSEawVxWJPTh4=
X-Received: by 2002:a05:6512:6d3:b0:55b:9f89:928b with SMTP id
 2adb3069b0e04-5906e383503mr43296e87.1.1760416910537; Mon, 13 Oct 2025
 21:41:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760364551.git.asml.silence@gmail.com> <20251013105446.3efcb1b3@kernel.org>
In-Reply-To: <20251013105446.3efcb1b3@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 13 Oct 2025 21:41:38 -0700
X-Gm-Features: AS18NWDsUu_PMxJh1iCf-aXLBKzwTZ_46MmoA7_5elnWV_3Q5KDGegO5lPk6knY
Message-ID: <CAHS8izOupVhkaZXNDmZo8KzR42M+rxvvmmLW=9r3oPoNOC6pkQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 00/24][pull request] Queue configs and large
 buffer providers
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, 
	Jijie Shao <shaojijie@huawei.com>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	hariprasad <hkelam@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Joe Damato <joe@dama.to>, David Wei <dw@davidwei.uk>, 
	Willem de Bruijn <willemb@google.com>, Breno Leitao <leitao@debian.org>, 
	Dragos Tatulea <dtatulea@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 10:54=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 13 Oct 2025 15:54:02 +0100 Pavel Begunkov wrote:
> > Jakub Kicinski (20):
> >   docs: ethtool: document that rx_buf_len must control payload lengths
> >   net: ethtool: report max value for rx-buf-len
> >   net: use zero value to restore rx_buf_len to default
> >   net: clarify the meaning of netdev_config members
> >   net: add rx_buf_len to netdev config
> >   eth: bnxt: read the page size from the adapter struct
> >   eth: bnxt: set page pool page order based on rx_page_size
> >   eth: bnxt: support setting size of agg buffers via ethtool
> >   net: move netdev_config manipulation to dedicated helpers
> >   net: reduce indent of struct netdev_queue_mgmt_ops members
> >   net: allocate per-queue config structs and pass them thru the queue
> >     API
> >   net: pass extack to netdev_rx_queue_restart()
> >   net: add queue config validation callback
> >   eth: bnxt: always set the queue mgmt ops
> >   eth: bnxt: store the rx buf size per queue
> >   eth: bnxt: adjust the fill level of agg queues with larger buffers
> >   netdev: add support for setting rx-buf-len per queue
> >   net: wipe the setting of deactived queues
> >   eth: bnxt: use queue op config validate
> >   eth: bnxt: support per queue configuration of rx-buf-len
>
> I'd like to rework these a little bit.
> On reflection I don't like the single size control.
> Please hold off.
>

FWIW when I last looked at this I didn't like that the size control
seemed to control the size of the allocations made from the pp, but
not the size actually posted to the NIC.

I.e. in the scenario where the driver fragments each pp buffer into 2,
and the user asks for 8K rx-buf-len, the size actually posted to the
NIC would have actually been 4K (8K / 2 for 2 fragments).

Not sure how much of a concern this really is. I thought it would be
great if somehow rx-buf-len controlled the buffer sizes actually
posted to the NIC, because that what ultimately matters, no (it ends
up being the size of the incoming frags)? Or does that not matter for
some reason I'm missing?

--=20
Thanks,
Mina

