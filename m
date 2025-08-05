Return-Path: <netdev+bounces-211695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FBAB1B4A4
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 15:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035A418A4E33
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 13:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E97273D6C;
	Tue,  5 Aug 2025 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6clb+AZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE1023C50F;
	Tue,  5 Aug 2025 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399661; cv=none; b=LchinyrF1QrYc4+Yznj0aUcC8/JNEHBSGlc2biKLggKTQT9kfARkTtuG/WN9YZNnv3GUJhmP6JFVMbaTPRrLzb//Nw2gSGp1tywJoptkw2J4Gvhu2RAZsGwSxDADrOHHClvbb7zvnzoE8QdESU6QaOeqqF75zCYX6/O/FKMKv+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399661; c=relaxed/simple;
	bh=N0CmshDMifKYo7r5by0XPRRXJE8BKzZlpniCDFhyMzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hv2qN5ToLX6L/zjMultGd2plEVgxlU6qHVjuWpFTJdOocjAebWkWaPXE8pt7liCAKpt5X5M8MLVblMAyPK7GTB1UXtSXQhvRRlsZ0/CsLr2t3guffXbE0DZBfVZEyCMDm1cdzirOyGPwi/HA9xfxWS1ErfaAI8lVVG71vAceSCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6clb+AZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24049d16515so34667305ad.1;
        Tue, 05 Aug 2025 06:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754399659; x=1755004459; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N0CmshDMifKYo7r5by0XPRRXJE8BKzZlpniCDFhyMzQ=;
        b=O6clb+AZPveXb0O0NcuVWHXoYgRGuTmL3bFUrnr9DCPKyyr2okwMqTP6SV0iC63eJD
         9Pb/u70vtOQNJeq6S5C7cWrqDZgGhIIJVLf2GWhs47Z9tuCSYDX9xZ4K9joUmYtrvcyN
         lVmvjQXj6aMgsZ3qxL/huWGabjtK5Yiq09T3SMCdk6wv7Tv4uvOVqeeOV/N6LLoZE/BU
         PR9gSyaElDBG/aiOXPEIlvzdAibW2bsEfGtAGPlgLQE8ezyJjn3Ru+AJHzH4mg2eVmUC
         fCg7S5lHB1JWbVh34SUuMclCvgq3KwYO9xeE52O7xHIycgpDvAnnE+6tVq2lw2PaUKpt
         fjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754399659; x=1755004459;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0CmshDMifKYo7r5by0XPRRXJE8BKzZlpniCDFhyMzQ=;
        b=o9R5ZupsGYc+GD2HK5R2tcl52oZlcALxKNLEWDppdiyXYIqgEDzid6X7QIDP+YZfWn
         83n8/1OEeNdwpOCDIZUSiK8JZGs/z+PnZl1Z+3wIcdJUplgd/85tiv6YCkQxcQYobvjR
         4o/qBwflX1wyP/kBhBm78vEsxk+D9n2MDNvKRkQJ015amEE++dKblyaZ85L9VVXcph6f
         1puyf7KsBsNe+rkSW6l02NfEWfE7Un3YG6b8/iYOBrHdZDL1x0sufjJ2HvIpNaq7qbel
         uzjhbZQPCFMF7+SSY3zEUWTeu+mewCFCWZyjp7yHlpqtuyjXjCW6sw5KaRatkODQOoLt
         Fr6g==
X-Forwarded-Encrypted: i=1; AJvYcCVw8rRXcTvuyExYlbnKtyYvM3bRU/HzDHVctozLBvFvD8w0IdHUXqPF5vmtR7lBqedFnj1aysY942fDX0c=@vger.kernel.org, AJvYcCWjdwzo3zM5/pY/qksiZz6HWc3oXAqggHMXW6e8roKp3k9X6D9R7EnCGS97ySS88Ps2FkYVp3N9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ahWqSOgBwV7T15VS6rES7IctNJr8Rt4+nCl1gPB3sZBjIQtM
	cjX8O1IJv3fxl0WBpQSLTuVKr97/TFM3k8FXdv2JAutWWVxd7x1fZdcR
X-Gm-Gg: ASbGnct92Fi1qXy8i4efonzPO1e4h5WRuvfcnDgbSSgX8/zWIa8WVCp5cGfh+UZBXhQ
	zf4pPfx5HkR4FZYEHEM3b3EXGbZ4FuGLAIC2fgrekpZTa4IXpVuchU3dTsMc2/Jkv/EtKur7oFb
	Yba5UMcbJzNwa3m41y3YHCQnDMT5Pizh4pMAeGgH0gmDgK/sIazjFw25en4kTsgclAGHm7fqAr+
	tUMwOFEsvpMC8opW8pziF1Miowh+u/m/TWMfmEQtwZyPnYmdaH0MfR64mpvs+mk/l6ef1u4VG2w
	fQd8KzJjWcazhmrE2jXhfXnJqfhoUM0N/rmRrHF5JhB7Wz7eyfmq4DlAK7/0N8n+ZEuzMPhoHGP
	aTVi4vm2JcWroAslt5uJE7ygtIUcX0DSYWxZazg==
X-Google-Smtp-Source: AGHT+IGUPAwX9hcCGJlmaMWO5avt7SqSBzXlpqyr3LHJByHYHNsOaUzGXslC3MQtuITNBEZ2gjb+Dg==
X-Received: by 2002:a17:902:ea0f:b0:240:296b:cb8a with SMTP id d9443c01a7336-24246fece92mr166585695ad.30.1754399659214;
        Tue, 05 Aug 2025 06:14:19 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f1ebc1sm132757795ad.67.2025.08.05.06.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 06:14:18 -0700 (PDT)
Date: Tue, 5 Aug 2025 13:14:08 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Carlos Bilbao <bilbao@vt.edu>
Cc: carlos.bilbao@kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sforshee@kernel.org
Subject: Re: [PATCH] bonding: Switch periodic LACPDU state machine from
 counter to jiffies
Message-ID: <aJIDoJ4Fp9AWbKWI@fedora>
References: <20250715205733.50911-1-carlos.bilbao@kernel.org>
 <c9eac8f6-8e7f-4ed0-b34d-5dc50be8078f@vt.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9eac8f6-8e7f-4ed0-b34d-5dc50be8078f@vt.edu>

On Tue, Jul 15, 2025 at 03:59:39PM -0500, Carlos Bilbao wrote:
> FYI, I was able to test this locally but couldn’t find any kselftests to
> stress the bonding state machine. If anyone knows of additional ways to
> test it, I’d be happy to run them.

Hi Carlos,

I have wrote a tool[1] to do lacp simulation and state injection. Feel free to
try it and open feature requests.

[1] lacpd: https://github.com/liuhangbin/lacpd

Thanks
Hangbin

