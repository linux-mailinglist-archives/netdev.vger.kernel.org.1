Return-Path: <netdev+bounces-73773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE18785E49D
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 18:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599321F2503D
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 17:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B3783A11;
	Wed, 21 Feb 2024 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mtw3UB1e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D282F81737
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 17:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536760; cv=none; b=mT8+JBEFXmdbTNnAeHfKvYIaVcSOmdjPl7K3VnRqA3RIzwYPf51eEAtcf/Z+3R0sv/ewlPLf78nZjQUMH+b/unw4ZbTZLlEt6E+ZrRKSBj9HEiq8bfmR/JMdXBzjmrGMO+BrnFUG0HIf42JlwHlhhMpSA1GukDKh6QPwgibtSR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536760; c=relaxed/simple;
	bh=JwdwM9J2OLTx3o/tPJIcLuRjEyhF3j3cRwoLtdYcuiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aCgelo39yICzltxY1fBaxyenGGB3VrFgI7d6tXXyV5SvpBfHvN01GgsSoQL/kPirf1MM2TyEWufBjy3puVJDTyHZJtYh92KKOaJdEQqonWuxef1TEne9TTR/UrHQKss0OFZglSnUd7G9qgfdSEhehbRDbUv2rmXHmil1ceK7WE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mtw3UB1e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708536756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fd0K12ppmMHd+McfZDDjz5bojEcZl56vE7eqAs6MGJo=;
	b=Mtw3UB1eo2FJmNNRwohzvnFjffrQ7ywmYTCvU0I9zuTKDA//WowARW2QU/irIc78HpJdSu
	MeMfvPqczPplarZhswuGGZ4b5iHW+T8CZYxUOFFI3FQkMpDn7Kl7GHwl/sAPhnUP8PyPjd
	L3ISg5n6Epgco+WnfrWtUsYODMlVf+4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-frhRAqf4OT6cLekrpXaGXg-1; Wed, 21 Feb 2024 12:32:34 -0500
X-MC-Unique: frhRAqf4OT6cLekrpXaGXg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40fb505c97aso4437155e9.3
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 09:32:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708536753; x=1709141553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fd0K12ppmMHd+McfZDDjz5bojEcZl56vE7eqAs6MGJo=;
        b=mlyNAUU1Zbikf4/7hHgihJ6ZvCh+Jw4RwcXaX8lp0cdyoPCWu9Sa0jAsINn13SSgc3
         0SloxZMsgVvLadyz9CXLdsEBGx0BpxHzHKdWfZ3u+mXMSjCXWUEtk2lf1ogg6U2Hbu8N
         WfqvFmwDWUG6E4ju2RaglgvdIWsFx6M5CxdoN6I+3vF1yaRNR5Q2RuUI+DuSUHTLVomU
         GOc/oOUVurMGuU1BmTNXqmp6M/w0S9ySozCSdJGYS7NOgAYHB4Mgzmm4xizH+OylMnUl
         q9x1/h+uL6QHYN12hnsqICj/8N38KJ/J5R5ggQmPGl7qU7nFjKzwnIoaTeds6Nktudws
         uUqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCF7MTv0szVejZp75rEmN2jCjtkvtPAbvgI+N/6uLQm2WwfBH+YBqCOMwSt2VpAXrPw7nqVs9r/hWuWbVsSma1hoI1U2fm
X-Gm-Message-State: AOJu0Yylfa6Lf/5+tl5pJlN5sfl19hWSVfdYDKKrC0ABPoXHQgXzWUFS
	t3kQNv75us3O70XF/2sze0wrBIn4isnEf7cE7EUFxr4HKkw3D+URdnp9XSlNc3GEa9dnjJMRigr
	0+aSXl6dlkVNh9axH5kwpvwUkMLkrtG6O1PcI8xXi6t+jWeHuxBNfUg==
X-Received: by 2002:adf:f0d0:0:b0:33d:174e:4813 with SMTP id x16-20020adff0d0000000b0033d174e4813mr11354139wro.23.1708536753546;
        Wed, 21 Feb 2024 09:32:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdnkLEMCWa5DR8DAqERAk6cUsWMVC+2IfGQSKzzLHWdb7GXG9EFarqvM0LisScIuXJNvtxJg==
X-Received: by 2002:adf:f0d0:0:b0:33d:174e:4813 with SMTP id x16-20020adff0d0000000b0033d174e4813mr11354118wro.23.1708536753199;
        Wed, 21 Feb 2024 09:32:33 -0800 (PST)
Received: from [192.168.1.131] ([193.177.210.50])
        by smtp.gmail.com with ESMTPSA id q4-20020adfab04000000b0033cf637eea2sm17684985wrc.29.2024.02.21.09.32.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 09:32:32 -0800 (PST)
Message-ID: <4bba621b-3680-4c70-b10c-39787c7c0ce1@redhat.com>
Date: Wed, 21 Feb 2024 18:32:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ovs-dev] [RFC 3/7] selftests: openvswitch: use non-graceful
 kills when needed
Content-Language: en-US
To: Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org
Cc: dev@openvswitch.org, Ilya Maximets <i.maximets@ovn.org>,
 Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>
References: <20240216152846.1850120-1-aconole@redhat.com>
 <20240216152846.1850120-4-aconole@redhat.com>
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <20240216152846.1850120-4-aconole@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/16/24 16:28, Aaron Conole wrote:
> Normally a spawned process under OVS is given a SIGTERM when the test
> ends as part of cleanup.  However, in case the process is still lingering
> for some reason, we also send a SIGKILL to force it down faster.
> 
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---
>   tools/testing/selftests/net/openvswitch/openvswitch.sh | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index a5dbde482ba4..678a72ad47c1 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -91,7 +91,8 @@ ovs_add_if () {
>   		python3 $ovs_base/ovs-dpctl.py add-if \
>   		    -u "$2" "$3" >$ovs_dir/$3.out 2>$ovs_dir/$3.err &
>   		pid=$!
> -		on_exit "ovs_sbx $1 kill -TERM $pid 2>/dev/null"
> +		on_exit "ovs_sbx $1 kill --timeout 1000 TERM \
> +                                        --timeout 1000 KILL $pid 2>/dev/null"
>   	fi
>   }
>   

AFAIK, this will immediately send TERM, then wait 1s, send TERM again, wait 1s 
then send KILL. Is that what you intended? To avoid the double TERM you could:

kill --timeout 1000 KILL --signal TERM $pid

--
Adrián Moreno

> @@ -108,7 +109,8 @@ ovs_netns_spawn_daemon() {
>   	info "spawning cmd: $*"
>   	ip netns exec $netns $*  >> $ovs_dir/stdout  2>> $ovs_dir/stderr &
>   	pid=$!
> -	ovs_sbx "$sbx" on_exit "kill -TERM $pid 2>/dev/null"
> +	ovs_sbx "$sbx" on_exit "kill --timeout 1000 TERM \
> +                                    --timeout 1000 KILL $pid 2>/dev/null"
>   }
>   
>   ovs_add_netns_and_veths () {


