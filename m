Return-Path: <netdev+bounces-40725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F37AC7C87EC
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 16:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849411F21260
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 14:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D337E11C92;
	Fri, 13 Oct 2023 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAoIFRi6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1592718C2A;
	Fri, 13 Oct 2023 14:34:48 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78096BE;
	Fri, 13 Oct 2023 07:34:46 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77386822cfbso141642485a.0;
        Fri, 13 Oct 2023 07:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697207685; x=1697812485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiqOjv9CBy/YAIHlJ/Ek/j41xRRll4lh+8GJVCNSWig=;
        b=XAoIFRi6sHgS7y3fopCCzMyyjlXmgt7lc0ko662dZz009IXW0GUdW/CSAcPdC+e7ik
         LAcig2iA6UXWaJm4A++bVWb5wIqS8Z0JLF8W8Gol4OSTUIMHKMlYReDXx30zx80Qz9u5
         muNYanYrmqye6L5xIZ+ad5kf1mxbBi5ggedL9QQ8KtPEZnz1o72rDlSlzzajOemowlD6
         EmqQGoHltDiG99cB+fQh/sPHmxnlcNOCfZ2O6GtEaBLU/nzsNSTxf5U1Bif1hh2Mmk5b
         AqVG8Utm7w3CwA0TVFGywRsmg12yqNlDtKWSPoLy/uCrkBTynJ6gm7r6Na8tkklnNfRX
         aLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697207685; x=1697812485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiqOjv9CBy/YAIHlJ/Ek/j41xRRll4lh+8GJVCNSWig=;
        b=Gt3iEKZOvz9B7tpOPlbqu7VQUA/oaVFv9wn1zSqh1Q2IkOroXWprBrTQhfNUbLQ0du
         Cv839rN0ZjDdgjfaT2Za7Qs5ZhjlwwrrBjXoXSrUk47dm+GaPqaoxCnBZsT6kNgAHWP3
         NQoqA5HHKIoFXpdrYSe95yBYvDTLNHSIAYSHLeXXm0y8vF9/9rpGXkqksZnQyQDN+Kv9
         epZtYoerAGQZIUVkv7WEepgXJhDk1bCOORIUrEjAyD1rhAztgEo80fm910dI1bZKKaqo
         xAXq4cCUTk6HTGxWjXCGcw41PQe2Y4x+XG+bA6Dgap27wUqBFaro90XTqdUiwaEraVzU
         doFg==
X-Gm-Message-State: AOJu0YxutChN2A+l//gxwDQwDycv0PDMqy8lptjrwA4kA+WGXmOwPzbX
	UeaKucUp0DOAMtJg5nlNwZk=
X-Google-Smtp-Source: AGHT+IGzQlJa+bZAHv9r6/5L9A88yLN9vQ1HtjKY/22DandnrI3+Do5EuidEt5ufmvrDP6uLeAQndw==
X-Received: by 2002:a05:620a:81d:b0:774:35da:75ac with SMTP id s29-20020a05620a081d00b0077435da75acmr26579669qks.55.1697207685443;
        Fri, 13 Oct 2023 07:34:45 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id e5-20020a05620a12c500b007756c8ce8f5sm671072qkl.59.2023.10.13.07.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 07:34:44 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 9475727C005A;
	Fri, 13 Oct 2023 10:34:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 13 Oct 2023 10:34:43 -0400
X-ME-Sender: <xms:g1UpZQ0_l53NZT0QW29zfT45D7vnNCcl2wH_ApZD1tgZm0GB5EK72w>
    <xme:g1UpZbGi_amYelqKBk9tvJ48b_jsndJVDEfEPHMtGnKr87EkEe_u1SX1cJlyj0OOv
    r5TiVPpv4nI_yABPQ>
X-ME-Received: <xmr:g1UpZY6jtbHrAyT0zfv8IF7Iyd_tvw4h3LNSafwwCe1MbkA7RXU6ZTSJl0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieefgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:g1UpZZ2jEwuyjJAnvJTsu6hyRQeePDxA7KHaxoacuCcT9yA1FhoR_g>
    <xmx:g1UpZTF8W5P4gNFtc9cJgE4AIwlvEkgWRMasZ9ntyEhDBu3Al70sVQ>
    <xmx:g1UpZS-DmmskbJm5GVqlJHOkdsyeWoRO8dFYz38xT-If0InFnuyrrQ>
    <xmx:g1UpZZaLbB6j-_U4ZUnO6ry3vRayUUQe5uxtZ4tZFxTgQApo1M1ykg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Oct 2023 10:34:42 -0400 (EDT)
Date: Fri, 13 Oct 2023 07:34:40 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu,
	wedsonaf@gmail.com, benno.lossin@proton.me, greg@kroah.com
Subject: Re: [PATCH net-next v4 3/4] MAINTAINERS: add Rust PHY abstractions
 to the ETHERNET PHY LIBRARY
Message-ID: <ZSlVgAfz-O5UR_ps@Boquns-Mac-mini.home>
References: <20231012125349.2702474-1-fujita.tomonori@gmail.com>
 <20231012125349.2702474-4-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012125349.2702474-4-fujita.tomonori@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 09:53:48PM +0900, FUJITA Tomonori wrote:
> Adds me as a maintainer for these Rust bindings too.
> 
> The files are placed at rust/kernel/ directory for now but the files
> are likely to be moved to net/ directory once a new Rust build system
> is implemented.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 698ebbd78075..eb51a1d526b7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7770,6 +7770,7 @@ F:	net/bridge/
>  ETHERNET PHY LIBRARY
>  M:	Andrew Lunn <andrew@lunn.ch>
>  M:	Heiner Kallweit <hkallweit1@gmail.com>
> +M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
>  R:	Russell King <linux@armlinux.org.uk>

Since Trevor has been reviewing the series and showed a lot of
expertise, I suggest having him as the reviewer in Rust networking, of
course if he and everyone agree ;-)

Trevor, what do you think?

Regards,
Boqun

>  L:	netdev@vger.kernel.org
>  S:	Maintained
> @@ -7799,6 +7800,7 @@ F:	include/trace/events/mdio.h
>  F:	include/uapi/linux/mdio.h
>  F:	include/uapi/linux/mii.h
>  F:	net/core/of_net.c
> +F:	rust/kernel/net/phy.rs
>  
>  EXEC & BINFMT API
>  R:	Eric Biederman <ebiederm@xmission.com>
> -- 
> 2.34.1
> 

