Return-Path: <netdev+bounces-96385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 238368C5887
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 17:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3972B21F65
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 15:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD8617EB8E;
	Tue, 14 May 2024 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gROR+nbQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B1D144D0D
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715699560; cv=none; b=OhKmN8tH5mcCcJ/hX8zr7yr9YNhmlVXi0CErgGEzkWMQpWL9ZcJfQjdqlyfwRu0MHXTZyfe17mT9yAOwH9zYUkR8mfApvnyWV3Fb18Kl6C/+78F0tWcuFbeGCU7+sZXIILV2juiSPpHQJqCqMf5vkPvwpKgXxavjrB4Ycpp++kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715699560; c=relaxed/simple;
	bh=NL1KHWtYv3QKUfmEMXyKfHmHt/nVGsCsOJA2nvTmHeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aaf+8Xhmd+srq0lKU3LbfDKXBX+HI1UaUkZBM0jd5mP+WU+pNe6uIvmk+rq8Xl1rvRTIjuzP9Gp/GEj8A14S9EHwDm7cBkO/pX0bNkQC3McyW+e4JUHm99zLFe7lUk3HEdUrUUBr8NtvTD4lXo5e0XQ5rnrXjEHmra08bKr7n6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gROR+nbQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715699554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4cnIUuYkHWIx+FjkGcvXg8Ni+ZK2m6H2U3SaL0bU3Wk=;
	b=gROR+nbQ1CoodzCFLWOp44G1/uZjjtn71/Wcpijw/DFLqgv8f4NCCE3wgllPsQaUoCWNsT
	rUQLGHwgHlD5iwYGxJSaC8dZi3KqiP1oqj0biwClX/Nx+c84lKVIqVOCDE4rhw5TjlVjhZ
	4Y0XV2KdB1LZs3ZFuL6IS9cPTSj2lKY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-KuZuzZIeMvilm2AF9x24sA-1; Tue, 14 May 2024 11:11:48 -0400
X-MC-Unique: KuZuzZIeMvilm2AF9x24sA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-792ca95e323so659375585a.1
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 08:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715699498; x=1716304298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cnIUuYkHWIx+FjkGcvXg8Ni+ZK2m6H2U3SaL0bU3Wk=;
        b=l40rjb85ozgHIUed+XK17tWjQICXGMLK0JF1vjbqxjCNvsXDnCdbqm9P8KtM89GG4Q
         3iCUZrGNfWTCYXLiIH09ffshrgcz0K//6rJdtyv1Tus17OLXY12GJlK4zQ1riOJGwmU4
         XddXomuAEvTVepGX8LZstMA4T6p0LGf4XDdF7H3w/aSVATE4ZPuszZc3IZa0Q+hIR8lG
         msV/3KQ6o6QD44vBrTTuurjrRN33FWSloSeRCNxf4FuODw8xb7wjARNz+sq73kY7N5uo
         tIYFSRfctzSZJO7dGjRhgC2kquaHEwYmq34Ium0Z8cbRmpbPWgS5XtxhuyWVjnKtKf6s
         BtrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4x/GyZbtTqrAEpA1ihB2MDEZTp4mUlvcseetb/NvrJYdvInh2dexfUiv80QrfZi2y/gSVQhutuFBtq0MgRniHjLfS81ji
X-Gm-Message-State: AOJu0YyGFWeiIIsDlL14s4IhxZDrov8R7c/gzi5MrP7aIlrlavulJNuf
	96UCuUMhV26TmLbHmaAimsTBPn303y3zF0G7bPUdLPOdIZQE2uEVEtWhZ9CZq9HPAZhY0RQqa5b
	7w+eII7LUQum20fkbjfr2kK0k/TzGbSNJCreurmto/KXu8zli0mUwMA==
X-Received: by 2002:a05:620a:1248:b0:792:ba5c:85ea with SMTP id af79cd13be357-792c75a0384mr1329257685a.18.1715699498422;
        Tue, 14 May 2024 08:11:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4S4VGlqFkjBvHME2OCbJc+xM35zlrwB2nmBbAdAlvnOFUj9Ev1YE2Zow33l3IJrgZpEtiKg==
X-Received: by 2002:a05:620a:1248:b0:792:ba5c:85ea with SMTP id af79cd13be357-792c75a0384mr1329254585a.18.1715699497938;
        Tue, 14 May 2024 08:11:37 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792e4c1076dsm165732485a.130.2024.05.14.08.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 08:11:37 -0700 (PDT)
Date: Tue, 14 May 2024 10:11:35 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sagar Cheluvegowda <quic_scheluve@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Vinod Koul <vkoul@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Bhupesh Sharma <bhupesh.sharma@linaro.org>, kernel@quicinc.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Mark Ethernet devices on sa8775p as DMA-coherent
Message-ID: <3werahgyztwoznysqijjk5nz25fexx7r2yas6osw4qqbb4k27c@euv6wu47seuv>
References: <20240507-mark_ethernet_devices_dma_coherent-v3-0-dbe70d0fa971@quicinc.com>
 <5z22b7vrugyxqj7h25qevyd5aj5tsofqqyxqn7mfy4dl4wk7zw@fipvp44y4kbb>
 <20240514074142.007261f2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514074142.007261f2@kernel.org>

On Tue, May 14, 2024 at 07:41:42AM GMT, Jakub Kicinski wrote:
> On Tue, 14 May 2024 09:21:08 -0500 Andrew Halaney wrote:
> > I don't know how to figure out who takes this patch in the end based on
> > the output above :)
> 
> bindings/net is usually going via netdev, but my reading of Krzysztof's
> comment was that there will be a v4...
> 

Ahh, I read that differently. I'll ask Sagar to respin with that comment
taken into consideration!

But ignoring that, let me know if there's a good way to know who really
picks things up outside of experience contributing. It's Sagar's first
submission upstream, etc, so I've been fielding some first time
contribution questions and realized I didn't have a good answer to that
other than troll through lkml or the git log and see who picked those up
in the past!

Thanks,
Andrew


