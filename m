Return-Path: <netdev+bounces-68085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DCA845C9A
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C8329A837
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43BD626CE;
	Thu,  1 Feb 2024 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="We/Sq/kk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F24A626AC
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803955; cv=none; b=IoC2Hm6APWkGYjbMBiPpKdUrGjUGtii5QaTXpmhYjLFIKKg4SLcGE4NuKcyiN0R23IfNNzip7j/TObwB4NS3R4I+K/3hIO36JMkwVm2ca8zZvJY0F9+wiQhmsODt5QOKvDZS3MvbnGi4t6nJU/DoZxvbNtiUGBzU5UAhfcZVGM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803955; c=relaxed/simple;
	bh=HgL3EIZArKvM++6XCAVlUbBRfjklGj0NcZA+UVymck4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLDaCjxEPzRHrZzwDxkcQvsft8j2enKM9RIggAgfyGgfF49tt0ryAVQnX6N5QLFNmrVO9Qmun8irg+soIzvGUu2X8ML+laG7SN2eU9zSpMUiOKHKy+dsXxHHskOY3ltinN9MXixpdTF35PZqOLGPKZlQSe8W4SBhMqYEGG2WP1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=We/Sq/kk; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-511318ef27fso690879e87.1
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 08:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706803952; x=1707408752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CvoQIc67FAoNioKR3qRI5MtFNwcL2F8AsiX5nruoy0k=;
        b=We/Sq/kkb5zgylP2r0J71i7VPB4T1YA4V9nhnz/Gz4QKqyxt2IeeapbyxJXMaf3MNB
         6/Rv0lQe0FcysTsGk6fdzhOQe3QTE7/mNFz9zT5DQMirPsG53ZSMJigVD6r/F8ftduun
         Y043hM87gS5KKvO8qtSx5atPnyBPrZAjKbrq7RLwWLI1GxENzhsEga8lAcOEFQ8It0S4
         Sf2VxItb2VJzliDqvVzIJiYgOBW1e8qD5Wt+DKR5s+w0LUXH6scw2n/Wlrh4MTuAtS2S
         Mb2yvA+dapvLuEwxz/12p9aOiTfGN+XuW7s0PADQG+o6it9OcZbB+mDtGFmS6nOjMoa7
         HUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706803952; x=1707408752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvoQIc67FAoNioKR3qRI5MtFNwcL2F8AsiX5nruoy0k=;
        b=gRntdOteEpUQwgfsOshBwAOVLyr5m2RoOurOlrfzdT6PVbnC/HtmRl5ZGv1My+NlNH
         A3uOu67cJcGWhBKHIz6xgwAEunKBPufBy78uTzfLCR2lG33AmGyAbja1rziQjQ7e0jFB
         J2NVb86oncgjDg3bmabPddEAptGObWDA0ehAMXeO8EBUKSsTeNO45ZEYRqX3t8b5e3a3
         2jef4pyFNd2AQvTOJ3HufGF2yMhV1pXY2Iz6odRZ4pu7+d1HoWtd26uyRTXkM/8zx0zF
         j0JGZT4kEcsxf+8iBjpBRNkHZ2FEPCjCyvDnlzqkCMRVU0V7mvX4USe7PYvqrxF/MYvO
         nRYw==
X-Gm-Message-State: AOJu0YxAJsMzPMF4LZ+kVqxj/snno91E1WwLKzBGU0wr6fYmQ9cr7RRh
	nCOssO0TQ+vU+kwlcQ4I5nW3pnTUDpyUZdNbgMXsdsg2j6z24qHQgHGe2U6f+rg=
X-Google-Smtp-Source: AGHT+IGr09+huv+FTiB4JVcV5/pIpI58ecy92fFBj667/Ha/7du0yP0ZbJC0clGDfTUYuNuA6LcL7Q==
X-Received: by 2002:ac2:4a6b:0:b0:50e:630d:7364 with SMTP id q11-20020ac24a6b000000b0050e630d7364mr2131137lfp.28.1706803951911;
        Thu, 01 Feb 2024 08:12:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU+9vwQUNWeoiAGERLW4E12dj14cC6EHC2ryUobc/HHgbX3+9OYj7hZCbevzV8X7gJMlSqSUB5broBkeh4XeTNiHeOIiajF9+qkRbIs/CVRSMioZqyMp8qqkSjsHz3Eesyy3/uJ35TkLgMrw5T9PH7kOBWx0o6skj++DEBp1+JryCeeUn938dDWimbfYBHsfXhX9sQ1XN88Kcoq74k2CJE68LIuRRwUiHYO8cAv9JcLBkD737qQpOWZm/FETrTj/wydSgBkB6ulkMoF1oXsSVCKEwRAZtZ56q7+e/Oon+LzlyJJnbH+O3PFZjmq/VdjT/YxmbhtZtqpRnuiOI7RiUMi/FUnFLMKgfdN5S59ixUlmmNHip7O0GAIDVQezESoRAMIFT3+9mYa1/JeKy6A3M2U9eRGZHfSK+zu71RSyakpUngmsq323bGjV+p1RpsKJTpwu+d9jD29q3TdSCL5RYNzBc/BKhFpMbMDnjx9556WZzolbASZadtyfW1shy2RsMwYFdMxUTFSl3u1w6nMdF/PUALS0r8bSA+F/vaIK+cAuVzAVizb68f8p57VzSXUchsDGCD36UxQk7r5i9c2XybQ27Ohny0VdPGyey91Tqp9kIQU7lHQjXLH3ElgHnwa1ioSZ5a/Xd97ari2LA9Bmis5LLVld0QNWtzvBQPESJejsopeYj7sPR9DXA2Kl5wGGjsZN31IzD7FnV112krVfn/0s/YKxwORLsGw7Q0qSPYftw1jwGdD+9qjpQYpqhSEBnMDz/B9unO36xTUJJvN3zAVGWhNe2hRCxlBy+9j7nAIzLkGK4vf0OjL4bbbastQeWBSPNW/8wdauC4x0u4xrBHTfs9SG3jKtBtJvoWqFgqi6hHzY7Atr39wM0vqUOSOdPm0bmxt0hYWrE7okg5l+6cVJHH37dvY9JKnJGfNQmZzrbc8nw==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c500600b0040fb01d61a3sm43883wmr.18.2024.02.01.08.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:12:31 -0800 (PST)
Date: Thu, 1 Feb 2024 17:12:28 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jinjian Song <songjinjian@hotmail.com>
Cc: netdev@vger.kernel.org, chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.com,
	vsankar@lenovo.com, letitia.tsai@hp.com, pin-hao.huang@hp.com,
	danielwinkler@google.com, nmarupaka@google.com,
	joey.zhao@fibocom.com, liuqf@fibocom.com, felix.yan@fibocom.com,
	angel.huang@fibocom.com, freddy.lin@fibocom.com,
	alan.zhang1@fibocom.com, zhangrc@fibocom.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: Re: [net-next v7 4/4] net: wwan: t7xx: Add fastboot WWAN port
Message-ID: <ZbvC7E_J7U6zBwJD@nanopsycho>
References: <20240201151340.4963-1-songjinjian@hotmail.com>
 <MEYP282MB269704BFB8AC4893C300EDBCBB432@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB269704BFB8AC4893C300EDBCBB432@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>

Thu, Feb 01, 2024 at 04:13:40PM CET, songjinjian@hotmail.com wrote:
>From: Jinjian Song <jinjian.song@fibocom.com>

[...]

>+static void t7xx_port_wwan_create(struct t7xx_port *port)
>+{
>+	const struct t7xx_port_conf *port_conf = port->port_conf;
>+	unsigned int header_len = sizeof(struct ccci_header), mtu;
>+	struct wwan_port_caps caps;
>+
>+	if (!port->wwan.wwan_port) {
>+		mtu = t7xx_get_port_mtu(port);
>+		caps.frag_len = mtu - header_len;
>+		caps.headroom_len = header_len;
>+		port->wwan.wwan_port = wwan_create_port(port->dev, port_conf->port_type,
>+							&wwan_ops, &caps, port);
>+		if (IS_ERR(port->wwan.wwan_port))
>+			dev_err(port->dev, "Unable to create WWWAN port %s", port_conf->name);

To many "W"s.

>+	}
>+}

[...]

