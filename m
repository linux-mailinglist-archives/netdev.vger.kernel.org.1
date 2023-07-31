Return-Path: <netdev+bounces-22714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2116768ED1
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 09:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B339281601
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 07:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F02613F;
	Mon, 31 Jul 2023 07:31:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A5F6132
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 07:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F2DC433C8;
	Mon, 31 Jul 2023 07:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690788706;
	bh=+Jpx5rScHelX0J95gY4cfnAKZKq2SSQUTbtXCwv+weU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKclpWqyqDkYyBXO5/phgcu6rAuuznq0Lye6Er6WtahwdCaQ+JdVYbg4el6bN2XWE
	 ATkaYfXpNp0UXeFp0nltk9zTbVDpi1Rc/8xzu4gpDExzZXv/DO/KzSUcCkWy7FR8ud
	 LGPNton39vOM0UfLC3U2GJ8PEpR0srPE1+cgZuucQRaLl1R6qn7/TDEX+XyGc34p7y
	 Jd0pkKjtYokasg5jCNWTQP/w/1aAHw1fmlY6m/lYpB2xEnPqsoiH0jb7gT64C3epD7
	 IuCOs+diR0hgvYlk2leUjM3vLi79PtRURmQ+HjAJUMxPbEalB+nwKQdeVOna8zS47N
	 skeoFBR0rVr8g==
Date: Mon, 31 Jul 2023 09:31:42 +0200
From: Simon Horman <horms@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, jiri@resnulli.us
Subject: Re: [PATCH net-next v2 0/5] net/sched: improve class lifetime
 handling
Message-ID: <ZMdjXqxsgWwBOeKy@kernel.org>
References: <20230728153537.1865379-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728153537.1865379-1-pctammela@mojatatu.com>

On Fri, Jul 28, 2023 at 12:35:32PM -0300, Pedro Tammela wrote:
> Valis says[0]:
> ============
> Three classifiers (cls_fw, cls_u32 and cls_route) always copy
> tcf_result struct into the new instance of the filter on update.
> 
> This causes a problem when updating a filter bound to a class,
> as tcf_unbind_filter() is always called on the old instance in the
> success path, decreasing filter_cnt of the still referenced class
> and allowing it to be deleted, leading to a use-after-free.
> ============
> 
> Turns out these could have been spotted easily with proper warnings.
> Improve the current class lifetime with wrappers that check for
> overflow/underflow.
> 
> While at it add an extack for when a class in use is deleted.
> 
> [0] https://lore.kernel.org/all/20230721174856.3045-1-sec@valis.email/
> 
> v1 -> v2:
>    - Add ack tag from Jamal
>    - Move definitions to sch_generic.h as suggested by Cong

Reviewed-by: Simon Horman <horms@kernel.org>


