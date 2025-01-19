Return-Path: <netdev+bounces-159587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4C3A15FCF
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDB9188473C
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 01:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02647DF60;
	Sun, 19 Jan 2025 01:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RO4RJLpv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9142A1BA
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 01:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737250974; cv=none; b=oks1hdQw5NqxAIzEEZrf/nCm3qa5omyLm04uJQY8RvcgRlnzcEVuN+zm9O0fJ2dZV9mqimzGcf0t+aU3r/cVVL9GaEo8rXrMYoXeYOQ7xATa9BS9XoYJPvPNl7MWy+wB+brsz79T7kz9kH0ssN2TVR3Rjhkrie5HqivJVKDAREQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737250974; c=relaxed/simple;
	bh=cYISlzqJVCKHtM2vXR8lg93OFdL6y9d/zYS+v0kb9fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nT8+RTUQ3M0kdeaSYJd+5aaQUuF7/CoyLV6AJISs7lKCQ4iu4p0W1HIzu7QwDCqCd5TWrJgBZYX2IehrzHu9esrzSMcRZWWoByEb5hTk6Zd9rCPXqkiC18tJc358d+dj+ROcqsbyuS2ur0UYJexKi/L0N3NeWS4PyU6/ljDQ9KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RO4RJLpv; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3eb9101419cso2007485b6e.0
        for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 17:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737250972; x=1737855772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z6yaN7N5OPXQFwdruAxaNW2g9MPADjaGklbd/tSgIoM=;
        b=RO4RJLpv1C2IGyM8aUve4RZzihS1Tt2RNPrpAvB/DJ+AYKO86hrew3F+b0FnH+JLwZ
         ZF37O4+vE5UPVRzv6W2doUFX8Wq+fNDo5CNYAtY4Uhgvgq7V2mM0jboflzDEdbs+wN+P
         L+PvkEYvAXyf8DV3gXgcal0hyATwT+2OgH3I/tIpaeacX5G3ypTNNmsER02GQNsflL2/
         qvfiQVmCCpe+LKgOWlLRDnlUvmSExXxIr7sEIq/LvDwn3bhzsaoIbYku3ZOTkX28zZDa
         de5hiafN88vgqhUEZbMq8jY9OW8Z2qXzyqEJfdVc+A/l6//I5GbbwBle7v8Fjvw1sK4c
         a3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737250972; x=1737855772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6yaN7N5OPXQFwdruAxaNW2g9MPADjaGklbd/tSgIoM=;
        b=XTy1vxDwNrxhhusjIowArIJfIJcb4LM5xJe2UIoN8+q5qmSaYzsgB5j8EEnn3lVEae
         yYrbE9LzZAqNxqRqhjlDEL7X5E61l6dLFKHGJ32S2PQhr1NF9gL9QjNR+bHc93EZthoT
         YI6kSDImjQg8IB8iJ/Me4Q9KQfFZ1Iq+eTBvxrxmanSpV8tctataIVRvfdjNI6vYo5hA
         f50lgiasMDY5cNlIfbyMeGPuV+aEC1OktEEXjoXvJfV6voIRWcFzRAYP0BmbhfWXkUN3
         7FjYf3mM9osHVH5yIOljR2sW6t40Q2FKs/x3H9Waw9+LGwSyddhGrh+20IRGp4DKyQRF
         v1SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrp08z3hkoao+mOW4/K3GSVjV9N77LkxhOzVvSjOHBW3uOmXpkNT4jdzdxJMEMHcwe0Ksdtxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxOdNezoJecutA4kbRjibr/FWt8GtLkSRfsTAbpC6lJnAzTeHx
	aGgiEaOHJpGlYhYjMwMjAij+syRQqC8JDNsx858WQ/G9M2eSpzTW
X-Gm-Gg: ASbGnctYcUvqDShXZInRRfro5RWg5hammHxYfCPgZhjpmxmwa3uM2XM/B5IkqKzPLAA
	72GVpDVb/XXOlcs6l2wniSUGjduNhumGudx+CmSpdhFvesUmxWiUi+Ff+TdaCRz/Cn+4ZHbIXcf
	mr3LjsOiI0Kd7q4i/JnKs5uo4vVpYbpxG0CfWIGb8jrwLK4KlZN3jlB1erNJN1/LSeIFopggaTN
	gUfcdcQ6vR/sRkaQp5PEJRnpVlyZImRSuVYqJzV6AzpSLADKLpRbr0V6/sLz801Uezg2B1ImMwi
	aWWFVIRuBxakPA==
X-Google-Smtp-Source: AGHT+IFlOidxhcHXss1Y6lq8KP78ZUNL4FPgUTZ5Mvb88/70Bea0KqYlGQe/Tq6/qWgRlXqCt7w3VQ==
X-Received: by 2002:a05:6808:164b:b0:3f1:b153:3105 with SMTP id 5614622812f47-3f1b15331b5mr1224041b6e.26.1737250972401;
        Sat, 18 Jan 2025 17:42:52 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f19da6f3casm1706457b6e.19.2025.01.18.17.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 17:42:51 -0800 (PST)
Date: Sat, 18 Jan 2025 17:42:49 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jiawen Wu <jiawenwu@trustnetic.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux@armlinux.org.uk, horms@kernel.org,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v5 1/4] net: wangxun: Add support for PTP clock
Message-ID: <Z4xYmcWH09n3Yg1r@hoboy.vegasvil.org>
References: <20250117062051.2257073-1-jiawenwu@trustnetic.com>
 <20250117062051.2257073-2-jiawenwu@trustnetic.com>
 <9390f920-a89f-43d3-a75f-664fd05df655@linux.dev>
 <Z4p8ZuQaUe86Em9_@hoboy.vegasvil.org>
 <df736add-784b-40c8-9982-ed8821a8bcb6@linux.dev>
 <4fc53607-c0e4-42fc-a0df-0ad0d0c7a26c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fc53607-c0e4-42fc-a0df-0ad0d0c7a26c@intel.com>

On Fri, Jan 17, 2025 at 02:39:14PM -0800, Jacob Keller wrote:
> On 1/17/2025 8:03 AM, Vadim Fedorenko wrote:
> > Well, yes, this case is a special one. Then maybe it's better to adjust
> > Kconfig and Makefile to avoid it?
> 
> Seems simple enough to just have the driver disable the PTP support when
> the kernel doesn't support it, especially if its not a core piece of
> functionality for the device. In cases where the device would be
> functionally useless without PTP support, Kconfig can be used to ensure
> the device driver won't be built without PTP support.

On the one hand, The PTP class layer API is clearly defined, and I
expect device drivers to adhere to it.

On the other, working around a driver's incorrect API usage by
changing the makefile/kconfig is confusing and poor practice.

Thanks,
Richard

