Return-Path: <netdev+bounces-75007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD18C867AC9
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744941F2790B
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3385412BF3C;
	Mon, 26 Feb 2024 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Z6q6RCv+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A66112C55B
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962695; cv=none; b=p75CjMy1nh+WdWxuovVbW1fx52Oc/MoBy1iNuy3P2T7sUF/G6ruNOXROi173fjTyDPl1R1b30bKEBfX+88JMS/vr6P0zFUKHQBcEb1P2vvVEehYfZh1AZUxu29tLJhHCfmc01IfPAFpitzlDffhlLAQE0z8WmuuJKd9R0+F+KyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962695; c=relaxed/simple;
	bh=zT5vk+Ejrqv2Xvf7Cyu49ydHjn29chWpWRdpe1SZKR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KH6jACmTpkNVXYrXgrXuqiy7kVBC/tXQim+NljnVFeLS9gpKc9kSy7lkXoGphb1eqPeusi4cb96BDatniN3osznITu9d1j7o9+uPwTvEaulgj+lLenyithH64eCC6NcHASnEemkYVtnZSWBf9VaXT6Z/mxvgdRinSbDZDh+GyNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Z6q6RCv+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso2220943f8f.0
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 07:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708962691; x=1709567491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zT5vk+Ejrqv2Xvf7Cyu49ydHjn29chWpWRdpe1SZKR8=;
        b=Z6q6RCv+8gMsUu8mizCS51jzQwjybkNxBz7glM/kqxLs5FKTcQed8hJx2g+fOlLyS6
         fh1DNJombA6z+Ekn70/Yga6rQIBdAfCPWt3Zm+g/wyukeXmOIj/nvVzJckFWPv89v1jY
         fgOmbruvZ/FnmHBG4fteAygw4YQoub34bsYhAOQhQBNWaHPY+D6vnB4KocE84d1R1hgN
         MlT0fBvu3qKK7xNwaV2F9V0tWAn7tXAT8RiBdEA9ANjNj8h+o8F/gR3yc6/2HGKWxIMN
         7BbZyWaSxTvvJZIsJ3jAIxVNyIGyWS8mAaGU2ruWqvrQNxCAH+jEOqXwPlFbV8lX7cCj
         Ghdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962691; x=1709567491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zT5vk+Ejrqv2Xvf7Cyu49ydHjn29chWpWRdpe1SZKR8=;
        b=cK1L3M+kPivbnlWLfz9sJuCC3VnSQkhazGFMozCsmalY7T6PwSCHTRTqqrRT3d09HR
         7cdwwdH8YwvY8bQ9/x6eieHY/I9x06478YYHLgYnrlPvRbkCQ+COrCFaBD1SsK2Ai2+6
         a+SWAFw+OSxnAIIhTI5pB/CKzmfDYIAg/hbliGS6GSNVZ2y9rkhdJnAZyPUfJFIkmJ5I
         MgM8TgdGmxlsEJ1HGZB5xzwPLsKcENQVitk2ldNNG1oz0SneJDFvUcBmVdTOvotLYmt8
         33aBA+QEA1k33Ao0jLbNr4lJlAk+1HJouy1os2wOGvb7aQNS/Pp7DDPIiL02QgzBLcCg
         WCnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVM+m1WZszl8cbJ2JDI/ES8c+/s7ZVrB+uzBH2Yh5YYpiyqsomvG7SpAb4XikV99J2hD6imN6KOqi3dsonKXi5nYvF9u2w
X-Gm-Message-State: AOJu0Yyvq2bb/LHTZCxonJm7Jk8imeB0NhhBLu/vnLZ75S9bV/t1Tq8e
	I52xn3vMWuksDRvF3xqHx/5bTrb2UPrC2YWeKkfnJmT3AomqyjJQZ4vVU1UUHoM=
X-Google-Smtp-Source: AGHT+IGswgaD/Qa2Maty7tCioABPsCETOEyJ7BpG5X+IjDy7TryNQu+jEK0uzHdco5wH3yvWViXS2A==
X-Received: by 2002:a05:6000:c8f:b0:33d:d252:73e0 with SMTP id dp15-20020a0560000c8f00b0033dd25273e0mr3762408wrb.17.1708962691581;
        Mon, 26 Feb 2024 07:51:31 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id df18-20020a5d5b92000000b0033dc3f3d689sm7632477wrb.93.2024.02.26.07.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 07:51:30 -0800 (PST)
Date: Mon, 26 Feb 2024 16:51:28 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Lukasz Majewski <lukma@denx.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] net: hsr: Use correct offset for HSR TLV values in
 supervisory HSR frames
Message-ID: <ZdyzgHtizHlVS2vn@nanopsycho>
References: <20240226152447.3439219-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226152447.3439219-1-lukma@denx.de>

Mon, Feb 26, 2024 at 04:24:47PM CET, lukma@denx.de wrote:
>Current HSR implementation uses following supervisory frame (even for
>HSRv1 the HSR tag is not is not present):
>
>00000000: 01 15 4e 00 01 2d XX YY ZZ 94 77 10 88 fb 00 01
>00000010: 7e 1c 17 06 XX YY ZZ 94 77 10 1e 06 XX YY ZZ 94
>00000020: 77 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>00000030: 00 00 00 00 00 00 00 00 00 00 00 00
>
>The current code adds extra two bytes (i.e. sizeof(struct hsr_sup_tlv))
>when offset for skb_pull() is calculated.
>This is wrong, as both 'struct hsrv1_ethhdr_sp' and 'hsrv0_ethhdr_sp'
>already have 'struct hsr_sup_tag' defined in them, so there is no need
>for adding extra two bytes.
>
>This code was working correctly as with no RedBox support, the check for
>HSR_TLV_EOT (0x00) was off by two bytes, which were corresponding to
>zeroed padded bytes for minimal packet size.
>
>Fixes: f43200a2c98b ("net: hsr: Provide RedBox support")
>

No need for this empty line.

>Signed-off-by: Lukasz Majewski <lukma@denx.de>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

