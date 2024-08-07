Return-Path: <netdev+bounces-116456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB6A94A75A
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252101F2129B
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 12:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BF21D175F;
	Wed,  7 Aug 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="UMw2C+OU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD8F62A02
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723032031; cv=none; b=rZqUy7+sD7Am/eqFi8lZZPBNBWTU9yPZZYjHjddclhswj+U3+0BJBEuse41vzvv0Uijj22XDRhMDcwuLe/3VRwvPkiiqnKPt8DZrB0TxvmNhWcSJ5Rw5qw0fBGusnHu6TAzpdtPLu+Tl64CyHH1fPH7I7y/oanoa2VdKHcIdIEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723032031; c=relaxed/simple;
	bh=BquMDs1bKuHp1+qagMV42ll/VOiozjhJi7Sw8UvAEYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnUokKCo3c2enahwKWYzVnDlowBs9pA4z3UD3aVyX0JRERnkcFX8VjGHRx6EENMCnF9BFTiO2F4zsxron6QPuWXMP3Y0q1JCKeJY9yAmBTYVOZUkGZCIkNlPaPNf3R9CIvTJcz2w8V++RnZSZ+qDsAtJaPTvU3CoeoQ3uGeUU7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=UMw2C+OU; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef2cb7d562so17778931fa.3
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 05:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723032025; x=1723636825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0p1HkQOY0pKMJmcKnkysI4PBbHfIfqw6/A3jgwrNizo=;
        b=UMw2C+OUvJf3z03SPrK/cwgAP8Jh9eSoeUkRhJzXeWVxTayjk/IqCP/m/QvFj/BK1j
         wpxdN342GQisdgr4P058njFAjZkIegsG0RNezSI8zMDg9wTq5zMSffjLaO9MOH1mfaWi
         MyRhGZnkLnUjioyqoHewORKxnmrOLX8rOVwg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723032025; x=1723636825;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0p1HkQOY0pKMJmcKnkysI4PBbHfIfqw6/A3jgwrNizo=;
        b=ba0RbjQyXfns5ZxCDTlJoGbDPo1wDhvmhPMZZewALeVlUOFXji8giVVlE7YD7rqJ4o
         xbvNZWhilcU2Kkl883UuSJOdaeOwsRiB4M/fk9+8EVn/fmvx/SlF569JHHHeG7vkwLw7
         1Pye906ZKi5AKb3Niwl4Ipt7PWGLSEVtNlaNjec/ylBNQSJJFy8x6q2OfuMelIkEt+sJ
         FSaobjlkreLLwYh2FJjj0sD/O4/PDha6sVbSya7hPnKMdtHfKA5J7BPc/0Kem8d7xiHH
         IMbqB/0oju2rqcUAkIYJJ6gMCHleLspj4AgIMnaKkoD1La/CKx211QUwmHQJyuBF7tWN
         CwYg==
X-Forwarded-Encrypted: i=1; AJvYcCVU6E+Pjqj81sqwOA3OFamy64B58XJ3hg1TZkW13jV0KfJyFyzhknr/U0Z43YJipuSnU5reAgGR2WChtdKLATipszceMl+0
X-Gm-Message-State: AOJu0YxGN93iun+AuQQvywrSNIEFpAsMFLhYCXJsVQT1nKwNm4/4mrb4
	hdnHM9kTIAW/CJJ4UQvKXbyIl0yyVTB/cMl1//+Qw53w3pfFi/fQR2AxqoM1pwU=
X-Google-Smtp-Source: AGHT+IFHOz+DQ05hHEbhY2wB/CsAfn59cjIpmJFcEtEyMaKZEr/IXiaLySgzXiFG0AhAWjbH4VgA2Q==
X-Received: by 2002:a2e:7011:0:b0:2ef:18ae:5cc2 with SMTP id 38308e7fff4ca-2f15aac0e67mr125832011fa.21.1723032025149;
        Wed, 07 Aug 2024 05:00:25 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290579fe08sm26157755e9.16.2024.08.07.05.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 05:00:24 -0700 (PDT)
Date: Wed, 7 Aug 2024 13:00:22 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, michael.chan@broadcom.com, shuah@kernel.org,
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
	ahmed.zaki@intel.com, andrew@lunn.ch, willemb@google.com,
	pavan.chebbi@broadcom.com, petrm@nvidia.com, gal@nvidia.com,
	donald.hunter@gmail.com
Subject: Re: [PATCH net-next v3 11/12] netlink: specs: decode indirection
 table as u32 array
Message-ID: <ZrNh1lNwKAzEwTHw@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	michael.chan@broadcom.com, shuah@kernel.org, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, ahmed.zaki@intel.com, andrew@lunn.ch,
	willemb@google.com, pavan.chebbi@broadcom.com, petrm@nvidia.com,
	gal@nvidia.com, donald.hunter@gmail.com
References: <20240806193317.1491822-1-kuba@kernel.org>
 <20240806193317.1491822-12-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806193317.1491822-12-kuba@kernel.org>

On Tue, Aug 06, 2024 at 12:33:16PM -0700, Jakub Kicinski wrote:
> Indirection table is dumped as a raw u32 array, decode it.
> It's tempting to decode hash key, too, but it is an actual
> bitstream, so leave it be for now.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/netlink/specs/ethtool.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 4c2334c213b0..1bbeaba5c644 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -1022,6 +1022,7 @@ doc: Partial family for Ethtool Netlink.
>        -
>          name: indir
>          type: binary
> +        sub-type: u32
>        -
>          name: hkey
>          type: binary
> -- 
> 2.45.2
> 

Reviewed-by: Joe Damato <jdamato@fastly.com>

