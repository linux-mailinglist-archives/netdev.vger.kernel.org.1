Return-Path: <netdev+bounces-51321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98A37FA1DF
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 15:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F501C20EE4
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 14:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5930E30D05;
	Mon, 27 Nov 2023 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="lvw+6FxY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45C44232
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 06:02:43 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507ad511315so5892920e87.0
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 06:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1701093762; x=1701698562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uh8MG/fcScS4zGx1w1Y666LV3WqtJtCJW99b8yZPGeU=;
        b=lvw+6FxYVAJcVDXhAwCe/s9ZxNHS8sF1SM/r+F8nmyCxt6kggKelzzoVhdrYZypeGh
         ZUrPlACn2bhGk/rchjr6SSV5u5KgvbkMR5AVxEk2vG8YmK6qc460vKxl5jxXdZRQg2yq
         VzOO+lmVMmU7F2py/GETYiesAsPCKaXiA2FdQoPr3Mp2zJKOtGx4dLxDaC4ZPV7R2X9y
         x3zy0X+wPtx9H7N986+Ie20LJDu3lX2AVrxtBi4l2xOHeG9M/nKyEvsU5BDT2Nl223J+
         HT2YcZ5m1KC6818QSROQFoDBaBgTy+BRGInPT0bEDNXR9/YBiC6/0yUD84abdeDn2nrK
         L5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701093762; x=1701698562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uh8MG/fcScS4zGx1w1Y666LV3WqtJtCJW99b8yZPGeU=;
        b=cJLQUW36u0Kxn428R3BV0Z2+rzPjmMhWd0seFYYSsJ+bEWze9hFiIk3be9mIn7xDtw
         Fv1pj+pJkj23AC+BPks5+KF37VfnKZhhyuXWbp4ILQah30mYerMH6Vpcb1shK1fq1Lqk
         NNqY41ACgO7IjzP4eDOs+CwyIsJtKsru8O47PcyuvE1g4Xe9HeN8E315pxjCfEgx9h3E
         CSwMW3c5f9MryuJJ+w8WBsyivJyxSWMQyhoa+IXFQlW8B8v9f7LOzZjbQctWyARZifWn
         1zh/WQvkw5Fbk5aqMqHFChImYHL7+MInX5YMIsApExOBNRePNJC9u7tjOjhZnAGRygWd
         WSgQ==
X-Gm-Message-State: AOJu0Yyqc+olqhC2jSWjomzkpPi24lA6qWChJ8ZKCS+b9KVyn5hVLAfa
	AjkrOsdJOkVBRPvx5DdzHmPIMQ==
X-Google-Smtp-Source: AGHT+IFj52P0DIEx0c9vj7QT0YARpPDlM/qFv1+NoeWnzCQ9HCNWjkCgkmNnLJMpwF9gtUU6vrpmNA==
X-Received: by 2002:a05:6512:2389:b0:506:899d:1994 with SMTP id c9-20020a056512238900b00506899d1994mr7071586lfv.52.1701093761408;
        Mon, 27 Nov 2023 06:02:41 -0800 (PST)
Received: from debian ([185.117.107.42])
        by smtp.gmail.com with ESMTPSA id u4-20020a056512128400b0050ab696bfaasm1486122lfs.3.2023.11.27.06.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:02:40 -0800 (PST)
Date: Mon, 27 Nov 2023 15:02:39 +0100
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] net: microchip_t1s: add support for LAN867x Rev.C1
Message-ID: <ZWShfwyqO-JkqVgI@debian>
References: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
 <20231127104045.96722-3-ramon.nordin.rodriguez@ferroamp.se>
 <f25ed798-e116-4f6f-ad3c-5060c7d540d0@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f25ed798-e116-4f6f-ad3c-5060c7d540d0@lunn.ch>

On Mon, Nov 27, 2023 at 02:37:41PM +0100, Andrew Lunn wrote:
> >  #define PHY_ID_LAN867X_REVB1 0x0007C162
> > +#define PHY_ID_LAN867X_REVC1 0x0007C164
> 
> So there is a gap in the revisions. Maybe a B2 exists?

The datasheet lists A0, B1 and C1, seems like Microchip removes the
application notes for old revisions, so no way that I can see to add the
init-fixup for A0.

I'm guessing there is a rev.c0 that was never released to the public.

> > +	const u16 magic_or = 0xE0;
> > +	const u16 magic_reg_mask = 0x1F;
> > +	const u16 magic_check_mask = 0x10;
> 
> Reverse christmass tree please. Longest first, shorted last.

My bad, I was just thinking 'christmas tree' forgot about the reverse.
I'll fix that.

> > +	int err;
> > +	int regval;
> > +	u16 override0;
> > +	u16 override1;
> > +	const u16 override_addr0 = 0x4;
> > +	const u16 override_addr1 = 0x8;
> > +	const u8 index_to_override0 = 2;
> > +	const u8 index_to_override1 = 3;
> 
> Same here.
I'll fix this.

> 
> > +
> > +	err = lan867x_wait_for_reset_complete(phydev);
> > +	if (err)
> > +		return err;
> > +
> > +	/* The application note specifies a super convenient process
> > +	 * where 2 of the fixup regs needs a write with a value that is
> > +	 * a modified result of another reg read.
> > +	 * Enjoy the magic show.
> > +	 */
> 
> I really do hope that by revision D1 they get the firmware sorted out
> so none of this undocumented magic is needed.
> 
> 	Andrew

Really do hope so.. 

