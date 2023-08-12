Return-Path: <netdev+bounces-27066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AD377A179
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 19:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E198F1C208F4
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 17:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51648883B;
	Sat, 12 Aug 2023 17:47:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B6620EE
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 17:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB3DC433C7;
	Sat, 12 Aug 2023 17:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691862463;
	bh=vdPr7Kd2KSwm7V82XjFtxBtkVUVxXjALdt/pa5tnOfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FbMPp9Il+NKZCMT04hrcAJmZS48vP70mvB6QLO0C2EyywKYPck3Ty1NrZiM4cUm0b
	 5lXwuTR2pueQjEBJXDVRHrsq9Zm4TenfYiSVDO3fNORiai/YkmD3yrl50ll7V8bxtf
	 yCL0oFAXYvvOCoTjQlN6cmGroi+Yey9nvSMlhnRkQSkHOihsvVOH04vHIwkZJXWIo8
	 VsL807xabUrYD4VtnZM5J5rRqv3EFpVJdXyM3qRdMKCe8m9/t0RcX47S5RwgBN+0Sm
	 FVsRRBNf6jyek82daGjPBThokmJowuqT+LXKfpbSru6NHBetSU0shLHLKTbi1TkfVX
	 6FTh130EugZ2Q==
Date: Sat, 12 Aug 2023 19:47:38 +0200
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, mlxsw@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: mirror_gre_changes: Tighten up the TTL
 test match
Message-ID: <ZNfFuoNXvwaB8jmX@vergenet.net>
References: <3ea00504d4fa00a4f3531044e3df20312d472a39.1691769262.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ea00504d4fa00a4f3531044e3df20312d472a39.1691769262.git.petrm@nvidia.com>

On Fri, Aug 11, 2023 at 05:59:27PM +0200, Petr Machata wrote:

+ Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org

> This test verifies whether the encapsulated packets have the correct
> configured TTL. It does so by sending ICMP packets through the test
> topology and mirroring them to a gretap netdevice. On a busy host
> however, more than just the test ICMP packets may end up flowing
> through the topology, get mirrored, and counted. This leads to
> potential spurious failures as the test observes much more mirrored
> packets than the sent test packets, and assumes a bug.
> 
> Fix this by tightening up the mirror action match. Change it from
> matchall to a flower classifier matching on ICMP packets specifically.
> 
> Fixes: 45315673e0c5 ("selftests: forwarding: Test changes in mirror-to-gretap")
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  tools/testing/selftests/net/forwarding/mirror_gre_changes.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
> index aff88f78e339..5ea9d63915f7 100755
> --- a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
> +++ b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
> @@ -72,7 +72,8 @@ test_span_gre_ttl()
>  
>  	RET=0
>  
> -	mirror_install $swp1 ingress $tundev "matchall $tcflags"
> +	mirror_install $swp1 ingress $tundev \
> +		"prot ip flower $tcflags ip_prot icmp"
>  	tc filter add dev $h3 ingress pref 77 prot $prot \
>  		flower skip_hw ip_ttl 50 action pass
>  
> -- 
> 2.41.0
> 
> 

