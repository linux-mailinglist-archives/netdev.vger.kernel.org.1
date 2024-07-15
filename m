Return-Path: <netdev+bounces-111499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9044593163B
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F5E1F2227C
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 13:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0694418E763;
	Mon, 15 Jul 2024 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jQXp8/7Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F1C1741CF
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721051971; cv=none; b=ooxGt4B4X+tnd5m74Q5nAgAAa7F+Pwf+iOzN/u8rJfizG0CO5hz1Lfbf7n8w2TKLK7naZ6HaRbYmDJ2qLxdeYW6VIcngDWJ37zyjJtHSSr88m821WZRgsBbsVmsRL402RbUWcogSPqa5rQUCbHKPP+kcFncZKTS0DGrW2X49/vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721051971; c=relaxed/simple;
	bh=fVYvYCrgRJF3PlF6lGBsfVvFPNzlOsXIOFH0UCv2dY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1K3wm9nWv5W/fUU35N2Tmg4f3Ldq3Nx8cf1/a2nwMFRqGR9F7P55v3x2U0gEb9LqKGbBq9nHfsf6I684rPIp047MWGcY90e7WDcxmtYlu5xEzDXigV+kQHnlRD5IZg/AKwONyCJeOynj74mU8fPU+Q76NuSwOna3BGyHrzqbcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jQXp8/7Y; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-65f8b0df1f0so18387787b3.2
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721051969; x=1721656769; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xbpAf9Iz0WaXtkTP5+IPP8WJkp/UYJ9URQ8tAUfdv80=;
        b=jQXp8/7YNfTq8etCiHOxiTXhgJZzPPy/Up6zH3xWis/VZuMLjKuZkZxgJZkvYJQVVj
         OGfVfOvnnQQoYINwn5lpfDBd0th37G5NubdOB/JtW7ies57mJSTLYsfK7EAxHgP4/alJ
         +JyLHSxyPOIJ5CiVFxQd7m1C+4rtfmMBTpP9LB5H9cewcWSu/LtqU7VZyuWeI+UN52UC
         p1PzBp2TMFIDd4SXy1whua2ZruvQw+0ziT+vl8ZjQIJTAIIv+wmBZnsY6gcoxYgybJbb
         ljO3sPLEyS9di7kvh9ElidpwsLKZTVVq+FDkM7Om+mczCgRkg3nvisLSqGkeN1onsyiA
         CTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721051969; x=1721656769;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbpAf9Iz0WaXtkTP5+IPP8WJkp/UYJ9URQ8tAUfdv80=;
        b=Y7AvXQTUM8pAIBm1trow8BowIMjlqjPQpYAl2XZQ3N/gbxxoByMP+LoU3FBGG3yzlJ
         saYda3mh4cuIjPpYatK2K4aQ22+K6tdvim1smXTGs5EMV8cTLAvxnkji4jAEP/Z35Wrj
         KYZHiZquREB70RVPU2uIVbEkplkRlBXrHutk3uKS9m2g2uUm4Bma2wVTbvry5oJCoRPw
         TeyKucC7F1KzxIuGCXvRuTO8/pq+nk1wHeH3bm92e/lzBQtbKY9zXmYpEh0HsAv9cXpb
         4MaZdzcMrSZR+bfvvfiXpXbpPYIlorgtJoD+bqbWhYckBjGkts+KeaKdhEysxl72r3uo
         A8oA==
X-Forwarded-Encrypted: i=1; AJvYcCVh0elIcnUq/11seHHWJeayxb2B+9zIYW/32IraYTxMFauDmYKb+Ibm1BQMZVWG2InqWr5f0MRi2uFWTCNl1+IyFDSoL7xR
X-Gm-Message-State: AOJu0Yzjfgbx8FNsw5vcR1VhztvG0rUexVLr8AIJIzXei7cwrXIX/J5Z
	dOgrzu7yTAMNRjLpMJGRibzmSZti65j3JUa6eMhAOA9wQ6jOU3Nf0YJjmHwHXBL8KkRFQUBUMWg
	iHiJNCu5n1xwS8EfjXOYFRdD7G2c1Z0L8iLEkYg==
X-Google-Smtp-Source: AGHT+IFq4yRpnxT2dPyje15G4PJAq08GA3tX1Gr8HKva6X+GNBjNoKXyg6sR0RdTV/BYANGhO6+gfurAhfoU0kRceb8=
X-Received: by 2002:a81:8ac3:0:b0:646:5f95:9c7d with SMTP id
 00721157ae682-658f01fda1bmr186420427b3.36.1721051969436; Mon, 15 Jul 2024
 06:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715015726.240980-1-luiz.dentz@gmail.com> <20240715064939.644536f3@kernel.org>
 <CACMJSes7rBOWFWxOaXZt70++XwDBTNr3E4R9KTZx+HA0ZQFG9Q@mail.gmail.com>
In-Reply-To: <CACMJSes7rBOWFWxOaXZt70++XwDBTNr3E4R9KTZx+HA0ZQFG9Q@mail.gmail.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 15 Jul 2024 15:59:18 +0200
Message-ID: <CACMJSet9xj=Ct0=OuGRX_xHsES6MgFe-OkYnGoCD+TetUcR7_A@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2024-07-14
To: Jakub Kicinski <kuba@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 15:55, Bartosz Golaszewski
<bartosz.golaszewski@linaro.org> wrote:
>
> On Mon, 15 Jul 2024 at 15:49, Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Sun, 14 Jul 2024 21:57:25 -0400 Luiz Augusto von Dentz wrote:
> > >  - qca: use the power sequencer for QCA6390
> >
> > Something suspicious here, I thought Bartosz sent a PR but the commits
> > appear with Luiz as committer (and lack Luiz's SoB):
> >
> > Commit ead30f3a1bae ("power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets") committer Signed-off-by missing
> >         author email:    bartosz.golaszewski@linaro.org
> >         committer email: luiz.von.dentz@intel.com
> >         Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Commit e6491bb4ba98 ("power: sequencing: implement the pwrseq core")
> >         committer Signed-off-by missing
> >         author email:    bartosz.golaszewski@linaro.org
> >         committer email: luiz.von.dentz@intel.com
> >         Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Is this expected? Any conflicts due to this we need to tell Linus about?
>
> Luiz pulled the immutable branch I provided (on which my PR to Linus
> is based) but I no longer see the Merge commit in the bluetooth-next
> tree[1]. Most likely a bad rebase.
>
> Luiz: please make sure to let Linus (or whomever your upstream is)
> know about this. I'm afraid there's not much we can do now, the
> commits will appear twice in mainline. :(
>
> Bart
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/log/

Alternatively you can wait for Linus to pull my PR and then just drop
my commits from your tree before sending out your PR for upstream.

Bart

