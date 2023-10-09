Return-Path: <netdev+bounces-39107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B38E7BE146
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8C31C208E8
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 13:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FA8341B7;
	Mon,  9 Oct 2023 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m34aq4oR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B8B341A5;
	Mon,  9 Oct 2023 13:49:10 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CACD94;
	Mon,  9 Oct 2023 06:49:09 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c76ef40e84so8268305ad.0;
        Mon, 09 Oct 2023 06:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696859349; x=1697464149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKANcfwhuAsvODwCPEx1W1hg3921aPpUJ7FkFgREVkI=;
        b=m34aq4oRt3hQ2kuYrKDsfINTBYNIvZipU7hAivQW2l3vT9cvAK1zgW2DYFobfSDdC+
         fTadisMbxv2F5XJo7qtc9vuK3MGo8TLBINfOt9mN/FEw2nGouk1b5N999OADOnLNBRZl
         ora0UklgKmoz4YaRPSL1YBgwk63X0Mm0uuQpqQuTHmFud1/eGJaz9zeS7SjYV62f+9Kf
         OI7wTexiow47+PIPiox9lWlja04PooTj8LWpKRfDw+ucGP8fp678oP9d8H+JYlQ4+qXc
         Zc8n2iUzYNaSd1Gb/Lh8jXzr9i1hy3M94Kt26TDQBMEkGKcdryoFAjc/nEM6GOBJOWPj
         h9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696859349; x=1697464149;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iKANcfwhuAsvODwCPEx1W1hg3921aPpUJ7FkFgREVkI=;
        b=N3lbC1sxaGn5sSOcSGob/BRaFpnms3sJR31bDqMy1SXX+cL11GLk92ffM4LVY52nmL
         MaaTxeBU/73nG2pk9eCZHBYKfBm/iinrnoZNtHrzcYbIO52iAqtTBo69sLwn5XpXV8cq
         3K4hhl4pzsdanS59H5xZpsaMjizSvKrUYMGLv21eD8QMfREdpIOm+8s06B2lkh0rGzPD
         iy3NU4cf5LKHpCDrdYKnf81r2OU6kVubstbvLwLBqhw5WyWkXSU//qa2E7/yyqmfBtSZ
         rmh56UOu7pNBiUDGMAZwzGcbFaJvWUKgBURp8KgRD2o67TNCuKH8yJEwHjOcneRxhhIy
         FG4w==
X-Gm-Message-State: AOJu0YyCJw1Zwh+urWkwV5SA4lSwoeerTgOijuEoeDWDQG4d8DqlQLTh
	wWwcwb+OezmmqLLyPPeslr8=
X-Google-Smtp-Source: AGHT+IGJp5yse3wRcoWdGhJTLX7cv3X55zx6fgB5j6J+XDbJDr/GEVOdTUj4SxQ5hGM5qeKbOXnWfQ==
X-Received: by 2002:a17:903:22ce:b0:1bb:83ec:832 with SMTP id y14-20020a17090322ce00b001bb83ec0832mr17663270plg.2.1696859348544;
        Mon, 09 Oct 2023 06:49:08 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902bd0500b001b9e86e05b7sm9559475pls.0.2023.10.09.06.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 06:49:08 -0700 (PDT)
Date: Mon, 09 Oct 2023 22:49:07 +0900 (JST)
Message-Id: <20231009.224907.206866439495105936.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, greg@kroah.com,
 tmgross@umich.edu, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72nBSyQw+vFayPco5b_-DDAKNqmhE7xiXSVbg920_ttAeQ@mail.gmail.com>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
	<20231009013912.4048593-2-fujita.tomonori@gmail.com>
	<CANiq72nBSyQw+vFayPco5b_-DDAKNqmhE7xiXSVbg920_ttAeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 9 Oct 2023 14:59:19 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> A few nits I noticed. Please note that this is not really a full
> review, and that I recommend that other people like Wedson should take
> a look again and OK these abstractions before this is merged.

We have about two weeks before the merge window opens? It would great
if other people could review really soon.

We can improve the abstractions after it's merged. This patchset
doesn't add anything exported to users. This adds only one driver so
the APIs can be fixed anytime.

Once it's merged, multiple people can send patches easily, so more
scalable.

