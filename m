Return-Path: <netdev+bounces-55490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AD280B0A5
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 00:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E211F21039
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 23:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5719C5ABAD;
	Fri,  8 Dec 2023 23:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLRAWITn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8A61F92D
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 23:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBABC433C8;
	Fri,  8 Dec 2023 23:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702078836;
	bh=ZeoFGCwXx82Uwmb273gxfAUuev7j6U8Z3TUJxNWpbcw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XLRAWITnfsUTEMaO9SoNF83BbXf3SbEAs3BCg1Bk2WSx6CW0UgCpQeQh6NQDWS/HV
	 yk5kO1TbpG0Eox3WAFIg5pTp9CD22FhpSLFRsm0dot4RJqc6SV0uEshd3AAlZDFKyV
	 YFZ+5BpbA0d7ZVx9+MtejA9GK9zawpBDTnJ2XLX6DEzm+vynLXHO6Fkd1JP0R8HUGa
	 xXpV5/xF51bxd8tlo/SaAV6v2H9TuzbdeGiyHH29t7DQY/mB95++r5rQSFHzoYH847
	 9il2eNp560B7ikyYiD8KrSKDSNh2Pa/PTgbjxVW0JKV76HREghHUroEWgfl9htw/tv
	 qsYf+ARPN6NBw==
Date: Fri, 8 Dec 2023 15:40:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: <jhs@mojatatu.com>, <pablo@netfilter.org>
Cc: Vlad Buslov <vladbu@nvidia.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
 <louis.peens@corigine.com>, <yinjun.zhang@corigine.com>,
 <simon.horman@corigine.com>, <jiri@resnulli.us>,
 <xiyou.wangcong@gmail.com>, Paul Blakey <paulb@nvidia.com>
Subject: Re: [PATCH net] net/sched: act_ct: Take per-cb reference to
 tcf_ct_flow_table
Message-ID: <20231208154035.7cbec2f7@kernel.org>
In-Reply-To: <20231205172554.3570602-1-vladbu@nvidia.com>
References: <20231205172554.3570602-1-vladbu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Dec 2023 18:25:54 +0100 Vlad Buslov wrote:
> The referenced change added custom cleanup code to act_ct to delete any
> callbacks registered on the parent block when deleting the
> tcf_ct_flow_table instance. However, the underlying issue is that the
> drivers don't obtain the reference to the tcf_ct_flow_table instance when
> registering callbacks which means that not only driver callbacks may still
> be on the table when deleting it but also that the driver can still have
> pointers to its internal nf_flowtable and can use it concurrently which
> results either warning in netfilter[0] or use-after-free.
> 
> Fix the issue by taking a reference to the underlying struct
> tcf_ct_flow_table instance when registering the callback and release the
> reference when unregistering. Expose new API required for such reference
> counting by adding two new callbacks to nf_flowtable_type and implementing
> them for act_ct flowtable_ct type. This fixes the issue by extending the
> lifetime of nf_flowtable until all users have unregistered.

Some acks would be good here - Pablo, Jamal?
-- 
pw-bot: needs-ack

