Return-Path: <netdev+bounces-19659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 574AD75B98C
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 23:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF291C2148A
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 21:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E64219BD7;
	Thu, 20 Jul 2023 21:30:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E34119BBE
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 21:30:18 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BE02111;
	Thu, 20 Jul 2023 14:30:16 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b703cbfaf5so18972211fa.1;
        Thu, 20 Jul 2023 14:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689888615; x=1690493415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxacXEluGsGwpl2y8KBqRJGU84iXk47vfx9ORCjxHug=;
        b=BWhxz3Fxm6dt/q5VVnJfBAeJZoMc4now6fB/IKNk3qldSPc86WYzZS/WBYZI0wuflB
         AH8z1qtD7vCeys0zPjm2F/GMHZY6Un1g5vFriZAiTNXDUz4ZazKZZGXIgoYGv54vibfX
         97O5pHUEk1p9pYUhMxywfAdNrnSu37cF1PR3nT1fY6ubkuAMHHhxEzUWx/gYcDasIklO
         Oylz8SSrhK1eRojLi9N6by1gveu+7rFo9U4VhK7MNX4x48tJRvTT4T62Bg3Vi4bKV3Ul
         4dPUPP9dfJBBHKJuAEbPb5zVsWHMI/MxS8IsaE9gDWu/eN7MVIMpsPrzjdzaQlitoymI
         37cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689888615; x=1690493415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxacXEluGsGwpl2y8KBqRJGU84iXk47vfx9ORCjxHug=;
        b=MPhhBB6R36hzi7w8iqFn/S6b2M1CYoLUZ7USDVg72JVvmYH59iGS/L5FaIAWPL8ySK
         3te0KTIcPSNS6wR4qRVl5pKQek/z+boHoSeB2xBZ37QZcaClF/Z7SB0vBdyH36s+SQw7
         veAiPRvJ/PXgtc3lRPRSl7gQCtDxnx1Mt1MGmOJ3UHYw1ih8olS/t4ABXTJpolJTtq8y
         SRCJSgvEAow0X5PfjWAG30VXjPFxaHwDWb2Y6vd4Xn52qyFj9dOiDO3E33emthW1SNCU
         edMjHUkTywn14UQd/KDa187WJaLg09cpALwY2lOjl6z5IVO+Z1C/1SXinMP1+WifpebS
         KJMg==
X-Gm-Message-State: ABy/qLZGsp+Z80tAwKnxeeKNcBgss0/8H2JW1LVqZ6PBI/HQiHMylmKk
	FWCNDDwp5Wa7/3ET8XtEm3QC8JOugCdT6dy9yz4=
X-Google-Smtp-Source: APBJJlF0tBQwm3aAgU4xLvrl9FRsgqh6fbCAmH5vuDHhVR+v70O9f7Qa8yGqIx7YbxtLlSLDUEcjzaSmbA4MnYuCtdI=
X-Received: by 2002:a2e:a178:0:b0:2b3:47b3:3c39 with SMTP id
 u24-20020a2ea178000000b002b347b33c39mr104443ljl.23.1689888614781; Thu, 20 Jul
 2023 14:30:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230720190201.446469-1-luiz.dentz@gmail.com> <20230720142552.78f3d477@kernel.org>
In-Reply-To: <20230720142552.78f3d477@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 20 Jul 2023 14:30:02 -0700
Message-ID: <CABBYNZL9puVzX7ELtR7UQGSU1=YFVWfdKWBmcGf4X5m3bRCS3w@mail.gmail.com>
Subject: Re: pull-request: bluetooth 2023-07-20
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jakub,

On Thu, Jul 20, 2023 at 2:25=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 20 Jul 2023 12:02:00 -0700 Luiz Augusto von Dentz wrote:
> > bluetooth pull request for net:
> >
> >  - Fix building with coredump disabled
> >  - Fix use-after-free in hci_remove_adv_monitor
> >  - Use RCU for hci_conn_params and iterate safely in hci_sync
> >  - Fix locking issues on ISO and SCO
> >  - Fix bluetooth on Intel Macbook 2014
>
> One bad fixes tag here, but good enough.
> Hopefully the big RCU-ifying patch won't blow up :)

Weird, I'd run verify-fixes and it didn't show up anything. As for the
RCU changes, yeah I was considering pulling it out but since it is a
single commit with no other dependencies we can always just revert it
if it causes problems.

--=20
Luiz Augusto von Dentz

