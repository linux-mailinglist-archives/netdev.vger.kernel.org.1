Return-Path: <netdev+bounces-35214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CFC7A7A10
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 13:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0EC21C20A70
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 11:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF3C16438;
	Wed, 20 Sep 2023 11:07:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A4C154AF
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 11:07:48 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27B2F3;
	Wed, 20 Sep 2023 04:07:46 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so8466799a12.0;
        Wed, 20 Sep 2023 04:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695208065; x=1695812865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vS/Cs2PLMP0wrXesDar8P/cFTTk09RoR8vpOfuuFr04=;
        b=FXd2I3XyuHZDW6sMuOLbD9oBI6GbFcL07yr+qtB7jwgqvPaOQy9g/DBw8sxq6OpZOe
         XyGCF9GhpjdPlNJUuZMg4KOnHgGEc9NY2+YbXpMZt540ocAogHp0LDTwGli3HnOdAABI
         wAvNRXDSINNzrzZuuiUXVxF0PuF/pENTzexppxjoEvx1P7ql1C4YpJKLRIfP0fYXOt7M
         nC5MP3nbwR4MQ6kvKezFLX3Q7MhwHdzq3qauSFnm+ABMl8SsaRwuUSo/bm6jOERWH8jy
         2k5eUOmMoxVqSSWINbjZOy0+vgNESy9srBjkQtF/h5rr1W06TjFDSfP+QFs+WNc6vd3L
         e0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695208065; x=1695812865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vS/Cs2PLMP0wrXesDar8P/cFTTk09RoR8vpOfuuFr04=;
        b=Ey85zOk9wjcoRLx2jJkLhBZxkytR7etY1z26YXSPVEuxkRl0SB+jdza0syabJ5Jnnf
         qq/EgtCKgn/+ps/0bSmF7YBy3jI7LbSTT8J8LY0NTTLibLgsRY4Pvd3M6EXPnHowB4dE
         WrDBd7RsiGs9KSMTH6DqgfJTGzdciY812beya7dwehUPW4Av2iDTy8qWYl1B+19S1KGT
         1rWbmeV86vQvujJKiRWnk5StpXL/mQjle9Pt4dcCPjcFDvuHaw9E50VllTF93PfKFhIu
         A27ubvqwRfME8ZWBAMOfTCNYaomVIGMA3yTNHez7NcW5h+DGlNGc0LRPzdTQM8XHvF4E
         iKyg==
X-Gm-Message-State: AOJu0YzRICb6kIBU4rjmJi46owZmWeRhSUP9ZzC9/B2ERnMSpWX2saLK
	tVxJYnr7WPd/5MBADkoA3uE=
X-Google-Smtp-Source: AGHT+IHJhYxXGF/oFkiARA6ufQ+RN2C28QZsKxEpzmxPTjndi+q1qWkXBk95MZAnjOn+PYiONQvuSw==
X-Received: by 2002:aa7:d518:0:b0:530:52d2:f656 with SMTP id y24-20020aa7d518000000b0053052d2f656mr1749171edq.21.1695208064972;
        Wed, 20 Sep 2023 04:07:44 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id es19-20020a056402381300b0051e1660a34esm7605111edb.51.2023.09.20.04.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 04:07:44 -0700 (PDT)
Date: Wed, 20 Sep 2023 14:07:42 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH][next] net: dsa: sja1105: make read-only const arrays
 static
Message-ID: <20230920110742.aykludzienjg5fn6@skbuf>
References: <20230919093606.24446-1-colin.i.king@gmail.com>
 <20230919093606.24446-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919093606.24446-1-colin.i.king@gmail.com>
 <20230919093606.24446-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 10:36:06AM +0100, Colin Ian King wrote:
> Don't populate read-only const arrays on the stack, instead make them
> static.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

