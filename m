Return-Path: <netdev+bounces-56409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCAC80EC6C
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 13:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06B61C20A8C
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 12:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ABA5FF17;
	Tue, 12 Dec 2023 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ze+GT1NK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31963AC
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 04:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702385258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q0FBMZQ9QUANOYHqvjRcTYLvJnFJ7N1ACRMaqbFvpBY=;
	b=Ze+GT1NKygFAfQPJ1+5sW7rL0A0ruTaQ+a3PlroEpfgGnoO3EOo/HXYhtvdblmJPuX5F/h
	69UmNCA4nZt6FI1A2TgaNa7O8U4eefjyh/XzgHrhrRFxhJpYQE6yn3KFap7QFTW4hmX5BO
	iPh2fP6s1crvlz5UALUip37jRPnXuOY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-WgRns87yNWedjxE3ys1kGw-1; Tue, 12 Dec 2023 07:47:37 -0500
X-MC-Unique: WgRns87yNWedjxE3ys1kGw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1e27c6de0eso119901666b.1
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 04:47:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702385256; x=1702990056;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q0FBMZQ9QUANOYHqvjRcTYLvJnFJ7N1ACRMaqbFvpBY=;
        b=CnjWlk1mkKdo2cpfjCac3D6xiUQJFyZpjrQPrv86jkbieawyHhKUPnHw86RTGtqyfo
         d2dqT8O98SQ1melHkkjr8Ps2I2jKcW3qpWXQ4JG35KpUlTof5pii1OvfxX0pg34OaOAz
         zHhmlUZDT8fBf4fekFOIX0bZkWW0GOYlCNuJTj6sZal3jlmo/RaISthbS1pCc5odc/aI
         9//sen4XOcOm7BOl9K2hAYq+nyhBFlNaRbABFg9Ti14Y4dfubyfMvoOiMcNJs6/lXmaN
         TiUw18q7jdOjmyoP9YGF2Tr3xpaTPW+fFux2diwdNxJK9Y5io4Fa04NLrfqCe+V9mvZ4
         hD8Q==
X-Gm-Message-State: AOJu0YzR4ocJ8Q2DFAdzLnvR1m0FfdGDoVo+RRsYBiX4EnTjIOzIIgqH
	3fhRLuCWCc77L5q8Hj3DNfkj7+J8jZlB+LQzTHaUUdQtjSa1Zkah/0Li752XH/m1F1II+9K6TCo
	BeFEw6kY7KB3XTtfO
X-Received: by 2002:a50:d5c2:0:b0:54d:2efd:369e with SMTP id g2-20020a50d5c2000000b0054d2efd369emr7023570edj.1.1702385256050;
        Tue, 12 Dec 2023 04:47:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHqy4GrXr69uCzGEx2t3IJBn0DSLLKIfTG4bcDZ3pgGdsgj36Z/xVbt9bSGwQwWtaK4ZEDHg==
X-Received: by 2002:a50:d5c2:0:b0:54d:2efd:369e with SMTP id g2-20020a50d5c2000000b0054d2efd369emr7023561edj.1.1702385255732;
        Tue, 12 Dec 2023 04:47:35 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-182.dyn.eolo.it. [146.241.249.182])
        by smtp.gmail.com with ESMTPSA id 28-20020a508e5c000000b0054b686e5b3bsm4807668edx.68.2023.12.12.04.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 04:47:35 -0800 (PST)
Message-ID: <f430f10970ee96c6b2f470ce53aaba81e7772b8b.camel@redhat.com>
Subject: Re: [PATCH net-next] net: remove SOCK_DEBUG leftovers
From: Paolo Abeni <pabeni@redhat.com>
To: kda <kirjanov@gmail.com>, netdev@vger.kernel.org
Cc: Denis Kirjanov <dkirjanov@suse.de>
Date: Tue, 12 Dec 2023 13:47:34 +0100
In-Reply-To: <20231209103335.11532-1-kda@localhost.localdomain>
References: <20231209103335.11532-1-kda@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-12-09 at 13:33 +0300, kda wrote:
> From: Denis Kirjanov <dkirjanov@suse.de>
>=20
> SOCK_DEBUG comes from the old days.=C2=A0

Indeed!

> Let's
> move logging to standard net core ratelimited logging functions

Since the macro is then unused, please also remove its definition.

Cheers,

Paolo


