Return-Path: <netdev+bounces-151786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39CA9F0D9B
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B971882A00
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A548F1E0B72;
	Fri, 13 Dec 2024 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A26XWLY3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4331DEFEC
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097546; cv=none; b=sP9S+QT0Uy6k98FH0Qft1F0U77KiGzqTIrFJu8uCCS04lw5BlHxmGcwzWaNVTMhZPToW8GlY/79yqGONSLqF2Q2l4l9EEEkMcahmxJMkmSBXcopZmUUvqb4m1dbAEPkaisSy8FromdzVu3Ll6NSiyAOy4f27fA6jjRYwVIpeuWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097546; c=relaxed/simple;
	bh=uZW74c73Oq7/td9mCuXW0GcNd3qn6G9lRBiXiNWt420=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCUwaxLk2w+CwI/sMgpjlTVCSkub2Fw1Yr37qXiKAiqTR7LpXd20DPzeiObw1OziSLojy9aHv3L3pVjpKQ+oBFxilr5ISOjssuGabauQC0c3AZUVbqFuck9C1NCKL+Ut3npq1ojEA2tKNkNDEyOazTsH7DQr/IOzekEt7CT+1Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A26XWLY3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD85u1X011400;
	Fri, 13 Dec 2024 13:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+T3FFX
	izCNYJoezCIFTaj3IO93ThRVuWpvbyK2Tr5CI=; b=A26XWLY39fXMznGASmJNL7
	niiq8M0Hwb9rgVcRjb2MmdNTAMxRT7FvHYRG61NaNOI9i+iuTaRCnNy9X8UANhQt
	YW7B/DDFmmEDXUVjJhH8Ah2cePyjV12X8QK6KDGeWQN8+7v2cbIbZjHF3zdmVxQF
	icPBrsZjice4TCkZ61q6hNblWbCjyERprSmQlGXZpO51yXFiYrbt9Jet+MIVX/Yt
	xjhgApAU80GBleBfE8KgzaaHwFBFtdU6UyhDjhdtrxagcCzdmYobU+OL0Cl73NoK
	Mftxv7mRPTKRj4j2Bhe0ml5ZNThbBlIJ15Us4+x94tMRFDh5N8pZRiCqD9CDKxOQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gh439e39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 13:45:25 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BDDgUlh001184;
	Fri, 13 Dec 2024 13:45:25 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gh439e36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 13:45:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD9sgbr018608;
	Fri, 13 Dec 2024 13:45:24 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d26kww5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 13:45:24 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BDDjOcj21299926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 13:45:24 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B5285805E;
	Fri, 13 Dec 2024 13:45:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCB8D58059;
	Fri, 13 Dec 2024 13:45:21 +0000 (GMT)
Received: from [9.171.74.77] (unknown [9.171.74.77])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 13:45:21 +0000 (GMT)
Message-ID: <919d9910-a405-40f0-ad0b-fa3e8b908013@linux.ibm.com>
Date: Fri, 13 Dec 2024 14:45:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 11/15] socket: Remove kernel socket
 conversion.
To: Kuniyuki Iwashima <kuniyu@amazon.com>, alibuda@linux.alibaba.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
        Matthieu Baerts <matttbe@kernel.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        Steve French <sfrench@samba.org>, Jan Karcher <jaka@linux.ibm.com>,
        Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
References: <20241213092152.14057-1-kuniyu@amazon.com>
 <20241213092152.14057-12-kuniyu@amazon.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20241213092152.14057-12-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QHiQkZ0IkrMjuWi3YnZrmrPBo4zmhmwz
X-Proofpoint-GUID: jg9pcSNvswoRCf-I3ZSJc5JvigBlIiQt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130095



On 13.12.24 10:21, Kuniyuki Iwashima wrote:
> Since commit 26abe14379f8 ("net: Modify sk_alloc to not reference count
> the netns of kernel sockets."), TCP kernel socket has caused many UAF.
> 
> We have converted such sockets to hold netns refcnt, and we have the
> same pattern in cifs, mptcp, rds, smc, and sunrpc.
> 
> Let's drop the conversion and use sock_create_net() instead.
> 
> The changes for cifs, mptcp, and smc are straightforward.
> 
> For rds, we need to move maybe_get_net() before sock_create_net() and
> sock->ops->accept().
> 
> For sunrpc, we call sock_create_net() for IPPROTO_TCP only and still
> call sock_create_kern() for others.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Acked-by: Allison Henderson <allison.henderson@oracle.com>
> ---
> v3: Add missing mutex_unlock in rds_tcp_conn_path_connect().
> v2: Collect Acked-by from MPTCP and RDS maintainers
> 
> Cc: Steve French <sfrench@samba.org>
> Cc: Wenjia Zhang <wenjia@linux.ibm.com>
> Cc: Jan Karcher <jaka@linux.ibm.com>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/smb/client/connect.c | 13 ++-----------
>   net/mptcp/subflow.c     | 10 +---------
>   net/rds/tcp.c           | 14 --------------
>   net/rds/tcp_connect.c   | 21 +++++++++++++++------
>   net/rds/tcp_listen.c    | 14 ++++++++++++--
>   net/smc/af_smc.c        | 21 ++-------------------
>   net/sunrpc/svcsock.c    | 12 ++++++------
>   net/sunrpc/xprtsock.c   | 12 ++++--------
>   8 files changed, 42 insertions(+), 75 deletions(-)
> 
> diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
> index c36c1b4ffe6e..7a67b86c0423 100644
> --- a/fs/smb/client/connect.c
> +++ b/fs/smb/client/connect.c
> @@ -3130,22 +3130,13 @@ generic_ip_connect(struct TCP_Server_Info *server)
>   	if (server->ssocket) {
>   		socket = server->ssocket;
>   	} else {
> -		struct net *net = cifs_net_ns(server);
> -		struct sock *sk;
> -
> -		rc = sock_create_kern(net, sfamily, SOCK_STREAM,
> -				      IPPROTO_TCP, &server->ssocket);
> +		rc = sock_create_net(cifs_net_ns(server), sfamily, SOCK_STREAM,
> +				     IPPROTO_TCP, &server->ssocket);
>   		if (rc < 0) {
>   			cifs_server_dbg(VFS, "Error %d creating socket\n", rc);
>   			return rc;
>   		}
>   
> -		sk = server->ssocket->sk;
> -		__netns_tracker_free(net, &sk->ns_tracker, false);
> -		sk->sk_net_refcnt = 1;
> -		get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
> -		sock_inuse_add(net, 1);
> -
>   		/* BB other socket options to set KEEPALIVE, NODELAY? */
>   		cifs_dbg(FYI, "Socket created\n");
>   		socket = server->ssocket;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index fd021cf8286e..e7e8972bdfca 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1755,7 +1755,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
>   	if (unlikely(!sk->sk_socket))
>   		return -EINVAL;
>   
> -	err = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
> +	err = sock_create_net(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
>   	if (err)
>   		return err;
>   
> @@ -1768,14 +1768,6 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
>   	/* the newly created socket has to be in the same cgroup as its parent */
>   	mptcp_attach_cgroup(sk, sf->sk);
>   
> -	/* kernel sockets do not by default acquire net ref, but TCP timer
> -	 * needs it.
> -	 * Update ns_tracker to current stack trace and refcounted tracker.
> -	 */
> -	__netns_tracker_free(net, &sf->sk->ns_tracker, false);
> -	sf->sk->sk_net_refcnt = 1;
> -	get_net_track(net, &sf->sk->ns_tracker, GFP_KERNEL);
> -	sock_inuse_add(net, 1);
>   	err = tcp_set_ulp(sf->sk, "mptcp");
>   	if (err)
>   		goto err_free;
> diff --git a/net/rds/tcp.c b/net/rds/tcp.c
> index 351ac1747224..4509900476f7 100644
> --- a/net/rds/tcp.c
> +++ b/net/rds/tcp.c
> @@ -494,21 +494,7 @@ bool rds_tcp_tune(struct socket *sock)
>   
>   	tcp_sock_set_nodelay(sock->sk);
>   	lock_sock(sk);
> -	/* TCP timer functions might access net namespace even after
> -	 * a process which created this net namespace terminated.
> -	 */
> -	if (!sk->sk_net_refcnt) {
> -		if (!maybe_get_net(net)) {
> -			release_sock(sk);
> -			return false;
> -		}
> -		/* Update ns_tracker to current stack trace and refcounted tracker */
> -		__netns_tracker_free(net, &sk->ns_tracker, false);
>   
> -		sk->sk_net_refcnt = 1;
> -		netns_tracker_alloc(net, &sk->ns_tracker, GFP_KERNEL);
> -		sock_inuse_add(net, 1);
> -	}
>   	rtn = net_generic(net, rds_tcp_netid);
>   	if (rtn->sndbuf_size > 0) {
>   		sk->sk_sndbuf = rtn->sndbuf_size;
> diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
> index a0046e99d6df..c9449780f952 100644
> --- a/net/rds/tcp_connect.c
> +++ b/net/rds/tcp_connect.c
> @@ -93,6 +93,7 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
>   	struct sockaddr_in6 sin6;
>   	struct sockaddr_in sin;
>   	struct sockaddr *addr;
> +	struct net *net;
>   	int addrlen;
>   	bool isv6;
>   	int ret;
> @@ -107,20 +108,28 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
>   
>   	mutex_lock(&tc->t_conn_path_lock);
>   
> +	net = rds_conn_net(conn);
> +
>   	if (rds_conn_path_up(cp)) {
> -		mutex_unlock(&tc->t_conn_path_lock);
> -		return 0;
> +		ret = 0;
> +		goto out;
>   	}
> +
> +	if (!maybe_get_net(net)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
>   	if (ipv6_addr_v4mapped(&conn->c_laddr)) {
> -		ret = sock_create_kern(rds_conn_net(conn), PF_INET,
> -				       SOCK_STREAM, IPPROTO_TCP, &sock);
> +		ret = sock_create_net(net, PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);
>   		isv6 = false;
>   	} else {
> -		ret = sock_create_kern(rds_conn_net(conn), PF_INET6,
> -				       SOCK_STREAM, IPPROTO_TCP, &sock);
> +		ret = sock_create_net(net, PF_INET6, SOCK_STREAM, IPPROTO_TCP, &sock);
>   		isv6 = true;
>   	}
>   
> +	put_net(net);
> +
>   	if (ret < 0)
>   		goto out;
>   
> diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
> index 69aaf03ab93e..440ac9057148 100644
> --- a/net/rds/tcp_listen.c
> +++ b/net/rds/tcp_listen.c
> @@ -101,6 +101,7 @@ int rds_tcp_accept_one(struct socket *sock)
>   	struct rds_connection *conn;
>   	int ret;
>   	struct inet_sock *inet;
> +	struct net *net;
>   	struct rds_tcp_connection *rs_tcp = NULL;
>   	int conn_state;
>   	struct rds_conn_path *cp;
> @@ -108,7 +109,7 @@ int rds_tcp_accept_one(struct socket *sock)
>   	struct proto_accept_arg arg = {
>   		.flags = O_NONBLOCK,
>   		.kern = true,
> -		.hold_net = false,
> +		.hold_net = true,
>   	};
>   #if !IS_ENABLED(CONFIG_IPV6)
>   	struct in6_addr saddr, daddr;
> @@ -118,13 +119,22 @@ int rds_tcp_accept_one(struct socket *sock)
>   	if (!sock) /* module unload or netns delete in progress */
>   		return -ENETUNREACH;
>   
> +	net = sock_net(sock->sk);
> +
> +	if (!maybe_get_net(net))
> +		return -EINVAL;
> +
>   	ret = sock_create_lite(sock->sk->sk_family,
>   			       sock->sk->sk_type, sock->sk->sk_protocol,
>   			       &new_sock);
> -	if (ret)
> +	if (ret) {
> +		put_net(net);
>   		goto out;
> +	}
>   
>   	ret = sock->ops->accept(sock, new_sock, &arg);
> +	put_net(net);
> +
>   	if (ret < 0)
>   		goto out;
>   
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 6e93f188a908..7b0de80b3aca 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -3310,25 +3310,8 @@ static const struct proto_ops smc_sock_ops = {
>   
>   int smc_create_clcsk(struct net *net, struct sock *sk, int family)
>   {
> -	struct smc_sock *smc = smc_sk(sk);
> -	int rc;
> -
> -	rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
> -			      &smc->clcsock);
> -	if (rc)
> -		return rc;
> -
> -	/* smc_clcsock_release() does not wait smc->clcsock->sk's
> -	 * destruction;  its sk_state might not be TCP_CLOSE after
> -	 * smc->sk is close()d, and TCP timers can be fired later,
> -	 * which need net ref.
> -	 */
> -	sk = smc->clcsock->sk;
> -	__netns_tracker_free(net, &sk->ns_tracker, false);
> -	sk->sk_net_refcnt = 1;
> -	get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
> -	sock_inuse_add(net, 1);
I don't think this line shoud be removed. Otherwise, the popurse here to 
manage the per namespace statistics in the case of network namespace 
isolation would be lost.
@D. Wythe, could you please check it again? Maybe you have some good 
testing on this case.

> -	return 0;
> +	return sock_create_net(net, family, SOCK_STREAM, IPPROTO_TCP,
> +			       &smc_sk(sk)->clcsock);
>   }
>   
>   static int __smc_create(struct net *net, struct socket *sock, int protocol,
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 9583bad3d150..cde5765f6f81 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -1526,7 +1526,10 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
>   		return ERR_PTR(-EINVAL);
>   	}
>   
> -	error = sock_create_kern(net, family, type, protocol, &sock);
> +	if (protocol == IPPROTO_TCP)
> +		error = sock_create_net(net, family, type, protocol, &sock);
> +	else
> +		error = sock_create_kern(net, family, type, protocol, &sock);
>   	if (error < 0)
>   		return ERR_PTR(error);
>   
> @@ -1551,11 +1554,8 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
>   	newlen = error;
>   
>   	if (protocol == IPPROTO_TCP) {
> -		__netns_tracker_free(net, &sock->sk->ns_tracker, false);
> -		sock->sk->sk_net_refcnt = 1;
> -		get_net_track(net, &sock->sk->ns_tracker, GFP_KERNEL);
> -		sock_inuse_add(net, 1);
> -		if ((error = kernel_listen(sock, 64)) < 0)
> +		error = kernel_listen(sock, 64);
> +		if (error < 0)
>   			goto bummer;
>   	}
>   
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index feb1768e8a57..f3e139c30442 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -1924,7 +1924,10 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
>   	struct socket *sock;
>   	int err;
>   
> -	err = sock_create_kern(xprt->xprt_net, family, type, protocol, &sock);
> +	if (protocol == IPPROTO_TCP)
> +		err = sock_create_net(xprt->xprt_net, family, type, protocol, &sock);
> +	else
> +		err = sock_create_kern(xprt->xprt_net, family, type, protocol, &sock);
>   	if (err < 0) {
>   		dprintk("RPC:       can't create %d transport socket (%d).\n",
>   				protocol, -err);
> @@ -1941,13 +1944,6 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
>   		goto out;
>   	}
>   
> -	if (protocol == IPPROTO_TCP) {
> -		__netns_tracker_free(xprt->xprt_net, &sock->sk->ns_tracker, false);
> -		sock->sk->sk_net_refcnt = 1;
> -		get_net_track(xprt->xprt_net, &sock->sk->ns_tracker, GFP_KERNEL);
> -		sock_inuse_add(xprt->xprt_net, 1);
> -	}
> -
>   	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
>   	if (IS_ERR(filp))
>   		return ERR_CAST(filp);


