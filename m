Return-Path: <netdev+bounces-33941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DFC7A0C01
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 19:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C82B20B9B
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8766262BF;
	Thu, 14 Sep 2023 17:51:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22B8262AE
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 17:51:42 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85601FF5;
	Thu, 14 Sep 2023 10:51:41 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so20312611fa.2;
        Thu, 14 Sep 2023 10:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694713900; x=1695318700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KY7RxSvyKFVM2Q9cKuTZj2GNL1ddxHDWFLp3+vCl28w=;
        b=KUdz/zg8uQqJ3Nf7zGRwWEnXxT9AvF1Z34UXifry5aGQJx3pwOdYKFj3sHrd1FlPS8
         nJ9wXjZm8H1Gvf/R7y4uOTM4Z5NcNp0sl0NYy5xbH96WzUU8S32ho+pItA/qszQhnpe1
         eCxud2ZyMknu5Tab0lyRv0hrVCdmDX1bMWcefLp4C8qgw3+TVQ1sCO+5P5Pr5ZwfnISt
         UZwGgrCdGzsPum9AmsyhIlgYcWyEGfBX2WhgTVQ1l5rafcn3H9e6S6KWZlp5ABIBhGH0
         mJp0QbjZalKClp0HyeOlutT6wxUhGH8o9xIbnebR5gV+TWc6bDf6RKNJn8QmS/+KGVtH
         jk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694713900; x=1695318700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KY7RxSvyKFVM2Q9cKuTZj2GNL1ddxHDWFLp3+vCl28w=;
        b=BGpkSfg2f02sFjQ1B0anQTTplSwa0LSSsRu4olkOWxkJjIT68ec4HVRPfBV0k4Ujdh
         iUv4BDxsXSr5FmPa813cx4l8sGaeNLPcsK7cDvCMX+bfiGOmn4/6/G/SOZ3FDQzAONSF
         7eR/2f/4qfvHHxFuGt3lQcUXGVFV8Si9rN6cSUVpiPzNqKMVdVeRfnNjgpjN0wyeyUCT
         kPYC5WaVQRWSpMndGGBFkzpB4wIj6CD3BQV9D9wTHFAVBW5SFCyYSwrfJJBAyLtga1p6
         DvK9opzuAlFeDvPVNngHavK9G15y67CAelSxJ3Yi0MQQOhb0y4SviuOcPC8+WS8yIA9J
         xDUg==
X-Gm-Message-State: AOJu0Yx7gevTeWQ+zoEWxkIDJM0ErRA4iU6D3pVmqSvzF7iVbRvkXcn9
	jL/ZB/sWtbitIkXFrBipdTSdGVcMdfZ8K0SEyPW9dzKZNeHJLA==
X-Google-Smtp-Source: AGHT+IHukwirE2wynl/GoyBbV46WIl+NKVa/vsFPFElyRIPkEWBjZgMJmpPwxTN6+8urhVHUtX9OLYKaNG6X3CDQRkk=
X-Received: by 2002:a2e:a281:0:b0:2bc:f1d3:b54c with SMTP id
 k1-20020a2ea281000000b002bcf1d3b54cmr5496422lja.20.1694713899582; Thu, 14 Sep
 2023 10:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230829205936.766544-1-luiz.dentz@gmail.com> <169343402479.21564.11565149320234658166.git-patchwork-notify@kernel.org>
 <de698d06-9784-43ed-9437-61d6edf9672b@leemhuis.info> <CABBYNZK2PPkLra8Au-fdN2nG2YLkfFRmPtEPQL0suLzBv=HHcA@mail.gmail.com>
 <574ca8dd-ee97-4c8b-a154-51faf83cabdf@leemhuis.info>
In-Reply-To: <574ca8dd-ee97-4c8b-a154-51faf83cabdf@leemhuis.info>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 14 Sep 2023 10:51:27 -0700
Message-ID: <CABBYNZJ=5VH2+my7Gw1fMCaGgdOQfbWNtBGOc27_XQqCP7jD-A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPLICATE_FILTER
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, patchwork-bot+bluetooth@kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev <netdev@vger.kernel.org>, 
	Stefan Agner <stefan@agner.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thorsten,

On Wed, Sep 13, 2023 at 10:13=E2=80=AFPM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 12.09.23 21:09, Luiz Augusto von Dentz wrote:
> > On Mon, Sep 11, 2023 at 6:40=E2=80=AFAM Linux regression tracking (Thor=
sten
> > Leemhuis) <regressions@leemhuis.info> wrote:
> >> On 31.08.23 00:20, patchwork-bot+bluetooth@kernel.org wrote:
> >>> This patch was applied to bluetooth/bluetooth-next.git (master)
> >>> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> >>> On Tue, 29 Aug 2023 13:59:36 -0700 you wrote:
> >>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>>>
> >>>> When HCI_QUIRK_STRICT_DUPLICATE_FILTER is set LE scanning requires
> >>>> periodic restarts of the scanning procedure as the controller would
> >>>> consider device previously found as duplicated despite of RSSI chang=
es,
> >>>> but in order to set the scan timeout properly set le_scan_restart ne=
eds
> >>>> to be synchronous so it shall not use hci_cmd_sync_queue which defer=
s
> >>>> the command processing to cmd_sync_work.
> >>>>
> >>>> [...]
> >>>
> >>> Here is the summary with links:
> >>>   - Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPLICATE_F=
ILTER
> >>>     https://git.kernel.org/bluetooth/bluetooth-next/c/52bf4fd43f75
> >>
> >> That is (maybe among others?) a fix for a regression from 6.1, so why
> >> was this merged into a "for-next" branch instead of a branch that
> >> targets the current cycle?
> >
> > We were late for including it to 6.5, that said the regression was
> > introduced in 6.4,
>
> 6.4? From the fixes tag it sounded like it was 6.1. Whatever, doesn't
> make a difference, because:

It seems I had it confused with HCI_QUIRK_BROKEN_LE_CODED, so you are
right about this affecting from 6.1 onwards.

> That answer doesn't answer the question afaics, as both 6.1 and 6.4 were
> released in the past year -- the fix thus should not wait till the next
> merge window, unless it's high risk or something. See this statement
> from Linus:
> https://lore.kernel.org/all/CAHk-=3Dwis_qQy4oDNynNKi5b7Qhosmxtoj1jxo5wmB6=
SRUwQUBQ@mail.gmail.com/

Thanks for the feedback, I will try to push fixes to net more often.

> > but I could probably have it marked for stable just
> > to make sure it would get backported to affected versions.
>
> That would be great, too!

Well now that it has already been merged via -next tree shall we still
attempt to mark it as stable? Perhaps we need to check if it was not
backported already based on the Fixes tag.

> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.



--=20
Luiz Augusto von Dentz

