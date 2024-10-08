Return-Path: <netdev+bounces-133177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFAC99538C
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 17:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5947F2867CF
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 15:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840101DFE2A;
	Tue,  8 Oct 2024 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q11gW83x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93751E00A9;
	Tue,  8 Oct 2024 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728402212; cv=none; b=MnqvTeDAcxmjAlvx4nde7QsTV9MRnCLIZmyNt/S/taQDJvaJsr775gwUbt+OArWxzNEW2FzbpW4ELnT9+eNt/Vnbs6R7+MFP18liHxqhaRbpBcBwo4HvPf0WCTl9IbGHherjtWpXyFnUIDNMMXA0LsOWNera+mVt5H/NxnC+MPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728402212; c=relaxed/simple;
	bh=brHLlY72/GncTnEuBgT8e226cpJvC5KqmOW0N8WnbLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lq0wuLSxcPlsjxENCD5Zl0/d3lfJdEG6GNWwZRJyWAv+r0nDM5cHHSKqDFfKGO7kEq5FGKXd3Qhoovj8y9E6BT1gcT2C7gwngKo38dhioQwCuwU70gTSscBiFusV6PmtQFHp8aUVfWS8w0ElJm8AWVFHiV63pvsLXF4Td498tas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q11gW83x; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-50a0bf4d4b8so1685621e0c.2;
        Tue, 08 Oct 2024 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728402210; x=1729007010; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QsNjO1HOPCQFWV2E8M3vz66X/+fWZEsDvarBeVLdydA=;
        b=Q11gW83xrrEX6B+qoU+/zV+RZtEzmxA+rzk9AYTMbud7Y8kPBlASuK3PwABMJLZp3a
         R6arUhY0VQedrQGXhC6zKTNDQIcDlM/RUFfB3eowezRFEX+dgepOOPjyggBAJsytwdEG
         Cwh8RZ4dX+tKwYDQSIk8Yey5W48iWESe8NabFZW9djp83vXjkLXD11rUj/IN6/4EhMud
         iN2B3ms1W8pNaOTOk+Z1kHh1Ws/lyyhst//MENvGPQcJ+kVONEzDucspqAJEvt6Cq1Eo
         nW4ONI96O1yG59ZUsNhq2d0RgViH2egWE7T25RvwVOO5opVEAOuylDNbvW8Ci/wyjI0L
         KwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728402210; x=1729007010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QsNjO1HOPCQFWV2E8M3vz66X/+fWZEsDvarBeVLdydA=;
        b=tAJPf25wDKC4xGPGV8JwPeYptEghqQ4rRzMx3zKtryYKq9UDSJ524DpJl9kkMILv1y
         WDcqXyNeMFqASKgz/iNk5ptSMyHFSCYiBKsfUtSjh+T4dX6pAlnDT9cqqqcgS1kUL2rP
         c/6+jmzAfSYjU+zkL+KH2FMfnMmnXD9DDKvNwPtws4utPalTlIbviY8TkEtiBsrbrsnS
         t601JhrbDxLTdVgDm4ECIRH/oEU6EFtZesa+7KbVa8jgZZDv7ye4poDoGJ+k36F4rGRx
         mOsUOfJzt+Ksx3RCGPfXFMB7AGpMfnQOkp9zzCRUh+9tzSpae9tpxEHuSliWgV50k/iO
         9HaA==
X-Forwarded-Encrypted: i=1; AJvYcCU5p4EIoAQPAcchiJ+aiTY+XPiOijvJi+HYMKd9AxIb3/9hSkOnR/ZiWMn/UZC2lXt4cVHLXX5d/nwvdgk=@vger.kernel.org, AJvYcCXCW+HsmIp2lKExgkwbIxmZ3YrPjDQsXjVRgbQ5O/YsCDR+ntHsLx6N0Nbz6C8OVvJyVCsXt56Y@vger.kernel.org
X-Gm-Message-State: AOJu0YztwF3i3dEX2K4K4WcZhs0NDcCsHWvShtCArqKNFPUEDB35zh6V
	CiZ5FwRQNoDQ8YkMq1zIG52XTd7HTjA1NBP2FZPB51E5k6uDDCdKtNnpd3q8w9U2OvKiivrjK18
	uOXBC0tPhnafXuGoNFRAsYSCXh9rY0w==
X-Google-Smtp-Source: AGHT+IENMVPLWqbIiJCBonkG/yvO/XS8srG6VQJqZeMk6pUio0yBGJab8roG+JjwjeZMfaeMCfXVJXtbQhdK9IdS13A=
X-Received: by 2002:a05:6122:91d:b0:50a:318:b39d with SMTP id
 71dfb90a1353d-50c8543a748mr10364358e0c.2.1728402209777; Tue, 08 Oct 2024
 08:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006163832.1739-1-kdipendra88@gmail.com> <20241008132024.GN32733@kernel.org>
In-Reply-To: <20241008132024.GN32733@kernel.org>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Tue, 8 Oct 2024 21:28:18 +0545
Message-ID: <CAEKBCKMrtLm1j3dU+H12Oy8635Ra2bZ6eFfxdixTvYwSEEyaJQ@mail.gmail.com>
Subject: Re: [PATCH net v3 0/6] octeontx2-pf: handle otx2_mbox_get_rsp errors
To: Simon Horman <horms@kernel.org>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com, 
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Simon,

On Tue, 8 Oct 2024 at 19:05, Simon Horman <horms@kernel.org> wrote:
>
> On Sun, Oct 06, 2024 at 04:38:31PM +0000, Dipendra Khadka wrote:
> > This patch series improves error handling in the Marvell OcteonTX2
> > NIC driver. Specifically, it adds error pointer checks after
> > otx2_mbox_get_rsp() to ensure the driver handles error cases more
> > gracefully.
> >
> > Changes in v3:
> > - Created a patch-set as per the feedback
> > - Corrected patch subject
> > - Added error handling in the new files
> >
> > Dipendra Khadka (6):
> >   octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_common.c
> >   octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_ethtool.c
> >   octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_flows.c
> >   octeontx2-pf: handle otx2_mbox_get_rsp errors in cn10k.c
> >   octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dmac_flt.c
> >   octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dcbnl.c
> >
> >  drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c   |  5 +++++
> >  .../net/ethernet/marvell/octeontx2/nic/otx2_common.c |  4 ++++
> >  .../net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c  |  5 +++++
> >  .../ethernet/marvell/octeontx2/nic/otx2_dmac_flt.c   |  9 +++++++++
> >  .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c    | 10 ++++++++++
> >  .../net/ethernet/marvell/octeontx2/nic/otx2_flows.c  | 12 ++++++++++++
> >  6 files changed, 45 insertions(+)
>
> Thanks for bundling this up in a patch-set.
>
> For reference, it does seem that the threading of this patchset is broken.
> Perhaps there was some option you passed to git send-email that caused
> this. In any case, please look into this for future submissions.
>
> Also, please use ./scripts/get_maintainer.pl patch_file to generate
> the CC list for patches.
>
> Lastly, b4 can help with both of the above.

Sure, thanks for this.
Do I have to send all the patches again with v4 with the new changes
to the few patches and the same old unchanged patches?

Best Regard,
Dipendra Khadka

