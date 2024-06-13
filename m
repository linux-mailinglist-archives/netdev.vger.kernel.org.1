Return-Path: <netdev+bounces-103122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A399065D4
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD381F256C6
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 07:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF6E13CA9B;
	Thu, 13 Jun 2024 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6I1OPKh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DC113CA87
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265382; cv=none; b=APQ7xjYmOyhcFrB/tUFydpB+6JAt7p20sps6ytQTXMdESv0SHmrPvkfZ+V+5niY1TkqNKOmvPdTdwGZKODAuOrx42/koTJ3J9G7KfdDN7C7aGJLE8ommq3BqkIK3H5f0EtxeH1aJYc8aeoj2l6ccZmHC6DnjgyRaYN4KLBegmMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265382; c=relaxed/simple;
	bh=pygi0U5FKG2E0+sRSrBi9VqcR2RBO6JP9AsIcYGiJOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kA/oTBPn6KxICgxl+a2WSh2GAZmiVFcrrLoQtF+Xn917dZ1e5FyQoZ+II7OM2d2uoTIoAwV1TzygdURVRXcSsm4trtX8QCzNGisRxX8s+28d9HlykVLvGHCfI58isIjZZ60Juf8+z05vP8PmlS1fmvLztI0miOcQlr0JRKqT1xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6I1OPKh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718265380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QrnLUq/sqFBifkpIseHSnETVQOXtxlWZ7PAdKbOFEBA=;
	b=P6I1OPKhe6zbkWPMH2RnrRBCvYnjT1tCxwpSMV/VlyeS1N6zyyghnjEaFItwwBqeqWucet
	64WKWPOopflb0HYXQhNvBtFTriGOZE1JC8Dx38O9sOTWS4lanoPofYYCF5txXsQEc7nYLn
	9QiPjKZNjX3+tBxtgKFgXBXdm6jr408=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-jnit47EzNw21SC0zZLImgg-1; Thu, 13 Jun 2024 03:56:16 -0400
X-MC-Unique: jnit47EzNw21SC0zZLImgg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52c893408b5so491758e87.2
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 00:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718265375; x=1718870175;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrnLUq/sqFBifkpIseHSnETVQOXtxlWZ7PAdKbOFEBA=;
        b=ISRtJzn1b+GqGrE/FSdDasWxJ8708dn18imODVpgohqZDsPkH+EORjNwbkXUTK3C0b
         IExZb95qD42fiBFpA10mXQiBvHOHwNO3xrppNd04PT57c1e0PyJqwADtZ5/Za7FVIrnP
         6mdl+ln0VHbXyHQrWq5Gmorugk/mfKm9oWXG1fFlOiKNVX1CtSugFk5T8twzVnTRzcc7
         uenTQhuqttc+F35F7dNLTDLXt11Kk/lh+h6A897m/wxua1TMKLr6VC9ZVc1nd+1evp/F
         SIQ023IzDnveriJndNZ348ycQfK7ICo2X6slXMsOztRhcLjNNlv6jpZtAKmnW0i2PdK7
         TnGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK59whJvE5ziSgz9sBUsuMMXGlLGqGl5p4SJCSPN36LtE/FXniuWqVa4Q3hdBcVMbKc4QHOZxFMEBnpwcOXO9HCqd7kUAI
X-Gm-Message-State: AOJu0Yy1nQzZqE3eHhDFofj2b9dbIqbr3BOMUzQ3IWeQ0Yu6PRWudhQP
	4ICg9BUxdIVp8TuXp/wwy/utr8VsCpRBZOJ7XsDWzxJAW7TpqpYHRpug1CdHoXd8d1E27t94PB3
	NeNwdZIEduPPFILajokz52u5AFNgI8bj5H7fSILRkG1Y6iuF8gEd1DQ==
X-Received: by 2002:a05:6512:3c95:b0:52c:8a88:54c with SMTP id 2adb3069b0e04-52c9a3b8dbcmr2980785e87.7.1718265375202;
        Thu, 13 Jun 2024 00:56:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi3y/B5Name8BDSsVNHDRaOE4J/72dwOLD9f27/Zxqg0A9INzT4XnhT0z3wmes0K13WaprLA==
X-Received: by 2002:a05:6512:3c95:b0:52c:8a88:54c with SMTP id 2adb3069b0e04-52c9a3b8dbcmr2980766e87.7.1718265374627;
        Thu, 13 Jun 2024 00:56:14 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:94c5:b48b:41a4:81c0:f1c8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f5f33be5sm13858475e9.2.2024.06.13.00.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 00:56:14 -0700 (PDT)
Date: Thu, 13 Jun 2024 03:56:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Xing <kerneljasonxing@gmail.com>, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	dsahern@kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, leitao@debian.org, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3] net: dqs: introduce IFF_NO_BQL private flag
 for non-BQL drivers
Message-ID: <20240613035148-mutt-send-email-mst@kernel.org>
References: <20240613023549.15213-1-kerneljasonxing@gmail.com>
 <ZmqFzpQOaQfp7Wjr@nanopsycho.orion>
 <CAL+tcoAir0u0HTYQCMgVNTkb8RpAMzD1eH-EevL576kt5u7DPw@mail.gmail.com>
 <Zmqdb-sBBitXIrFo@nanopsycho.orion>
 <CAL+tcoDCjm86wCHiVXDXMw1fs6ga9hp3x91u+Dy0CGBB=eEp2w@mail.gmail.com>
 <Zmqk5ODEKYcQerWS@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zmqk5ODEKYcQerWS@nanopsycho.orion>

On Thu, Jun 13, 2024 at 09:51:00AM +0200, Jiri Pirko wrote:
> Thu, Jun 13, 2024 at 09:24:27AM CEST, kerneljasonxing@gmail.com wrote:
> >On Thu, Jun 13, 2024 at 3:19 PM Jiri Pirko <jiri@resnulli.us> wrote:
> >>
> >> Thu, Jun 13, 2024 at 08:08:36AM CEST, kerneljasonxing@gmail.com wrote:
> >> >On Thu, Jun 13, 2024 at 1:38 PM Jiri Pirko <jiri@resnulli.us> wrote:
> >> >>
> >> >> Thu, Jun 13, 2024 at 04:35:49AM CEST, kerneljasonxing@gmail.com wrote:
> >> >> >From: Jason Xing <kernelxing@tencent.com>
> >> >> >
> >> >> >Since commit 74293ea1c4db6 ("net: sysfs: Do not create sysfs for non
> >> >> >BQL device") limits the non-BQL driver not creating byte_queue_limits
> >> >> >directory, I found there is one exception, namely, virtio-net driver,
> >> >> >which should also be limited in netdev_uses_bql(). Let me give it a
> >> >> >try first.
> >> >> >
> >> >> >I decided to introduce a NO_BQL bit because:
> >> >> >1) it can help us limit virtio-net driver for now.
> >> >> >2) if we found another non-BQL driver, we can take it into account.
> >> >> >3) we can replace all the driver meeting those two statements in
> >> >> >netdev_uses_bql() in future.
> >> >> >
> >> >> >For now, I would like to make the first step to use this new bit for dqs
> >> >> >use instead of replacing/applying all the non-BQL drivers in one go.
> >> >> >
> >> >> >As Jakub said, "netdev_uses_bql() is best effort", I think, we can add
> >> >> >new non-BQL drivers as soon as we find one.
> >> >> >
> >> >> >After this patch, there is no byte_queue_limits directory in virtio-net
> >> >> >driver.
> >> >>
> >> >> Please note following patch is currently trying to push bql support for
> >> >> virtio_net:
> >> >> https://lore.kernel.org/netdev/20240612170851.1004604-1-jiri@resnulli.us/
> >> >
> >> >I saw this one this morning and I'm reviewing/testing it.
> >> >
> >> >>
> >> >> When that is merged, this patch is not needed. Could we wait?
> >> >
> >> >Please note this patch is not only written for virtio_net driver.
> >> >Virtio_net driver is one of possible cases.
> >>
> >> Yeah, but without virtio_net, there will be no users. What's the point
> >> of having that in code? I mean, in general, no-user kernel code gets
> >> removed.
> >
> >Are you sure netdev_uses_bql() can limit all the non-bql drivers with
> >those two checks? I haven't investigated this part.
> 
> Nope. What I say is, if there are other users, let's find them and let
> them use what you are introducing here. Otherwise don't add unused code.


Additionally, it looks like virtio is going to become a
"sometimes BQL sometimes no-BQL" driver, so what's the plan -
to set/clear the flag accordingly then? What kind of locking
will be needed?

> >
> >>
> >>
> >> >
> >> >After your patch gets merged (I think it will take some time), you
> >> >could simply remove that one line in virtio_net.c.
> >> >
> >> >Thanks.


