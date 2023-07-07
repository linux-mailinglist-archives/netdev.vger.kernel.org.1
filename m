Return-Path: <netdev+bounces-16077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3FA74B546
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 18:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECAF31C20998
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 16:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF5F107BF;
	Fri,  7 Jul 2023 16:50:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C8F10795
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 16:50:35 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF991FEF
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 09:50:32 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb9ae4cef6so3400773e87.3
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 09:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1688748630; x=1691340630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLXZgXJ3+fhscV17K2fnf26FIQt2ef2bWf/PY4eWVh0=;
        b=hyHMpsodfUphxMQtvgZcrCErIt/draEzO+5GgYcb0UWo1tfECJI4gic4qNSFPBY/My
         MFsCGsK8prgsg4QEU5R7K7nEywcIJizxTK0jK4QjHBJpY7cJKsIypFy9aa+qZANusALM
         qk6shmdJQOrZ29FsBJqbmvp8GRYu45TXnDVls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688748630; x=1691340630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zLXZgXJ3+fhscV17K2fnf26FIQt2ef2bWf/PY4eWVh0=;
        b=CUgarKHmqvhNqw1sKRyduXT06gZFyA2R/95tUywKkWObhaYZ+gqJG1RscuROyTytqL
         GHA+dPLfvX8Rp497KFUCaUVLrssCkzV/wQrzDgz1MRqSoiRn7E2ocF/hv5zuKUr/eA1u
         /mJXI6Vnjh+dxWk4UbwlfRk8yveApWhlsSUMjU08GvcbTTPkxU+C22LHpbafa3vDryQf
         qbx51kqcArg0NYlqsiLHqbtdT0XtedYMoGBjy6lGK6r9dShIJkhwNFWAHTuUIFtb1Kbb
         Xu1QShc/xvMLmvQp5p+HcnJkYnptr/Xl4en4MEK3GDGCmcx/GVAYnP0yfuN/m0XQhbP/
         IAGA==
X-Gm-Message-State: ABy/qLZWGdWOEWMWQhupOJTsaBLhHXrvG597/cUwspHVL25aqWviZoh0
	awu3VNL/sTCRwzETFmPA/aov93O88QEXTgU5duV5wrNi
X-Google-Smtp-Source: APBJJlEXfAYNH15dK3AV5eI09WPbZQg+IHwGbyW73ycGwv0cxtUWa/Gf/y2pDT6aOhKxMtHo1C5Acg==
X-Received: by 2002:a05:6512:32d0:b0:4f8:6dfd:faa0 with SMTP id f16-20020a05651232d000b004f86dfdfaa0mr4176574lfg.2.1688748629854;
        Fri, 07 Jul 2023 09:50:29 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id z12-20020ac24f8c000000b004fbab1f023csm742346lfs.138.2023.07.07.09.50.28
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 09:50:28 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4fb9ae4cef6so3400725e87.3
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 09:50:28 -0700 (PDT)
X-Received: by 2002:a05:6512:2141:b0:4f6:2e4e:e425 with SMTP id
 s1-20020a056512214100b004f62e4ee425mr3732573lfr.50.1688748628215; Fri, 07 Jul
 2023 09:50:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230706145154.2517870-1-jforbes@fedoraproject.org> <20230706084433.5fa44d4c@kernel.org>
In-Reply-To: <20230706084433.5fa44d4c@kernel.org>
From: Justin Forbes <jforbes@fedoraproject.org>
Date: Fri, 7 Jul 2023 11:50:16 -0500
X-Gmail-Original-Message-ID: <CAFbkSA0wW-tQ_b_GF3z2JqtO4hc0c+1gcbcyTcgjYbQBsEYLyA@mail.gmail.com>
Message-ID: <CAFbkSA0wW-tQ_b_GF3z2JqtO4hc0c+1gcbcyTcgjYbQBsEYLyA@mail.gmail.com>
Subject: Re: [PATCH] Move rmnet out of NET_VENDOR_QUALCOMM dependency
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jmforbes@linuxtx.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 6, 2023 at 10:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu,  6 Jul 2023 09:51:52 -0500 Justin M. Forbes wrote:
> > The rmnet driver is useful for chipsets that are not hidden behind
> > NET_VENDOR_QUALCOMM.  Move sourcing the rmnet Kconfig outside of the if
> > NET_VENDOR_QUALCOMM as there is no dependency here.
> >
> > Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
>
> Examples of the chipsets you're talking about would be great to have in
> the commit message.

The user in the Fedora bug was using mhi_net with qmi_wwan.

Justin

> pw-bot: cr
>

