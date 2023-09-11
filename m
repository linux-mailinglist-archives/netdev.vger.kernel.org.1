Return-Path: <netdev+bounces-32879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE3779AA6A
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 19:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875FA281351
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 17:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771D5154B3;
	Mon, 11 Sep 2023 17:03:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687F6A950
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 17:03:52 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDB6121;
	Mon, 11 Sep 2023 10:03:51 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a648f9d8e3so595595166b.1;
        Mon, 11 Sep 2023 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694451829; x=1695056629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bh45NkM6d8BWFe6aEYm+B4fjovxJAqk+P+SIzP9SdD8=;
        b=T6Li1t32k1m2HUrwlhsbuVr1SCIsqzc2211QQRswKqP7vfmYdIb0MPas44CJ58mBpk
         Q/YKQpg8Ihzl/ShLq6th8HZvleEv4EZfqN3NDge8K/gQ6EGZSVM3JvV9lJya7ZLDK/sj
         bSMKaVzTPX1dAbJfEuuJBCICYa1ZJX1PNsKYQaMCM/srmU4N2Ck3A8/tedFy/x1995yZ
         Cb8T6HGEi6fuV60/NhRPnDB0eHx4NgTT/6+JNoqfVjVs4888UqDETQJyjSTQzyxPQ0Gs
         u7dZ1JVHP/+yhA9e1jStrzvxMnOfqVe7cI8YVuGzXBKO7NwSU4tM4ZqPvef50B79OX8p
         HBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694451829; x=1695056629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bh45NkM6d8BWFe6aEYm+B4fjovxJAqk+P+SIzP9SdD8=;
        b=QYNXftLiLTJe9bqzzP1wHM1YqvHuTt03kov7MDTelcbpV93lPN32S2360YdU0S+XIS
         nLB3AIs4OaMjs/ElSgeexRs+tuI9w0faR6W/qujOBjL5q6FyGW81xtkznUROHcsOK1hz
         E60r/qay4WjrzX/qZZ9PtuY095g+YIuUkFNKz3Ve602tXRkJeMyEYHbbYtOxxWtf6alY
         PfBsQl3ISVR9M7zkJt5EbsYOeD/+00vI3E5spaWGdpMx9o7qhTfUxuEe0A08W10O0Xet
         RMI2V8vKNXp345jhvIAAnBU2DTZQB/7iY4qBHSzpFecFW7TDbHIA4GL9/5JcWGTaG6wa
         DvGw==
X-Gm-Message-State: AOJu0YwsXjgYd8kUbkSgvDXU6PPo2pjdRb/tYjdQvGyJU1DpoAm1g58U
	KD06JA756HPS9bohjuAUuCw=
X-Google-Smtp-Source: AGHT+IGIYCw4aLZaESMFDF/Tq0rdFzvqK0OG6gkCpZ8qHvDPE4Q2Nd8YyjWfadMSs3/mvmX0pisycA==
X-Received: by 2002:a17:906:301b:b0:9a1:c39a:8bfd with SMTP id 27-20020a170906301b00b009a1c39a8bfdmr8262550ejz.57.1694451829504;
        Mon, 11 Sep 2023 10:03:49 -0700 (PDT)
Received: from skbuf ([188.26.56.202])
        by smtp.gmail.com with ESMTPSA id n16-20020a170906379000b009930308425csm5646857ejc.31.2023.09.11.10.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 10:03:49 -0700 (PDT)
Date: Mon, 11 Sep 2023 20:03:46 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, Tristram.Ha@microchip.com,
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
	davem@davemloft.net, Woojung Huh <woojung.huh@microchip.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
	Oleksij Rempel <linux@rempel-privat.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [[RFC PATCH v4 net-next] 0/2] net: dsa: hsr: Enable HSR HW
 offloading for KSZ9477
Message-ID: <20230911170346.wm2ph3dspayplwd5@skbuf>
References: <20230906152801.921664-1-lukma@denx.de>
 <20230911165848.0741c03c@wsk>
 <20230911160501.5vc4nttz6fnww56h@skbuf>
 <20230911170222.hip2pcyzbfu3olau@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911170222.hip2pcyzbfu3olau@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 11, 2023 at 08:02:22PM +0300, Vladimir Oltean wrote:
> Hi @Jakub, I remember you fixed some issues with the dev->dev_addr writes,

I should have changed To: Jakub.. did that now.

