Return-Path: <netdev+bounces-63605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32A182E663
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 02:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4751C210B3
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 01:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509C76FBF;
	Tue, 16 Jan 2024 00:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBU/3av2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD66E6FA7
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 00:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6db81c6287dso1122028b3a.0
        for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 16:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705366075; x=1705970875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mv2YBJpD9hIvqW37gYxiOp38ZAHvsrnrfAjC/BJlXNc=;
        b=kBU/3av2tfuoebx27TYICN1nu1GniOzwgybc9f97Kw7dLPPF5dqCwe36Y5vxob535J
         z6ul0p30pYBGiT5dgdOzkEF3lFoIs4zQwg4WaHMN0CZyoFZnglfD7523YPsnZ0lvbWoZ
         lBtl4SGozAiOU5qwbw+gyjLv8rkGAW/Abu+XvgJehFU2cOmnJgh07cCo4PDEJsJGWWFl
         2meKvevXZ9p/utEpqhWUknVOLCBZBTsTiE+TJZl5tIRJFvujRsBB6B/XCyk9vg7s3UPl
         Zl2ck/WPSN8lNNz/rxWkMSnif9IagJwcinzMUGF/FMOPC9LXjSqb32JpK05pwKNM7/R9
         Vwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705366075; x=1705970875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mv2YBJpD9hIvqW37gYxiOp38ZAHvsrnrfAjC/BJlXNc=;
        b=vuD17WASDQiwp0HrKLOysBrOveC7pBI7ZKh6Nkg9hAKeUK2COb8E6mjPzU1S+/Ej6w
         H2G3hmAlDapgwXPWWdzgFCWLYkg1Ha7C12sWeCN0XfeaWK3lz24IhzifWdH1L/ua9vtt
         LN43GuLzyC/UGIhwxhiOtpvQ/qlo2PF6MJlt4xiJXti/w7MPHOyXVbg4PGwjcpeDol8Z
         J5kKS0rQKz+uO9HCUslCJbDm5SLEbUAtD8ykzWH630WVG/95n5P2Sy9hMX5mN8HXEwaU
         Zvo4yRZIVfGj0aI/L/TtaHgNkjryDugAXf+hIIqQnPuMy3+JRKsiC6bIE9Ad5Wu3k4VZ
         ty3Q==
X-Gm-Message-State: AOJu0Yw7DXYfkBZGMmysbFjpKDpx48F28vJD5ddzX9UpsLVGURXt9Xk/
	orPs39+J6jQM18D6Bis+Dpc=
X-Google-Smtp-Source: AGHT+IGCTtQ6GjRFqJO+wnFzp+/mMdXKtkDdtl6DtuFHgyf8LgmaGtF72M7DQdPlNvMUhZH5b9DhqA==
X-Received: by 2002:a05:6a20:b298:b0:19a:3774:c597 with SMTP id ei24-20020a056a20b29800b0019a3774c597mr7349822pzb.4.1705366075147;
        Mon, 15 Jan 2024 16:47:55 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x28-20020aa793bc000000b006daed66b540sm8149035pff.219.2024.01.15.16.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 16:47:54 -0800 (PST)
Date: Tue, 16 Jan 2024 08:47:49 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Phil Sutter <phil@nwl.cc>,
	David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] selftests: rtnetlink: use setup_ns in bonding test
Message-ID: <ZaXSNR5NMAh-qaG8@Laptop-X1>
References: <20240115135922.3662648-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115135922.3662648-1-nicolas.dichtel@6wind.com>

On Mon, Jan 15, 2024 at 02:59:22PM +0100, Nicolas Dichtel wrote:
> This is a follow-up of commit a159cbe81d3b ("selftests: rtnetlink: check
> enslaving iface in a bond") after the merge of net-next into net.
> 
> The goal is to follow the new convention,
> see commit d3b6b1116127 ("selftests/net: convert rtnetlink.sh to run it in
> unique namespace") for more details.
> 
> Let's use also the generic dummy name instead of defining a new one.
> 
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
>  tools/testing/selftests/net/rtnetlink.sh | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
> index a31be0eaaa50..4667d74579d1 100755
> --- a/tools/testing/selftests/net/rtnetlink.sh
> +++ b/tools/testing/selftests/net/rtnetlink.sh
> @@ -1244,21 +1244,19 @@ kci_test_address_proto()
>  
>  kci_test_enslave_bonding()
>  {
> -	local testns="testns"
>  	local bond="bond123"
> -	local dummy="dummy123"
>  	local ret=0
>  
> -	run_cmd ip netns add "$testns"
> -	if [ $ret -ne 0 ]; then
> +	setup_ns testns
> +	if [ $? -ne 0 ]; then
>  		end_test "SKIP bonding tests: cannot add net namespace $testns"
>  		return $ksft_skip
>  	fi
>  
>  	run_cmd ip -netns $testns link add dev $bond type bond mode balance-rr
> -	run_cmd ip -netns $testns link add dev $dummy type dummy
> -	run_cmd ip -netns $testns link set dev $dummy up
> -	run_cmd ip -netns $testns link set dev $dummy master $bond down
> +	run_cmd ip -netns $testns link add dev $devdummy type dummy
> +	run_cmd ip -netns $testns link set dev $devdummy up
> +	run_cmd ip -netns $testns link set dev $devdummy master $bond down
>  	if [ $ret -ne 0 ]; then
>  		end_test "FAIL: initially up interface added to a bond and set down"
>  		ip netns del "$testns"
> -- 
> 2.39.2
> 

Thanks for the update.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

