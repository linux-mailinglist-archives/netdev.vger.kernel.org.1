Return-Path: <netdev+bounces-110210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D809E92B511
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 12:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2BD1F23BFF
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B763415688C;
	Tue,  9 Jul 2024 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QMJn1abG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108F2154C04
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520472; cv=none; b=kmweCi9nVssOtH3h/z/nwI9wOGszcMRJTbB27TqCxOeB9XCMDt5BH5tEn8jeH+XFsnM/sFUaKAni6II087re0CnNZnRASUTAxPsPylLE1N2L5xnHoOfFxtB9lnqdTXIQPPT82/rJPRG5N5iqE3bCSTdEvS93XCl18Eavgrovbek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520472; c=relaxed/simple;
	bh=XVE9fKNRhblmaYmiXhRYmnSwHxk2SUEz/w5DF6HEdZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MOrOkBuigIvCF9c60Kq4opp4jCUWdS0sgLJiOegSUF1WLGqpnE5y4r0O+IWSONRs5zAx5Ld5EXCggER+MrfiP9sp7VyLXU1gwSUtqKU5Xx39JvXUlfRYRPd3sQtwmYRMxJYJM4tcyq9rrwA7pyk3AVDs2cSZnmMKlxSyKfLt0xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QMJn1abG; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77c4309fc8so530803766b.3
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 03:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1720520469; x=1721125269; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eiyzlXFiT490bXRPvnsAVjMAX0g//5oo2uMENF5EDDA=;
        b=QMJn1abGA3k2JyfT80saW+vTmYu0h2jdBsVvjowOUT7SUylRF/KJ3KwLqxHw+5LTRV
         XDTg5ZKOP0mgPo9H0Jiueiqg0uFu6rZBIXqraHs5jJioVF1HiJIWQDvlWd2a65nD1Opp
         5KHsz7JwvyraF44xRGI1LeUPfrhRi/hTBmxFHDBtQyVqKix3kTZn9PBbFJjL4KzCk2kE
         7tuqxooqBrJcGNG72JZ2H3Zg6vc+soO7X+WSpXHatbxIT3eIqB0oFAC7guGP5D7OM5Aq
         UaBnG/fV9F24gJV5WhivQwRhyicvW8az9Or80zumr8GOF3JT7gPO3W2xEJki0JT3wKhV
         N1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720520469; x=1721125269;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiyzlXFiT490bXRPvnsAVjMAX0g//5oo2uMENF5EDDA=;
        b=B4ckFR96DYkuQ42qPvbp0jPFYMoSsUMTffcJXV/M9X9fq+wx7sUH75SGGlCO8dwRrx
         dr+OyyWNulZoLXSXkxjYDh9b9aNFi0SqyeTBYNZeGRiRkFL9xjXx2+4XWt4Q714T75/V
         K129cMhij8PeHvPqX0xZlDiaEwMIe0usfvg+cNQlJ/BLXiWukHyq1JxWU81LfbNNtTV2
         T4duoF/d+MQMtmouPs4hePJxcbAbQIkqSGwOWSI3zApt0JTs+VicQoqpj7FpRxPHSYLC
         ODCzii78MRe0NYgfo37AyeZBxjqnbneDfCYXyTS9/NjWb72ErGiwtF3FC0dfXImSyInT
         92bA==
X-Gm-Message-State: AOJu0Yxz9X/vO7FdRKMbXNY2r1kQbJqnd/bO4N8yxBuas8aKMiT9SfzN
	PGHCH+bnc55XwmU85JrOCjDFuuNRU4KKipOyMEAvSj07VNNVYKuN0XEhZePiBgg=
X-Google-Smtp-Source: AGHT+IG7jluRH3J6uR23WaXTKF1HFAJyu1dzIDnCIZqAkrRf8myJmeu/Kcvby9DCFnorSOoe+d4h1w==
X-Received: by 2002:a17:906:128d:b0:a6f:5150:b805 with SMTP id a640c23a62f3a-a780b7009demr144688566b.33.1720520469471;
        Tue, 09 Jul 2024 03:21:09 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a8561cfsm64864866b.163.2024.07.09.03.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:21:08 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  john.fastabend@gmail.com,  kuniyu@amazon.com,  Rao.Shoaib@oracle.com,
  Cong Wang <cong.wang@bytedance.com>
Subject: Re: [PATCH bpf v2] af_unix: Disable MSG_OOB handling for sockets in
 sockmap/sockhash
In-Reply-To: <8820c332-53e9-4d8d-99a1-3e8b1aad188b@rbox.co> (Michal Luczaj's
	message of "Mon, 8 Jul 2024 01:10:41 +0200")
References: <20240622223324.3337956-1-mhal@rbox.co>
	<874j9ijuju.fsf@cloudflare.com>
	<2301f9fb-dab5-4db7-8e69-309e7c7186b7@rbox.co>
	<87tthej0jj.fsf@cloudflare.com>
	<8820c332-53e9-4d8d-99a1-3e8b1aad188b@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Tue, 09 Jul 2024 12:21:07 +0200
Message-ID: <87msmqn9ws.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 08, 2024 at 01:10 AM +02, Michal Luczaj wrote:
> On 6/27/24 09:40, Jakub Sitnicki wrote:
>> On Wed, Jun 26, 2024 at 12:19 PM +02, Michal Luczaj wrote:
>>> On 6/24/24 16:15, Jakub Sitnicki wrote:
>>>> On Sun, Jun 23, 2024 at 12:25 AM +02, Michal Luczaj wrote:
>>>>> AF_UNIX socket tracks the most recent OOB packet (in its receive queue)
>>>>> with an `oob_skb` pointer. BPF redirecting does not account for that: when
>>>>> an OOB packet is moved between sockets, `oob_skb` is left outdated. This
>>>>> results in a single skb that may be accessed from two different sockets.
>>>>>
>>>>> Take the easy way out: silently drop MSG_OOB data targeting any socket that
>>>>> is in a sockmap or a sockhash. Note that such silent drop is akin to the
>>>>> fate of redirected skb's scm_fp_list (SCM_RIGHTS, SCM_CREDENTIALS).
>>>>>
>>>>> For symmetry, forbid MSG_OOB in unix_bpf_recvmsg().
>>>>>
>>>>> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>>>>> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
>>>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>>>> ---

[...]

>>> And regarding Rao's comment, I took a look and I think sockmap'ed TCP OOB
>>> does indeed act the same way. I'll try to add that into selftest as well.n
>> 
>> Right, it does sound like we're not clearing the offset kept in
>> tcp_sock::urg_data when skb is redirected.
>
> Yeah, so I also wanted to extend the TCP's redir_to_connected(), but is
> that code correct? It seems to be testing REDIR_INGRESS, yet
> prog_stream_verdict() doesn't run bpf_sk_redirect_map() with the
> BPF_F_INGRESS flag.

Right, we don't have the ingress-to-local [1] setup covered there.

This test case has outgrown its initial coverage purpose - using sockmap
with listening / unconnected sockets - and needs to be split up, IMO.

There are definitely gaps in the coverage of redirect cases, and I'd
like to extend it to cover all combinations (supported and unsupported
ones) [2].

[1] It's a term I coined to make it easier to communiate
    https://github.com/jsitnicki/kubecon-2024-sockmap/blob/main/cheatsheet-sockmap-redirect.png
[2] https://gist.github.com/jsitnicki/578fdd614d181bed2b02922b17972b4e

