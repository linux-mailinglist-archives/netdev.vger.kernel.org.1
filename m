Return-Path: <netdev+bounces-151377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38F99EE786
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 14:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24766282B5D
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 13:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440532144BA;
	Thu, 12 Dec 2024 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M162+d9s"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF68213E9C
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734009129; cv=none; b=U/7TKZY0nLeL1MvWTtii5i55/mLSOoj+yx3p+79EeMhbKzjQNym8bR9DSSpdwSnJjSvT0CTfVg1deyF/mszLuPqsYW3nk6ScZOJoavwKfAK5hA81JcI7exr8h3G9XVbSESuIflYuQTZ8ZgoV3GULgaBT2ihZUC/tFmYbi1WD8xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734009129; c=relaxed/simple;
	bh=xNH0trxtTOW4rvdL0I4jlBRk+iwSpfBrPX6q3+p6KJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=usWaGpKSgy1pnPmYlmKfFTQizUErjLGYHPM73I2JOpUwWvhiVkQ3QATNMXnswCxbmvaPl6OjgrwmTe/es2J/qJU7RcSqnFk4/QEZ1p0qjglhJQ9f7Aivu1AofCKOIAc68b9O71oyzLfIFrQ1k2lTJGaecDnxuxBVR29lKzORdtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M162+d9s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734009125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cg1nYxP6XG2A44Y9yGhgtQIdlrwL6BM0kKg96k/uz4g=;
	b=M162+d9scuqvE/W6geF+/E5Q83aTeotaCzwb1VPHTAWtg0c1shcGr9Ox+3UBhzLjOXaWF3
	CkG9gId0PW8cPBF9CBzKPXWII3qiKijMN9z3VgvSgTy95H5SpjnPeoU7zEK0t5pg3sNOsZ
	a1Wg7JqruS9u286xlY4hyua/yTFwtZc=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-VyDzj2K0Pkqfjdgj8R5j3g-1; Thu, 12 Dec 2024 08:12:02 -0500
X-MC-Unique: VyDzj2K0Pkqfjdgj8R5j3g-1
X-Mimecast-MFC-AGG-ID: VyDzj2K0Pkqfjdgj8R5j3g
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-71d893a4082so233277a34.0
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 05:12:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734009122; x=1734613922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cg1nYxP6XG2A44Y9yGhgtQIdlrwL6BM0kKg96k/uz4g=;
        b=cLRD3cGWuYONWuLq1GzriSoev2n59O0X8PSyj2ZE+ldSvjP0ydMI00G2OTLgr3fK9T
         fPEkC49cpZRdHgcpZXTPakbjF4WR/xC1jtKQcL0DkYqmu5hgn3FM23k2lSihQkXztn+n
         QDMeXli8tjS46jJMSGcOhnKcRb7YM6AO7+zTK6PZhZHceNrxnQ9WaclVX40MApLMAga1
         ljsm1gLvN0oNyvst1Y1Zbmo5CiRcVPzj6ztUwcGSSKV5SmZaKBYuQTadMzYBtE6hQu2x
         yikBb+XndqXG0wDdmvVJVMV5ASVPQlbKv7f9SVN5+kVwP+HXKKlqt+8txPomVP3g6jdt
         EjUA==
X-Forwarded-Encrypted: i=1; AJvYcCXH/Vm4ALqe01j3PpC2+fLUCKkufT5SYO+p5Ip5O/08ZbB/X87sSPDCweLb8TUnDpUJinTVrk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKs5uH1vNBdmX4Ql5h9IYBgrOLk35SIv58I1M7VlAsHrn3H9Ah
	F9EswA7iIj3qF9xaVT4D6CqPrCdCQwVzSnFG55ZeJk8tMcrSls2rI3Nj3TxTaUu2YbTPqmAo8jM
	XfE6qvTb3JU5Y62lkXh0OwurvnSkQsxvATLXNe/R7jzdSuV+V9wTR+TwkohyR3Rzh9Dwy3Sk40G
	ubCGpL8OMBINSu4CmTSz7LftWX7IWL
X-Gm-Gg: ASbGncusQKQ9CYrYAilaAf7IGLCIxlFLZFSZYUgdbtMAwzqYMxdRW+pRtI5THs1HeRt
	920lEVrHFE26yTAncJALiYnrLN4jzPSljOBAoQQ==
X-Received: by 2002:a05:6870:7b46:b0:29f:de73:b4e3 with SMTP id 586e51a60fabf-2a0128a2e5fmr1284619fac.0.1734009122007;
        Thu, 12 Dec 2024 05:12:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2aoz+nmqiiFuP0zfvq8eSkrlXCTfYsTtSQ0bCvkAzA+SqW9fUzx/j08IR/MBPt9jjTuI1kyLvvaeqR0mCtR0=
X-Received: by 2002:a05:6870:7b46:b0:29f:de73:b4e3 with SMTP id
 586e51a60fabf-2a0128a2e5fmr1284607fac.0.1734009121717; Thu, 12 Dec 2024
 05:12:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115194216.2718660-1-aleksandr.loktionov@intel.com> <SJ0PR11MB586584A7DD6C2BF831B358418F312@SJ0PR11MB5865.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB586584A7DD6C2BF831B358418F312@SJ0PR11MB5865.namprd11.prod.outlook.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Thu, 12 Dec 2024 14:11:50 +0100
Message-ID: <CADEbmW1otJrU3HgcJ2mx22r50Xjmcb15LxJ=h8R8Cs+L0QBGSg@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5] i40e: add ability to reset
 VF for Tx and Rx MDD events
To: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Sokolowski, Jan" <jan.sokolowski@intel.com>, 
	"Connolly, Padraig J" <padraig.j.connolly@intel.com>, 
	"Romanowski, Rafal" <rafal.romanowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 4:41=E2=80=AFPM Romanowski, Rafal
<rafal.romanowski@intel.com> wrote:
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> on behalf of A=
leksandr Loktionov <aleksandr.loktionov@intel.com>
> Sent: Friday, November 15, 2024 8:42 PM
> To: intel-wired-lan@lists.osuosl.org <intel-wired-lan@lists.osuosl.org>; =
Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Loktionov, Aleksandr <aleks=
andr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org <netdev@vger.kernel.org>; Sokolowski, Jan <jan=
.sokolowski@intel.com>; Connolly, Padraig J <padraig.j.connolly@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5] i40e: add ability to reset=
 VF for Tx and Rx MDD events
>
> Implement "mdd-auto-reset-vf" priv-flag to handle Tx and Rx MDD events fo=
r VFs.
> This flag is also used in other network adapters like ICE.
>
> Usage:
> - "on"  - The problematic VF will be automatically reset
>           if a malformed descriptor is detected.
> - "off" - The problematic VF will be disabled.
>
> In cases where a VF sends malformed packets classified as malicious, it c=
an
> cause the Tx queue to freeze, rendering it unusable for several minutes. =
When
> an MDD event occurs, this new implementation allows for a graceful VF res=
et to
> quickly restore operational state.
>
> Currently, VF queues are disabled if an MDD event occurs. This patch adds=
 the
> ability to reset the VF if a Tx or Rx MDD event occurs. It also includes =
MDD
> event logging throttling to avoid dmesg pollution and unifies the format =
of
> Tx and Rx MDD messages.
>
> Note: Standard message rate limiting functions like dev_info_ratelimited(=
)
> do not meet our requirements. Custom rate limiting is implemented,
> please see the code for details.
>
> Co-developed-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Co-developed-by: Padraig J Connolly <padraig.j.connolly@intel.com>
> Signed-off-by: Padraig J Connolly <padraig.j.connolly@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v4->v5 + documentation - 2nd clear_bit(__I40E_MDD_EVENT_PENDING) * rate l=
imit
> v3->v4 refactor two helper functions into one
> v2->v3 fix compilation issue
> v1->v2 fix compilation issue
> ---
>  .../device_drivers/ethernet/intel/i40e.rst    |  12 ++
>  drivers/net/ethernet/intel/i40e/i40e.h        |   4 +-
>  .../net/ethernet/intel/i40e/i40e_debugfs.c    |   2 +-
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |   2 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 107 +++++++++++++++---
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |   2 +-
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  11 +-
>  7 files changed, 123 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/networking/device_drivers/ethernet/intel/i40e.=
rst b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
> index 4fbaa1a..53d9d58 100644
> --- a/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
> +++ b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
> @@ -299,6 +299,18 @@ Use ethtool to view and set link-down-on-close, as f=
ollows::
>
>
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

Hi Tony,

Did your tools miss this "Tested-by" from Rafal? Maybe because of the
weird quoting in Rafal's email?
I see you refreshed dev-queue yesterday, but the Tested-by is not there.

Michal


