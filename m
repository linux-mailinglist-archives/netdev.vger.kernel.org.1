Return-Path: <netdev+bounces-102354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F55C902A53
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 22:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37CFE284A75
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 20:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FD317545;
	Mon, 10 Jun 2024 20:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WD2OpXpO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57111210E7
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 20:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718053036; cv=none; b=C8JnZ+nBhH5BR8xblw2NAu/B42RChIrVeXerPCB8EFEUeEKiX0U7pUSDJqYQkOoSGjIUnSNMZYnuhNrTqau5K0spnh2qVwiBxWITV3tn/kc/J2yX0x+lB1sfuMFfYfG1Ca+uwe0C/YYbihEzy3dqWvHdKqdGjAiTIcT5j08+8NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718053036; c=relaxed/simple;
	bh=sTxKvKo+LJRQ99l3irbYLmi5vxgPZOqXfgG+n1REQdM=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pvnKdgiF7CGQgtk0FhgXvrAYDQvsELZk+x39dSvqfV+ZaxkDY9yHyKdwshntjtQ3bTZOJp81fRAHMVA+eYBarBIrEwoUCvaW11NRa0VS3gE5wpjX+nYMVRiOHlsRaW69JdAkpWnZPnUnDVrn8nhbN8V+9v1YolrZ38cJzCZRSm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WD2OpXpO; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6e3341c8767so520110a12.0
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 13:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718053034; x=1718657834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfGcpUFc8MslcyHQPsPoipYUAt8oVUXhMj6f0ISB2ls=;
        b=WD2OpXpOUwno6mKUftqLCf1wnlZrXqr8XvG0os7h69hcubJAykTFJzvOrYXdU8Udo5
         3Oq2O+qK0Cg/g3xagy/muEblPRkcPYXt3aiZ+LNI0LzZoSWTnM/yiLchcPFzs6hmd6rg
         17DKuAyG7P/iwo5ZChOG/hmSdZLJLDyG8lYiuctpYeueZX/Rx7UbkDlZt32YmJnApuk2
         fP7xSbP0z2XMyljD+jsZ5Ce3VsaQ2WuRBJechZPK266/cGnLi8P4tPy1K3ZUOholfr7R
         114XZphv6ipDdx+/1pEG5QqdJ/KNEJZbJXRHPUVUG3p20KnhoQEBQaOuylU4Aid+jjxs
         0pOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718053034; x=1718657834;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NfGcpUFc8MslcyHQPsPoipYUAt8oVUXhMj6f0ISB2ls=;
        b=RnxapkWyi/CqnZay1+jVqDEDSyYByf0jDVyYw+exlfdTAr5obIx9VGlMCO1Lbh+3oG
         Tp5ezbBBr/gJLFq8hdKJuP9BMWDdSPAE5zyrdGGaGWmgXh3e+sS5gEvxQ53qPnw6X6Av
         L7XIgv3uBZJe6EuCi2crbVCjKTl3ZNsAqR9DAvlEm/fFGeLkmWXighHmgM9fAIxJ9J/x
         uuLeTc+qxabzgFphPS1/eQv8r8Pf4PkLx73r+656Qtxo585u6+RwwfxFq6G9GNLXbY8o
         JHt0kUGxj5p1NKs79k4O2oY5uDBoIOR/Qd5E4ltLDC+VB2o8sdzmBgAi+H36iYms7rDB
         xsQw==
X-Forwarded-Encrypted: i=1; AJvYcCWcyfaGyoER/gARBhf1ZU/nnW1MxlKitTv7dLjL3YyvDE+8kRnfDN0K2+XoeprKoC/eK1D5XVFy7R0wSUtZnS0o/4V4HXCs
X-Gm-Message-State: AOJu0YyITwNGr9qthbRPl81yLkTOwVm0zYQKPJ1OqtbdzpIX+FQBhmEu
	G9dEdi7xWrs3gZ9X09eykibO1O2j1tQtTD8s9je+JCXAbvwleR/z
X-Google-Smtp-Source: AGHT+IElYujIps3c5gqeD5T7shnO2pnNVslbHjoTyauwPLCSiyvhRsiJgisCmZ3QtEXX9ksRRb9Qaw==
X-Received: by 2002:a05:6a20:9483:b0:1b0:1be7:3708 with SMTP id adf61e73a8af0-1b2f969ed1amr9425353637.1.1718053034488;
        Mon, 10 Jun 2024 13:57:14 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-704140681e5sm5665950b3a.125.2024.06.10.13.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 13:57:14 -0700 (PDT)
Date: Tue, 11 Jun 2024 05:57:08 +0900 (JST)
Message-Id: <20240611.055708.569544695430930380.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org,
 jiri@resnulli.us, pabeni@redhat.com, hfdevel@gmx.net, naveenm@marvell.com,
 jdamato@fastly.com
Subject: Re: [PATCH net-next v9 6/6] net: tn40xx: add phylink support
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <f8befc17-bc29-41f0-95f7-7af3f854d77e@lunn.ch>
References: <ZmWFNATfPWEPSLyf@shell.armlinux.org.uk>
	<20240610.151023.1062977558544031951.fujita.tomonori@gmail.com>
	<f8befc17-bc29-41f0-95f7-7af3f854d77e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 10 Jun 2024 17:42:30 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> > And my email client, setup with rules to catch common programming
>> > mistakes, highlights the above line. I have no idea why people do
>> > this... why people think "lets return -1 on error". It seems to be
>> > a very common pattern... but it's utterly wrong. -1 is -EPERM, aka
>> > "Operation not permitted". This is not what you mean here. Please
>> > return a more suitable negative errno symbol... and please refrain
>> > from using "return -1" in kernel code.
>> 
>> Indeed, my bad. How about -ENODEV? Or -ENOXIO?
> 
> ENODEV.

Thanks for the confirmation.

There are drivers that return -ENOXIO in the same situation so I was
not sure which should be used.

