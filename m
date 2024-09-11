Return-Path: <netdev+bounces-127321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7A6974FAE
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 12:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD88F1C22855
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E2F1802DD;
	Wed, 11 Sep 2024 10:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Xu8Y3dRD"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC1814A606;
	Wed, 11 Sep 2024 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050445; cv=none; b=VODWM0TPVugE9ehZcuWrJLGDlHDGW1eTui1zXSkkm873k67iPJvK6Nz9/ZkaMmebUdu1zsXvST1Edk3g9N6olQ3wAmWlRFChtxzA8Mq7A8PFNajv46w1CrMH4gRoZANNTy2ogfsbscU200pVT6AiDyCTfPHPxppiwMh3BdJZpLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050445; c=relaxed/simple;
	bh=rqT9eY0boblbsatS6ps+fzXUv/Y8bmaKnqZFJdAYxpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvgUminEbxLLrcyMOBKLM1gXfM5fb7CqS3cm0RJr2o1Z6dro3ezd/qbVL5X4YN/g70mO0UcHD0u2JImyYXVuRINDD4MIyfoXrRdlkOiQpWqo4n50p2NWHFfswd5Xj9qpV8TsGDqooY7kAPptuk/ivnLeV9RhZ2uchfYTS4Nypu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Xu8Y3dRD; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=fV673DpfFA4MYNHfQAvK+I/5OpdY8LmvXQLXqXTiBUI=;
	b=Xu8Y3dRDI2FOngWW50UTmcMSEFljtkXZoLD1JxeEeaI66kPQ8OvmUcTUQuLot/
	Jpu0FWIEUn3eji1eBov9XRY4Bmrndvh2UB+uzzmupkHfp9mgkcjlfnF+xbjPOWi3
	fwp6BkDsZWGnaZaNV86xHnd4tqRJOqsIoyZcAs2RjgPLA=
Received: from localhost (unknown [120.26.85.94])
	by gzga-smtp-mta-g2-3 (Coremail) with SMTP id _____wDnD6bzb+FmSVO0AQ--.2273S2;
	Wed, 11 Sep 2024 18:24:51 +0800 (CST)
Date: Wed, 11 Sep 2024 18:24:51 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Tze-nan.Wu@mediatek.com, xiyou.wangcong@gmail.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: check the return value of the copy_from_sockptr
Message-ID: <ZuFv88V0qhcwfOgP@iZbp1asjb3cy8ks0srf007Z>
References: <20240911050435.53156-1-qianqiang.liu@163.com>
 <CANn89iKhbQ1wDq1aJyTiZ-yW1Hm-BrKq4V5ihafebEgvWvZe2w@mail.gmail.com>
 <ZuFTgawXgC4PgCLw@iZbp1asjb3cy8ks0srf007Z>
 <CANn89i+G-ycrV57nc-XrgToJhwJuhuCGtHpWtFsLvot7Wu9k+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+G-ycrV57nc-XrgToJhwJuhuCGtHpWtFsLvot7Wu9k+w@mail.gmail.com>
X-CM-TRANSID:_____wDnD6bzb+FmSVO0AQ--.2273S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr18Kry5JFy8WFWrWr18uFg_yoW8KF18pF
	1Yy3WDXrZ7XFWvqFnYgay8WryrAr4Sy3yUCa4vyry8ZFsrW3WfXry29F4akFnrWr4fArZI
	qrWjgw1Yy3Z5Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jq9akUUUUU=
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiRQ1XamXAo2ARQgABsB

On Wed, Sep 11, 2024 at 11:12:24AM +0200, Eric Dumazet wrote:
> On Wed, Sep 11, 2024 at 10:23 AM Qianqiang Liu <qianqiang.liu@163.com> wrote:
> >
> > > I do not think it matters, because the copy is performed later, with
> > > all the needed checks.
> >
> > No, there is no checks at all.
> >
> 
> Please elaborate ?
> Why should maintainers have to spend time to provide evidence to
> support your claims ?
> Have you thought about the (compat) case ?
> 
> There are plenty of checks. They were there before Stanislav commit.
> 
> Each getsockopt() handler must perform the same actions.
> 
> For instance, look at do_ipv6_getsockopt()
> 
> If you find one getsockopt() method failing to perform the checks,
> please report to us.

Sorry, let me explain a little bit.

The issue was introduced in this commit: 33f339a1ba54e ("bpf, net: Fix a
potential race in do_sock_getsockopt()")

diff --git a/net/socket.c b/net/socket.c
index fcbdd5bc47ac..0a2bd22ec105 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2362,7 +2362,7 @@ INDIRECT_CALLABLE_DECLARE(bool tcp_bpf_bypass_getsockopt(int level,
 int do_sock_getsockopt(struct socket *sock, bool compat, int level,
 		       int optname, sockptr_t optval, sockptr_t optlen)
 {
-	int max_optlen __maybe_unused;
+	int max_optlen __maybe_unused = 0;
 	const struct proto_ops *ops;
 	int err;
 
@@ -2371,7 +2371,7 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
 		return err;
 
 	if (!compat)
-		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
+		copy_from_sockptr(&max_optlen, optlen, sizeof(int));
 
 	ops = READ_ONCE(sock->ops);
 	if (level == SOL_SOCKET) {

The return value of "copy_from_sockptr()" in "do_sock_getsockopt()" was
not checked. So, I added the following patch:

diff --git a/net/socket.c b/net/socket.c
index 0a2bd22ec105..6b9a414d01d5 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2370,8 +2370,11 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
 	if (err)
 		return err;
 
-	if (!compat)
-		copy_from_sockptr(&max_optlen, optlen, sizeof(int));
+	if (!compat) {
+		err = copy_from_sockptr(&max_optlen, optlen, sizeof(int));
+		if (err)
+			return -EFAULT;
+	}
 
 	ops = READ_ONCE(sock->ops);
 	if (level == SOL_SOCKET) {

Maybe I missed something?

If you think it's not an issue, then I'm OK with it.

-- 
Best,
Qianqiang Liu


