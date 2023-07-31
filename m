Return-Path: <netdev+bounces-22772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F82376922B
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F8E281498
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 09:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8D81775C;
	Mon, 31 Jul 2023 09:47:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115D763A2
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 09:47:18 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDC81B5
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 02:47:11 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f954d7309fso5320715e87.1
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 02:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690796829; x=1691401629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJWnYrFQOvRUTU9QJb5JhTI9ZcFNM0nZZtsPRcg4gpo=;
        b=DH4sS0q5aYKbJmVkzW6i+EWE/yfNEx3EBvMtuTVVhoR+gf2M5oK8ubei4xQQ6UcE0J
         ncX/SY9y5xRKeEev16EVaPc/uIjsDy6GulvxU+4Z9pd5fzw71aoCOZnBHJYPm3/mkLqU
         /N9KKOR05eSHsXkJSZi9FO3oaC4sFREg6y/nXzsmqBuSM2vtGLWbMna2bGGKI9a79tIg
         llrxspzwuzrPofIfC5Tj72fIl96NktmKasZpE1hV+l+C68Bx5f23Z4dpsyJfElfCgOEh
         yUYWhUDDEwaPgpz5JW9qM7kg+3yc3YiMvZn0kFwNr1RY6Php0DlUSBKMjasGAAzkauJO
         /YiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796829; x=1691401629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJWnYrFQOvRUTU9QJb5JhTI9ZcFNM0nZZtsPRcg4gpo=;
        b=XIEv3qEESjaFUOIkNW5g8BKVWq1zKTWh0kcnhvfqKbSQ1xfW27ZRcIozFA2j/4jV9I
         dvWF90ADvzS/Av+TxlceedEcd/Qp3ilLjyeOQwq3Lx8sD0SAbK0xUH0XBKhnDDAfUgQG
         8uy9U0Z995kwvrDnL5yDA5yyuZ85cxpayjhz6aoVPYxQUR/F07bHClAR62tqSPfQ7Fc9
         kTsJ4zVd6ZXu4VfKYkTew0CmnM8sPjTCJTVzEk2waLiV8uJL74+tE1ByWWgUDRztd3uW
         eig7oWpnyGiSL4Pq4n1V2SlkRgVw1bigStEpBA8H0dYwniNFp+8X2boiqqZNIiKUdtbp
         Nw0A==
X-Gm-Message-State: ABy/qLZSjspkswuIH/f42CQJaSQTvQVnE7sLCTaV75GJ/+KL0pYHL28Y
	heSunWZy6NwMlXself85DRnXlvnULjIYcvMIL64=
X-Google-Smtp-Source: APBJJlHB2qbVzGFshPeg+QG1pL6JaDBFsvmiAnAnm1yEtlVjYWe4Aa3OGHhWJErglPDD3XVa0X6EHm2xXrKIC0lAahE=
X-Received: by 2002:a05:6512:304b:b0:4fb:8aca:6bb4 with SMTP id
 b11-20020a056512304b00b004fb8aca6bb4mr4401427lfb.20.1690796829500; Mon, 31
 Jul 2023 02:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1690439335.git.chenfeiyang@loongson.cn> <7cae63ede2792cb2a7189f251b282aecbb0945b1.1690439335.git.chenfeiyang@loongson.cn>
 <ZMOJNtClcAlWwZpP@shell.armlinux.org.uk>
In-Reply-To: <ZMOJNtClcAlWwZpP@shell.armlinux.org.uk>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Mon, 31 Jul 2023 17:46:57 +0800
Message-ID: <CACWXhKmcFCHQsjc-7BU5VkNyJ70v6iEg2iQ11i-qS3VchvKCJA@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] net: stmmac: Add Loongson HWIF entry
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Feiyang Chen <chenfeiyang@loongson.cn>, andrew@lunn.ch, hkallweit1@gmail.com, 
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	chenhuacai@loongson.cn, dongbiao@loongson.cn, 
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 5:24=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Jul 27, 2023 at 03:18:06PM +0800, Feiyang Chen wrote:
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index e8619853b6d6..829de274e75d 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -3505,17 +3505,21 @@ static int stmmac_request_irq_multi_msi(struct =
net_device *dev)
> >  {
> >       struct stmmac_priv *priv =3D netdev_priv(dev);
> >       enum request_irq_err irq_err;
> > +     unsigned long flags =3D 0;
> >       cpumask_t cpu_mask;
> >       int irq_idx =3D 0;
> >       char *int_name;
> >       int ret;
> >       int i;
> >
> > +     if (priv->plat->has_lgmac)
> > +             flags |=3D IRQF_TRIGGER_RISING;
>
> Can this be described in firmware?
>

Hi, Russell,

I'm not sure, could you explain what you mean?

Thanks,
Feiyang

> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

