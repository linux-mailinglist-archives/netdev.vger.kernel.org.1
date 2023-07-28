Return-Path: <netdev+bounces-22440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED8E7677FB
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 23:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E211C20431
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 21:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13C71FB2D;
	Fri, 28 Jul 2023 21:59:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3E61FB28
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 21:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F98C4AF5C;
	Fri, 28 Jul 2023 21:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690581549;
	bh=aJJUgMnybmSKC64xwesijfZKQ6iEXCmPREvGxok9bBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JErkcm7qItIw3EnRz129saxYuocjua5kL/Od3fZ6hzsFJU7GhcFZ6+xXUDYWtE5x/
	 iG1Wajx8KHCzzpQObxdh7ALnhV/R1+1Z7K1cc3HcUaI8imW8L0DfIIFXTHcDJaLOVc
	 zCTrTCrR94UKS7YJgRb5c6GlCmgAyOAIWcVew65tZ/eS7Zons2WfD3k3FkFj7t7gyL
	 yqqjV9ya9FCXQ+0HBy5JtT6Q14rZrMuckzJDzjrTZrpaFUewlL5yCjcUCRj7uemxae
	 mPPqF4MFjytRVmo9rbORwwByb8g/DbGZg6PH0VUzwA9k/o6ZVre1PdUNJ4knbgTMth
	 BkxBuLVrKa2zg==
Date: Fri, 28 Jul 2023 14:59:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>,
 <sridhar.samudrala@intel.com>
Subject: Re: [net-next/RFC PATCH v1 1/4] net: Introduce new napi fields for
 rx/tx queues
Message-ID: <20230728145908.2d94c01f@kernel.org>
In-Reply-To: <20230712165326.71c3a8ad@kernel.org>
References: <168564116688.7284.6877238631049679250.stgit@anambiarhost.jf.intel.com>
	<168564134580.7284.16867711571036004706.stgit@anambiarhost.jf.intel.com>
	<20230602230635.773b8f87@kernel.org>
	<717fbdd6-9ef7-3ad6-0c29-d0f3798ced8e@intel.com>
	<20230712141442.44989fa7@kernel.org>
	<4c659729-32dc-491e-d712-2aa1bb99d26f@intel.com>
	<20230712165326.71c3a8ad@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jul 2023 16:53:26 -0700 Jakub Kicinski wrote:
> > The napi pointer in the queue structs would give the napi<->queue 
> > mapping, I still need to walk the queues of a NAPI (when there are 
> > multiple queues for the NAPI), example:
> > 'napi-id': 600, 'rx-queues': [7,6,5], 'tx-queues': [7,6,5]
> > 
> > in which case I would have a list of netdev queue structs within the 
> > napi_struct (instead of the list of queue indices that I currently have) 
> > to avoid memory allocation.
> > 
> > Does this sound right?  
> 
> yes, I think that's fine.
> 
> If we store the NAPI pointer in the queue struct, we can still generate
> the same dump with the time complexity of #napis * (#max_rx + #max_tx).
> Which I don't think is too bad. Up to you.

The more I think about it the more I feel like we should dump queues
and NAPIs separately. And the queue can list the NAPI id of the NAPI
instance which services it.

Are you actively working on this or should I take a stab?

