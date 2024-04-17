Return-Path: <netdev+bounces-88852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7889F8A8BBB
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 20:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797A61C2458D
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 18:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED3F1DFF3;
	Wed, 17 Apr 2024 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyU7bQXV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD93B1CD38
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713380312; cv=none; b=EylY3m2fjSFnOcY9UaHBPctaV42HAz4ImVEQGXxXCuxlK/+xOt6Pwz22jSirPLkw6tscLGTmwLLO9m1ao3AAPjuxkfUzV4pmrhh3xmlXBblyRWLlacswmaDwpcZyKPhbdGQSe3JmN8aE/BJf07WuttJ2YHahbPWwVb4btNzBtek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713380312; c=relaxed/simple;
	bh=/jnFAtk5JrhCZKzNlE0FZi4DnJAjgqAmYsYCDTMivik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sadBbF2XMsP4n2bwcqrbf4reuVUXKj1mu1DdGS6sbvMtpNmuN4qgoPLM8/6kvyQ2WaasrznaI5Azkp9jF5PquU/21Sz3ou4nNZ1S1h1bqItIf18hEdm6b9LD+GftXa9tiJtpIuLc3zCMyQFr9GL2xhHGnuG9AxppT6yV9Bz1g4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyU7bQXV; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-437202687bfso18767121cf.2
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 11:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713380308; x=1713985108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fAbbCnyx7krUH4X1bdxFgDOmkasKsIov7yr+n3NIJH0=;
        b=KyU7bQXVzCSap4OsDoVBFNjFZxK1HkoC3SutfuC+2++MgyA+RMFMpVGZg8L0UExv0d
         vRfQK3qijVJJjCqcxnzwPm1pi68fGaaYZbGFP/SCzhVR4E6qtDl662E6Y395wssu+Azc
         MebL49QZMfcxLl7KBqKqargr/NhBXBFeoIUJNA2xtq9jtV+eVGIAL0NXOhdR9vmgBCVP
         5i/LeRZVxVzFOP6vE38QaSuYRYn7fsglBVwd9lOhR+QsTmQNKbFM8AbPluiSVBUK8jMd
         4bsUvM954D5G2fWuAJvqvz7a42yh6Jie8DjKIg03D8fC7wmyvy6R+NfDgSxk7Qu/5Vfo
         jNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713380308; x=1713985108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAbbCnyx7krUH4X1bdxFgDOmkasKsIov7yr+n3NIJH0=;
        b=V7gJSwl03HkaJPoxVAgYSgF5KzCkf7l9LU23WcYQFaFCnbZlk4hHTImuJFJC1DsyGR
         vkV6jysANJxd1VUc/cFUuwDRreiCFTq881yHaGtiIMJcF6Cf3xxpl/tPjRaBWqYA7aR3
         rF+0+LLxBpgBML3P6tNN3K9zk8tkpWIJnwjMyL1W+6CpmBElyedCNm9IxOXREef3Emsh
         EoSC/dklPRcg2mVQ7JxE0OOScJi8oter5KsX8aCMds+eYTBte4+XIZcSQjD79DqJZIAP
         JOa6m1MdTHQFEu+GZg6SF2xg42GR7ZxyQjxtHuJKqJd+c2sbzIMH47WGr28mU9AUlJ+I
         tRCA==
X-Gm-Message-State: AOJu0YzHRA44aoJDoMTjufhL9JeQkccJRsKQ8K1S3hQtf1lG7hwlOwAZ
	m/8EfndniZSU1vu8K9sAxTMZ/Q69QrEHGsMpFzOOybMqPiljUJ8C
X-Google-Smtp-Source: AGHT+IFbqlGvvzByv8jR2ziRuPLaB/yqLU/1wtab9WpmRhUSYTXy/ttB2aaZU4Y+QHqkOgRWl7qnkQ==
X-Received: by 2002:a05:622a:1787:b0:436:888f:80d0 with SMTP id s7-20020a05622a178700b00436888f80d0mr501009qtk.28.1713380308527;
        Wed, 17 Apr 2024 11:58:28 -0700 (PDT)
Received: from localhost (24-122-67-147.resi.cgocable.ca. [24.122.67.147])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8490f000000b00434d86fb403sm8327092qtq.86.2024.04.17.11.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 11:58:28 -0700 (PDT)
Date: Wed, 17 Apr 2024 14:58:27 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v3 2/6] selftests: forwarding: move couple of
 initial check to the beginning
Message-ID: <ZiAb0wZcWDSozCoq@f4>
References: <20240417164554.3651321-1-jiri@resnulli.us>
 <20240417164554.3651321-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417164554.3651321-3-jiri@resnulli.us>

On 2024-04-17 18:45 +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> These two check can be done at he very beginning of the script.
> As the follow up patch needs to add early code that needs to be executed
> after the checks, move them.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 7913c6ee418d..2e7695b94b6b 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -84,6 +84,16 @@ declare -A NETIFS=(
>  # e.g. a low-power board.
>  : "${KSFT_MACHINE_SLOW:=no}"
>  
> +if [[ "$(id -u)" -ne 0 ]]; then
> +	echo "SKIP: need root privileges"
> +	exit $ksft_skip
> +fi
> +
> +if [[ ! -v NUM_NETIFS ]]; then
> +	echo "SKIP: importer does not define \"NUM_NETIFS\""
> +	exit $ksft_skip
> +fi
> +

I noticed that this part conflicts with the recently merged commit
2291752fae3d ("selftests: forwarding: lib.sh: Validate NETIFS"). Can you
please verify that the conflict was fixed correctly? The above check is
now duplicated in the file.

