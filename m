Return-Path: <netdev+bounces-128097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D50977FCD
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 14:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DDE01C21503
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 12:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78BD1D86D8;
	Fri, 13 Sep 2024 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWsn9FTk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAAD1C2319
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230390; cv=none; b=IsZo2efEfuvtmmvJxfBjJu7YxZxJDvjbqtYXYsg4jT+BH7al23DfDfAKgA7ZJadQTIgGfs/mjykMH/oPcGTnteh4PqJoi3PtGNg7Qlasq+o4pdQmgEYZBEDKKT7kd4dOEyPDJvN1yOuUqJYrhu5j2zK5eTFJB1LeR9QA1TfJkpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230390; c=relaxed/simple;
	bh=HY+8tXYG0xSJnh7R4C2Y8YGh3DQ6p9Y1GSBIm/ur/YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gx+SEQd/oB3hxD3bjHTMspJWaMkyOvP4iTr5ZkGbWl2DgxYJ+eCM7YHL5M4x1PxpIe1svX8xVJJDX3DFF675pEsnaPaG0Rg3x2i3W6mNKmrBHLo3HqSG0djFzTAjMF00zfY7W7fA5f1qQ9trNfHVgAoVDuxvsO9gS7u3rtqMWWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DWsn9FTk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726230387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HY+8tXYG0xSJnh7R4C2Y8YGh3DQ6p9Y1GSBIm/ur/YQ=;
	b=DWsn9FTk/HtgAyGi+Qv8OgcmiikbesHemZ498kHDMtD1li5PuIBwdQbNq25SSRL2BfjzRh
	OW+OqiiaYkXZA5PIop+waxi3tr5oPwTci5+2RYPEwVZVSQOBNtFzkVNAsm4Zjp0IwiVJl4
	VI8nsmv5fsr2hvyC9hE/fe3AW2WdkdU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-7MtcphbaMsuxptAoCxNnsQ-1; Fri, 13 Sep 2024 08:26:26 -0400
X-MC-Unique: 7MtcphbaMsuxptAoCxNnsQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cc4345561so13470405e9.1
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 05:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726230385; x=1726835185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY+8tXYG0xSJnh7R4C2Y8YGh3DQ6p9Y1GSBIm/ur/YQ=;
        b=rVW4ePwrHepj+dSw1bouxzMbV1u0byeLB0aRz/yHj3kOE5ajpThKZa27gZtQahQhbT
         htqDwviYWtBiBcg/kTKN4C5nZsNkiTcDdPXrft5yohEG4c0/fLq0yUyzyZSAkhv+av+j
         OgWMbfaGmnb2kaiQWWn4qeXjzJvf5pn0ueiVDljutCFG/0sUR9uW5piz12t+I1VxVxen
         Kzu2hB7NIYiPCj0r1S7KVYcCaRF6lXxp7QnRFRnPpLGLDycykqdDhez8nNLZa8LPhHZk
         FPeQEjiuGaRBYgLP0hgvvGhnyFhxuAh+dfezPeMT7RXeBI2po5TPDxTTFluJJWVbYLcf
         h0fg==
X-Gm-Message-State: AOJu0Yxp/fkvItLPSO5oLkY71ksSJeVJms3KaFXA2bCsO7tyN5vlS2Zy
	TjOkyubBqH8Yg1SpLkTlXkIlAAiBkLvybREwTVC1X/J/JOJzoCS4spE8lrpkI7b6XQbuBvJAj0Q
	a+oJZk38GhJAPhLvBDE+P8We8sZA49pNxcVEpArVwKXQYnSU5KPeB7A==
X-Received: by 2002:a05:600c:198b:b0:426:593c:9361 with SMTP id 5b1f17b1804b1-42cdb5684damr49690985e9.26.1726230385362;
        Fri, 13 Sep 2024 05:26:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFidkkjDUoRoTLb7g2pCkQZIB8sE676scGn0fZ6NJNoSbtOVMdBZvM/oAsDStfGEoKtQEA1Cw==
X-Received: by 2002:a05:600c:198b:b0:426:593c:9361 with SMTP id 5b1f17b1804b1-42cdb5684damr49690695e9.26.1726230384834;
        Fri, 13 Sep 2024 05:26:24 -0700 (PDT)
Received: from debian (2a01cb058d23d600f8cdc4d4209368b3.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:f8cd:c4d4:2093:68b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b17ae4asm23621475e9.39.2024.09.13.05.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 05:26:24 -0700 (PDT)
Date: Fri, 13 Sep 2024 14:26:22 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org
Subject: Re: [PATCH net-next 4/6] net: fib_rules: Enable DSCP selector usage
Message-ID: <ZuQvbtoq26cVoczM@debian>
References: <20240911093748.3662015-1-idosch@nvidia.com>
 <20240911093748.3662015-5-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911093748.3662015-5-idosch@nvidia.com>

On Wed, Sep 11, 2024 at 12:37:46PM +0300, Ido Schimmel wrote:
> Now that both IPv4 and IPv6 support the new DSCP selector, enable user
> space to configure FIB rules that make use of it by changing the policy
> of the new DSCP attribute so that it accepts values in the range of [0,
> 63].

Reviewed-by: Guillaume Nault <gnault@redhat.com>


