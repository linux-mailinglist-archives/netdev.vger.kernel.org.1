Return-Path: <netdev+bounces-93994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB908BDDC7
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 11:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF4F281C5D
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 09:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701CF14D6E6;
	Tue,  7 May 2024 09:09:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF976BFC0;
	Tue,  7 May 2024 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715072963; cv=none; b=XfaNe3/xzzr7IZMRqK/2TDGgB3QlwewDolSed2LD52hVvfUNuvHs1lhjZf8yVd73/FgQsy/6SnXn2ndKzugOIn1OEhphLYzXD84VOD3t8athG7ZEsmw89sJ+JwChzh9zEoPPuivH5+DVtwCVAgkVsWicUc7p81x30q7BnZDXrkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715072963; c=relaxed/simple;
	bh=0L9VIcNji6Ae28xW1QP08XAInwJIp5n5Epon4SaYRxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHdLsDAQX5qqqZ1Q9Vi7HK4pwR8YN6+9VXEz70dZ2bJVluZSHEzg4NucqLPFF4LLDDVJV8iVHaoXjAGZi+JcMBIslNfWzEf81wDvdUP4xYftC2Re999HLACjA2UM5nJ3gKOdAODyiKPfbowgC3n5iIiLMImshzHHNa9gBa+jjVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A7BC2BBFC;
	Tue,  7 May 2024 09:09:20 +0000 (UTC)
Date: Tue, 7 May 2024 05:09:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: <xu.xin16@zte.com.cn>
Cc: <kuba@kernel.org>, <horms@kernel.org>, <davem@davemloft.net>,
 <mhiramat@kernel.org>, <dsahern@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <yang.yang29@zte.com.cn>, <he.peilin@zte.com.cn>,
 <liu.chun2@zte.com.cn>, <jiang.xuexin@zte.com.cn>,
 <zhang.yunkai@zte.com.cn>, <kerneljasonxing@gmail.com>,
 <fan.yu9@zte.com.cn>, <qiu.yutan@zte.com.cn>, <ran.xiaokai@zte.com.cn>,
 <zhang.run@zte.com.cn>, <wang.haoyi@zte.com.cn>, <si.hao@zte.com.cn>,
 <lu.zhongjun@zte.com.cn>
Subject: Re: [PATCH net-next v9] net/ipv4: add tracepoint for icmp_send
Message-ID: <20240507050917.238a0891@rorschach.local.home>
In-Reply-To: <202405071541038433DpxXxFl-a_4XcQGTy_BU@zte.com.cn>
References: <202405071541038433DpxXxFl-a_4XcQGTy_BU@zte.com.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 7 May 2024 15:41:03 +0800 (CST)
<xu.xin16@zte.com.cn> wrote:

> From: Peilin He <he.peilin@zte.com.cn>
>=20
> Introduce a tracepoint for icmp_send, which can help users to get more
> detail information conveniently when icmp abnormal events happen.
>=20
> 1. Giving an usecase example:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> When an application experiences packet loss due to an unreachable UDP
> destination port, the kernel will send an exception message through the
> icmp_send function. By adding a trace point for icmp_send, developers or
> system administrators can obtain detailed information about the UDP
> packet loss, including the type, code, source address, destination addres=
s,
> source port, and destination port. This facilitates the trouble-shooting
> of UDP packet loss issues especially for those network-service
> applications.
>=20
> 2. Operation Instructions:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> Switch to the tracing directory.
>         cd /sys/kernel/tracing
> Filter for destination port unreachable.
>         echo "type=3D=3D3 && code=3D=3D3" > events/icmp/icmp_send/filter
> Enable trace event.
>         echo 1 > events/icmp/icmp_send/enable
>=20
> 3. Result View:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  udp_client_erro-11370   [002] ...s.12   124.728002:
>  icmp_send: icmp_send: type=3D3, code=3D3.
>  From 127.0.0.1:41895 to 127.0.0.1:6666 ulen=3D23
>  skbaddr=3D00000000589b167a
>=20
> Signed-off-by: Peilin He <he.peilin@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> Cc: Liu Chun <liu.chun2@zte.com.cn>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> ---

=46rom just a tracing point of view:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

