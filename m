Return-Path: <netdev+bounces-21057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B0676241F
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 23:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F391281A4B
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 21:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71DF26B77;
	Tue, 25 Jul 2023 21:08:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD9825936;
	Tue, 25 Jul 2023 21:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A928FC433C8;
	Tue, 25 Jul 2023 21:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690319303;
	bh=mFP4UYco3gOD5VKyaE0YzA7kaUtVPHKmet4Fc4mG02w=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=KJ8lTP6dOcczngeRimNEKGAjKevSsSSrB4XmesB0YrYxMZrDgFiSqzxRMJGxYq0eG
	 OCBFwq8IFfA4315z9VhHz+SpV8vl500TQP+L5GYKvt5dOHxxJ/79SV+FbXXkxbSXi2
	 fQIhx3yJ4aWWg5P79YYEszk17WSRmv+HnIcRVPfJMYWdv3yAcfuyA9AqeF8s1D8MU0
	 DOiGLdNNwCUyDphpBZ68MZ43v1qh7XyB4LYWP9f2CidFuwkaWjGM6L24ZMkWU66JpW
	 BbAPKy9x+kJ0+S+ZfmINbU723wzIVGPXff3wsSjsUQ00kHHBoOpgp6XUI3aBBxAVbH
	 nixNZGC6D5sUQ==
Date: Tue, 25 Jul 2023 14:08:22 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
cc: Greg KH <gregkh@linuxfoundation.org>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Geliang Tang <geliang.tang@suse.com>, 
    netdev@vger.kernel.org, mptcp@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] selftests: mptcp: join: only check for ip6tables
 if needed
In-Reply-To: <2023072521-surfboard-starry-fbe8@gregkh>
Message-ID: <1388a7a1-dbad-1653-d9eb-150fdd1ec746@kernel.org>
References: <20230725-send-net-20230725-v1-0-6f60fe7137a9@kernel.org> <20230725-send-net-20230725-v1-1-6f60fe7137a9@kernel.org> <2023072521-surfboard-starry-fbe8@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 25 Jul 2023, Greg KH wrote:

> On Tue, Jul 25, 2023 at 11:34:55AM -0700, Mat Martineau wrote:
>> From: Matthieu Baerts <matthieu.baerts@tessares.net>
>>
>> If 'iptables-legacy' is available, 'ip6tables-legacy' command will be
>> used instead of 'ip6tables'. So no need to look if 'ip6tables' is
>> available in this case.
>>
>> Fixes: 0c4cd3f86a40 ("selftests: mptcp: join: use 'iptables-legacy' if available")
>> Acked-by: Paolo Abeni <pabeni@redhat.com>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> Signed-off-by: Mat Martineau <martineau@kernel.org>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index e6c9d5451c5b..3c2096ac97ef 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -162,9 +162,7 @@ check_tools()
>>  	elif ! iptables -V &> /dev/null; then
>>  		echo "SKIP: Could not run all tests without iptables tool"
>>  		exit $ksft_skip
>> -	fi
>> -
>> -	if ! ip6tables -V &> /dev/null; then
>> +	elif ! ip6tables -V &> /dev/null; then
>>  		echo "SKIP: Could not run all tests without ip6tables tool"
>>  		exit $ksft_skip
>>  	fi
>>
>> --
>> 2.41.0
>>
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
>
> </formletter>

Ugh, I did forget to add the "Cc: stable@vger.kernel.org" tag in the 
commit messages for this series and only added in the email cc field.

Jakub/Paolo, if you apply the series as-is I can make sure these end up in 
stable (as they likely will even without the cc tag). If you prefer I send 
a v2 just let me know.


- Mat

