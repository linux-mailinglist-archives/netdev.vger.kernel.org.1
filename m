Return-Path: <netdev+bounces-49596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EDE7F2A5A
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 11:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE46EB219D3
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 10:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AD34652E;
	Tue, 21 Nov 2023 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKnQzpWm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B73C1
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 02:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700562491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ME8mQZAJfu3KmV5hnIpgicdED11+YLGNGZQG/TCbQu4=;
	b=dKnQzpWmF7YIzUft8mjpn8raS+FyETjkOS75OsOzZiNyOM/P0mWy0dEjexJJUSDmWtaQSF
	aRmZ9ucLctEBkRNL9qRYhQbmDHzgbTGYWjjm0m1A6nEqgfA/v/X4PblIR8u6R79sHW2/XM
	WqQNkV+yR2vaRQXdOzLDG82Uv2t3BOQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-azT4a4w3Mjuxum6257QXHg-1; Tue, 21 Nov 2023 05:28:09 -0500
X-MC-Unique: azT4a4w3Mjuxum6257QXHg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9c37ff224b9so58879166b.0
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 02:28:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700562488; x=1701167288;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ME8mQZAJfu3KmV5hnIpgicdED11+YLGNGZQG/TCbQu4=;
        b=Vtj8PVmYMe9RNIiNt3sqmSwQ3VtcyNoA2lFyha5+6QJN70eIRpAWxJ7qAlfMyHxyN7
         jsLp7qGvykjWccpZR7bvbddllM4/7O0x1ZLywoNVloM+VXzda4xxjth0mP8T3bNTzRi9
         P+VOuvae6/vxx8czJZj3mqHbXmQJI00+iwN57ZkbcP+whh+dEVyF4qZgbXnXDzE2w2Rb
         naVmvTiECmss5DUIQez4zsslxvwrPAdFmybjxaUVdGq00wIS8lv3dJaL/Jeu1ndZ18i0
         EBRi0KIrYK04vGGrkPxoNbshN2jlSQGgc/rwKcswqTs1jFbTS/0jAZnod5XAeYGtoh5N
         La1w==
X-Gm-Message-State: AOJu0Yx++b5kQCryTH9osaBZcOwhTM24s04PXSrolBlEWTK92qPD81XO
	R9cFCpL+A3cekSRFuzPBhP8jyYzmcnLv1s/B/v5TjmlWyLwNM61t0H1qtRBaBbQSITepNx4n8fA
	+qV3nuNijL7pA1VaB
X-Received: by 2002:a17:906:3089:b0:a01:ae7b:d19b with SMTP id 9-20020a170906308900b00a01ae7bd19bmr948647ejv.7.1700562488569;
        Tue, 21 Nov 2023 02:28:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfqBBKQjJPsSCckyoPS3IN1c9fpadiy3GzvbG30dUhcOb3QCInWZGvEZkzEtMTQhGKdrjcjQ==
X-Received: by 2002:a17:906:3089:b0:a01:ae7b:d19b with SMTP id 9-20020a170906308900b00a01ae7bd19bmr948641ejv.7.1700562488281;
        Tue, 21 Nov 2023 02:28:08 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-234-2.dyn.eolo.it. [146.241.234.2])
        by smtp.gmail.com with ESMTPSA id qu14-20020a170907110e00b009fc6e3ef4e4sm2993985ejb.42.2023.11.21.02.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 02:28:07 -0800 (PST)
Message-ID: <4fa33b0938031d7339dbc89a415864b6d041d0c3.camel@redhat.com>
Subject: Re: [PATCH 2/2] r8152: Add RTL8152_INACCESSIBLE checks to more loops
From: Paolo Abeni <pabeni@redhat.com>
To: Douglas Anderson <dianders@chromium.org>, Jakub Kicinski
 <kuba@kernel.org>,  Hayes Wang <hayeswang@realtek.com>, "David S . Miller"
 <davem@davemloft.net>
Cc: Grant Grundler <grundler@chromium.org>, Simon Horman <horms@kernel.org>,
  Edward Hill <ecgh@chromium.org>, linux-usb@vger.kernel.org, Laura Nao
 <laura.nao@collabora.com>, Alan Stern <stern@rowland.harvard.edu>,
 =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,  Eric Dumazet
 <edumazet@google.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Tue, 21 Nov 2023 11:28:06 +0100
In-Reply-To: <20231117130836.2.I79c8a6c8cafd89979af5407d77a6eda589833dca@changeid>
References: 
	<20231117130836.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
	 <20231117130836.2.I79c8a6c8cafd89979af5407d77a6eda589833dca@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-11-17 at 13:08 -0800, Douglas Anderson wrote:
> Previous commits added checks for RTL8152_INACCESSIBLE in the loops in
> the driver. There are still a few more that keep tripping the driver
> up in error cases and make things take longer than they should. Add
> those in.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

I think this deserves a 'Fixes' tag. Please add it.

Additionally please insert the target tree in the subj prefix when re-
postin (in this case 'net')

You can retain the already collected reviewed-by tags.

Thanks,

Paolo


