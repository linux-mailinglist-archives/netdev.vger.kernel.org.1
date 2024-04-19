Return-Path: <netdev+bounces-89632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A42D8AAFBC
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 15:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E7E1C214B5
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 13:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133CC12AAFD;
	Fri, 19 Apr 2024 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="A3CPRy7G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24E112837C
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 13:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534684; cv=none; b=d+Kq9v2Iaea55c7RHMnRHDscJgSYNQ2/FWaUDjRM2K3bojk+h7wnGIhFl/kpP3twQufcfsX5haSfvIXnqbSOwzu4npvnjg5VvBKGnNFE+XSX54uO9SijgE51y0h8SE09yM5tATNvNap6wtmO7c/z6kecGncT2h3U4nVaxvgaQHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534684; c=relaxed/simple;
	bh=mi6XnFalf9EtQ/ENxG+jKIfTecVDeLfY3D2+zCxoRBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI4qhrgb7mW23qI6aodFw/fqVsaadIdOeiakk/41+6LcOLkEA3V1tfzVT6XPUOgzbNUStUu2TuiAb82+U2V1smdw6A/5yjkDaWP7bz866vkiQ3xN/H628qtCHwkOrxXAnv0SoVCyhBac9Poi9kTkazq21BA2Hofn+ylz3BnpFNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=A3CPRy7G; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4196c62bb41so3943755e9.0
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 06:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713534680; x=1714139480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bdhA12ApYJzVjqZj6OB/MpvC9ZtmrqHdwY8N+5n/lLM=;
        b=A3CPRy7GvWHbn+mkq686nnQ3EuzFUhPvesNf7KXzJ98sahrZ2fqoMe8s6B742OdbDX
         lO3cswSfYBuZozdI16fhFMm9yxDsxXKYjGESVqyswCmMWW7Cq6f582L4/I5U5Gmscuf8
         LYKNUY0MZ6Qq/wV9YO9MkANXxy9s6Ry64CGer0c4Yfgni6AK+kJBQT16ooxhrF8IdneC
         XjL+1hC+TGPQjFAyuF5bKqxaoA3yi32fLv3N37YZhrwFgZ9UQ4MmWD1YBhAVbS69WF5K
         gU/wPAc/7k/fy5pWl1MLpyyJ91SAjsbf+uw7YkWkYfXoD14sdGwtDNDBYA3LcBNWyFEj
         9Z6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713534680; x=1714139480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdhA12ApYJzVjqZj6OB/MpvC9ZtmrqHdwY8N+5n/lLM=;
        b=siBMe13+PwXOR07m6xe/Bl8FGbPGfv4u+GvtX6WeE9UDh/HoVCko0Mq+zvDc1z8Hub
         08I24Onts48nPVP0mV9Wg1U/k2Nv7jrzdKVseSO45MRIOO74LdmPXFEE6y8onUsQdZMM
         Ff3YfPl6MQW4P9gEBiYqazIw0fnUo0IeMiwL5cKYZlvU751WrkExoxy4GY19Z2qENYI6
         ERiG0Xj1+pp9OF4SAjxHBUFGVk8iPNVnqkbhLZxj7E9uc3Eht+xcZbXMUt5K6Oo1Z8sJ
         /BpqxswDJncaWcyvfKismwW1I1YqlGrA8qGevpyN9KaAavTmbJ7c4qH7bXe9PokydGV7
         Z1wA==
X-Gm-Message-State: AOJu0Yx9/46gtk7miqXJ08ZzmYlzognp5cvq8DRpNulH7Og/nzizHa+W
	GpIUS7iMamC5kiJmxu1sewNtEUovtV87dZPKfUETU42wDkp1UxMKvm4HjPXvIZs=
X-Google-Smtp-Source: AGHT+IGXzjcSLJNod0+4HL4Ih6pp20uZOLo+tZhLBwZQD5QFrAyhVsfR1DSp8c+sjOb8Yj00NhB9bA==
X-Received: by 2002:a05:600c:3b06:b0:418:df5a:3fba with SMTP id m6-20020a05600c3b0600b00418df5a3fbamr1474289wms.32.1713534679953;
        Fri, 19 Apr 2024 06:51:19 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a12-20020a056000050c00b00349ac818326sm4463206wrf.43.2024.04.19.06.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 06:51:19 -0700 (PDT)
Date: Fri, 19 Apr 2024 15:51:16 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v4 2/6] selftests: forwarding: move initial root
 check to the beginning
Message-ID: <ZiJ21Pz0Pa1bo0KJ@nanopsycho>
References: <20240418160830.3751846-1-jiri@resnulli.us>
 <20240418160830.3751846-3-jiri@resnulli.us>
 <ZiFq9EmbGZ3psdho@f4>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiFq9EmbGZ3psdho@f4>

Thu, Apr 18, 2024 at 08:48:20PM CEST, benjamin.poirier@gmail.com wrote:
>On 2024-04-18 18:08 +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> This check can be done at the very beginning of the script.
>> As the follow up patch needs to add early code that needs to be executed
>> after the check, move it.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v3->v4:
>> - removed NUM_NETIFS mode, rephrased the patch subject and description
>>   accordingly
>> ---
>>  tools/testing/selftests/net/forwarding/lib.sh | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> index 7913c6ee418d..b63a5866ce97 100644
>> --- a/tools/testing/selftests/net/forwarding/lib.sh
>> +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> @@ -84,6 +84,11 @@ declare -A NETIFS=(
>>  # e.g. a low-power board.
>>  : "${KSFT_MACHINE_SLOW:=no}"
>>  
>> +if [[ "$(id -u)" -ne 0 ]]; then
>> +	echo "SKIP: need root privileges"
>> +	exit $ksft_skip
>> +fi
>> +
>
>There's a small problem here. ksft_skip is defined in net/lib.sh which
>hasn't yet been imported at this point.
>
>Also, on my system at least, the code in the next patch can run
>successfully as an unprivileged user. So what is this patch needed for
>exactly?

Okay, you are right. Will remove this patch.

