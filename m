Return-Path: <netdev+bounces-87612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0B78A3CCC
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 15:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BF351C20B46
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 13:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0430C3E49D;
	Sat, 13 Apr 2024 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="OTBN2ULD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FE521106
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713014639; cv=none; b=ESqWns8HT0j8b4gsDK6KO7vpz5BNLGgB6G2HKJLEWAtjnjK2+CQAZvXwCWSUZ9uNLL5MMeY5nXNaIOPA2neGPZ7lJDl15vOIc+6RkUzoGzdlJzzv659pS0WoZ9O1h3nPPqXkxW/5PPxJvpP6qJvZSqm28pkHFi+wlF9tPbcF8gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713014639; c=relaxed/simple;
	bh=SRCIyPNQ6adFujDBz3DDPId6nlqW8ilRvRvNjMce8P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRkQSznE8cIbYBNdsF0E1aHCbWb8vAKMSXVmWwekmBCH3J+r1ZX1HnjmXSBgM/8lGk+LgKb8CTBE7A/TOFUCUsRwsT21JNruM8FkfwvaR1ASE5Hl546mGhajNS1Xqy1aHoDRSBs9jdzZG6oaFiFecq4QQocpcgS80z08ikhYvOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=OTBN2ULD; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516cdb21b34so2247443e87.1
        for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 06:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713014636; x=1713619436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tNdapE51xDmYzRf4qXGuO2j+5WX8I40uaybU2UWwKxo=;
        b=OTBN2ULDqS0WlipOvj2lEqgHbiZlK8qKAk/RYjETw03c7ebCBhLpneY0bquXAn6vOD
         Mb1bbmLYrV8dM3mxcz+ggtzPTzJtkOPlRHL7XuCobzycTED2rK0ZCEPV7ZZSTIFRZKOa
         biD8snYpnPo5JuN0chV9W8Np3ii0H6VatEReD8wlBehovqouqaJ/26x2hEUc2RlC9C4a
         C0qgrGdw6MSe1V4psmoJvjyytnDIM4Z/0Qyw4l1hY6K1MhbvW3iUXUbABaZD0ilF1MTy
         3ds3I2Koyg16pns+U97uBSFiauF/i+UcbdawQfVrTaK2I+iqamoj3fvbCxkoZpJmRtS6
         OUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713014636; x=1713619436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNdapE51xDmYzRf4qXGuO2j+5WX8I40uaybU2UWwKxo=;
        b=SJ/ZkJGLUlqDjwIu+EmpKqq3qVrtcDIKeuEVdZq98E4IF2Dnfp/LVv1B4aMehGqRWf
         Hvzin2aqPXGJaE6psSGTG8ZfCDQQSi2QdwYfsigME33mbpSiLiUItwlljSYNe4ui5K+I
         EYS36oGQG2hTw+0Y9GjB5j/yW1SmfcwAu3ZTWFAFuCCQ1+C1L63xCOpVgb2x3pWO5n7E
         NKSjBsGo7MwvrU+gUjxDtLTAC3IEIyoNJfkYWaZTwz/Q4fQuO0kq/NhjyFODFpHNCNf6
         3Bx1JSuie/Ac/LMP+CaLX8Zga3qLHc0gI+f89TQaHnsIV2UoQ//OMng6FDp2QwVc/JBX
         HCnw==
X-Gm-Message-State: AOJu0YzJzMacP0+aFCFtwY2GLuPYPLXuDzg4DUN6B0SCa6501caPmuVH
	tic7HNpu0Ds3Js5tXI/Otf/y7bkZ9FCJUVmGE2swBpgHZ1rIt9et7FJt+F9eZK8=
X-Google-Smtp-Source: AGHT+IFELlF2VPV1SnAO8TXfTkNK2OpqLn5CbLd1/1gUGn1Mm7hVFcBg61m0MFKlCcx24mPPnIJjQQ==
X-Received: by 2002:a05:6512:1327:b0:513:d08b:3790 with SMTP id x39-20020a056512132700b00513d08b3790mr3822688lfu.49.1713014636011;
        Sat, 13 Apr 2024 06:23:56 -0700 (PDT)
Received: from localhost (37-48-0-252.nat.epc.tmcz.cz. [37.48.0.252])
        by smtp.gmail.com with ESMTPSA id cn22-20020a0564020cb600b0056e34297cbasm2643255edb.80.2024.04.13.06.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 06:23:55 -0700 (PDT)
Date: Sat, 13 Apr 2024 15:23:53 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, parav@nvidia.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, shuah@kernel.org,
	petrm@nvidia.com, liuhangbin@gmail.com, vladimir.oltean@nxp.com,
	bpoirier@nvidia.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next 0/6] selftests: virtio_net: introduce initial
 testing infrastructure
Message-ID: <ZhqHadH3G5kfGO8H@nanopsycho>
References: <20240412151314.3365034-1-jiri@resnulli.us>
 <20240412180428.35b83923@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412180428.35b83923@kernel.org>

Sat, Apr 13, 2024 at 03:04:28AM CEST, kuba@kernel.org wrote:
>On Fri, 12 Apr 2024 17:13:08 +0200 Jiri Pirko wrote:
>> This patchset aims at introducing very basic initial infrastructure
>> for virtio_net testing, namely it focuses on virtio feature testing.
>> 
>> The first patch adds support for debugfs for virtio devices, allowing
>> user to filter features to pretend to be driver that is not capable
>> of the filtered feature.
>
>Two trivial points: MAINTAINERS should probably be updated to bestow
>the responsibility over these to virtio folks; there should probably
>be a config file. Admittedly anyone testing in a VM should have VIRTIO
>and anyone not in a VM won't test this... but it's a good practice.

Sure, will add these 2.


>
>Did you investigate how hard it would be to make virtme-ng pop out
>two virtio interfaces?  It's a pretty hackable Python code base and
>Andrea is very responsive so would be nice to get that done. And then
>its trivial to run those in our CI.

That is a goal. Currently I do it with:
vng --qemu-opts="-nic tap,id=nd0,ifname=xtap0,model=virtio-net-pci,script=no,downscript=no,mac=52:54:00:12:34:57 -nic tap,id=nd1,ifname=xtap1,model=virtio-net-pci,script=no,downscript=no,mac=52:54:00:12:34:58"

and setting loop manually with tc-matchall-mirred

Implementing virtio loop instantiation in vng is on the todo list for
this.

