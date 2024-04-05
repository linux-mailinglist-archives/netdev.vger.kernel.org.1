Return-Path: <netdev+bounces-85306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED3D89A1DB
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 17:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5E21C21352
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 15:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243F316FF5A;
	Fri,  5 Apr 2024 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="RKOaxOX9"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD8916EBFB;
	Fri,  5 Apr 2024 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332325; cv=none; b=jOudDzcKUomUP7kfTs2saJk1kI7n8DWn1DfyhfvjFw5vOuzMPsLU6MWMdq7dUgtGDChAKMZUoxTLvRo4gUXf3nfNLPOF74mvNkU3fwtwAOLsghrSI+cZpJo5zuzWoPOvu1Jm6Hdn9I73tsHxTqOXDL8qxW+dFr47yamuKlCvBdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332325; c=relaxed/simple;
	bh=fxv8PWbJbosspUvll7wJxzHOu0SzCsKZfnP95vWBhBc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hH0u+FfPc5YHH798+1vx+ENWSbToU5LuTpORzVUWYQJExbBTp7SsRHxGFTfpbTpxwDABvZDipKb3VWyt3e7sx70PPtE1a5Su+b5eRDEAUg8l+yTm1auJLFngKJauR1Yv/KDRvmlhEuyVQ7NugtWVa04sEzC/4RAr61bkNAzmmmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=RKOaxOX9; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=y8HiA5vRMbQK27T06qo0opVcq074kst6mzqx2ZlhPcE=; b=RKOaxOX9p9DcbDkS/bQPzUk89g
	/wE51Cq04Wk/tNX6RTFR3byLwXMGLxCmZPVHYY0dEojtTzXrx8zvsvImy67nxzfOwDsMDU0SD8HnZ
	TTTQmVxD2+kNQ2XaBp8A39yn3XJH6yfUaYYGeJAjPnxfkKa+dCGz23VpYoy60cth5QG0ZJZ0MHVet
	F7YVNSTki3xdcwlpnG682SCcuZVNH7Jx2p2dkRtx99eDzhp14QstvvljFNmDRwDZooz+4z4qWIYcO
	56BUbSPG9S1v5OGnMRky5EkrNpHo2Cqq17grAZqLB+tUUt4qs/npPxeomh+5suHc22fA1d2NOqaBf
	masJvRVw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rslr4-000J2P-VY; Fri, 05 Apr 2024 17:51:51 +0200
Received: from [178.197.249.22] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rslr3-00AxvR-1E;
	Fri, 05 Apr 2024 17:51:49 +0200
Subject: Re: [PATCH net-next v14 14/15] p4tc: add set of P4TC table kfuncs
To: Jamal Hadi Salim <jhs@mojatatu.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>, deb.chatterjee@intel.com,
 Anjali Singhai Jain <anjali.singhai@intel.com>, namrata.limaye@intel.com,
 tom@sipanda.io, Marcelo Ricardo Leitner <mleitner@redhat.com>,
 Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, tomasz.osinski@intel.com,
 Jiri Pirko <jiri@resnulli.us>, Cong Wang <xiyou.wangcong@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>,
 khalidm@nvidia.com, =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?=
 <toke@redhat.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 victor@mojatatu.com, Pedro Tammela <pctammela@mojatatu.com>,
 bpf <bpf@vger.kernel.org>
References: <20240404122338.372945-1-jhs@mojatatu.com>
 <20240404122338.372945-15-jhs@mojatatu.com>
 <CAADnVQLw1FRkvYJX0=6WMDoR7rQaWSVPnparErh4soDtKjc73w@mail.gmail.com>
 <CAM0EoM=SyHR-f7z8YVRknXrUsKALgx96eH-hBudo40NyeaxuoA@mail.gmail.com>
 <CAADnVQLJ3iO73c7g0PG1Em9iM4W-n=7aanu_pc9O0t4XrG5Gwg@mail.gmail.com>
 <CAM0EoMn6Nyu5AKgSERZEtSojvzKN6r7enc7t313G9xBvq-bcog@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <db5fa77e-c179-d90c-f4f5-1f39a5a0f56d@iogearbox.net>
Date: Fri, 5 Apr 2024 17:51:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoMn6Nyu5AKgSERZEtSojvzKN6r7enc7t313G9xBvq-bcog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27236/Fri Apr  5 10:26:04 2024)

On 4/5/24 1:16 AM, Jamal Hadi Salim wrote:
> On Thu, Apr 4, 2024 at 7:05 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> On Thu, Apr 4, 2024 at 3:59 PM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>>>
>>> We will use ebpf/xdp/kfuncs whenever they make sense to us.
>>
>> In such case my Nack stands even if you drop this patch.
> 
> We are not changing any ebpf code. I must have missed the memo that
> stated you can control how people write or use ebpf.
> The situation is this: Anybody can write kfuncs today. They can put
> them in kernel modules - i am sure you designed it with that intent.
> So what exactly are you objecting to that is ebpf related here?

To be honest, this entire patchset is questionable from a design pov for
the many reasons stated by various folks (including tc co-maintainers) in
all the earlier discussions, but related to the BPF bits if someone else
were trying to propose an interface on kfuncs which replicate to a larger
extend BPF map APIs, the feedback would be similarly in that this should
be attempted to generalize instead so that this is useful as a building
block, esp given the goal is on SW datapath and not offloads, and the
context specific pieces would reside in the p4tc code.

