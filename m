Return-Path: <netdev+bounces-189772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EDCAB39F5
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F6D3A8AA6
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA921DC1A7;
	Mon, 12 May 2025 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+FIkSUc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC462AD18;
	Mon, 12 May 2025 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058636; cv=none; b=RZI7xHfrbia7Ra5iUaBKGpsudKNi4PBoMn1knPdhCZXTnXjnP/3HGzcMNYONFN4umtGQqAXWorcaGvVacfjTAuiOOmEhM1u30n16mpc4iEyb3pNgYwqITk/eM5/utMieBoJkcT5Rb7A6C3t8hzl063qlrSwtcAf+KmTnrhX3C1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058636; c=relaxed/simple;
	bh=Wo2gtYcy8F8/HRgD/mguaoCC7Ih+VqVdVr7p9Tj2BO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqWi9oB/gy0yocuI4gXagggQ/2ZcGBCPXMXF+TpwSPGFB9KXyPdppeCJl804hLjeuvXI6zhuhFwdEtc983Cwm14lxFeGJvUrFIk2MV9xZNnyaw7UCgVzSeJfMQzPVxs6cPkO0LJpzuGqoT4BTTUjanrDhkSUEcyBRjpowKnxd6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+FIkSUc; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2d060c62b61so4516610fac.0;
        Mon, 12 May 2025 07:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747058633; x=1747663433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dLb+JRGLVFS0BSqKTkNSyQIkAQdMTPXYGYGh/OuIIrg=;
        b=P+FIkSUc36fwfhemX9NbXd6s9GPZHrxjVog9KmBKEzyVj0fyRP/fK130e5TgDZExP6
         PuhbFm/zf3m1Cwv2yLzGuGHIxqCd/UFNideSXJYrzHibdTlK9tX19hnSvBPsDGycHCR+
         FRHS0Sl3h8Drnvd2PHSnxQYI10OIkpDqt3MWsvL6Ye08npyVgVzEJ0AsfB5d5ZF3ig+z
         kN9AYDIl3IE5xfSl12TJOhMdGlFYjnNoWOaWrAHooMpYJ/7xUqHVUQk+WcaCotcouj7a
         xlIySSGNZ5hMe4f3yTCGA0Amk4t3jr9DSFT49j+xflfIYZsPuGS/oEWlMqW8GBkvrKBL
         s7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747058633; x=1747663433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLb+JRGLVFS0BSqKTkNSyQIkAQdMTPXYGYGh/OuIIrg=;
        b=rM/EZ1jLBgbKqqievYpC5VTljZsi8taKxNf7PUh8iENxLIAEYrCX0ziBS0kz4yOk/P
         I1wdPWfiWdtXC2667gNX9xTTCTd9cIjS3dq6hMCTpLJIehwFILDdViysYuoktnqh+RDb
         ziM1zp36MEeRzuVdEkpy+CRdh5gJ+9sE719yu+ySGnzy95uNEqss2unblxjqDDhXyRD2
         wAl5FkKIItyvfzNM7lL4AxEwYq+bh568CclMptahyl8rcZUpUbK8VJed4Y7bj7Ep1D3d
         SnNoBJycW95Z5Jr3QlisOY9g93DH9g5oyQv7Qr7CLBoNUXB+f9U5YgY8g6bXIU768jFk
         /vgw==
X-Forwarded-Encrypted: i=1; AJvYcCUhYr7vRhnLJEELGoWueUBy0rnJM7Z4mnJtbpVEBiZXHh3Rbu7DFvFTFmncxxRHFLqzW1PHGvDD1B0ld1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJDDA7WRmkxguxGJwaLOGo7gduYjbTrJTjh2oBhT+vXeC7Wq6S
	pNlevX60imor7FhTiAUPBd3+t90MnThFY1yqvMgqpbtpYaTDXNSt
X-Gm-Gg: ASbGncvTtFbnENRJOI3ADbdmfCEk1oSlt2BckSgu8Hzy29DZYb5y1jj6E3fV45UQU3A
	3IXEo46vLJvVm5mxLWw3q003SD4Q3SWH7LaAMNOx/glGlDF/p+DuXE/dHBgAl1/jlcqIPfhBjYZ
	WygsOi2yV/NR/U52pzePd+eTiUzkcRe7+sHx1gkQk0IERgRXIlT/0PRB3KkTms702l5sxNuyfs7
	IP1qK8cRhKBiOgqPUxzjbxPUGQa+IikaNtS3rVfwthtJgHIH/3tUN5bp3cfylvVmiklXYd5h9A9
	6U3uvNWB32zxAfK382qZLcdgdi1RXoM++JgYfy3dg6DNcFi/TUVzqNTmkKiMJWw466c0CrU=
X-Google-Smtp-Source: AGHT+IF1tkZYqYyXXtjmaPTB+Gkqq74Inf49XWAK+PjfZ2RlQ2OoYywpaAUFYYJ6wzuQTsDoXjEWhA==
X-Received: by 2002:a05:6870:5246:b0:2c8:34df:8c4f with SMTP id 586e51a60fabf-2dba453cc52mr7464382fac.37.1747058628114;
        Mon, 12 May 2025 07:03:48 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-732264d59e1sm1553171a34.34.2025.05.12.07.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 07:03:46 -0700 (PDT)
Date: Mon, 12 May 2025 07:03:43 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Xing <kernelxing@tencent.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] docs: networking: timestamping: improve stacked PHC
 sentence
Message-ID: <aCH_v3fSZXROUHpD@hoboy.vegasvil.org>
References: <20250512131751.320283-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512131751.320283-1-vladimir.oltean@nxp.com>

On Mon, May 12, 2025 at 04:17:51PM +0300, Vladimir Oltean wrote:
> The first paragraph makes no grammatical sense. I suppose a portion of
> the intended sentece is missing: "[The challenge with ] stacked PHCs
> (...) is that they uncover bugs".
> 
> Rephrase, and at the same time simplify the structure of the sentence a
> little bit, it is not easy to follow.
> 
> Fixes: 94d9f78f4d64 ("docs: networking: timestamping: add section for stacked PHC devices")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Acked-by: Richard Cochran <richardcochran@gmail.com>

