Return-Path: <netdev+bounces-88248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 034BA8A6749
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 11:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC741F21E11
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 09:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AD585C68;
	Tue, 16 Apr 2024 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1X+rlHfH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051418593D
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713260248; cv=none; b=Lc26iI68dLbgsjAj1aa90X9Z6vvL27Jgt0bFDlDnv5n9nVnmqbSB8jcXY+J9808h6yWxvgpsfdBc6hrbMdz6rfvukeRcv+oKtgDYej/IZitCIXNR7XK9WutuKB7dy/6zI7F3HAsAVbSImWwNGAkwFp/ZS3ZDDYZrs56zz2diSD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713260248; c=relaxed/simple;
	bh=ffWk3OdR6v/Mse52x1zn4+xDjJA19hq7H0Mp+dTmZ6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmgLTHlN+jFsqGFFD9n6Sdfi4ny2E9TUqGXGpPnP7+1gFTdnZYVMruRershHPS3tOoNeupvm1+pAUeYf3VjgKNTdLauPuy+tUU85B4CkWkYzLMX4wGb0gyNoO2Pqrta+wd2/2MiyaAiyuqICpXFpFwgEBUulq/g7lDtJxfYTr6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=1X+rlHfH; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso4437260a12.0
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 02:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713260245; x=1713865045; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/3DPvUKeMNgOHBMbHiy5cwD4zIVoi8D7XJtZoI1Ak70=;
        b=1X+rlHfHD5+quOJdtFxi2935DZC4PTaEhKVW2nNz7B5OPkr/8reqrMDEb8+gVoeRTC
         6WffeqV+65bjrcur5sexLtzxl3ABK4VicLdFHU2GFf5Gly09FYiAyH3PLVON1nciUtdx
         YWcNvjMVqZy5h1DNZStcHHTIMYaMRtftIB/5L0HCPUrrO8DqilGTTU5KjSuszFu+wYS0
         kX7lH7MpOBTRevW2k9/xHTd2umbz4tFdjb7R6z+iAEXbQlHN9NOIXrgAxJTOrn4ICWpG
         vCp0Uvuu8oR8U+krHRo8WOiRRa/uRE6XU/S83D0jAu4tBtyJuN5D1zzo13lEX+xDYRUR
         z89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713260245; x=1713865045;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3DPvUKeMNgOHBMbHiy5cwD4zIVoi8D7XJtZoI1Ak70=;
        b=onPSOCuTZz5q5H3clR9ItKbqw++VVlpWUaDV8QV8K+/Qz2eOAZsA6YV+LY8Xirvi5B
         wAbn47OxkJHuV5PHJo46RfVO5GSBHeLUvdfKvbwKUL8GdUuMHeAIZV4gDWNHTrmB1U4E
         vGQxqBUSSxwN9aA4JimdbUEiRIYtdi6Jh7WPlsPQjy+R3ox7J5PbP6sJh/ZEOjpo9EFI
         L3tSwg8Qg251WUUWm1sbhanNDkLMH4yudK0pXyuHk7uFbdUYkAAD98wF8AVvlm4Wg3DW
         Pan9nKjl33418Trka27HnXzv/QHlbClkLHM81OWUIpEZqsJ0k4Y10Fmqbvr7SxgyQX3n
         ufcg==
X-Gm-Message-State: AOJu0Yx8tcS894UAqWbhf9kaCT2QqSuT3r71xp0BZGqDDppswBIfl21B
	l/NfZsh2HpB4pOZGuDaW7jJLmXCrY4Tpd+3z7OPlkYDdi6OUDv4DDT6BD1aKGeE=
X-Google-Smtp-Source: AGHT+IFvrj+8thE7TmHUgLSpaAVmqDEMlhBPdSlqMtVJZFoiX03aKmhBk17QQ+Nc1niwn/fjwRo85w==
X-Received: by 2002:a50:baa4:0:b0:568:b622:f225 with SMTP id x33-20020a50baa4000000b00568b622f225mr9062152ede.30.1713260245215;
        Tue, 16 Apr 2024 02:37:25 -0700 (PDT)
Received: from localhost (37-48-42-173.nat.epc.tmcz.cz. [37.48.42.173])
        by smtp.gmail.com with ESMTPSA id h6-20020aa7c946000000b005702fc1f92asm1835336edt.53.2024.04.16.02.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 02:37:24 -0700 (PDT)
Date: Tue, 16 Apr 2024 11:37:22 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, xuanzhuo@linux.alibaba.com, shuah@kernel.org,
	petrm@nvidia.com, liuhangbin@gmail.com, vladimir.oltean@nxp.com,
	bpoirier@nvidia.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v2 1/6] virtio: add debugfs infrastructure to
 allow to debug virtio features
Message-ID: <Zh5G0sh62hZtOM0J@nanopsycho>
References: <20240415162530.3594670-1-jiri@resnulli.us>
 <20240415162530.3594670-2-jiri@resnulli.us>
 <CACGkMEtpSPFSpikcrsZZBtXOgpAukjCwFRcF79xfzDG-s8_SyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtpSPFSpikcrsZZBtXOgpAukjCwFRcF79xfzDG-s8_SyQ@mail.gmail.com>

Tue, Apr 16, 2024 at 05:52:41AM CEST, jasowang@redhat.com wrote:
>On Tue, Apr 16, 2024 at 12:25 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> Currently there is no way for user to set what features the driver
>> should obey or not, it is hard wired in the code.
>>
>> In order to be able to debug the device behavior in case some feature is
>> disabled, introduce a debugfs infrastructure with couple of files
>> allowing user to see what features the device advertises and
>> to set filter for features used by driver.
>>
>> Example:
>> $cat /sys/bus/virtio/devices/virtio0/features
>> 1110010111111111111101010000110010000000100000000000000000000000
>> $ echo "5" >/sys/kernel/debug/virtio/virtio0/filter_feature_add
>> $ cat /sys/kernel/debug/virtio/virtio0/filter_features
>> 5
>> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/unbind
>> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/bind
>> $ cat /sys/bus/virtio/devices/virtio0/features
>> 1110000111111111111101010000110010000000100000000000000000000000
>>
>> Note that sysfs "features" know already exists, this patch does not
>> touch it.
>>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>
>Note that this can be done already with vp_vdpa feature provisioning:
>
>commit c1ca352d371f724f7fb40f016abdb563aa85fe55
>Author: Jason Wang <jasowang@redhat.com>
>Date:   Tue Sep 27 15:48:10 2022 +0800
>
>    vp_vdpa: support feature provisioning
>
>For example:
>
>vdpa dev add name dev1 mgmtdev pci/0000:02:00.0 device_features 0x300020000

Sure. My intension was to make the testing possible on any virtio
device. Narrowing the testing for vpda would be limitting.


>
>Thanks
>

