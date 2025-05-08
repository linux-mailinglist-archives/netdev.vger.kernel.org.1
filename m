Return-Path: <netdev+bounces-188965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8210AAAFA3B
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC0C3A8C0D
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 12:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73407221723;
	Thu,  8 May 2025 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hK+x3mHv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3DC28682
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746708055; cv=none; b=pNLqoQJxKMPhMr6RyS9WY5STCsfRq6HJlQq4aUSIotw8T2RodDrVrYnFwCVMSUfwDkCWaHsQR47vnu8oiRXFdB4RSDISV7fu/HnqgUpTmz5SVuNY1op/xzSGmjAPquPuCtzx24Nwgsuc/yqRICIZg3SrTEyiMBSNN+r+TYvdu+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746708055; c=relaxed/simple;
	bh=pKlFSibVCuIKUfeHuryuhDjuzsa/O1p+KQkiTD1DxRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9BYTElsiS2BcUzEqcNhNlKTl5Z9Qze7tRb+Dmt4b6x+EWu4dHQiQ1jBl0rHQI6BGMHozDrg+SfSyz5YvTJgsMZaNMZ64LKErmn6LSIs8DbiiLP7ZVP7KX4OLCl1RKkWBeNjqttfe0Uf9gDSclKTzkff3CwMjOP/S/q7HiG4Rq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hK+x3mHv; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5f8619031f1so158076a12.1
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 05:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746708052; x=1747312852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FfaMOjFCxtcOF8MhEpb1KgHLIQZnLvXhrX8KE+Reg/I=;
        b=hK+x3mHvMCNCXo3cWrE5lwD3J9r5kwkEnT7Kapjx/bnIqk1SXewLhgEMxbk22NJxbT
         YPYkS3KWcPCfi8F910sqp9fE7A44As9+xU+L9GeoDi8R+/Bw7/SKnnhMe2skY2jLtGCB
         Is0wxNxfJQ7wFG6veeTHfBrGdYBlrwIyZBew4EGUczSsz1vBLisTx8pzOSVUTngm3CIQ
         wImaYvslIy4a9ScohB+TzhxhLdxVr/Qap3zPWj5SRNO8XEp001hFcxex8/+YfjM0CdjL
         Fng53h9ClaUUaLFcGtkgjRR2fYahdbEcKCI1QYTGoQTc5D2hRL8gMS43ykxD4jKpFU41
         3oGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746708052; x=1747312852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfaMOjFCxtcOF8MhEpb1KgHLIQZnLvXhrX8KE+Reg/I=;
        b=Fr5j1JVEKImg4GwOl6IUGoiN9unRA5EDemJHwlVR+nEWyWSYLyEyWTiMAMxr14aJAy
         8fCvS8n2aBYd9mVZsANWCJWrzsaJImAY2Yx4pyH+wJeI6DfFrrYIP9DE6i/PT4doWNWV
         HqdHsgEXYiNow7DJz9m8mWGqIonmG794MoXnvQ0fx6xWzv4oooMP0TanpFgEukUpJAt5
         QsfsdRNGn1TC8kaJcL25V8EB5DwMIHxqc2To75y67nOBt7rBkOX1sC4qv9E40gnt1BPf
         /rD41XXv+5H68n1SsDjrZhnbyCCqwIsPLSCAkvWm5AykU18NeqCH32SObE/DfwqDkPcG
         fujQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZBgxVQ4s5acbRRf9Svaa+RLW3kdu4QuiCbtqq4YS46eq6lHavM0CcHuYoR/II2GxBz2ZE6/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw0cq+Z7kQG7ud46c79qGCUeIuZm22LxrHSJUiGAA54qKxNF/r
	P4FUP3cJYm8OWRVTK6qeSjN9D93OPh8pjOqf2mm/DPU3jDhctVY2
X-Gm-Gg: ASbGnctIbfXKCYWo9klABUoBrTz1m4Lt9neIRJE/GK5TDkZS0g5Ovv2Fr/gYbD8uNct
	SJIvHKcZIHIrJyOLbu361znIa6sSiIoPtlEb0nz6hii3K8bm8ZpkPxmMXy1bksIa+ce7eFlGaKL
	ektAibm0gPd9WjCQdf40yN+VBsvgcVZls35BxrB/3OjiZ1Y5ohNgAjQIeNIEUUjql1+1Y/f/IpV
	vsFZZO7j0PolpAUgAsIVvfgzlANLmj5lH9KbSUfvbGGUkspkxnba+Gk2GB0k2G5O/52NdVKM+SE
	QU6EuFUk9QClfXAk7We9eU3KgYAr
X-Google-Smtp-Source: AGHT+IFmPs/2aiiB0+rhM6F30MuvsarGsibw9G89lQ2xc3LVHmTRux9M5oIqfkwsO5WMCG0k9AZPCw==
X-Received: by 2002:a05:6402:278d:b0:5f9:2a29:543b with SMTP id 4fb4d7f45d1cf-5fbe9e329e6mr2233823a12.5.1746708051532;
        Thu, 08 May 2025 05:40:51 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa777c8b70sm11517512a12.29.2025.05.08.05.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 05:40:50 -0700 (PDT)
Date: Thu, 8 May 2025 15:40:47 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>, irusskikh@marvell.com,
	andrew+netdev@lunn.ch, bharat@chelsio.com, ayush.sawal@chelsio.com,
	UNGLinuxDriver@microchip.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, sgoutham@marvell.com, willemb@google.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v1 4/4] net: lan966x: generate software
 timestamp just before the doorbell
Message-ID: <20250508124047.xyhrabkxsbhceujv@skbuf>
References: <20250508033328.12507-1-kerneljasonxing@gmail.com>
 <20250508033328.12507-5-kerneljasonxing@gmail.com>
 <20250508070700.m3bufh2q4v4llbfx@DEN-DL-M31836.microchip.com>
 <CAL+tcoCuvxfQUbzjSfk+7vPWLEqQgVK8muqkOQe+N6jQQwXfUw@mail.gmail.com>
 <20250508094156.kbegdd5vianotsrr@DEN-DL-M31836.microchip.com>
 <CAL+tcoBrB05QSTQjcCS7=W3GRTC5MeGoKv=inxtQHPvmYcmVyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL+tcoBrB05QSTQjcCS7=W3GRTC5MeGoKv=inxtQHPvmYcmVyA@mail.gmail.com>

On Thu, May 08, 2025 at 08:22:39PM +0800, Jason Xing wrote:
> Thanks for the kind reply.
> 
> It looks like how to detect depends on how the bpf prog is written?
> Mostly depends on how the writer handles this data part. Even though
> we don't guarantee on how to ask users/admins to write/adjust their
> bpf codes, it's not that convenient for them if this patch is applied,
> to be frank. I'm not pushing you to accept this patch, just curious on
> "how and why". Now I can guess why you're opposed to it....

The BPF program is not user-generated, it is run in the context of the
function you're moving.

skb_tx_timestamp()
-> skb_clone_tx_timestamp()
   -> classify()
      -> ptp_classify_raw()
         -> bpf_prog_run(ptp_insns, skb)

