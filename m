Return-Path: <netdev+bounces-96789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DBB8C7CD8
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 21:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4346B22BEC
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 19:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF14157A56;
	Thu, 16 May 2024 19:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Va3qPJQz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505A8157A63
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886293; cv=none; b=TFBp2Dv0yn5inBDfC0fC6ykvvXJ33cPG9bjb9Ev3C+SLgiqYE/OFEIZcaf2vTO6dlHF3G0uw6kjYJyMpMYGHYbF1yX+4swaja2EqQGDDD6alZe9C+LFepzRNLIrWbweoUUtb4CmietY68r9uLSOKiqxxxf3j2gvKC491LdFIBqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886293; c=relaxed/simple;
	bh=ELtnt8hMvirmxWy694FQQpOITSRYaHdbDyo7UvSyHWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utSkxdXLFrsri5vES+J+vlNwMUY0AVkl19Oy2HwEGsheKJ6GuhoKU6og8QFYs58PXalYK+dbZ+/n4H/82u63pXOl8o4RloVC6Q6pmIQQ7POAriM38PMK21h9hnUOhP6Lw+uMIR25BW71sK8qtH5k+RtHpWG0Lt4eRRmYcQGC7iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Va3qPJQz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715886291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jz7L9c2ybtagPzZAI/HiPe7jF+CkWPwh/QudsghM+Bo=;
	b=Va3qPJQzWryAgj2XpP9RwW9DRCxBD7+9Sl5bry8tWsl1EBLPtXPxzkGBGl5NSHIJ6/SBMp
	WFHeSupM+GlDS9njmWVkaIzGFCRZWy39Ry0uHf4Q0vvR8pIBl+6llj8CAzAQnCuyTDFgVQ
	/eTpswBmbHTiX5UWOeJwC3zvLNngWYk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-nNfYkKvuPVu5N8CXVrptDQ-1; Thu, 16 May 2024 15:04:50 -0400
X-MC-Unique: nNfYkKvuPVu5N8CXVrptDQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52389b09bb6so2638548e87.1
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 12:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715886288; x=1716491088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jz7L9c2ybtagPzZAI/HiPe7jF+CkWPwh/QudsghM+Bo=;
        b=dJpYKYmhKMReYckkTXOYXnbcIOXlyiS4OM18qq03OXEe4eM5uKk4eGQtKBUNotjU2V
         MO5C1y61T7sUIS0NA8dkkI6Nq1dq2xmKkbJFi7ygy7wqo/A4rJfMgv0F/QdkyRbwR9Le
         MzkiroSoAskvxRycLc4h+O5ofl/HFhq6fKckhkv3yO59hUkTuVlgs2s9bqa+r+JGB2S3
         ZcOxmH25ue0FfjQqsAB1a5Bq+0QN6/2UESR9WFlRTkMSotumcseTw0a+qoLfoRvJeRjv
         B8kPloLM9N/EiG1W0OEUdas/b+cMUhK0tt3acuVhiERzb9lZ9b34ZHyr5pJl3grndFIa
         uV3g==
X-Forwarded-Encrypted: i=1; AJvYcCXeeF6mvDVBX+YCNC5z5uj9g1UMVNVUJFVp4kksbEUptXkbwCUGZwLu8WRGaMjQ3rjO8OdX4jMmzYQPhwMEUEkOoK9mofZu
X-Gm-Message-State: AOJu0YzjiEmMAfQUMC8aAdN5r8G/TrcVEsG7N11mvqCFlMppd8+gCfXL
	f1f+Lj8RVTAxi7JLUsaT85few7LONGecEtPknvVfcGJZWJSt2ZMSLhcuiit/9wkKHuzRJJX8ORH
	Gg+KdvOSRWk1sjzHMuWkkfew19q7MJNbf97EaG+BdkUEUpZjrcEI1vA==
X-Received: by 2002:a05:6512:b8e:b0:523:d1ba:6431 with SMTP id 2adb3069b0e04-523d1ba660fmr1095661e87.66.1715886288430;
        Thu, 16 May 2024 12:04:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG666LZBWPCUr/LqwIyFBHcLAp4WehVEl1G2GF4vgzI3Hc5z6LWccyOB1hMi+IOAyNcwR1fA==
X-Received: by 2002:a05:6512:b8e:b0:523:d1ba:6431 with SMTP id 2adb3069b0e04-523d1ba660fmr1095636e87.66.1715886287775;
        Thu, 16 May 2024 12:04:47 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17c:ab88:14c2:fc9:18f8:19ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351d2df8449sm3266124f8f.12.2024.05.16.12.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 12:04:47 -0700 (PDT)
Date: Thu, 16 May 2024 15:04:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240516150101-mutt-send-email-mst@kernel.org>
References: <Zj4A9XY7z-TzEpdz@nanopsycho.orion>
 <20240510072431-mutt-send-email-mst@kernel.org>
 <ZkRlcBU0Nb3O-Kg1@nanopsycho.orion>
 <20240515041909-mutt-send-email-mst@kernel.org>
 <ZkSKo1npMxCVuLfT@nanopsycho.orion>
 <ZkSwbaA74z1QwwJz@nanopsycho.orion>
 <CACGkMEsLfLLwjfHu5MT8Ug0_tS_LASvw-raiXiYx_WHJzMcWbg@mail.gmail.com>
 <ZkXmAjlm-A50m4dx@nanopsycho.orion>
 <20240516083100-mutt-send-email-mst@kernel.org>
 <ZkYlYLFthXVmHOaQ@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkYlYLFthXVmHOaQ@nanopsycho.orion>

On Thu, May 16, 2024 at 05:25:20PM +0200, Jiri Pirko wrote:
> 
> >I'd expect a regression if any to be in a streaming benchmark.
> 
> Can you elaborate?

BQL does two things that can hurt throughput:
- limits amount of data in the queue - can limit bandwidth
  if we now get queue underruns
- adds CPU overhead - can limit bandwidth if CPU bound

So checking result of a streaming benchmark seems important.


-- 
MST


