Return-Path: <netdev+bounces-84108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CB48959A6
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 18:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351201F22DFB
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 16:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27AB14B065;
	Tue,  2 Apr 2024 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="h3c5A5VJ"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8B414AD3F;
	Tue,  2 Apr 2024 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075075; cv=none; b=EraYS7DAV2CB/S4rhFxUhJvCOT+0JuxV0IO6WmZJ+uLiDHVNVD87H97Y9sNnM5v1Tk1XO58WsMvihQ6dCR2Wll2xTb8xRl1LmSy3K+g3KWsKQ+yM8dmbVIgqxrMSurQ977Bh7tsznC1IaEwfQwFkgKxBF00GTjrlfdDzebHqwYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075075; c=relaxed/simple;
	bh=T/1yoCsi4GP730fXqNiqoizjQuq13ZRUJPoJmfMP5kg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NBhkY1xy99x6wjXqsLW1sbRF4612pQqVubJxpm+AkRf+rz11Xpk9Nc6yZyibIcWIdjat1Z3tlFXKwWeLtNmZV3v1MCYTxleLRLCwDNE27RY/wVyKIdvL1xtqEWjW7IvG3BPfOe+ykL0zxZqDnIzcI/E6TeghgdaP87CjSuDdWl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=h3c5A5VJ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=CyIVajsnrqIc9aPmFtNlh8ytag8an+QEap4fj/7NjHc=; b=h3c5A5VJAAgv6qoUjBFB4+v+xA
	zM6zctkJmzQ3myEg1AcdGCislp6xYaCnF/M9CnmRRZdD40PstebrZhf2DPyzdTkwsAAYA7U57N+Xr
	xM/bMzKwagk47WFPqXCpKAVOgEzvIp2HehrBcGBxzne1QO4/TSbzcnAhsx0Y4N6Hkjm1qYtYjyc4i
	rDvdi4N5oNIrwn+ITgg+UQ38iYGk6deZMweqj0A/VlhqMOA5wLy1NfXmz5LGSK/bm1qNN9DKLdjB/
	frOjcFCG2rOrwzsltny3/YZleAw00FsyNqdSEAnwExHYQTUt2JQ5NrtOE2FtbqefD7JYMMypG5CL5
	xznMnodQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rrgbX-0002E0-Kh; Tue, 02 Apr 2024 18:03:19 +0200
Received: from [178.197.248.12] (helo=linux.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rrgbW-0002En-1Y;
	Tue, 02 Apr 2024 18:03:18 +0200
Subject: Re: [PATCH bpf-next 2/5] riscv, bpf: Relax restrictions on Zbb
 instructions
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Manu Bretelle <chantr4@gmail.com>, Pu Lehui <pulehui@huawei.com>
References: <20240328124916.293173-1-pulehui@huaweicloud.com>
 <20240328124916.293173-3-pulehui@huaweicloud.com>
 <878r1vrga9.fsf@all.your.base.are.belong.to.us>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5005fb56-086c-2aa7-e28b-83f0fc51f988@iogearbox.net>
Date: Tue, 2 Apr 2024 18:03:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <878r1vrga9.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27233/Tue Apr  2 10:26:21 2024)

On 4/2/24 4:27 PM, Björn Töpel wrote:
> Pu Lehui <pulehui@huaweicloud.com> writes:
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> This patch relaxes the restrictions on the Zbb instructions. The hardware
>> is capable of recognizing the Zbb instructions independently, eliminating
>> the need for reliance on kernel compile configurations.
>>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> 
> Should this patch really be part of this series?

No, that should be submitted independently.

Also, given Eduard's comment, it would be great if you could add the
instructions to tools/testing/selftests/bpf/README.rst even if not in
a perfect shape, but it would give developers a chance to get started.

Thanks,
Daniel

