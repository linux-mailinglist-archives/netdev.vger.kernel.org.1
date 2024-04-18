Return-Path: <netdev+bounces-89001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DC48A92E6
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE763B21DBD
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 06:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522A66EB5D;
	Thu, 18 Apr 2024 06:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xWfhuAgR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5D96D1C7
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 06:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420981; cv=none; b=XP9x8UFb6AYhTuSw+5xeTwP81Ij0mTTBX5cUhjqY2Qm1vNwXnlsbkm1mp8xRml86Ri70THCuUlp7uVPFV6X9xOKRN1NQflMeqFLKrZPMCdzIP5BNJ33CPImjULuR9SFPRkVWyIlWR8sUKKypzUu1qf6BbyuRS+1lWWzhdFd95jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420981; c=relaxed/simple;
	bh=HH0x58aeITczEaoOTmgbXQZRHs2VvH12CDc1gcImzfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkZdukv2LrtWmx/KZnByHxKjtiMmJgrKfyhN8WNz5j3c50CWWyEjXU4haotwh42JWaTqWha1Bo90gpOoc2EGZ6QWQD1wHIDer8VY59A2P7KFirwFSpfEADyx4G8ExeASXURXt01GrL9ocXkgOCF+l3Fd/ohC7NwhCB6/kJueLws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xWfhuAgR; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-571be483ccaso252635a12.2
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 23:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713420977; x=1714025777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zM+AwiIA7FKrgS/Ytacnt1rsdmjxxW5sRnLCAiG5Ajk=;
        b=xWfhuAgRPktpoK4oXvzyIyFYwxSPWEvp87aPRT1JQtT0rU/fbiDeK6lOc5VVZXDuQe
         tnreZ82NPeoBaaZ92FaLOrEbnd0Pq8DuaaqUsAXjiXtEz+82ED6030WgMzL+cCp4n8OR
         HPsQIVDCjblsMVs6O8y0GpuZiNhcwtRC0/NlQjWYZ5n3l6OThmmLBUVz9f8yX45TWxPW
         zt8WAvXcaYMGb2F1rj7WOS09ZzUakC+XV14VsBKI/aLfJCV2pl4ucJBrz4y9Kgyi2mnr
         S5ox3970abs4ECJgeAchiC+a9axxJGVXpw8XAcyNlu3v6zV/vdjVz7vhJEgFT/jWyG83
         JeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713420977; x=1714025777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zM+AwiIA7FKrgS/Ytacnt1rsdmjxxW5sRnLCAiG5Ajk=;
        b=CQpkXZft+yhosaSkFCOkpps1WvQ5FCXYMR4sW9zFCtNvlyqyWGD1sHcUFQ6r4GECMZ
         tC3XbYFXN2LrXwlot+1UjgOOCm7CtuJVBJ9i6FWrbNwvunZwD3kAKyTN6/ZU6QZjFVt/
         JzlJFUc+Cho7PHhaDLfRBvJaMMqwe28DHDx3IGx1LehtvTO4wDPZ0fcsDI+ypyUfJUyi
         akQ9kH+yhCUv2tdOllsreFGjamjg8/UwXzbPNycRoBFApkjxkUVl3CtsycNGOEkX6GvG
         JdNjyvzPV/Km6pMMmuqUFN5+BWZB6FSf+I10jKL0r8Nxk3FWV0zZN0YaLKlhLX3GtHUI
         1lLA==
X-Gm-Message-State: AOJu0YypYRD60yeC8FNbPRNPFKSkhyQ+J80wZM4X+jgbjTcLHMZPF5VA
	lkATSdDp4bqA5iUat4vY30VoRdjCUqlRZdBMzq/on/Os7kjv6wokUB1PrhfId88=
X-Google-Smtp-Source: AGHT+IGizIdXTx/CsZk8PbZxvqVwV8yCfAEfxtPRXxseAeb1ekCj2GMLjSLWgN3RIojVrXMq1Sz58A==
X-Received: by 2002:a17:906:c0d1:b0:a52:6535:d15f with SMTP id bn17-20020a170906c0d100b00a526535d15fmr887865ejb.61.1713420976631;
        Wed, 17 Apr 2024 23:16:16 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709066bc700b00a5556cd0fd5sm436991ejs.183.2024.04.17.23.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 23:16:16 -0700 (PDT)
Date: Thu, 18 Apr 2024 08:16:14 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v3 2/6] selftests: forwarding: move couple of
 initial check to the beginning
Message-ID: <ZiC6rpgScGzYyJZb@nanopsycho>
References: <20240417164554.3651321-1-jiri@resnulli.us>
 <20240417164554.3651321-3-jiri@resnulli.us>
 <ZiAb0wZcWDSozCoq@f4>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiAb0wZcWDSozCoq@f4>

Wed, Apr 17, 2024 at 08:58:27PM CEST, benjamin.poirier@gmail.com wrote:
>On 2024-04-17 18:45 +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> These two check can be done at he very beginning of the script.
>> As the follow up patch needs to add early code that needs to be executed
>> after the checks, move them.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>  tools/testing/selftests/net/forwarding/lib.sh | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> index 7913c6ee418d..2e7695b94b6b 100644
>> --- a/tools/testing/selftests/net/forwarding/lib.sh
>> +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> @@ -84,6 +84,16 @@ declare -A NETIFS=(
>>  # e.g. a low-power board.
>>  : "${KSFT_MACHINE_SLOW:=no}"
>>  
>> +if [[ "$(id -u)" -ne 0 ]]; then
>> +	echo "SKIP: need root privileges"
>> +	exit $ksft_skip
>> +fi
>> +
>> +if [[ ! -v NUM_NETIFS ]]; then
>> +	echo "SKIP: importer does not define \"NUM_NETIFS\""
>> +	exit $ksft_skip
>> +fi
>> +
>
>I noticed that this part conflicts with the recently merged commit
>2291752fae3d ("selftests: forwarding: lib.sh: Validate NETIFS"). Can you
>please verify that the conflict was fixed correctly? The above check is
>now duplicated in the file.

Right, will remove the duplicate. Thanks!

