Return-Path: <netdev+bounces-127210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CCF9748F8
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 05:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E046F287B39
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 03:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652D339FD7;
	Wed, 11 Sep 2024 03:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="X+w+cTu4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756F1A936
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 03:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726027007; cv=none; b=fP1ZpOY/Q0JWkrPh3f13ou1jjAS3Z2k/fjF+E4Xl0RzK801BX+em9YCd9WkZjGy3R4D6Nhc6z4oMAon7FdtkL3Ctgly8aWbAMjIDirCOpyGJdqH5EJOVD/deS3n8yL8UTkhli/cV/FRqCjjY1HVdrJgoEqt4+/MlSFdUgrqAVL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726027007; c=relaxed/simple;
	bh=8p5CmDjsAdK61oHtAKDY35RYvtpZHIPa/0wqYuiCFXM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ri5pAqvxai61JpHCqIWolor2ohhloiA5qfdXomHobi9le8BPb2E42/YbV6K6ltxa5Stqb5VTAc0F9QBcEXm0TWV3PvTzQTrqdSrK28fPbpKI9L3k1XyLLMkBdaTsKTCbCjMyEVagEsTWTkJXyfXYM9Tx/AzlnqdkhH6OqHR1++o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=X+w+cTu4; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d89229ac81so4948793a91.0
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 20:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1726027005; x=1726631805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRId34MrmjwBQCGTBCcIdTbyoq/BbAp29HJ2NQfUuq4=;
        b=X+w+cTu4JgiYjPyWWKVBsvQZiGvjtu8Jlp1lRZtijWCwInccV0rRJMlVU+5o3m80FR
         vuhy6OOryB3rx6QW7usqvlwnJ+jhMfv+7wHuMRXqRfAU7wHPAOEe0ICp9rX2/25fFKuy
         nhZaGebmLPSedpsF48EtjI6fhtVZ5VhE9umI87nGPCCuN5L6xiuMgUZQ6V9rf6ptRysG
         ADEWqNGpkcs8xcr7N+tKO3puV12DdXg1p9actZLJaY/9Kd3pr3VbUeMywUPjFQoNJK5Q
         bzd7qApoTmgnvp3oQ/M3WWauFzsVoF62AhWxk14Q5pA/P+0X5X441woDxVO5395eFQUs
         hTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726027005; x=1726631805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRId34MrmjwBQCGTBCcIdTbyoq/BbAp29HJ2NQfUuq4=;
        b=QC5AD9cpXZeBOT7vxcnBhFEhl2lIg9ukSbkSJ9Em8h4EERLezuXFRHx7x1c/mtRBiI
         oK4bzkV7KGQWjUcuJC9m/2JPwwpsmbn/TYj6Bx9+1BEVbkAZrQmptXCSJJ4lZAQq1nIt
         5BMGfL7bB/kJsLFxu+ERe3FRMAQraPLBTG0ArTGBURtsLhA2lrkxzkVF7+xwtYkRsUug
         O7me8+UzsgbMskT+HECrg8Z8Rx3J+cCyNdRjeiobMg2iZhZ3mpaqCrmiiZ87Y+ChVuXW
         gXuB+DE9MMKonq7LrWtKxMY5lSF1j2UikEPElHJsAEGh1+QMTaDWj/jSwDMIt28u6KfP
         u43Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7iZ7GKYa84R5w6VL0SmEcxKc0/2Mz995/lrLpFW7vsSTOFRnmUD8VWgl5v2koIXbsB4DoSCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7+QY6i/pM8Y/0TF22SG2UOO7XlPtSVpb1RhTPfC/jgkxcTORp
	zQs+DGarkpA6gGdjtXut84K4WVy6N8cSSZ61cRWUV0ekA6mN07Bt8vdNsAOz7Pg=
X-Google-Smtp-Source: AGHT+IH+Wbk9xLKsf4qNLxlGvXGi3co1pfLth7JoExCcN+noE1farZRdTbjPaemHoKe1jzMWp48v+A==
X-Received: by 2002:a17:90a:510b:b0:2d8:8cef:3d64 with SMTP id 98e67ed59e1d1-2dad4de10dfmr19117653a91.6.1726027004740;
        Tue, 10 Sep 2024 20:56:44 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db0419aab4sm7362746a91.15.2024.09.10.20.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 20:56:44 -0700 (PDT)
Date: Tue, 10 Sep 2024 20:56:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Atlas Yu <atlas.yu@canonical.com>
Cc: kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v1] dev_ioctl: fix the type of ifr_flags
Message-ID: <20240910205642.2d4a64ca@hermes.local>
In-Reply-To: <20240911034608.43192-1-atlas.yu@canonical.com>
References: <20240911034608.43192-1-atlas.yu@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 11:46:08 +0800
Atlas Yu <atlas.yu@canonical.com> wrote:

> diff --git a/include/uapi/linux/if.h b/include/uapi/linux/if.h
> index 797ba2c1562a..b612b6cd7446 100644
> --- a/include/uapi/linux/if.h
> +++ b/include/uapi/linux/if.h
> @@ -244,7 +244,7 @@ struct ifreq {
>  		struct	sockaddr ifru_broadaddr;
>  		struct	sockaddr ifru_netmask;
>  		struct  sockaddr ifru_hwaddr;
> -		short	ifru_flags;
> +		unsigned int	ifru_flags;
>  		int	ifru_ivalue;
>  		int	ifru_mtu;
>  		struct  ifmap ifru_map;

NAK
This breaks userspace ABI. There is no guarantee that
older application correctly zeros the upper flag bits.

