Return-Path: <netdev+bounces-179974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9026A7F041
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 00:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E081891AC8
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA132222D2;
	Mon,  7 Apr 2025 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iO4IcSr1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3811F4199;
	Mon,  7 Apr 2025 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744064596; cv=none; b=BawAuNRRMUGPgCHLslgi2G6g/Cm+ixUTv712KR+RnMbasSmzxnFX5v8OlFHhIcZR3lIR7ngeeNeMtidWRsYl76lk/I59uC4cVeOwztgZsXuThb9NRh7lnnVruDMT6uOdOZfYKJ4fNDWtnhIiuh2f1w4+YajniM2TuoPLUDdIrr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744064596; c=relaxed/simple;
	bh=vOHCcuStpqZxUTDTbE+guySnY7gWbbaPhAY3mPxLucE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbV0tw4dIY+Hyjp4/7RLc/jbPzfPHGur44PrC/FVPJqSvMdVUFWinXpf7iHmfEYlifM4Rt4ynRjQAaS18CGqGR1fq4ZKTSNbhKAzbNjoN1vZ8BrFMRwWnw7P5BiGwyiQL8SIy48Mrpiwenmuvvm+uw0MFhRdLHmZpfBavwyYN6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iO4IcSr1; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54af20849bbso2337059e87.0;
        Mon, 07 Apr 2025 15:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744064593; x=1744669393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1F7HhWO1LnOhK6MSocO4DGoRqA9u+WS41dhl1g2yR/k=;
        b=iO4IcSr1lyJdq0S1nuVPXRwMA1EKJPqzLPKODdV31MrZCZnT+UiHvpmhCyCx3VVqIL
         e0+mzS+l0k/udF4T2kEYCgzS96RygGTkt0PSAclg7kisIVpZntFNcS35B3KcEG3QqAO9
         N/0S1sqRy34lA1sge/y0yskov+jL3v1NuDWIdK6AtNZtxEFH/h/lNYEsWfGPAWxGGYU3
         TI6aLiZzyEqYfD2peqA8CI473c63wlOMh6r3L6wpkgZiwscWo1uV5I/QSOU35c+jTeqb
         lWir9WweAnEU4xU5NZSg05Uw3J3u5U/ssNwqOpS9x7v0tDr8EirZBRcSa+dQFQyy/uCL
         G7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744064593; x=1744669393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1F7HhWO1LnOhK6MSocO4DGoRqA9u+WS41dhl1g2yR/k=;
        b=VZAxVRqHIdKT4H859sSocmiEnd63eEcXcbQlMNrqGo/rUzQz6c4UbC3lP3g5uCvjsH
         HBet71xQwpwk7QxMT5r9YHAaHb9jLefrg+amV9uIsQF43ozXjyY4XkC0/ZQPIByS0C+R
         aH0YdwiJp0qWbGIEyioPZPetwRZCz85o5BKL9gH3MGB6ra0+zeF80/qBQx9WvEz15ymH
         B7q2EY+7i1bxqYYlFCwQjr+IUwFxX1ZmDgNBbieiAt8b98mDM1rdGUzTK/rV0Tps+n4G
         MaaYssOsVtrKF9GCBEwYhe0h4Fux3leP9grTV8RVCfCDQ00U3SJn6vPI42joiEX19MV8
         7DfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOGrWi02TnRybEoAoG3J9omHlTuXH0CRjX3vRsnvjkpLJGDpTYzwPQ6WuYQsQVwbyCS/udTeUc@vger.kernel.org, AJvYcCVAOg+uwlWAyfwTA9VfoACSj3POeGNqf38ddtqS9Z0wL13GYkAZFGBJtc8mQu0ytQUyZfKW3qYTu/EdYRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk1/XN7oQ8z2NhlloFEAb4CWEhqE367KG0Ggvy1uInhuwuVVqR
	dYv40S9GyuibjccNfMutjEpFFZ4bPZ0PdJMWlqJnlOJQP991laJf
X-Gm-Gg: ASbGncuxgSeGSXn2M+SyLYSsTzmYurTE1AlpHZ6Lj4S4u+aUCSflqaFdAZSfkUhmdUv
	WrplyKvN80xtFf1siCIrtc3dh5QtIlUOpnqe1UAz/W8/8LShmZNisDcma8jxU4WNmSuGSPMMKJg
	sOtQIcnPDBPY/hB+YF8VZLUfBzBT4AzoFWgYwvmZLrxFvAkB85hKVjN8aPn3qWwNdTUsGhcrYlu
	Ufr9SHPs9Ggjxot5Gol8RbRcE/sIVUKIykNMyOT3ilpZck/VwrFNg9DOB+aNSy9lbvwrrRKf0lk
	It1QzOjRl0+GzHLapnnH6j6wTJxR3MqNtoMv6B03JzeZyYvBIGoHdAUFp68=
X-Google-Smtp-Source: AGHT+IGBsMos3hJsyJXySb8JRnfqGLGz1miXDBT/4t4UOyjZMKfYxKN+E9YRH/z/S/Lnnjv7wz+0Kw==
X-Received: by 2002:a05:6512:68a:b0:545:9ce:7608 with SMTP id 2adb3069b0e04-54c22808a42mr3848934e87.50.1744064592721;
        Mon, 07 Apr 2025 15:23:12 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e5c1896sm1377554e87.56.2025.04.07.15.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 15:23:12 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 537MN7dY011627;
	Tue, 8 Apr 2025 01:23:09 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 537MN6sR011626;
	Tue, 8 Apr 2025 01:23:06 +0300
Date: Tue, 8 Apr 2025 01:23:05 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: kalavakunta.hari.prasad@gmail.com
Cc: sam@mendozajonas.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        npeacock@meta.com, akozlov@meta.com
Subject: Re: [PATCH net-next 2/2] net: ncsi: Fix GCPS 64-bit member variables
Message-ID: <Z/RQSfwH1CLcDEuT@home.paul.comp>
References: <cover.1744048182.git.kalavakunta.hari.prasad@gmail.com>
 <1ee392cf6a639b47cf9aa648fbc1c11393e19748.1744048182.git.kalavakunta.hari.prasad@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ee392cf6a639b47cf9aa648fbc1c11393e19748.1744048182.git.kalavakunta.hari.prasad@gmail.com>

Hello Hari,

Thank you for the patch.

On Mon, Apr 07, 2025 at 11:19:49AM -0700, kalavakunta.hari.prasad@gmail.com wrote:
> @@ -290,7 +298,8 @@ struct ncsi_rsp_gcps_pkt {
>  	__be32                  tx_1023_frames;    /* Tx 512-1023 bytes frames   */
>  	__be32                  tx_1522_frames;    /* Tx 1024-1522 bytes frames  */
>  	__be32                  tx_9022_frames;    /* Tx 1523-9022 bytes frames  */
> -	__be32                  rx_valid_bytes;    /* Rx valid bytes             */
> +	__be32                  rx_valid_bytes_hi; /* Rx valid bytes             */
> +	__be32                  rx_valid_bytes_lo; /* Rx valid bytes             */

Why not __be64 then?

>  	__be32                  rx_runt_pkts;      /* Rx error runt packets      */
>  	__be32                  rx_jabber_pkts;    /* Rx error jabber packets    */
>  	__be32                  checksum;          /* Checksum                   */

I wonder how come this problem you're fixing wasn't spotted earlier,
as your patch is changing the checksum offset within the struct it
means the checksum isn't properly checked at all and neither is the
kernel checking that the size of the returned packet matches the size
of the struct?

