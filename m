Return-Path: <netdev+bounces-104718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8199190E1AB
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 04:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7124D1C20FFA
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 02:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009FA481A4;
	Wed, 19 Jun 2024 02:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHH4tuEO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE1527446;
	Wed, 19 Jun 2024 02:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718765052; cv=none; b=Giw17k/gy6o1XBgFrtu3o3cck9YxNh1QaqotjN3DNhYzHtCAnmSf2wb60HH4BSvTBiSq07srVv1NfXxXyPmRTTkApfsbjFic5twlaYWUR79G5rqZQNHuZO3UWkNnhK5Vo+RLz3okzZ3XngWCqggbWyhasEjaoj2d5BsW3apGUh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718765052; c=relaxed/simple;
	bh=yIS+Hga6fTf+p8q8rSDiuCX5mEwnbSnT8hSMG+V0pg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCll4bCxjKosThetmXi6gt269U+J8GabZmnzU/Ng9gAAayaK/gAMIGwjzb+zNO6RxsjnisR1MfF+KuGBabhA6weCHnCODZOjsggKEHD85dbBQnqDZBjaPglRKt+o3uWL+evh6f5ds3giHSakfNwkSXjvV1kq96p0XDKLZn3X84A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHH4tuEO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f717ee193fso44983715ad.0;
        Tue, 18 Jun 2024 19:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718765051; x=1719369851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DnejJuBXPYOrAwLP9xhXDbPt82fre1nRXATj/eABvNI=;
        b=WHH4tuEOjazWOHi4zOxjCdxJRQCv7QePwECPpUg32R2wdmT+q2+pBnW2+S2uipm3/o
         rynFQClPSO3f2Wh6sdXQSlCEJQxBewXWCgtLUyzUDV/Je9IM8yATMbHnEd1bpwI6OntB
         fT9aplT87Sq9ZZPBinpVFEn7N53OfOLdaoCeXDeD71YMnzS378mWVF2tjbWb5uWVR9/Q
         5PwAr+8ziVD2rY1yuXAX+imdZWmqEkj6gp7V7WC/zwsbzRw8eU4CDgb9jenJe6V7dHH/
         Fk27p7B1Gmb+cdnxVYAKpkcm8EnUHLZ6jQCrurF/+aRmFeBL+UWH/MQ/i5CLHuwbfJzO
         9ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718765051; x=1719369851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnejJuBXPYOrAwLP9xhXDbPt82fre1nRXATj/eABvNI=;
        b=JRZUynD5Y516x8MHKeOrPmqx06zD1GlpB9noqQCC+rNAUdZcSWLOJRodGL9P9ia0pD
         KmbpLbM/lx1Y3nW9CMjX8v9Vtoq3EE1ubZ/WoF6S7rZaY6HSRHFGmGvGrz3j8NELNlKH
         XH0vW2ld103p9yglOU5A2Q6xHEeVNMd2eN+sX3CcftBgy4jRJT6gRdoAT+cbIYivujlS
         Kxp6108KuqHsBc0BoSB90u3HeLAWUyaX1ELavqT7Nn91MKvpp9hEmHEAHoQNNOFhFGUP
         2QQp5vMqQ0Z/8sCZO9XoQm7szC0/Ma3JDp9Az4xDN2g0TWD2da4EvGqgPj72PiRmkwkV
         LpQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpEgac5YxmW6GkDnRL03cugEFjz1o95o8HUoytajNgFsAqFuDEn9XXwdh1H2d7UlJTEj99MVB5NhWhcXq4o/bdsha72OPUDEUn5Yt8VvnQ6qadH6BFlGx8IPKirzr7xxxfme7Z
X-Gm-Message-State: AOJu0Yy2LiaZw/9+W9kaWuqLMPDkBARDd5GSHsN8dfHLXLZzqMWUjEeJ
	2hlfMjgLOI2JS1HfMxUARHqvHYaPbDa7wd+gJhzgkKfoMGcqAqRJ
X-Google-Smtp-Source: AGHT+IGiWymNuefpsU/ke0j8+xTk6cWKObrmtPVZT3zn+Ztr6KTQqTwtTdVx4m9fLH7jgrizuy5ooQ==
X-Received: by 2002:a17:903:250:b0:1f7:1a31:fae8 with SMTP id d9443c01a7336-1f9aa3eba1bmr17160665ad.26.1718765050777;
        Tue, 18 Jun 2024 19:44:10 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:782c:cfa0:b84b:f384:190:dd84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f99e8cdf72sm17324095ad.260.2024.06.18.19.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 19:44:10 -0700 (PDT)
Date: Wed, 19 Jun 2024 10:44:00 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>,
	Arvid Brodin <Arvid.Brodin@xdin.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org, Geliang Tang <tanggeliang@kylinos.cn>,
	Shuah Khan <shuah@kernel.org>,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: Re: [PATCH v1 net-next] net: hsr: cosmetic: Remove extra white space
Message-ID: <ZnJF8EKZ_eGqZKpl@Laptop-X1>
References: <20240618125817.1111070-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618125817.1111070-1-lukma@denx.de>

On Tue, Jun 18, 2024 at 02:58:17PM +0200, Lukasz Majewski wrote:
> This change just removes extra (i.e. not needed) white space in
> prp_drop_frame() function.
> 
> No functional changes.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  net/hsr/hsr_forward.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 960ef386bc3a..b38060246e62 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -421,9 +421,9 @@ static int hsr_xmit(struct sk_buff *skb, struct hsr_port *port,
>  bool prp_drop_frame(struct hsr_frame_info *frame, struct hsr_port *port)
>  {
>  	return ((frame->port_rcv->type == HSR_PT_SLAVE_A &&
> -		 port->type ==  HSR_PT_SLAVE_B) ||
> +		 port->type == HSR_PT_SLAVE_B) ||
>  		(frame->port_rcv->type == HSR_PT_SLAVE_B &&
> -		 port->type ==  HSR_PT_SLAVE_A));
> +		 port->type == HSR_PT_SLAVE_A));
>  }
>  
>  bool hsr_drop_frame(struct hsr_frame_info *frame, struct hsr_port *port)
> -- 
> 2.20.1
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

