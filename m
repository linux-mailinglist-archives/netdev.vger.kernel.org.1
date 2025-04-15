Return-Path: <netdev+bounces-182740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0568A89CB1
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0825916625A
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF8928E61D;
	Tue, 15 Apr 2025 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFtj4Kom"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9F128BABB;
	Tue, 15 Apr 2025 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744717272; cv=none; b=i13PiC2CHXp2dfdp1jyQ6pBj0m0AtZtlr74vGZgUupkZfEmKHMRoSpNM39qEjBTzfS7KvBrBaRyHVTTEI2/BXGdvdkXERr4LRi9cOvO2PXPGLvMYR7XPtY2bmRCz07pbsADq+fWGL6T12dPoCRPdNtZ3710Gjyljc1g9nKdKFnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744717272; c=relaxed/simple;
	bh=g3hn0yGJMo7DDiRSHoTwt5wFttVxHTxAvkwjmrqrWco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kI0J4/P2+I3cItqJGPaJPLtgUtu2SmETxjAHTLGRhoghGQos/WoMqAfd7ToGlaUWBfxgzlS8YtcXTQ03JVzjJL4UvZ+Rd0ruCYrEAap6xpRzoUcioWLjRK9V6br95zjc3jKjwbYbgrBrxTSnHy9NLpOHRl9xY24OOuij5TzH0Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFtj4Kom; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54b166fa41bso6362957e87.0;
        Tue, 15 Apr 2025 04:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744717269; x=1745322069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WgLwTxTesNXhvi5z13KJSwx0wnAaoY7RDa9n3Jg4iDE=;
        b=IFtj4Kom/F0fNbWof0XQmXY5+13t9BYi7jH+Z7zxZafEs9FyQDH3fLTJCQ0gUX2tSA
         RmP7HhxD2cNic+6DLJOIvVKc0M1MTBl38Gh2KcqlPk0bPA0p4GIPRD7FjJ8ZVEWUa0J5
         OzuifTtaQGe3TEROG2Zj2DR5t5ygTbjydVxBxWWRf2m7MGPnKTZ9ANHWQIRvtrXzFZY0
         BTom7vrzLqz6CiucYyhlM99VBCXRcDB8VZsUnRVZwVETZ2dBLO13Dqi6hKr9yiMZ8t6f
         yu/hhFSMtHpXWJ+2snyUA4OQsORQyu9Xa1CkcbtSG5TSmkpTCSkF0L17jev+Oud9ZBkp
         SDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744717269; x=1745322069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgLwTxTesNXhvi5z13KJSwx0wnAaoY7RDa9n3Jg4iDE=;
        b=O5CcVWWLqs5GYsXeCI0FAoKMuVXxvU+1FiWCMMTeGV0FKbly85HnByPm+G6WztAy/z
         +n5k35FQGJOsDNQShajkbg5blzjGFVndis6ZWq1OikBmQ7zqaKnUhfDu6XJnV9rXBmEy
         MLYoVL0cMgEsR62cBSqHTbIoGKsFQ6k61jXtlD0GCYFtw6HVskXlRKhVrMDS2kokg2A2
         FJ6FA1c+07VTn0rUAwEpYOQ/MJcVyomu5uZSvahHTB/6wohej1kGi6lfAQkFXLLr8vPk
         2OC1fIE5POeWn4qOCjqDV82dVtZd3c1CqxS2flNhDooeR5isUirWW8/GDd1Urdr1nzY3
         Na9g==
X-Forwarded-Encrypted: i=1; AJvYcCVkSflHSdl/jC/AtatQ/WtpgN/Capoo6Kd/7mQ3xselrJx1XvPvT0RF1h9ZTGdmZGR0h4s+0RRK@vger.kernel.org, AJvYcCXLVXV1iTLS139WVKDBsIjfdrlQ6fth7ZfAoGINp7MqR10v82MjL6xmEw1rPu+NBQnzsOWePM8WEQLpJ/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjFNYbJlZcMOKzM4bOeWFdc2XxpF6b4jbB9+GNM0SDPsD6btap
	K2RqzMkD8oBuEJqgU6y4i7p5xE9Ib/lgwKpcZmxOWxy67DSichWs
X-Gm-Gg: ASbGnctFx/P+zJJ1EZlJJFA2JpyHIuE3pDoSveYy9SaRxUtw9/DN1+PXlxQO42WnIMP
	HrqBjFz9vkr4Lhd+GHJaXDRIOedecm3DE2aslu0iKo2G0kHddISj2kqSGGWMcRi8RfUVYBdnRnH
	cLLWEOa7xdXZnlVGUW6tBbl4LUiDry8gT8uIpuomiOQZ4z1L3+6+hmm8X8PlZbt1EILbfK1ZJW4
	d480AQnph8xmb2zt1nCpLG5nTn4hqfarCemIrl5Oi41A1PaGnHOOnXqru1Jviz61nHe2oTtf9mY
	dXSnUe/pWwc1mkBXHFk8R6heYY6qBNrODJlOTS08gt/rxM79xTYFH4E=
X-Google-Smtp-Source: AGHT+IHV+K8qXT7IR0FR10Mxo2JrlNWFRM/MZldNhPuRhi4cHdWhibmxpGQXnMajrdq3ZLJL1H7Ktw==
X-Received: by 2002:a05:6512:3e12:b0:545:f1d:6f2c with SMTP id 2adb3069b0e04-54d452965b5mr4581312e87.18.1744717268913;
        Tue, 15 Apr 2025 04:41:08 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d123663sm1407642e87.25.2025.04.15.04.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 04:41:08 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 53FBf4mG029154;
	Tue, 15 Apr 2025 14:41:06 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 53FBf38t029153;
	Tue, 15 Apr 2025 14:41:03 +0300
Date: Tue, 15 Apr 2025 14:41:03 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: kalavakunta.hari.prasad@gmail.com
Cc: sam@mendozajonas.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        npeacock@meta.com, akozlov@meta.com, hkalavakunta@meta.com
Subject: Re: [PATCH net-next v2] net: ncsi: Fix GCPS 64-bit member variables
Message-ID: <Z/5FzySnQ2y3stpj@home.paul.comp>
References: <20250410012309.1343-1-kalavakunta.hari.prasad@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410012309.1343-1-kalavakunta.hari.prasad@gmail.com>

Hello,

On Wed, Apr 09, 2025 at 06:23:08PM -0700, kalavakunta.hari.prasad@gmail.com wrote:
> From: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
> 
> Correct Get Controller Packet Statistics (GCPS) 64-bit wide member
> variables, as per DSP0222 v1.0.0 and forward specs. The Driver currently
> collects these stats, but they are yet to be exposed to the user.
> Therefore, no user impact.
> 
> Statistics fixes:
> Total Bytes Received (byte range 28..35)
> Total Bytes Transmitted (byte range 36..43)
> Total Unicast Packets Received (byte range 44..51)
> Total Multicast Packets Received (byte range 52..59)
> Total Broadcast Packets Received (byte range 60..67)
> Total Unicast Packets Transmitted (byte range 68..75)
> Total Multicast Packets Transmitted (byte range 76..83)
> Total Broadcast Packets Transmitted (byte range 84..91)
> Valid Bytes Received (byte range 204..11)
> 
> v2:
> - __be64 for all 64 bit GCPS counters
> 
> Signed-off-by: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>

This version looks correct to me (other than the changelog being
before ---) so

Reviewed-by: Paul Fertser <fercerpav@gmail.com>

