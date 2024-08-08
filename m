Return-Path: <netdev+bounces-116748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DB194B94C
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 10:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FF8282874
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 08:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54349189914;
	Thu,  8 Aug 2024 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="r9yfHUnp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DC625634
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723107091; cv=none; b=uQ9oYtndAaHoOT0YxXA6jZuRc+qVbQ50rB+mPIc2QHwToCwycregI7IMrrZiQ0PyRcIHESVd8Hxogc/a1RZLX3Wfk8fOsHBBjqiam8/37YZ/L0x0lvZxykkU0bTgDt7qc2B8oPSIKlsA3t1fQdhMMiM9DF8WjwGMOHCIk4yW6u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723107091; c=relaxed/simple;
	bh=OylNvV/2Jxg8HgS+79ZrnAuN8bkc8uwnAF60VfIODao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwYDFU8affVMU6qIda37/cuqfG2vBUEenSt5+NU1BC/DOUTrYF0JBtMTFH1tROKlBjmeWjfiSx5UDgRgc2TURtTGdFFsFY5qW0skVq0CsNkQBImVDWX/HDCSv8hbT621vHbcPVxZv93NXf6UpL915qhXY8ZQRm/fwELOF1TPXHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=r9yfHUnp; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so8638121fa.2
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 01:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723107087; x=1723711887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDZAVwW6W7U68HIAf2CDuICmRI1k9Gjd2s0qzMn5MdE=;
        b=r9yfHUnpQ9YOr4fgdev2DvXWHVC4/FeXLrBAY30ZxY4/fi4kek0hdeT+7P9roJ0gZ/
         hQxcQJ8ojdTPdnN6GUKB+FK43DXQLCZRFE1zxUd+UT46rrw1/oSLaVqsJ2HWYBUbY384
         Z33umdU/OMWo+vZUYI9dbiJ/jY+T7qidLws9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723107087; x=1723711887;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDZAVwW6W7U68HIAf2CDuICmRI1k9Gjd2s0qzMn5MdE=;
        b=Uovc6NAzV4tB7NQzHVEmEV3DBV5VHqaWnMIHiVbrXoiVg4ylKM1BFoPxKiQ6N8fkb1
         bKmlr52d25ryUR1CWoVAlkZHOdUvtQp/KPokui+/gksbOHNsJCrzndLNteIJ37Zg4AVq
         MpvB2shrSgDNWUNCVv2JMmueB5TBoPn6n6uo1h/eI6e0OlY1eOUVj7IVx33MjCGiuSJJ
         /pEaFbO9M7Em7agtF8EbHdEOSTAeMEXFUuOcCf+hFlNmUvKSRoSuIH5KLVCgeQvKappU
         d4MreznmKRGgG2WntEgTRLTA5v6kGS1E+ZbA9jIbVH4IlFwepLfVs8thqyed1VJ8jOqt
         jeag==
X-Gm-Message-State: AOJu0YxtR4iPVHfuNMn/SQHVtHI83ojacADJlR+qpETox+nD0KB2uzKX
	FTRnpVw3+Tt5wvXBjuZMxrLN2S1SqnH4VadmHZaz75vr6oEOtpTV5ZtMoOvU5OEr5x9MxKH0IUo
	4MQw=
X-Google-Smtp-Source: AGHT+IGCRE9WVyR6A4ka6TTrK9acN1AtsnhfdXconCkBPP1mL84gRbnCT+4qQIt419Mh0Pm9d7CIGQ==
X-Received: by 2002:a2e:a595:0:b0:2ef:2c0f:283e with SMTP id 38308e7fff4ca-2f19de326d0mr8895071fa.12.1723107087353;
        Thu, 08 Aug 2024 01:51:27 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27229757sm1168687f8f.107.2024.08.08.01.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 01:51:27 -0700 (PDT)
Date: Thu, 8 Aug 2024 09:51:25 +0100
From: Joe Damato <jdamato@fastly.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] net: atlantic: use ethtool_sprintf
Message-ID: <ZrSHDR2hoEGx-kNi@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
References: <20240807190303.6143-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807190303.6143-1-rosenp@gmail.com>

On Wed, Aug 07, 2024 at 12:02:53PM -0700, Rosen Penev wrote:
> Allows simplifying get_strings and avoids manual pointer manipulation.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../ethernet/aquantia/atlantic/aq_ethtool.c   | 21 +++++++------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>

[...]

Patch seems fine overall, but two suggestions:

  - Use the subject line '[PATCH net-next]' so this goes to the
    right tree.

  - As Andrew mentioned for your other submission: use the
    get_maintainers script to ensure all the right people are CC'd.
    For more info check the docs:

        https://www.kernel.org/doc/html/v6.11-rc2/process/submitting-patches.html#select-the-recipients-for-your-patch

I'll admit that it is not clear to me if this should be marked as
"RESEND" or "v2", but I'd go with v2:

  example:
  git format-patch HEAD~1 --subject-prefix="PATCH net-next" \
        -v 2 -o /output/path/

Assuming the code remains the same (and you are just modifying the
subject line and to/cc list in the v2), you can add my Reviewed-by
tag to the patch:

Reviewed-by: Joe Damato <jdamato@fastly.com>

