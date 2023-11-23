Return-Path: <netdev+bounces-50427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C407F5C2F
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 11:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2340EB20EE8
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 10:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4086F224C2;
	Thu, 23 Nov 2023 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FW7LZry9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45656BC
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 02:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700734901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sgtmdSW98J90Kfrs7HiPvT9RZVZuwuMmB0Gp4wHhzs0=;
	b=FW7LZry9+savVC1KQEIigDUnKjwFpVD/3px2n//2/5iRtkkqPQve1zPM/BUgZzo7T3rMK4
	I+2bGQKqupH3Cw5eHEqAOzlhkB1Wvo8lLPT8C9OcqRroBhD9bzi04CBqfJVOb/duf4eAWR
	PBDUg93YdejCk3uImmcgxDfRdQxihqY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-ZK3z91azPoWhGsKRoJSaoA-1; Thu, 23 Nov 2023 05:21:40 -0500
X-MC-Unique: ZK3z91azPoWhGsKRoJSaoA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a03389a0307so9757466b.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 02:21:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700734899; x=1701339699;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sgtmdSW98J90Kfrs7HiPvT9RZVZuwuMmB0Gp4wHhzs0=;
        b=aPpbESfnxfyfeqGM/jaCAcJ1ELBpQqutwKtsQ3JYcPUnqQCy0QUz0O66p3o3dUOg0i
         zJynfdUsdqvRkN4/9sw3ljIsUwqLrOY8NlqtImnGGbZ1DzsbfszSpEPScVj9I2VH1ESO
         g1nyJOYc0QcjZ/HL4+ghia2lEN0RlXWURrjBDP5vh/23hMnXA4VXlt3Za4s8Bq5G8cKF
         L2zsSGkqYMzqNkS3T0rn1Z3w0nAwA6dCZseuvYf6mMrJ6T8viQpmhOsWUXWY8PJGBzVL
         f41lf+97cY9ZQPHEVnxXZ/BurTSgZc++nkAvkzyo0i52L3Kmz/vz63/uW0izPIf7Y2mM
         /61g==
X-Gm-Message-State: AOJu0YzeeFOccT2WInMAoWJf7byUIu2RDGbb/a4WJ2xDWraMwhdhF3Tm
	euPP1eAbOaEYjBoY2FtQXvXfTZMe/yFQVmTD2nq3IxyLxPwOKVcV3huFQXPNuC2k0sm0dY1muVl
	kQqIjV99ENNQJd2xA
X-Received: by 2002:a17:906:10cd:b0:a01:8f8c:ea9 with SMTP id v13-20020a17090610cd00b00a018f8c0ea9mr2938367ejv.7.1700734898915;
        Thu, 23 Nov 2023 02:21:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9/qQ+NdZJcbqQ0VKAwLvuSjGjtIxOO3YUeVJI75tXFZhR3SCYSFE8g8GINDJP9qeeh8oRbA==
X-Received: by 2002:a17:906:10cd:b0:a01:8f8c:ea9 with SMTP id v13-20020a17090610cd00b00a018f8c0ea9mr2938353ejv.7.1700734898554;
        Thu, 23 Nov 2023 02:21:38 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-213.dyn.eolo.it. [146.241.241.213])
        by smtp.gmail.com with ESMTPSA id ay8-20020a170906d28800b009b928eb8dd3sm587756ejb.163.2023.11.23.02.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 02:21:38 -0800 (PST)
Message-ID: <92d95955f66098ce725729243251beacc2823a81.camel@redhat.com>
Subject: Re: [net-next PATCH v3 2/2] octeontx2-pf: TC flower offload support
 for mirror
From: Paolo Abeni <pabeni@redhat.com>
To: Wojciech Drewek <wojciech.drewek@intel.com>, Suman Ghosh
 <sumang@marvell.com>, sgoutham@marvell.com, gakula@marvell.com, 
 sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net,
 edumazet@google.com,  kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,  lcherian@marvell.com, jerinj@marvell.com,
 horms@kernel.org
Date: Thu, 23 Nov 2023 11:21:36 +0100
In-Reply-To: <ee30eaa0-2a1f-4dc6-8e03-c2d993eb159a@intel.com>
References: <20231121094346.3621236-1-sumang@marvell.com>
	 <20231121094346.3621236-3-sumang@marvell.com>
	 <ee30eaa0-2a1f-4dc6-8e03-c2d993eb159a@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-21 at 15:48 +0100, Wojciech Drewek wrote:
>=20
> On 21.11.2023 10:43, Suman Ghosh wrote:
> > This patch extends TC flower offload support for mirroring
> > ingress/egress traffic to a different PF/VF. Below is an example
> > command,
> >=20
> > 'tc filter add dev eth1 ingress protocol ip flower src_ip <ip-addr>
> > skip_sw action mirred ingress mirror dev eth2'
> >=20
> > Signed-off-by: Suman Ghosh <sumang@marvell.com>
>=20
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

Thank you for your review!

Please, additionally try to trim away the irrelevant part of the patch
when replying (in this case almost everything). That helps a lot
following the discussion, especially on long patches, thanks!

@Suman: please retain Wojciech's tag on next revision of this series.

Cheers,

Paolo


