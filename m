Return-Path: <netdev+bounces-87534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254828A3732
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 22:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568521C21B95
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 20:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC0638F84;
	Fri, 12 Apr 2024 20:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jgd7QLKz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D91527442
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 20:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712954625; cv=none; b=JJRAxMlYzwloXEvVqEhEZ80p3KbAk3ET8frEJs5BI0bLLwMHqYDwC0YSkwTrfbFwNc1LSJb33tKwc6Svp/mjQFJ2NCmYfqZdRzl7aP1I1cQUbil2A99zaSVB1vFGtujMdqHQxZMQwtwBmGXWuc9k2qfwJXUCY/pF4WipcHjeT44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712954625; c=relaxed/simple;
	bh=a9drh6RDh/gc5LP0JJH2bApYl3sZg5E6LTjci3KDBS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBr81uBYdHbdmMZdGAlnG01Hs8kHrn4jd0mVif/q0gSy/n/fAQDUiJGzWwaYKLSFYHZfGtl5ldJxmqMLpLJ/qER4nzBisOVEgJ6jzIeDPTNyOLJZIDpC1qzMsxrZFqkerJpJj/+YPkHqRSHevxSLL5lqCc3Hrn1+dw/q2XpiyQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jgd7QLKz; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-434942fb16aso4339341cf.2
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 13:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712954623; x=1713559423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n51BvZIT+WN9Wvb7bAXMMtFVvL7V11A9hSVIjwpajTo=;
        b=Jgd7QLKzIiJYVq1jiCCCZkIfiGxi78bC5qCHmrybTDpMFAfpzs53HxqjsVaA6Tzjmf
         foTDDWS9SKyvRYARI9z2G7tzccKJV728r1mnvIylSA6mm2kVULX27/o8+zQlIDrVJgTu
         oXaNE7C3kF1iKirsBfL2cejKHMIuWDRRwNXnJeu0zVV0acoMHYyGJqahSaEVVJ6+tE1a
         4E8iW9IQzkm31M8TbpexCze11VeuMN9WqOQYCQ7Cx55thdSIl31Sd634KpdtAWFexZVq
         1IFOvp1vmuAxnTFuC6v66qHrlOQXfbilSwYCqB5w8jpNLDaYMe2fbl2dCDf5fY2IRF6S
         /nvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712954623; x=1713559423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n51BvZIT+WN9Wvb7bAXMMtFVvL7V11A9hSVIjwpajTo=;
        b=JD5foUNdtZMe6jb2pAcUwtgof/2lUjaTG8JeoMpAKGlTirlfXyQYf14hANbVQMam3B
         BN3UATSsoEshBfbByKwIRsy3auA3Y+6rcd4LxbRJpuQn/k73KSAgQiRRfEae7SYAX6pj
         4IeLzV43D38r0CFD4SAekv16SJRh0ZWg/aQPn8WCqwjKxhPbHj7EyVHMSmrYIj23icpC
         Gm5iS6kh6PdUZAmUKNWYVVQkePGI1yFIb0oc3UA5cQVfg7tJAeegEpTHe+qH8xCTunsQ
         Srsog1Rxb8UgAGY952ctd2xokFMZ712rjMTxgnCTl4wH7gY0XN9DzSzQvJwNIMl8Xgbl
         kNFQ==
X-Gm-Message-State: AOJu0YxRhB63TFS+/Lh4LMvXJQkaLQf1VdVO2K/BKbS1BozC/UrV9Mrd
	2YVYyth/J3EVkYEikM9DhKVf4Ep2k2ZrF8xbHi3SR1Fg6gQcoiWUKXLAhmNl
X-Google-Smtp-Source: AGHT+IHZCGsvpaFveX/T5xCZgBDGCi4rgvJEU/PhlFJDpUHv1LskwNrc66A6TbKBWCp4fE9QMdzADw==
X-Received: by 2002:ac8:598f:0:b0:435:bda5:483c with SMTP id e15-20020ac8598f000000b00435bda5483cmr4253599qte.62.1712954623068;
        Fri, 12 Apr 2024 13:43:43 -0700 (PDT)
Received: from localhost ([142.169.16.165])
        by smtp.gmail.com with ESMTPSA id v9-20020ac87289000000b00436b2135b51sm285562qto.64.2024.04.12.13.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 13:43:42 -0700 (PDT)
Date: Fri, 12 Apr 2024 16:43:40 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next 5/6] selftests: forwarding: add wait_for_dev()
 helper
Message-ID: <Zhmc_KsL__7noHWZ@f4>
References: <20240412151314.3365034-1-jiri@resnulli.us>
 <20240412151314.3365034-6-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412151314.3365034-6-jiri@resnulli.us>

On 2024-04-12 17:13 +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> The existing setup_wait*() helper family check the status of the
> interface to be up. Introduce wait_for_dev() to wait for the netdevice
> to appear, for example after test script does manual device bind.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 959183b516ce..74859f969997 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -746,6 +746,25 @@ setup_wait()
>  	sleep $WAIT_TIME
>  }
>  
> +wait_for_dev()
> +{
> +	local dev=$1; shift
> +	local timeout=${1:-$WAIT_TIMEOUT}; shift
> +	local max_iterations=$(($timeout * 10))
> +
> +	for ((i = 1; i <= $max_iterations; ++i)); do
> +		ip link show dev $dev up &> /dev/null
> +		if [[ $? -ne 0 ]]; then
> +			sleep 0.1
> +		else
> +			return 0
> +		fi
> +	done
> +
> +	log_test wait_for_dev ": Interface $dev did not appear."
> +	exit 1
> +}

How about rewriting the function to make use of the `slowwait` helper as
follows:

wait_for_dev()
{
	local dev=$1; shift
	local timeout=${1:-$WAIT_TIMEOUT}; shift

	slowwait $timeout ip link show dev $dev up &> /dev/null
	if (( $? )); then
		check_err 1
		log_test wait_for_dev "Interface $dev did not appear."
		exit $EXIT_STATUS
	fi
}

