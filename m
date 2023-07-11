Return-Path: <netdev+bounces-16719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC8874E800
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16DCB1C20A63
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 07:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437AA174C8;
	Tue, 11 Jul 2023 07:32:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C48171DC
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 07:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F79C433C8;
	Tue, 11 Jul 2023 07:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689060726;
	bh=J+7qpMah7tjR/wIuDuI3+LbXguCQY9CEVJ+oqH4ORXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=et51hedx+QMT1zTAX2xWz7YG/MbECAcudnhr3gW4lOHaskIdJ6FWWSUQ3WkbTQN8t
	 x0yP7t3xzO1o4VyzQlaqZSZltwQytTwWpwGfSjfJz4Sniy+9m7D3CnOg3zJJA7c9zx
	 Wk7DaYzRrmmjessjs10OZ9STeJwFL9c3bNLqK0kBW1PEub53KLAcaAjuSwBcX8MJH8
	 KDgLULVHjf0/M8uHhSlea+MNTEHpNugHEHCvJOIGFPgWko1GgXhbnx5UjePa7SsByz
	 rUxsfOdbkgQSHyPFqXVvTNH5hNnk31gziuZF5ZblEat1VxK028qM4NwGuVC3+r+EKo
	 RMhn8LsL8PUWQ==
Date: Tue, 11 Jul 2023 10:32:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Florian Kauer <florian.kauer@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	netdev@vger.kernel.org, kurt@linutronix.de,
	vinicius.gomes@intel.com, muhammad.husaini.zulkifli@intel.com,
	tee.min.tan@linux.intel.com, aravindhan.gunasekaran@intel.com,
	sasha.neftin@intel.com, Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net 1/6] igc: Rename qbv_enable to taprio_offload_enable
Message-ID: <20230711073201.GJ41919@unreal>
References: <20230710163503.2821068-1-anthony.l.nguyen@intel.com>
 <20230710163503.2821068-2-anthony.l.nguyen@intel.com>
 <20230711070130.GC41919@unreal>
 <51f59838-8972-73c8-e6d2-83ad56bfeab4@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51f59838-8972-73c8-e6d2-83ad56bfeab4@linutronix.de>

On Tue, Jul 11, 2023 at 09:18:31AM +0200, Florian Kauer wrote:
> Hi Leon,
> 
> On 11.07.23 09:01, Leon Romanovsky wrote:
> > On Mon, Jul 10, 2023 at 09:34:58AM -0700, Tony Nguyen wrote:
> >> From: Florian Kauer <florian.kauer@linutronix.de>
> >>
> >> In the current implementation the flags adapter->qbv_enable
> >> and IGC_FLAG_TSN_QBV_ENABLED have a similar name, but do not
> >> have the same meaning. The first one is used only to indicate
> >> taprio offload (i.e. when igc_save_qbv_schedule was called),
> >> while the second one corresponds to the Qbv mode of the hardware.
> >> However, the second one is also used to support the TX launchtime
> >> feature, i.e. ETF qdisc offload. This leads to situations where
> >> adapter->qbv_enable is false, but the flag IGC_FLAG_TSN_QBV_ENABLED
> >> is set. This is prone to confusion.
> >>
> >> The rename should reduce this confusion. Since it is a pure
> >> rename, it has no impact on functionality.
> > 
> > And shouldn't be sent to net, but to net-next.> 
> > Thanks
> 
> In principle I fully agree that sole renames are not intended for net.
> But in this case the rename is tightly coupled with the other patches
> of the series, not only due to overlapping code changes, but in particular
> because the naming might very likely be one root cause of the regressions.

I understand the intention, but your second patch showed that rename was
premature.

Thanks

