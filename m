Return-Path: <netdev+bounces-45029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E96447DAA28
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 01:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDA46B20D3A
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 23:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C53118AFB;
	Sat, 28 Oct 2023 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nllB85kX"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCA91097C;
	Sat, 28 Oct 2023 23:26:22 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F61CF;
	Sat, 28 Oct 2023 16:26:21 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41e1974783cso22156001cf.3;
        Sat, 28 Oct 2023 16:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698535580; x=1699140380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kdf9pElA1fR4QgDFyuJCQ41jT1ZvFhdzgsvGwKxFNZ8=;
        b=nllB85kXJt+h9z2+w7zRdJudrEe/uW6FsQGSPxKfX8AoVZkb0vljpaOE38ujMoONkD
         T7dEvy1myur3CTIy3P/k56dt5CzWLYpIO4CfLS94Q9j2MByQp33dmbWfe57HbaQMly41
         iF5YCvoad2OSHmDknLI/AuscykA9czCoTx1iRkypYhZ2vfPW7BgmO3SKBv09L99cbyhn
         YMLd/Lp8qACx4sgBDaRT12AeRv+QYwEJ3HJgcw63I6gyPm2kyNuu8BYWTWrBTcnaQLgN
         zBEBHtpJhBuxfh8cGKDsaJtATSiTauA6/FJ82ipxw4fn4eHFydxK7ZYodqH6QmrjOiy4
         8CEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698535580; x=1699140380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kdf9pElA1fR4QgDFyuJCQ41jT1ZvFhdzgsvGwKxFNZ8=;
        b=S1DQl+EBP6QrqM4MTkQtTxZo49BjmcDMpzKW4ZpG5irJcE/y6+N1AXlxsWj/YrLX9m
         D5hyX3k9FEMD/9EnX7+90SoTz1CE9Olo+qQDP6E7ZM3CIdPCD0zxsFMOvYL9x2vMKDRX
         /Pjiv9XAxn7nlHTmY1vqCdmJm1dHDm5Bq6ypsgGkxupJ4o0zmsYSWbHlBvnUNtQzpKPk
         7qW0wUIPcFSjls49B7KZw/5dzlIb/34QpSgVX2W92+4Dh25Mz+uPEALlKMTEp+5EDgIu
         HEfK2/rBpFQBIH8wPbXr+ro/QMYNs8aw2g5R+V5vXMZgeJY5wDEYrCu+foHf7O3HJG9X
         2QEQ==
X-Gm-Message-State: AOJu0YxF3AUAQItFZYnzhDxjenVmr2+0amjmOr0v/He9Ldtr1zM9cswM
	ML+zX0FiCw8mlrvSnh+kwJQ=
X-Google-Smtp-Source: AGHT+IGWXgY2Cz5bM2GOXBrzX2zXrTGFZa4P54QCXRxTCC9D8OCBC7slxFsIKoyHtKwZGuicZq7eKQ==
X-Received: by 2002:ac8:7fcc:0:b0:41c:bc53:4ed8 with SMTP id b12-20020ac87fcc000000b0041cbc534ed8mr8973566qtk.7.1698535580061;
        Sat, 28 Oct 2023 16:26:20 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id g13-20020ac84dcd000000b00403cce833eesm1974736qtw.27.2023.10.28.16.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 16:26:19 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id 28F9727C0054;
	Sat, 28 Oct 2023 19:26:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 28 Oct 2023 19:26:19 -0400
X-ME-Sender: <xms:mpg9Zcv87cJshs9xl7hQislvcjI5eAcVqP2TUXrf731yqevjfXlHhA>
    <xme:mpg9ZZcgjS20y9LTSlvszvKhqXmurpmFK57sCSnQ_4TS5kJnzPDa0ZKPJB7EB4vxV
    lumvpIAJ_B6tQvW6A>
X-ME-Received: <xmr:mpg9ZXzi8iSyqRw46y4MX1eIdUYWPSAl7GC5Bhtxuj6zqw-Lw5YowDDGd_0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleejgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:mpg9ZfNCGYrKw786PqBrAWnsmy2ZD7XyHGnk2-ABkoMvjlvvP9lsUg>
    <xmx:mpg9Zc-XLy0pdjd7WnnmwMXSF1K6OPN50fVdxtOROGORSJaZoE44lg>
    <xmx:mpg9ZXU5YvWczY5tW54ZKqeQlhcBhY1zeF7Ip1RbXFlCSafUQlEOKQ>
    <xmx:m5g9ZZP-6wHqFTC3PTvHNrsLirzI4TM0e9B6U2fu72kKEgH-k6B7nQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Oct 2023 19:26:18 -0400 (EDT)
Date: Sat, 28 Oct 2023 16:26:16 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Benno Lossin <benno.lossin@proton.me>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <ZT2YmC70zrCgxlHo@Boquns-Mac-mini.home>
References: <ba9614cf-bff6-4617-99cb-311fe40288c1@proton.me>
 <20231028.182723.123878459003900402.fujita.tomonori@gmail.com>
 <f0bf3628-c4ef-4f80-8c1a-edaf01d77457@lunn.ch>
 <20231029.010905.2203628525080155252.fujita.tomonori@gmail.com>
 <91cba75f-0997-43e8-93d0-b795b3783eff@proton.me>
 <ZT1bt8FknDEeUotm@Boquns-Mac-mini.home>
 <10415b9d-5051-47b1-8dee-9decc0d1539a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10415b9d-5051-47b1-8dee-9decc0d1539a@lunn.ch>

On Sat, Oct 28, 2023 at 09:23:25PM +0200, Andrew Lunn wrote:
> > Now let's look back into struct phy_device, it does have a few locks
> > in it, and at least even with phydev->lock held, the content of
> > phydev->lock itself can be changed (e.g tick locks), hence it breaks the
> > requirement of the existence of a `&bindings::phy_device`.
> 
> tick locks appear to be a Rust thing, so are unlikely to appear in a C

Ah, I meant ticket locks... same here a mutex has a wait_lock which can
be implemented by ticket locks or queued spin locks, so the u32 lock
field may change even with lock held.

Regards,
Boqun

> structure. However, kernel C mutex does have a linked list of other
> threads waiting for the mutex. So phydev->lock can change at any time,
> even when held.
> 
> 	Andrew

