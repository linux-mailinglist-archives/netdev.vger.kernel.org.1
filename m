Return-Path: <netdev+bounces-28926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3E37812F2
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD401C21674
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71303198BF;
	Fri, 18 Aug 2023 18:37:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E022CA7
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 18:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A371C433C7;
	Fri, 18 Aug 2023 18:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692383862;
	bh=LPZ3kbVFH1VZ1oefBF6eOczHPOVwUAr8ziZ+u5QQLA4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C1yynuixq5mfeCFJN17DZCkjLYwYl1LiUH9n4Z+HqRHUpjxg/wOOYg7vev5qIBD8M
	 h8pTP5FLwKK6XydUll15H1fK8mYCd8uX/wH1ihE+7eAgyKmsE5UrIZb40rpLT/0pPw
	 Y1SmhR56CA1GTN2UeLnsOpV79Dupnm/CWDwKrNoMIQRpvixT1bt0UNpQKTClDHjx3D
	 Lp2pikHYuPWiT4XilAGpb/i/dJqKn+euxrvq366+vBclvUpY8m1fFFlygYjtH1bIqo
	 kVrhRP89hZp1Z4o9WFQEk9uYxU/lheGcsWpbX9Q45wDeQf+wYHK5N0OIIn7sMxztVF
	 ja9ke8TO+5nnA==
Date: Fri, 18 Aug 2023 11:37:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Joshua Hay <joshua.a.hay@intel.com>,
 pavan.kumar.linga@intel.com, emil.s.tantilov@intel.com,
 jesse.brandeburg@intel.com, sridhar.samudrala@intel.com,
 shiraz.saleem@intel.com, sindhu.devale@intel.com, willemb@google.com,
 decot@google.com, andrew@lunn.ch, leon@kernel.org, mst@redhat.com,
 simon.horman@corigine.com, shannon.nelson@amd.com,
 stephen@networkplumber.org, Alan Brady <alan.brady@intel.com>, Madhu
 Chittim <madhu.chittim@intel.com>, Phani Burra <phani.r.burra@intel.com>
Subject: Re: [PATCH net-next v5 10/15] idpf: add splitq start_xmit
Message-ID: <20230818113740.1ed88d8a@kernel.org>
In-Reply-To: <20230816004305.216136-11-anthony.l.nguyen@intel.com>
References: <20230816004305.216136-1-anthony.l.nguyen@intel.com>
	<20230816004305.216136-11-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 17:43:00 -0700 Tony Nguyen wrote:
> +	netif_stop_subqueue(tx_q->vport->netdev, tx_q->idx);
> +
> +	/* Memory barrier before checking head and tail */
> +	smp_mb();
> +
> +	/* Check again in a case another CPU has just made room available. */
> +	if (likely(IDPF_DESC_UNUSED(tx_q) < size))
> +		return -EBUSY;
> +
> +	/* A reprieve! - use start_subqueue because it doesn't call schedule */
> +	netif_start_subqueue(tx_q->vport->netdev, tx_q->idx);

Please use the helpers from include/net/netdev_queues.h.

