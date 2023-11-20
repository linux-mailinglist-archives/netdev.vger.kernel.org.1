Return-Path: <netdev+bounces-49076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFF07F0A82
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 03:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C714C1F215E9
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 02:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E594186A;
	Mon, 20 Nov 2023 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LHVd0oJR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AC513A
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 18:19:53 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cb90b33c1dso228880b3a.0
        for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 18:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700446793; x=1701051593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdcAy7f6OnqVo5w9nQ2q1tLDxqo/b/Mq58x7mmCIVdQ=;
        b=LHVd0oJR77piZdhcFHW2B5xjZ9ZZKgvES3yFhMTPdGDF75TCQPU+i7ISeuJEXUlHQH
         V/fADTTK8IA2KhvXxaksorYD0TWotzQ2VZYSwfknZb+FuYOLomPIiKMORmU5Xf1qSVLp
         QotmF6aXcBqI6/1J7dloyZ2RXSa1TPHYhV5VrEq4JG92ryFWigBn7qiY5wnbRHrENSiu
         o70Q0QZvW3sjB0QgTJvZZGr7Mp4/Ef8V3+hoDFes+5dhN8F+DKrMpkVs8JaJiJBgaqDd
         0Lf+Q6A4ZDG0mq0pZYfFkOxwnqPIeuJgPPpc9lV0R0/HcFN5F6NFzuU3OzjNsnhtpBaK
         TQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700446793; x=1701051593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdcAy7f6OnqVo5w9nQ2q1tLDxqo/b/Mq58x7mmCIVdQ=;
        b=eFS3Sc4U1SBHoPH9Hoj/7s6+d+lSq6DV/IjY2DWJvMmHUzqQXmSlU5xdjj6V0weLX7
         5uURBOGbiNJm/sOr48eWK5kOaR+e047nAg1Z4OoWSEKa4oZCrDzlzBPZ3a2s2Pl/LD4F
         DUp4OLozp1ZJEG3/70oVmSTcmiz26jX4adAPCglIdm0Px3/MNmdJL+h1ul+p6VG0bb9+
         2DEZwNmBb6cgpY60DtlXWhWDlmCRsMRX1cZOXDITfo194uZH9G9COc0B48bpx2kcwNBG
         qkF3CkUZ3iK/ILZmYg0Ts+dnqOw6c4oXYWFwtX0rVc/vGFcsHnYCw0WuHdnm6WgPehjI
         DjQA==
X-Gm-Message-State: AOJu0YzlgpeFMM+SXhWsuA3v30wvo9IhfQuy3y/eNKkHFaUiBQbebfqN
	f4CSYfNPKwJL/5zKgXQkCz0RRw==
X-Google-Smtp-Source: AGHT+IEGL27jcOecfkEXSzT46jeep5qjXQSjSRMeMi2Pno023MFnh2RelKymNsSgTt8dDccEibQN4w==
X-Received: by 2002:a17:902:da8e:b0:1cc:27fa:1fb7 with SMTP id j14-20020a170902da8e00b001cc27fa1fb7mr7935283plx.5.1700446792822;
        Sun, 19 Nov 2023 18:19:52 -0800 (PST)
Received: from fedora.localnet ([240d:1a:3a7:a400:9a57:aa11:487a:b54f])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902f7d200b001cf5d425244sm1013801plw.298.2023.11.19.18.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 18:19:52 -0800 (PST)
From: Ryosuke Saito <ryosuke.saito@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: jaswinder.singh@linaro.org, ilias.apalodimas@linaro.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 masahisa.kojima@linaro.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] net: netsec: replace cpu_relax() with timeout handling for
 register checks
Date: Mon, 20 Nov 2023 11:19:48 +0900
Message-ID: <5027002.31r3eYUQgx@fedora>
In-Reply-To: <20231119185337.GE186930@vergenet.net>
References:
 <20231117081002.60107-1-ryosuke.saito@linaro.org>
 <20231119185337.GE186930@vergenet.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

[Resend again after removing an HTML format. Sorry for that.]

Hi Simon-san,

On Mon, Nov 20, 2023 at 3:53 AM Simon Horman <horms@kernel.org> wrote:
>
> On Fri, Nov 17, 2023 at 05:10:02PM +0900, Ryosuke Saito wrote:
> > The cpu_relax() loops have the potential to hang if the specified
> > register bits are not met on condition. The patch replaces it with
> > usleep_range() and netsec_wait_while_busy() which includes timeout
> > logic.
> >
> > Additionally, if the error condition is met during interrupting DMA
> > transfer, there's no recovery mechanism available. In that case, any
> > frames being sent or received will be discarded, which leads to
> > potential frame loss as indicated in the comments.
> >
> > Signed-off-by: Ryosuke Saito <ryosuke.saito@linaro.org>
> > ---
> >  drivers/net/ethernet/socionext/netsec.c | 35 ++++++++++++++++---------
> >  1 file changed, 23 insertions(+), 12 deletions(-)
>
> ...
>
> > @@ -1476,9 +1483,13 @@ static int netsec_reset_hardware(struct netsec_priv 
*priv,
> >       netsec_write(priv, NETSEC_REG_DMA_MH_CTRL, MH_CTRL__MODE_TRANS);
> >       netsec_write(priv, NETSEC_REG_PKT_CTRL, value);
> >
> > -     while ((netsec_read(priv, NETSEC_REG_MODE_TRANS_COMP_STATUS) &
> > -             NETSEC_MODE_TRANS_COMP_IRQ_T2N) == 0)
> > -             cpu_relax();
> > +     usleep_range(100000, 120000);
> > +
> > +     if ((netsec_read(priv, NETSEC_REG_MODE_TRANS_COMP_STATUS) &
> > +                      NETSEC_MODE_TRANS_COMP_IRQ_T2N) == 0) {
> > +             dev_warn(priv->dev,
> > +                      "%s: trans comp timeout.\n", __func__);
> > +     }
>
> Hi Saito-san,
>
> could you add some colour to how the new code satisfies the
> requirements of the hardware?  In particular, the use of
> usleep_range(), and the values passed to it.


For the h/w requirements, I followed U-Boot upstream:
https://elixir.bootlin.com/u-boot/latest/source/drivers/net/sni_netsec.c

It has the same function as well, netsec_reset_hardware(), and the 
corresponding potion is the following read-check loop:

1012         value = 100;
1013         while ((netsec_read_reg(priv, NETSEC_REG_MODE_TRANS_COMP_STATUS) 
&
1014                 NETSEC_MODE_TRANS_COMP_IRQ_T2N) == 0) {
1015                 udelay(1000);
1016                 if (--value == 0) {
1017                         value = netsec_read_reg(priv, 
NETSEC_REG_MODE_TRANS_COMP_STATUS);
1018                         pr_err("%s:%d timeout! val=%x\n", __func__, 
__LINE__, value);
1019                         break;
1020                 }
1021         }

The maximum t/o = 1000us * 100 + read time

Regards,
Ryo 



