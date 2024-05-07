Return-Path: <netdev+bounces-93990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172E28BDD88
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233111C21A00
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 08:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C979F14D2B6;
	Tue,  7 May 2024 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="FEQKwscH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF86B10E3
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 08:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715072122; cv=none; b=ctcOESNK0ttStViAQjR433BzlMZDFuOhZeQnX+Qx3TRCTebdbHKPv4Js6gVLTFaUV2ygI2RLap5+uYg6HtuoNGjYRQ5/nouj0Df3Bsxfv4HeTX+/pjURWvufxL1x3rGiJKG4401vdHGL21yOzFY8owlzRzj6CNDCw+cVnNwhDm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715072122; c=relaxed/simple;
	bh=ZIvdSpIfCxhJ1EfFdfeWhD/aMB47HvlZ56AkDlfXrps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AR71HHRgx0DUYQyI8LAgWeYZf5zIGEaNQPwAlY2SAUr8K+BUd5U+/OVL1ANsgdfmqCxHuXQ7ycGKotw/EsoNEeqHzx1LoOnXrkdqySCkEIcx8mxUGxlyOiK3/BGCVhmzJH4IM/GOu1YJjONgMBp1NB6KcdzX0nVCi5JsrZM5Tiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=FEQKwscH; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6784E3FB60
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 08:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715072106;
	bh=Jo8OYnmn4OC8OiXlkwsI28aekX0eSHBqnnXbWjkcswQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=FEQKwscHlZd84aW+ijikBSigAjDgW8GTJPahVEwkVCtH3TmQkOstXHas3mSgvuVHR
	 vQaqrLDHTrOCvrLgBwcdVtKKb5OTJ4Ym6z7ea1Fz63mZPJA+XH9Txp6FFEZ8zjoE54
	 iL1o+BuorOb2vfrDUa9QZLxbhznVTajTZf/n2S8gxzEmWb8UWPCMw9dFSKOF84bEdr
	 /Fu+4489NnqzXWcdUs+nk3kA9n+JBWwJlAcmczBx0i9UYEqC+4rLvGebojCgoTrRgj
	 3XSXcSuxqq39w83rvtHsrKLip9GzNV+uFTeLEww3TQy3KfrwF4Sjq0uXgE9pjZBdp1
	 5PX5eT6Nnkp8w==
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-51fa2c23f62so2861062e87.1
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 01:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715072104; x=1715676904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jo8OYnmn4OC8OiXlkwsI28aekX0eSHBqnnXbWjkcswQ=;
        b=uti/ZwgOHGEYGciIBlFP7WkNEVschzoA7a3Xej7kZeTTlqa2YYb183g5skKbrhVJb2
         9p5sd91CANpSV/4iO8RaX6+GcrNeVF5LVNYHiBDFV/9+lw/BAtu/+CZfY7WHX/zO14nm
         /tSDLKa18FXNixXhNRJ59CYpe5QDPFIKFEGu3++MYeH+2XNFJyZer9QYmMy/TE8v7GiS
         YZoHmvmiraSJtoEqKI+5vJc1mlCO2paIO6l5ACXfDVlqVWvKv92703aC4VpcZa6b6QQp
         UOSSNFHUvm9WIsBvPnXzQxGk8fgRTF8uOTdq/VgsDTlcR5wl4SdtUuxaqf3u5ZiFlytV
         gwVw==
X-Forwarded-Encrypted: i=1; AJvYcCVTWgSB+dno33w4hnq+SRb+9MRCbsS9febmnTNTpgb0YxWTNk3f1Pk2MmcpRB9e4zOZEnbREh+aKFfPkIwapiCdA5+ay5f1
X-Gm-Message-State: AOJu0Yz9ownK6xhcKMvIz3Thps1cGBstQAExK+PAHCLOD+hj22LzK++l
	2yyxgS1+Cs+t/JXWu/iVqvgsckNaIiHunZ4dXBnmrEIV+pdsFhgAfbMruRAA4YiTYEROs71kd9X
	RwiBQUHy3h9KxMtwSq6WlZ1/e6Og98Y7VC6tVIAVWZ43+/p0uqhBLEeky3GeV/KgC1iXpGrmAGe
	uAwAKre6EYvVUw+2J4Z6FO4Hxak8k3UuNJmkpG7/zBChPn
X-Received: by 2002:a19:5e55:0:b0:513:e63c:cfe7 with SMTP id z21-20020a195e55000000b00513e63ccfe7mr7624855lfi.66.1715072103924;
        Tue, 07 May 2024 01:55:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcHr569y8CXVv1K6jlp8zJO7oa0VJugnPkcRf2d/9ahiU6CQowCeVXshdDc2dOJTtspM4xzmgndcLovNTDPwk=
X-Received: by 2002:a19:5e55:0:b0:513:e63c:cfe7 with SMTP id
 z21-20020a195e55000000b00513e63ccfe7mr7624834lfi.66.1715072103481; Tue, 07
 May 2024 01:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503101824.32717-1-en-wei.wu@canonical.com>
 <7f533913-fba9-4a29-86a5-d3b32ac44632@intel.com> <CAMqyJG1Fyt1pZJqEjQN_kqXwfJ+HnqvW1PnAOEEpzoS9f37KBg@mail.gmail.com>
 <d2d9c0a8-6d4f-4aff-84f3-35fc2bff49b7@intel.com>
In-Reply-To: <d2d9c0a8-6d4f-4aff-84f3-35fc2bff49b7@intel.com>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Tue, 7 May 2024 10:54:52 +0200
Message-ID: <CAMqyJG2S4yvO-UiCiWydO+9uzOWpeKR9tmMDWrw=m6O7pd3m0w@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2 1/2] e1000e: let the sleep codes run
 every time
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
Cc: Sasha Neftin <sasha.neftin@intel.com>, netdev@vger.kernel.org, rickywu0421@gmail.com, 
	linux-kernel@vger.kernel.org, edumazet@google.com, 
	intel-wired-lan@lists.osuosl.org, kuba@kernel.org, anthony.l.nguyen@intel.com, 
	pabeni@redhat.com, davem@davemloft.net, 
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Content-Type: text/plain; charset="UTF-8"

> Why so long?

> Furthermore, if I am reading this right, it appears that, with the
> proposed change, e1000e_phy_has_link_generic will poll the PHY link up
> to 10 times, with 100ms delay between each iteration - until the link is
> up. Won't it lead to wasting all this time, if the link is actually down?
It seems like making the delay 10ms is more suitable. And if the link
is actually down, it takes up to 10 (times)* 10 (ms) = 100ms which is
not quite long in terms of the configuration path.

> (1) How serious this problem is. It is normal for link establishment to
> take a few seconds from plugging the cable (due to PHY
> auto-negotiation), and I can accept some link instability during that time.
Actually, the problem is not critical since the link will be up
permanently after the unstable up-down problem when hot-plugging. And
it has no functional impact on the system. But this problem can lead
to a failure in our script (for Canonical Certification), and it's not
tolerable.

> (2) Assuming the problem is considered serious - have we root-caused it
> correctly.
The problem seems to be a PHY manufacturer errata. The patch here is a
MAC workaround and I'm wondering if we can root-cause it.

On Tue, 7 May 2024 at 08:22, Ruinskiy, Dima <dima.ruinskiy@intel.com> wrote:
>
> On 06/05/2024 19:46, En-Wei WU wrote:
> > Thank you for your time.
> >
> > Originally, sleep codes would only be executed if the first read fails
> > or the link status that is read is down. Some circumstances like the
> > [v2,2/2] "e1000e: fix link fluctuations problem" would need a delay
> > before first reading/accessing the PHY IEEE register, so that it won't
> > read the instability of the link status bit in the PHY status
> > register.
> >
> > I've realized that this approach isn't good enough since the purpose
> > is only to fix the problem in another patch and it also changes the
> > behavior.
> >
> > Here is the modification of the patch [v2,2/2] "e1000e: fix link
> > fluctuations problem":
> > --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> > +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> > @@ -1428,7 +1428,17 @@  static s32
> > e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
> > - ret_val = e1000e_phy_has_link_generic(hw, 1, 0, &link);
> > /* comments */
> > + ret_val = e1000e_phy_has_link_generic(hw, COPPER_LINK_UP_LIMIT,
> > 100000, &link);
> >
> > Do you think we can just add a msleep/usleep_range in front of the
> > e1000e_phy_has_link_generic() instead of modifying the sleep codes in
> > e1000e_phy_has_link_generic()?
> >
> > Thanks.
> >
> > On Mon, 6 May 2024 at 23:53, Sasha Neftin <sasha.neftin@intel.com> wrote:
> >>
> >> On 03/05/2024 13:18, Ricky Wu wrote:
> >>> Originally, the sleep codes being moved forward only
> >>> ran if we met some conditions (e.g. BMSR_LSTATUS bit
> >>> not set in phy_status). Moving these sleep codes forward
> >>> makes the usec_interval take effect every time.
> >>>
> >>> Signed-off-by: Ricky Wu <en-wei.wu@canonical.com>
> >>> ---
> >>>
> >>> In v2:
> >>> * Split the sleep codes into this patch
> >>>
> >>>    drivers/net/ethernet/intel/e1000e/phy.c | 9 +++++----
> >>>    1 file changed, 5 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
> >>> index 93544f1cc2a5..4a58d56679c9 100644
> >>> --- a/drivers/net/ethernet/intel/e1000e/phy.c
> >>> +++ b/drivers/net/ethernet/intel/e1000e/phy.c
> >>> @@ -1777,6 +1777,11 @@ s32 e1000e_phy_has_link_generic(struct e1000_hw *hw, u32 iterations,
> >>>
> >>>        *success = false;
> >>>        for (i = 0; i < iterations; i++) {
> >>> +             if (usec_interval >= 1000)
> >>> +                     msleep(usec_interval / 1000);
> >>> +             else
> >>> +                     udelay(usec_interval);
> >>> +
> >>
> >> I do not understand this approach. Why wait before first
> >> reading/accessing the PHY IEEE register?
> >>
> >> For further discussion, I would like to introduce Dima Ruinskiy (architect)
> >>
> >>>                /* Some PHYs require the MII_BMSR register to be read
> >>>                 * twice due to the link bit being sticky.  No harm doing
> >>>                 * it across the board.
> >>> @@ -1799,10 +1804,6 @@ s32 e1000e_phy_has_link_generic(struct e1000_hw *hw, u32 iterations,
> >>>                        *success = true;
> >>>                        break;
> >>>                }
> >>> -             if (usec_interval >= 1000)
> >>> -                     msleep(usec_interval / 1000);
> >>> -             else
> >>> -                     udelay(usec_interval);
> >>>        }
> >>>
> >>>        return ret_val;
> >>
>
> Regarding the usage of sleep/sleep_range functions - they can only be
> used if this code will never be called from an atomic context. I do not
> know if such a guarantee exists.
>
> In general I have quite a few questions and concerns regarding this
> patch series. The comment in patch 2/2 states that it is designed to
> work around a link flap issue with the average time between link up and
> down is 3-4ms, and yet the code waits a whole 100ms before reading the
> PHY bit the first time. Why so long?
>
> Furthermore, if I am reading this right, it appears that, with the
> proposed change, e1000e_phy_has_link_generic will poll the PHY link up
> to 10 times, with 100ms delay between each iteration - until the link is
> up. Won't it lead to wasting all this time, if the link is actually down?
>
> Looking at https://bugzilla.kernel.org/show_bug.cgi?id=218642, at the
> problem this commit series is trying to solve - I wonder:
> (1) How serious this problem is. It is normal for link establishment to
> take a few seconds from plugging the cable (due to PHY
> auto-negotiation), and I can accept some link instability during that time.
> (2) Assuming the problem is considered serious - have we root-caused it
> correctly.
>

