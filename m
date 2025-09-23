Return-Path: <netdev+bounces-225592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB07B95D0A
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 14:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C498E1898D55
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 12:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053F3322DBA;
	Tue, 23 Sep 2025 12:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ONyn2DhS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C06322DAD
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758630005; cv=none; b=GYUEfGwGMPwDalWTXeGRUvPJmNqk1wCeQIHe62+cPGzg7/ILhbnIKnHm9Uf7LYPaz/ZbIhIOR3iQyV8Q18+PcVAqgHei/QzlE3/Eagt+uK4X3O800iWzuryR3yhmuB2kMqXJaIo+oBKIvNjn88paJxc37udeksYazx+rFqjYu3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758630005; c=relaxed/simple;
	bh=5u3Tf4zsWxGWOtJhDSUGMOTvoKdRhCkB563LHF1FknA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pop9MOlKWJjQ//jQX3lED+YXC7rSyjk9U54ZMQRWIhDzgg5gV56mDTLGNC/XZFFkcxL3WzRSfpoUfMPm9B3x/8oUssN29JsJ5Np9NNMSBEFXy3cRmKsl1d7pe5tcIfdto7lCpbcFPHkZEE6mD/K/6filWQBoXs6LYoW1rzzqzFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ONyn2DhS; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-74435335177so32728997b3.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 05:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758630003; x=1759234803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5u3Tf4zsWxGWOtJhDSUGMOTvoKdRhCkB563LHF1FknA=;
        b=dIoKcQnAG9T+Qk9cz/f7eCG1yfNjEHUyEFXRSBs5d4Li5RySy7qH9XaAy2VbjdVHen
         XLu8vyb2tR+JcQX6jDIc5SxSlG5iE2DjAYTBq0L3KOokOYBfB/GmcNPekrVuiWNDna1x
         5RIIiBxa56bwzJ6ZqW7OPh3UdXVVOEodVFGEcaeRZD2S9nVQh7bseam1YHvdkmeIhLLZ
         EtFMsWJ97oHGrrspkY3KWaQT/7H3oIejlOUWYXnSJAWWS6zQCJw3yxGpGOycin+UVo1g
         h2s9vAl9dDemY3Y4qk5zj2y3McYFWZJ10qZSItUM5OmxkoQH2vz8ctg/520m9j/UOnmC
         znAg==
X-Forwarded-Encrypted: i=1; AJvYcCXzvITr1mCK/EsqbXj7Ld+rrAbVkFzTpH2qyBRDugp1bXzDTShpSW8p/4CCvCxwc5qeI4SStXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj5U4KK0rdJvJyJraElhbpbqmQ1FCUzjBOv+1RnIg46Y17N6f/
	xR9piDLh/e6VRIAVUtjX3hfNGAmqQZ+APdvvMAGEPmx7WzsYc1sm8H2VfxnWhAF3YnlJeRsjGf9
	Ej59U93UAKGZarcPvuxb6MNu4IIdo09klcd8h7hl2yp3GuVs/UpfpATL/Lf6cNs805YbybD046K
	eWpo4Mo0hGPptj1z2BWVsHhg5ITITGyYBMzZPo8ews1ZMptdusvpSKVcwQl+IXutAKpOoMffoSu
	wQ6fGZGbIM=
X-Gm-Gg: ASbGncufY03HvLArgx11uX43Sw0yDxgdZfgoCppOoiqZublgaUs++YTjx8jYl1psjE/
	bOSoRhUStJodOr8vQttWwMBCGJoD6YBnc4iO90OB5bsQFrE+rdtkTbwIQvOQn0nl7mJvvVgF/Zd
	t86JRIkunr5RPxKaLdFejN5uDjJoTshT7qwKjd4VHNYGV80hndGFtPmUQ7wJisuIbz0WZsXFgw8
	0pm31nP/UagICz9dgU8UMMtghqzTLi6orNvlsmfTioxBnq1anStBI3FypRO84g4XwWln+HQC75L
	GD2QTawIyiaBRizeKHkRTmBOIUfmIMwd/hSdLJ5yB6GiHfn1Zm5uKUYSJ2JdYDnBC0gjrrw1gbM
	qawiQbUxpJTHOUFyrd6uQqm6w/pcvdn13bih35fLbsBxPXhnNG5ols6TmuFgeFiB/zd7Yti6Hvi
	Q=
X-Google-Smtp-Source: AGHT+IFYUn+fmAiTV4VuOXIkpxMThdoCPuvdNzoIS7nihnHCgI3IVVqjwqbRPZC105ZQG2qypO62YZR7iSNk
X-Received: by 2002:a05:690c:5887:b0:744:9c41:c54b with SMTP id 00721157ae682-758928a5dadmr10857367b3.12.1758630003124;
        Tue, 23 Sep 2025 05:20:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7397197380dsm7109547b3.36.2025.09.23.05.20.02
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Sep 2025 05:20:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b54d0ffd172so4288457a12.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 05:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758630001; x=1759234801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5u3Tf4zsWxGWOtJhDSUGMOTvoKdRhCkB563LHF1FknA=;
        b=ONyn2DhSVR6LRldRb0wKOUM1+qdBgb3vpBlHj+RfnvOrEutUwtgckbsd8Pz/Gd8ZA+
         j/J9/q4DAiFxvdhwsmoedfPilpnzKR0HWaZnWE8saHthurFucN47YSsmvQ3qCna6Pgjs
         6Qh3SE8d95x6X1vbtPo0/0w/G9vvkngzA7xqc=
X-Forwarded-Encrypted: i=1; AJvYcCUT7xBTfM2QBMT+ke+vVufGpgp+hYkfLT8PG3YXcdGV95M5xijvEvZjdzG0GPXQEDcfykmwWWI=@vger.kernel.org
X-Received: by 2002:a05:6a21:99a4:b0:2ce:67b2:3c41 with SMTP id adf61e73a8af0-2d108952c2bmr2932189637.5.1758630001462;
        Tue, 23 Sep 2025 05:20:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:99a4:b0:2ce:67b2:3c41 with SMTP id
 adf61e73a8af0-2d108952c2bmr2932156637.5.1758630001091; Tue, 23 Sep 2025
 05:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
 <20250923095825.901529-6-pavan.chebbi@broadcom.com> <20250923121704.00000eb7@huawei.com>
In-Reply-To: <20250923121704.00000eb7@huawei.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Tue, 23 Sep 2025 17:49:50 +0530
X-Gm-Features: AS18NWAHrU1KtZ1-lxx3sgGEcq2CmV9ssymb8cxBP8El-aUe8vbtDeNTu-N_JLo
Message-ID: <CALs4sv2gUisgf4QxO3Sed4y7TSo3tnieVSen6yGSPSgHh9xT7w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/6] bnxt_fwctl: Add bnxt fwctl device
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: jgg@ziepe.ca, michael.chan@broadcom.com, dave.jiang@intel.com, 
	saeedm@nvidia.com, davem@davemloft.net, corbet@lwn.net, edumazet@google.com, 
	gospo@broadcom.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, selvin.xavier@broadcom.com, 
	leon@kernel.org, kalesh-anakkur.purayil@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Tue, Sep 23, 2025 at 4:47=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> I was kind of expecting something called validate_rpc to do
> the scope checks that we see in other drivers.
> e.g. mlx5ctl_validate_rpc()
>
Right, skipped applying scope with the intention to support all the command=
s,
assuming good faith in the sender. Thanks for your comment, I realize besid=
es
missing to implement an important fwctl construct, it also does make me app=
ear
lazy, to segregate commands from a really large list. But I will do it in v=
3.
Thanks for pointing out.

